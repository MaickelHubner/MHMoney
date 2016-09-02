DEFINE BUFFER bf-mov-conta FOR mov-conta.
DEFINE BUFFER bf-mov-bens FOR mov-bens.
DEFINE VARIABLE cTipo AS CHARACTER   NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-mov-bens AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-Parent   AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE pcActionBT AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.

/* Verificar se existe movimento parecido associado a algum bem */
blk-mov:
FOR EACH mov-conta
    WHERE mov-conta.id-tipo <> 0:

    IF CAN-FIND(FIRST mov-bens OF mov-conta) THEN NEXT blk-mov.

    FOR LAST bf-mov-conta NO-LOCK
        WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
        AND   bf-mov-conta.dt-mov < mov-conta.dt-mov
        AND   bf-mov-conta.cd-favorecido = mov-conta.cd-favorecido
        AND   bf-mov-conta.cod-categoria = mov-conta.cod-categoria
        AND   bf-mov-conta.cd-sub = mov-conta.cd-sub
        AND   bf-mov-conta.id-tipo = mov-conta.id-tipo,
        FIRST mov-bens OF bf-mov-conta NO-LOCK
        BY bf-mov-conta.dt-mov:

        IF AVAIL mov-bens THEN DO:

            FIND FIRST conta OF mov-conta NO-LOCK NO-ERROR.
            ASSIGN r-parent = ROWID(conta)
                   r-mov-conta = ROWID(mov-conta)
                   pcActionBT = "DETAIL".
            RUN mov-conta_det.w.

            CASE mov-bens.id-tipo:
                WHEN 1 THEN ASSIGN cTipo = "Aquisi‡Æo".
                WHEN 2 THEN ASSIGN cTipo = "Valor Agregado".
                WHEN 3 THEN ASSIGN cTipo = "Manuten‡Æo".
                WHEN 4 THEN ASSIGN cTipo = "Despesa".
                WHEN 5 THEN ASSIGN cTipo = "Consumo".
                WHEN 6 THEN ASSIGN cTipo = "Venda".
            END CASE.

            FIND FIRST bens OF mov-bens NO-LOCK NO-ERROR.

            RUN func\msg.w (INPUT 2, INPUT 'Relacionar com Bem (047)', INPUT 'Deseja relacionar o movimento com o Bem ?', INPUT 'Existe um movimento anterior idˆntico relacionado a ' + cTipo + ' do bem ' + bens.ds-bens + '. Deseja associar automaticamente esse movimento ao bem ?').
            IF RETURN-VALUE = "OK" THEN DO:
                CREATE bf-mov-bens.
                BUFFER-COPY mov-conta TO bf-mov-bens.
                BUFFER-COPY bens TO bf-mov-bens.
                ASSIGN bf-mov-bens.id-tipo = mov-bens.id-tipo.
                IF mov-bens.id-tipo = 5 THEN DO:
                    ASSIGN r-parent = ROWID(mov-conta)
                           r-mov-bens = ROWID(bf-mov-bens)
                           pcActionBT = "UPDATE".
                    RUN mov-bens_det.w.
                END.
            END.
            NEXT blk-mov.

        END.

    END.
END.

