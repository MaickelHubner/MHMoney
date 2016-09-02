DEFINE TEMP-TABLE tt-acomp
    FIELD cod AS INTEGER
    FIELD descricao AS CHARACTER COLUMN-LABEL "" FORMAT "X(120)"
    FIELD vl-prev AS DECIMAL FORMAT "->>>>,>>>,>>9.99" COLUMN-LABEL "Vl. Previsto"
    FIELD vl-real AS DECIMAL FORMAT "->>>>,>>>,>>9.99" COLUMN-LABEL "Vl. Realizado"
    FIELD vl-dif  AS DECIMAL FORMAT "->>>>,>>>,>>9.99" COLUMN-LABEL "Diferen‡a"
    FIELD cod-cat AS INTEGER
    FIELD cd-sub AS INTEGER
    FIELD registros AS CHAR EXTENT 10
    FIELD cont-reg AS INT INITIAL 1
    {&Campo}
    INDEX mensal IS PRIMARY cod ASCENDING.

DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE BUFFER bfItem FOR item-orcamento.
DEFINE BUFFER bfAcomp FOR tt-acomp.
DEFINE BUFFER bfReg FOR tt-acomp.

FUNCTION fnReg RETURNS LOGICAL (iCod AS INT, cRow AS CHAR):

    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE lJaExiste AS LOGICAL     NO-UNDO INITIAL NO.

    FIND FIRST bfReg
        WHERE bfReg.cod = iCod NO-ERROR.
    IF AVAIL bfReg THEN DO:

        blk-proc:
        REPEAT iAux = 1 TO bfReg.cont-reg:
            IF INDEX(bfReg.registros[iAux], cRow) <> 0 THEN ASSIGN lJaExiste = TRUE.
            LEAVE blk-proc.
        END.

        IF NOT lJaExiste THEN DO:
            IF LENGTH(bfReg.registros[bfReg.cont-reg]) + LENGTH(cRow) > 30000 THEN
                ASSIGN bfReg.cont-reg = bfReg.cont-reg + 1.
            ASSIGN bfReg.registros[bfReg.cont-reg] = bfReg.registros[bfReg.cont-reg] + cRow + ",".
        END.

    END.

    RETURN TRUE.

END FUNCTION. 

FUNCTION fnRegCopy RETURNS LOGICAL (iCodFrom AS INT, iCodTo AS INT):

    DEFINE VARIABLE iReg AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cRow AS CHARACTER   NO-UNDO.

    FIND FIRST bfReg
        WHERE bfReg.cod = iCodFrom NO-ERROR.
    IF AVAIL bfReg THEN DO:
        REPEAT iReg = 1 TO bfReg.cont-reg:
            REPEAT iCont = 1 TO NUM-ENTRIES(bfReg.registros[iReg]):
                ASSIGN cRow = ENTRY(iCont, bfReg.registros[iReg]).
                IF cRow <> "" THEN DO:
                    fnReg(iCodTo, cRow).
                END.
            END.
        END.
    END.
    
    RETURN TRUE.

END FUNCTION. 

FUNCTION fnRegCopyLista RETURNS LOGICAL (iCod AS INT, cLista AS LONGCHAR):

    DEFINE VARIABLE iCont AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cRow AS CHARACTER   NO-UNDO.

    REPEAT iCont = 1 TO NUM-ENTRIES(cLista):
        ASSIGN cRow = ENTRY(iCont, cLista).
        fnReg(iCod, cRow).
    END.

    RETURN TRUE.

END FUNCTION. 

{cotacao.i}

PROCEDURE criaTTacomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT  PARAMETER iMesDe  AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iMesAte AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iOrc AS INTEGER    NO-UNDO.
    
    FOR EACH tt-acomp:
        DELETE tt-acomp.
    END.

    RUN TTreceitas (INPUT iMesDe, INPUT iMesAte, INPUT iOrc).
    RUN TTPoupanca (INPUT iMesDe, INPUT iMesAte, INPUT iOrc).
    RUN TTDespesas (INPUT iMesDe, INPUT iMesAte, INPUT iOrc).

    FOR EACH tt-acomp:
        ASSIGN tt-acomp.vl-dif = tt-acomp.vl-real - tt-acomp.vl-prev.
    END.

