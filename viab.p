{viab.i}

DEFINE INPUT PARAMETER piPedido LIKE pedido.nr-pedido.
DEFINE OUTPUT PARAMETER TABLE FOR tt-calc-viab.

DEFINE VARIABLE iLinha AS INT INITIAL 1.

DEFINE VARIABLE de-tot-rec AS DEC.
DEFINE VARIABLE de-tot-des AS DEC.
DEFINE VARIABLE de-tot-imp AS DEC.
DEFINE VARIABLE de-tot-apo AS DEC.
DEFINE VARIABLE de-tot-mov AS DEC.
DEFINE VARIABLE de-custo AS DECIMAL     NO-UNDO.

DEFINE BUFFER bf-ped FOR pedido.
DEFINE BUFFER bf-calc FOR tt-calc-viab.
DEFINE BUFFER bf-custo FOR custo.

EMPTY TEMP-TABLE tt-calc-viab.
 
ASSIGN de-tot-rec = 0
       de-tot-imp = 0
       de-tot-des = 0
       de-tot-apo = 0.

FIND FIRST pedido 
    WHERE pedido.nr-pedido = piPedido NO-ERROR.
IF NOT AVAIL pedido THEN RETURN "NOK".

IF pedido.nr-pedido-ant <> 0 THEN RETURN "NOK".
  
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "RECEITAS"
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        iLinha = iLinha + 1.
        
 RUN calcNF.
        
 ASSIGN bf-calc.linha = iLinha
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "  TOTAL RECEITAS"
        tt-calc-viab.valor = STRING(de-tot-rec, "->>>>,>>9.99")
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "DESPESAS"
        iLinha = iLinha + 1.
        
 RUN calcDesp.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "  TOTAL DESPESAS"
        tt-calc-viab.valor = STRING(de-tot-des, "->>>>,>>9.99")
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "MARGEM BRUTA"
        tt-calc-viab.valor = STRING(de-tot-rec - de-tot-des, "->>>>,>>9.99")
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "  EBITDA"
        tt-calc-viab.valor = STRING((((de-tot-rec - de-tot-des) / de-tot-rec) * 100), "->>>9.9999") + " %" 
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        iLinha = iLinha + 1.
        
 RUN calcIMP.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "MARGEM LIQUIDA"
        tt-calc-viab.valor = STRING(de-tot-rec - de-tot-des - de-tot-imp, "->>>>,>>9.99")
        iLinha = iLinha + 1.
        
 CREATE tt-calc-viab.
 ASSIGN tt-calc-viab.linha = iLinha
        tt-calc-viab.descricao = "  Lucratividade"
        tt-calc-viab.valor = STRING((((de-tot-rec - de-tot-des - de-tot-imp) / de-tot-rec) * 100), "->>>9.9999") + " %" 
        iLinha = iLinha + 1.
        
RETURN "OK".

PROCEDURE calcNF:

    CREATE bf-calc.
    ASSIGN bf-calc.linha = 0
           bf-calc.descricao = "  A Faturar"
           bf-calc.valor = STRING(pedido.val-total, "->>>>,>>9.99")
           de-tot-rec = pedido.val-total.
               
    FOR EACH nota-fiscal OF pedido:
        ASSIGN bf-calc.descricao = "  Nota Fiscal " + STRING(nota-fiscal.nr-controle).
        FIND FIRST mov-conta OF nota-fiscal NO-ERROR.
        IF AVAIL mov-conta THEN ASSIGN bf-calc.descricao = bf-calc.descricao + " - " + STRING(mov-conta.dt-mov, "99/99/9999").
    END.
           
    FOR EACH bf-ped
        WHERE bf-ped.nr-pedido-ant = pedido.nr-pedido:
        FOR EACH nota-fiscal OF bf-ped:
            CREATE tt-calc-viab.
            ASSIGN tt-calc-viab.linha = iLinha
                   tt-calc-viab.descricao = "  Nota Fiscal " + STRING(nota-fiscal.nr-controle)
                   tt-calc-viab.valor = STRING(bf-ped.val-total, "->>>>,>>9.99")
                   bf-calc.valor = STRING((DEC(bf-calc.valor) - bf-ped.val-total), "->>>>,>>9.99")
                   iLinha = iLinha + 1.
            FIND FIRST mov-conta OF nota-fiscal NO-ERROR.
            IF AVAIL mov-conta THEN ASSIGN tt-calc-viab.descricao = tt-calc-viab.descricao + " - " + STRING(mov-conta.dt-mov, "99/99/9999").
        END.           
    END.
           

END PROCEDURE.

