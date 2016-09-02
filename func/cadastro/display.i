IF AVAIL {&Table} THEN DO:

    DISPLAY {&KeyFields} WITH FRAME {&FRAME-NAME}.
    DISPLAY {&FrameFields} WITH FRAME {&FRAME-NAME}.
    &IF DEFINED(Frame1Fields) &THEN
    DISPLAY {&Frame1Fields} WITH FRAME fPage1.
    &ENDIF
    &IF DEFINED(Frame2Fields) &THEN
    DISPLAY {&Frame2Fields} WITH FRAME fPage2.
    &ENDIF
    &IF DEFINED(Frame3Fields) &THEN
    DISPLAY {&Frame3Fields} WITH FRAME fPage3.
    &ENDIF

    IF cAction = "" THEN DO:
        {func\disp_buttons.i}
    END.

    ASSIGN r-{&Table} = ROWID({&Table}).

END.
ELSE DO:

    DISABLE btFirst
            btPrev
            btNext
            btLast
            btUpdate
            btDel
            btGoTo
            btZoom WITH FRAME {&FRAME-NAME}.
    DISABLE {&KeyFields} WITH FRAME {&FRAME-NAME}.
    DISABLE {&FrameFields} WITH FRAME {&FRAME-NAME}.
    &IF DEFINED(Frame1Fields) &THEN
    DISABLE {&Frame1Fields} WITH FRAME fPage1.
    &ENDIF
    &IF DEFINED(Frame2Fields) &THEN
    DISABLE {&Frame2Fields} WITH FRAME fPage2.
    &ENDIF
    &IF DEFINED(Frame3Fields) &THEN
    DISABLE {&Frame3Fields} WITH FRAME fPage3.
    &ENDIF

END.
