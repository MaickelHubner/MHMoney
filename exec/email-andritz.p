DEF VAR i-num-os-mes LIKE ordem-serv.num-os INITIAL 858.
DEF VAR i-num-os-avulsa LIKE ordem-serv.num-os INITIAL 47.

DEFINE VARIABLE iLinha AS INTEGER     NO-UNDO INITIAL 5.
DEFINE VARIABLE c-apont AS CHARACTER   NO-UNDO.
DEFINE VARIABLE deTot AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deGeral AS DECIMAL     NO-UNDO.
DEFINE VARIABLE cArq AS CHARACTER   NO-UNDO.

ASSIGN cArq = SESSION:TEMP-DIRECTORY + "suporte-andritz.xls".
IF SEARCH(cArq) <> ? THEN DO:
    OS-DELETE VALUE(cArq).
END.

{campos/situacao.i}

output to value(session:temp-directory + "dtsemail.txt") convert target "iso8859-1".
PUT UNFORMATTED '<html><head><title>Relat¢rio de Tarefas do Suporte ANDRITZ</title></head><body>' +
                '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr><td width="11%"><img src="http://www.otimasis.com/marca_otima.png" width="178" height="84" alt="logo_tetra_web.jpg (3494 bytes)"></td><td width="89%"><p align="center"><big><big><big><strong><font face="Trebuchet MS">Relat¢rio de Tarefas do Suporte ANDRITZ</font></strong></big></big></big></td></tr></table>' +
                '</body></html>'.
output close.

FIND FIRST ordem-serv NO-LOCK
    WHERE ordem-serv.num-os = i-num-os-mes NO-ERROR.
IF NOT AVAIL ordem-serv THEN RETURN "NOK".

DEFINE VARIABLE ch-excel     AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-planilha  AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-arquivo   AS COM-HANDLE NO-UNDO.

CREATE "Excel.Application" ch-excel.
ASSIGN ch-arquivo = ch-excel:Workbooks:Add().        
ASSIGN ch-planilha = ch-arquivo:Sheets:Item(1).        

/* Cabe‡alho */
ch-planilha:Cells(1, 1):Value = "Tarefas Suporte Mensal ANDRITZ".
ch-planilha:Cells(1, 1):Font:Bold = True.
ch-planilha:Cells(1, 1):Font:Size = 16.
ch-planilha:Cells(1, 1):Font:ColorIndex = 45.
ch-planilha:Cells(3, 1):Value = "Tarefas Planejadas no Mˆs".
ch-planilha:Cells(3, 1):Font:Bold = True.

ch-planilha:Columns("A"):ColumnWidth = 12.
ch-planilha:Columns("B"):ColumnWidth = 40.
ch-planilha:Columns("C"):ColumnWidth = 12.
ch-planilha:Columns("D"):ColumnWidth = 10.
ch-planilha:Columns("E"):ColumnWidth = 12.
ch-planilha:Columns("G"):ColumnWidth = 12.
ch-planilha:Columns("H"):ColumnWidth = 12.
ch-planilha:Columns("I"):ColumnWidth = 12.
ch-planilha:Columns("J"):ColumnWidth = 12.

ch-planilha:Cells(iLinha, 1):Value = "Data".
ch-planilha:Cells(iLinha, 1):Font:Bold = True.
ch-planilha:Cells(iLinha, 1):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 2):Value = "Descri‡Æo".
ch-planilha:Cells(iLinha, 2):Font:Bold = True.
ch-planilha:Cells(iLinha, 2):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 3):Value = "Respons vel".
ch-planilha:Cells(iLinha, 3):Font:Bold = True.
ch-planilha:Cells(iLinha, 3):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 4):Value = "Qtd Horas".
ch-planilha:Cells(iLinha, 4):Font:Bold = True.
ch-planilha:Cells(iLinha, 4):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 5):Value = "Situa‡Æo".
ch-planilha:Cells(iLinha, 5):Font:Bold = True.
ch-planilha:Cells(iLinha, 5):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 6):Value = "% Con".
ch-planilha:Cells(iLinha, 6):Font:Bold = True.
ch-planilha:Cells(iLinha, 6):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 7):Value = "Data Prev Ini".
ch-planilha:Cells(iLinha, 7):Font:Bold = True.
ch-planilha:Cells(iLinha, 7):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 8):Value = "Data Prev Fim".
ch-planilha:Cells(iLinha, 8):Font:Bold = True.
ch-planilha:Cells(iLinha, 8):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 9):Value = "Data Ini".
ch-planilha:Cells(iLinha, 9):Font:Bold = True.
ch-planilha:Cells(iLinha, 9):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 10):Value = "Data Fim".
ch-planilha:Cells(iLinha, 10):Font:Bold = True.
ch-planilha:Cells(iLinha, 10):Font:ColorIndex = 45.
ASSIGN iLinha = iLinha + 1.