END PROCEDURE.

PROCEDURE TTdespesas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER iMesDe  AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iMesAte AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iOrc AS INTEGER    NO-UNDO.

    DEFINE VARIABLE deMes AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iCat  AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dMesc AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE cReg AS LONGCHAR  NO-UNDO.

    DEFINE VARIABLE iNumMeses AS INTEGER    NO-UNDO.

    FIND FIRST orcamento WHERE orcamento.cd-orcamento = iOrc NO-LOCK.

    ASSIGN iNumMeses = iMesAte - iMesDe + 1.
    
    /* Despesas */

    CREATE tt-acomp.
    ASSIGN tt-acomp.cod = iCont
           iCont = iCont + 1.

    CREATE tt-acomp.
    ASSIGN tt-acomp.cod = iCont
           tt-acomp.descricao = "DESPESAS"
           iCont = iCont + 1
           iCat = tt-acomp.cod
           dMesc = 0.

    FOR EACH categoria NO-LOCK
        WHERE categoria.id-tipo = 2
        BY categoria.ds-categoria:

        IF CAN-FIND(FIRST bfItem
                    WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria) THEN DO:

            CREATE tt-acomp.
            ASSIGN tt-acomp.cod = iCont
                   tt-acomp.descricao = "     " + categoria.ds-categoria
                   tt-acomp.cod-cat = categoria.cod-categoria
                   iCont = iCont + 1
                   deMes = 0
                   iTemp = tt-acomp.cod.

            FOR EACH sub-cat OF categoria NO-LOCK
                BY sub-cat.ds-sub:

                FIND FIRST bfItem
                    WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria
                    AND   bfItem.cd-sub = sub-cat.cd-sub NO-LOCK NO-ERROR.
                IF AVAIL bfItem THEN DO:

                    CREATE tt-acomp.
                    ASSIGN tt-acomp.cod = iCont
                           tt-acomp.descricao = "          " + sub-cat.ds-sub
                           tt-acomp.cod-cat = categoria.cod-categoria
                           tt-acomp.cd-sub = sub-cat.cd-sub
                           tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
                           iCont = iCont + 1.
                    REPEAT iAux = iMesDe TO iMesAte:
                        ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
                    END.
                    ASSIGN deMes = deMes + tt-acomp.vl-prev.

                END.

            END.
            FIND FIRST bfItem
                WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
                AND   bfItem.cod-categoria = categoria.cod-categoria
                AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
            IF AVAIL bfItem THEN DO:

                CREATE tt-acomp.
                ASSIGN tt-acomp.cod = iCont
                       tt-acomp.descricao = "          GERAL"
                       tt-acomp.cod-cat = categoria.cod-categoria
                       tt-acomp.cd-sub = 999
                       tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
                       iCont = iCont + 1.
                REPEAT iAux = iMesDe TO iMesAte:
                    ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
                END.
                ASSIGN deMes = deMes + tt-acomp.vl-prev.

            END.

            FIND FIRST tt-acomp WHERE tt-acomp.cod = iTemp.
            ASSIGN tt-acomp.vl-prev = deMes
                   dMesc = dMesc + deMes.

        END.

    END.
    FIND FIRST bfItem
        WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
        AND   bfItem.cod-categoria = 998
        AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
    IF AVAIL bfItem THEN DO:

        CREATE tt-acomp.
        ASSIGN tt-acomp.cod = iCont
               tt-acomp.descricao = "     OUTROS"
               tt-acomp.cod-cat = 998
               tt-acomp.cd-sub = 999
               tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
               iCont = iCont + 1.
        REPEAT iAux = iMesDe TO iMesAte:
            ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
        END.
        ASSIGN dMesc = dMesc + tt-acomp.vl-prev.

    END.

    FIND FIRST tt-acomp WHERE tt-acomp.cod = iCat.
    ASSIGN tt-acomp.vl-prev = dMesc.

    /* Despesas realizado */

    FOR EACH mov-conta
        WHERE mov-conta.dt-mov >= DATE(iMesDe,1,orcamento.ano)
        AND   mov-conta.dt-mov <= (DATE(IF iMesAte <> 12 THEN (iMesAte + 1) ELSE 1,1,
                                       IF iMesAte <> 12 THEN orcamento.ano ELSE (orcamento.ano + 1)) - 1)
        AND   mov-conta.de-valor < 0
        AND   mov-conta.id-tipo <> 3
        AND   mov-conta.id-tipo <> 0 NO-LOCK:

        FIND FIRST tt-acomp 
            WHERE tt-acomp.cod-cat = mov-conta.cod-categoria
            AND   tt-acomp.cd-sub = mov-conta.cd-sub NO-ERROR.
        IF AVAIL tt-acomp THEN DO:
            ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + (fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov) * (-1)).
            fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
        END.
        ELSE DO:
            FIND FIRST tt-acomp 
                WHERE tt-acomp.cod-cat = mov-conta.cod-categoria
                AND   tt-acomp.cd-sub = 999 NO-ERROR.
            IF AVAIL tt-acomp THEN DO:
                ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + (fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov) * (-1)).
                fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
            END.
            ELSE DO:
                FIND FIRST tt-acomp 
                    WHERE tt-acomp.cod-cat = 998
                    AND   tt-acomp.cd-sub = 999 NO-ERROR.
                IF AVAIL tt-acomp THEN DO:
                    ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + (fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov) * (-1)).
                    fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                END.
                ELSE DO:
                    CREATE tt-acomp.
                    ASSIGN tt-acomp.cod = iCont
                           tt-acomp.descricao = "     OUTROS"
                           tt-acomp.cod-cat = 998
                           tt-acomp.cd-sub = 999
                           iCont = iCont + 1.
                    fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                    ASSIGN tt-acomp.vl-real = (fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov) * (-1)).
                END.
            END.
        END.    
    
    END.
    ASSIGN deTemp = 0
           cReg = "".
    FOR EACH tt-acomp 
        WHERE tt-acomp.cod-cat <> 0
        AND   tt-acomp.cd-sub = 0
        AND   tt-acomp.vl-real = 0:

        FOR EACH bfAcomp
            WHERE bfAcomp.cod-cat = tt-acomp.cod-cat:

            ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + bfAcomp.vl-real.
            fnRegCopy(bfAcomp.cod, tt-acomp.cod).

        END.
        ASSIGN deTemp = deTemp + tt-acomp.vl-real.
        REPEAT iAux = 1 TO tt-acomp.cont-reg:
            ASSIGN cReg = cReg + tt-acomp.registros[iAux].
        END.

    END.
    FIND FIRST tt-acomp WHERE tt-acomp.descricao = "DESPESAS".
    ASSIGN tt-acomp.vl-real = deTemp.
    fnRegCopyLista(tt-acomp.cod, cReg).
    FIND FIRST bfAcomp WHERE bfAcomp.cod-cat = 998 NO-LOCK NO-ERROR.
    IF AVAIL bfAcomp THEN DO:
        ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + bfAcomp.vl-real.
        fnRegCopy(bfAcomp.cod, tt-acomp.cod).
    END.


