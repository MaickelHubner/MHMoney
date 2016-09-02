RUN som.p(INPUT "music\click.wav").
RUN validateRecord IN THIS-PROCEDURE.
IF RETURN-VALUE = "OK" THEN DO:
    ASSIGN INPUT FRAME {&FRAME-NAME} {&KeyFields} {&FrameFields}.
    &IF DEFINED(Frame1Fields) &THEN
    ASSIGN INPUT FRAME fPage1 {&Frame1Fields}.    
    &ENDIF
    &IF DEFINED(Frame2Fields) &THEN
    ASSIGN INPUT FRAME fPage2 {&Frame2Fields}.    
    &ENDIF
    &IF DEFINED(Frame3Fields) &THEN
    ASSIGN INPUT FRAME fPage3 {&Frame3Fields}.    
    &ENDIF
    RUN afterAssignFields IN THIS-PROCEDURE NO-ERROR.
    ASSIGN pcActionBT = "".
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN "OK".
END.
