RUN som.p(INPUT "music\click.wav").
&IF "{1}" = "" &THEN
FIND PREV {&Table} NO-LOCK NO-ERROR.
&ELSE
&IF "{2}" = "" &THEN
FIND PREV {&Table} USE-INDEX {1} NO-LOCK NO-ERROR.
&ELSE
FIND PREV {&Table} WHERE {2} USE-INDEX {1} NO-LOCK NO-ERROR.
&ENDIF
&ENDIF
IF NOT AVAIL {&Table} THEN DO:
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
END.
ELSE DO:
    ENABLE btNext
           btLast WITH FRAME {&FRAME-NAME}.
    FIND FIRST bf-{&Table} NO-LOCK
        WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-ERROR.
    &IF "{1}" = "" &THEN
    FIND PREV bf-{&Table} NO-LOCK NO-ERROR.
    &ELSE
    &IF "{2}" = "" &THEN
    FIND PREV bf-{&Table} USE-INDEX {1} NO-LOCK NO-ERROR.
    &ELSE
    FIND PREV bf-{&Table} WHERE {2} USE-INDEX {1} NO-LOCK NO-ERROR.
    &ENDIF
    &ENDIF
    IF NOT AVAIL bf-{&Table} THEN
        DISABLE btPrev
                btFirst WITH FRAME {&FRAME-NAME}.

END.
RUN displayFields IN THIS-PROCEDURE.
