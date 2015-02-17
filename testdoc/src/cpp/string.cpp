/*  
 *  Package:        String
 *      string package.
 */

#include <string>

using namespace std;

/*
 *  Type:           MyStruct
 *      Structure My
 */
struct MyStruct {   
    std::string     name;                       //!< user name
    std :: string   address;                    //!< user address
};

typedef basic_string<unsigned short> mystring;

static Mystruct     details;

void
test1(void)
{
    string s0;

    string s1 = "my string";

    string s2(s1, 100, 2);                      // error: out_of_range

    string s3(s1, 2, 100);                      // char count to large = (s,2,s.size()-2)

    string s4(s1, 2, string::npos);             // the char's starting from s[2]

    string s5(s1);

//  string s6 = ' ';                            // error: no conversion from character

//  string s7 = 1;                              // error: no conversion from int

    string s8(7, 'a');                          // 7 copies of 'a' = 'aaaaaaa'

    string s9 = s1;

    string sA( s1.begin(), s1.end() );          // copy all characters
}


void
main(void)
{
    details.name = "myname";
}


//  Function:		c_string
//      c_string function
//
//  Exceptions;
//      out_of_range    attempt to access beyond the end of the string.
//      length_error    if a string length has exceeded the system limit.
//

//  Members:
//      size()          length of the string in characters.
//      length()        synonym for size()
//
//

//  Conversion to C-Style strings:
//
//      data()          retrieves the address of array containing the character data.
//      c_str()         returns a NUL terminated string of data()
//
//          Note:       both should be treated as having limited scope, with the 
//                      buffer valid past the next string call.
//

char *
c_string(const string &s)
{
    char * p = new char[s.length()+1];          // +1 for NULL
    s.copy(p, string::npos);                    // npos -> "all characters" marker.
    p[s.length()] = '\0';
    return p;
}


int
cmp_nocase(const string &a, const string &b)
{
    string::const_iterator ia = a.begin();      // char_traits iterators
    string::const_iterator ib = b.begin();

    while (ia != a.end() && ib != b.end()) {
        if (toupper(*ia) != toupper(*ib))
            return (toupper(*ia) < toupper(*ib) ? -1 : 1);
        ia++, ib++;
    }
    if (a.size() == b.size())
        return 0;
    return (a.size() < b.size() ? -1 : 1);
}
