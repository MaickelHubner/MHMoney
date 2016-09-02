DEFINE INPUT  PARAMETER pcUsuario AS CHARACTER   NO-UNDO.
DEFINE INPUT  PARAMETER pdtIni AS DATE   NO-UNDO.

DEFINE VARIABLE d-qt AS DECIMAL     NO-UNDO.
DEFINE VARIABLE dtAux AS DATE    NO-UNDO.
DEFINE VARIABLE d-tar AS DECIMAL     NO-UNDO.
DEFINE VARIABLE iPri AS INTEGER     NO-UNDO INITIAL 1.
DEFINE VARIABLE de-qt-vis AS DECIMAL     NO-UNDO.

DEFINE TEMP-TABLE tt-tar LIKE tarefa.

DEFINE BUFFER bf-tarefa FOR tarefa.
DEFINE BUFFER bf-tarefa2 FOR tarefa.

FIND FIRST usuario NO-LOCK
    WHERE usuario.nome = pcUsuario NO-ERROR.
IF NOT AVAIL usuario THEN RETURN "NOK".

IF usuario.hrs-dia = 0 THEN RETURN "NOK".

/* Reinicia as prioridades */
FOR EACH tarefa NO-LOCK
    WHERE tarefa.responsavel = pcUsuario
    AND   tarefa.situacao <= 2 /* Em Andamento */
    AND   tarefa.num-os <> 0
    BY tarefa.prioridade:
    CREATE tt-tar.
    BUFFER-COPY tarefa TO tt-tar
    ASSIGN tt-tar.prioridade = iPri
           iPri = iPri + 1.
END.

FOR EACH tt-tar:
    FIND FIRST tarefa OF tt-tar EXCLUSIVE-LOCK NO-ERROR.
    ASSIGN tarefa.prioridade = tt-tar.prioridade.

END.

EMPTY TEMP-TABLE tt-tar.
    
ASSIGN d-qt = usuario.hrs-dia
       dtAux = pdtIni.

blk-fer:
REPEAT:
    ASSIGN de-qt-vis = 0.
    FIND FIRST feriado NO-LOCK
        WHERE feriado.dt-feriado = dtAux NO-ERROR.
    IF AVAIL feriado THEN DO:
        ASSIGN dtAux = dtAux + 1.
    END.
    ELSE DO:
        FOR EACH visita NO-LOCK
            WHERE visita.nome = pcUsuario
            AND   visita.situacao < 9
            AND   visita.dt-visita = dtAux
            AND   visita.ocupado:
            ASSIGN de-qt-vis = de-qt-vis + visita.qt-visita.
        END.
        IF de-qt-vis >= 8.5 THEN
            ASSIGN dtAux = dtAux + 1.
    END.
    IF NOT AVAIL feriado
    AND de-qt-vis < 8.5 THEN
        LEAVE blk-fer.
END.
CASE WEEKDAY(dtAux):
    WHEN 1 /* Domingo */ THEN ASSIGN dtAux = dtAux + 1.
    WHEN 7 /* S bado */ THEN ASSIGN dtAux = dtAux + 2.
END CASE.

IF dtAux = TODAY THEN DO:
    IF STRING(TIME, "HH:MM") > "18:00" THEN
        ASSIGN dtAux = dtAux + 1.
    ELSE
        IF STRING(TIME, "HH:MM") > "12:00" THEN
            ASSIGN d-qt = 18 - INT(SUBSTRING(STRING(TIME, "HH:MM"), 1, 2)).
        ELSE
            ASSIGN d-qt = 16.5 - INT(SUBSTRING(STRING(TIME, "HH:MM"), 1, 2)).
END.
IF d-qt > usuario.hrs-dia THEN
    ASSIGN d-qt = usuario.hrs-dia.

ASSIGN de-qt-vis = 0.
FOR EACH visita NO-LOCK
    WHERE visita.nome = pcUsuario
    AND   visita.situacao < 9
    AND   visita.dt-visita = dtAux
    AND   visita.ocupado:
    ASSIGN de-qt-vis = de-qt-vis + visita.qt-visita.
END.
IF d-qt > (8.5 - de-qt-vis) THEN
    ASSIGN d-qt = (8.5 - de-qt-vis).

FOR EACH tarefa EXCLUSIVE-LOCK
    WHERE tarefa.responsavel = pcUsuario
    AND   tarefa.situacao <= 2 /* Em Andamento */
    AND   tarefa.num-os <> 0
    BY tarefa.prioridade:

    /* Calcula as datas para tarefas que iniciam ap¢s... */
    FOR EACH tt-tar
        WHERE tt-tar.dt-ini-apos <= dtAux
        BY tt-tar.prioridade:
        FIND FIRST bf-tarefa OF tt-tar EXCLUSIVE-LOCK.
        {calc_prioridade.i bf-tarefa}
        DELETE tt-tar.
    END.

    /* Verifica se a tarefa pode iniciar na data atual */
    IF tarefa.dt-ini-apos > dtAux THEN DO:
        CREATE tt-tar.
        BUFFER-COPY tarefa TO tt-tar.
    END.
    ELSE DO:
        {calc_prioridade.i tarefa}
    END.

    FOR EACH bf-tarefa NO-LOCK
        WHERE bf-tarefa.rest-nome = tarefa.nome
        AND   bf-tarefa.rest-sequencia = tarefa.sequencia:
        FIND FIRST bf-tarefa2 OF bf-tarefa EXCLUSIVE-LOCK.
        ASSIGN bf-tarefa2.dt-ini-apos = tarefa.data-prev-fim + 1.
    END.

END.

FOR EACH tt-tar
    BY tt-tar.dt-ini-apos
    BY tt-tar.prioridade:
    FIND FIRST bf-tarefa OF tt-tar EXCLUSIVE-LOCK.

    IF dtAux < tt-tar.dt-ini-apos THEN
        ASSIGN dtAux = tt-tar.dt-ini-apos.

    {calc_prioridade.i bf-tarefa}
    DELETE tt-tar.
END.


RETURN "OK".

