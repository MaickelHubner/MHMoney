ASSIGN C-Win:HIDDEN = YES.

PROCEDURE initialize-controls :

    assign chProgressBar = chctrlframe:ProgressBar.
    RUN initialize-controls-local IN THIS-PROCEDURE NO-ERROR.
    ASSIGN chProgressBar:VISIBLE = NO.

END PROCEDURE.

PROCEDURE getTTGraf:
    DEFINE OUTPUT PARAMETER TABLE FOR tt-graf-par.
    DEFINE OUTPUT PARAMETER TABLE FOR tt-graf.
END PROCEDURE.

PROCEDURE setPersistent:
    ASSIGN C-Win:HIDDEN = YES.
    RUN control_load.
    RUN initialize.
END PROCEDURE.

PROCEDURE closeProg:
    APPLY "CHOOSE" TO btCancel IN FRAME {&FRAME-NAME}.
END PROCEDURE.

{func\data.i}
{cotacao.i}

ASSIGN iProgsCont = iProgsCont + 1.
ASSIGN hProgsMenu[iProgsCont] = C-Win:HANDLE.
