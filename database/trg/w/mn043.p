TRIGGER PROCEDURE FOR WRITE OF nota-fiscal NEW BUFFER newTab OLD BUFFER oldTab.

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
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-categoria,"999")).
                END.
                WHEN "cod-verificacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-verificacao,"x(40)")).
                END.
                WHEN "dt-emissao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-emissao,"99/99/9999")).
                END.
                WHEN "nr-controle" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-controle,">>>>>>9")).
                END.
                WHEN "nr-nota" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-nota,"x(8)")).
                END.
                WHEN "serie" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.serie,"x(4)")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tipo,"9")).
                END.
                WHEN "val-desconto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-desconto,"->>,>>9.99")).
                END.
                WHEN "val-impostos" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-impostos,"->>,>>9.99")).
                END.
                WHEN "val-itens" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-itens,"->>,>>9.99")).
                END.
                WHEN "val-liquido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-liquido,"->>,>>9.99")).
                END.
                WHEN "val-total" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-total,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-categoria,"999")).
                END.
                WHEN "cod-verificacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-verificacao,"x(40)")).
                END.
                WHEN "dt-emissao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-emissao,"99/99/9999")).
                END.
                WHEN "nr-controle" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-controle,">>>>>>9")).
                END.
                WHEN "nr-nota" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-nota,"x(8)")).
                END.
                WHEN "serie" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.serie,"x(4)")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tipo,"9")).
                END.
                WHEN "val-desconto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-desconto,"->>,>>9.99")).
                END.
                WHEN "val-impostos" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-impostos,"->>,>>9.99")).
                END.
                WHEN "val-itens" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-itens,"->>,>>9.99")).
                END.
                WHEN "val-liquido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-liquido,"->>,>>9.99")).
                END.
                WHEN "val-total" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.val-total,"->>,>>9.99")).
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
           lote-mov.tabela   = "nota-fiscal"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("nr-controle",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "nr-controle"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.nr-controle,">>>>>>9")).

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
               lote-mov-campo.campo   = "nr-controle"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.nr-controle,">>>>>>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.nr-controle,">>>>>>9")).

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