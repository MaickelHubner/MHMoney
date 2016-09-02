DEFINE INPUT  PARAMETER dtBase AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER moeda  AS INTEGER    NO-UNDO.
DEFINE OUTPUT PARAMETER vl-total AS DECIMAL    NO-UNDO.

{cotacao.i}

DEFINE VARIABLE vl-conta AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-passivo AS DECIMAL    NO-UNDO.

ASSIGN vl-total = 0.
FOR EACH conta NO-LOCK:

    FIND FIRST mov-conta OF conta USE-INDEX data NO-LOCK NO-ERROR.
    IF AVAIL mov-conta THEN DO:
        IF YEAR(mov-conta.dt-mov) > YEAR(dtBase) THEN 
            NEXT.
        ELSE
            IF YEAR(mov-conta.dt-mov) = YEAR(dtBase) THEN
                IF MONTH(mov-conta.dt-mov) > MONTH(dtBase) THEN
                    NEXT.
    END.
    ELSE
        NEXT.

    ASSIGN vl-conta = conta.vl-saldo-ini.
    FOR EACH mov-conta OF conta NO-LOCK
        WHERE dt-mov <= dtBase
        AND   agrupado = 0
        USE-INDEX data:

        ASSIGN vl-conta = vl-conta + mov-conta.de-valor.

    END.

    IF conta.cd-moeda <> moeda THEN DO:
        ASSIGN vl-conta = fnCotacao(vl-conta,conta.cd-moeda,moeda,dtBase).
    END.

    ASSIGN vl-total = vl-total + vl-conta.
END.

FOR EACH proj-periodo NO-LOCK
    WHERE proj-periodo.dt-ini <= dtBase
    AND   proj-periodo.dt-end >= dtBase:

    ASSIGN vl-passivo = 0.

    FOR EACH nivel-projeto NO-LOCK
        WHERE nivel-projeto.cd-projeto = proj-periodo.cd-projeto
        AND   nivel-projeto.passivo:

        FIND FIRST proj-periodo-nivel OF proj-periodo
            WHERE  proj-periodo-nivel.cd-nivel = nivel-projeto.cd-nivel NO-LOCK NO-ERROR.
        IF AVAIL proj-periodo-nivel THEN DO:
            ASSIGN vl-passivo = vl-passivo + proj-periodo-nivel.valor.
        END.

        FOR EACH mov-conta OF nivel-projeto NO-LOCK
            WHERE mov-conta.dt-mov <= dtBase:
            ASSIGN vl-passivo = vl-passivo + mov-conta.de-valor.
        END.

    END.

    ASSIGN vl-passivo = fnCotacao(vl-passivo,0,moeda,dtBase).

    ASSIGN vl-total = vl-total - vl-passivo.

END.

