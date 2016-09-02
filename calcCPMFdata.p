DEFINE INPUT  PARAMETER iAgend AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER dtCPMF AS DATE       NO-UNDO.
DEFINE OUTPUT PARAMETER deValor AS DECIMAL    NO-UNDO.

DEFINE VARIABLE dtIniD AS DATE       NO-UNDO.
DEFINE VARIABLE dtEndD AS DATE       NO-UNDO.
DEFINE VARIABLE iConta AS INTEGER    NO-UNDO.
DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta.
    
{func\data.i}

FIND FIRST agenda EXCLUSIVE-LOCK
    WHERE agenda.cd-agenda = iAgend NO-ERROR.
IF NOT AVAIL agenda THEN RETURN "NOK".

IF DAY(dtCPMF) > 10
AND DAY(dtCPMF) <= 20 THEN DO:
    ASSIGN dtIniD = DATE(MONTH(dtCPMF),1,YEAR(dtCPMF))
           dtEndD = DATE(MONTH(dtCPMF),10,YEAR(dtCPMF)).
END.
IF DAY(dtCPMF) > 20
AND DAY(dtCPMF) <= 31 THEN DO:
    ASSIGN dtIniD = DATE(MONTH(dtCPMF),11,YEAR(dtCPMF))
           dtEndD = DATE(MONTH(dtCPMF),20,YEAR(dtCPMF)).
END.
IF DAY(dtCPMF) <= 10 THEN DO:
    ASSIGN dtIniD = (DATE(MONTH(dtCPMF),1,YEAR(dtCPMF)) - 1)
           dtIniD = DATE(MONTH(dtIniD),21,YEAR(dtIniD))
           dtEndD = fnUltimoDia(MONTH(dtIniD),YEAR(dtIniD)).
END.

ASSIGN iConta = agenda.cd-conta.

FIND FIRST conta NO-LOCK
    WHERE conta.cd-conta = iConta NO-ERROR.

DEFINE VARIABLE dtCalc AS DATE       NO-UNDO.
ASSIGN dtCalc = dtIniD - 5.

{ttmovto.i dtCalc dtEndD NO}

RUN criaTT.
FIND FIRST agenda EXCLUSIVE-LOCK
    WHERE agenda.cd-agenda = iAgend NO-ERROR.

FOR EACH tt-mov-conta
    WHERE tt-mov-conta.dt-mov >= dtIniD
    AND   tt-mov-conta.dt-mov <= dtEndD
    AND   tt-mov-conta.de-valor < 0:

    IF tt-mov-conta.cd-agenda = agenda.cd-agenda THEN NEXT.

    ASSIGN deTotal = deTotal + tt-mov-conta.de-valor.
END.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.agrupado = 0
    AND   mov-conta.de-valor < 0
    AND   mov-conta.id-situacao = 3
    AND   mov-conta.dt-compensacao >= dtIniD
    AND   mov-conta.dt-compensacao <= dtEndD:

    IF mov-conta.cd-favorecido = agenda.cd-favorecido
    AND mov-conta.cod-categoria = agenda.cod-categoria
    AND mov-conta.cd-sub = agenda.cd-sub THEN NEXT.

    ASSIGN deTotal = deTotal + mov-conta.de-valor.

END.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.agrupado = 0
    AND   mov-conta.de-valor < 0
    AND   mov-conta.id-situacao <> 3
    AND   mov-conta.dt-mov >= dtIniD
    AND   mov-conta.dt-mov <= dtEndD:

    IF mov-conta.cd-favorecido = agenda.cd-favorecido
    AND mov-conta.cod-categoria = agenda.cod-categoria
    AND mov-conta.cd-sub = agenda.cd-sub THEN NEXT.

    ASSIGN deTotal = deTotal + mov-conta.de-valor.

END.

FIND FIRST param-mn.

ASSIGN deValor = ((deTotal * param-mn.pc-cpmf) / 100).

RETURN "OK".

