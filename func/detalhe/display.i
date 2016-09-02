DISABLE {&FrameDisp} WITH FRAME {&FRAME-NAME}.
&IF DEFINED(ParentField) <> 0 &THEN
    DISABLE {&Table}.{&ParentField} WITH FRAME {&FRAME-NAME}.
&ENDIF

IF AVAIL {&Table} THEN DO:

    DISPLAY {&KeyFields} WITH FRAME {&FRAME-NAME}.
    DISPLAY {&FrameFields} WITH FRAME {&FRAME-NAME}.
    DISPLAY {&FrameDisp} WITH FRAME {&FRAME-NAME}.
    &IF DEFINED(ParentField) <> 0 &THEN
        DISPLAY {&Table}.{&ParentField} WITH FRAME {&FRAME-NAME}.
    &ENDIF

    ASSIGN r-{&Table} = ROWID({&Table}).

    IF pcActionBT = "ADD" THEN DO:
        ENABLE {&KeyFields} WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE {&KeyFields} WITH FRAME {&FRAME-NAME}.
    END.
    IF pcActionBT <> "DETAIL" THEN DO:
        ENABLE {&FrameFields} WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE {&FrameFields} WITH FRAME {&FRAME-NAME}.
    END.

END.
ELSE DO:

    DISABLE {&KeyFields} WITH FRAME {&FRAME-NAME}.
    DISABLE {&FrameFields} WITH FRAME {&FRAME-NAME}.

END.
