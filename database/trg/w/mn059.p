TRIGGER PROCEDURE FOR WRITE OF meta NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "ano" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ano,"9999")).
                END.
                WHEN "cd-meta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-meta,">>9")).
                END.
                WHEN "ds-meta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-meta,"x(60)")).
                END.
                WHEN "formula" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.formula,"x(2000)")).
                END.
                WHEN "frequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.frequencia,">9")).
                END.
                WHEN "val-meta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-meta[1],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[1],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[2],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[3],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[4],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[5],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[6],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[7],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[8],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[9],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[10],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[11],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(newTab.val-meta[12],"->>>,>>>,>>9.9999")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "ano" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ano,"9999")).
                END.
                WHEN "cd-meta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-meta,">>9")).
                END.
                WHEN "ds-meta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-meta,"x(60)")).
                END.
                WHEN "formula" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.formula,"x(2000)")).
                END.
                WHEN "frequencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.frequencia,">9")).
                END.
                WHEN "val-meta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-meta[1],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[1],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[2],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[3],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[4],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[5],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[6],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[7],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[8],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[9],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[10],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[11],"->>>,>>>,>>9.9999")) + "|" +
                                    TRIM(STRING(oldTab.val-meta[12],"->>>,>>>,>>9.9999")).
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
           lote-mov.tabela   = "meta"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-meta",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-meta"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-meta,">>9")).

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
               lote-mov-campo.campo   = "cd-meta"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-meta,">>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-meta,">>9")).

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