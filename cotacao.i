DEFINE BUFFER bf-cotacao-func FOR cotacao.
FUNCTION fnCotacao RETURNS DECIMAL (deValor AS DECIMAL,
                                    iMoeda-de AS INTEGER,
                                    iMoeda-para AS INTEGER,
                                    dtMov AS DATE):

    DEFINE VARIABLE deReturn AS DECIMAL  NO-UNDO.

    FIND FIRST bf-cotacao-func NO-LOCK
        WHERE bf-cotacao-func.cd-moeda = iMoeda-de
        AND   bf-cotacao-func.dt-ini <= dtMov
        AND   bf-cotacao-func.dt-end >= dtMov NO-ERROR.
    IF AVAIL bf-cotacao-func THEN DO:
        ASSIGN deReturn = deValor * bf-cotacao-func.valor.
        IF iMoeda-para <> 0 THEN DO:
            ASSIGN deReturn = fnCotacao(deReturn,0,iMoeda-para,dtMov).
        END.
    END.
    ELSE DO:
        FIND FIRST bf-cotacao-func NO-LOCK
            WHERE bf-cotacao-func.cd-moeda = iMoeda-para
            AND   bf-cotacao-func.dt-ini <= dtMov
            AND   bf-cotacao-func.dt-end >= dtMov NO-ERROR.
        IF AVAIL bf-cotacao-func THEN DO:
            ASSIGN deReturn = deValor / bf-cotacao-func.valor.
        END.
        ELSE DO:
            ASSIGN deReturn = deValor.
        END.
    END.

    RETURN deReturn.

END FUNCTION. 
