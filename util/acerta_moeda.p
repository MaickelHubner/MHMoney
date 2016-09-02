DISABLE TRIGGERS FOR LOAD OF moeda.
DISABLE TRIGGERS FOR LOAD OF mov-conta.

IF NOT CAN-FIND(FIRST moeda) THEN DO:
    CREATE moeda.
    ASSIGN moeda.ds-moeda = "Real"
           moeda.sigla = "R$".
END.
FOR EACH conta NO-LOCK:

    FOR EACH mov-conta OF conta EXCLUSIVE-LOCK
        WHERE mov-conta.cd-moeda <> conta.cd-moeda:

        ASSIGN mov-conta.cd-moeda = conta.cd-moeda.

    END.

END.
