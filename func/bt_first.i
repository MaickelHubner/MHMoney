RUN som.p(INPUT "music\click.wav").
&IF "{1}" = "" &THEN
FIND FIRST {&Table} NO-LOCK NO-ERROR.
&ELSE
&IF "{2}" = "" &THEN
FIND FIRST {&Table} USE-INDEX {1} NO-LOCK NO-ERROR.
&ELSE
FIND FIRST {&Table} WHERE {2} USE-INDEX {1} NO-LOCK NO-ERROR.
&ENDIF
&ENDIF
DISABLE btPrev
        btFirst WITH FRAME {&FRAME-NAME}.
ENABLE btNext
       btLast WITH FRAME {&FRAME-NAME}.
RUN displayFields IN THIS-PROCEDURE.
