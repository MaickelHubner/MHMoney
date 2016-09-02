PROCEDURE initialize-controls :

    assign chProgressBar = chctrlframe:ProgressBar.
    RUN initialize-controls-local IN THIS-PROCEDURE NO-ERROR.
    ASSIGN chProgressBar:VISIBLE = NO.

END PROCEDURE.

&IF DEFINED(Data) = 0 &THEN
    {func\data.i}
&ENDIF
&IF DEFINED(Cotacao) = 0 &THEN
    {cotacao.i}
&ENDIF

ASSIGN iProgsCont = iProgsCont + 1.
ASSIGN hProgsMenu[iProgsCont] = C-Win:HANDLE.
