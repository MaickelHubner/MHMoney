
DEFINE BUFFER bf-caracteristica FOR caracteristica.
DEFINE VARIABLE cCd-caracteristica AS CHARACTER COLUMN-LABEL "Caracter¡stica" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-caracteristica RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-caracteristica NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-caracteristica.ds-caracteristica + "," + STRING(bf-caracteristica.cd-caracteristica).
        ELSE
            ASSIGN cLista = bf-caracteristica.ds-caracteristica + "," + STRING(bf-caracteristica.cd-caracteristica).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-caracteristica RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-caracteristica NO-LOCK
        WHERE bf-caracteristica.Cd-caracteristica = iCod NO-ERROR.
    IF AVAIL bf-caracteristica THEN
        RETURN bf-caracteristica.ds-caracteristica.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cd-caracteristica}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cd-caracteristica IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cd-caracteristica IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cd-caracteristica"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-caracteristica"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF

