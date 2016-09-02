IF pcActionBT = "ADD" THEN DO:
    FIND LAST bf-{&Table} OF {&Parent} NO-LOCK NO-ERROR.
    IF AVAIL bf-{&Table} THEN DO:
        ASSIGN {&Table}.{1} = bf-{&Table}.{1} + 1.
    END.
    ELSE DO:
        ASSIGN {&Table}.{1} = 1.
    END.
    DISPLAY {&Table}.{1} WITH FRAME {&FRAME-NAME}.
END.
