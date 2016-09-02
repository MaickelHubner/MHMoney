&IF ("{2}" = "1" OR "{2}" = "") &THEN
    {1}:LOAD-MOUSE-POINTER("image\lupa.cur") {3}.
    IF {1}:TOOLTIP {3} = ""
    OR {1}:TOOLTIP {3} = ? THEN
        ASSIGN {1}:TOOLTIP {3} = "Clique duas vezes para abrir o zoom.".
&ENDIF
&IF "{2}" = "2" &THEN
    {1}:LOAD-MOUSE-POINTER("image\digita.cur") {3}.
    IF {1}:TOOLTIP = ""
    OR {1}:TOOLTIP = ? THEN
        ASSIGN {1}:TOOLTIP = "Clique duas vezes para digitar e procurar.".
&ENDIF

