TRIGGER PROCEDURE FOR WRITE OF contato NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "area-empresa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.area-empresa,"x(60)")).
                END.
                WHEN "ativo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ativo,"Sim/NÆo")).
                END.
                WHEN "cargo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cargo,"x(40)")).
                END.
                WHEN "cd-contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-contato,"->,>>>,>>9")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-favorecido,"9999")).
                END.
                WHEN "celular" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.celular,"X(20)")).
                END.
                WHEN "data-nasc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.data-nasc,"99/99/9999")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-observacao,"x(2000)")).
                END.
                WHEN "email" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.email,"x(100)")).
                END.
                WHEN "foto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.foto,"x(80)")).
                END.
                WHEN "mensageiro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.mensageiro,"x(200)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome,"X(60)")).
                END.
                WHEN "nome-apelido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nome-apelido,"X(20)")).
                END.
                WHEN "telefone" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.telefone,"X(20)")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "area-empresa" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.area-empresa,"x(60)")).
                END.
                WHEN "ativo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ativo,"Sim/NÆo")).
                END.
                WHEN "cargo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cargo,"x(40)")).
                END.
                WHEN "cd-contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-contato,"->,>>>,>>9")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "celular" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.celular,"X(20)")).
                END.
                WHEN "data-nasc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.data-nasc,"99/99/9999")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-observacao,"x(2000)")).
                END.
                WHEN "email" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.email,"x(100)")).
                END.
                WHEN "foto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.foto,"x(80)")).
                END.
                WHEN "mensageiro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.mensageiro,"x(200)")).
                END.
                WHEN "nome" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome,"X(60)")).
                END.
                WHEN "nome-apelido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nome-apelido,"X(20)")).
                END.
                WHEN "telefone" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.telefone,"X(20)")).
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
           lote-mov.tabela   = "contato"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-favorecido",cResult) <> 0
    OR LOOKUP("cd-contato",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-favorecido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-favorecido,"9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-contato"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-contato,"->,>>>,>>9")).

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
               lote-mov-campo.campo   = "cd-favorecido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-favorecido,"9999")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-favorecido,"9999")).

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-contato"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.cd-contato,"->,>>>,>>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.cd-contato,"->,>>>,>>9")).

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