for each tarefa OF ordem-serv no-lock:

    ch-planilha:Cells(iLinha, 1):Value = tarefa.dt-cri-tarefa.
    ch-planilha:Cells(iLinha, 2):Value = tarefa.ds-tarefa.
    ch-planilha:Cells(iLinha, 3):Value = tarefa.responsavel.
    ch-planilha:Cells(iLinha, 4):Value = tarefa.qtd-horas.
    ch-planilha:Cells(iLinha, 5):Value = fnSituacaoTarefa(tarefa.situacao).
    ch-planilha:Cells(iLinha, 6):Value = tarefa.perc-con.
    ch-planilha:Cells(iLinha, 7):Value = tarefa.data-prev-ini.
    ch-planilha:Cells(iLinha, 8):Value = tarefa.data-prev-fim.
    ch-planilha:Cells(iLinha, 9):Value = tarefa.dt-real-ini.
    ch-planilha:Cells(iLinha, 10):Value = tarefa.dt-real-fim.
    ASSIGN iLinha = iLinha + 1.

END.

FIND FIRST ordem-serv NO-LOCK
    WHERE ordem-serv.num-os = i-num-os-avulsa NO-ERROR.

ASSIGN iLinha = iLinha + 1.
ch-planilha:Cells(iLinha, 1):Value = "Tarefas NÆo Planejadas".
ch-planilha:Cells(iLinha, 1):Font:Bold = True.
ASSIGN iLinha = iLinha + 2.
ch-planilha:Cells(iLinha, 1):Value = "Data".
ch-planilha:Cells(iLinha, 1):Font:Bold = True.
ch-planilha:Cells(iLinha, 1):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 2):Value = "Descri‡Æo".
ch-planilha:Cells(iLinha, 2):Font:Bold = True.
ch-planilha:Cells(iLinha, 2):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 3):Value = "Respons vel".
ch-planilha:Cells(iLinha, 3):Font:Bold = True.
ch-planilha:Cells(iLinha, 3):Font:ColorIndex = 45.
ch-planilha:Cells(iLinha, 4):Value = "Qtd Horas".
ch-planilha:Cells(iLinha, 4):Font:Bold = True.
ch-planilha:Cells(iLinha, 4):Font:ColorIndex = 45.
ASSIGN iLinha = iLinha + 1.

for each tarefa OF ordem-serv no-lock:

    ch-planilha:Cells(iLinha, 1):Value = tarefa.dt-cri-tarefa.
    ch-planilha:Cells(iLinha, 2):Value = tarefa.ds-tarefa.
    ch-planilha:Cells(iLinha, 3):Value = tarefa.responsavel.
    ch-planilha:Cells(iLinha, 4):Value = tarefa.qtd-horas.
    ASSIGN iLinha = iLinha + 1.

END.

/*ch-Excel:VISIBLE = TRUE.*/
ch-excel:ActiveWorkbook:SaveAs(cArq,1,"","",NO,NO,NO) NO-ERROR.
ch-excel:ActiveWorkbook:CLOSE.

ch-excel:QUIT.

RELEASE OBJECT ch-Excel NO-ERROR.
RELEASE OBJECT ch-planilha NO-ERROR.

RUN pi-blat (INPUT "bruno@otimasis.com;maickel@otimasis.com", INPUT cArq).

PROCEDURE pi-blat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER cDest AS CHARACTER FORMAT "X(40)"  NO-UNDO.
    DEFINE INPUT  PARAMETER cArquivo AS CHARACTER   NO-UNDO.

    DEFINE VARIABLE v-cod-lin-comando AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE destinatario AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE remetente AS CHARACTER  NO-UNDO.

    ASSIGN destinatario = TRIM(cDest)
           remetente = "maickel@otimasis.com".

     assign destinatario = replace(destinatario,chr(10),",")       
            destinatario = replace(destinatario,";",",")
            remetente = replace(remetente,chr(10),",")       
            remetente = replace(remetente,";",",").

    assign v-cod-lin-comando = "blat.exe"
                               + " "
                               + "~"" + session:temp-directory + "dtsemail.txt" + "~""
                               + " -s" 
                               + ' "' 
                               + "Relat¢rio Semanal de Tarefas do Suporte ANDRITZ - " + STRING(TODAY, "99/99/9999") 
                               + '"' 
                               + " -t " 
                               + destinatario 
                               + " -server " 
                               + "~"127.0.0.1:1099~""
                               /*+ " -port " 
                               + "587"*/
                               + " -f "
                               + remetente
                               + " -u " 
                               + "maickel@otimasis.com"
                               + " -pw " 
                               + "otima@123"
                               + " -mime"
                               + " -q"
                               + " -noh"
                               + " -noh2".

    assign v-cod-lin-comando = v-cod-lin-comando + " -html ".           
    file-info:file-name = SEARCH(cArquivo).
    assign v-cod-lin-comando = v-cod-lin-comando + " -attach ~"" + FILE-INFO:FULL-PATHNAME + "~"".

    output to value(session:temp-directory + "dtsemail.bat") convert target "IBM850".
    put unformatted "CD C:\Compartilhadas\Sistema\MHMoney" CHR(10) v-cod-lin-comando " -debug".
    OUTPUT CLOSE.
    dos SILENT value("~"" + session:temp-directory + "dtsemail.bat" + "~"").

    /*os-delete value(session:temp-directory + "dtsemail.txt").
    os-delete value(session:temp-directory + "dtsemail.bat").*/

    return "OK".

END PROCEDURE.
