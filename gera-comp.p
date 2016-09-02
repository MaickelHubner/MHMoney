DEFINE INPUT PARAMETER p-rowid AS ROWID                           NO-UNDO.
DEFINE INPUT PARAMETER p-tipo  AS INT                             NO-UNDO.

/* variaveis para geraá∆o da planilha excel */
DEFINE VARIABLE cdiretorio     AS CHARACTER                       NO-UNDO.
DEFINE VARIABLE cdirdestino    AS CHARACTER                       NO-UNDO.
DEFINE VARIABLE cdir           AS CHARACTER                       NO-UNDO.
DEFINE VARIABLE icont          AS INTEGER                         NO-UNDO.
DEFINE VARIABLE errStatus      AS INT                             NO-UNDO.
DEFINE VARIABLE cfile          AS CHARACTER                       NO-UNDO.
DEFINE VARIABLE chExcel        AS COM-HANDLE                      NO-UNDO.
DEFINE VARIABLE ch-planilha1   AS COM-HANDLE                      NO-UNDO.
DEFINE VARIABLE ch-arquivo     AS COM-HANDLE                      NO-UNDO.
DEFINE VARIABLE ch-planilha    AS COM-HANDLE                      NO-UNDO.
DEFINE VARIABLE c-arq-pdf      AS CHARACTER                       NO-UNDO.
DEFINE VARIABLE c-periodo      AS CHARACTER                       NO-UNDO.
DEFINE VARIABLE de-hrs AS DECIMAL     NO-UNDO INITIAL 0.  

DEFINE BUFFER  bf-mov-conta FOR mov-conta.
DEFINE BUFFER  bf-mov2 FOR mov-conta.

ASSIGN cdirdestino    = SESSION:TEMP-DIRECTORY + "planilhaGera-Comprovante_" + STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") + "_" + STRING(TIME) + ".xlsx".
     
SESSION:SET-WAIT-STATE ("general").
/*cria a aplicaá∆o do excel*/
CREATE "Excel.Application" chExcel CONNECT NO-ERROR.
IF ERROR-STATUS:ERROR THEN DO:
    CREATE "Excel.application" chExcel.
END.    

