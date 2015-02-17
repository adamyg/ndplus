
/*  Title:          ClassA & ClassB

        Tests for multiple class definitions within the same image.

        Processing under this condition is controlled thru the 'multiple'
        specification against the topic, where;

        Default -       Nothing is performed.

        Summaries -     A compound summary is generated within the determined
                        primary image, based upon the one containing body (ie
                        description).

        Merge -         All class components are merged into the primary image.

        Split -         Firstly a merge is performed and then all components
                        with a 'splittable: yes' attributes are placed within
                        their own image.

---------------------------------------------------------------------------*/


/*  Package:        ClassA

        Primary

    Function:       FunctionA

        Class A::FunctionA

---------------------------------------------------------------------------*/

void 
FunctionA()
{
}


/*  Package:        ClassB

    Function:       FunctionA

        Class B::FunctionA

---------------------------------------------------------------------------*/

void 
FunctionA()
{
}


/*  Package:        ClassA

    Function:       FunctionB

        Class A::FunctionB

---------------------------------------------------------------------------*/

void 
FunctionB()
{
}


/*  Package:        ClassB

    Function:       FunctionC

        Class B::FunctionC

---------------------------------------------------------------------------*/

void
FunctionC()
{
}


/*  Package:        ClassA

    Function:       FunctionC

        Class A::FunctionC

---------------------------------------------------------------------------*/

void 
FunctionC()
{
}


/*  Package:        ClassB
            
        Primary

    Function:       FunctionB

        Class B::FunctionB

---------------------------------------------------------------------------*/

void 
FunctionB()
{
}

