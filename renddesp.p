DEFINE INPUT  PARAMETER dtBase AS DATE       NO-UNDO.
DEFINE INPUT  PARAMETER iMoeda AS INTEGER      NO-UNDO.
DEFINE OUTPUT PARAMETER vl-total AS DECIMAL    NO-UNDO.

DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

{cotacao.i}

ASSIGN vl-total = 0.
FOR EACH mov-conta NO-LOCK
    WHERE dt-mov >= DATE(MONTH(dtBase),1,YEAR(dtBase))
    AND   dt-mov <= (DATE(IF MONTH(dtBase) <> 12 THEN (MONTH(dtBase) + 1) ELSE 1,
                         1,IF MONTH(dtBase) <> 12 THEN YEAR(dtBase) ELSE (YEAR(dtBase) + 1)) - 1)
    AND mov-conta.agrupado = 0
    USE-INDEX data:

    ASSIGN vl-total = vl-total + IF mov-conta.cd-moeda = iMoeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,iMoeda,mov-conta.dt-mov).

END.

RUN var_camb.p (INPUT dtBase, INPUT iMoeda, OUTPUT deAux).
ASSIGN vl-total = vl-total + deAux.
