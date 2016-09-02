IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
    ASSIGN iTotReg = {1}.

    IF iTotReg <= 0 THEN
        ASSIGN iTotReg = 1.

    ASSIGN chProgressBar:Max = iTotReg /* Controles da ProgressBar */
           iContReg = 0.
END.
