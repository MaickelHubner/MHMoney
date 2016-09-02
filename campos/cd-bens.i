DEFINE BUFFER bf-bens FOR bens.
DEFINE VARIABLE cCd-bens AS CHARACTER COLUMN-LABEL "Bem" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-bens RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-bens NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-bens.ds-bens + "," + STRING(bf-bens.cd-bens).
        ELSE
            ASSIGN cLista = bf-bens.ds-bens + "," + STRING(bf-bens.cd-bens).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-bens RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-bens NO-LOCK
        WHERE bf-bens.Cd-bens = iCod NO-ERROR.
    IF AVAIL bf-bens THEN
        RETURN bf-bens.ds-bens.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-bens}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-bens IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-bens IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-bens"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-bens"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
