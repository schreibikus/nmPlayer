/*
********************************************************************************
*
*      GSM AMR-NB speech codec   R98   Version 7.6.0   December 12, 2001
*                                R99   Version 3.3.0                
*                                REL-4 Version 4.1.0                
*
********************************************************************************
*
*      File             : sqrt_l.h
*      Purpose          : Computes sqrt(L_x),  where  L_x is positive.
*                       : If L_x is negative or zero, the result is
*                       : 0 (3fff ffff).
*
********************************************************************************
*/
#ifndef sqrt_l_h
#define sqrt_l_h
/*
********************************************************************************
*                         INCLUDE FILES
********************************************************************************
*/
#include "typedef.h"
#include "basic_op.h"
#include "sqrt_l.tab" /* Table for sqrt_l_exp() */

/*
********************************************************************************
*                         PUBLIC PROGRAM CODE
********************************************************************************
*/
__inline Word32 sqrt_l_exp (/* o : output value,                          Q31 */
    Word32 L_x,    /* i : input value,                           Q31 */
    Word16 *exp    /* o : right shift to be applied to result,   Q1  */
)
{
    Word16 e, i, a, tmp;
    Word32 L_y;
    if (L_x <= (Word32) 0)
    {
        *exp = 0;               
        return (Word32) 0;
    }
    e = norm_l (L_x) & 0xFFFE;						/* get next lower EVEN norm. exp  */
    L_x = (L_x << e);								/* L_x is normalized to [0.25..1) */
    *exp = e;										/* return 2*exponent (or Q1)      */

    L_x = (L_x >> 9);
    i = extract_h (L_x);							/* Extract b25-b31, 16 <= i <= 63 because of normalization */
    L_x = (L_x >> 1);   
    a = extract_l(L_x);								/* Extract b10-b24 */
    a = a & (Word16) 0x7fff;
    i = sub3 (i, 16);								/* 0 <= i <= 47 */

    L_y = L_deposit_h (sqrt_table[i]);					/* table[i] << 16*/
    tmp = sub3 (sqrt_table[i], sqrt_table[i + 1]);      /* table[i] - table[i+1])         */
    L_y = L_msu3 (L_y, tmp, a);							/* L_y -= tmp*a*2                 */       
    /* L_y = L_shr (L_y, *exp); */          /* denormalization done by caller */
    return (L_y);
}
#endif