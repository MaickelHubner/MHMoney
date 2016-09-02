DEFINE VARIABLE hTemp-results AS HANDLE     NO-UNDO.

ASSIGN hTemp-results = br-select:QUERY IN FRAME {&FRAME-NAME}.
IF hTemp-results:NUM-RESULTS > 0 THEN DO:
    ENABLE btDel
           btDelAll WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    DISABLE btDel
            btDelAll WITH FRAME {&FRAME-NAME}.
END.

ASSIGN hTemp-results = br-disp:QUERY IN FRAME {&FRAME-NAME}.
IF hTemp-results:NUM-RESULTS > 0 THEN DO:
    ENABLE btAdd
           btAddAll WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    DISABLE btAdd
            btAddAll WITH FRAME {&FRAME-NAME}.
END.

