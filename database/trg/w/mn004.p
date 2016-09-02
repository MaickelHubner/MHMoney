TRIGGER PROCEDURE FOR WRITE OF mov-conta NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "agrupado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.agrupado,"->,>>>,>>9")).
                END.
                WHEN "cd-agenda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-agenda,"999")).
                END.
                WHEN "cd-conta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-conta,"999")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-favorecido,"9999")).
                END.
                WHEN "cd-moeda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-moeda,">>9")).
                END.
                WHEN "cd-nivel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-nivel,">>9")).
                END.
                WHEN "cd-projeto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-projeto,"999")).
                END.
                WHEN "cd-sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sequencia,"->,>>>,>>9")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-categoria,"999")).
                END.
                WHEN "cod-imposto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-imposto,"999")).
                END.
                WHEN "conta-transf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.conta-transf,"999")).
                END.
                WHEN "de-valor" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.de-valor,"->>>,>>>,>>9.99")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-observacao,"X(256)")).
                END.
                WHEN "dt-compensacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-compensacao,"99/99/9999")).
                END.
                WHEN "dt-mov" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-mov,"99/99/9999")).
                END.
                WHEN "id-situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.id-situacao,"9")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.id-tipo,"9")).
                END.
                WHEN "nr-controle" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-controle,">>>>>>9")).
                END.
                WHEN "nr-mov" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-mov,"X(25)")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "seq-transf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.seq-transf,"->,>>>,>>9")).
                END.
                WHEN "seq-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.seq-visita,">>>>>>9")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.sequencia,">>>9")).
                END.
                WHEN "usuar-resp" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.usuar-resp,"X(8)")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "agrupado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.agrupado,"->,>>>,>>9")).
                END.
                WHEN "cd-agenda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-agenda,"999")).
                END.
                WHEN "cd-conta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-conta,"999")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "cd-moeda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-moeda,">>9")).
                END.
                WHEN "cd-nivel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-nivel,">>9")).
                END.
                WHEN "cd-projeto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-projeto,"999")).
                END.
                WHEN "cd-sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sequencia,"->,>>>,>>9")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-categoria,"999")).
                END.
                WHEN "cod-imposto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-imposto,"999")).
                END.
                WHEN "conta-transf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.conta-transf,"999")).
                END.
                WHEN "de-valor" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.de-valor,"->>>,>>>,>>9.99")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-observacao,"X(256)")).
                END.
                WHEN "dt-compensacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-compensacao,"99/99/9999")).
                END.
                WHEN "dt-mov" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-mov,"99/99/9999")).
                END.
                WHEN "id-situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.id-situacao,"9")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.id-tipo,"9")).
                END.
                WHEN "nr-controle" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-controle,">>>>>>9")).
                END.
                WHEN "nr-mov" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-mov,"X(25)")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "seq-transf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.seq-transf,"->,>>>,>>9")).
                END.
                WHEN "seq-visita" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.seq-visita,">>>>>>9")).
                END.
                WHEN "sequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.sequencia,">>>9")).
                END.
                WHEN "usuar-resp" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.usuar-resp,"X(8)")).
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
           lote-mov.tabela   = "mov-conta"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-conta",cResult) <> 0
    OR LOOKUP("cd-sequencia",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-conta"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-conta,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-sequencia"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-sequencia,"->,>>>,>>9")).

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
               lote-mov-campo.campo   = "cd-conta"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-conta,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-conta,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-sequencia"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-sequencia,"->,>>>,>>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-sequencia,"->,>>>,>>9")).

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