PROCEDURE calcDesp:

    DEFINE VARIABLE de-apont AS DEC.

    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           iLinha = iLinha + 1.

    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "  APONTAMENTOS"
           iLinha = iLinha + 1.
           
    FOR EACH apontamento OF pedido NO-LOCK
        BREAK BY apontamento.nome:
        
        FIND FIRST pedido-item OF apontamento.
        FIND FIRST item OF pedido-item.
        
        IF FIRST-OF(apontamento.nome) THEN DO:
            ASSIGN de-apont = 0.
        END.
        
        IF item.un MATCHES("*HR*") THEN DO:
            FIND FIRST custo
                WHERE custo.nome = apontamento.nome
                AND   custo.periodo = STRING(YEAR(apontamento.data), "9999") + STRING(MONTH(apontamento.data), "99") NO-LOCK NO-ERROR.
            IF NOT AVAIL custo THEN DO:
                FIND LAST custo
                    WHERE custo.nome = apontamento.nome NO-LOCK NO-ERROR.
            END.
            IF AVAIL custo THEN
                ASSIGN de-apont = de-apont + (apontamento.qt-apont * custo.val-custo).
            ELSE DO:
                FIND LAST bf-custo NO-LOCK NO-ERROR.
                SELECT AVG(val-custo) INTO de-custo FROM custo
                    WHERE custo.periodo = bf-custo.periodo.
                ASSIGN de-apont = de-apont + (apontamento.qt-apont * de-custo).
            END.
        END.
        
        IF LAST-OF(apontamento.nome) THEN DO:
            CREATE tt-calc-viab.
            ASSIGN tt-calc-viab.linha = iLinha
                   tt-calc-viab.descricao = "    " + apontamento.nome
                   tt-calc-viab.valor = STRING(de-apont, "->>>>,>>9.99")
                   de-tot-apo = de-tot-apo + de-apont
                   iLinha = iLinha + 1.
        END.
        
    END.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    TOTAL APONTAMENTOS"
           tt-calc-viab.valor = STRING(de-tot-apo, "->>>>,>>9.99")
           de-tot-des = de-tot-des + de-tot-apo
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           iLinha = iLinha + 1.

    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "  MOVIMENTOS"
           iLinha = iLinha + 1.
           
    FOR EACH mov-conta OF pedido NO-LOCK,
        FIRST favorecido OF mov-conta NO-LOCK,
            FIRST categoria OF mov-conta NO-LOCK,
                FIRST sub-cat OF mov-conta NO-LOCK
                BY mov-conta.dt-mov:
        
        CREATE tt-calc-viab.
        ASSIGN tt-calc-viab.linha = iLinha
               tt-calc-viab.descricao = "    " + STRING(mov-conta.dt-mov, "99/99/99") + " - " + favorecido.ds-favorecido + " [" + categoria.ds-categoria + "/" + sub-cat.ds-sub + "]"
               tt-calc-viab.valor = STRING((-1) * mov-conta.de-valor, "->>>>,>>9.99")
               de-tot-mov = de-tot-mov + (-1) * mov-conta.de-valor
               iLinha = iLinha + 1.
        
    END.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    TOTAL MOVIMENTOS"
           tt-calc-viab.valor = STRING(de-tot-mov, "->>>>,>>9.99")
           de-tot-des = de-tot-des + de-tot-mov
           iLinha = iLinha + 1.
                      
END PROCEDURE.

PROCEDURE calcIMP:

    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "IMPOSTOS"
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    PIS (0,65%)"
           tt-calc-viab.valor = STRING((de-tot-rec * 0.0065), "->>>>,>>9.99")
           de-tot-imp = de-tot-imp + DEC(tt-calc-viab.valor)
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    COFINS (3,00%)"
           tt-calc-viab.valor = STRING((de-tot-rec * 0.03), "->>>>,>>9.99")
           de-tot-imp = de-tot-imp + DEC(tt-calc-viab.valor)
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    CSLL (2,88%)"
           tt-calc-viab.valor = STRING((de-tot-rec * 0.0288), "->>>>,>>9.99")
           de-tot-imp = de-tot-imp + DEC(tt-calc-viab.valor)
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    IRPJ (4,80%)"
           tt-calc-viab.valor = STRING((de-tot-rec * 0.048), "->>>>,>>9.99")
           de-tot-imp = de-tot-imp + DEC(tt-calc-viab.valor)
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    ISS (2,00%)"
           tt-calc-viab.valor = STRING((de-tot-rec * 0.02), "->>>>,>>9.99")
           de-tot-imp = de-tot-imp + DEC(tt-calc-viab.valor)
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "    INSS (2,00%)"
           tt-calc-viab.valor = STRING((de-tot-rec * 0.02), "->>>>,>>9.99")
           de-tot-imp = de-tot-imp + DEC(tt-calc-viab.valor)
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           tt-calc-viab.descricao = "  TOTAL IMPOSTOS"
           tt-calc-viab.valor = STRING(de-tot-imp, "->>>>,>>9.99")
           iLinha = iLinha + 1.
           
    CREATE tt-calc-viab.
    ASSIGN tt-calc-viab.linha = iLinha
           iLinha = iLinha + 1.
           

END PROCEDURE.




