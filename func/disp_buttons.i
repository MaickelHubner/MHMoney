RUN controlButtons IN THIS-PROCEDURE (INPUT NO).

FIND FIRST bf-{&Table} WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-LOCK.
&IF DEFINED(UseIndex) &THEN
FIND NEXT bf-{&Table} USE-INDEX {&UseIndex} NO-LOCK NO-ERROR.
&ELSE
FIND NEXT bf-{&Table} NO-LOCK NO-ERROR.
&ENDIF
IF NOT AVAIL bf-{&Table} THEN DO:
    DISABLE btNext
            btLast WITH FRAME {&FRAME-NAME}.
END.

FIND FIRST bf-{&Table} WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-LOCK.
&IF DEFINED(UseIndex) &THEN
FIND PREV bf-{&Table} USE-INDEX {&UseIndex} NO-LOCK NO-ERROR.
&ELSE
FIND PREV bf-{&Table} NO-LOCK NO-ERROR.
&ENDIF
IF NOT AVAIL bf-{&Table} THEN DO:
    DISABLE btPrev
            btFirst WITH FRAME {&FRAME-NAME}.
END.

