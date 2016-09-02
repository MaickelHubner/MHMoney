DEFINE INPUT  PARAMETER dtIni AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER dtEnd AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER moeda AS INTEGER    NO-UNDO.
DEFINE OUTPUT PARAMETER vl-total AS DECIMAL    NO-UNDO.

{cotacao.i}

ASSIGN vl-total = 0.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= dtIni
    AND   mov-conta.dt-mov <= dtEnd
    USE-INDEX data:

    FIND FIRST categoria OF mov-conta NO-LOCK NO-ERROR.
    IF AVAIL categoria THEN DO:
        IF categoria.id-tipo = 2 THEN DO:
            FIND FIRST sub-cat OF mov-conta NO-LOCK NO-ERROR.
            IF AVAIL sub-cat THEN DO:
                IF sub-cat.id-tipo = 2 THEN DO:
                    IF mov-conta.cd-moeda = moeda THEN
                        ASSIGN vl-total = vl-total + mov-conta.de-valor.
                    ELSE
                        ASSIGN vl-total = vl-total + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
                END.
            END.
        END.
    END.

END.