ASSIGN cdir = ENTRY(1,cdirdestino, '~\') 
    cdiretorio = cdirdestino.
    /*Troca caracteres inv†lidos para evitar erro na criaá∆o da planilha*/
DO icont = 2 TO NUM-ENTRIES(cdiretorio, '~\') - 1:
    ASSIGN cdiretorio = REPLACE(cdiretorio, '"', '_').
    OS-CREATE-DIR VALUE(cdir + "~\" + ENTRY(icont, cdiretorio, "~\")).
    ASSIGN cdir = cdir + "~\" + ENTRY(icont, cdiretorio, "~\").
END.

ASSIGN errStatus = OS-ERROR.
IF errStatus <> 0 AND
 errStatus <> 2 THEN DO:
    CASE errStatus:
        WHEN 1 THEN
            run utp/ut-msgs.p ('show', 26692, '').
        WHEN 8 THEN 
            run utp/ut-msgs.p ('show', 26694, ''). 
        WHEN 3 THEN 
         run utp/ut-msgs.p ('show', 26695, '').
        WHEN 7 THEN  
         run utp/ut-msgs.p ('show', 26696, '').       
        WHEN 17 THEN
            RUN utp/ut-msgs.p ('show', 26697, '').
END CASE.
    RETURN NO-APPLY.
END.     
    
/*Busca a planilha modelo*/  
ASSIGN cfile = SEARCH("gera-comprovante.xlsx").

IF cFile <> ? THEN DO:
  OS-COPY VALUE(cFile) VALUE(cDiretorio).
END.
ELSE DO:
  RUN utp/ut-msgs.p (INPUT "show",
                     INPUT 1332  ,
                     INPUT "gera-comprovante.xlsx":U).
  RETURN "NOK":U.
END.

ASSIGN de-hrs = 0.

/*Abre o arquivo do excel*/
chExcel:workbooks:OPEN(cdiretorio).
ASSIGN ch-planilha1 = chExcel:sheets:ITEM(1).

ch-planilha1:activate(). 
chExcel:displayAlerts = NO.

FIND FIRST mov-conta NO-LOCK
    WHERE  ROWID(mov-conta) = p-rowid NO-ERROR.

FIND FIRST conta OF mov-conta NO-LOCK NO-ERROR.
FIND FIRST favorecido OF mov-conta NO-LOCK NO-ERROR.

FOR EACH bf-mov-conta  OF conta
    WHERE bf-mov-conta.agrupado = mov-conta.cd-sequencia:

    RUN preencheExcel.
END.

FOR EACH bf-mov-conta NO-LOCK
    WHERE bf-mov-conta.cd-favorecido = mov-conta.cd-favorecido
    AND   bf-mov-conta.dt-mov >= (mov-conta.dt-mov - 25)
    AND   bf-mov-conta.dt-mov < mov-conta.dt-mov
    AND   bf-mov-conta.id-tipo <> 0:

    RUN preencheExcel.

END.

FOR EACH bf-mov2 NO-LOCK
    WHERE bf-mov2.cd-favorecido = mov-conta.cd-favorecido
    AND   bf-mov2.dt-mov >= (mov-conta.dt-mov - 25)
    AND   bf-mov2.dt-mov < mov-conta.dt-mov
    AND   bf-mov2.id-tipo = 0:

    FOR EACH bf-mov-conta NO-LOCK
        WHERE bf-mov-conta.cd-conta = bf-mov2.cd-conta
        AND   bf-mov-conta.agrupado = bf-mov2.cd-sequencia
        AND   bf-mov-conta.cd-favorecido <> bf-mov2.cd-favorecido:
    
        RUN preencheExcel.
    
    END.

END.

chExcel:range("D12"):VALUE   = favorecido.ds-favorecido.
chExcel:range("D13"):VALUE   = STRING(YEAR(mov-conta.dt-mov),"9999") + "/" + STRING(MONTH(mov-conta.dt-mov),"99") .

CASE MONTH((mov-conta.dt-mov - 26)):
    WHEN 1 THEN ASSIGN c-periodo = "Jan".
    WHEN 2 THEN ASSIGN c-periodo = "Fev".
    WHEN 3 THEN ASSIGN c-periodo = "Mar".
    WHEN 4 THEN ASSIGN c-periodo = "Abr".
    WHEN 5 THEN ASSIGN c-periodo = "Mai".
    WHEN 6 THEN ASSIGN c-periodo = "Jun".
    WHEN 7 THEN ASSIGN c-periodo = "Jul".
    WHEN 8 THEN ASSIGN c-periodo = "Ago".
    WHEN 9 THEN ASSIGN c-periodo = "Set".
    WHEN 10 THEN ASSIGN c-periodo = "Out".
    WHEN 11 THEN ASSIGN c-periodo = "Nov".
    WHEN 12 THEN ASSIGN c-periodo = "Dez".
END CASE.

chExcel:range("C19"):VALUE   = "Retirada Fixa (Ref. a " + c-periodo + "/" + SUBSTRING(STRING(YEAR(mov-conta.dt-mov - 26), "9999"), 3, 2) + ")".

IF INT(de-hrs) <> de-hrs THEN
    chExcel:range("C20"):VALUE = "Horas Deslocamento (´) - " + TRIM(STRING(de-hrs, ">>9.99")) + "h".
ELSE
    chExcel:range("C20"):VALUE = "Horas Deslocamento (´) - " + TRIM(STRING(de-hrs, ">>9")) + "h".

IF p-tipo = 1 THEN DO:
    ASSIGN c-arq-pdf = SESSION:TEMP-DIRECTORY + "comprovante.pdf".
           ch-planilha1:ExportAsFixedFormat(0,c-arq-pdf,0,FALSE).
           DOS SILENT START VALUE(c-arq-pdf).
    chExcel:ActiveWorkbook:CLOSE.
    chExcel:QUIT.
END.

IF p-tipo = 2 THEN DO:
    chExcel:VISIBLE = TRUE.
    /*chExcel:APPLICATION:WindowState = 3.  /*-4140 Minimizado -4143 Maxmizado */     
    chExcel:sheets:ITEM(1):SELECT.*/
END.

/*Finaliza handleãs do excel*/
chexcel:QUIT().

/*Finaliza handle¡s do excel*/
IF VALID-HANDLE(ch-arquivo) THEN
   RELEASE OBJECT ch-arquivo.

IF VALID-HANDLE(chExcel) THEN
   RELEASE OBJECT chExcel.

IF VALID-HANDLE(ch-planilha1) THEN
   RELEASE OBJECT ch-planilha1.

SESSION:SET-WAIT-STATE ("").


/**************************************************************************/

PROCEDURE preencheExcel:

    /*     MESSAGE bf-mov-conta.id-tipo SKIP bf-mov-conta.cd-favorecido SKIP  bf-mov-conta.cod-categoria SKIP bf-mov-conta.cd-sub SKIP bf-mov-conta.dt-mov SKIP bf-mov-conta.de-valor SKIP */
    /*          bf-mov-conta.cd-conta SKIP  bf-mov-conta.sequencia                                                                                                                         */
    /*                                                                                                                                                                                     */
    /*                                                                                                                                                                                     */
    /*         VIEW-AS ALERT-BOX INFO BUTTONS OK.                                                                                                                                          */

    IF bf-mov-conta.id-tipo = 3 THEN DO:   
        CASE bf-mov-conta.cd-favorecido:
            WHEN 9 THEN DO:
                ASSIGN chExcel:range("I21"):VALUE = IF chExcel:range("I21"):VALUE <> ? THEN chExcel:range("I21"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
            END.
            WHEN 366 /* INSS */ THEN DO:
                IF bf-mov-conta.dt-mov = mov-conta.dt-mov THEN DO:
                    ASSIGN chExcel:range("I44"):VALUE = IF chExcel:range("I44"):VALUE <> ? THEN chExcel:range("I44"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                END.
                ELSE DO:
                    ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE - bf-mov-conta.de-valor ELSE (bf-mov-conta.de-valor * -1).
                    ASSIGN chExcel:range("I44"):VALUE = IF chExcel:range("I44"):VALUE <> ? THEN chExcel:range("I44"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                END.
            END.
            WHEN 367 THEN DO:
                ASSIGN chExcel:range("I45"):VALUE = IF chExcel:range("I45"):VALUE <> ? THEN chExcel:range("I45"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
            END.
            WHEN 370 THEN DO:
                ASSIGN chExcel:range("I39"):VALUE = IF chExcel:range("I39"):VALUE <> ? THEN chExcel:range("I39"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
            END.
            WHEN 413 THEN DO:
                ASSIGN chExcel:range("I46"):VALUE = IF chExcel:range("I46"):VALUE <> ? THEN chExcel:range("I46"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
            END.
             WHEN 494 THEN DO:
                ASSIGN chExcel:range("I39"):VALUE = IF chExcel:range("I39"):VALUE <> ? THEN chExcel:range("I39"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
            END.
        END CASE.
        IF bf-mov-conta.conta-transf = 7 /* M£tuos */ THEN DO:
            IF bf-mov-conta.cd-favorecido = mov-conta.cd-favorecido THEN DO:
                ASSIGN chExcel:range("I22"):VALUE = IF chExcel:range("I22"):VALUE <> ? THEN chExcel:range("I22"):VALUE + (-1 * bf-mov-conta.de-valor) ELSE (-1 * bf-mov-conta.de-valor).
                IF bf-mov-conta.dt-mov <> mov-conta.dt-mov THEN
                    ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (-1 * bf-mov-conta.de-valor) ELSE (-1 * bf-mov-conta.de-valor).
            END.
        END.
    END.
    ELSE DO:
        CASE bf-mov-conta.cod-categoria:
            WHEN 4 THEN DO:
                CASE bf-mov-conta.cd-sub:
                    WHEN 1 THEN DO:
                        ASSIGN chExcel:range("I19"):VALUE = IF chExcel:range("I19"):VALUE <> ? THEN chExcel:range("I19"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 2 THEN DO:
                         IF bf-mov-conta.dt-mov = mov-conta.dt-mov THEN
                            ASSIGN chExcel:range("I28"):VALUE = IF chExcel:range("I28"):VALUE <> ? THEN chExcel:range("I28"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1)
                                   chExcel:range("I39"):VALUE = IF chExcel:range("I39"):VALUE <> ? THEN chExcel:range("I39"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                    END.
                     WHEN 4 THEN DO:
                        ASSIGN chExcel:range("I19"):VALUE = IF chExcel:range("I19"):VALUE <> ? THEN chExcel:range("I19"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 5 THEN DO:
                        ASSIGN chExcel:range("I27"):VALUE = IF chExcel:range("I27"):VALUE <> ? THEN chExcel:range("I27"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1)
                               chExcel:range("I38"):VALUE = IF chExcel:range("I38"):VALUE <> ? THEN chExcel:range("I38"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                    END.
                     WHEN 9 THEN DO:
                        ASSIGN chExcel:range("I19"):VALUE = IF chExcel:range("I19"):VALUE <> ? THEN chExcel:range("I19"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 10 THEN DO:
                        ASSIGN chExcel:range("I22"):VALUE = IF chExcel:range("I22"):VALUE <> ? THEN chExcel:range("I22"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 11 THEN DO:
                        ASSIGN chExcel:range("I40"):VALUE = IF chExcel:range("I40"):VALUE <> ? THEN chExcel:range("I40"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                               chExcel:range("I29"):VALUE = IF chExcel:range("I29"):VALUE <> ? THEN chExcel:range("I29"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                    END.
                     WHEN 12 THEN DO:
                        ASSIGN chExcel:range("I22"):VALUE = IF chExcel:range("I22"):VALUE <> ? THEN chExcel:range("I22"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 13 THEN DO:
                        ASSIGN chExcel:range("I26"):VALUE = IF chExcel:range("I26"):VALUE <> ? THEN chExcel:range("I26"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 14 THEN DO:
                        ASSIGN chExcel:range("I25"):VALUE = IF chExcel:range("I25"):VALUE <> ? THEN chExcel:range("I25"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                     WHEN 15 THEN DO:
                        ASSIGN chExcel:range("I20"):VALUE = IF chExcel:range("I20"):VALUE <> ? THEN chExcel:range("I20"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1)
                               de-hrs = chExcel:range("I20"):VALUE / 25.
                    END.
                     WHEN 16 THEN DO:
                        ASSIGN chExcel:range("I30"):VALUE = IF chExcel:range("I30"):VALUE <> ? THEN chExcel:range("I30"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                    END.
                    WHEN 18 THEN DO:
                       ASSIGN chExcel:range("I22"):VALUE = IF chExcel:range("I22"):VALUE <> ? THEN chExcel:range("I22"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                    END.
                END CASE.
            END.
            WHEN 7 THEN DO:
                CASE bf-mov-conta.cd-sub:
                    WHEN 1 THEN DO:
                        ASSIGN chExcel:range("I23"):VALUE = IF chExcel:range("I23"):VALUE <> ? THEN chExcel:range("I23"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        IF bf-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                            ASSIGN chExcel:range("I41"):VALUE = IF chExcel:range("I41"):VALUE <> ? THEN chExcel:range("I41"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                        END.
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN chExcel:range("I24"):VALUE = IF chExcel:range("I24"):VALUE <> ? THEN chExcel:range("I24"):VALUE + (bf-mov-conta.de-valor * -1) ELSE (bf-mov-conta.de-valor * -1).
                    END.
                END CASE.
            END.
            WHEN 10 THEN DO:
                CASE bf-mov-conta.cd-sub:
                    WHEN 1 THEN DO:
                        ASSIGN chExcel:range("I47"):VALUE = IF chExcel:range("I47"):VALUE <> ? THEN chExcel:range("I47"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN chExcel:range("I43"):VALUE = IF chExcel:range("I43"):VALUE <> ? THEN chExcel:range("I43"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                    END.
                END CASE.
            END.
            WHEN 15 THEN DO:
                CASE bf-mov-conta.cd-sub:
                    WHEN 1 THEN DO:
                        ASSIGN chExcel:range("I42"):VALUE = IF chExcel:range("I42"):VALUE <> ? THEN chExcel:range("I42"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN chExcel:range("I43"):VALUE = IF chExcel:range("I43"):VALUE <> ? THEN chExcel:range("I43"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                    END.
                    WHEN 8 THEN DO:
                        ASSIGN chExcel:range("I48"):VALUE = IF chExcel:range("I48"):VALUE <> ? THEN chExcel:range("I42"):VALUE + bf-mov-conta.de-valor ELSE bf-mov-conta.de-valor.
                    END.
                END CASE.
            END.
        END CASE.
    END.
        
END PROCEDURE.
