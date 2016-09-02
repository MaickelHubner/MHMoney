RUN som.p(INPUT "music\click.wav").
ASSIGN pcActionBT = "ADD"
       r-parent = ROWID({&Table}).
&IF "{1}" <> "" &THEN
{func\run.i &Programa = "{1}_det.w"}
&ELSE
{func\run.i &Programa = "{&Filho}_det.w"}
&ENDIF
IF RETURN-VALUE = "OK" THEN DO:
    {&OPEN-QUERY-{&BROWSE-NAME}}
END.
