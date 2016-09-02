{gerapend.i}

DEFINE INPUT  PARAMETER pcUsuario AS CHARACTER   NO-UNDO.
DEFINE INPUT  PARAMETER dt-ini AS DATE    NO-UNDO.
DEFINE INPUT  PARAMETER dt-fim AS DATE    NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE FOR tt-pend.

DEFINE VARIABLE dt-aux AS DATE    NO-UNDO.
DEFINE VARIABLE de-cont AS DECIMAL     NO-UNDO.

EMPTY TEMP-TABLE tt-pend.

FOR EACH pedido NO-LOCK
    WHERE pedido.responsavel = pcUsuario
    AND pedido.situacao < 9 /* Cancelado */
    AND pedido.dt-lib-homolog <> ?
    AND YEAR(pedido.dt-lib-homolog) >= 2014
    AND pedido.nps = 0
    AND pedido.nr-pedido-ant = 0,
    FIRST favorecido OF pedido NO-LOCK:

    IF (pedido.dt-lib-homolog + 7) > TODAY THEN NEXT.

    CREATE tt-pend.
    ASSIGN tt-pend.dt-pend = pedido.dt-lib-homolog
           tt-pend.tipo = "HOMOL"
           tt-pend.ds-pend = "Projeto " + STRING(pedido.nr-pedido) + " (" + TRIM(favorecido.ds-favorecido) + ") " + pedido.nom-projeto
           tt-pend.cd-favorecido = pedido.cd-favorecido.
END.

IF pcUsuario = "Maickel"
OR pcUsuario = "Silvano" THEN DO:
    FOR EACH pedido NO-LOCK
        WHERE pedido.situacao <= 2 /* Iniciado */
        AND pedido.dt-aprovacao = ?
        AND pedido.dt-validade <= TODAY
        AND pedido.nr-pedido-ant = 0,
        FIRST favorecido OF pedido NO-LOCK:
        CREATE tt-pend.
        ASSIGN tt-pend.dt-pend = pedido.dt-validade
               tt-pend.tipo = "PROPOSTA"
               tt-pend.ds-pend = TRIM(favorecido.ds-favorecido) + "-Proposta" + pedido.num-cliente + " - " + pedido.nom-projeto.
               tt-pend.cd-favorecido = pedido.cd-favorecido.
    END.
END.

FOR EACH visita NO-LOCK
    WHERE visita.nome = pcUsuario
    AND   visita.situacao < 8 /* Realizada */,
    FIRST favorecido OF visita NO-LOCK:
    CREATE tt-pend.
    ASSIGN tt-pend.dt-pend = visita.dt-visita
           tt-pend.tipo = IF visita.compromisso THEN "COMPROM" ELSE "VISITA"
           tt-pend.ds-pend = TRIM(favorecido.ds-favorecido) + " - " + visita.ds-visita
           tt-pend.cd-favorecido = visita.cd-favorecido
           tt-pend.ds-observacao = visita.ds-observacao.
END.

FOR EACH tarefa NO-LOCK
    WHERE tarefa.responsavel = pcUsuario
    AND   tarefa.situacao < 8 /* Conclu¡da */,
    FIRST favorecido OF tarefa NO-LOCK:
    FIND FIRST ordem-serv OF tarefa NO-LOCK NO-ERROR.
    IF AVAIL ordem-serv THEN DO:
        CREATE tt-pend.
        ASSIGN tt-pend.dt-pend = tarefa.dt-alert-tarefa
               tt-pend.tipo = "TAREFA"
               tt-pend.ds-pend = TRIM(favorecido.ds-favorecido) + " - " + tarefa.ds-tarefa + " (" + ordem-serv.ds-os + ")"
           tt-pend.cd-favorecido = tarefa.cd-favorecido
           tt-pend.ds-observacao = tarefa.ds-observacao.
    END.
    ELSE DO:
        CREATE tt-pend.
        ASSIGN tt-pend.dt-pend = tarefa.dt-alert-tarefa
               tt-pend.tipo = "TAREFA"
               tt-pend.ds-pend = TRIM(favorecido.ds-favorecido) + " - " + tarefa.ds-tarefa
           tt-pend.cd-favorecido = tarefa.cd-favorecido
           tt-pend.ds-observacao = tarefa.ds-observacao.
    END.

    FOR EACH atendimento NO-LOCK
        WHERE atendimento.cd-favorecido = tarefa.cd-favorecido
        AND atendimento.nome = tarefa.nome
        AND atendimento.sequencia = tarefa.sequencia
        BY atendimento.data DESCENDING
        BY atendimento.hora DESCENDING:
        IF LENGTH(tt-pend.ds-observacao) < 30000 THEN DO:
            ASSIGN tt-pend.ds-observacao = tt-pend.ds-observacao + CHR(10) + CHR(10) +
                                           "ATENDIMENTO " + STRING(atendimento.data, "99/99/9999") + " " + atendimento.hora + " ===============================" + CHR(10) + CHR(10) +
                                           atendimento.observacao.
        END.
    END.

END.

REPEAT dt-aux = dt-ini TO dt-fim:
    IF WEEKDAY(dt-aux) = 1 /* Domingo */ THEN NEXT.
    IF WEEKDAY(dt-aux) = 7 /* Sabado */ THEN NEXT.
    IF CAN-FIND(FIRST feriado WHERE feriado.dt-feriado = dt-aux) THEN NEXT.
    IF dt-aux > TODAY THEN NEXT.
    ASSIGN de-cont = 0.
    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome = pcUsuario
        AND   apontamento.data = dt-aux:
        ASSIGN de-cont = de-cont + apontamento.qt-apont.
    END.
    FOR EACH visita NO-LOCK
        WHERE visita.nome = pcUsuario
        AND   visita.dt-visita = dt-aux
        AND   visita.ocupado:
        ASSIGN de-cont = de-cont + visita.qt-visita.
    END.
    IF de-cont < 8 THEN DO:
        IF de-cont = 0 THEN DO:
            CREATE tt-pend.
            ASSIGN tt-pend.dt-pend = dt-aux
                   tt-pend.tipo = "APONT"
                   tt-pend.ds-pend = "Falta apontamento no dia " + STRING(dt-aux, "99/99/9999")
                   tt-pend.cd-favorecido = 440.
        END.
        ELSE DO:
            CREATE tt-pend.
            ASSIGN tt-pend.dt-pend = dt-aux
                   tt-pend.tipo = "APONT"
                   tt-pend.ds-pend = "Apontamento incompleto (" + STRING(de-cont, "9.99") + "h) no dia " + STRING(dt-aux, "99/99/9999")
                   tt-pend.cd-favorecido = 440.
        END.
    END.
END.
