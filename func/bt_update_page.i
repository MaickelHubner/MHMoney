RUN som.p(INPUT "music\click.wav").
ASSIGN r-parent = ROWID({&Table}).

&IF "{1}" <> "" &THEN
    ASSIGN r-{1} = ROWID({1}).
&ELSE
    ASSIGN r-{&Filho} = ROWID({&Filho}).
&ENDIF

IF SELF:SENSITIVE = NO THEN
    ASSIGN pcActionBT = "DETAIL".
ELSE
    ASSIGN pcActionBT = "UPDATE".
&IF "{1}" <> "" &THEN
{func\run.i &Programa = "{1}_det.w"}
&ELSE
{func\run.i &Programa = "{&Filho}_det.w"}
&ENDIF
IF RETURN-VALUE = "OK" THEN DO:
    {&OPEN-QUERY-{&BROWSE-NAME}}
END.
