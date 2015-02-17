/*
 *  Package:        CTest1::Package1
 *      CTest1::Package1
 */

/*  Topic:          Overview
 *      blah blah
 *
 *  Topic:          More Stuff
 *      blah blah
 */


/*  Type:           TypeA
 *      CTest1::Package1::TypeA
 *
 *  Synopsis:
 *      typedef struct {
 *           int    afield1;
 *           int    afield2;
 *           int    afield3;
 *           int    afield4;
 *           int    afield5;
 *      } TypeA;
 */
typedef struct TypeA {
        int         afield1;
        int         afield2;
        int         afield3;
        int         afield4;
        int         afield5;
} TypeA;


/*  Type:           TypeB
 *      CTest1::Package1::TypeB
 */
struct TypeB {
        int         bfield1;    /*!< field 1 */
        int         bfield2;    /*!< field 2 */
        int         bfield3;    /*!< field 3 */
        int         bfield4;    /*!< field 4 */
        int         bfield5;    /*!< field 5 */
};


/* --------------------------------------------------------------------------
 *  Enum:           EnumA
 *      CTest1::Package1::TypeA
 *
 *  AVALUEA -       1
 *  AVALUEB -       2
 *  AVALUEC -       3
 *  AVALUED -       4
 *  AVALUEE -       5
 *
 * ----------------------------------------------------------------------- 
 */
enum EnumA {
    AVALUEA,
    AVALUEB,
    AVALUEC,
    AVALUED,
    AVALUEE
} enumA_var;


/* --------------------------------------------------------------------------
 *  Enum:           EnumB
 *      CTest1::Package1::TypeA
 *
 *  BVALUEA -       1
 *  BVALUEB -       2
 *  BVALUEC -       3
 *  BVALUED -       4
 *  BVALUEE -       5
 *
 * ----------------------------------------------------------------------- 
 */
enum {
    BVALUEA,
    BVALUEB,
    BVALUEC,
    BVALUED,
    BVALUEE
} enum_var;


/*  Function:       FunctionA
 *      CTest1::Package1::FunctionA
 *  ----------------------------------------------------------------------- 
 */
void FunctionA()
{
}


/*  Type:           TypeC_t
 *      CTest1::Package1::TypeC
 *
 */
typedef struct TypeC {
        int         cfield1;
        int         cfield2;
        int         cfield3;
        int         cfield4;
        int         cfield5;
} TypeC;


/*  Function:       FunctionB
 *      CTest1::Package1::FunctionB
 *
 *  Parameters:
 *      arg1 -      <TypeB *> pointer.
 *
 *      arg2 -      int.
 */
void
FunctionB ()
{
}

