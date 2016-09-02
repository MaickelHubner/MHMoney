FUNCTION fnIR RETURNS DECIMAL (deValor AS DECIMAL,
                               dtMov AS DATE):

    DEFINE VARIABLE deReturn AS DECIMAL  NO-UNDO.

    FIND FIRST tabela-ir NO-LOCK
        WHERE tabela-ir.dt-ini <= dtMov
        AND   tabela-ir.dt-end >= dtMov NO-ERROR.
    IF NOT AVAIL tabela-ir THEN 
        RETURN 0.0.

    FIND FIRST tabela-ir-faixa OF tabela-ir NO-LOCK
        WHERE tabela-ir-faixa.val-ini <= deValor
        AND   tabela-ir-faixa.val-end >= deValor NO-ERROR.
    IF NOT AVAIL tabela-ir-faixa THEN
        RETURN 0.0.

    ASSIGN deReturn = (((tabela-ir-faixa.pc-ir / 100) * deValor) - tabela-ir-faixa.val-abate).

    RETURN deReturn.

END FUNCTION. 
