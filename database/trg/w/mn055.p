TRIGGER PROCEDURE FOR WRITE OF visita NEW BUFFER newTab OLD BUFFER oldTab.

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
                WHEN "compromisso" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.compromisso,"Sim/N�o")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-observacao,"x(2000)")).
                END.
                WHEN "ds-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-visita,"x(80)")).
                END.
                WHEN "dt-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-visita,"99/99/9999")).
                END.
                WHEN "hora-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.hora-fim,"x(5)")).
                END.
                WHEN "hora-inicio" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.hora-inicio,"x(5)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome,"X(8)")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "ocupado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ocupado,"Sim/N�o")).
                END.
                WHEN "qt-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.qt-visita,"->>,>>9.99")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.sequencia,">>>>>>9")).
                END.
                WHEN "situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.situacao,"9")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tipo,"9")).
                END.
                WHEN "vl-adiantado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-adiantado,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "compromisso" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.compromisso,"Sim/N�o")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-observacao,"x(2000)")).
                END.
                WHEN "ds-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-visita,"x(80)")).
                END.
                WHEN "dt-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-visita,"99/99/9999")).
                END.
                WHEN "hora-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.hora-fim,"x(5)")).
                END.
                WHEN "hora-inicio" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.hora-inicio,"x(5)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome,"X(8)")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "ocupado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ocupado,"Sim/N�o")).
                END.
                WHEN "qt-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.qt-visita,"->>,>>9.99")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.sequencia,">>>>>>9")).
                END.
                WHEN "situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.situacao,"9")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tipo,"9")).
                END.
                WHEN "vl-adiantado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-adiantado,"->>,>>9.99")).
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
           lote-mov.tabela   = "visita"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("sequencia",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "sequencia"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.sequencia,">>>>>>9")).

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
               lote-mov-campo.campo   = "sequencia"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.sequencia,">>>>>>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.sequencia,">>>>>>9")).

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