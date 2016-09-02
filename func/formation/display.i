IF AVAIL {&Table} THEN DO:

    DISPLAY {&ParentFields} WITH FRAME {&FRAME-NAME}.

    ASSIGN r-{&Table} = ROWID({&Table}).

    {&OPEN-QUERY-br-select}
    {&OPEN-QUERY-br-disp}

    RUN controlButtons IN THIS-PROCEDURE.

END.
ELSE DO:

    DISABLE btFirst
            btPrev
            btNext
            btLast WITH FRAME {&FRAME-NAME}.

END.
