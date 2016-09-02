TRIGGER PROCEDURE FOR WRITE OF conta NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-conta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-conta,"999")).
                END.
                WHEN "cd-fav-padrao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-fav-padrao,"9999")).
                END.
                WHEN "cd-moeda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-moeda,">>9")).
                END.
                WHEN "dia-fat" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dia-fat,"->>9")).
                END.
                WHEN "dinheiro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dinheiro,"Sim/NÆo")).
                END.
                WHEN "ds-conta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-conta,"X(30)")).
                END.
                WHEN "dt-saldo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-saldo,"99/99/9999")).
                END.
                WHEN "id-encerrada" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.id-encerrada,"yes/no")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.id-tipo,"9")).
                END.
                WHEN "perc-ir" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.perc-ir,">>9.99")).
                END.
                WHEN "vl-limite" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-limite,"->>,>>9.99")).
                END.
                WHEN "vl-saldo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-saldo,"->>,>>9.99")).
                END.
                WHEN "vl-saldo-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-saldo-ini,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-conta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-conta,"999")).
                END.
                WHEN "cd-fav-padrao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-fav-padrao,"9999")).
                END.
                WHEN "cd-moeda" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-moeda,">>9")).
                END.
                WHEN "dia-fat" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dia-fat,"->>9")).
                END.
                WHEN "dinheiro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dinheiro,"Sim/NÆo")).
                END.
                WHEN "ds-conta" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-conta,"X(30)")).
                END.
                WHEN "dt-saldo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-saldo,"99/99/9999")).
                END.
                WHEN "id-encerrada" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.id-encerrada,"yes/no")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.id-tipo,"9")).
                END.
                WHEN "perc-ir" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.perc-ir,">>9.99")).
                END.
                WHEN "vl-limite" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-limite,"->>,>>9.99")).
                END.
                WHEN "vl-saldo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-saldo,"->>,>>9.99")).
                END.
                WHEN "vl-saldo-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-saldo-ini,"->>,>>9.99")).
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
           lote-mov.tabela   = "conta"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-conta",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-conta"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-conta,"999")).

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