DEFINE INPUT PARAMETER pi-nr-pedido AS INTEGER   NO-UNDO.
DEFINE INPUT PARAMETER pc-usuario   AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER pd-dt-ini    AS DATE      NO-UNDO.
DEFINE INPUT PARAMETER pd-dt-fim    AS DATE      NO-UNDO.
DEFINE INPUT PARAMETER i-tipo       AS INTEGER   NO-UNDO. /*1 - PDF, 2 - Excel = PDF, 3 - Excel Geral*/

DEFINE VARIABLE iLinha    AS INTEGER     NO-UNDO INITIAL 3.
DEFINE VARIABLE c-apont   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE deTot     AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deGeral   AS DECIMAL     NO-UNDO.
DEFINE VARIABLE gcusuario AS CHARACTER   NO-UNDO.
DEFINE VARIABLE deTotParc AS DECIMAL     NO-UNDO.
DEFINE VARIABLE c-arq-pdf AS CHARACTER   NO-UNDO.

DEFINE TEMP-TABLE tt-dados
            FIELD data           LIKE apontamento.data                                 
            FIELD hora-ini       LIKE apontamento.hora-ini                             
            FIELD hora-fim       LIKE apontamento.hora-fim                             
            FIELD nome           LIKE apontamento.nome                                 
            FIELD ds-tarefa      LIKE tarefa.ds-tarefa
            FIELD ds-pedido-item LIKE pedido-item.ds-pedido-item                       
            FIELD qt-apontada    LIKE apontamento.qt-apontada                          
            FIELD ds-apont       AS CHARACTER
            FIELD seq-tarefa     LIKE tarefa.sequencia
            FIELD seq-ped-item   LIKE pedido-item.sequencia
            FIELD dt-ini-tarefa  LIKE tarefa.dt-real-ini
            FIELD dt-fim-tarefa  LIKE tarefa.dt-real-fim
            FIELD un             AS CHAR.

DEFINE TEMP-TABLE tt-tot
    FIELD un AS CHAR
    FIELD qtd AS DEC.

DEFINE VARIABLE ch-excel     AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-planilha  AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-arquivo   AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE l-pdf        AS LOGICAL    NO-UNDO.

IF i-tipo = 1 OR i-tipo = 2 THEN
    ASSIGN l-pdf = YES.

CREATE "Excel.Application" ch-excel.
ch-excel:DisplayAlerts = NO.
ASSIGN ch-arquivo = ch-excel:Workbooks:Add().        
ASSIGN ch-planilha = ch-arquivo:Sheets:Item(1).        

/* Cabe‡alho */
ch-planilha:Range("A1"):select().
ch-planilha:Pictures:Insert(SEARCH("image\otima.jpg")).
ch-planilha:Cells(2, 3):Value = "Controle de Apontamentos de Projeto".
ch-planilha:Cells(2, 3):Font:Bold = True.
ch-planilha:Cells(2, 3):Font:Size = 16.
/*ch-planilha:Cells(2, 3):Font:ColorIndex = 27.*/

ch-planilha:Columns("A"):ColumnWidth = 10.
ch-planilha:Columns("B"):ColumnWidth = 8.
ch-planilha:Columns("C"):ColumnWidth = 8.
ch-planilha:Columns("D"):ColumnWidth = 9.
ch-planilha:Columns("E"):ColumnWidth = 20.
IF l-pdf THEN DO:
    ch-planilha:Columns("F"):ColumnWidth = 10.
    ch-planilha:Columns("G"):ColumnWidth = 60.
END.
ELSE DO:
    ch-planilha:Columns("F"):ColumnWidth = 20.
    ch-planilha:Columns("G"):ColumnWidth = 10.
    ch-planilha:Columns("H"):ColumnWidth = 60.
END.