END PROCEDURE.

PROCEDURE TTpoupanca :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER iMesDe  AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iMesAte AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iOrc AS INTEGER    NO-UNDO.

    DEFINE VARIABLE deMes AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iCat  AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dMesc AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE cReg AS LONGCHAR  NO-UNDO.
    DEFINE VARIABLE lContou AS LOGICAL    NO-UNDO.

    DEFINE VARIABLE iNumMeses AS INTEGER    NO-UNDO.

    FIND FIRST orcamento WHERE orcamento.cd-orcamento = iOrc NO-LOCK.

    ASSIGN iNumMeses = iMesAte - iMesDe + 1.
    
    /* Poupan‡a */

    CREATE tt-acomp.
    ASSIGN tt-acomp.cod = iCont
           iCont = iCont + 1.

    CREATE tt-acomp.
    ASSIGN tt-acomp.cod = iCont
           tt-acomp.descricao = "CONTRIBUI€åES · POUPAN€A"
           iCont = iCont + 1
           iCat = tt-acomp.cod
           dMesc = 0.
    FOR EACH item-poupanca WHERE item-poupanca.ano = orcamento.ano NO-LOCK:

        FIND FIRST poupanca OF item-poupanca NO-LOCK.
        IF poupanca.simulacao THEN NEXT.

        CREATE tt-acomp.
        ASSIGN tt-acomp.cod = iCont
               tt-acomp.descricao = "     " + poupanca.ds-poupanca
               tt-acomp.cd-sub = poupanca.cd-poupanca /*cd-conta*/
               tt-acomp.vl-prev = (item-poupanca.vl-deposito * iNumMeses)
               iCont = iCont + 1.
        REPEAT iAux = iMesDe TO iMesAte:
            ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + item-poupanca.vl-espontaneo[iAux].
        END.
        ASSIGN dMesc = dMesc + tt-acomp.vl-prev.

    END.
    FOR EACH conta WHERE conta.id-tipo = 2 NO-LOCK:
        FIND FIRST bfItem
            WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
            AND   bfItem.cod-categoria = 997
            AND   bfItem.cd-sub = conta.cd-conta NO-LOCK NO-ERROR.
        IF AVAIL bfItem THEN DO:

            CREATE tt-acomp.
            ASSIGN tt-acomp.cod = iCont
                   tt-acomp.descricao = "     " + conta.ds-conta
                   tt-acomp.cod-cat = 997
                   tt-acomp.cd-sub = conta.cd-conta
                   tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
                   iCont = iCont + 1.
            REPEAT iAux = iMesDe TO iMesAte:
                ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
            END.
            ASSIGN dMesc = dMesc + tt-acomp.vl-prev.

        END.
    END.
    FIND FIRST tt-acomp WHERE tt-acomp.cod = iCat.
    ASSIGN tt-acomp.vl-prev = dMesc.

    /* Poupan‡a realizado */

    FOR EACH mov-conta
        WHERE mov-conta.dt-mov >= DATE(iMesDe,1,orcamento.ano)
        AND   mov-conta.dt-mov <= (DATE(IF iMesAte <> 12 THEN (iMesAte + 1) ELSE 1,1,
                                       IF iMesAte <> 12 THEN orcamento.ano ELSE (orcamento.ano + 1)) - 1)
        AND   mov-conta.id-tipo = 3 NO-LOCK:

        FIND FIRST conta WHERE conta.cd-conta = mov-conta.cd-conta NO-LOCK.
        IF conta.id-tipo <> 2 THEN NEXT.

        ASSIGN lContou = NO.

        FOR EACH item-poupanca NO-LOCK
            WHERE item-poupanca.ano = YEAR(mov-conta.dt-mov):
            IF NOT lContou THEN DO:
                FIND FIRST poupanca OF item-poupanca NO-LOCK NO-ERROR.
                IF NOT CAN-FIND(FIRST poup-conta
                                WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca
                                AND   poup-conta.cd-conta = conta.cd-conta) THEN NEXT.
                IF poupanca.cd-fav-padrao = mov-conta.cd-favorecido THEN DO:
                    FIND FIRST tt-acomp 
                        WHERE tt-acomp.cod-cat = 0
                        AND   tt-acomp.cd-sub = poupanca.cd-poupanca /*conta.cd-conta*/ NO-ERROR.
                    IF AVAIL tt-acomp THEN DO:
                        ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)
                               lContou = YES.
                        fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                    END.

                END.
                ELSE DO:

                    IF NOT CAN-FIND(FIRST poupanca
                                    WHERE poupanca.cd-fav-padrao = mov-conta.cd-favorecido) THEN DO:

                        FIND FIRST tt-acomp 
                            WHERE tt-acomp.cod-cat = 997
                            AND   tt-acomp.cd-sub = conta.cd-conta NO-ERROR.
                        IF AVAIL tt-acomp THEN DO:
                            ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)
                                   lContou = YES.
                            fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                        END.
                        ELSE DO:
                            CREATE tt-acomp.
                            ASSIGN tt-acomp.cod = iCont
                                   tt-acomp.descricao = "     " + conta.ds-conta
                                   tt-acomp.cod-cat = 997
                                   tt-acomp.cd-sub = conta.cd-conta
                                   iCont = iCont + 1.
                            fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                            ASSIGN tt-acomp.vl-real = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)
                                   lContou = YES.
                        END.

                    END.

                END.
            END.
        END.

        IF NOT lContou THEN DO:

            FIND FIRST tt-acomp 
                WHERE tt-acomp.cod-cat = 997
                AND   tt-acomp.cd-sub = conta.cd-conta NO-ERROR.
            IF AVAIL tt-acomp THEN DO:
                ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
            END.
            ELSE DO:
                CREATE tt-acomp.
                ASSIGN tt-acomp.cod = iCont
                       tt-acomp.descricao = "     " + conta.ds-conta
                       tt-acomp.cod-cat = 997
                       tt-acomp.cd-sub = conta.cd-conta
                       iCont = iCont + 1.
                fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                ASSIGN tt-acomp.vl-real = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
            END.

        END.
    
    END.

    FIND FIRST tt-acomp WHERE tt-acomp.descricao = "CONTRIBUI€åES · POUPAN€A".
    FOR EACH bfAcomp
        WHERE bfAcomp.cd-sub <> 0
        AND   (bfAcomp.cod-cat = 0 OR bfAcomp.cod-cat = 997) NO-LOCK:

        ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + bfAcomp.vl-real.
        fnRegCopy(bfAcomp.cod, tt-acomp.cod).

    END.

