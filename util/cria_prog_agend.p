FOR EACH agenda NO-LOCK:

    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 0 /* Dia NÆo étil */
           prog-agenda.valor = 2.

    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1 /* Anual */
           prog-agenda.todos = YES.

    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2 /* Mensal */
           prog-agenda.valor = agenda.dia.
END.
