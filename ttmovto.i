DEFINE VARIABLE iNumMovtosTT AS INTEGER    NO-UNDO.
DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO INITIAL 1.
DEFINE BUFFER bf-conta FOR conta.
DEFINE BUFFER bfProg FOR prog-agenda.
DEFINE BUFFER bfProg-mes FOR prog-agenda.
DEFINE BUFFER bfProg-sem FOR prog-agenda.
DEFINE BUFFER bfProg-dia FOR prog-agenda.
DEFINE BUFFER bf-agenda FOR agenda.
DEFINE BUFFER bf-agenda-valor FOR agenda-valor.
DEFINE VARIABLE iAuxDiaNval AS INTEGER    NO-UNDO.
DEFINE VARIABLE deValCPMF AS DECIMAL    NO-UNDO.
DEFINE VARIABLE de-val-imp AS DECIMAL     NO-UNDO.
{proxpag.i}

FUNCTION fnCriaMov RETURNS CHARACTER (iAgend AS INT,
                                      dtTemp AS DATE):

    FIND FIRST bfAgend NO-LOCK
        WHERE bfAgend.cd-agenda = iAgend NO-ERROR.
    IF NOT AVAIL bfAgend THEN RETURN "NOK".

    IF NOT {3} AND bfAgend.simulado THEN RETURN "OK".
    IF bfAgend.dt-ultimo-pag >= bfAgend.dt-fim THEN RETURN "OK".
    IF dtTemp >= bfAgend.dt-fim THEN RETURN "OK".

    IF dtTemp < bfAgend.prox-data-pag THEN RETURN "OK".

    IF bfAgend.cd-conta = iConta
    OR bfAgend.conta-transf = iConta THEN DO:

        FIND FIRST agenda-valor NO-LOCK
            WHERE agenda-valor.dt-ini <= dtTemp
            AND   agenda-valor.dt-end >= dtTemp
            AND   agenda-valor.cd-agenda = bfAgend.cd-agenda NO-ERROR.
        IF NOT AVAIL agenda-valor THEN RETURN "NOK".

        FIND FIRST conta NO-LOCK
            WHERE conta.cd-conta = bfAgend.cd-conta NO-ERROR.

        CREATE tt-mov-conta.
        ASSIGN tt-mov-conta.cd-conta      = bfAgend.cd-conta
               tt-mov-conta.cd-favorecido = bfAgend.cd-favorecido
               tt-mov-conta.cod-categoria = bfAgend.cod-categoria
               tt-mov-conta.cd-sub        = bfAgend.cd-sub
               tt-mov-conta.conta-transf  = bfAgend.conta-transf
               tt-mov-conta.id-tipo       = bfAgend.id-tipo
               tt-mov-conta.de-valor      = IF AVAIL agenda-valor THEN agenda-valor.valor ELSE 0
               tt-mov-conta.cd-sequencia  = iSeq
               tt-mov-conta.dt-mov        = dtTemp
               tt-mov-conta.cd-moeda      = conta.cd-moeda
               tt-mov-conta.cd-agenda     = bfAgend.cd-agenda
               tt-mov-conta.id-situacao   = 1
               iSeq = iSeq + 1
               iNumMovtosTT = iNumMovtosTT + 1.

        IF dtTemp = bfAgend.prox-data-pag THEN DO:
            /* Pr¢ximo pagamento do agendamento */
            FIND FIRST param-mn NO-LOCK NO-ERROR.
            IF param-mn.perfil = 2 /* Empresarial */ THEN DO:
                IF CAN-FIND(FIRST imposto OF bfAgend) THEN DO:
                    ASSIGN tt-mov-conta.de-valor = 0.
                    FOR EACH imposto OF bfAgend NO-LOCK:
                        FOR EACH nota-fiscal-imp OF imposto NO-LOCK
                            WHERE nota-fiscal-imp.situacao = 1 /* Pendente */:
                            FIND FIRST nota-fiscal OF nota-fiscal-imp NO-LOCK NO-ERROR.
                            IF nota-fiscal.dt-emissao < DATE(MONTH(tt-mov-conta.dt-mov), 1, YEAR(tt-mov-conta.dt-mov)) THEN DO:
                                ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor - nota-fiscal-imp.val-imposto.
                            END.
                        END.
                    END.
                END.
            END.
            IF bfAgend.vl-atual <> 0 THEN DO:
                /* Se o valor foi atualizado */
                ASSIGN tt-mov-conta.de-valor = bfAgend.vl-atual.
            END.
            IF bfAgend.id-tipo = 3 THEN DO:
                FIND FIRST bf-conta WHERE bf-conta.cd-conta = bfAgend.conta-transf NO-LOCK.
                /*/* Acerta moeda se for transferància */
                IF bf-conta.cd-moeda <> tt-mov-conta.cd-moeda
                AND bf-conta.cd-moeda <> 0 THEN
                    ASSIGN tt-mov-conta.cd-moeda = bf-conta.cd-moeda.*/
                IF bf-conta.id-tipo = 3 and not bf-conta.dinheiro THEN DO:
                    /* Cart∆o de CrÇdito - soma valor de pagamento pelos movimentos lanáados */
                    ASSIGN tt-mov-conta.de-valor = bf-conta.vl-saldo.
                    FOR EACH mov-conta OF bf-conta
                        WHERE mov-conta.id-situacao <> 3
                        AND   mov-conta.agrupado = 0
                        AND   mov-conta.dt-mov <= dtTemp + bf-conta.dia-fat
                        USE-INDEX compensado:

                        ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor + mov-conta.de-valor.

                    END.
                    /* Soma tambÇm os movimentos agendados para aquele cart∆o de crÇdito */
                    FOR EACH bf-agenda
                        WHERE bf-agenda.cd-conta = bf-conta.cd-conta
                        AND   bf-agenda.dt-ini <= (dtTemp + bf-conta.dia-fat)
                        AND   IF (bf-agenda.dt-ini = bf-agenda.dt-fim) THEN TRUE ELSE (bf-agenda.dt-fim >= dtTemp):

                        IF bf-agenda.prox-data-pag > (dtTemp + bf-conta.dia-fat) THEN NEXT.

                        IF bf-agenda.vl-atual <> 0 THEN DO:
                            ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor + bf-agenda.vl-atual.
                        END.
                        ELSE DO:
                            FIND FIRST bf-agenda-valor NO-LOCK
                                WHERE bf-agenda-valor.dt-ini <= (dtTemp + bf-conta.dia-fat)
                                AND   bf-agenda-valor.dt-end >= (dtTemp + bf-conta.dia-fat)
                                AND   bf-agenda-valor.cd-agenda = bf-agenda.cd-agenda NO-ERROR.
                            IF AVAIL bf-agenda-valor THEN
                                ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor + bf-agenda-valor.valor.
                        END.

                    END.
                END.
            END.
        END.
        ELSE DO:
            /* Se n∆o for o pr¢ximo pagamento */
            IF bfAgend.id-tipo = 3 THEN DO:
                FIND FIRST bf-conta WHERE bf-conta.cd-conta = bfAgend.conta-transf NO-LOCK.
                /*/* Acerta moeda se for transferància */
                IF bf-conta.cd-moeda <> tt-mov-conta.cd-moeda
                AND bf-conta.cd-moeda <> 0 THEN
                    ASSIGN tt-mov-conta.cd-moeda = bf-conta.cd-moeda.*/
                IF bf-conta.id-tipo = 3 and not bf-conta.dinheiro THEN DO:
                    /* Cart∆o de CrÇdito - soma valor de pagamento pelos movimentos lanáados */
                    ASSIGN tt-mov-conta.de-valor = 0.
                    FOR EACH mov-conta OF bf-conta
                        WHERE mov-conta.id-situacao <> 3
                        AND   mov-conta.agrupado = 0
                        AND   mov-conta.dt-mov > DATE((IF MONTH(dtTemp + bf-conta.dia-fat) <> 1 THEN MONTH(dtTemp + bf-conta.dia-fat) - 1 ELSE 12),DAY(dtTemp + bf-conta.dia-fat),(IF MONTH(dtTemp + bf-conta.dia-fat) <> 1 THEN YEAR(dtTemp + bf-conta.dia-fat) ELSE YEAR(dtTemp + bf-conta.dia-fat) - 1))
                        AND   mov-conta.dt-mov <= (dtTemp + bf-conta.dia-fat)
                        USE-INDEX compensado:

                        ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor + mov-conta.de-valor.

                    END.
                    /* Soma tambÇm os movimentos agendados para aquele cart∆o de crÇdito */
                    FOR EACH bf-agenda
                        WHERE bf-agenda.cd-conta = bf-conta.cd-conta
                        AND   bf-agenda.dt-fim >= (dtTemp + bf-conta.dia-fat - 30):

                        FIND FIRST bf-agenda-valor NO-LOCK
                            WHERE bf-agenda-valor.dt-ini <= (dtTemp + bf-conta.dia-fat)
                            AND   bf-agenda-valor.dt-end >= (dtTemp + bf-conta.dia-fat)
                            AND   bf-agenda-valor.cd-agenda = bf-agenda.cd-agenda NO-ERROR.
                        IF AVAIL bf-agenda-valor THEN
                            ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor + bf-agenda-valor.valor.

                    END.
                    /* Se n∆o atingiu o valor do agendamento, mantÇm o valor agendado */
                    IF AVAIL agenda-valor THEN DO:
                        IF tt-mov-conta.de-valor > agenda-valor.valor THEN DO:
                            ASSIGN tt-mov-conta.de-valor = agenda-valor.valor.
                        END.
                    END.
                END.
            END.
            IF bfAgend.calc-cpmf
            AND NOT THIS-PROCEDURE:FILE-NAME MATCHES("*calcCPMFdata.p*") THEN DO:
                /* Calcula o valor de CPMF se for maior que o valor agendado */
                RUN calcCPMFdata.p (INPUT bfAgend.cd-agenda, INPUT tt-mov-conta.dt-mov, OUTPUT deValCPMF).
                IF deValCPMF < tt-mov-conta.de-valor THEN
                    ASSIGN tt-mov-conta.de-valor = deValCPMF.
            END.
        END.
        /* Inverte o valor se a conta for a de transferància */
        IF bfAgend.conta-transf = iConta THEN
            ASSIGN tt-mov-conta.de-valor = (-1) * tt-mov-conta.de-valor.
    END.

    RETURN "OK".

