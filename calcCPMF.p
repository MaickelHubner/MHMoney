DEFINE INPUT  PARAMETER iAgend AS INTEGER    NO-UNDO.

DEFINE VARIABLE dtIni AS DATE       NO-UNDO.
DEFINE VARIABLE dtEnd AS DATE       NO-UNDO.
DEFINE VARIABLE iConta AS INTEGER    NO-UNDO.
DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta.

{func\data.i}

FIND FIRST agenda EXCLUSIVE-LOCK
    WHERE agenda.cd-agenda = iAgend NO-ERROR.
IF NOT AVAIL agenda THEN RETURN "NOK".

IF DAY(agenda.prox-data-pag) > 10
AND DAY(agenda.prox-data-pag) <= 20 THEN DO:
    ASSIGN dtIni = DATE(MONTH(agenda.prox-data-pag),1,YEAR(agenda.prox-data-pag))
           dtEnd = DATE(MONTH(agenda.prox-data-pag),10,YEAR(agenda.prox-data-pag)).
END.
IF DAY(agenda.prox-data-pag) > 20
AND DAY(agenda.prox-data-pag) <= 31 THEN DO:
    ASSIGN dtIni = DATE(MONTH(agenda.prox-data-pag),11,YEAR(agenda.prox-data-pag))
           dtEnd = DATE(MONTH(agenda.prox-data-pag),20,YEAR(agenda.prox-data-pag)).
END.
IF DAY(agenda.prox-data-pag) <= 10 THEN DO:
    ASSIGN dtIni = (DATE(MONTH(agenda.prox-data-pag),1,YEAR(agenda.prox-data-pag)) - 1)
           dtIni = DATE(MONTH(dtIni),21,YEAR(dtIni))
           dtEnd = fnUltimoDia(MONTH(dtIni),YEAR(dtIni)).
END.

ASSIGN iConta = agenda.cd-conta.

{ttmovto.i dtIni dtEnd NO}

RUN criaTT.
FIND FIRST agenda EXCLUSIVE-LOCK
    WHERE agenda.cd-agenda = iAgend NO-ERROR.

FOR EACH tt-mov-conta:
    ASSIGN deTotal = deTotal + tt-mov-conta.de-valor.
END.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.agrupado = 0
    AND   mov-conta.de-valor < 0
    AND   mov-conta.id-situacao = 3
    AND   mov-conta.dt-compensacao >= dtIni
    AND   mov-conta.dt-compensacao <= dtEnd:

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
    AND   mov-conta.dt-mov <= dtEnd:

    IF mov-conta.cd-favorecido = agenda.cd-favorecido
    AND mov-conta.cod-categoria = agenda.cod-categoria
    AND mov-conta.cd-sub = agenda.cd-sub THEN NEXT.

    ASSIGN deTotal = deTotal + mov-conta.de-valor.

END.

FIND FIRST param-mn.

ASSIGN agenda.vl-atual = ((deTotal * param-mn.pc-cpmf) / 100).

RETURN "OK".
