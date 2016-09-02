DEFINE VARIABLE cArquivo AS CHARACTER  NO-UNDO.

IF NOT THIS-PROCEDURE:PERSISTENT THEN
    RUN som.p(INPUT "music\click.wav").
    
RUN validateRecord IN THIS-PROCEDURE.

IF RETURN-VALUE <> "NOK":U THEN DO:
    
    SESSION:SET-WAIT-STATE("image\calc.cur").
    ASSIGN chProgressBar:VISIBLE = YES.
    RUN executaRelatorio.
    ASSIGN chProgressBar:VISIBLE = NO.
    SESSION:SET-WAIT-STATE("").
    ASSIGN cArquivo = SEARCH("temp\" + cProgRelat + ".htm").
    {func\run.i &Programa = "grafview.w (INPUT TABLE tt-graf-par, INPUT TABLE tt-graf)"}

END.

