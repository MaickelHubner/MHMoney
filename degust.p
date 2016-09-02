DEFINE VARIABLE dtDeg AS DATE       NO-UNDO.

ASSIGN dtDeg = DATE(11,29,2004).

IF TODAY <= dtDeg THEN DO:
    RUN func\msg.w (INPUT 1, INPUT 'VersÆo de Degusta‡Æo', INPUT 'Validade: ' + STRING(dtDeg,"99/99/9999"), INPUT 'Essa ‚ uma versÆo de degusta‡Æo. Ap¢s a data de validade nÆo ser  mais poss¡vel executar o programa.').
    RUN MENU.w.
END.
ELSE DO:
    RUN func\msg.w (INPUT 1, INPUT 'VersÆo de Degusta‡Æo', INPUT 'A data limite de degusta‡Æo expirou!', INPUT 'Adquira o produto MHMoney 2005').
    QUIT.
END.
