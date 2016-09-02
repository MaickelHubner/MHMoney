FUNCTION fnTipo
RETURNS CHARACTER
  ( iTipo AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    CASE iTipo:
        WHEN 4 THEN RETURN "Cheque".
        WHEN 1 THEN RETURN "Dep¢sito".
        WHEN 5 THEN RETURN "Pagamento".
        WHEN 6 THEN RETURN "Saque em Dinheiro".
        WHEN 3 THEN RETURN "Transferˆncia".
        WHEN 0 THEN RETURN "Agrupamento".
        WHEN 7 THEN DO:
            IF conta.dinheiro THEN
                RETURN "Gasto".
            ELSE
                RETURN "D‚bito".
        END.
        WHEN 2 THEN DO:
            IF conta.dinheiro THEN
                RETURN "Recebimento".
            ELSE
                RETURN "Cr‚dito".
        END.
    END CASE.

  RETURN "".   /* Function return value. */

END FUNCTION.

FUNCTION fnSit
RETURNS CHARACTER
  ( iSit AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    IF iSit = 2 THEN
        RETURN "C".
    IF iSit = 3 THEN
        RETURN "R".

    RETURN "".

END FUNCTION.

DEFINE VARIABLE cSit AS CHAR COLUMN-LABEL "C" FORMAT "X(1)" NO-UNDO.
DEFINE VARIABLE cTipo AS CHAR COLUMN-LABEL "Tipo" FORMAT "X(25)" NO-UNDO.
