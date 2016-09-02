DEFINE VARIABLE hTemp-results AS HANDLE     NO-UNDO.
DEFINE VARIABLE l-habilita AS LOGICAL    NO-UNDO.

ASSIGN hTemp-results = br-page1:QUERY IN FRAME {&FRAME-NAME}.
IF hTemp-results:NUM-RESULTS > 0 THEN DO:
    ENABLE btUpdate-page1
           btDel-page1 WITH FRAME {&FRAME-NAME}.
    ASSIGN l-habilita = YES.
END.
ELSE DO:
    DISABLE btUpdate-page1
            btDel-page1 WITH FRAME {&FRAME-NAME}.
    ASSIGN l-habilita = NO.
END.
