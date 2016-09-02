{1}:LOAD-MOUSE-POINTER("image\calcula.cur") IN FRAME {&FRAME-NAME}.
{1}:TOOLTIP IN FRAME {&FRAME-NAME} = "Clique duas vezes para abrir a calculadora.".
ON F5 OF {1} OR MOUSE-SELECT-DBLCLICK OF {1} 
DO:

    DEFINE VARIABLE deReturn AS DECIMAL NO-UNDO.
    {func\run.i &Programa = "func\calc.w (INPUT INPUT FRAME {&FRAME-NAME} {1}, OUTPUT deReturn)"}
    IF RETURN-VALUE = "OK" THEN DO:
        ASSIGN {1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(deReturn,{1}:FORMAT IN FRAME {&FRAME-NAME}).
        RUN afterCalc IN THIS-PROCEDURE (INPUT SELF:NAME) NO-ERROR.
    END.

END.
