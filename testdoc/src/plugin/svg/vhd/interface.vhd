library ieee;
use ieee.std_logic_1164.all;
--
-- Entity: interface
--
--   Inputs:
--        clk             - clock input
--        resetn_clk      - synchronous reset, active low
--        data_in         - 32 bit data word to transmit
--        data_ready      - assert high when data is ready
--        finish_off      - assert high when requesting that the current transfer be finished off (see below)
--
--   Outputs:
--        frame_busy      - asserted high when sending data or finishing off
--        data_ack        - asserted for one cycle when data_in has been latched
--        valid_data      - asserted high when sending data (not when finishing off)
--        out_clk         - clock to interface of micro
--        out_capture_en  - capture enable signal to interface of micro
--        out_data        - byte wide data to interface of micro
--
-- Description:
-- When *data_ready* goes high, new data is available.  *data_ack* is asserted for one cycle to show that *data_in* is latched.
-- The 32 bits of input data are then clocked out 8 bits at a time, most significant byte first.
-- Data is presented on the rising clock edge to be sampled on the falling clock edge by the micro
-- When data ready has gone low, no more data is available this frame.
--
-- In order to meet the requirements of the micro, we must toggle OUT clk three more times at the end,
-- dropping *out_capture_en* for the last one.
-- This is done by asserting *finish_off* while *out_capture_en* is high.
--
-- The *frame_busy* output will go high when the first data word is latched, and will drop once the
-- final three OUT clk pulses have been sent
--
-- *out_capture_en* goes high during the entire transfer.
-- There is also a *valid_data* output to signify which OUT clks are associated with valid data and which are with
-- the "end of transfer bodging"
--
-- Timing diagram example for sending 2x32bit words of data:
-- (begin drawing debug=0 scale=0.7)
--                  _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
--            clk: | |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |
--                      ___________________________________________
--     data_ready: ____|                                           |__________________________________________________________....
--                          ___                                 ___                                 ___
--       data_ack: ________|   |_______________________________|   |_______________________________|   |______________________....
--                          _______________________________________________________________________________________________
--     frame_busy: ________|                                                                                               |__....
--                 ____ _______________ _______________________________
--        data_in: ____X_12345679______X___ABCDEF12____________________
--                                                                  ______________________________________
--     finish_off: ________________________________________________|                                      |____________________....
--                          ___________________________________________________________________________________________
-- out_capture_en: ________|                                                                                           |_______....
--                              _______________________________________________________________________
--     valid_data: ____________|                                                                       |_______________________....
--                              ___     ___     ___     ___         ___     ___     ___     ___         ___     ___     ___
--        out_clk: ____________|   |___|   |___|   |___|   |_______|   |___|   |___|   |___|   |_______|   |___|   |___|   |___....
--                 ____________ _______ _______ _______ ___________ _______ _______ _______ ___________ _______________________
--       out_data: ____XX______X_12____X__34___X__56___X__78_______X___AB__X__CD___X___EF__X___12______X___--__--______________
--                                                                                                          ^---^--dummy data
-- (end drawing)
entity interface is
    port (
        clk            : in  std_logic;
        resetn_clk     : in  std_logic;
        data_in        : in  std_logic_vector(31 downto 0);
        data_ready     : in  std_logic;
        finish_off     : in  std_logic;
        frame_busy     : out std_logic;
        data_ack       : out std_logic;
        valid_data     : out std_logic;
        out_clk        : out std_logic;
        out_capture_en : out std_logic;
        out_data       : out std_logic_vector(7 downto 0)    );

end entity interface;
