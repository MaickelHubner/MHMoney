ON 'RETURN' OF {&Campo}-fim
DO:
  
    APPLY "CHOOSE" TO btFiltra IN FRAME {&FRAME-NAME}.

END.

ON 'VALUE-CHANGED' OF {&Campo}-ini
DO:
  
    APPLY "CHOOSE" TO btFiltra IN FRAME {&FRAME-NAME}.

END.