FOR FIRST pedido NO-LOCK
    WHERE pedido.nr-pedido = pi-nr-pedido,
    FIRST favorecido NO-LOCK OF pedido:
    ASSIGN iLinha = iLinha + 1.
    ch-planilha:Cells(iLinha, 1):Value = "Cliente:".
    ch-planilha:Cells(iLinha, 2):Value = favorecido.ds-favorecido.
    ch-planilha:Cells(iLinha, 1):Font:Bold = True.
    ASSIGN iLinha = iLinha + 1.
    ch-planilha:Cells(iLinha, 1):Value = "Projeto:".
    ch-planilha:Cells(iLinha, 2):Value = pedido.nom-projeto.
    ch-planilha:Cells(iLinha, 1):Font:Bold = True.
    ASSIGN iLinha = iLinha + 1.
    ch-planilha:Cells(iLinha, 1):Value = "Per¡odo:".
    ch-planilha:Cells(iLinha, 2):Value = STRING(pd-dt-ini,"99/99/9999") + "   At‚   " + STRING(pd-dt-fim,"99/99/9999").
    ch-planilha:Cells(iLinha, 1):Font:Bold = True.
    IF pc-usuario <> "" THEN DO:
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):Value = "Usu rio:".
        ch-planilha:Cells(iLinha, 2):Value = pc-usuario.
        ch-planilha:Cells(iLinha, 1):Font:Bold = True.
    END.
    ASSIGN iLinha = iLinha + 2.
END.

FOR EACH pedido-item NO-LOCK OF pedido,
    EACH ITEM OF pedido-item NO-LOCK
   /*WHERE ITEM.unidade MATCHES "*HR*"*/,
    EACH apontamento NO-LOCK OF pedido-item
   WHERE apontamento.data >= pd-dt-ini
     AND apontamento.data <= pd-dt-fim:

    IF pc-usuario <> "" THEN DO:
        IF apontamento.nome <> pc-usuario THEN NEXT.
    END.

    FIND FIRST tarefa NO-LOCK
         WHERE tarefa.nome      = apontamento.nome-tarefa
           AND tarefa.sequencia = apontamento.seq-tarefa NO-ERROR.

    IF NOT CAN-FIND(FIRST tt-dados
                    WHERE tt-dados.data     = apontamento.data
                      AND tt-dados.hora-ini = apontamento.hora-ini
                      AND tt-dados.hora-fim = apontamento.hora-fim
                      AND tt-dados.nome     = apontamento.nome)     THEN DO:

        ASSIGN c-apont = REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " ").

        CREATE tt-dados.
        ASSIGN tt-dados.data           = apontamento.data
               tt-dados.hora-ini       = apontamento.hora-ini
               tt-dados.hora-fim       = apontamento.hora-fim
               tt-dados.nome           = apontamento.nome
               tt-dados.ds-tarefa      = IF AVAILABLE tarefa THEN tarefa.ds-tarefa ELSE "SEM TAREFA"
               tt-dados.ds-pedido-item = pedido-item.ds-pedido-item
               tt-dados.qt-apontada    = apontamento.qt-apontada
               tt-dados.ds-apont       = c-apont
               tt-dados.seq-tarefa     =  IF AVAILABLE tarefa THEN tarefa.sequencia ELSE 9999
               tt-dados.seq-ped-item   = pedido-item.sequencia
               tt-dados.dt-ini-tarefa  = IF AVAILABLE tarefa THEN tarefa.dt-real-ini ELSE ?
               tt-dados.dt-fim-tarefa  = IF AVAILABLE tarefa THEN tarefa.dt-real-fim ELSE ?
               tt-dados.un             = item.un.
    END.
END.

IF NOT l-pdf THEN DO:
    ch-planilha:Cells(iLinha, 1):Value = "Data".
    ch-planilha:Cells(iLinha, 1):Font:Bold = True.
    ch-planilha:Cells(iLinha, 2):Value = "Hora Ini".
    ch-planilha:Cells(iLinha, 2):Font:Bold = True.
    ch-planilha:Cells(iLinha, 3):Value = "Hora Fim".
    ch-planilha:Cells(iLinha, 3):Font:Bold = True.
    ch-planilha:Cells(iLinha, 4):Value = "Recurso".
    ch-planilha:Cells(iLinha, 4):Font:Bold = True.
    ch-planilha:Cells(iLinha, 5):Value = "Tarefa".
    ch-planilha:Cells(iLinha, 5):Font:Bold = True.
    ch-planilha:Cells(iLinha, 6):Value = "Item".
    ch-planilha:Cells(iLinha, 6):Font:Bold = True.
    ch-planilha:Cells(iLinha, 7):Value = "Qt Apont".
    ch-planilha:Cells(iLinha, 7):Font:Bold = True.
    ch-planilha:Cells(iLinha, 8):Value = "Observa‡Æo".
    ch-planilha:Cells(iLinha, 8):Font:Bold = True.
    ASSIGN iLinha = iLinha + 1.
