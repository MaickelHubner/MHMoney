DEFINE {1} shared VARIABLE gcUsuario AS CHARACTER  NO-UNDO.

{reg.i}

IF CAN-FIND(FIRST usuario)
AND CAN-FIND(FIRST conta)
AND CAN-FIND(FIRST favorecido) THEN DO:
    FIND FIRST param-mn NO-LOCK.
    IF param-mn.num-reg = "" THEN DO:
        RUN valida.w NO-ERROR.
        FIND FIRST param-mn NO-LOCK.
        IF param-mn.num-reg = "" THEN
            QUIT.
    END.
    ELSE DO:
        IF fnValidaReg() = "NOK" THEN DO:
            RUN valida.w NO-ERROR.
            FIND FIRST param-mn NO-LOCK.
            IF param-mn.num-reg = ""
            OR fnValidaReg() = "NOK" THEN
                QUIT.
        END.
    END.
END.

if gcUsuario = "" then do:
    run senha.w.
    if gcUsuario = "" then
        quit.
end.

