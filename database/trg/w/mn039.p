TRIGGER PROCEDURE FOR WRITE OF pedido NEW BUFFER newTab OLD BUFFER oldTab.

DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER    NO-UNDO.

FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):
    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.
    CASE cTab:
        WHEN "NEW" THEN DO:
            CASE cCampo:
                WHEN "bairro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.bairro,"X(20)")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cd-favorecido,"9999")).
                END.
                WHEN "cep" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cep,"X(10)")).
                END.
                WHEN "cidade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cidade,"X(30)")).
                END.
                WHEN "cliente-fat" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.cliente-fat,"9999")).
                END.
                WHEN "complemento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.complemento,"X(20)")).
                END.
                WHEN "dias-garantia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dias-garantia,">>9")).
                END.
                WHEN "ds-obs-cli" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-obs-cli,"x(2000)")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.ds-observacao,"X(2000)")).
                END.
                WHEN "dt-aprovacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-aprovacao,"99/99/9999")).
                END.
                WHEN "dt-encerramento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-encerramento,"99/99/9999")).
                END.
                WHEN "dt-lib-homolog" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-lib-homolog,"99/99/9999")).
                END.
                WHEN "dt-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-pedido,"99/99/9999")).
                END.
                WHEN "dt-previsao-fat" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-previsao-fat,"99/99/9999")).
                END.
                WHEN "dt-validade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.dt-validade,"99/99/9999")).
                END.
                WHEN "estado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.estado,"X(2)")).
                END.
                WHEN "nom-projeto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nom-projeto,"x(80)")).
                END.
                WHEN "nps" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nps,">9")).
                END.
                WHEN "nr-controle" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-controle,">>>>>>9")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "nr-pedido-ant" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.nr-pedido-ant,">>>>,>>9")).
                END.
                WHEN "num-cliente" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.num-cliente,"x(12)")).
                END.
                WHEN "numero" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.numero,">,>>>,>>9")).
                END.
                WHEN "pc-impto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.pc-impto,"->>9.9999")).
                END.
                WHEN "prob-fec" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.prob-fec,"9")).
                END.
                WHEN "responsavel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.responsavel,"X(8)")).
                END.
                WHEN "rua" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.rua,"X(80)")).
                END.
                WHEN "situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.situacao,"9")).
                END.
                WHEN "telefone" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.telefone,"X(20)")).
                END.
                WHEN "usuar-indicacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.usuar-indicacao,"x(8)")).
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
                WHEN "val-total" THEN DO:
                    ASSIGN cValor = TRIM(STRING(newTab.val-total,"->>,>>9.99")).
                END.
            END CASE.
        END.
        WHEN "OLD" THEN DO:
            CASE cCampo:
                WHEN "bairro" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.bairro,"X(20)")).
                END.
                WHEN "cd-favorecido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cd-favorecido,"9999")).
                END.
                WHEN "cep" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cep,"X(10)")).
                END.
                WHEN "cidade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cidade,"X(30)")).
                END.
                WHEN "cliente-fat" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.cliente-fat,"9999")).
                END.
                WHEN "complemento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.complemento,"X(20)")).
                END.
                WHEN "dias-garantia" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dias-garantia,">>9")).
                END.
                WHEN "ds-obs-cli" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-obs-cli,"x(2000)")).
                END.
                WHEN "ds-observacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.ds-observacao,"X(2000)")).
                END.
                WHEN "dt-aprovacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-aprovacao,"99/99/9999")).
                END.
                WHEN "dt-encerramento" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-encerramento,"99/99/9999")).
                END.
                WHEN "dt-lib-homolog" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-lib-homolog,"99/99/9999")).
                END.
                WHEN "dt-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-pedido,"99/99/9999")).
                END.
                WHEN "dt-previsao-fat" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-previsao-fat,"99/99/9999")).
                END.
                WHEN "dt-validade" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.dt-validade,"99/99/9999")).
                END.
                WHEN "estado" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.estado,"X(2)")).
                END.
                WHEN "nom-projeto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nom-projeto,"x(80)")).
                END.
                WHEN "nps" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nps,">9")).
                END.
                WHEN "nr-controle" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-controle,">>>>>>9")).
                END.
                WHEN "nr-pedido" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-pedido,">>>>,>>9")).
                END.
                WHEN "nr-pedido-ant" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.nr-pedido-ant,">>>>,>>9")).
                END.
                WHEN "num-cliente" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.num-cliente,"x(12)")).
                END.
                WHEN "numero" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.numero,">,>>>,>>9")).
                END.
                WHEN "pc-impto" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.pc-impto,"->>9.9999")).
                END.
                WHEN "prob-fec" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.prob-fec,"9")).
                END.
                WHEN "responsavel" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.responsavel,"X(8)")).
                END.
                WHEN "rua" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.rua,"X(80)")).
                END.
                WHEN "situacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.situacao,"9")).
                END.
                WHEN "telefone" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.telefone,"X(20)")).
                END.
                WHEN "usuar-indicacao" THEN DO:
                    ASSIGN cValor = TRIM(STRING(oldTab.usuar-indicacao,"x(8)")).
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
           lote-mov.tabela   = "pedido"
           lote-mov.operacao = "UPD"
           lote-mov.origem   = param-mn.maquina-local
           lote-mov.num-mov  = iNum.

    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult.

    IF LOOKUP("nr-pedido",cResult) <> 0 THEN DO:

        ASSIGN lote-mov.operacao = "CRE".

        CREATE lote-mov-campo.
        ASSIGN lote-mov-campo.num-mov = iNum
               lote-mov-campo.campo   = "nr-pedido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(newTab.nr-pedido,">>>>,>>9")).

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
               lote-mov-campo.campo   = "nr-pedido"
               lote-mov-campo.chave   = YES
               lote-mov-campo.origem  = param-mn.maquina-local
               lote-mov-campo.antes   = TRIM(STRING(oldTab.nr-pedido,">>>>,>>9")).
               lote-mov-campo.depois  = TRIM(STRING(newTab.nr-pedido,">>>>,>>9")).

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