TRIGGER PROCEDURE FOR WRITE OF tarefa NEW BUFFER newTab OLD BUFFER oldTab.

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
                WHEN "data-prev-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.data-prev-fim,"99/99/9999")).
                END.
                WHEN "data-prev-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.data-prev-ini,"99/99/9999")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-observacao,"x(2000)")).
                END.
                WHEN "ds-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-tarefa,"x(40)")).
                END.
                WHEN "dt-alert-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-alert-tarefa,"99/99/9999")).
                END.
                WHEN "dt-cri-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-cri-tarefa,"99/99/9999")).
                END.
                WHEN "dt-ini-apos" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-ini-apos,"99/99/9999")).
                END.
                WHEN "dt-plan-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-plan-fim,"99/99/9999")).
                END.
                WHEN "dt-plan-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-plan-ini,"99/99/9999")).
                END.
                WHEN "dt-real-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-real-fim,"99/99/9999")).
                END.
                WHEN "dt-real-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-real-ini,"99/99/9999")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome,"X(8)")).
                END.
                WHEN "num-os" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.num-os,"999999")).
                END.
                WHEN "perc-con" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.perc-con,"->>,>>9.99")).
                END.
                WHEN "prioridade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.prioridade,">>>>>9")).
                END.
                WHEN "qtd-horas" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.qtd-horas,"->>,>>9.99")).
                END.
                WHEN "qtd-lib" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.qtd-lib,"->>,>>9.99")).
                END.
                WHEN "responsavel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.responsavel,"X(8)")).
                END.
                WHEN "rest-nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.rest-nome,"X(8)")).
                END.
                WHEN "rest-sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.rest-sequencia,">>>>9")).
                END.
                WHEN "seq-pedido-item" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.seq-pedido-item,">>>9")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.sequencia,">>>>9")).
                END.
                WHEN "situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.situacao,"9")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "data-prev-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.data-prev-fim,"99/99/9999")).
                END.
                WHEN "data-prev-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.data-prev-ini,"99/99/9999")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-observacao,"x(2000)")).
                END.
                WHEN "ds-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-tarefa,"x(40)")).
                END.
                WHEN "dt-alert-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-alert-tarefa,"99/99/9999")).
                END.
                WHEN "dt-cri-tarefa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-cri-tarefa,"99/99/9999")).
                END.
                WHEN "dt-ini-apos" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-ini-apos,"99/99/9999")).
                END.
                WHEN "dt-plan-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-plan-fim,"99/99/9999")).
                END.
                WHEN "dt-plan-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-plan-ini,"99/99/9999")).
                END.
                WHEN "dt-real-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-real-fim,"99/99/9999")).
                END.
                WHEN "dt-real-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-real-ini,"99/99/9999")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome,"X(8)")).
                END.
                WHEN "num-os" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.num-os,"999999")).
                END.
                WHEN "perc-con" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.perc-con,"->>,>>9.99")).
                END.
                WHEN "prioridade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.prioridade,">>>>>9")).
                END.
                WHEN "qtd-horas" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.qtd-horas,"->>,>>9.99")).
                END.
                WHEN "qtd-lib" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.qtd-lib,"->>,>>9.99")).
                END.
                WHEN "responsavel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.responsavel,"X(8)")).
                END.
                WHEN "rest-nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.rest-nome,"X(8)")).
                END.
                WHEN "rest-sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.rest-sequencia,">>>>9")).
                END.
                WHEN "seq-pedido-item" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.seq-pedido-item,">>>9")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.sequencia,">>>>9")).
                END.
                WHEN "situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.situacao,"9")).
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
           lote-mov.tabela   = "tarefa"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("nome",cResult) <> 0
    OR LOOKUP("sequencia",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "nome"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.nome,"X(8)")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "sequencia"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.sequencia,">>>>9")).

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
               lote-mov-campo.campo   = "sequencia"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.sequencia,">>>>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.sequencia,">>>>9")).

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