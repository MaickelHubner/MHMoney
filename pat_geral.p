DEFINE INPUT  PARAMETER dtBase AS DATE        NO-UNDO.
DEFINE INPUT  PARAMETER moeda  AS INTEGER     NO-UNDO.
DEFINE OUTPUT PARAMETER vl-pat AS DECIMAL     NO-UNDO.

{func\data.i}

DEFINE VARIABLE deTemp AS DECIMAL     NO-UNDO.

/* Bens */
FOR EACH bens
    WHERE (bens.dt-venda > fnUltimoDia(MONTH(dtBase), YEAR(dtBase)) OR bens.dt-venda = ?)
    AND   bens.bem-pai = 0:
    RUN valorbem.p(INPUT bens.cd-bens,INPUT dtBase, INPUT moeda, OUTPUT deTemp).
    ASSIGN vl-pat = vl-pat + deTemp.
END.

/* Financeiro */
RUN patrimon-tot.p (INPUT dtBase, INPUT moeda, OUTPUT deTemp).
ASSIGN vl-pat = vl-pat + deTemp.

RETURN "OK".
