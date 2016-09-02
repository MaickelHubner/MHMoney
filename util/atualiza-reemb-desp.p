DEFINE VARIABLE c-usuario AS CHARACTER   NO-UNDO INITIAL "Maickel".

FIND FIRST param-mn NO-LOCK.

/* Atualiza agendamento */
FIND FIRST agenda EXCLUSIVE-LOCK
    WHERE agenda.usuar-resp = c-usuario
    AND   agenda.cd-favorecido = 9 NO-ERROR.
IF AVAIL agenda THEN DO:
    MESSAGE agenda.usuar-resp SKIP agenda.cd-agenda SKIP agenda.prox-data-pag
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
    ASSIGN agenda.vl-atual = 0.
    FOR EACH mov-conta NO-LOCK
        WHERE mov-conta.cd-conta = param-mn.conta-desp-viag
        AND   mov-conta.id-tipo <> 0
        AND   mov-conta.id-situacao = 1
        AND   mov-conta.usuar-resp = agenda.usuar-resp
        AND   mov-conta.dt-mov < DATE(MONTH(agenda.prox-data-pag), 1, YEAR(agenda.prox-data-pag)):
        MESSAGE mov-conta.dt-mov SKIP mov-conta.de-valor
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        ASSIGN agenda.vl-atual = agenda.vl-atual + mov-conta.de-valor.
    END.
END.

