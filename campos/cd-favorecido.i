DEFINE BUFFER bf-favorecido FOR favorecido.
DEFINE VARIABLE cCd-favorecido AS CHARACTER COLUMN-LABEL "Favorecido" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-favorecido RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-favorecido NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-favorecido.ds-favorecido + "," + STRING(bf-favorecido.cd-favorecido).
        ELSE
            ASSIGN cLista = bf-favorecido.ds-favorecido + "," + STRING(bf-favorecido.cd-favorecido).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-favorecido RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-favorecido NO-LOCK
        WHERE bf-favorecido.Cd-favorecido = iCod NO-ERROR.
    IF AVAIL bf-favorecido THEN
        RETURN bf-favorecido.ds-favorecido.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-favorecido}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-favorecido IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-favorecido IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-favorecido"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-favorecido"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
