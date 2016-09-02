DEFINE VARIABLE hTemp-results AS HANDLE     NO-UNDO.

RUN som.p(INPUT "music\click.wav").
    
ASSIGN hTemp-results = br-disp:QUERY IN FRAME {&FRAME-NAME}.
REPEAT WHILE(hTemp-results:NUM-RESULTS > 0):
    br-disp:SELECT-ROW(1).
    APPLY "CHOOSE" TO btAdd IN FRAME {&FRAME-NAME}.
END.



