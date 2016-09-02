RUN som.p(INPUT "music\click.wav").
RUN validateRecord IN THIS-PROCEDURE NO-ERROR.
IF RETURN-VALUE = "OK" THEN DO:
    CREATE {&TableSelect}.
    BUFFER-COPY {&Table} TO {&TableSelect} NO-ERROR.
    BUFFER-COPY {&TableDisp} TO {&TableSelect} NO-ERROR.
    RUN setCampos IN THIS-PROCEDURE NO-ERROR.
    RUN afterChange IN THIS-PROCEDURE NO-ERROR.
    {&OPEN-QUERY-br-select}
    {&OPEN-QUERY-br-disp}
    RUN controlButtons IN THIS-PROCEDURE.
END.

