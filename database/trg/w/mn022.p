TRIGGER PROCEDURE FOR WRITE OF nivel-projeto NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-nivel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-nivel,">>9")).
                END.
                WHEN "cd-projeto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-projeto,"999")).
                END.
                WHEN "ds-nivel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-nivel,"X(40)")).
                END.
                WHEN "nivel-pai" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nivel-pai,">>9")).
                END.
                WHEN "passivo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.passivo,"Sim/NÆo")).
                END.
                WHEN "val-estimado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-estimado,"->>,>>9.99")).
                END.
                WHEN "val-planejado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-planejado,"->>,>>9.99")).
                END.
                WHEN "val-real" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-real,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-nivel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-nivel,">>9")).
                END.
                WHEN "cd-projeto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-projeto,"999")).
                END.
                WHEN "ds-nivel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-nivel,"X(40)")).
                END.
                WHEN "nivel-pai" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nivel-pai,">>9")).
                END.
                WHEN "passivo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.passivo,"Sim/NÆo")).
                END.
                WHEN "val-estimado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-estimado,"->>,>>9.99")).
                END.
                WHEN "val-planejado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-planejado,"->>,>>9.99")).
                END.
                WHEN "val-real" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-real,"->>,>>9.99")).
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
           lote-mov.tabela   = "nivel-projeto"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-projeto",cResult) <> 0
    OR LOOKUP("cd-nivel",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-projeto"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-projeto,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-nivel"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-nivel,">>9")).

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
               lote-mov-campo.campo   = "cd-projeto"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-projeto,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-projeto,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-nivel"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-nivel,">>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-nivel,">>9")).

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