DEFINE VARIABLE cGotoFields AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iContGT AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTempGT AS CHARACTER  NO-UNDO.
DEFINE VARIABLE rGoto AS ROWID      NO-UNDO.

RUN som.p(INPUT "music\click.wav").

FOR EACH tt-goto:
    DELETE tt-goto.
END.

ASSIGN cTempGT = TRIM("{&KeyFields}").

REPEAT iContGT = 1 TO LENGTH(cTempGT):

    IF ASC(SUBSTRING(cTempGT,iContGT,1)) <> 32 THEN
        ASSIGN cGotoFields = cGotoFields + SUBSTRING(cTempGT,iContGT,1).
    ELSE
        IF ASC(SUBSTRING(cTempGT,(iContGT + 1),1)) <> 32 THEN
            ASSIGN cGotoFields = cGotoFields + ",".

END.

REPEAT iContGT = 1 TO NUM-ENTRIES(cGotoFields):
    CREATE tt-goto.
    ASSIGN tt-goto.orig = ENTRY(iContGT,cGotoFields).
    FIND FIRST _file NO-LOCK
        WHERE _file._file-name = ENTRY(1,ENTRY(iContGT,cGotoFields),".") NO-ERROR.
    IF AVAIL _file THEN DO:
        FIND FIRST _field NO-LOCK
            WHERE _field._file-recid = RECID(_file)
            AND   _field._field-name = ENTRY(2,ENTRY(iContGT,cGotoFields),".") NO-ERROR.
        IF AVAIL _field THEN
            ASSIGN tt-goto.campo = _field._label
                   tt-goto.tipo  = _field._data-type
                   tt-goto.formato = _field._format.
        ELSE
            ASSIGN tt-goto.campo = ENTRY(iContGT,cGotoFields).
    END.
END.

{func\run.i &Programa = "func\goto.w (INPUT-OUTPUT TABLE tt-goto)"}

IF RETURN-VALUE = "OK" THEN DO:

    ASSIGN cTempGT = "".
    FOR EACH tt-goto:
        IF cTempGT = "" THEN
            IF tt-goto.tipo <> "CHARACTER" THEN
                ASSIGN cTempGT = cTempGT + tt-goto.orig + " = " + tt-goto.tipo + "(~"" + tt-goto.valor + "~")".
            ELSE
                ASSIGN cTempGT = cTempGT + tt-goto.orig + " = " + "~"" + tt-goto.valor + "~"".
        ELSE
            IF tt-goto.tipo <> "CHARACTER" THEN
                ASSIGN cTempGT = cTempGT + " AND " + tt-goto.orig + " = " + tt-goto.tipo + "(~"" + tt-goto.valor + "~")".
            ELSE
                ASSIGN cTempGT = cTempGT + " AND " + tt-goto.orig + " = " + "~"" + tt-goto.valor + "~"".
    END.

    OS-DELETE VALUE(SESSION:TEMP-DIRECTORY + "rowid.p").
    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "rowid.p").

    PUT UNFORMATTED "DEFINE OUTPUT PARAMETER r-Temp AS ROWID." SKIP
                    "FIND FIRST {&Table} NO-LOCK WHERE " cTempGT " NO-ERROR." SKIP
                    "IF AVAIL {&Table} THEN" SKIP
                    "    ASSIGN r-Temp = ROWID({&Table})." SKIP
                    "ELSE" SKIP
                    "    ASSIGN r-Temp = ?." SKIP.

    OUTPUT CLOSE.

    RUN VALUE(SESSION:TEMP-DIRECTORY + "rowid.p") (OUTPUT rGoto).

    IF CAN-FIND(FIRST {&TABLE} WHERE ROWID({&TABLE}) = rGoto) THEN DO:
        FIND FIRST {&TABLE} NO-LOCK
            WHERE ROWID({&TABLE}) = rGoto.
        RUN displayFields IN THIS-PROCEDURE.
    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Registro n∆o encontrado (001)', INPUT _file._file-label + ' n∆o encontrado(a).', INPUT 'N∆o foi encontrado(a) nenhum(a) ' + _file._file-label + ' com a chave informada no V† Para.')"}
    END.

END.
