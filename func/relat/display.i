DEFINE VARIABLE h_frame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE cCampoProc AS CHARACTER  NO-UNDO.
DEFINE VARIABLE hFrame AS HANDLE     NO-UNDO.

DISPLAY {&FrameFields} WITH FRAME {&FRAME-NAME}.

IF cParamRelat <> "" THEN DO:

    ASSIGN hFrame = FRAME {&FRAME-NAME}:HANDLE.

    REPEAT iCont = 1 TO NUM-ENTRIES(cParamRelat):
        ASSIGN cCampoProc = ENTRY(iCont,cParamRelat).

        ASSIGN h_Frame = hFrame:FIRST-CHILD. /* pegando o Field-Group */
        ASSIGN h_Frame = h_Frame:FIRST-CHILD.       /* pegando o 1o. Campo */
        DO WHILE h_Frame <> ?:
            IF h_frame:TYPE <> "field-group" THEN DO:  
                IF h_Frame:NAME = ENTRY(1,cCampoProc,"=") THEN DO :
                    ASSIGN h_Frame:SCREEN-VALUE = ENTRY(2,cCampoProc,"=").
                    APPLY "VALUE-CHANGED" TO h_Frame.
                    LEAVE.
                END.
                ASSIGN h_Frame = h_Frame:NEXT-SIBLING.
            END. 
            ELSE DO:
                ASSIGN h_frame = h_frame:FIRST-CHILD.
            END.    
        END.

    END.

END.

