DEFINE INPUT  PARAMETER dtBase  AS DATE        NO-UNDO.
DEFINE INPUT  PARAMETER moeda   AS INTEGER     NO-UNDO.
DEFINE OUTPUT PARAMETER vl-varc AS DECIMAL     NO-UNDO.

{cotacao.i}
{func\data.i}

ASSIGN vl-varc = 0.

DEFINE VARIABLE deSaldo AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deDesc AS DECIMAL     NO-UNDO.

IF CAN-FIND(FIRST conta
            WHERE conta.cd-moeda <> 0) THEN DO:

    FOR EACH conta NO-LOCK
        WHERE conta.cd-moeda <> 0
        BY conta.ds-conta:

        ASSIGN deSaldo = conta.vl-saldo-ini.
        FOR EACH mov-conta OF conta NO-LOCK
            WHERE mov-conta.dt-mov < DATE(MONTH(dtBase),1,YEAR(dtBase))
            AND   mov-conta.id-tipo <> 0:
            ASSIGN deSaldo = deSaldo + mov-conta.de-valor.
        END.

        ASSIGN deAux = (-1) * fnCotacao(deSaldo,conta.cd-moeda,moeda,(DATE(MONTH(dtBase),1,YEAR(dtBase)) - 1))
               deDesc = 0.

        FOR EACH mov-conta OF conta NO-LOCK
            WHERE mov-conta.dt-mov >= DATE(MONTH(dtBase),1,YEAR(dtBase))
            AND   mov-conta.dt-mov <= fnUltimoDia(MONTH(dtBase), YEAR(dtBase))
            AND   mov-conta.id-tipo <> 0:
            ASSIGN deSaldo = deSaldo + mov-conta.de-valor
                   deDesc = deDesc + fnCotacao(mov-conta.de-valor,conta.cd-moeda,moeda,mov-conta.dt-mov).
        END.
        ASSIGN deAux = deAux + fnCotacao(deSaldo,conta.cd-moeda,moeda,fnUltimoDia(MONTH(dtBase), YEAR(dtBase))) - deDesc.

        ASSIGN vl-varc = vl-varc + deAux.

    END.

END.

RETURN "OK".
