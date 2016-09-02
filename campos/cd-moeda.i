DEFINE BUFFER bf-moeda FOR moeda.
DEFINE VARIABLE cCd-moeda AS CHARACTER COLUMN-LABEL "Moeda" FORMAT "X(20)" NO-UNDO.

FUNCTION fnListaCd-moeda RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-moeda NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-moeda.ds-moeda + "," + STRING(bf-moeda.cd-moeda).
        ELSE
            ASSIGN cLista = bf-moeda.ds-moeda + "," + STRING(bf-moeda.cd-moeda).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-moeda RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-moeda NO-LOCK
        WHERE bf-moeda.Cd-moeda = iCod NO-ERROR.
    IF AVAIL bf-moeda THEN
        RETURN bf-moeda.ds-moeda.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-moeda}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-moeda IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-moeda IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-moeda"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-moeda"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
