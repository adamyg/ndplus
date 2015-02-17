/* -ND- naturaldocs = yes, numericlists = yes -ND- */
/* -ND- bulletlists = yes, bulletchar = [o+*] -ND- */
/* -ND- deflists = yes -ND- */

/*
 *  test the unnamed namespace
 */
namespace {
    /*  
     *  Class:              UnnamedClass
     *      A namespace defines a new scope. Members of a namespace are said to have
     *      namespace scope. They provide a way to avoid name collisions (of variables,
     *      types, classes or functions) without some of the restrictions imposed by
     *      the use of classes, and without the inconvenience of handling nested classes.
     */
    class UnnamedClass {
        /*
         *  dont allow copy or assignment
         */
        UnnamedClass(const UnnamedClass&);
        UnnamedClass& operator=(const UnnamedClass&);

    public:
        /*  
         *  Constructor:    UnnamedClass
         *      Constructor
         */
        UnnamedClass()
            { }

        /*  
         * Destructor:      ~UnnamedClass
         *      Destructor
         */
        ~UnnamedClass()
            { }

    private:
        unsigned            m_variable;
    };

};  //unnamed namespace

// -ND- indent=4 -ND-
// -ND- language=C++ -ND-
// -ND- auto=yes -ND-

