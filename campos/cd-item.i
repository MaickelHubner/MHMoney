DEFINE BUFFER bf-item FOR item.
DEFINE VARIABLE cCd-item AS CHARACTER COLUMN-LABEL "Item" FORMAT "X(40)" NO-UNDO.
DEFINE VARIABLE cUnidade AS CHARACTER COLUMN-LABEL "Un" FORMAT "X(4)" NO-UNDO.

FUNCTION fnListaCd-item RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-item NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-item.ds-item + "," + STRING(bf-item.cd-item).
        ELSE
            ASSIGN cLista = bf-item.ds-item + "," + STRING(bf-item.cd-item).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-item RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-item NO-LOCK
        WHERE bf-item.Cd-item = iCod NO-ERROR.
    IF AVAIL bf-item THEN
        RETURN bf-item.ds-item.
    ELSE
        RETURN "".

END.

FUNCTION fnUnidade RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-item NO-LOCK
        WHERE bf-item.Cd-item = iCod NO-ERROR.
    IF AVAIL bf-item THEN
        RETURN bf-item.unidade.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-item}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-item IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-item IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-item"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-item"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
