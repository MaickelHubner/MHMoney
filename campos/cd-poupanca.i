DEFINE BUFFER bf-poupanca FOR poupanca.
DEFINE VARIABLE cCd-poupanca AS CHARACTER COLUMN-LABEL "Poupanca" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-poupanca RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-poupanca NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-poupanca.ds-poupanca + "," + STRING(bf-poupanca.cd-poupanca).
        ELSE
            ASSIGN cLista = bf-poupanca.ds-poupanca + "," + STRING(bf-poupanca.cd-poupanca).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-poupanca RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-poupanca NO-LOCK
        WHERE bf-poupanca.Cd-poupanca = iCod NO-ERROR.
    IF AVAIL bf-poupanca THEN
        RETURN bf-poupanca.ds-poupanca.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-poupanca}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-poupanca IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-poupanca IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-poupanca"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-poupanca"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
