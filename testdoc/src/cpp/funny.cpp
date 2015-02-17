/*  
 *  All this was done on August 17, 2007 by Pietro Gagliardi
 *
 *  You are free to use this code in a citation or (if you have the guts)
 *  in your own program; just please mention me. 
 **/
typedef int     number;

/*  
 *  Class:      Microsoft  
 *      Big brother
 */
class Microsoft : public Corporation, public Enemy<(number) 1> {
    public:
        Microsoft()
            {
                sanity = 200;
                bill_gates = drop_out();
                ceo = bill_gates;
                while (sanity > 2) {
                    sleep(2);
                    sanity--;
                }
                steve_ballmer = new class doofus;
            }

#define our     int
#define SUCCESS 1

        our     year_2006_goals()
            {
                delete bill_gates;
                ceo = steve_ballmer;
                sanity -= 200;
                return SUCCESS;
            }

    protected:
        int             sanity;

        class doofus ceo, bill_gates, steve_ballmer;
};
