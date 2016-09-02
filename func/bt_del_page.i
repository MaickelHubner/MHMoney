RUN som.p(INPUT "music\click.wav").
{func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Elimina‡Æo de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma elimina‡Æo do registro ?')"}
IF RETURN-VALUE = "OK" THEN DO:
    &IF "{1}" <> "" &THEN
        ASSIGN cTable = "{1}".
    &ELSE
        ASSIGN cTable = "{&Filho}".
    &ENDIF.
    RUN validateRecord IN THIS-PROCEDURE NO-ERROR.
    IF RETURN-VALUE <> "NOK":U THEN DO:
        &IF "{1}" <> "" &THEN
            FIND CURRENT {1} EXCLUSIVE-LOCK. 
            DELETE {1}.
        &ELSE
            FIND CURRENT {&Filho} EXCLUSIVE-LOCK.
            DELETE {&Filho}.
        &ENDIF.
        {&OPEN-QUERY-{&BROWSE-NAME}}
    END.
END.
