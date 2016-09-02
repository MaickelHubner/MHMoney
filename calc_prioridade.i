    
    ASSIGN {1}.data-prev-ini = dtAux
           d-tar = {1}.qtd-lib * ((100 - {1}.perc-con) / 100)
           d-qt = d-qt - d-tar.

    IF {1}.situacao = 1 /* Pendente */ THEN DO:
        ASSIGN {1}.dt-alert-tarefa = {1}.data-prev-ini.
    END.
    ELSE DO:
        IF {1}.dt-alert-tarefa = ?
        OR {1}.dt-alert-tarefa > {1}.data-prev-ini THEN DO:
            ASSIGN {1}.dt-alert-tarefa = {1}.data-prev-ini.
        END.
    END.


    IF d-qt = 0 THEN
        ASSIGN {1}.data-prev-fim = dtAux.

    IF d-qt <= 0 THEN DO:
        blk-qtd:
        REPEAT:
            ASSIGN dtAux = dtAux + 1.
            blk-fer:
            REPEAT:
                ASSIGN de-qt-vis = 0.
                FIND FIRST feriado NO-LOCK
                    WHERE feriado.dt-feriado = dtAux NO-ERROR.
                IF AVAIL feriado THEN DO:
                    ASSIGN dtAux = dtAux + 1.
                END.
                ELSE DO:
                    FOR EACH visita NO-LOCK
                        WHERE visita.nome = pcUsuario
                        AND   visita.situacao < 9
                        AND   visita.dt-visita = dtAux
                        AND   visita.ocupado:
                        ASSIGN de-qt-vis = de-qt-vis + visita.qt-visita.
                    END.
                    IF de-qt-vis >= 8.5 THEN
                        ASSIGN dtAux = dtAux + 1.
                END.
                IF NOT AVAIL feriado
                AND de-qt-vis < 8.5 THEN
                    LEAVE blk-fer.
            END.
            CASE WEEKDAY(dtAux):
                WHEN 1 /* Domingo */ THEN ASSIGN dtAux = dtAux + 1.
                WHEN 7 /* S bado */ THEN ASSIGN dtAux = dtAux + 2.
            END CASE.
            ASSIGN de-qt-vis = 0.
            FOR EACH visita NO-LOCK
                WHERE visita.nome = pcUsuario
                AND   visita.situacao < 9
                AND   visita.dt-visita = dtAux
                AND   visita.ocupado:
                ASSIGN de-qt-vis = de-qt-vis + visita.qt-visita.
            END.
            IF (8.5 - de-qt-vis) < usuario.hrs-dia  THEN
                ASSIGN d-qt = d-qt + (8.5 - de-qt-vis).
            ELSE
                ASSIGN d-qt = d-qt + usuario.hrs-dia.
            IF d-qt >= 0 THEN
                LEAVE blk-qtd.
        END.
    END.

    IF d-qt <> usuario.hrs-dia THEN
        ASSIGN {1}.data-prev-fim = dtAux.


