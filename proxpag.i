DEFINE BUFFER bfAgend FOR agenda.

FUNCTION fnProxDataPag
RETURNS DATE
  ( rPar AS ROWID ) :

    DEFINE VARIABLE dtReturn AS DATE       NO-UNDO INITIAL ?.
    
    FIND FIRST bfAgend WHERE ROWID(bfAgend) = rPar NO-ERROR.
    IF AVAIL bfAgend THEN DO:

        ASSIGN dtReturn = bfAgend.prox-data-pag.

    END.

    RETURN dtReturn.

END FUNCTION.

PROCEDURE calculaProximoPag:

    DEFINE INPUT  PARAMETER iAgend AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER dtMov AS DATE       NO-UNDO.
    DEFINE INPUT  PARAMETER lAtualiza AS LOGICAL     NO-UNDO.
    DEFINE OUTPUT PARAMETER dtProx AS DATE    NO-UNDO.

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE dtAux AS DATE       NO-UNDO.
    DEFINE VARIABLE l-sim AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iContDia AS INTEGER     NO-UNDO.
    DEFINE VARIABLE dtContAux AS DATE    NO-UNDO.
    DEFINE VARIABLE dtPagAnt AS DATE    NO-UNDO.
    DEFINE VARIABLE iDia AS INTEGER     NO-UNDO.

    DEFINE BUFFER bfProg FOR prog-agenda.
    DEFINE BUFFER bfProg-mes FOR prog-agenda.
    DEFINE BUFFER bfProg-sem FOR prog-agenda.
    DEFINE BUFFER bfProg-dia FOR prog-agenda.
    DEFINE BUFFER bfProg-aux FOR prog-agenda.
    DEFINE BUFFER bfProg-du FOR prog-agenda.

    FIND FIRST agenda EXCLUSIVE-LOCK
        WHERE agenda.cd-agenda = iAgend.

    IF dtMov <= agenda.dt-ultimo-pag THEN RETURN "NOK".

    IF lAtualiza THEN
        ASSIGN agenda.dt-ultimo-pag = dtMov.

    REPEAT dtTemp = (agenda.prox-data-pag + 1) TO (agenda.prox-data-pag + 1000):

        /* Anual */
        FOR FIRST prog-agenda OF agenda NO-LOCK
            WHERE prog-agenda.id-tipo = 1
            AND   (prog-agenda.todos
            OR    prog-agenda.valor = MONTH(dtTemp)
            OR    prog-agenda.num-periodo <> 0):

            FIND FIRST bfProg-aux NO-LOCK
                WHERE bfProg-aux.cd-agenda = prog-agenda.cd-agenda
                AND   bfProg-aux.id-tipo = 0.

            IF prog-agenda.num-periodo <> 0 THEN DO:
                ASSIGN l-sim = NO
                       dtAux = dtMov.
                REPEAT WHILE(dtAux <= dtTemp):
                    ASSIGN iMes = MONTH(dtAux) + prog-agenda.num-periodo
                           iAno = YEAR(dtAux).
                    IF iMes > 12 THEN
                        ASSIGN iMes = iMes - 12
                               iAno = iAno + 1.
                    IF MONTH(dtTemp) = iMes
                    AND YEAR(dtTemp) = iAno THEN DO:
                        ASSIGN l-sim = YES.
                        LEAVE.
                    END.
                    ASSIGN dtAux = DATE(iMes,DAY(dtMov),iAno).
                END.
                IF NOT l-sim THEN NEXT.
            END.

            IF CAN-FIND(FIRST bfProg
                        WHERE bfProg.cd-agenda = prog-agenda.cd-agenda
                        AND   bfProg.id-tipo = 2) THEN DO:
                /* Mensal */
                CASE MONTH(dtTemp):
                    WHEN 2 THEN ASSIGN iDia = 28.
                    WHEN 4 THEN ASSIGN iDia = 30.
                    WHEN 6 THEN ASSIGN iDia = 30.
                    WHEN 9 THEN ASSIGN iDia = 30.
                    WHEN 11 THEN ASSIGN iDia = 30.
                    OTHERWISE ASSIGN iDia = 99.
                END CASE.
                FOR FIRST bfProg-mes NO-LOCK
                    WHERE bfProg-mes.cd-agenda = prog-agenda.cd-agenda
                    AND   bfProg-mes.id-tipo = 2
                    AND   (bfProg-mes.valor = DAY(dtTemp)
                    OR    bfProg-mes.num-periodo <> 0):
                END.
                IF NOT AVAIL bfProg-mes AND DAY(dtTemp) >= iDia THEN DO:
                    FOR FIRST bfProg-mes NO-LOCK
                        WHERE bfProg-mes.cd-agenda = prog-agenda.cd-agenda
                        AND   bfProg-mes.id-tipo = 2
                        AND   bfProg-mes.valor >= iDia:
                    END.
                END.
                IF AVAIL bfProg-mes THEN DO:
                    IF bfProg-mes.num-periodo <> 0 THEN DO:
                        FIND FIRST agenda OF bfProg-mes NO-LOCK.
                        ASSIGN l-sim = NO
                               dtAux = dtMov.
                        REPEAT WHILE(dtAux <= dtTemp):
                            IF (dtAux + bfProg-mes.num-periodo) = dtTemp THEN DO:
                                ASSIGN l-sim = YES.
                                LEAVE.
                            END.
                            ASSIGN dtAux = dtAux + bfProg-mes.num-periodo.
                        END.
                        IF NOT l-sim THEN NEXT.
                    END.
                    ASSIGN dtProx = dtTemp.
                    /* Verifica dia n∆o £til */
                    IF bfProg-aux.valor <> 2 THEN DO:
                        /* se n∆o mantÇm */
                        IF WEEKDAY(dtProx) = 7 THEN DO: /* S†bado */
                            IF bfProg-aux.valor = 1 THEN /* Posterga */
                                ASSIGN dtProx = dtProx + 2.
                            ELSE
                                ASSIGN dtProx = dtProx - 1.
                        END.
                        ELSE DO:
                            IF WEEKDAY(dtProx) = 1 THEN DO: /* Domingo */
                                IF bfProg-aux.valor = 1 THEN /* Posterga */
                                    ASSIGN dtProx = dtProx + 1.
                                ELSE
                                    ASSIGN dtProx = dtProx - 2.
                            END.
                        END.
                        REPEAT:
                            IF CAN-FIND(FIRST feriado NO-LOCK
                                        WHERE feriado.dt-feriado = dtProx) THEN DO:
                                IF bfProg-aux.valor = 1 THEN DO: /* Posterga */
                                    ASSIGN dtProx = dtProx + 1.
                                    IF WEEKDAY(dtProx) = 7 THEN /* S†bado */
                                        ASSIGN dtProx = dtProx + 2.
                                END.
                                ELSE DO:
                                    ASSIGN dtProx = dtProx - 1.
                                    IF WEEKDAY(dtProx) = 1 THEN /* Domingo */
                                        ASSIGN dtProx = dtProx - 2.
                                END.
                            END.
                            ELSE DO:
                                LEAVE.
                            END.
                        END.
                    END.
                    /* Adiciona dias £teis */
                    ASSIGN iContDia = 0.
                    FIND FIRST bfProg-du OF agenda NO-LOCK
                        WHERE bfProg-du.id-tipo = 5 NO-ERROR.
                    IF AVAIL bfProg-du AND bfProg-du.valor > 0 THEN DO:
                        REPEAT dtContAux = dtProx + 1 TO dtProx + 2000:
                            IF WEEKDAY(dtContAux) > 1
                            AND WEEKDAY(dtContAux) < 7
                            AND NOT CAN-FIND(FIRST feriado NO-LOCK
                                             WHERE feriado.dt-feriado = dtContAux) THEN DO:
                                ASSIGN iContDia = iContDia + 1.
                                IF iContDia = bfProg-du.valor THEN DO:
                                    ASSIGN dtProx = dtContAux.
                                    LEAVE.
                                END.
                            END.
                        END.
                    END.
                    IF dtProx > dtMov THEN DO:
                        IF lAtualiza THEN
                            ASSIGN agenda.prox-data-pag = dtProx.
                        RETURN.
                    END.
                END.
                IF fnUltimoDia(MONTH(dtTemp),YEAR(dtTemp)) = dtTemp THEN DO:
                    FOR EACH bfProg-mes NO-LOCK
                        WHERE bfProg-mes.cd-agenda = prog-agenda.cd-agenda
                        AND   bfProg-mes.id-tipo = 2
                        AND   bfProg-mes.ultimo = YES:
                        ASSIGN dtProx = dtTemp.
                        /* Verifica dia n∆o £til */
                        IF bfProg-aux.valor <> 2 THEN DO:
                            /* se n∆o mantÇm */
                            IF WEEKDAY(dtProx) = 7 THEN DO: /* S†bado */
                                IF bfProg-aux.valor = 1 THEN /* Posterga */
                                    ASSIGN dtProx = dtProx + 2.
                                ELSE
                                    ASSIGN dtProx = dtProx - 1.
                            END.
                            ELSE DO:
                                IF WEEKDAY(dtProx) = 1 THEN DO: /* Domingo */
                                    IF bfProg-aux.valor = 1 THEN /* Posterga */
                                        ASSIGN dtProx = dtProx + 1.
                                    ELSE
                                        ASSIGN dtProx = dtProx - 2.
                                END.
                            END.
                            REPEAT:
                                IF CAN-FIND(FIRST feriado NO-LOCK
                                            WHERE feriado.dt-feriado = dtProx) THEN DO:
                                    IF bfProg-aux.valor = 1 THEN DO: /* Posterga */
                                        ASSIGN dtProx = dtProx + 1.
                                        IF WEEKDAY(dtProx) = 7 THEN /* S†bado */
                                            ASSIGN dtProx = dtProx + 2.
                                    END.
                                    ELSE DO:
                                        ASSIGN dtProx = dtProx - 1.
                                        IF WEEKDAY(dtProx) = 1 THEN /* Domingo */
                                            ASSIGN dtProx = dtProx - 2.
                                    END.
                                END.
                                ELSE DO:
                                    LEAVE.
                                END.
                            END.
                        END.
                        /* Adiciona dias £teis */
                        ASSIGN iContDia = 0.
                        FIND FIRST bfProg-du OF agenda NO-LOCK
                            WHERE bfProg-du.id-tipo = 5 NO-ERROR.
                        IF AVAIL bfProg-du AND bfProg-du.valor > 0 THEN DO:
                            REPEAT dtContAux = dtProx + 1 TO dtProx + 2000:
                                IF WEEKDAY(dtContAux) > 1
                                AND WEEKDAY(dtContAux) < 7
                                AND NOT CAN-FIND(FIRST feriado NO-LOCK
                                                 WHERE feriado.dt-feriado = dtContAux) THEN DO:
                                    ASSIGN iContDia = iContDia + 1.
                                    IF iContDia = bfProg-du.valor THEN DO:
                                        ASSIGN dtProx = dtContAux.
                                        LEAVE.
                                    END.
                                END.
                            END.
                        END.
                        IF dtProx > dtMov THEN DO:
                            IF lAtualiza THEN
                                ASSIGN agenda.prox-data-pag = dtProx.
                            RETURN.
                        END.
                    END.
                END.
            END.
            IF CAN-FIND(FIRST bfProg
                        WHERE bfProg.cd-agenda = prog-agenda.cd-agenda
                        AND   bfProg.id-tipo = 4) THEN DO:
                /* Semanal */
                FOR EACH bfProg-sem NO-LOCK
                    WHERE bfProg-sem.cd-agenda = prog-agenda.cd-agenda
                    AND   bfProg-sem.id-tipo = 3
                    AND   (bfProg-sem.valor = fnSemana(dtTemp)
                    OR    bfProg-sem.todos
                    OR    bfProg-sem.ultimo):

                    IF bfProg-sem.ultimo THEN DO:
                        IF fnSemana(fnUltimoDia(MONTH(dtTemp),YEAR(dtTemp))) <> fnSemana(dtTemp) THEN NEXT.
                    END.

                    /* Diario */
                    FOR EACH bfProg-dia NO-LOCK
                        WHERE bfProg-dia.cd-agenda = prog-agenda.cd-agenda
                        AND   bfProg-dia.id-tipo = 4
                        AND   (bfProg-dia.todos
                        OR     bfProg-dia.valor = WEEKDAY(dtTemp)):
                        ASSIGN dtProx = dtTemp.
                        /* Verifica dia n∆o £til */
                        IF bfProg-aux.valor <> 2 THEN DO:
                            /* se n∆o mantÇm */
                            IF WEEKDAY(dtProx) = 7 THEN DO: /* S†bado */
                                IF bfProg-aux.valor = 1 THEN /* Posterga */
                                    ASSIGN dtProx = dtProx + 2.
                                ELSE
                                    ASSIGN dtProx = dtProx - 1.
                            END.
                            ELSE DO:
                                IF WEEKDAY(dtProx) = 1 THEN DO: /* Domingo */
                                    IF bfProg-aux.valor = 1 THEN /* Posterga */
                                        ASSIGN dtProx = dtProx + 1.
                                    ELSE
                                        ASSIGN dtProx = dtProx - 2.
                                END.
                            END.
                            REPEAT:
                                IF CAN-FIND(FIRST feriado NO-LOCK
                                            WHERE feriado.dt-feriado = dtProx) THEN DO:
                                    IF bfProg-aux.valor = 1 THEN DO: /* Posterga */
                                        ASSIGN dtProx = dtProx + 1.
                                        IF WEEKDAY(dtProx) = 7 THEN /* S†bado */
                                            ASSIGN dtProx = dtProx + 2.
                                    END.
                                    ELSE DO:
                                        ASSIGN dtProx = dtProx - 1.
                                        IF WEEKDAY(dtProx) = 1 THEN /* Domingo */
                                            ASSIGN dtProx = dtProx - 2.
                                    END.
                                END.
                                ELSE DO:
                                    LEAVE.
                                END.
                            END.
                        END.
                        /* Adiciona dias £teis */
                        ASSIGN iContDia = 0.
                        FIND FIRST bfProg-du OF agenda NO-LOCK
                            WHERE bfProg-du.id-tipo = 5 NO-ERROR.
                        IF AVAIL bfProg-du AND bfProg-du.valor > 0 THEN DO:
                            REPEAT dtContAux = dtProx + 1 TO dtProx + 2000:
                                IF WEEKDAY(dtContAux) > 1
                                AND WEEKDAY(dtContAux) < 7
                                AND NOT CAN-FIND(FIRST feriado NO-LOCK
                                                 WHERE feriado.dt-feriado = dtContAux) THEN DO:
                                    ASSIGN iContDia = iContDia + 1.
                                    IF iContDia = bfProg-du.valor THEN DO:
                                        ASSIGN dtProx = dtContAux.
                                        LEAVE.
                                    END.
                                END.
                            END.
                        END.
                        IF dtProx > dtMov THEN DO:
                            IF lAtualiza THEN
                                ASSIGN agenda.prox-data-pag = dtProx.
                            RETURN.
                        END.
                    END.
                END.
            END.
        END.

    END.

    IF lAtualiza THEN
        ASSIGN agenda.prox-data-pag = dtProx.

END PROCEDURE.
