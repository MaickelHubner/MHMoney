DEFINE INPUT  PARAMETER iProj AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER iNivel AS INTEGER    NO-UNDO.
DEFINE OUTPUT PARAMETER deValor AS DECIMAL    NO-UNDO.
DEFINE OUTPUT PARAMETER deEst AS DECIMAL    NO-UNDO.

DEFINE BUFFER bfNivel FOR nivel-projeto.
DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deTemp-est AS DECIMAL    NO-UNDO.

DEFINE VARIABLE l-contr AS LOGICAL    NO-UNDO INITIAL NO.

ASSIGN deValor = 0
       deEst = 0.

FOR EACH bfNivel NO-LOCK
    WHERE bfNivel.cd-projeto = iProj
    AND   bfNivel.nivel-pai = iNivel
    AND   bfNivel.cd-nivel <> 0:

    RUN projval.p (INPUT iProj,
                   INPUT bfNivel.cd-nivel,
                   OUTPUT deTemp,
                   OUTPUT deTemp-est).

    ASSIGN deValor = deValor + deTemp
           deEst   = deEst + deTemp-est
           l-contr = YES.

END.

IF NOT l-contr THEN DO:
    IF deValor = 0 THEN DO:
        FIND FIRST bfNivel NO-LOCK
            WHERE bfNivel.cd-projeto = iProj
            AND   bfNivel.cd-nivel   = iNivel NO-ERROR.
        IF AVAIL bfNivel THEN
            ASSIGN deValor = bfNivel.val-planejado.
    END.

    IF deEst = 0 THEN DO:
        FIND FIRST bfNivel NO-LOCK
            WHERE bfNivel.cd-projeto = iProj
            AND   bfNivel.cd-nivel   = iNivel NO-ERROR.
        IF AVAIL bfNivel THEN
            ASSIGN deEst = bfNivel.val-estimado.
    END.
END.

RETURN "OK":U.
