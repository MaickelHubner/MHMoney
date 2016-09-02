DEFINE INPUT  PARAMETER iBem AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER moeda AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER data AS DATE       NO-UNDO.
DEFINE OUTPUT PARAMETER deValor AS DECIMAL    NO-UNDO.

{cotacao.i}

FIND FIRST bens WHERE bens.cd-bens = iBem NO-LOCK NO-ERROR.
IF AVAIL bens THEN DO:

    ASSIGN deValor = bens.vl-venda.
    FOR EACH mov-bens OF bens
        WHERE mov-bens.id-tipo = 6 NO-LOCK:
        FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
        IF AVAIL mov-conta THEN
          ASSIGN deValor = deValor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,bens.cd-moeda,mov-conta.dt-mov).
    END.

    IF bens.cd-moeda <> moeda THEN
        ASSIGN deValor = fnCotacao(deValor,bens.cd-moeda,moeda,data).

END.
