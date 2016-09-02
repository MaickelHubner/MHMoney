TRIGGER PROCEDURE FOR WRITE OF item-orcamento NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "cd-orcamento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-orcamento,"999")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cod-categoria,"999")).
                END.
                WHEN "vl-espontaneo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-espontaneo[1],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[1],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[2],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[3],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[4],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[5],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[6],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[7],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[8],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[9],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[10],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[11],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(newTab.vl-espontaneo[12],"->>,>>9.99")).
                END.
                WHEN "vl-mes" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-mes,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "cd-orcamento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-orcamento,"999")).
                END.
                WHEN "cd-sub" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-sub,"999")).
                END.
                WHEN "cod-categoria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cod-categoria,"999")).
                END.
                WHEN "vl-espontaneo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-espontaneo[1],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[1],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[2],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[3],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[4],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[5],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[6],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[7],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[8],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[9],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[10],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[11],"->>,>>9.99")) + "|" +
                                    TRIM(STRING(oldTab.vl-espontaneo[12],"->>,>>9.99")).
                END.
                WHEN "vl-mes" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-mes,"->>,>>9.99")).
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
           lote-mov.tabela   = "item-orcamento"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-orcamento",cResult) <> 0
    OR LOOKUP("cod-categoria",cResult) <> 0
    OR LOOKUP("cd-sub",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-orcamento"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-orcamento,"999")).

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
               lote-mov-campo.campo   = "cd-orcamento"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-orcamento,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-orcamento,"999")).

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