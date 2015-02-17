##################################################################################
#   Class:          PerlClassA::Child1
#
#       PerlClassA::Root
#
#   Description:
#       This module was documented using JavaDoc style
#

package PerlClassA::Child1;

use base 'PerlClassA::Parent';

#   
#   Topic:          Overview
#   
#       blah blah
#   
#   Topic:          More Stuff
#   
#       blah blah


##
#   Returns the character at the specified index. An index 
#   ranges from <code>0</code> to <code>length() - 1</code>.
# 
#   @param          index  the index of the desired character.
#   @return         the desired character.
#   @exception      StringIndexOutOfRangeException 
#                       if the index is not in the range <code>0</code> 
#                       to <code>length()-1</code>.
#   @see            java.lang.Character#charValue()
#
##
sub FunctionA
{
}


##
#   Returns the character at the specified index. An index 
#   ranges from <code>0</code> to <code>length() - 1</code>.
# 
#   @param          index  the index of the desired character.
#   @return         the desired character.
#   @exception      StringIndexOutOfRangeException 
#                       if the index is not in the range <code>0</code> 
#                       to <code>length()-1</code>.
#   @see            java.lang.Character#charValue()
#
##
sub FunctionB
{
}


#
#   Function:       FunctionB
#
#       PerlClassA::Child1::FunctionB
#
sub FunctionB #(arg1, arg2)
{
}
