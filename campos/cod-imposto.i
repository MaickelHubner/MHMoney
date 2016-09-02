DEFINE BUFFER bf-imposto FOR imposto.
DEFINE VARIABLE ccod-imposto AS CHARACTER COLUMN-LABEL "Imposto" FORMAT "X(20)" NO-UNDO.

FUNCTION fnListaCod-imposto RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-imposto NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-imposto.ds-imposto + "," + STRING(bf-imposto.cod-imposto).
        ELSE
            ASSIGN cLista = bf-imposto.ds-imposto + "," + STRING(bf-imposto.cod-imposto).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCod-imposto RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-imposto NO-LOCK
        WHERE bf-imposto.cod-imposto = iCod NO-ERROR.
    IF AVAIL bf-imposto THEN
        RETURN bf-imposto.ds-imposto.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cod-imposto}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cod-imposto IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cod-imposto IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cod-imposto"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-imposto"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
