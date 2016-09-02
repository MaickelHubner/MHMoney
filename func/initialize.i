IF r-{&Table} <> ? THEN DO:
    FIND FIRST {&Table} NO-LOCK
        WHERE ROWID({&Table}) = r-{&Table} NO-ERROR.
    IF NOT AVAIL {&Table} THEN DO:
        APPLY "CHOOSE" TO btFirst IN FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        FIND FIRST bf-{&Table} NO-LOCK
            WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-ERROR.
        FIND NEXT bf-{&TABLE} NO-LOCK NO-ERROR.
        IF NOT AVAIL bf-{&TABLE} THEN
            DISABLE btNext
                    btLast WITH FRAME {&FRAME-NAME}.
        FIND FIRST bf-{&Table} NO-LOCK
            WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-ERROR.
        FIND PREV bf-{&TABLE} NO-LOCK NO-ERROR.
        IF NOT AVAIL bf-{&TABLE} THEN
            DISABLE btPrev
                    btFirst WITH FRAME {&FRAME-NAME}.
    END.
END.
ELSE
    APPLY "CHOOSE" TO btFirst IN FRAME {&FRAME-NAME}.

DISABLE {&ParentFields} WITH FRAME {&FRAME-NAME}.

RUN displayFields IN THIS-PROCEDURE.

APPLY "ENTRY" TO C-Win.

&IF "{1}" = "YES" &THEN
    IF pgInitialize <> "" THEN DO:
        CASE pgInitialize:
            WHEN "ADD" THEN APPLY "CHOOSE" TO btAdd IN FRAME {&FRAME-NAME}.
            WHEN "UPDATE" THEN APPLY "CHOOSE" TO btUpdate IN FRAME {&FRAME-NAME}.
        END CASE.
        ASSIGN pgInitialize = "".
    END.
&ENDIF
