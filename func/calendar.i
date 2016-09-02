{1}:LOAD-MOUSE-POINTER("image\calend.cur") IN FRAME {&FRAME-NAME}.
{1}:TOOLTIP IN FRAME {&FRAME-NAME} = "Clique duas vezes para abrir o calend rio.".
ON F5 OF {1} OR MOUSE-SELECT-DBLCLICK OF {1} 
DO:

    DEFINE VARIABLE dtReturn AS DATE       NO-UNDO.
    {func\run.i &Programa = "func\calendar.w (OUTPUT dtReturn)"}
    IF RETURN-VALUE = "OK" THEN
        ASSIGN {1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(dtReturn,"99/99/9999").

END.
