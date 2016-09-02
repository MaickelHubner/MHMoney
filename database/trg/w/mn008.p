TRIGGER PROCEDURE FOR WRITE OF item-poupanca NEW BUFFER newTab OLD BUFFER oldTab.

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
                WHEN "cd-poupanca" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-poupanca,"999")).
                END.
                WHEN "pc-juros" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.pc-juros,"->>9.999")).
                END.
                WHEN "vl-deposito" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.vl-deposito,"->>,>>9.99")).
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
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "ano" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ano,"9999")).
                END.
                WHEN "cd-poupanca" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-poupanca,"999")).
                END.
                WHEN "pc-juros" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.pc-juros,"->>9.999")).
                END.
                WHEN "vl-deposito" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.vl-deposito,"->>,>>9.99")).
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
           lote-mov.tabela   = "item-poupanca"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-poupanca",cResult) <> 0
    OR LOOKUP("ano",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-poupanca"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-poupanca,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "ano"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.ano,"9999")).

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
               lote-mov-campo.campo   = "cd-poupanca"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-poupanca,"999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-poupanca,"999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "ano"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.ano,"9999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.ano,"9999")).

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