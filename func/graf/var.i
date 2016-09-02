DEFINE VARIABLE iTotReg AS INTEGER    NO-UNDO.
DEFINE VARIABLE iContReg AS INTEGER    NO-UNDO.

ASSIGN INPUT FRAME {&FRAME-NAME} {&FrameFields}.

FOR EACH tt-graf:
    DELETE tt-graf.
END.
FOR EACH tt-graf-par:
    DELETE tt-graf-par.
END.

CREATE tt-graf-par.
ASSIGN tt-graf-par.titulo = TRIM(ENTRY(1,CURRENT-WINDOW:TITLE,"-")).
