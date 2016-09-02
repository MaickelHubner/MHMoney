DEFINE BUFFER bf-categoria FOR categoria.
DEFINE VARIABLE cCod-categoria AS CHARACTER COLUMN-LABEL "Categoria" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCod-categoria RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-categoria NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-categoria.ds-categoria + "," + STRING(bf-categoria.cod-categoria).
        ELSE
            ASSIGN cLista = bf-categoria.ds-categoria + "," + STRING(bf-categoria.cod-categoria).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCod-categoria RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-categoria NO-LOCK
        WHERE bf-categoria.cod-categoria = iCod NO-ERROR.
    IF AVAIL bf-categoria THEN
        RETURN bf-categoria.ds-categoria.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i cod-categoria}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.cod-categoria IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.cod-categoria IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="cod-categoria"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-categoria"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