END FUNCTION. 

PROCEDURE criaTT:

    DEFINE VARIABLE dtIni AS DATE       NO-UNDO.
    DEFINE VARIABLE i-max AS INTEGER     NO-UNDO.
    DEFINE VARIABLE dtCont AS DATE       NO-UNDO.
    DEFINE VARIABLE dtProx AS DATE       NO-UNDO.

    ASSIGN dtIni = {1} - 7.
    FIND LAST mov-conta WHERE mov-conta.cd-conta = iConta NO-LOCK NO-ERROR.
    IF AVAIL mov-conta THEN
        ASSIGN iSeq = mov-conta.cd-sequencia + 1.

    ASSIGN iNumMovtosTT = 0.

    FOR LAST agenda NO-LOCK
        WHERE agenda.dt-ini <= dtIni
        AND   agenda.prox-data-pag >= dtIni
        AND   agenda.prox-data-pag <= {2}:
        ASSIGN i-max = agenda.cd-agenda.
    END.

    FOR EACH agenda NO-LOCK
        WHERE agenda.dt-ini <= dtIni
        AND   agenda.prox-data-pag >= dtIni
        AND   agenda.prox-data-pag <= {2}:

        RUN controlaExecucao IN THIS-PROCEDURE (INPUT i-max, INPUT agenda.cd-agenda) NO-ERROR.

        ASSIGN dtCont = ?
               dtProx = agenda.prox-data-pag.

        REPEAT WHILE ((dtProx <= {2}) AND (dtCont <> dtProx)):
            ASSIGN dtCont = dtProx.
            fnCriaMov(agenda.cd-agenda, dtCont).
            RUN calculaProximoPag (INPUT agenda.cd-agenda, INPUT dtCont, INPUT FALSE, OUTPUT dtProx).
        END.

    END.

    FIND FIRST param-mn NO-LOCK NO-ERROR.
    IF param-mn.perfil = 2 /* Empresarial */ THEN DO:

        FIND FIRST conta NO-LOCK
            WHERE conta.id-tipo = 1 /* Conta Corrente */
            AND   NOT conta.id-encerrada
            AND   conta.cd-moeda = 0 NO-ERROR.
        IF AVAIL conta THEN DO:

            FOR EACH parc-nota-fiscal NO-LOCK
                WHERE parc-nota-fiscal.situacao = 1 /* Pendente */
                AND   parc-nota-fiscal.dt-pagto-parc >= {1}
                AND   parc-nota-fiscal.dt-pagto-parc <= {2}:

                ASSIGN de-val-imp = 0.

                FIND FIRST nota-fiscal OF parc-nota-fiscal NO-LOCK NO-ERROR.

                IF parc-nota-fiscal.sequencia = 1 THEN DO:
                    FOR EACH nota-fiscal-imp OF nota-fiscal NO-LOCK
                        WHERE nota-fiscal-imp.situacao = 2 /* Retido */:
                        FIND FIRST imposto OF nota-fiscal-imp NO-LOCK NO-ERROR.
                        IF imposto.tipo = 1 /* Retido */ THEN DO:
                            FIND FIRST agenda OF nota-fiscal-imp NO-LOCK NO-ERROR.
                            CREATE tt-mov-conta.
                            ASSIGN tt-mov-conta.cd-conta      = agenda.cd-conta
                                   tt-mov-conta.cd-favorecido = agenda.cd-favorecido
                                   tt-mov-conta.cod-categoria = imposto.cod-categoria
                                   tt-mov-conta.cd-sub        = imposto.cd-sub
                                   tt-mov-conta.id-tipo       = agenda.id-tipo
                                   tt-mov-conta.de-valor      = (-1) * nota-fiscal-imp.val-imposto
                                   tt-mov-conta.cd-sequencia  = iSeq
                                   tt-mov-conta.dt-mov        = parc-nota-fiscal.dt-pagto-parc
                                   tt-mov-conta.id-situacao   = 1
                                   tt-mov-conta.nr-controle   = nota-fiscal.nr-controle
                                   tt-mov-conta.cod-imposto   = nota-fiscal-imp.cod-imposto
                                   tt-mov-conta.nr-mov        = nota-fiscal.nr-nota
                                   tt-mov-conta.ds-observacao = "PAGAMENTO DE IMPOSTO RETIDO - Controle: " + STRING(nota-fiscal.nr-controle) + " - NF-em: " + STRING(nota-fiscal.nr-nota)
                                   iSeq = iSeq + 1
                                   iNumMovtosTT = iNumMovtosTT + 1
                                   de-val-imp = de-val-imp + nota-fiscal-imp.val-imposto.
                        END.
                    END.
                END.

                CREATE tt-mov-conta.
                ASSIGN tt-mov-conta.cd-conta      = conta.cd-conta
                       tt-mov-conta.cd-favorecido = nota-fiscal.cd-favorecido
                       tt-mov-conta.cod-categoria = nota-fiscal.cod-categoria
                       tt-mov-conta.cd-sub        = nota-fiscal.cd-sub
                       tt-mov-conta.id-tipo       = 1
                       tt-mov-conta.de-valor      = parc-nota-fiscal.val-parcela + de-val-imp
                       tt-mov-conta.cd-sequencia  = iSeq
                       tt-mov-conta.dt-mov        = parc-nota-fiscal.dt-pagto-parc
                       tt-mov-conta.id-situacao   = 1
                       tt-mov-conta.nr-controle   = nota-fiscal.nr-controle
                       tt-mov-conta.sequencia     = parc-nota-fiscal.sequencia
                       tt-mov-conta.nr-mov        = nota-fiscal.nr-nota
                       tt-mov-conta.ds-observacao = "FATURAMENTO - Controle: " + STRING(nota-fiscal.nr-controle) + " - NF-em: " + STRING(nota-fiscal.nr-nota) + " PARCELA: " + STRING(parc-nota-fiscal.sequencia)
                       iSeq = iSeq + 1
                       iNumMovtosTT = iNumMovtosTT + 1.

            END.
        END.

    END.

    FOR EACH tt-mov-conta EXCLUSIVE-LOCK
        WHERE tt-mov-conta.dt-mov > {2}
        OR    tt-mov-conta.dt-mov < {1}:
        DELETE tt-mov-conta.
    END.

