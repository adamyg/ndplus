/*  Package:        Repeated

        Repeated inheritance example.

    Topic:          Overview

        The simplest and most obvious use of multiple inheritance is to
        "glue" not related classes together, as part of the implementation
        of a third class.

(start ditaa -S)
                    +----------+
          +-------->|   Base   |<--------+
          |         +----------+         |
          |                              |
    +------------+                 +------------+
    |  DerivedA  |                 |  DerivedB  |
    +------------+                 +------------+
          ^                              ^
          |         +----------+         |
          +---------|   Top    |---------+
                    +----------+
(end ditaa)

    Example:
>
>       void
>       main( void )
>       {
>           DerivedA devivedA;
>           Top top;
>       }

    Output:
>       Hello from Base 1
>       Hello from Derived A
>       Hello from Base 2
>       Hello from Derived A
>       Hello from Derived B
>       Hello from TOP 2
>       ByeBye from TOP
>       ByeBye from Derived B
>       ByeBye from Derived A
>       ByeBye from Base 2
>       ByeBye from Derived A
>       ByeBye from Base 1
*/

#include <vector>
#include <iostream>

namespace mynamespace {
    /*  Class:              Base
     *      Base class
     */
    class Base {
    protected:
        int                 data1;
        std::vector<int>    data2;

    public:
        /*  Enum:           ReturnValue
         *      Return value enumeration
         */
        enum ReturnValue {
            ONE     = 1,                //!< enum one .
            TWO,                        /*!< enum two */   /*..*/
            THREE   = 3,                /*!< enum three
                                            enum three cont */
            FOUR    = 4                 //!< enum four
                                        //!< enum four count
        };

        /*  Constructor:    Base
         *      Public constructor
         *
         *  Parameters:
         *      data -      an integer
         */
        Base (int data)
                : data1(data)
            {  cout << "Hello from Base " << data1 << "\n";  }

        /*  Destructor:     ~Base
         *      Public destructor
         */
        ~Base()
            {  cout << "ByeBye from Base " << data1 << "\n";  }

        Base& operator=(const Base &);

        //  Method:         VirtualConst
        //      A const pure virtual function
        //
        void                VirtualConst() const = 0;

        char const * const  ConstReturn();

        unsigned            ConstFunction() const;

        static const unsigned StaticFunction();

        int                 ThrowFunction() throw(A, B);

        int                 NothrowFunction() throw();

        ReturnValue         ReturnValueFunction();

        //  Method:         VectorFunction
        //      A function returning a vector of ints
        //
        const std::vector<int>& VectorFunction();

    private:
        unsigned            data2 [10];

        unsigned          (*data3)[];
    };


    /*  Class:              DerivedA
     *      DerivedA class
     */
    class DerivedA : virtual public Base {
    public:
        /*  Constructor:    DerivedA
         *      Public constructor
         */
        DerivedA() : Base(1)
            { cout << "Hello from Derived A\n"; }

        /*  Destructor:     ~DerivedA
         *      Public destructor
         */
        ~DerivedA()
            { cout << "ByeBye from Derived A\n"; }

        /*  Operator:           =
         *      Assigment operator
         */
        DerivedA&
        operator=(const DerivedA &)
            { }
    };


    /*  Class:              DerivedB
     *      DerivedB class
     */
    class DerivedB : virtual public Base {
    public:
        /*  Constructor:    DerivedB
         *      Public constructor
         */
         DerivedB()
                : Base(1)
            { cout << "Hello from Derived B\n"; }

        /*  Destructor:     ~DerivedB
         *      Public destructor
         */
        ~DerivedB()
            { cout << "ByeBye from Derived B\n"; }

        /*  Operator:       =
         *      Assigment operator
         */
        DerivedB&
        operator=(const DerivedB &)
            { }
    };


    /*  Class:              Top
     *      Top class
     */
    class Top : public DerivedA, public DerivedB {
    public:
        Top();
        ~Top();
    };


    /*  Constructor:        Top
     *      Public constructor
     */
    Top::Top()
            : Base(2)                           // must initialise base class
        {
        cout << "Hello from TOP " << data1 << "\n";
        }


    /*  Destructor:         ~Top
     *      Public destructor
     */
    Top::~Top()
        {
        cout << "ByeBye from TOP\n";
        }

    /*  Operator:            =
     *      Assigment operator
     */
    Base&
    Base::operator=(const Base &)
        {
        }

    /*  Method:             ConstReturn
     *      Function returning a const * const value
     */
    char const * const
    Base::ConstReturn()
        {
        }

    /*  Method:             ConstFunction
     *      Const function returning a const value
     */
    unsigned
    Base::ConstFunction() const
        {
        }

    /*  Method:             StaticFunction
     *      Static function returning a const value
     */
    const unsigned          /*static*/
    Base::StaticFunction()
        {
        }

    /*  Method:             ThrowFunction
     *      A throw function
     */
    int
    Base::ThrowFunction() throw(A, B)
        {
        }

    /*  Method:             NothrowFunction
     *      A nothrow function
     */
    int
    Base::NothrowFunction() throw()
        {
        }

    /*  Method:             ReturnValueFunction
     *      A function with a typed return value
     */
    Base::ReturnValue         
    Base::ReturnValueFunction()
        {
        }

};  //namespace

