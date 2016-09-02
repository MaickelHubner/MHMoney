RUN som.p(INPUT "music\click.wav").
&IF "{1}" = "" &THEN
FIND LAST {&Table} NO-LOCK NO-ERROR.
&ELSE
&IF "{2}" = "" &THEN
FIND LAST {&Table} USE-INDEX {1} NO-LOCK NO-ERROR.
&ELSE
FIND LAST {&Table} WHERE {2} USE-INDEX {1} NO-LOCK NO-ERROR.
&ENDIF
&ENDIF

DISABLE btNext
        btLast WITH FRAME {&FRAME-NAME}.
ENABLE btPrev
       btFirst WITH FRAME {&FRAME-NAME}.
RUN displayFields IN THIS-PROCEDURE.
