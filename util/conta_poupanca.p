FOR EACH poupanca:

    IF NOT CAN-FIND(FIRST poup-conta
                    WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca
                    AND   poup-conta.cd-conta    = poupanca.cd-conta) THEN DO:

        CREATE poup-conta.
        ASSIGN poup-conta.cd-poupanca = poupanca.cd-poupanca
               poup-conta.cd-conta    = poupanca.cd-conta.

    END.

END.
