ON MOUSE-SELECT-DBLCLICK OF brZoom IN FRAME DEFAULT-FRAME
DO:  
    APPLY "CHOOSE":U TO btOK IN FRAME {&FRAME-NAME}.
END.

ON RETURN OF brZoom IN FRAME DEFAULT-FRAME
DO:
    APPLY "CHOOSE":U TO btOK IN FRAME {&FRAME-NAME}.
END.

ON START-SEARCH OF brZoom IN FRAME DEFAULT-FRAME
DO:
    RUN openQuery IN THIS-PROCEDURE.
END.

ASSIGN iProgsCont = iProgsCont + 1.
ASSIGN hProgsMenu[iProgsCont] = C-Win:HANDLE.
