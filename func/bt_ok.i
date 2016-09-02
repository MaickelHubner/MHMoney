RUN som.p(INPUT "music\click.wav").
IF VALID-HANDLE(hLastWidget) THEN
    ASSIGN hLastWidget:BGCOLOR = ?.
DEFINE VARIABLE l-val-ok AS LOGICAL    NO-UNDO INITIAL NO.
RUN validateRecord IN THIS-PROCEDURE.
IF RETURN-VALUE = "OK":U THEN DO:
    ASSIGN l-val-ok = YES.
    FIND CURRENT {&Table} EXCLUSIVE-LOCK.
    ASSIGN INPUT FRAME {&FRAME-NAME} {&FrameFields}.
    &IF DEFINED(Frame1Fields) &THEN
    ASSIGN INPUT FRAME fPage1 {&Frame1Fields}.    
    &ENDIF
    &IF DEFINED(Frame2Fields) &THEN
    ASSIGN INPUT FRAME fPage2 {&Frame2Fields}.    
    &ENDIF
    &IF DEFINED(Frame3Fields) &THEN
    ASSIGN INPUT FRAME fPage3 {&Frame3Fields}.    
    &ENDIF
    IF cAction = "ADD" THEN DO:
        ASSIGN INPUT FRAME {&FRAME-NAME} {&KeyFields}.
    END.
    RUN afterAssignFields IN THIS-PROCEDURE NO-ERROR.
    ASSIGN cAction = "".
    RUN displayFields IN THIS-PROCEDURE.
END.
