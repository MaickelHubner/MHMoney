RUN som.p(INPUT "music\click.wav").
ASSIGN cAction = "ADD".
CREATE {&Table}.
&IF "{1}" <> "" &THEN
    FIND LAST bf-{&Table} NO-LOCK NO-ERROR.
    IF AVAIL bf-{&Table} THEN DO:
        ASSIGN {&Table}.{1} = bf-{&Table}.{1} + 1.
    END.
    ELSE DO:
        ASSIGN {&Table}.{1} = 1.
    END.
&ENDIF
RUN displayFields IN THIS-PROCEDURE.
RUN controlButtons IN THIS-PROCEDURE (INPUT YES).
&IF "{1}" <> "" &THEN
APPLY "ENTRY" TO {&Table}.{1} IN FRAME {&FRAME-NAME}.
&ENDIF
