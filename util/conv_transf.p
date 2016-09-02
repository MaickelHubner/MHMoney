DEFINE BUFFER bfMov FOR mov-conta.
FOR EACH mov-conta EXCLUSIVE-LOCK
    WHERE id-tipo = 3
    AND   seq-transf = 0:

    FIND FIRST bfMov WHERE bfMov.cd-conta = mov-conta.conta-transf
                     AND   bfMov.conta-transf = mov-conta.cd-conta
                     AND   bfMov.dt-mov = mov-conta.dt-mov
                     AND   bfMov.cd-favorecido = mov-conta.cd-favorecido
                     AND   bfMov.de-valor = (-1) * mov-conta.de-valor EXCLUSIVE-LOCK NO-ERROR.
    IF AVAIL bfMov THEN DO:

        ASSIGN mov-conta.seq-transf = bfMov.cd-sequencia
               bfMov.seq-transf = mov-conta.cd-sequencia.

    END.


END.
