DEFINE INPUT  PARAMETER iConta AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER data AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER moeda AS INTEGER    NO-UNDO.
DEFINE OUTPUT PARAMETER vl-total AS DECIMAL    NO-UNDO.

{cotacao.i}

FIND FIRST conta NO-LOCK
    WHERE conta.cd-conta = iConta NO-ERROR.
IF NOT AVAIL conta THEN RETURN "NOK".

FIND FIRST mov-conta OF conta USE-INDEX data NO-LOCK NO-ERROR.
IF AVAIL mov-conta THEN DO:
    IF YEAR(mov-conta.dt-mov) > YEAR(data) THEN 
        NEXT.
    ELSE
        IF YEAR(mov-conta.dt-mov) = YEAR(data) THEN
            IF MONTH(mov-conta.dt-mov) > MONTH(data) THEN
                NEXT.
END.
ELSE
    NEXT.

FIND FIRST mov-conta OF conta
    WHERE dt-mov <= data
    USE-INDEX data NO-LOCK NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN vl-total = conta.vl-saldo-ini.
ELSE
    NEXT.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE dt-mov <= data
    AND agrupado = 0
    USE-INDEX data:

    ASSIGN vl-total = vl-total + mov-conta.de-valor.

END.

IF conta.cd-moeda <> moeda THEN DO:
    ASSIGN vl-total = fnCotacao(vl-total,conta.cd-moeda,moeda,data).
END.

RETURN "OK".
