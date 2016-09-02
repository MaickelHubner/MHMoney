RUN som.p(INPUT "music\click.wav").
IF VALID-HANDLE(hLastWidget) THEN
    ASSIGN hLastWidget:BGCOLOR = ?.
IF cAction = "ADD" THEN DO:
    {func\cancelar.i}
END.
ASSIGN cAction = "".
RUN displayFields IN THIS-PROCEDURE.
