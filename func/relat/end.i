/* Zera progressBar */
IF NOT THIS-PROCEDURE:PERSISTENT THEN
    ASSIGN chProgressBar:VALUE = 0.

PUT UNFORMATTED "<tr>" SKIP
                "  <td vAlign=~"bottom~" width=~"800~" bgColor=~"#FFFFFF~" colSpan=~"2~" height=~"50~"></td>" SKIP
                "</tr>" SKIP
                "<tr>" SKIP
                "  <td vAlign=~"bottom~" width=~"800~" bgColor=~"#319B64~" colSpan=~"2~"><font face=~"Arial~"" SKIP
                "  color=~"#ffffff~"><small><strong>MH Money 2005 - " cVersion "</strong></small></font></td>" SKIP
                "</tr>" SKIP
                "<tr>" SKIP
                "  <td vAlign=~"bottom~" width=~"400~"><font face=~"Arial~" color=~"#319B64~"><small><strong>" CAPS(ENTRY(1,ENTRY(2,cLinhaProg," "),".")) "</strong>" SKIP
                "  - " ENTRY(3,cLinhaProg," ") " - " ENTRY(2,cLinhaProg,"%") "</small></font></td>" SKIP
                "  <td vAlign=~"bottom~" width=~"400~"><p align=~"right~"><font face=~"Arial~" color=~"#319B64~"><strong><small>" STRING(TODAY,"99/99/9999") SKIP
                "  - " v_hora "</small></strong></font></td>" SKIP
                "</tr>" SKIP
                "</TBODY>" SKIP
                "</table>" SKIP
                "</center></div>" SKIP
                "</body>" SKIP
                "</html>".

OUTPUT CLOSE.

