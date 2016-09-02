ASSIGN br-page1:TITLE IN FRAME {&FRAME-NAME} = "{&LabelFilho}".
IF AVAIL {&Table} THEN DO:

    DISPLAY {&ParentFields} WITH FRAME {&FRAME-NAME}.

    ASSIGN r-{&Table} = ROWID({&Table}).

    {&OPEN-QUERY-{&BROWSE-NAME}}

END.
ELSE DO:

    DISABLE btFirst
            btPrev
            btNext
            btLast
            btGoTo
            btZoom
            btAdd-page1 WITH FRAME {&FRAME-NAME}.

END.
