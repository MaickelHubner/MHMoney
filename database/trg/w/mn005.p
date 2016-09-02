TRIGGER PROCEDURE FOR WRITE OF favorecido NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "agencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.agencia,"x(12)")).
                END.
                WHEN "ativo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ativo,"Sim/NÆo")).
                END.
                WHEN "bairro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.bairro,"X(20)")).
                END.
                WHEN "banco" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.banco,"x(40)")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-favorecido,"9999")).
                END.
                WHEN "cep" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cep,"X(10)")).
                END.
                WHEN "cgc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cgc,"X(18)")).
                END.
                WHEN "cidade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cidade,"X(30)")).
                END.
                WHEN "complemento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.complemento,"X(20)")).
                END.
                WHEN "conta-bancaria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.conta-bancaria,"x(12)")).
                END.
                WHEN "contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.contato,"x(40)")).
                END.
                WHEN "data-nasc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.data-nasc,"99/99/9999")).
                END.
                WHEN "desconto-prim-parc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.desconto-prim-parc,"yes/no")).
                END.
                WHEN "dia-pagto-padrao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dia-pagto-padrao,">9")).
                END.
                WHEN "dia-semana-pagto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dia-semana-pagto,"9")).
                END.
                WHEN "dias-uteis-pagto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dias-uteis-pagto,">9")).
                END.
                WHEN "ds-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-favorecido,"X(40)")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-observacao,"X(2000)")).
                END.
                WHEN "e-mail" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.e-mail,"x(80)")).
                END.
                WHEN "estado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.estado,"X(2)")).
                END.
                WHEN "foto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.foto,"x(80)")).
                END.
                WHEN "ins-estadual" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ins-estadual,"x(20)")).
                END.
                WHEN "numero" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.numero,">,>>>,>>9")).
                END.
                WHEN "razao-social" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.razao-social,"x(100)")).
                END.
                WHEN "rua" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.rua,"X(80)")).
                END.
                WHEN "telefone" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.telefone,"X(20)")).
                END.
                WHEN "tem-endereco" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tem-endereco,"Sim/NÆo")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tipo,"9")).
                END.
                WHEN "tipo-pagto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.tipo-pagto,"9")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "agencia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.agencia,"x(12)")).
                END.
                WHEN "ativo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ativo,"Sim/NÆo")).
                END.
                WHEN "bairro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.bairro,"X(20)")).
                END.
                WHEN "banco" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.banco,"x(40)")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "cep" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cep,"X(10)")).
                END.
                WHEN "cgc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cgc,"X(18)")).
                END.
                WHEN "cidade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cidade,"X(30)")).
                END.
                WHEN "complemento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.complemento,"X(20)")).
                END.
                WHEN "conta-bancaria" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.conta-bancaria,"x(12)")).
                END.
                WHEN "contato" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.contato,"x(40)")).
                END.
                WHEN "data-nasc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.data-nasc,"99/99/9999")).
                END.
                WHEN "desconto-prim-parc" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.desconto-prim-parc,"yes/no")).
                END.
                WHEN "dia-pagto-padrao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dia-pagto-padrao,">9")).
                END.
                WHEN "dia-semana-pagto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dia-semana-pagto,"9")).
                END.
                WHEN "dias-uteis-pagto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dias-uteis-pagto,">9")).
                END.
                WHEN "ds-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-favorecido,"X(40)")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-observacao,"X(2000)")).
                END.
                WHEN "e-mail" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.e-mail,"x(80)")).
                END.
                WHEN "estado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.estado,"X(2)")).
                END.
                WHEN "foto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.foto,"x(80)")).
                END.
                WHEN "ins-estadual" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ins-estadual,"x(20)")).
                END.
                WHEN "numero" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.numero,">,>>>,>>9")).
                END.
                WHEN "razao-social" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.razao-social,"x(100)")).
                END.
                WHEN "rua" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.rua,"X(80)")).
                END.
                WHEN "telefone" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.telefone,"X(20)")).
                END.
                WHEN "tem-endereco" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tem-endereco,"Sim/NÆo")).
                END.
                WHEN "tipo" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tipo,"9")).
                END.
                WHEN "tipo-pagto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.tipo-pagto,"9")).
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
           lote-mov.tabela   = "favorecido"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("cd-favorecido",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "cd-favorecido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.cd-favorecido,"9999")).

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