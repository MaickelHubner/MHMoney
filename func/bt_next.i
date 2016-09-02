RUN som.p(INPUT "music\click.wav").
&IF "{1}" = "" &THEN
FIND NEXT {&Table} NO-LOCK.
&ELSE
&IF "{2}" = "" &THEN
FIND NEXT {&Table} USE-INDEX {1} NO-LOCK NO-ERROR.
&ELSE
FIND NEXT {&Table} WHERE {2} USE-INDEX {1} NO-LOCK NO-ERROR.
&ENDIF
&ENDIF
IF NOT AVAIL {&Table} THEN DO:
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
END.
ELSE DO:

    ENABLE btPrev
           btFirst WITH FRAME {&FRAME-NAME}.
    FIND FIRST bf-{&Table} NO-LOCK
        WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-ERROR.
    &IF "{1}" = "" &THEN
    FIND NEXT bf-{&Table} NO-LOCK NO-ERROR.
    &ELSE
    &IF "{2}" = "" &THEN
    FIND NEXT bf-{&Table} USE-INDEX {1} NO-LOCK NO-ERROR.
    &ELSE
    FIND NEXT bf-{&Table} WHERE {2} USE-INDEX {1} NO-LOCK NO-ERROR.
    &ENDIF
    &ENDIF
    IF NOT AVAIL bf-{&Table} THEN
        DISABLE btNext
                btLast WITH FRAME {&FRAME-NAME}.
END.
RUN displayFields IN THIS-PROCEDURE.
