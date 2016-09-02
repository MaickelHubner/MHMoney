DO TRANSACTION:
    {func\run.i &Programa = "func\zoom\filtro.w (INPUT-OUTPUT TABLE tt-filtro)"}
    IF RETURN-VALUE <> "OK" THEN
        UNDO, LEAVE.
    ELSE
        RUN openQuery IN THIS-PROCEDURE.
END.

