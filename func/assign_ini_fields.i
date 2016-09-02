DEFINE VARIABLE hFrame AS HANDLE     NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE cCampoProc AS CHARACTER  NO-UNDO.
DEFINE VARIABLE h_Frame AS HANDLE     NO-UNDO.

IF {1} <> "" THEN DO:

    ASSIGN hFrame = FRAME {&FRAME-NAME}:HANDLE.

    REPEAT iCont = 1 TO NUM-ENTRIES({1}):
        ASSIGN cCampoProc = ENTRY(iCont,{1}).

        ASSIGN h_Frame = hFrame:FIRST-CHILD. /* pegando o Field-Group */
        ASSIGN h_Frame = h_Frame:FIRST-CHILD.       /* pegando o 1o. Campo */
        DO WHILE h_Frame <> ?:
            IF h_frame:TYPE <> "field-group" THEN DO:  
                IF h_Frame:NAME = ENTRY(1,cCampoProc,"=") THEN DO :
                    IF h_frame:DATA-TYPE <> "DECIMAL" THEN
                        ASSIGN h_Frame:SCREEN-VALUE = ENTRY(2,cCampoProc,"=").
                    ELSE
                        ASSIGN h_Frame:SCREEN-VALUE = REPLACE(ENTRY(2,cCampoProc,"="),".",",").
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
