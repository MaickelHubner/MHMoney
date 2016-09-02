RUN som.p(INPUT "music\click.wav").
&IF DEFINED(Programa) = 0 &THEN
    {func\run.i &Programa = "{&Table}.w"}
    RUN openQuery IN THIS-PROCEDURE.
&ELSE
    {func\run.i &Programa = "{&Programa}.w"}
    RUN openQuery IN THIS-PROCEDURE.
&ENDIF
