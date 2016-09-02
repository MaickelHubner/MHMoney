FOR EACH agenda:

    IF NOT CAN-FIND(FIRST agenda-valor
                    WHERE agenda-valor.cd-agenda = agenda.cd-agenda) THEN DO:
        CREATE agenda-valor.
        ASSIGN agenda-valor.cd-agenda = agenda.cd-agenda
               agenda-valor.dt-ini = DATE(1,1,0001)
               agenda-valor.dt-end = DATE(12,31,9999)
               agenda-valor.valor = agenda.valor.
    END.

END.
