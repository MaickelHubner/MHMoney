ENABLE btOK
       btCancel WITH FRAME {&FRAME-NAME}.

IF pcActionBT = "ADD" THEN DO:
    FIND FIRST {&Parent} NO-LOCK
        WHERE ROWID({&Parent}) = r-parent NO-ERROR.
    CREATE {&Table}.
    &IF DEFINED(ParentField) <> 0 &THEN
        ASSIGN {&Table}.{&ParentField} = {&Parent}.{&ParentField}.
    &ENDIF
    RUN assignIniFields IN THIS-PROCEDURE NO-ERROR.
END.
ELSE DO:
    FIND FIRST {&Table} EXCLUSIVE-LOCK
        WHERE ROWID({&Table}) = r-{&Table} NO-ERROR.
    FIND FIRST {&Parent} NO-LOCK
        WHERE ROWID({&Parent}) = r-parent NO-ERROR.
END.

RUN displayFields IN THIS-PROCEDURE.
