/* Prot¢tipo da Fun‡Æo Mestre */
FUNCTION fnLista{&OBJETO} RETURNS CHARACTER
 ( /* parameter-definitions */ )  FORWARD.

{func\cursor.i {&OBJETO} 2}
	
ASSIGN {&OBJETO}:READ-ONLY IN FRAME {&FRAME} = YES
       {&OBJETO}:TAB-STOP IN FRAME {&FRAME} = NO.

/* Triggers do Objeto */
ON ENTRY OF {&OBJETO} IN FRAME {&FRAME}
DO: 
    {func\set_entry.i}
    ASSIGN SELF:TAB-STOP = YES.
    IF whNextTabItem = ? THEN
        ASSIGN whNextTabItem = {&ObjPai}:NEXT-TAB-ITEM.
    {&OBJETO}:MOVE-BEFORE-TAB-ITEM(sl-consulta:HANDLE).
    IF NOT lTab THEN DO:
        ENABLE {&ObjPai} WITH FRAME {&FRAME}.
        ASSIGN {&ObjPai}:READ-ONLY IN FRAME {&FRAME} = YES.
        {&ObjPai}:MOVE-AFTER-TAB-ITEM({&OBJETO}:HANDLE).
    END.
END.
ON TAB OF {&OBJETO} IN FRAME {&FRAME}
DO: 
    IF NOT sl-consulta:HIDDEN THEN
        ASSIGN lTab = YES.
END.
ON RETURN OF {&OBJETO} IN FRAME {&FRAME}
DO: 
    APPLY "MOUSE-SELECT-DBLCLICK" TO sl-consulta.
    ASSIGN sl-consulta:HIDDEN = YES.
END.
ON MOUSE-SELECT-DBLCLICK OF {&OBJETO} IN FRAME {&FRAME}
DO: 
    ASSIGN SELF:READ-ONLY = NO.
    DISABLE {&ObjPai} WITH FRAME {&FRAME}.
    SELF:SET-SELECTION(1, LENGTH(SELF:SCREEN-VALUE IN FRAME {&FRAME}) + 1).
END.
ON BACKSPACE OF {&OBJETO} IN FRAME {&FRAME}
DO: 
    ASSIGN lBack = YES.
END.
ON DELETE-CHARACTER OF {&OBJETO} IN FRAME {&FRAME}
DO:
    ASSIGN lBack = YES.
END.
ON LEAVE OF {&OBJETO} IN FRAME {&FRAME}
DO:  
    {func\set_leave.i}  
    IF NOT lTab THEN DO:
        ASSIGN sl-consulta:HIDDEN = YES.
        RUN leaveObject IN THIS-PROCEDURE (INPUT SELF:NAME) NO-ERROR.
        ASSIGN SELF:TAB-STOP = NO.
        ASSIGN SELF:READ-ONLY = YES.
        ASSIGN {&ObjPai}:READ-ONLY IN FRAME {&FRAME} = NO.
        {&ObjPai}:MOVE-BEFORE-TAB-ITEM(whNextTabItem:HANDLE).
        ASSIGN whNextTabItem = ?.
        APPLY "ENTRY" TO {&ObjPai} IN FRAME {&FRAME}.
    END.
    ELSE DO:
        APPLY "ENTRY" TO sl-consulta.
        ASSIGN lTab = NO.
    END.
END.
ON VALUE-CHANGED OF {&OBJETO} IN FRAME {&FRAME} /* Fill 1 */
DO:
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO INITIAL 0.
    DEFINE VARIABLE iTotalSel AS INTEGER    NO-UNDO INITIAL 0.
    DEFINE VARIABLE cNovaLista AS CHARACTER  NO-UNDO INITIAL "".
    DEFINE VARIABLE deTamLista AS DECIMAL    NO-UNDO INITIAL 3.5.

    IF SELF:SCREEN-VALUE IN FRAME {&FRAME} <> "" THEN DO:

        ASSIGN cNovaLista = fnLista{&OBJETO}()
               hWidget = SELF.
        ASSIGN iTotalSel = NUM-ENTRIES(cNovaLista).

        IF iTotalSel < 5 THEN DO:
            ASSIGN deTamLista = ((SELF:HEIGHT * 0.7) * iTotalSel) + 0.1.
        END.
        ELSE DO:
            ASSIGN deTamLista = 3.5.
        END.

        /* Para corrigir erro de posicionamento na frame */
        ASSIGN sl-consulta:HEIGHT = 0.1.

        IF iTotalSel = 1 THEN DO:
            IF NOT lBack THEN DO:
                ASSIGN iCont = SELF:CURSOR-OFFSET
                       SELF:SCREEN-VALUE IN FRAME {&FRAME} = cNovaLista
                       SELF:CURSOR-OFFSET = iCont.
                SELF:SET-SELECTION(iCont, LENGTH(cNovaLista) + 1).
            END.
        END.
        ASSIGN lBack = NO.

        IF (SELF:ROW IN FRAME {&FRAME} - deTamLista) > 1.24 THEN
            ASSIGN sl-consulta:ROW = SELF:ROW IN FRAME {&FRAME} - deTamLista.
        ELSE
            ASSIGN sl-consulta:ROW = SELF:ROW IN FRAME {&FRAME} + SELF:HEIGHT IN FRAME {&FRAME}.

        ASSIGN sl-consulta:COL = SELF:FRAME-COL IN FRAME {&FRAME}
               sl-consulta:WIDTH = SELF:WIDTH IN FRAME {&FRAME}
               sl-consulta:HEIGHT = deTamLista
               sl-consulta:LIST-ITEMS = cNovaLista
               sl-consulta:SCREEN-VALUE = ENTRY(1,cNovaLista)
               sl-consulta:HIDDEN = NO.

    END.
    ELSE DO:
        ASSIGN sl-consulta:HIDDEN = YES
               hWidget = ?.
    END.
END.

/* Fun‡Æo Mestre */
FUNCTION fnLista{&OBJETO} RETURNS CHARACTER
  (  ) :

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH {&FOREACH}:

        IF NOT {&CAMPO} MATCHES({&OBJETO}:SCREEN-VALUE IN FRAME {&FRAME} + "*") THEN NEXT.

        IF cLista = "" THEN
            ASSIGN cLista = {&CAMPO}.
        ELSE
            ASSIGN cLista = cLista + "," + {&CAMPO}.

    END.

    RETURN cLista.

END FUNCTION.
