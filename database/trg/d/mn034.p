TRIGGER PROCEDURE FOR DELETE OF prog-agenda.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FIND FIRST param-mn NO-LOCK.
IF param-mn.sincroniza THEN DO:

    FIND LAST lote-mov WHERE lote-mov.numero = 0 NO-LOCK NO-ERROR.
    IF AVAIL lote-mov THEN
        ASSIGN iNum = lote-mov.num-mov + 1.
    ELSE
        ASSIGN iNum = 1.

    CREATE lote-mov.
    ASSIGN lote-mov.usuario  = gcUsuario
           lote-mov.data     = TODAY
           lote-mov.hora     = REPLACE(STRING(TIME,"HH:MM"),":","")
           lote-mov.tabela   = "prog-agenda"
           lote-mov.operacao = "DEL"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "cd-agenda"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(prog-agenda.cd-agenda,"999")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "id-tipo"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(prog-agenda.id-tipo,">>9")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "valor"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(prog-agenda.valor,">>9")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "todos"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(prog-agenda.todos,"Sim/N�o")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "ultimo"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(prog-agenda.ultimo,"Sim/N�o")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "num-periodos"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(prog-agenda.num-periodos,">>9")).

END.