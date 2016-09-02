INPUT FROM VALUE(SEARCH("version")) CONVERT TARGET "ibm850".
REPEAT:
    IMPORT UNFORMATTED cVrsTmp.
    IF cVrsTmp MATCHES("*[PRODUTO]*") THEN DO:
        ASSIGN cVersion = ENTRY(2,cVrsTmp," ").
    END.
    IF ENTRY(1,ENTRY(2,cVrsTmp," "),".") = cProgRelat THEN DO:
        ASSIGN cLinhaProg = cVrsTmp.
    END.
END.
INPUT CLOSE.

ASSIGN v_hora = STRING(TIME,"HH:MM:SS").

{func\relat\ini-prg-bar.i {1}}

OUTPUT TO VALUE("temp\" + cProgRelat + ".htm") CONVERT TARGET "iso8859-1".

PUT UNFORMATTED "<html>" SKIP(1)
                "<head>" SKIP
                "<title>" CURRENT-WINDOW:TITLE "</title>" SKIP
                "</head>" SKIP(1)
                "<body>" SKIP
                "<div align=~"center~"><center>" SKIP(1)
                "<table width=~"800~" border=~"0~">" SKIP
                "<TBODY>" SKIP
                "  <tr>" SKIP
                "    <td width=~"800~" bgColor=~"#319B64~" colSpan=~"2~" height=~"150~"><p align=~"center~"><font" SKIP
                "    face=~"Arial~" color=~"#ffffff~"><big><big>" &IF "{2}" = "" &THEN TRIM(ENTRY(1,CURRENT-WINDOW:TITLE,"-")) &ELSE {2} &ENDIF "</big></big></font></td>" SKIP
                "  </tr>" SKIP.