END.

FOR EACH tt-dados
BREAK BY tt-dados.seq-ped-item
      BY tt-dados.dt-ini-tarefa
      BY tt-dados.dt-fim-tarefa
      BY tt-dados.seq-tarefa
      BY tt-dados.data:
    IF FIRST-OF(tt-dados.seq-ped-item) AND l-pdf THEN DO:
        ASSIGN deTotParc = 0.
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):VALUE = CAPS(tt-dados.ds-pedido-item).
        ch-planilha:Cells(iLinha, 1):Font:Bold = True.
        ASSIGN iLinha = iLinha + 1.
    END.

    IF FIRST-OF(tt-dados.seq-tarefa) AND l-pdf THEN DO:
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):Value = CAPS(tt-dados.ds-tarefa).
        ch-planilha:Cells(iLinha, 1):Font:Bold = True.
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):Value = "Data".
        ch-planilha:Cells(iLinha, 1):Font:Bold = True.
        ch-planilha:Cells(iLinha, 2):Value = "Hora Ini".
        ch-planilha:Cells(iLinha, 2):Font:Bold = True.
        ch-planilha:Cells(iLinha, 3):Value = "Hora Fim".
        ch-planilha:Cells(iLinha, 3):Font:Bold = True.
        ch-planilha:Cells(iLinha, 4):Value = "Recurso".
        ch-planilha:Cells(iLinha, 4):Font:Bold = True.
        ch-planilha:Cells(iLinha, 5):Value = "Qt Apont".
        ch-planilha:Cells(iLinha, 5):Font:Bold = True.
        ch-planilha:Cells(iLinha, 6):Value = "Observa‡Æo".
        ch-planilha:Cells(iLinha, 6):Font:Bold = True.
        ASSIGN iLinha = iLinha + 1.
    END.

    FIND FIRST tt-tot
        WHERE tt-tot.un = tt-dados.un NO-ERROR.
    IF NOT AVAIL tt-tot THEN DO:
        CREATE tt-tot.
        ASSIGN tt-tot.un = tt-dados.un.
    END.
    ASSIGN tt-tot.qtd = tt-tot.qtd + tt-dados.qt-apontada.

    ch-planilha:Cells(iLinha, 1):VALUE = tt-dados.data.
    ch-planilha:Cells(iLinha, 2):Value = tt-dados.hora-ini.
    ch-planilha:Cells(iLinha, 3):Value = tt-dados.hora-fim.
    ch-planilha:Cells(iLinha, 4):Value = tt-dados.nome.

    IF l-pdf THEN DO:
        ch-planilha:Cells(iLinha, 5):Value = STRING(tt-dados.qt-apontada,">>,>>9.99").
        ch-planilha:Cells(iLinha, 6):Value = tt-dados.ds-apont.
    END.
    ELSE DO:
        ch-planilha:Cells(iLinha, 5):Value = tt-dados.ds-tarefa.
        ch-planilha:Cells(iLinha, 6):Value = tt-dados.ds-pedido-item.
        ch-planilha:Cells(iLinha, 7):Value = STRING(tt-dados.qt-apontada,">>,>>9.99").
        ch-planilha:Cells(iLinha, 8):Value = tt-dados.ds-apont.
    END.

    ASSIGN deTotParc = deTotParc + tt-dados.qt-apontada.

    ch-planilha:Cells(iLinha, 2):HorizontalAlignment = -4108.
    ch-planilha:Cells(iLinha, 3):HorizontalAlignment = -4108.

    IF l-pdf THEN DO:
        ch-planilha:Cells(iLinha, 5):HorizontalAlignment = -4108.
    END.
    ELSE DO:
        ch-planilha:Cells(iLinha, 7):HorizontalAlignment = -4108.
    END.

    ASSIGN iLinha = iLinha + 1.

    IF LAST-OF(tt-dados.seq-ped-item) AND l-pdf THEN DO:
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):VALUE = "TOTAL " + CAPS(tt-dados.ds-pedido-item).
        ch-planilha:Cells(iLinha, 1):Font:Bold = True.
        ch-planilha:Cells(iLinha, 5):VALUE = STRING(deTotParc,">>,>>9.99").
        ch-planilha:Cells(iLinha, 5):HorizontalAlignment = -4108.
        ch-planilha:Cells(iLinha, 5):Font:Bold = True.
        ASSIGN iLinha = iLinha + 1.
    END.
