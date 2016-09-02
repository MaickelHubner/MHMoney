TRIGGER PROCEDURE FOR WRITE OF item NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-item" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-item,"99999")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-categoria,"999")).
                END.
                WHEN "controlado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.controlado,"Sim/NÆo")).
                END.
                WHEN "desp-viag" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.desp-viag,"Sim/NÆo")).
                END.
                WHEN "ds-item" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-item,"X(80)")).
                END.
                WHEN "dt-ult-compra" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-ult-compra,"99/99/9999")).
                END.
                WHEN "fator-reemb" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.fator-reemb,"->>,>>9.99")).
                END.
                WHEN "permite-dec" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.permite-dec,"Sim/NÆo")).
                END.
                WHEN "reposicao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.reposicao,">>>>9")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tipo,"9")).
                END.
                WHEN "unidade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.unidade,"X(3)")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-item" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-item,"99999")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-categoria,"999")).
                END.
                WHEN "controlado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.controlado,"Sim/NÆo")).
                END.
                WHEN "desp-viag" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.desp-viag,"Sim/NÆo")).
                END.
                WHEN "ds-item" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-item,"X(80)")).
                END.
                WHEN "dt-ult-compra" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-ult-compra,"99/99/9999")).
                END.
                WHEN "fator-reemb" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.fator-reemb,"->>,>>9.99")).
                END.
                WHEN "permite-dec" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.permite-dec,"Sim/NÆo")).
                END.
                WHEN "reposicao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.reposicao,">>>>9")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tipo,"9")).
                END.
                WHEN "unidade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.unidade,"X(3)")).
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
           lote-mov.tabela   = "item"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-item",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-item"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-item,"99999")).

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
               lote-mov-campo.campo   = "cd-item"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-item,"99999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-item,"99999")).

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