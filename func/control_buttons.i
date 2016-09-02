DEFINE INPUT  PARAMETER lHabilita AS LOGICAL    NO-UNDO.

IF lHabilita THEN DO:
    ENABLE {&FrameFields} WITH FRAME {&FRAME-NAME}.
    &IF DEFINED(Frame1Fields) &THEN
    ENABLE {&Frame1Fields} WITH FRAME fPage1.
    &ENDIF
    &IF DEFINED(Frame2Fields) &THEN
    ENABLE {&Frame2Fields} WITH FRAME fPage2.
    &ENDIF
    &IF DEFINED(Frame3Fields) &THEN
    ENABLE {&Frame3Fields} WITH FRAME fPage3.
    &ENDIF
    IF cAction = "ADD" THEN DO:
        ENABLE {&KeyFields} WITH FRAME {&FRAME-NAME}.
    END.
    ENABLE btOK
           btCancel WITH FRAME {&FRAME-NAME}.
    DISABLE btFirst
            btLast
            btPrev
            btNext
            btAdd
            btUpdate
            btDel
            btGoTo
            btZoom
            btExit WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    DISABLE {&FrameFields} WITH FRAME {&FRAME-NAME}.
    DISABLE {&KeyFields} WITH FRAME {&FRAME-NAME}.
    &IF DEFINED(Frame1Fields) &THEN
    DISABLE {&Frame1Fields} WITH FRAME fPage1.
    &ENDIF
    &IF DEFINED(Frame2Fields) &THEN
    DISABLE {&Frame2Fields} WITH FRAME fPage2.
    &ENDIF
    &IF DEFINED(Frame3Fields) &THEN
    DISABLE {&Frame3Fields} WITH FRAME fPage3.
    &ENDIF
    DISABLE btOK
            btCancel WITH FRAME {&FRAME-NAME}.
    ENABLE btAdd
           btExit WITH FRAME {&FRAME-NAME}.
    IF AVAIL {&Table} THEN DO:
        ENABLE btFirst
               btLast
               btPrev
               btNext
               btUpdate
               btDel
               btGoTo
               btZoom WITH FRAME {&FRAME-NAME}.
    END.
END.
