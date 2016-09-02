TRIGGER PROCEDURE FOR WRITE OF sub-cat NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-categoria,"999")).
                END.
                WHEN "ds-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-sub,"X(40)")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.id-tipo,"->,>>>,>>9")).
                END.
                WHEN "inflacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.inflacao,"Sim/NÆo")).
                END.
                WHEN "l-ir" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.l-ir,"Sim/NÆo")).
                END.
                WHEN "obriga-num" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.obriga-num,"Sim/NÆo")).
                END.
                WHEN "reembolso" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.reembolso,"Sim/NÆo")).
                END.
                WHEN "tp-ir" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tp-ir,"9")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-categoria,"999")).
                END.
                WHEN "ds-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-sub,"X(40)")).
                END.
                WHEN "id-tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.id-tipo,"->,>>>,>>9")).
                END.
                WHEN "inflacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.inflacao,"Sim/NÆo")).
                END.
                WHEN "l-ir" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.l-ir,"Sim/NÆo")).
                END.
                WHEN "obriga-num" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.obriga-num,"Sim/NÆo")).
                END.
                WHEN "reembolso" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.reembolso,"Sim/NÆo")).
                END.
                WHEN "tp-ir" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tp-ir,"9")).
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
           lote-mov.tabela   = "sub-cat"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cod-categoria",cResult) <> 0
    OR LOOKUP("cd-sub",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cod-categoria"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cod-categoria,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-sub"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-sub,"999")).

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
               lote-mov-campo.campo   = "cod-categoria"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cod-categoria,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cod-categoria,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-sub"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-sub,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-sub,"999")).

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