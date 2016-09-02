TRIGGER PROCEDURE FOR DELETE OF contato-caracteristica.

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
           lote-mov.tabela   = "contato-caracteristica"
           lote-mov.operacao = "DEL"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "cd-favorecido"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(contato-caracteristica.cd-favorecido,"9999")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "cd-contato"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(contato-caracteristica.cd-contato,"->,>>>,>>9")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "sequencia"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(contato-caracteristica.sequencia,"->,>>>,>>9")).

END.