DEFINE INPUT  PARAMETER rNota AS ROWID       NO-UNDO.

FIND FIRST nota-fiscal EXCLUSIVE-LOCK
    WHERE ROWID(nota-fiscal) = rNota NO-ERROR.
IF NOT AVAIL nota-fiscal THEN
    RETURN "NOK".

IF CAN-FIND(FIRST nota-fiscal-imp OF nota-fiscal
            WHERE nota-fiscal-imp.situacao = 3 /* Pago */) THEN
    RETURN "NOK".

IF nota-fiscal.tipo = 2 /* Recibo */ THEN
    RETURN "NOK".

ASSIGN nota-fiscal.val-imposto = 0
       nota-fiscal.val-liquido = 0.

FOR EACH nota-fiscal-imp OF nota-fiscal EXCLUSIVE-LOCK:
    DELETE nota-fiscal-imp.
END.

FOR EACH imposto NO-LOCK
    WHERE imposto.dt-val-ini <= nota-fiscal.dt-emissao
    AND   imposto.dt-val-fim >= nota-fiscal.dt-emissao
    AND   imposto.val-nf-min <= nota-fiscal.val-total
    AND   imposto.val-nf-max >= nota-fiscal.val-total:

    IF imposto.tipo-retencao <> 0 /* Geral */ THEN DO:
        FIND FIRST param-mn NO-LOCK NO-ERROR.
        FIND FIRST favorecido OF nota-fiscal NO-LOCK NO-ERROR.
        CASE imposto.tipo-retencao:
            WHEN 1 /* Municipal */ THEN DO:
                IF favorecido.cidade <> param-mn.cidade THEN NEXT.
            END.
            WHEN 2 /* Fora do Munic¡pio */ THEN DO:
                IF favorecido.cidade = param-mn.cidade THEN NEXT.
            END.
        END CASE.
    END.

    CREATE nota-fiscal-imp.
    ASSIGN nota-fiscal-imp.nr-controle = nota-fiscal.nr-controle
           nota-fiscal-imp.cod-imposto = imposto.cod-imposto
           nota-fiscal-imp.situacao = 1 /* Pendente */
           nota-fiscal-imp.cd-agenda = imposto.cd-agenda
           nota-fiscal-imp.val-imposto = ((nota-fiscal.val-total * imposto.pc-imposto) / 100).

    IF imposto.tipo = 1 /* Retido */ THEN
        ASSIGN nota-fiscal.val-imposto = nota-fiscal.val-imposto + nota-fiscal-imp.val-imposto
               nota-fiscal-imp.situacao = 2 /* Retido */.

END.

ASSIGN nota-fiscal.val-liquido = nota-fiscal.val-total - nota-fiscal.val-imposto.

RETURN "OK".
