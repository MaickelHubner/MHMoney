TRIGGER PROCEDURE FOR WRITE OF bens NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "bem-pai" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.bem-pai,"999")).
                END.
                WHEN "bem-venda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.bem-venda,"999")).
                END.
                WHEN "cd-bens" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-bens,"999")).
                END.
                WHEN "cd-moeda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-moeda,">>9")).
                END.
                WHEN "controla-consumo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.controla-consumo,"Sim/NÆo")).
                END.
                WHEN "ds-bens" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-bens,"X(40)")).
                END.
                WHEN "dt-aquisicao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-aquisicao,"99/99/9999")).
                END.
                WHEN "dt-venda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-venda,"99/99/9999")).
                END.
                WHEN "grupo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.grupo,"Sim/NÆo")).
                END.
                WHEN "imagem" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.imagem,"X(256)")).
                END.
                WHEN "pc-depreciacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.pc-depreciacao,"->>,>>9.9999")).
                END.
                WHEN "un-consumo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.un-consumo,"X(3)")).
                END.
                WHEN "un-medida" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.un-medida,"X(3)")).
                END.
                WHEN "vl-aquisicao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-aquisicao,"->>,>>9.99")).
                END.
                WHEN "vl-depreciacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-depreciacao,"->>,>>9.99")).
                END.
                WHEN "vl-venda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-venda,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "bem-pai" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.bem-pai,"999")).
                END.
                WHEN "bem-venda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.bem-venda,"999")).
                END.
                WHEN "cd-bens" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-bens,"999")).
                END.
                WHEN "cd-moeda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-moeda,">>9")).
                END.
                WHEN "controla-consumo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.controla-consumo,"Sim/NÆo")).
                END.
                WHEN "ds-bens" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-bens,"X(40)")).
                END.
                WHEN "dt-aquisicao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-aquisicao,"99/99/9999")).
                END.
                WHEN "dt-venda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-venda,"99/99/9999")).
                END.
                WHEN "grupo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.grupo,"Sim/NÆo")).
                END.
                WHEN "imagem" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.imagem,"X(256)")).
                END.
                WHEN "pc-depreciacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.pc-depreciacao,"->>,>>9.9999")).
                END.
                WHEN "un-consumo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.un-consumo,"X(3)")).
                END.
                WHEN "un-medida" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.un-medida,"X(3)")).
                END.
                WHEN "vl-aquisicao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-aquisicao,"->>,>>9.99")).
                END.
                WHEN "vl-depreciacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-depreciacao,"->>,>>9.99")).
                END.
                WHEN "vl-venda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-venda,"->>,>>9.99")).
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
           lote-mov.tabela   = "bens"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-bens",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-bens"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-bens,"999")).

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
               lote-mov-campo.campo   = "cd-bens"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-bens,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-bens,"999")).

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