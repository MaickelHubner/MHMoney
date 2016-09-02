TRIGGER PROCEDURE FOR WRITE OF atendimento NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-contato,"->,>>>,>>9")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-favorecido,"9999")).
                END.
                WHEN "contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.contato,"x(60)")).
                END.
                WHEN "data" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.data,"99/99/9999")).
                END.
                WHEN "hora" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.hora,"x(05)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome,"X(8)")).
                END.
                WHEN "observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.observacao,"x(2000)")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.sequencia,">>>>9")).
                END.
                WHEN "usuario" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.usuario,"x(20)")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-contato,"->,>>>,>>9")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.contato,"x(60)")).
                END.
                WHEN "data" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.data,"99/99/9999")).
                END.
                WHEN "hora" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.hora,"x(05)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome,"X(8)")).
                END.
                WHEN "observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.observacao,"x(2000)")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.sequencia,">>>>9")).
                END.
                WHEN "usuario" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.usuario,"x(20)")).
                END.
            END CASE.
        END.
    END CASE.
    RETURN cValor.
END FUNCTION.

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
           lote-mov.tabela   = "atendimento"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-favorecido",cResult) <> 0
    OR LOOKUP("data",cResult) <> 0
    OR LOOKUP("hora",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-favorecido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-favorecido,"9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "data"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.data,"99/99/9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "hora"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.hora,"x(05)")).

        REPEAT iCont = 1 TO NUM-ENTRIES(cResult):
            FIND FIRST lote-mov-campo
                WHERE lote-mov-campo.num-mov = iNum
                AND   lote-mov-campo.campo = ENTRY(iCont,cResult) NO-LOCK NO-ERROR.
            IF NOT AVAIL lote-mov-campo THEN DO:
                CREATE lote-mov-campo.
                ASSIGN lote-mov-campo.num-mov = iNum
                       lote-mov-campo.campo   = ENTRY(iCont,cResult)
                       lote-mov-campo.origem  = param-mn.maquina-local.
                ASSIGN lote-mov-campo.antes   = fnValor("NEW",ENTRY(iCont,cResult)).
            END.
        END.

    END.
    ELSE DO:

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-favorecido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-favorecido,"9999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-favorecido,"9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "data"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.data,"99/99/9999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.data,"99/99/9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "hora"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.hora,"x(05)")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.hora,"x(05)")).

        REPEAT iCont = 1 TO NUM-ENTRIES(cResult):
            CREATE lote-mov-campo.
            ASSIGN lote-mov-campo.num-mov = iNum
                   lote-mov-campo.campo   = ENTRY(iCont,cResult)
                   lote-mov-campo.origem  = param-mn.maquina-local.
            ASSIGN lote-mov-campo.antes   = fnValor("OLD",ENTRY(iCont,cResult)).
                   lote-mov-campo.depois  = fnValor("NEW",ENTRY(iCont,cResult)).
        END.

    END.

END.