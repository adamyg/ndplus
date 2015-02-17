/*
 *  Package:    Linkage
 *      Module to test support for C and C++ explicit linkage declarations
 */

namespace mynamespace {
    /*  
     *  Function:       cbinding
     */
    extern "C" static void  cbinding();
};


/*
 *  This declaration tells the compiler that references to the functions f1, f2, and f3
 *  should not be mangled.
 *
 *  The extern "C" linkage specifier can also be used to prevent mangling of functions
 *  that are defined in C++ so that they can be called from C. For example,
 */
extern "C" {
    /*  
     *  Function:       f1
     */
    int         f1(int);

    /*  
     *  Function:       f2
     */
    int         f2(int);

    /*  
     *  Function:       f3
     */
    int         f3(int);
};

extern "C++" {
    /*  
     *  Function:       f4
     */
    void        f4();
};


/*  In multiple levels of nested extern declarations, the innermost extern
 *  specification prevails.
 */
extern "C" {
    /* 
     *  Function:       c1_func
     */
    void        c1_func();

    extern "C++" {
        /*  
         *  Function:   cpp_func
         */
        void    cpp_func();
    };

    /*  
     *  Function:       c2_func
     */
    void        c2_func();
};

