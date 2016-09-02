TRIGGER PROCEDURE FOR WRITE OF apontamento NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-favorecido,"9999")).
                END.
                WHEN "codigo-fa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.codigo-fa,">>>>>>9")).
                END.
                WHEN "data" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.data,"99/99/9999")).
                END.
                WHEN "ds-apontamento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-apontamento,"x(2000)")).
                END.
                WHEN "ds-fav-apont" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-fav-apont,"X(40)")).
                END.
                WHEN "hora-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.hora-fim,"x(5)")).
                END.
                WHEN "hora-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.hora-ini,"x(5)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome,"X(8)")).
                END.
                WHEN "nome-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome-tarefa,"X(8)")).
                END.
                WHEN "nr-mov" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-mov,"X(25)")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "qt-apontada" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.qt-apontada,"->>,>>9.99")).
                END.
                WHEN "reembolsavel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.reembolsavel,"yes/no")).
                END.
                WHEN "seq-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.seq-tarefa,">>>>9")).
                END.
                WHEN "seq-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.seq-visita,">>>>>>9")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.sequencia,">>>9")).
                END.
                WHEN "tipo-despesa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tipo-despesa,"x(30)")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "codigo-fa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.codigo-fa,">>>>>>9")).
                END.
                WHEN "data" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.data,"99/99/9999")).
                END.
                WHEN "ds-apontamento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-apontamento,"x(2000)")).
                END.
                WHEN "ds-fav-apont" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-fav-apont,"X(40)")).
                END.
                WHEN "hora-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.hora-fim,"x(5)")).
                END.
                WHEN "hora-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.hora-ini,"x(5)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome,"X(8)")).
                END.
                WHEN "nome-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome-tarefa,"X(8)")).
                END.
                WHEN "nr-mov" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-mov,"X(25)")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "qt-apontada" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.qt-apontada,"->>,>>9.99")).
                END.
                WHEN "reembolsavel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.reembolsavel,"yes/no")).
                END.
                WHEN "seq-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.seq-tarefa,">>>>9")).
                END.
                WHEN "seq-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.seq-visita,">>>>>>9")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.sequencia,">>>9")).
                END.
                WHEN "tipo-despesa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tipo-despesa,"x(30)")).
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
           lote-mov.tabela   = "apontamento"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("nome",cResult) <> 0
    OR LOOKUP("data",cResult) <> 0
    OR LOOKUP("hora-ini",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "nome"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.nome,"X(8)")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "data"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.data,"99/99/9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "hora-ini"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.hora-ini,"x(5)")).

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
               lote-mov-campo.campo   = "nome"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.nome,"X(8)")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.nome,"X(8)")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "data"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.data,"99/99/9999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.data,"99/99/9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "hora-ini"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.hora-ini,"x(5)")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.hora-ini,"x(5)")).

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