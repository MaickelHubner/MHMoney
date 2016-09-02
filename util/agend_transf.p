DEFINE BUFFER bf-mov-conta FOR mov-conta.
FOR EACH mov-conta NO-LOCK
    WHERE id-tipo = 3
    AND   cd-agenda <> 0:

    FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
        WHERE bf-mov-conta.cd-conta = mov-conta.conta-transf
        AND   bf-mov-conta.cd-sequencia = mov-conta.seq-transf NO-ERROR.
    IF AVAIL bf-mov-conta
    AND bf-mov-conta.cd-agenda = 0 THEN
        ASSIGN bf-mov-conta.cd-agenda = mov-conta.cd-agenda.

END.
