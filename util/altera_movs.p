DEFINE VARIABLE iConta AS INTEGER     NO-UNDO INITIAL 4.
DEFINE VARIABLE dtInicio AS DATE    NO-UNDO INITIAL 04/26/2017.
DEFINE VARIABLE dtFim AS DATE     NO-UNDO INITIAL 05/27/2017.
DEFINE BUFFER bf-mov FOR mov-conta.
DEFINE VARIABLE deSoma AS DECIMAL     NO-UNDO.
DEFINE VARIABLE lCompras AS LOGICAL     NO-UNDO.

/*FOR EACH mov-conta
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.dt-mov >= dtInicio
    AND   mov-conta.dt-mov <= dtFim:
    ASSIGN mov-conta.id-situacao = 1.
END.*/
    
FOR EACH mov-conta
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.dt-mov >= dtInicio
    AND   mov-conta.dt-mov <= dtFim
    AND   mov-conta.id-situacao = 1
    AND   mov-conta.de-valor < 0,
    FIRST favorecido OF mov-conta,
        FIRST categoria OF mov-conta,
            FIRST sub-cat OF mov-conta:

    DISP mov-conta.dt-mov
         favorecido.ds-favorecido FORMAT "X(15)"
         sub-cat.ds-sub FORMAT "X(15)"
         mov-conta.de-valor
         REPLACE(REPLACE(mov-conta.ds-observacao, CHR(10), " "), CHR(13), " ") FORMAT "X(40)"
        WITH WIDTH 500.

    UPDATE mov-conta.de-valor.

    IF mov-conta.de-valor > 0 THEN
        ASSIGN mov-conta.de-valor = (-1) * mov-conta.de-valor.

END.

FOR EACH mov-conta
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.dt-mov >= dtInicio
    AND   mov-conta.dt-mov <= dtFim
    AND   mov-conta.id-situacao = 1
    AND   mov-conta.id-tipo = 0,
        FIRST favorecido OF mov-conta:

    ASSIGN deSoma = 0.
    FOR EACH bf-mov
        WHERE bf-mov.cd-conta = iConta
        AND   bf-mov.agrupado = mov-conta.cd-sequencia:
        ASSIGN deSoma = deSoma + bf-mov.de-valor.
    END.

    DISP mov-conta.dt-mov
         favorecido.ds-favorecido FORMAT "X(15)"
         mov-conta.de-valor
         deSoma
        WITH WIDTH 500.

    ASSIGN mov-conta.de-valor = deSoma.

END.

MESSAGE "Deseja atualizar os itens das compras do per¡odo?"
    VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE lCompras.

IF lCompras THEN DO:

    FOR EACH compra
        WHERE compra.dt-compra >= dtInicio
        AND   compra.dt-compra <= dtFim,
        FIRST favorecido OF compra:

        DISP compra.dt-compra
             favorecido.ds-favorecido.

        FOR EACH item-compra OF compra,
            FIRST item OF item-compra:

            DISP item.ds-item FORMAT "X(15)"
                 item-compra.vl-unitario
                 item-compra.quantidade
                 item-compra.vl-total.

            UPDATE item-compra.vl-total.
            ASSIGN item-compra.vl-unitario = (item-compra.vl-total / item-compra.quantidade).

            DISP item-compra.vl-unitario.

        END.

    END.

END.
