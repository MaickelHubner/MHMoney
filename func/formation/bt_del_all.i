DEFINE VARIABLE hTemp-results AS HANDLE     NO-UNDO.

RUN som.p(INPUT "music\click.wav").

ASSIGN hTemp-results = br-select:QUERY IN FRAME {&FRAME-NAME}.
REPEAT WHILE(hTemp-results:NUM-RESULTS > 0):
    br-select:SELECT-ROW(1).
    APPLY "CHOOSE" TO btDel IN FRAME {&FRAME-NAME}.
END.



