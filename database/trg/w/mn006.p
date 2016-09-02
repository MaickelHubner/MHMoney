TRIGGER PROCEDURE FOR WRITE OF agenda NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "calc-cpmf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.calc-cpmf,"Sim/NÆo")).
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
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-categoria,"999")).
                END.
                WHEN "conta-transf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.conta-transf,"999")).
                END.
                WHEN "dia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dia,"99")).
                END.
                WHEN "dt-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-fim,"99/99/9999")).
                END.
                WHEN "dt-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-ini,"99/99/9999")).
                END.
                WHEN "dt-ultimo-pag" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-ultimo-pag,"99/99/9999")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.id-tipo,"9")).
                END.
                WHEN "prox-data-pag" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.prox-data-pag,"99/99/9999")).
                END.
                WHEN "simulado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.simulado,"Sim/NÆo")).
                END.
                WHEN "usuar-resp" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.usuar-resp,"X(8)")).
                END.
                WHEN "valor" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.valor,"->>,>>9.99")).
                END.
                WHEN "vl-atual" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-atual,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "calc-cpmf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.calc-cpmf,"Sim/NÆo")).
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
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-categoria,"999")).
                END.
                WHEN "conta-transf" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.conta-transf,"999")).
                END.
                WHEN "dia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dia,"99")).
                END.
                WHEN "dt-fim" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-fim,"99/99/9999")).
                END.
                WHEN "dt-ini" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-ini,"99/99/9999")).
                END.
                WHEN "dt-ultimo-pag" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-ultimo-pag,"99/99/9999")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.id-tipo,"9")).
                END.
                WHEN "prox-data-pag" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.prox-data-pag,"99/99/9999")).
                END.
                WHEN "simulado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.simulado,"Sim/NÆo")).
                END.
                WHEN "usuar-resp" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.usuar-resp,"X(8)")).
                END.
                WHEN "valor" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.valor,"->>,>>9.99")).
                END.
                WHEN "vl-atual" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-atual,"->>,>>9.99")).
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
           lote-mov.tabela   = "agenda"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-agenda",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-agenda"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-agenda,"999")).

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
               lote-mov-campo.campo   = "cd-agenda"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-agenda,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-agenda,"999")).

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