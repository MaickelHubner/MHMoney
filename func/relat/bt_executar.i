DEFINE VARIABLE cArquivo AS CHARACTER  NO-UNDO.

RUN som.p(INPUT "music\click.wav").

RUN validateRecord IN THIS-PROCEDURE.

IF RETURN-VALUE <> "NOK":U THEN DO:
    
    SESSION:SET-WAIT-STATE("image\calc.cur").
    ASSIGN chProgressBar:VISIBLE = YES.
    RUN executaRelatorio.
    ASSIGN chProgressBar:VISIBLE = NO.
    SESSION:SET-WAIT-STATE("").
    ASSIGN cArquivo = SEARCH("temp\" + cProgRelat + ".htm").
    {func\run.i &Programa = "relview.w (INPUT cArquivo)"}

END.

