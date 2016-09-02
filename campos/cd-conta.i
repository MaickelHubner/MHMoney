DEFINE BUFFER bf-conta FOR conta.
DEFINE VARIABLE cCd-conta AS CHARACTER COLUMN-LABEL "Conta" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-conta RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-conta NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-conta.ds-conta + "," + STRING(bf-conta.cd-conta).
        ELSE
            ASSIGN cLista = bf-conta.ds-conta + "," + STRING(bf-conta.cd-conta).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-conta RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-conta NO-LOCK
        WHERE bf-conta.Cd-conta = iCod NO-ERROR.
    IF AVAIL bf-conta THEN
        RETURN bf-conta.ds-conta.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-conta}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-conta IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-conta IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-conta"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-conta"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
