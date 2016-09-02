DEFINE BUFFER bf-mov-conta FOR mov-conta.
    
FOR EACH mov-conta
    WHERE mov-conta.id-tipo = 0:
    FOR EACH bf-mov-conta EXCLUSIVE-LOCK
        WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
        AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
    /* Se o respons vel do movimento de agrupamento for diferente de Todos replica para
       os movimentos agrupados */
    IF mov-conta.usuar-resp <> "" THEN
        ASSIGN bf-mov-conta.usuar-resp = mov-conta.usuar-resp.
    END.
END.
