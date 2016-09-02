DEFINE INPUT PARAMETER p-seq-visita LIKE visita.sequencia NO-UNDO.
DEFINE INPUT PARAMETER p-tipo AS INTEGER NO-UNDO. /*1 = PDF ; 2 = EXCEL*/ 

/* variaveis para gera‡Æo da planilha excel */
DEFINE VARIABLE cdiretorio     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cdirdestino    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cdir           AS CHARACTER   NO-UNDO.
DEFINE VARIABLE icont          AS INTEGER     NO-UNDO.
DEFINE VARIABLE errStatus      AS INT         NO-UNDO.
DEFINE VARIABLE cfile          AS CHARACTER   NO-UNDO.
DEFINE VARIABLE chExcel        AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE ch-planilha1   AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE c-arq-pdf      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE da-ini-per     AS DATE        NO-UNDO.
DEFINE VARIABLE da-fim-per     AS DATE        NO-UNDO.
DEFINE VARIABLE ilinha         AS INTEGER     NO-UNDO.

ASSIGN cdirdestino    = SESSION:TEMP-DIRECTORY + "DespViagem_" + STRING(p-seq-visita) + ".xlsx".
     
SESSION:SET-WAIT-STATE ("general").
/*cria a aplica‡Æo do excel*/
CREATE "Excel.Application" chExcel CONNECT NO-ERROR.
IF ERROR-STATUS:ERROR THEN DO:
    CREATE "Excel.application" chExcel.
END.    

ASSIGN cdir = ENTRY(1,cdirdestino, '~\') 
    cdiretorio = cdirdestino.
    /*Troca caracteres inv lidos para evitar erro na cria‡Æo da planilha*/
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
            RUN utp/ut-msgs.p ('show', 26692, '').
        WHEN 8 THEN 
            RUN utp/ut-msgs.p ('show', 26694, ''). 
        WHEN 3 THEN 
            RUN utp/ut-msgs.p ('show', 26695, '').
        WHEN 7 THEN  
            RUN utp/ut-msgs.p ('show', 26696, '').       
        WHEN 17 THEN
            RUN utp/ut-msgs.p ('show', 26697, '').
END CASE.
    RETURN NO-APPLY.
END.     
    
/*Busca a planilha modelo*/  
ASSIGN cfile = SEARCH("desp-viag.xlsx").

IF cFile <> ? THEN DO:
  OS-COPY VALUE(cFile) VALUE(cDiretorio).
END.
ELSE DO:
  RUN utp/ut-msgs.p (INPUT "show",
                     INPUT 1332  ,
                     INPUT "desp-viag.xlsx":U).
  RETURN "NOK":U.
END.

/*Abre o arquivo do excel*/
chExcel:workbooks:OPEN(cdiretorio).
ASSIGN ch-planilha1 = chExcel:sheets:ITEM(1).

ch-planilha1:activate().
chExcel:displayAlerts = NO.

DEFINE BUFFER b-cli FOR favorecido.
DEFINE BUFFER b-fav FOR favorecido.

FOR FIRST visita NO-LOCK
    WHERE visita.sequencia = p-seq-visita :

    FIND FIRST b-cli NO-LOCK
        WHERE b-cli.cd-favorecido = visita.cd-favorecido NO-ERROR.

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = visita.nome NO-ERROR.

    FIND FIRST b-fav NO-LOCK
        WHERE b-fav.cd-favorecido = usuario.cd-favorecido NO-ERROR.

    ASSIGN chExcel:range("C12"):VALUE = b-fav.ds-favorecido.
    ASSIGN chExcel:range("C13"):VALUE = IF b-cli.razao-social = "" THEN b-cli.ds-favorecido ELSE b-cli.razao-social.
    ASSIGN chExcel:range("C14"):VALUE = SUBSTRING(visita.ds-visita,1,40).
    ASSIGN chExcel:range("C15"):VALUE = SUBSTRING(visita.ds-visita,41,80).
    ASSIGN chExcel:range("C16"):VALUE = visita.vl-adiantado.

    ASSIGN ilinha     = 22
           da-ini-per = 12/31/9999
           da-fim-per = 01/01/0001.

    FOR EACH apontamento NO-LOCK
        WHERE apontamento.seq-visita = visita.sequencia
        AND   apontamento.nome       = visita.nome:
    
        FIND FIRST pedido-item OF apontamento NO-LOCK NO-ERROR.
    
        FIND FIRST ITEM OF pedido-item NO-LOCK NO-ERROR.
    
        IF NOT AVAILABLE pedido-item OR NOT AVAILABLE ITEM THEN NEXT.


        ASSIGN chExcel:range("A" + STRING(ilinha)):VALUE = apontamento.nr-mov.
        ASSIGN chExcel:range("B" + STRING(ilinha)):VALUE = apontamento.tipo-despesa.
        ASSIGN chExcel:range("C" + STRING(ilinha)):VALUE = apontamento.ds-fav-apont.
        ASSIGN chExcel:range("D" + STRING(ilinha)):VALUE = apontamento.data.
        ASSIGN chExcel:range("E" + STRING(ilinha)):VALUE = IF apontamento.reembolsavel THEN "Sim" ELSE "NÆo".
        ASSIGN chExcel:range("F" + STRING(ilinha)):VALUE = (apontamento.qt-apontada * item.fator-reemb).
        
        IF item.ds-item = "Quilometragem" THEN
            ASSIGN chExcel:range("G" + STRING(ilinha)):VALUE = SUBSTRING(apontamento.ds-apontamento,1,32) + " (" + STRING(apontamento.qt-apontada) + " KM)".
        ELSE 
            ASSIGN chExcel:range("G" + STRING(ilinha)):VALUE = SUBSTRING(apontamento.ds-apontamento,1,40).

        IF apontamento.data < da-ini-per THEN
            ASSIGN da-ini-per = apontamento.data.
        
        IF apontamento.data > da-fim-per THEN
            ASSIGN da-fim-per = apontamento.data.

        ASSIGN ilinha = ilinha + 1.
    END.

    ASSIGN chExcel:range("G12"):VALUE = STRING(da-ini-per,"99/99/9999") + " a " + STRING(da-fim-per,"99/99/9999").
END.

IF p-tipo = 1 THEN DO:
    ASSIGN c-arq-pdf = SESSION:TEMP-DIRECTORY + "despViagem.pdf".
           ch-planilha1:ExportAsFixedFormat(0,c-arq-pdf,0,FALSE).
           DOS SILENT START VALUE(c-arq-pdf).
END.
ELSE DO:
    chExcel:VISIBLE = TRUE.
END.

/*Finaliza handle‹s do excel*/
RELEASE OBJECT chExcel NO-ERROR.

SESSION:SET-WAIT-STATE ("").
