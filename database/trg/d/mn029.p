TRIGGER PROCEDURE FOR DELETE OF tabela-ir-faixa.

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
           lote-mov.tabela   = "tabela-ir-faixa"
           lote-mov.operacao = "DEL"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "cd-tabela"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(tabela-ir-faixa.cd-tabela,"999")).

    CREATE lote-mov-campo.
    ASSIGN lote-mov-campo.num-mov = iNum
           lote-mov-campo.campo   = "val-ini"
           lote-mov-campo.chave   = yes
           lote-mov-campo.origem  = param-mn.maquina-local
           lote-mov-campo.antes   = TRIM(STRING(tabela-ir-faixa.val-ini,"->>,>>9.99")).

END.