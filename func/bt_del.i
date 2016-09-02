RUN som.p(INPUT "music\click.wav").
{func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Elimina‡Æo de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma elimina‡Æo do registro ?')"}
IF RETURN-VALUE = "OK":U THEN DO:
    ASSIGN cAction = "DEL".
    RUN validateRecord IN THIS-PROCEDURE.
    ASSIGN cAction = "".
    IF RETURN-VALUE = "OK" THEN DO:
        {func\cancelar.i}
        IF NOT AVAIL {&Table} THEN
            FIND FIRST {&Table} NO-LOCK NO-ERROR.
        RUN displayFields IN THIS-PROCEDURE.
    END.
END.
