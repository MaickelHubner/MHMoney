{valida.i}

FUNCTION fnValidaReg
RETURNS CHARACTER () :

    DEFINE VARIABLE l-OK AS LOGICAL    NO-UNDO INITIAL YES.

    FIND FIRST param-mn.

    FOR EACH usuario:
        IF ValidaRegMoney(1, usuario.nome, param-mn.num-reg) = "OK" THEN DO:
            ASSIGN l-OK = YES.
            LEAVE.
        END.
    END.

    IF l-OK THEN DO:
        ASSIGN l-OK = NO.
        FIND FIRST conta NO-LOCK.
        IF ValidaRegMoney(2, conta.ds-conta, param-mn.num-reg) = "OK" THEN DO:
            ASSIGN l-OK = YES.
        END.
        IF l-OK THEN DO:
            ASSIGN l-OK = NO.
            FIND FIRST favorecido NO-LOCK.
            IF ValidaRegMoney(3, favorecido.ds-favorecido, param-mn.num-reg) = "OK" THEN DO:
                ASSIGN l-OK = YES.
            END.
            IF l-OK THEN DO:
                ASSIGN l-OK = NO.
                IF DATE(ValidaRegMoney(4, "", param-mn.num-reg)) >= TODAY THEN DO:
                    ASSIGN l-OK = YES.
                END.
                IF l-OK THEN DO:
                    ASSIGN l-OK = NO.
                    IF (ValidaRegMoney(5, "", param-mn.num-reg) = "Pessoal" AND param-mn.perfil = 1)
                    OR (ValidaRegMoney(5, "", param-mn.num-reg) = "Empresarial" AND param-mn.perfil = 2) THEN DO:
                        ASSIGN l-OK = YES.
                    END.
                END.
            END.
        END.
    END.

    IF l-OK THEN DO:
        RETURN "OK".
    END.
    ELSE DO:
        RETURN "NOK".
    END.

END FUNCTION.
