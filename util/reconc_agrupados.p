DEFINE BUFFER bfMov FOR mov-conta.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.id-tipo = 0
    AND   mov-conta.id-situacao = 3:

    FOR EACH bfMov EXCLUSIVE-LOCK
        WHERE bfMov.cd-conta = mov-conta.cd-conta
        AND   bfMov.agrupado = mov-conta.cd-sequencia:

        ASSIGN bfMov.id-situacao = 3.

    END.

END.
