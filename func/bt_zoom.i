DEFINE VARIABLE rReturn AS ROWID    NO-UNDO.

RUN som.p(INPUT "music\click.wav").

ASSIGN glImplantar = NO.
{func\run.i &Programa = "zoom\z{&Table}.w (OUTPUT rReturn)"}

IF RETURN-VALUE = "OK" THEN DO:
    FIND FIRST {&TABLE} NO-LOCK
        WHERE ROWID({&TABLE}) = rReturn.
    RUN displayFields IN THIS-PROCEDURE.
END.
