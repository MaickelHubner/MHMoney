/* Vari veis de controle */
DEFINE VARIABLE lBack AS LOGICAL    NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE sl-consulta  AS WIDGET-HANDLE.
DEFINE VARIABLE lTab AS LOGICAL    NO-UNDO.
DEFINE VARIABLE whNextTabItem AS WIDGET-HANDLE     NO-UNDO.

/* Listagem dos dados */
CREATE SELECTION-LIST sl-consulta
    ASSIGN ROW                  = 3
          COLUMN               = 5
           FRAME                = FRAME {&FRAME}:HANDLE
           SENSITIVE            = TRUE
          VISIBLE              = FALSE
           SCROLLBAR-VERTICAL   = TRUE
           TRIGGERS:
                ON MOUSE-SELECT-DBLCLICK
                DO:  
                    ASSIGN hWidget:SCREEN-VALUE = sl-consulta:SCREEN-VALUE
                           sl-consulta:HIDDEN = YES.
                    APPLY "LEAVE" TO hWidget.
                    ASSIGN hWidget = ?.
                END.
                ON RETURN
                DO:
                    ASSIGN hWidget:SCREEN-VALUE = sl-consulta:SCREEN-VALUE
                        sl-consulta:HIDDEN = YES.
                    APPLY "LEAVE" TO hWidget.
                    ASSIGN hWidget = ?.
                END.
                ON ENTRY 
                DO:
                    ASSIGN sl-consulta:HIDDEN = NO.
                    ASSIGN hWidget:SCREEN-VALUE = sl-consulta:SCREEN-VALUE.
                    sl-consulta:MOVE-BEFORE-TAB-ITEM(hWidget).
                END.
                ON LEAVE
                DO:
                    ASSIGN sl-consulta:HIDDEN = YES.
                END.
                ON VALUE-CHANGED
                DO:
                    ASSIGN hWidget:SCREEN-VALUE = sl-consulta:SCREEN-VALUE.
                END.
           END TRIGGERS.

