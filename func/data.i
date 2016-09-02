FUNCTION fnMes RETURNS CHARACTER (iTemp AS INTEGER):

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO INITIAL "".

    CASE iTemp:
        WHEN 1 THEN ASSIGN cReturn  = "Janeiro".
        WHEN 2 THEN ASSIGN cReturn  = "Fevereiro".
        WHEN 3 THEN ASSIGN cReturn  = "Mar‡o".
        WHEN 4 THEN ASSIGN cReturn  = "Abril".
        WHEN 5 THEN ASSIGN cReturn  = "Maio".
        WHEN 6 THEN ASSIGN cReturn  = "Junho".
        WHEN 7 THEN ASSIGN cReturn  = "Julho".
        WHEN 8 THEN ASSIGN cReturn  = "Agosto".
        WHEN 9 THEN ASSIGN cReturn  = "Setembro".
        WHEN 10 THEN ASSIGN cReturn = "Outubro".
        WHEN 11 THEN ASSIGN cReturn = "Novembro".
        WHEN 12 THEN ASSIGN cReturn = "Dezembro".
    END CASE.

    RETURN cReturn.

END FUNCTION. 

FUNCTION fnUltimoDia RETURNS DATE (iMes AS INTEGER, iAno AS INTEGER):

    RETURN (DATE(
                 (IF iMes = 12 THEN 1 ELSE (iMes + 1)),
                 1,
                 (IF iMes = 12 THEN (iAno + 1) ELSE iAno)
                ) - 1).

END FUNCTION.

FUNCTION fnSemana RETURNS INTEGER (dtProc AS DATE):

    DEFINE VARIABLE dtCont AS DATE       NO-UNDO.
    DEFINE VARIABLE iSem AS INTEGER    NO-UNDO INITIAL 1.
    DEFINE VARIABLE iCont AS INTEGER     NO-UNDO INITIAL 0.

    REPEAT dtCont = DATE(MONTH(dtProc),1,YEAR(dtProc)) TO dtProc:

        ASSIGN iCont = iCont + 1.

        IF iCont > 7 THEN
            ASSIGN iSem = iSem + 1
                   iCont = 1.

    END.

    RETURN iSem.

END FUNCTION.

FUNCTION fnProxDiaUtil RETURNS DATE (dtTemp AS DATE):

    DEFINE VARIABLE dtReturn AS DATE    NO-UNDO.

    ASSIGN dtReturn = dtTemp.

    IF WEEKDAY(dtReturn) = 7 THEN DO: /* S bado */
        ASSIGN dtReturn = dtReturn + 2.
    END.
    ELSE DO:
        IF WEEKDAY(dtReturn) = 1 THEN DO: /* Domingo */
            ASSIGN dtReturn = dtReturn + 1.
        END.
    END.
    REPEAT:
        IF CAN-FIND(FIRST feriado NO-LOCK
                    WHERE feriado.dt-feriado = dtReturn) THEN DO:
            ASSIGN dtReturn = dtReturn + 1.
            IF WEEKDAY(dtReturn) = 7 THEN /* S bado */
                ASSIGN dtReturn = dtReturn + 2.
        END.
        ELSE DO:
            LEAVE.
        END.
    END.

    RETURN dtReturn.

END FUNCTION. 

