DEFINE VARIABLE cArq AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.

INPUT FROM VALUE(SEARCH("help.lst")).
REPEAT:
    IMPORT UNFORMATTED cTemp.
    IF cTemp MATCHES("*" + TRIM(ENTRY(3,CURRENT-WINDOW:TITLE,"-")) + "*") THEN DO:
        ASSIGN cArq = "manual\" + ENTRY(2,cTemp).
        LEAVE.
    END.
END.
INPUT CLOSE.
IF cArq = "" THEN DO:
    ASSIGN cArq = SEARCH("manual\index.htm").
END.

FILE-INFO:FILE-NAME = cArq.
ASSIGN cArq = FILE-INFO:FULL-PATHNAME.

assign cArq = " " + cArq.

find first param-mn NO-LOCK.

run WinExec(input param-mn.caminho-ie + cArq, input 1).

procedure WinExec external "kernel32.dll":
    define input parameter prog_name    as character.
    define input parameter visual_style as short.
end procedure.