END PROCEDURE.

PROCEDURE prevFatPed:

    DEFINE VARIABLE de-prev-fat AS DEC.
    DEFINE BUFFER bf-pedido FOR pedido.

    FIND FIRST param-mn NO-LOCK NO-ERROR.

    FIND FIRST conta NO-LOCK
        WHERE conta.id-tipo = 1 /* Conta Corrente */
        AND   NOT conta.id-encerrada
        AND   conta.cd-moeda = 0 NO-ERROR.
    IF AVAIL conta THEN DO:

        FOR EACH pedido NO-LOCK
            WHERE pedido.dt-previsao-fat >= {1}
            AND   pedido.dt-previsao-fat <= {2}
            AND   pedido.situacao < 4 /* Faturado */:
            
            ASSIGN de-prev-fat = pedido.val-total.
            FOR EACH bf-pedido NO-LOCK
               WHERE bf-pedido.nr-pedido-ant = pedido.nr-pedido:            
                ASSIGN de-prev-fat = de-prev-fat - bf-pedido.val-total.
            END.

            CREATE tt-mov-conta.
            ASSIGN tt-mov-conta.cd-conta      = conta.cd-conta
                   tt-mov-conta.cd-favorecido = pedido.cliente-fat
                   tt-mov-conta.cod-categoria = param-mn.categoria-nf
                   tt-mov-conta.cd-sub        = param-mn.sub-nf
                   tt-mov-conta.id-tipo       = 1
                   tt-mov-conta.de-valor      = (de-prev-fat * 0.9185)
                   tt-mov-conta.cd-sequencia  = iSeq
                   tt-mov-conta.dt-mov        = pedido.dt-previsao-fat
                   tt-mov-conta.id-situacao   = 1
                   tt-mov-conta.ds-observacao = "FATURAMENTO PEDIDO: " + STRING(pedido.nr-pedido)
                   iSeq = iSeq + 1
                   iNumMovtosTT = iNumMovtosTT + 1.       
            
        END.

    END.

END PROCEDURE.

FUNCTION fnJuros RETURNS DECIMAL (deValor AS DECIMAL,
                                  tx-juro AS DECIMAL):

    DEFINE VARIABLE deReturn AS DECIMAL  NO-UNDO.

    deReturn = ((deValor * tx-juro) / 100).

    RETURN deReturn.

END FUNCTION. 

