DEFINE INPUT  PARAMETER dtBase AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER moeda AS INTEGER    NO-UNDO.
DEFINE OUTPUT PARAMETER vl-rec AS DECIMAL    NO-UNDO.
DEFINE OUTPUT PARAMETER vl-desp AS DECIMAL    NO-UNDO.

{cotacao.i}

ASSIGN vl-rec = 0
       vl-desp = 0.
FOR EACH mov-conta NO-LOCK
    WHERE dt-mov >= DATE(MONTH(dtBase),1,YEAR(dtBase))
    AND   dt-mov <= (DATE(IF MONTH(dtBase) <> 12 THEN (MONTH(dtBase) + 1) ELSE 1,
                         1,IF MONTH(dtBase) <> 12 THEN YEAR(dtBase) ELSE (YEAR(dtBase) + 1)) - 1)
    USE-INDEX data:

    FIND FIRST categoria OF mov-conta NO-LOCK NO-ERROR.

    IF AVAIL categoria THEN DO:
        IF categoria.id-tipo = 1 THEN DO:
            IF mov-conta.cd-moeda <> moeda THEN DO:
                ASSIGN vl-rec = vl-rec + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
            END.
            ELSE DO:
                ASSIGN vl-rec = vl-rec + mov-conta.de-valor.
            END.
        END.
        ELSE DO:
            IF mov-conta.cd-moeda <> moeda THEN DO:
                ASSIGN vl-desp = vl-desp + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
            END.
            ELSE DO:
                ASSIGN vl-desp = vl-desp + mov-conta.de-valor.
            END.
        END.
    END.

END.