END PROCEDURE.

PROCEDURE TTreceitas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER iMesDe  AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iMesAte AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iOrc AS INTEGER    NO-UNDO.

    DEFINE VARIABLE deMes AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iCat  AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dMesc AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE cReg AS CHARACTER  NO-UNDO.

    DEFINE VARIABLE iNumMeses AS INTEGER    NO-UNDO.

    FIND FIRST orcamento WHERE orcamento.cd-orcamento = iOrc NO-LOCK.

    ASSIGN iNumMeses = iMesAte - iMesDe + 1.
    
    /* Receitas */

    ASSIGN iCont = 1.
    CREATE tt-acomp.
    ASSIGN tt-acomp.cod = iCont
           tt-acomp.descricao = "RECEITAS"
           iCont = iCont + 1
           iCat = tt-acomp.cod
           dMesc = 0.

    FOR EACH categoria NO-LOCK
        WHERE categoria.id-tipo = 1
        BY categoria.ds-categoria:

        IF CAN-FIND(FIRST bfItem
                    WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria) THEN DO:
            
            CREATE tt-acomp.
            ASSIGN tt-acomp.cod = iCont
                   tt-acomp.descricao = "     " + categoria.ds-categoria
                   tt-acomp.cod-cat = categoria.cod-categoria
                   iCont = iCont + 1
                   deMes = 0
                   iTemp = tt-acomp.cod.

            FOR EACH sub-cat OF categoria NO-LOCK
                BY sub-cat.ds-sub:

                FIND FIRST bfItem
                    WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria
                    AND   bfItem.cd-sub = sub-cat.cd-sub NO-LOCK NO-ERROR.
                IF AVAIL bfItem THEN DO:

                    CREATE tt-acomp.
                    ASSIGN tt-acomp.cod = iCont
                           tt-acomp.descricao = "          " + sub-cat.ds-sub
                           tt-acomp.cod-cat = categoria.cod-categoria
                           tt-acomp.cd-sub = sub-cat.cd-sub
                           tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
                           iCont = iCont + 1.
                    REPEAT iAux = iMesDe TO iMesAte:
                        ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
                    END.
                    ASSIGN deMes = deMes + tt-acomp.vl-prev.

                END.

            END.
            FIND FIRST bfItem
                WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
                AND   bfItem.cod-categoria = categoria.cod-categoria
                AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
            IF AVAIL bfItem THEN DO:

                CREATE tt-acomp.
                ASSIGN tt-acomp.cod = iCont
                       tt-acomp.descricao = "          GERAL"
                       tt-acomp.cod-cat = categoria.cod-categoria
                       tt-acomp.cd-sub = 999
                       tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
                       iCont = iCont + 1.
                REPEAT iAux = iMesDe TO iMesAte:
                    ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
                END.
                ASSIGN deMes = deMes + tt-acomp.vl-prev.

            END.

            FIND FIRST tt-acomp WHERE tt-acomp.cod = iTemp.
            ASSIGN tt-acomp.vl-prev = deMes
                   dMesc = dMesc + deMes.

        END.

    END.
    FIND FIRST bfItem
        WHERE bfItem.cd-orcamento = orcamento.cd-orcamento
        AND   bfItem.cod-categoria = 999
        AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
    IF AVAIL bfItem THEN DO:

        CREATE tt-acomp.
        ASSIGN tt-acomp.cod = iCont
               tt-acomp.descricao = "     OUTROS"
               tt-acomp.cod-cat = 999
               tt-acomp.cd-sub = 999
               tt-acomp.vl-prev = (bfItem.vl-mes * iNumMeses)
               iCont = iCont + 1.
        REPEAT iAux = iMesDe TO iMesAte:
            ASSIGN tt-acomp.vl-prev = tt-acomp.vl-prev + bfItem.vl-espontaneo[iAux].
        END.
        ASSIGN deMes = deMes + tt-acomp.vl-prev
               dMesc = dMesc + tt-acomp.vl-prev.

    END.

    FIND FIRST tt-acomp WHERE tt-acomp.cod = iCat.
    ASSIGN tt-acomp.vl-prev = dMesc.

    /* Receitas realizado */

    FOR EACH mov-conta
        WHERE mov-conta.dt-mov >= DATE(iMesDe,1,orcamento.ano)
        AND   mov-conta.dt-mov <= (DATE(IF iMesAte <> 12 THEN (iMesAte + 1) ELSE 1,1,
                                       IF iMesAte <> 12 THEN orcamento.ano ELSE (orcamento.ano + 1)) - 1)
        AND   mov-conta.de-valor > 0
        AND   mov-conta.id-tipo <> 3
        AND   mov-conta.id-tipo <> 0 NO-LOCK:
    
        FIND FIRST tt-acomp 
            WHERE tt-acomp.cod-cat = mov-conta.cod-categoria
            AND   tt-acomp.cd-sub = mov-conta.cd-sub NO-ERROR.
        IF AVAIL tt-acomp THEN DO:
            ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
            fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
        END.
        ELSE DO:
            FIND FIRST tt-acomp 
                WHERE tt-acomp.cod-cat = mov-conta.cod-categoria
                AND   tt-acomp.cd-sub = 999 NO-ERROR.
            IF AVAIL tt-acomp THEN DO:
                ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
            END.
            ELSE DO:
                FIND FIRST tt-acomp 
                    WHERE tt-acomp.cod-cat = 999
                    AND   tt-acomp.cd-sub = 999 NO-ERROR.
                IF AVAIL tt-acomp THEN DO:
                    ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                    fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                END.
                ELSE DO:
                    CREATE tt-acomp.
                    ASSIGN tt-acomp.cod = iCont
                           tt-acomp.descricao = "     OUTROS"
                           tt-acomp.cod-cat = 999
                           tt-acomp.cd-sub = 999
                           iCont = iCont + 1.
                    fnReg(tt-acomp.cod, STRING(ROWID(mov-conta))).
                    ASSIGN tt-acomp.vl-real = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                END.
            END.
        END.    
    
    END.

    ASSIGN deTemp = 0
           cReg = "".
    FOR EACH tt-acomp 
        WHERE tt-acomp.cod-cat <> 0
        AND   tt-acomp.cd-sub = 0:

        FOR EACH bfAcomp
            WHERE bfAcomp.cod-cat = tt-acomp.cod-cat:

            ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + bfAcomp.vl-real.
            fnRegCopy(bfAcomp.cod, tt-acomp.cod).

        END.
        ASSIGN deTemp = deTemp + tt-acomp.vl-real.
        REPEAT iAux = 1 TO tt-acomp.cont-reg:
            ASSIGN cReg = cReg + tt-acomp.registros[iAux].
        END.

    END.
    FIND FIRST tt-acomp WHERE tt-acomp.descricao = "RECEITAS".
    ASSIGN tt-acomp.vl-real = deTemp.
    fnRegCopyLista(tt-acomp.cod, cReg).
    FIND FIRST bfAcomp WHERE bfAcomp.cod-cat = 999 NO-LOCK NO-ERROR.
    IF AVAIL bfAcomp THEN DO:
        ASSIGN tt-acomp.vl-real = tt-acomp.vl-real + bfAcomp.vl-real.
        fnRegCopy(bfAcomp.cod, tt-acomp.cod).
    END.

END PROCEDURE.