END.

IF l-pdf THEN DO:
    FOR EACH tt-tot:
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):Value = "TOTAL GERAL " + TRIM(tt-tot.un).
        ch-planilha:Cells(iLinha, 1):Font:Bold = True.
        ch-planilha:Cells(iLinha, 4):Font:Bold = True.
        ch-planilha:Cells(iLinha, 5):Value = STRING(tt-tot.qtd,">>,>>9.99").
        ch-planilha:Cells(iLinha, 5):Font:Bold = True.
        ch-planilha:Cells(iLinha, 5):HorizontalAlignment = -4108.
    END.
END.
ELSE DO:
    FOR EACH tt-tot:
        ASSIGN iLinha = iLinha + 1.
        ch-planilha:Cells(iLinha, 1):Value = "TOTAL GERAL " + TRIM(tt-tot.un).
        ch-planilha:Cells(iLinha, 6):Font:Bold = True.
        ch-planilha:Cells(iLinha, 7):Value = STRING(tt-tot.qtd,">>,>>9.99").
        ch-planilha:Cells(iLinha, 7):Font:Bold = True.
        ch-planilha:Cells(iLinha, 7):HorizontalAlignment = -4108.
    END.
END.

ASSIGN iLinha = iLinha + 2.
ch-planilha:Range("A" + STRING(iLinha)):select().
ch-planilha:Pictures:Insert(SEARCH("image\otima2.png")).

ch-planilha:Range("A1"):select().

IF i-tipo = 1 OR i-tipo = 2 THEN DO:
    ch-planilha:Columns("F:F"):EntireColumn:ColumnWidth = 90.
    ch-planilha:Columns("F:F"):EntireColumn:WrapText = YES.
END.
ELSE DO:
    ch-planilha:Columns("H:H"):EntireColumn:ColumnWidth = 45.
        ch-planilha:Columns("H:H"):EntireColumn:WrapText = YES.
END.

ch-planilha:Columns("D:H"):EntireColumn:AutoFit.

ch-planilha:Cells(iLinha, 2):Value = "Avenida Marquˆs de Olinda, 935 - Sala 01 CEP: 89.218-252 - Santo Ant“nio - Joinville-SC - www.otimasis.com".
ch-planilha:Cells(iLinha, 2):Font:Bold = True.

ch-planilha:PageSetup:Zoom = FALSE. /*zoom de impressao tem que estar falso*/
ch-planilha:PageSetup:FitToPagesWide     = 1.
ch-planilha:PageSetup:FitToPagesTall     = 9999.
ch-planilha:PageSetup:CenterHorizontally = True.
ch-planilha:PageSetup:CenterVertically   = True.
ch-planilha:PageSetup:Orientation        = 2.  

IF i-tipo = 1 THEN DO:
    ASSIGN c-arq-pdf = SESSION:TEMP-DIRECTORY + "relat-apont.pdf".
           ch-planilha:ExportAsFixedFormat(0,c-arq-pdf,0,FALSE).
           DOS SILENT START VALUE(c-arq-pdf).
    ch-Excel:ActiveWorkbook:CLOSE.
    ch-Excel:QUIT.
END.
ELSE DO:
    ch-Excel:VISIBLE = TRUE.
END.

RELEASE OBJECT ch-Excel    NO-ERROR.
RELEASE OBJECT ch-planilha NO-ERROR.
RELEASE OBJECT ch-arquivo  NO-ERROR.

RETURN "OK".
