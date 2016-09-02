DEFINE BUFFER bf-sub-cat FOR sub-cat.
DEFINE VARIABLE cCd-sub AS CHARACTER COLUMN-LABEL "Sub-Categoria" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-sub RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-sub-cat NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-sub-cat.ds-sub + "," + STRING(bf-sub-cat.Cd-sub).
        ELSE
            ASSIGN cLista = bf-sub-cat.ds-sub + "," + STRING(bf-sub-cat.Cd-sub).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-sub RETURNS CHARACTER
    (INPUT iCod AS INTEGER, INPUT iCat AS INTEGER):

    FIND FIRST bf-sub-cat NO-LOCK
        WHERE bf-sub-cat.Cd-sub = iCod
        AND   bf-sub-cat.cod-categoria = iCat NO-ERROR.
    IF AVAIL bf-sub-cat THEN
        RETURN bf-sub-cat.ds-sub.
    ELSE
        RETURN "".

END.

&IF DEFINED(Tela1) <> 0 &THEN

{func\cursor.i Cd-sub}

ON 'MOUSE-SELECT-DBLCLICK':U OF {&Table}.Cd-sub IN FRAME {&FRAME-NAME}
OR F5 OF {&Table}.Cd-sub IN FRAME {&FRAME-NAME}
DO:
    {func\zoom.i &Tabela="{&Table}"
                 &Campo1="Cd-sub"
                 &Tela1="{&Tela1}"
&IF DEFINED(Tela2) <> 0 &THEN
                 &Campo2="ds-sub"
                 &Tela2="{&Tela2}"
&ENDIF
                 }
END.

&ENDIF
