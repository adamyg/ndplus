/*  Class:              Stack

        Basic stack templete class

    Example:
(start code)

    void 
    main()
    {
        Stack<int, 100> s1;

        cout << "\nPush: ";
        for (int i = 1; !s1.full(); i++) {
            cout << i << ", ";
            s1.push( i );
        }   
        cout << "\nPop: ";
        for (i = 1; i <= 101; i++)
            cout << s1.pop() << ", ";
    }
(end code)

 */
template <class T, int size = 10> 
class Stack {
private:
    T *         data;
    int         top;

public:
    /*  Group:          Constructors */

    /*  Constructor:    Stack
     *      Public constructor
     */
    Stack()
                        { data = new T[size]; top = -1; }

    /*  Destructor:     ~Stack
     *      Public destructor
     */
    ~Stack()
                        { delete data; }

    T               pop();
    void            push( T item );

    /*  Group:          Functions */

    /*  Method:         empty
     *      Determine whether the stack is empty.
     */
    int             empty() const
                        { return top < 0 ? 1 : 0; }

    /*  Method:         full
     *      Determine whether the stack is full.
     */
    int             full() const
                        { return top >= size-1 ? 1 : 0; }

    virtual void    overflow();

    virtual void    underflow();
};


/*  Method:         pop
 *      Pop a stack element
 */
template <class T, int size> 
T Stack< T, size > :: pop()
{
    if ( top >= 0 )
        return data[ top-- ];
    underflow();
    return 0;
}


/*  Method:         push
 *      Push a stack element
 */
template <class T, int size> 
void Stack< T, size > :: push( T item )
{
    if ( top < size-1 )
        data[ ++top ] = item;
    else 
        overflow();
}



/*  Group:          Signal handlers */

/*  Method:         overflow
 *      Stack overflow signal
 */
template <class T, int size> void 
Stack< T, size >::overflow()
{
    cout << "\nStack overflow !\n";
}


/*  Method:         underflow
 *      Stack underflow signal
 */
template <class T, int size> void 
Stack< T, size >::underflow()
{
    cout << "\nStack underflow !\n";
}
