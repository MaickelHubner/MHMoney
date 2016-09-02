{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}

ON BELL ANYWHERE 
DO:
    IF btGoto:SENSITIVE IN FRAME {&FRAME-NAME} THEN
        APPLY "CHOOSE" TO btGoTo IN FRAME {&FRAME-NAME}.
END.

ON "CTRL-Z" ANYWHERE 
DO:
    IF btZoom:SENSITIVE IN FRAME {&FRAME-NAME} THEN
        APPLY "CHOOSE" TO btZoom IN FRAME {&FRAME-NAME}.
END.

ASSIGN iProgsCont = iProgsCont + 1.
ASSIGN hProgsMenu[iProgsCont] = C-Win:HANDLE.
