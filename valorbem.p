DEFINE INPUT  PARAMETER iBem AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER dtBase AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER moeda AS INTEGER    NO-UNDO.
DEFINE OUTPUT PARAMETER deValor AS DECIMAL    NO-UNDO.

DEFINE VARIABLE deAgreg AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deAquisMo AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deAquis AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deDepre AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE vl-mes AS DECIMAL    NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

{cotacao.i}

DEFINE BUFFER bfBens FOR bens.

FIND FIRST bens WHERE bens.cd-bens = iBem NO-LOCK NO-ERROR.
IF AVAIL bens THEN DO:

    /* Ainda nÆo foi comprado nessa data */
    IF bens.dt-aquisicao > dtBase THEN RETURN.

    /* Foi vendido antes dessa data */
    IF bens.dt-venda <> ? THEN
        IF bens.dt-venda < dtBase THEN ASSIGN dtBase = bens.dt-venda.

    /* Aquisi‡Æo */
    /*ASSIGN deAquis = fnCotacao(bens.vl-aquis, bens.cd-moeda, moeda, bens.dt-aquis).*/
    ASSIGN deAquisMo = bens.vl-aquis.
    FOR EACH mov-bens OF bens
        WHERE mov-bens.id-tipo = 1 NO-LOCK:
        FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
        IF AVAIL mov-conta THEN
                ASSIGN deAquisMo = deAquisMo + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,bens.cd-moeda,mov-conta.dt-mov)).
                /*ASSIGN deAquis = deAquis + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov)).*/
    END.
    FOR EACH bfBens
        WHERE bfBens.bem-venda = bens.cd-bens NO-LOCK:

        /*RUN vendabem.p (INPUT bfBens.cd-bens, INPUT moeda, INPUT bfBens.dt-venda, OUTPUT deTemp).*/
        RUN vendabem.p (INPUT bfBens.cd-bens, INPUT bens.cd-moeda, INPUT bfBens.dt-venda, OUTPUT deTemp).
        ASSIGN deAquisMo = deAquisMo + deTemp.

    END.
    ASSIGN deAquis = fnCotacao(deAquisMo, bens.cd-moeda, moeda, dtBase).

    /* Valor Agregado */
    ASSIGN deAgreg = 0.
    FOR EACH mov-bens OF bens
        WHERE mov-bens.id-tipo = 2 NO-LOCK:
        FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
        IF AVAIL mov-conta THEN DO:
            /* Deprecia‡Æo do Valor Agregado */
            ASSIGN deDepre = 0
                   vl-mes = ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov)).
            REPEAT iCont = 1 TO ((dtBase - mov-conta.dt-mov) / 30):
                ASSIGN deDepre = (bens.pc-depreciacao * vl-mes) / 100
                       vl-mes = vl-mes - deDepre.
            END.
            ASSIGN deAgreg = deAgreg + vl-mes.
        END.
    END.
    FOR EACH bfBens
        WHERE bfBens.bem-pai = bens.cd-bens
        AND   bfBens.dt-aquisicao <= dtBase NO-LOCK:

        IF bfBens.dt-venda <> ? AND bens.dt-venda = ? THEN 
            IF NOT bens.grupo THEN
                NEXT.
            ELSE DO:
                IF bfBens.dt-venda <= dtBase THEN NEXT.
            END.

        RUN valorbem.p (INPUT bfbens.cd-bens, INPUT dtBase, INPUT moeda, OUTPUT deTemp).
        ASSIGN deAgreg = deAgreg + deTemp.

    END.

    /* Deprecia‡Æo */
    ASSIGN iMes = (dtBase - bens.dt-aquisicao) / 30
           vl-mes = deAquisMo
           deDepre = 0.

    REPEAT iCont = 1 TO iMes:
        ASSIGN deDepre = deDepre + (bens.pc-depreciacao * vl-mes) / 100
               vl-mes = deAquisMo - deDepre.
    END.

    ASSIGN deValor = deAquis + deAgreg - fnCotacao(deDepre,bens.cd-moeda,moeda,dtBase).

END.
