DEFINE INPUT PARAMETER cResp     AS CHARACTER   NO-UNDO.
DEFINE INPUT PARAMETER dtDataIni AS DATE        NO-UNDO.
DEFINE INPUT PARAMETER dtDataFim AS DATE        NO-UNDO.

DEFINE VARIABLE de-hrs        AS DECIMAL FORMAT ">>>9.99"       NO-UNDO.
DEFINE VARIABLE de-hrs-proj   AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-dsl    AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-adm    AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-fer    AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-com    AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-int    AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-dis    AS DECIMAL FORMAT ">>9.99"        NO-UNDO.
DEFINE VARIABLE de-hrs-uti    AS DECIMAL FORMAT ">>>9.99"       NO-UNDO.
DEFINE VARIABLE de-hrs-tre    AS DECIMAL FORMAT ">>>9.99"       NO-UNDO.
DEFINE VARIABLE de-tot-apont  AS DECIMAL FORMAT ">>>9.99"       NO-UNDO.
DEFINE VARIABLE dt-aux        AS DATE                           NO-UNDO.
DEFINE VARIABLE iLinhaTot AS INTEGER     NO-UNDO.
DEFINE VARIABLE de-tot-efi AS DECIMAL     NO-UNDO EXTENT 2.
DEFINE VARIABLE de-tot-atr AS DECIMAL     NO-UNDO EXTENT 2.

DEFINE VARIABLE de-tot-hrs      AS DECIMAL FORMAT ">>>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-proj AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-dsl  AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-adm  AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-fer  AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-com  AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-int  AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-dis  AS DECIMAL FORMAT  ">>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-uti  AS DECIMAL FORMAT ">>>9.99"     NO-UNDO.
DEFINE VARIABLE de-tot-hrs-tre  AS DECIMAL FORMAT ">>>9.99"     NO-UNDO.
DEFINE VARIABLE i-atend         AS INTEGER INITIAL 0            NO-UNDO.
DEFINE VARIABLE i-dias          AS INTEGER INITIAL 0            NO-UNDO.
DEFINE VARIABLE i-proj          AS INTEGER INITIAL 0            NO-UNDO.
DEFINE VARIABLE i-proj-cli      AS INTEGER INITIAL 0            NO-UNDO.
DEFINE VARIABLE i-fav           AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-fav2          AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-semana        AS INTEGER                      NO-UNDO.
DEFINE VARIABLE c-mes-ano       AS CHARACTER                    NO-UNDO.
DEFINE VARIABLE i-resumo        AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-qtd-atend     AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-excel         AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-excel2        AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-cont          AS INTEGER                      NO-UNDO.
DEFINE VARIABLE i-sit AS INTEGER     NO-UNDO EXTENT 4.

DEFINE VARIABLE iHr-ini  AS INTEGER                             NO-UNDO.
DEFINE VARIABLE iHr-fim  AS INTEGER                             NO-UNDO.
DEFINE VARIABLE iMin-ini AS INTEGER                             NO-UNDO.
DEFINE VARIABLE iMin-fim AS INTEGER                             NO-UNDO.
DEFINE VARIABLE deQtd    AS DECIMAL                             NO-UNDO.
DEFINE VARIABLE deQtdT   AS DECIMAL                             NO-UNDO.
DEFINE VARIABLE dt-cont  AS DATE                                NO-UNDO.

/* variaveis para gera‡Æo da planilha excel */
DEFINE VARIABLE i-linha      AS INTEGER                        NO-UNDO.
DEFINE VARIABLE cdiretorio   AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE cdirdestino  AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE cArqPdf      AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE cdir         AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE icont        AS INTEGER                        NO-UNDO.
DEFINE VARIABLE errStatus    AS INT                            NO-UNDO.
DEFINE VARIABLE cfile        AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE c-colunas    AS CHAR FORMAT "x(500)"           NO-UNDO.
DEFINE VARIABLE chExcel      AS COM-HANDLE                     NO-UNDO.
DEFINE VARIABLE ch-planilha1 AS COM-HANDLE                     NO-UNDO.
DEFINE VARIABLE ch-arquivo   AS COM-HANDLE                     NO-UNDO.
DEFINE VARIABLE ch-cell      AS COM-HANDLE                     NO-UNDO.
DEFINE VARIABLE vPicture     AS COM-HANDLE                     NO-UNDO.
DEFINE VARIABLE c-nrtv       AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE icontTarefas AS INTEGER                        NO-UNDO.
DEFINE VARIABLE counter-page AS INTEGER                        NO-UNDO.
DEFINE VARIABLE name-page    AS CHARACTER                      NO-UNDO.
DEFINE VARIABLE ch-planilha  AS COM-HANDLE                     NO-UNDO.
DEFINE VARIABLE excelappl    AS COM-HANDLE                     NO-UNDO.

DEFINE TEMP-TABLE tt-favorecido NO-UNDO
    FIELD ds-favorecido LIKE favorecido.ds-favorecido
    FIELD qtd-favorecido AS INT.

DEFINE TEMP-TABLE tt-resumo-atend NO-UNDO
    FIELD mes-ano  AS CHAR
    FIELD mes      AS INT
    FIELD ano      AS INT
    FIELD semana   AS INT
    FIELD qtd-atend AS INT.

{func\data.i}

ASSIGN cdirdestino    = SESSION:TEMP-DIRECTORY + "planilhaGera-Resumo_" + STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") + "_" + STRING(TIME) + ".xlsx".
     
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

/*Verifica erros do sistema operacional*/
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
ASSIGN cfile = SEARCH("gera-resumo.xlsx").

IF cFile <> ? THEN DO:
  OS-COPY VALUE(cFile) VALUE(cDiretorio).
END.
ELSE DO:
  RUN utp/ut-msgs.p (INPUT "show",
                     INPUT 1332  ,
                     INPUT "gera-resumo.xlsx":U).
  RETURN "NOK":U.
END.

/*Abre o arquivo do excel*/
chExcel:workbooks:OPEN(cdiretorio).
ASSIGN ch-planilha1 = chExcel:sheets:ITEM(2).

ch-planilha1:activate(). 
chExcel:displayAlerts = NO.

ASSIGN counter-page = 11.
chExcel:range("B11"):VALUE   = STRING(dtDataIni, "99/99/9999") + " at‚ " + STRING(dtDataFim, "99/99/9999").
chExcel:range("B10"):VALUE   = cResp.
ASSIGN counter-page = 14.
       
/* ATENDIMENTOS */   
RUN calc-dias. 
FOR EACH atendimento NO-LOCK                                               
  WHERE atendimento.usuario = cResp
    AND atendimento.data >= dtDataIni
    AND atendimento.data <= dtDataFim
    BY atendimento.data                                                    
    BY atendimento.hora:                              
                                                
    FIND FIRST favorecido OF atendimento NO-LOCK.

    CASE MONTH(atendimento.data):
        WHEN 1  THEN ASSIGN c-mes-ano = "Jan" .
        WHEN 2  THEN ASSIGN c-mes-ano = "Fev" .
        WHEN 3  THEN ASSIGN c-mes-ano = "Mar" .
        WHEN 4  THEN ASSIGN c-mes-ano = "Abr" .
        WHEN 5  THEN ASSIGN c-mes-ano = "Mai" .
        WHEN 6  THEN ASSIGN c-mes-ano = "Jun" .
        WHEN 7  THEN ASSIGN c-mes-ano = "Jul" .
        WHEN 8  THEN ASSIGN c-mes-ano = "Ago" .
        WHEN 9  THEN ASSIGN c-mes-ano = "Set" .
        WHEN 10 THEN ASSIGN c-mes-ano = "Out" .
        WHEN 11 THEN ASSIGN c-mes-ano = "Nov" .
        WHEN 12 THEN ASSIGN c-mes-ano = "Dez" .
    END CASE.

    ASSIGN c-mes-ano = c-mes-ano + "-" + SUBSTRING(STRING(YEAR(atendimento.data),"9999"), 3, 2). 

    FIND FIRST tt-resumo-atend
        WHERE tt-resumo-atend.mes-ano = c-mes-ano
        AND   tt-resumo-atend.semana  = fnSemana(atendimento.data) NO-ERROR.
    IF NOT AVAIL tt-resumo-atend THEN DO:
        CREATE tt-resumo-atend.
        ASSIGN tt-resumo-atend.mes-ano = c-mes-ano
               tt-resumo-atend.semana  = fnSemana(atendimento.data)
               tt-resumo-atend.mes     = MONTH(atendimento.data)
               tt-resumo-atend.ano     = YEAR(atendimento.data).
    END.
    ASSIGN tt-resumo-atend.qtd-atend = tt-resumo-atend.qtd-atend + 1.

    chExcel:range("A" + STRING(counter-page)):VALUE   = atendimento.data .       
    chExcel:range("B" + STRING(counter-page)):VALUE   = atendimento.hora .       
    chExcel:range("C" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(favorecido.ds-favorecido, CHR(10), " "), CHR(13), " ")),1,20).
    chExcel:range("D" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(atendimento.contato, CHR(10), " "), CHR(13), " ")),1,20).     
    chExcel:range("E" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(atendimento.observacao, CHR(10), " "), CHR(13), " ")),1,75).

   
    IF NOT CAN-FIND(FIRST tt-favorecido NO-LOCK
                    WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido) THEN DO:

       CREATE tt-favorecido.
       ASSIGN tt-favorecido.ds-favorecido = favorecido.ds-favorecido.

       
       FOR EACH tt-favorecido
           WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido:
           ASSIGN i-fav = i-fav + 1.
       END.
    END.
    ASSIGN counter-page = counter-page + 1
           i-atend = i-atend + 1.

    FIND FIRST tt-favorecido
        WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido NO-ERROR.

    ASSIGN tt-favorecido.qtd-favorecido = tt-favorecido.qtd-favorecido + 1.
    
END.

ASSIGN dt-aux = dtDataIni.
REPEAT:
    ASSIGN dt-aux = dt-aux + 1.

    CASE MONTH(dt-aux):
        WHEN 1  THEN ASSIGN c-mes-ano = "Jan" .
        WHEN 2  THEN ASSIGN c-mes-ano = "Fev" .
        WHEN 3  THEN ASSIGN c-mes-ano = "Mar" .
        WHEN 4  THEN ASSIGN c-mes-ano = "Abr" .
        WHEN 5  THEN ASSIGN c-mes-ano = "Mai" .
        WHEN 6  THEN ASSIGN c-mes-ano = "Jun" .
        WHEN 7  THEN ASSIGN c-mes-ano = "Jul" .
        WHEN 8  THEN ASSIGN c-mes-ano = "Ago" .
        WHEN 9  THEN ASSIGN c-mes-ano = "Set" .
        WHEN 10 THEN ASSIGN c-mes-ano = "Out" .
        WHEN 11 THEN ASSIGN c-mes-ano = "Nov" .
        WHEN 12 THEN ASSIGN c-mes-ano = "Dez" .
    END CASE.

    ASSIGN c-mes-ano = c-mes-ano + "-" + SUBSTRING(STRING(YEAR(dt-aux),"9999"), 3, 2). 

    FIND FIRST tt-resumo-atend
        WHERE tt-resumo-atend.mes-ano = c-mes-ano
        AND   tt-resumo-atend.semana  = fnSemana(dt-aux) NO-ERROR.
    IF NOT AVAIL tt-resumo-atend THEN DO:
        CREATE tt-resumo-atend.
        ASSIGN tt-resumo-atend.mes-ano = c-mes-ano
               tt-resumo-atend.semana  = fnSemana(dt-aux)
               tt-resumo-atend.mes     = MONTH(dt-aux)
               tt-resumo-atend.ano     = YEAR(dt-aux).
    END.

    IF dt-aux >= dtDataFim THEN LEAVE.
END.

RUN atend-excel.

/* FIM ATENDIMENTOS */ 

chExcel:sheets:ITEM(3):SELECT.
chExcel:range("B11"):VALUE   = STRING(dtDataIni, "99/99/9999") + " at‚ " + STRING(dtDataFim, "99/99/9999").
chExcel:range("B10"):VALUE   = cResp.
ASSIGN counter-page = 14.
/*  INICIO TAREFAS USUARIO */
EMPTY TEMP-TABLE tt-favorecido.
ASSIGN i-fav = 0
       i-sit[1] = 0
       i-sit[2] = 0
       i-sit[3] = 0
       i-sit[4] = 0.

FOR EACH tarefa NO-LOCK
    WHERE tarefa.responsavel = cResp
    AND   ((tarefa.dt-real-ini >= dtDataIni AND tarefa.dt-real-ini <= dtDataFim)
    OR     (tarefa.dt-real-fim >= dtDataIni AND tarefa.dt-real-fim <= dtDataFim)
    OR     (tarefa.dt-plan-ini >= dtDataIni AND tarefa.dt-plan-ini <= dtDataFim)
    OR     (tarefa.dt-plan-fim >= dtDataIni AND tarefa.dt-plan-fim <= dtDataFim)
    OR     (tarefa.dt-alert >= dtDataIni AND tarefa.dt-alert <= dtDataFim))
    BY tarefa.dt-alert:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.
    FIND FIRST ordem-serv OF tarefa NO-LOCK NO-ERROR.
    
    ASSIGN de-tot-apont = 0.
    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome-tarefa = tarefa.nome
        AND   apontamento.seq-tarefa = tarefa.sequencia
        AND   apontamento.nome = cResp:
        ASSIGN de-tot-apont = de-tot-apont + apontamento.qt-apontada.
    END.

    chExcel:range("A" + STRING(counter-page)):VALUE   = tarefa.dt-alert    .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-fav     .
    chExcel:range("C" + STRING(counter-page)):VALUE   = IF AVAIL ordem-serv THEN ordem-serv.ds-os ELSE ""      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = tarefa.ds-tarefa      .
    chExcel:range("F" + STRING(counter-page)):VALUE   = tarefa.qtd-horas      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = de-tot-apont          .
    chExcel:range("I" + STRING(counter-page)):VALUE   = tarefa.dt-plan-ini  .
    chExcel:range("J" + STRING(counter-page)):VALUE   = tarefa.dt-plan-fim  .
    chExcel:range("K" + STRING(counter-page)):VALUE   = tarefa.dt-real-ini    .
    chExcel:range("L" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .

    CASE tarefa.situacao:
        WHEN 1 THEN DO:
            chExcel:range("E" + STRING(counter-page)):VALUE = "Pendente".
            IF tarefa.dt-plan-ini < TODAY THEN DO:
                ASSIGN i-sit[4] = i-sit[4] + 1.
                chExcel:range("I" + STRING(counter-page)):FONT:ColorIndex = 3.
            END.
            ELSE
                ASSIGN i-sit[3] = i-sit[3] + 1.
        END.
        WHEN 2 THEN DO:
            chExcel:range("E" + STRING(counter-page)):VALUE = "Em Andamento".
            IF (tarefa.dt-plan-fim < TODAY
            OR  tarefa.dt-alert < TODAY) THEN DO:
                ASSIGN i-sit[4] = i-sit[4] + 1.
                IF tarefa.dt-plan-fim < TODAY THEN
                    chExcel:range("J" + STRING(counter-page)):FONT:ColorIndex = 3.
                IF tarefa.dt-alert < TODAY THEN
                    chExcel:range("A" + STRING(counter-page)):FONT:ColorIndex = 3.
            END.
            ELSE
                ASSIGN i-sit[3] = i-sit[3] + 1.
        END.
        WHEN 8 THEN DO:
            chExcel:range("E" + STRING(counter-page)):VALUE = "Conclu¡da".
            ASSIGN i-sit[1] = i-sit[1] + 1.
        END.
        WHEN 9 THEN DO:
            chExcel:range("E" + STRING(counter-page)):VALUE = "Cancelada".
            ASSIGN i-sit[2] = i-sit[2] + 1.
        END.
    END CASE.

    IF de-tot-apont > tarefa.qtd-horas THEN
        chExcel:range("G" + STRING(counter-page)):FONT:ColorIndex = 3.

    IF tarefa.situacao = 8 THEN DO:
        IF tarefa.qtd-horas > 0 THEN DO:
            ASSIGN de-tot-efi[1] = de-tot-efi[1] + (((tarefa.qtd-horas - de-tot-apont) / tarefa.qtd-horas) * 100)
                   de-tot-efi[2] = de-tot-efi[2] + 1.
            chExcel:range("H" + STRING(counter-page)):VALUE   = (((tarefa.qtd-horas - de-tot-apont) / tarefa.qtd-horas) * 100).
            IF tarefa.qtd-horas < de-tot-apont THEN
                chExcel:range("H" + STRING(counter-page)):FONT:ColorIndex = 3.
        END.
        ELSE DO:
            chExcel:range("H" + STRING(counter-page)):VALUE   = 0.
        END.
    END.
    ELSE
        chExcel:range("H" + STRING(counter-page)):VALUE   = 0.

    IF tarefa.dt-real-ini > tarefa.dt-plan-ini THEN
        chExcel:range("M" + STRING(counter-page)):VALUE = tarefa.dt-real-ini - tarefa.dt-plan-ini.
    ELSE
        chExcel:range("M" + STRING(counter-page)):VALUE = 0.
    
    IF tarefa.dt-real-fim > tarefa.dt-plan-fim THEN
        chExcel:range("N" + STRING(counter-page)):VALUE = tarefa.dt-real-fim - tarefa.dt-plan-fim.
    ELSE
        chExcel:range("N" + STRING(counter-page)):VALUE = 0.

    chExcel:range("O" + STRING(counter-page)):VALUE = (chExcel:range("M" + STRING(counter-page)):VALUE + chExcel:range("N" + STRING(counter-page)):VALUE) / 2.
    ASSIGN de-tot-atr[1] = de-tot-atr[1] + chExcel:range("O" + STRING(counter-page)):VALUE.

    IF tarefa.situacao > 1 THEN
        ASSIGN de-tot-atr[2] = de-tot-atr[2] + 1.

    chExcel:range("A" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("E" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("F" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("F" + STRING(counter-page)):NumberFormat = "0,00".
    chExcel:range("G" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("G" + STRING(counter-page)):NumberFormat = "0,00".
    chExcel:range("H" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("H" + STRING(counter-page)):NumberFormat = "0,00".
    chExcel:range("I" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("J" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("K" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("L" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("M" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("N" + STRING(counter-page)):HorizontalAlignment = 3.
    chExcel:range("O" + STRING(counter-page)):HorizontalAlignment = 3.
    
    ASSIGN counter-page = counter-page + 1.

END.

chExcel:range("R14"):VALUE = i-sit[1].
chExcel:range("R15"):VALUE = i-sit[2].
chExcel:range("R16"):VALUE = i-sit[3].
chExcel:range("R17"):VALUE = i-sit[4].

chExcel:range("H" + STRING(counter-page)):VALUE   = de-tot-efi[1] / de-tot-efi[2].
chExcel:range("H" + STRING(counter-page)):FONT:Bold = TRUE.
chExcel:range("H" + STRING(counter-page)):HorizontalAlignment = 3.
chExcel:range("O" + STRING(counter-page)):VALUE   = de-tot-atr[1] / de-tot-atr[2].
chExcel:range("O" + STRING(counter-page)):FONT:Bold = TRUE.
chExcel:range("O" + STRING(counter-page)):HorizontalAlignment = 3.

/* FIM CONCLUÖDAS éLTIMOS 7 DIAS */

/*
/* INICIO TAREFAS CANCELADAS */
RUN taref-canc-excel.
FOR EACH tarefa NO-LOCK
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-alert-tarefa >= dtDataIni
    AND   tarefa.dt-alert-tarefa <= dtDataFim
    AND tarefa.situacao = 9
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.
    
    ASSIGN de-tot-apont = 0.
    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome-tarefa = tarefa.nome
        AND   apontamento.seq-tarefa = tarefa.sequencia
        AND   apontamento.nome = cResp:

        ASSIGN de-tot-apont = de-tot-apont + apontamento.qt-apontada.

    END.

    chExcel:range("A" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-fav     .
    chExcel:range("C" + STRING(counter-page)):VALUE   = tarefa.ds-tarefa      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = tarefa.qtd-horas      .
    chExcel:range("E" + STRING(counter-page)):VALUE   = de-tot-apont.
    chExcel:range("F" + STRING(counter-page)):VALUE   = tarefa.dt-plan-ini  .
    chExcel:range("G" + STRING(counter-page)):VALUE   = tarefa.dt-plan-fim  .
    chExcel:range("H" + STRING(counter-page)):VALUE   = tarefa.dt-real-ini    .
    chExcel:range("I" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .

    IF NOT CAN-FIND(FIRST tt-favorecido NO-LOCK
                    WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido)  THEN DO:
    
       CREATE tt-favorecido.
       ASSIGN tt-favorecido.ds-favorecido = favorecido.ds-favorecido.
    
       FOR EACH tt-favorecido
           WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido:
    
           ASSIGN i-fav = i-fav + 1.
       END.
    END.
    ASSIGN counter-page = counter-page + 1
           i-atend = i-atend + 1.

END.
/* FIM TAREFAS CANCELADAS */

/* INICIO TAREFAS PENDENTES */
RUN taref-pend-excel.
FOR EACH tarefa NO-LOCK
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-alert-tarefa >= TODAY
    AND   tarefa.dt-alert-tarefa <= dtDataFim
    AND   tarefa.situacao < 8
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.
    
    ASSIGN de-tot-apont = 0.
    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome-tarefa = tarefa.nome
        AND   apontamento.seq-tarefa = tarefa.sequencia
        AND   apontamento.nome = cResp:

        ASSIGN de-tot-apont = de-tot-apont + apontamento.qt-apontada.

    END.

    chExcel:range("A" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-fav     .
    chExcel:range("C" + STRING(counter-page)):VALUE   = tarefa.ds-tarefa      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = tarefa.qtd-horas      .
    chExcel:range("E" + STRING(counter-page)):VALUE   = de-tot-apont.
    chExcel:range("F" + STRING(counter-page)):VALUE   = tarefa.dt-plan-ini  .
    chExcel:range("G" + STRING(counter-page)):VALUE   = tarefa.dt-plan-fim  .
    chExcel:range("H" + STRING(counter-page)):VALUE   = tarefa.dt-real-ini    .
    chExcel:range("I" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .
    IF NOT CAN-FIND(FIRST tt-favorecido NO-LOCK
                    WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido)  THEN DO:
    
       CREATE tt-favorecido.
       ASSIGN tt-favorecido.ds-favorecido = favorecido.ds-favorecido.
    
       FOR EACH tt-favorecido
           WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido:
    
           ASSIGN i-fav = i-fav + 1.
       END.
    END.
    ASSIGN counter-page = counter-page + 1
           i-atend = i-atend + 1.

END.
/* FIM TAREFAS PENDENTES */

/* INICIO TAREFAS ATRASADAS */
RUN taref-atras-excel.
FOR EACH tarefa NO-LOCK
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-alert-tarefa < TODAY
    AND   tarefa.situacao < 8
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.
    
    ASSIGN de-tot-apont = 0.
    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome-tarefa = tarefa.nome
        AND   apontamento.seq-tarefa = tarefa.sequencia
        AND   apontamento.nome = cResp:

        ASSIGN de-tot-apont = de-tot-apont + apontamento.qt-apontada.

    END.

    chExcel:range("A" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-fav     .
    chExcel:range("C" + STRING(counter-page)):VALUE   = tarefa.ds-tarefa      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = tarefa.qtd-horas      .
    chExcel:range("E" + STRING(counter-page)):VALUE   = de-tot-apont.
    chExcel:range("F" + STRING(counter-page)):VALUE   = tarefa.dt-plan-ini  .
    chExcel:range("G" + STRING(counter-page)):VALUE   = tarefa.dt-plan-fim  .
    chExcel:range("H" + STRING(counter-page)):VALUE   = tarefa.dt-real-ini    .
    chExcel:range("I" + STRING(counter-page)):VALUE   = tarefa.dt-real-fim    .
    IF NOT CAN-FIND(FIRST tt-favorecido NO-LOCK
                    WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido)  THEN DO:
    
       CREATE tt-favorecido.
       ASSIGN tt-favorecido.ds-favorecido = favorecido.ds-favorecido.
    
       FOR EACH tt-favorecido
           WHERE tt-favorecido.ds-favorecido = favorecido.ds-favorecido:
    
           ASSIGN i-fav = i-fav + 1.
       END.
    END.
    ASSIGN counter-page = counter-page + 1
           i-atend = i-atend + 1.

END.
chExcel:range("L18"):VALUE   = i-atend.
chExcel:range("A1"):SELECT.
chExcel:COLUMNS ("A:Z"):entirecolumn:autofit. /*ajusta as colunas dos dados*/
/* FIM TAREFAS ATRASADAS */
*/
/*     /*  FIM TAREFAS USUARIO */                                         */

chExcel:sheets:ITEM(4):SELECT.
chExcel:range("B11"):VALUE   = STRING(dtDataIni, "99/99/9999") + " at‚ " + STRING(dtDataFim, "99/99/9999").

ASSIGN counter-page = 15.
      
 /* INICIO USUARIOS */
RUN calc-dias. 
FOR EACH usuario NO-LOCK:
    
    IF cResp <> "Maickel"
    AND cResp <> "Silvano"
    AND cResp <> "Bruno" THEN
        IF usuario.nome <> cResp THEN NEXT.

    ASSIGN de-hrs = 0
           de-hrs-proj = 0
           de-hrs-dsl = 0
           de-hrs-adm = 0
           de-hrs-com = 0
           de-hrs-fer = 0
           de-hrs-int = 0
           de-hrs-tre = 0
           de-hrs-dis = 0.

    FOR EACH apontamento OF usuario
        WHERE apontamento.data >= dtDataIni
        AND   apontamento.data <= dtDataFim
        BREAK BY apontamento.nome:

        IF FIRST-OF(apontamento.nome) THEN
            ASSIGN de-tot-hrs-uti = de-tot-hrs-uti + de-hrs-uti.

        FIND FIRST pedido-item OF apontamento.
        FIND FIRST item OF pedido-item.
        FIND FIRST pedido OF pedido-item.
        IF NOT item.un MATCHES("*HR*") THEN NEXT.
        ASSIGN de-hrs = de-hrs + apontamento.qt-apontada.

        CASE item.cd-item:
            WHEN 14 THEN DO:
                IF pedido.nom-projeto MATCHES("*Gerencial*") THEN DO:
                    IF pedido-item.ds-pedido-item MATCHES("Administrativo*")
                    OR pedido-item.ds-pedido-item MATCHES("Faturamento*")
                    OR pedido-item.ds-pedido-item MATCHES("Lan‡amentos Financeiros*")
                    OR pedido-item.ds-pedido-item MATCHES("GestÆo Administrativa*")
                    OR pedido-item.ds-pedido-item MATCHES("Planejamento Estrat*") THEN
                        ASSIGN de-hrs-adm = de-hrs-adm + apontamento.qt-apontada.
                    ELSE
                        IF pedido-item.ds-pedido-item MATCHES("*Dispon*") THEN
                            ASSIGN de-hrs-dis = de-hrs-dis + apontamento.qt-apontada.
                        ELSE
                            ASSIGN de-hrs-int = de-hrs-int + apontamento.qt-apontada.
                END.
                ELSE
                    ASSIGN de-hrs-com = de-hrs-com + apontamento.qt-apontada.
            END.
            WHEN 15 THEN DO:
                ASSIGN deQtdT = 0.
                IF WEEKDAY(apontamento.data) = 1 /* S bado */
                OR WEEKDAY(apontamento.data) = 7 /* Domingo */
                OR CAN-FIND(FIRST feriado
                            WHERE feriado.dt-feriado = apontamento.data) THEN DO:
                    ASSIGN deQtdT = apontamento.qt-apontada.
                END.
                ELSE DO:
                    IF apontamento.hora-ini < "08:00" OR apontamento.hora-fim > "18:00" THEN DO:
                        IF apontamento.hora-ini < "08:00" THEN DO:
                            ASSIGN iHr-ini = INT(ENTRY(1,apontamento.hora-ini,":"))
                                   iMin-ini = INT(ENTRY(2,apontamento.hora-ini,":"))
                                   iHr-fim = 8
                                   iMin-fim = 0.
                            IF iMin-ini = 0 THEN
                                ASSIGN iMin-ini = 60.
                            ELSE
                                ASSIGN iHr-ini = iHr-ini + 1.

                            ASSIGN deQtd = iHr-fim - iHr-ini
                                   deQtd = deQtd + ((60 - iMin-ini) / 60)
                                   deQtd = deQtd + (iMin-fim / 60)
                                   deQtdT = deQtdT + deQtd.
                        END.
                        IF apontamento.hora-fim > "18:00" THEN DO:
                            ASSIGN iHr-ini = 18
                                   iMin-ini = 0
                                   iHr-fim = INT(ENTRY(1,apontamento.hora-fim,":"))
                                   iMin-fim = INT(ENTRY(2,apontamento.hora-fim,":")).
                            IF iMin-ini = 0 THEN
                                ASSIGN iMin-ini = 60.
                            ELSE
                                ASSIGN iHr-ini = iHr-ini + 1.

                            ASSIGN deQtd = iHr-fim - iHr-ini
                                   deQtd = deQtd + ((60 - iMin-ini) / 60)
                                   deQtd = deQtd + (iMin-fim / 60)
                                   deQtdT = deQtdT + deQtd.
                        END.
                    END.
                END.
                IF deQtdT > apontamento.qt-apontada THEN ASSIGN deQtdT = apontamento.qt-apontada.
                IF deQtdT > 0 THEN DO:
                    ASSIGN de-hrs-dsl = de-hrs-dsl + deQtdT
                           de-hrs-proj = de-hrs-proj + (apontamento.qt-apontada - deQtdT).
                END.
                ELSE DO:
                    ASSIGN de-hrs-proj = de-hrs-proj + apontamento.qt-apontada.
                END.
            END.
            WHEN 18 THEN ASSIGN de-hrs-tre = de-hrs-tre + apontamento.qt-apontada.
            WHEN 31 THEN ASSIGN de-hrs-fer = de-hrs-fer + apontamento.qt-apontada.
            OTHERWISE ASSIGN de-hrs-proj = de-hrs-proj + apontamento.qt-apontada.
        END CASE.

    END.

    FOR EACH visita OF usuario
        WHERE visita.compromisso
        AND   visita.dt-visita >= dtDataIni
        AND   visita.dt-visita <= dtDataFim
        AND   visita.ds-visita MATCHES ("*F‚rias*"):
        ASSIGN de-hrs-fer = de-hrs-fer + visita.qt-visita
               de-hrs = de-hrs + visita.qt-visita.
    END.

    IF de-hrs > 0 THEN DO:

        IF usuario.nome = cResp THEN DO:
            chExcel:range("A14"):VALUE   = usuario.nome  .
            chExcel:range("B14"):VALUE   = de-hrs-uti    .
            chExcel:range("C14"):VALUE   = de-hrs        .
            chExcel:range("D14"):VALUE   = de-hrs-proj   .
            chExcel:range("E14"):VALUE   = de-hrs-int    .
            chExcel:range("F14"):VALUE   = de-hrs-dis    .
            chExcel:range("G14"):VALUE   = de-hrs-adm    .
            chExcel:range("H14"):VALUE   = de-hrs-com    .
            chExcel:range("I14"):VALUE   = de-hrs-fer    .
            chExcel:range("J14"):VALUE   = de-hrs-tre    .
            chExcel:range("K14"):VALUE   = de-hrs-dsl    .
        END.
        ELSE DO:
            chExcel:range("A" + STRING(counter-page)):VALUE   = usuario.nome  .
            chExcel:range("B" + STRING(counter-page)):VALUE   = de-hrs-uti    .
            chExcel:range("C" + STRING(counter-page)):VALUE   = de-hrs        .
            chExcel:range("D" + STRING(counter-page)):VALUE   = de-hrs-proj   .
            chExcel:range("E" + STRING(counter-page)):VALUE   = de-hrs-int    .
            chExcel:range("F" + STRING(counter-page)):VALUE   = de-hrs-dis    .
            chExcel:range("G" + STRING(counter-page)):VALUE   = de-hrs-adm    .
            chExcel:range("H" + STRING(counter-page)):VALUE   = de-hrs-com    .
            chExcel:range("I" + STRING(counter-page)):VALUE   = de-hrs-fer    .
            chExcel:range("J" + STRING(counter-page)):VALUE   = de-hrs-tre    .
            chExcel:range("K" + STRING(counter-page)):VALUE   = de-hrs-dsl    .
            ASSIGN counter-page = counter-page + 1.
        END.
        
        ASSIGN /*de-tot-hrs-uti   = de-tot-hrs-uti    + de-hrs-uti */
               de-tot-hrs       = de-tot-hrs        + de-hrs     
               de-tot-hrs-proj  = de-tot-hrs-proj   + de-hrs-proj
               de-tot-hrs-int   = de-tot-hrs-int    + de-hrs-int 
               de-tot-hrs-dis   = de-tot-hrs-dis    + de-hrs-dis 
               de-tot-hrs-adm   = de-tot-hrs-adm    + de-hrs-adm 
               de-tot-hrs-com   = de-tot-hrs-com    + de-hrs-com 
               de-tot-hrs-fer   = de-tot-hrs-fer    + de-hrs-fer 
               de-tot-hrs-tre   = de-tot-hrs-tre    + de-hrs-tre 
               de-tot-hrs-dsl   = de-tot-hrs-dsl    + de-hrs-dsl.
    END.

END.

RUN propostas-abert-excel.
/* Aberto */
FOR EACH pedido NO-LOCK
    WHERE pedido.dt-pedido  >= dtDataIni
    AND   pedido.dt-pedido  <= dtDataFim
    AND   pedido.nr-pedido-ant = 0:

    FIND FIRST favorecido OF pedido NO-LOCK.

    IF favorecido.cd-favorecido = 440 THEN NEXT.

    chExcel:range("A" + STRING(counter-page)):VALUE   = pedido.nr-pedido      .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-favorecido.
    chExcel:range("C" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(pedido.nom-projeto, CHR(10), " "), CHR(13), " ")),1,50).
    chExcel:range("D" + STRING(counter-page)):VALUE   = pedido.num-cliente    .
    chExcel:range("E" + STRING(counter-page)):VALUE   = pedido.responsavel    .
    chExcel:range("F" + STRING(counter-page)):VALUE   = pedido.val-total      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = pedido.dt-pedido    .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = pedido.dt-aprovacao    .      */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = pedido.dt-encerramento      . */
    ASSIGN counter-page = counter-page + 1
           i-atend = i-atend + 1.
END.

RUN propostas-aprov-excel. 

FOR EACH pedido NO-LOCK
    WHERE pedido.dt-aprovacao >= dtDataIni
    AND   pedido.dt-aprovacao <= dtDataFim
    AND   pedido.nr-pedido-ant = 0:

    FIND FIRST favorecido OF pedido NO-LOCK.
    IF favorecido.cd-favorecido = 440 THEN NEXT.

    chExcel:range("A" + STRING(counter-page)):VALUE   = pedido.nr-pedido      .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-favorecido.
    chExcel:range("C" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(pedido.nom-projeto, CHR(10), " "), CHR(13), " ")),1,50).
    chExcel:range("D" + STRING(counter-page)):VALUE   = pedido.num-cliente    .
    chExcel:range("E" + STRING(counter-page)):VALUE   = pedido.responsavel    .
    chExcel:range("F" + STRING(counter-page)):VALUE   = pedido.val-total      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = pedido.dt-aprovacao    .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = pedido.dt-aprovacao    .      */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = pedido.dt-encerramento      . */
    ASSIGN counter-page = counter-page + 1
           i-atend      = i-atend + 1.
           

END.

RUN propostas-canc-excel.
FOR EACH pedido NO-LOCK
    WHERE pedido.dt-encerramento >= dtDataIni
    AND   pedido.dt-encerramento <= dtDataFim
    AND   pedido.nr-pedido-ant = 0
    AND   pedido.situacao = 9: 

    FIND FIRST favorecido OF pedido NO-LOCK.
    IF favorecido.cd-favorecido = 440 THEN NEXT.

    chExcel:range("A" + STRING(counter-page)):VALUE   = pedido.nr-pedido      .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-favorecido.
    chExcel:range("C" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(pedido.nom-projeto, CHR(10), " "), CHR(13), " ")),1,50).
    chExcel:range("D" + STRING(counter-page)):VALUE   = pedido.num-cliente    .
    chExcel:range("E" + STRING(counter-page)):VALUE   = pedido.responsavel    .
    chExcel:range("F" + STRING(counter-page)):VALUE   = pedido.val-total      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = pedido.dt-encerramento    .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = pedido.dt-aprovacao    .      */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = pedido.dt-encerramento      . */
    ASSIGN counter-page = counter-page + 1
           i-atend      = i-atend + 1.
           

END.

RUN propostas-pend-excel.
FOR EACH pedido NO-LOCK
    WHERE pedido.dt-aprovacao = ?
    AND   pedido.nr-pedido-ant = 0
    AND   pedido.dt-pedido   < dtDataIni
    AND   pedido.situacao    <= 2: 

    FIND FIRST favorecido OF pedido NO-LOCK.
    IF favorecido.cd-favorecido = 440 THEN NEXT.

    chExcel:range("A" + STRING(counter-page)):VALUE   = pedido.nr-pedido      .
    chExcel:range("B" + STRING(counter-page)):VALUE   = favorecido.ds-favorecido.
    chExcel:range("C" + STRING(counter-page)):VALUE   = SUBSTRING(TRIM(REPLACE(REPLACE(pedido.nom-projeto, CHR(10), " "), CHR(13), " ")),1,50).
    chExcel:range("D" + STRING(counter-page)):VALUE   = pedido.num-cliente    .
    chExcel:range("E" + STRING(counter-page)):VALUE   = pedido.responsavel    .
    chExcel:range("F" + STRING(counter-page)):VALUE   = pedido.val-total      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = pedido.dt-pedido    .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = pedido.dt-aprovacao    .      */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = pedido.dt-encerramento      . */
    ASSIGN counter-page = counter-page + 1
           i-atend      = i-atend + 1.
END.

chExcel:range("L18"):VALUE   = i-atend.


chExcel:range("A1"):SELECT.
chExcel:COLUMNS ("A:Z"):entirecolumn:autofit. /*ajusta as colunas dos dados*/

chExcel:sheets:ITEM(1):SELECT.
chExcel:range("B10"):VALUE   = STRING(dtDataIni, "99/99/9999") + " at‚ " + STRING(dtDataFim, "99/99/9999").

PROCEDURE calc-dias.
    ASSIGN de-hrs-uti   = 0.

    REPEAT dt-cont = dtDataIni TO (IF TODAY > dtDataFim THEN dtDataFim ELSE TODAY):
    IF WEEKDAY(dt-cont) = 1 THEN NEXT.
    IF WEEKDAY(dt-cont) = 7 THEN NEXT.
    IF CAN-FIND(FIRST feriado NO-LOCK
                WHERE feriado.dt-feriado = dt-cont) THEN NEXT.
    ASSIGN de-hrs-uti = de-hrs-uti + 8.5
           i-dias     = i-dias + 1.
    END.
                                                                                             
                                                                                             
END PROCEDURE.                                                         
PROCEDURE atend-excel.

chExcel:range("H13"):VALUE   = i-atend.
chExcel:range("H16"):VALUE   = i-atend / i-dias.
chExcel:range("H19"):VALUE   = i-fav.


ASSIGN i-resumo = 15.
FOR EACH tt-resumo-atend
   BY tt-resumo-atend.ano
   BY tt-resumo-atend.mes
   BY tt-resumo-atend.semana:
    chExcel:range("J" + STRING(i-resumo)):VALUE   = tt-resumo-atend.mes-ano + "|S" + string(tt-resumo-atend.semana).
    chExcel:range("K" + STRING(i-resumo)):VALUE   = tt-resumo-atend.qtd-atend.

    ASSIGN i-resumo = i-resumo + 1.

END. 

ASSIGN i-excel2 = i-resumo.        

ASSIGN i-resumo = 15.
FOR EACH tt-favorecido
    BREAK BY tt-favorecido.qtd-favorecido DESC:

    chExcel:range("M" + STRING(i-resumo)):VALUE   = tt-favorecido.ds-favorecido.
    chExcel:range("N" + STRING(i-resumo)):VALUE   = tt-favorecido.qtd-favorecido.
    ASSIGN i-resumo = i-resumo + 1
           i-fav2   = i-fav2   + 1.

    IF LAST-OF(tt-favorecido.qtd-favorecido) AND i-fav2 >= 10 THEN DO:
        LEAVE.
    END.
END.
ASSIGN i-excel = i-fav2.

chExcel:range("A1"):SELECT.
chExcel:COLUMNS ("A:Z"):entirecolumn:autofit. /*ajusta as colunas dos dados*/ 

END PROCEDURE.


/* INICIO PROCEDURES GERA EXCEL */

PROCEDURE taref-canc-excel.

    chExcel:range("L15"):VALUE   = i-atend.
    /*Formata‡Æo dinamica Excel*/
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("B" + STRING(counter-page)):VALUE = "Canceladas" .
    chExcel:range("B" + STRING(counter-page) + ":A" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Merge.
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:HorizontalAlignment = -4108.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(4):Weight = 3.
    
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "Data"        .
    chExcel:range("B" + STRING(counter-page)):VALUE   = "Favorecido"  .
    chExcel:range("C" + STRING(counter-page)):VALUE   = "Tarefa"      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = "Qtd. Horas"  .
    chExcel:range("E" + STRING(counter-page)):VALUE   = "Qtd. Apontada"  .
    chExcel:range("F" + STRING(counter-page)):VALUE   = "Dt. Prev. Ini"  .
    chExcel:range("G" + STRING(counter-page)):VALUE   = "Dt. Prev. Fim"  .
    chExcel:range("H" + STRING(counter-page)):VALUE   = "Dt. Real Ini"  .
    chExcel:range("I" + STRING(counter-page)):VALUE   = "Dt. Real Fim"  .
    
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(4):Weight = 3.
    
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:SELECTION:interior:colorindex = 44.
    
    /*Fim formata‡Æo dinamica Excel*/
    
    /* CANCELADAS NOS éLTIMOS 7 DIAS */
    EMPTY TEMP-TABLE tt-favorecido.
    ASSIGN i-fav = 0
           i-atend = 0.
    
    ASSIGN counter-page = counter-page + 1. 

    RETURN "OK:".

END PROCEDURE.

PROCEDURE taref-pend-excel.

    chExcel:range("L16"):VALUE   = i-atend.
    
    /*Formata‡Æo dinamica Excel*/
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("B" + STRING(counter-page)):VALUE = "Pendentes" .
    chExcel:range("B" + STRING(counter-page) + ":A" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Merge.
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:HorizontalAlignment = -4108.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(4):Weight = 3.
    
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "Data"        .
    chExcel:range("B" + STRING(counter-page)):VALUE   = "Favorecido"  .
    chExcel:range("C" + STRING(counter-page)):VALUE   = "Tarefa"      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = "Qtd. Horas"  .
    chExcel:range("E" + STRING(counter-page)):VALUE   = "Qtd. Apontada"  .
    chExcel:range("F" + STRING(counter-page)):VALUE   = "Dt. Prev. Ini"  .
    chExcel:range("G" + STRING(counter-page)):VALUE   = "Dt. Prev. Fim"  .
    chExcel:range("H" + STRING(counter-page)):VALUE   = "Dt. Real Ini"  .
    chExcel:range("I" + STRING(counter-page)):VALUE   = "Dt. Real Fim"  .
    
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(4):Weight = 3.
    
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:SELECTION:interior:colorindex = 44.
    
    /*Fim formata‡Æo dinamica Excel*/
    
    /* PENDENTES */
    ASSIGN counter-page = counter-page + 1.
    EMPTY TEMP-TABLE tt-favorecido.
    ASSIGN i-fav = 0
           i-atend = 0.
    
    RETURN "OK:".

END PROCEDURE.

PROCEDURE taref-atras-excel.

    chExcel:range("L17"):VALUE   = i-atend.

    /*Formata‡Æo dinamica Excel*/
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("B" + STRING(counter-page)):VALUE = "Atrasadas" .
    chExcel:range("B" + STRING(counter-page) + ":A" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Merge.
    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:HorizontalAlignment = -4108.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(4):Weight = 3.

    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "Data"        .
    chExcel:range("B" + STRING(counter-page)):VALUE   = "Favorecido"  .
    chExcel:range("C" + STRING(counter-page)):VALUE   = "Tarefa"      .
    chExcel:range("D" + STRING(counter-page)):VALUE   = "Qtd. Horas"  .
    chExcel:range("E" + STRING(counter-page)):VALUE   = "Qtd. Apontada"  .
    chExcel:range("F" + STRING(counter-page)):VALUE   = "Dt. Prev. Ini"  .
    chExcel:range("G" + STRING(counter-page)):VALUE   = "Dt. Prev. Fim"  .
    chExcel:range("H" + STRING(counter-page)):VALUE   = "Dt. Real Ini"  .
    chExcel:range("I" + STRING(counter-page)):VALUE   = "Dt. Real Fim"  .

    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):Borders(4):Weight = 3.

    chExcel:range("A" + STRING(counter-page) + ":I" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:SELECTION:interior:colorindex = 44.

    /*Fim formata‡Æo dinamica Excel*/

    /* ATRASADAS */
    ASSIGN counter-page = counter-page + 1.
    EMPTY TEMP-TABLE tt-favorecido.
    ASSIGN i-fav = 0
           i-atend = 0.

    RETURN "OK:".

END PROCEDURE.

PROCEDURE propostas-aprov-excel.

    chExcel:range("L15"):VALUE   = i-atend.
    
    /*Formata‡Æo dinamica Excel*/
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("B" + STRING(counter-page)):VALUE = "Aprovadas" .
    chExcel:range("B" + STRING(counter-page) + ":A" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Merge.
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:HorizontalAlignment = -4108.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(4):Weight = 3.
    
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "Pedido"           .
    chExcel:range("B" + STRING(counter-page)):VALUE   = "Favorecido"       .
    chExcel:range("C" + STRING(counter-page)):VALUE   = "Projeto"          .
    chExcel:range("D" + STRING(counter-page)):VALUE   = "Cliente"          .
    chExcel:range("E" + STRING(counter-page)):VALUE   = "Respons vel"      .
    chExcel:range("F" + STRING(counter-page)):VALUE   = "Valor Total"      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = "Data"     .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = "Dt. Aprova‡Æo"    . */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = "Dt. Cancelamento" . */
    
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(4):Weight = 3.
    
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:SELECTION:interior:colorindex = 44.
    
    /*Fim formata‡Æo dinamica Excel*/
    
    /* APROVADAS */
    ASSIGN counter-page = counter-page + 1
           i-atend = 0.

    RETURN "OK:".

END PROCEDURE.

PROCEDURE propostas-canc-excel.

    chExcel:range("L16"):VALUE   = i-atend.
    
    /*Formata‡Æo dinamica Excel*/
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("B" + STRING(counter-page)):VALUE = "Canceladas" .
    chExcel:range("B" + STRING(counter-page) + ":A" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Merge.
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:HorizontalAlignment = -4108.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(4):Weight = 3.
    
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "Pedido"           .
    chExcel:range("B" + STRING(counter-page)):VALUE   = "Favorecido"       .
    chExcel:range("C" + STRING(counter-page)):VALUE   = "Projeto"          .
    chExcel:range("D" + STRING(counter-page)):VALUE   = "Cliente"          .
    chExcel:range("E" + STRING(counter-page)):VALUE   = "Respons vel"      .
    chExcel:range("F" + STRING(counter-page)):VALUE   = "Valor Total"      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = "Data"     .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = "Dt. Aprova‡Æo"    . */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = "Dt. Cancelamento" . */
    
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(4):Weight = 3.
    
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:SELECTION:interior:colorindex = 44.
    /*Fim formata‡Æo dinamica Excel*/
    
    /* Canceladas */
    ASSIGN counter-page = counter-page + 1
            i-atend = 0.

    RETURN "OK:".

END PROCEDURE.

PROCEDURE propostas-abert-excel.

    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "TOTAL"        .
    chExcel:range("B" + STRING(counter-page)):VALUE   = de-tot-hrs-uti   .
    chExcel:range("C" + STRING(counter-page)):VALUE   = de-tot-hrs       .
    chExcel:range("D" + STRING(counter-page)):VALUE   = de-tot-hrs-proj  .
    chExcel:range("E" + STRING(counter-page)):VALUE   = de-tot-hrs-int   .
    chExcel:range("F" + STRING(counter-page)):VALUE   = de-tot-hrs-dis   .
    chExcel:range("G" + STRING(counter-page)):VALUE   = de-tot-hrs-adm   .
    chExcel:range("H" + STRING(counter-page)):VALUE   = de-tot-hrs-com   .
    chExcel:range("I" + STRING(counter-page)):VALUE   = de-tot-hrs-fer   .
    chExcel:range("J" + STRING(counter-page)):VALUE   = de-tot-hrs-tre   .
    chExcel:range("K" + STRING(counter-page)):VALUE   = de-tot-hrs-dsl   .

    ASSIGN iLinhaTot = counter-page.

    chExcel:Range("A" + STRING(counter-page) + ":K" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":K" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":K" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":K" + STRING(counter-page)):Borders(4):Weight = 3.

    chExcel:range("A" + STRING(counter-page) + ":K" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/

    /* FIM USUARIOS */
    /*chExcel:range("A11"):SELECT.
    chExcel:COLUMNS ("A:Z"):entirecolumn:autofit. /*ajusta as colunas dos dados*/*/

    chExcel:sheets:ITEM(5):SELECT.
    chExcel:range("B11"):VALUE   = STRING(dtDataIni, "99/99/9999") + " at‚ " + STRING(dtDataFim, "99/99/9999").

    ASSIGN counter-page = 15
           i-atend = 0.

    RETURN "OK:".

END PROCEDURE.

PROCEDURE propostas-pend-excel.

    chExcel:range("L17"):VALUE   = i-atend.
    
    /*Formata‡Æo dinamica Excel*/
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("B" + STRING(counter-page)):VALUE = "Pendentes" .
    chExcel:range("B" + STRING(counter-page) + ":A" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Merge.
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:HorizontalAlignment = -4108.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(4):Weight = 3.
    
    ASSIGN counter-page = counter-page + 1.
    chExcel:range("A" + STRING(counter-page)):VALUE   = "Pedido"           .
    chExcel:range("B" + STRING(counter-page)):VALUE   = "Favorecido"       .
    chExcel:range("C" + STRING(counter-page)):VALUE   = "Projeto"          .
    chExcel:range("D" + STRING(counter-page)):VALUE   = "Cliente"          .
    chExcel:range("E" + STRING(counter-page)):VALUE   = "Respons vel"      .
    chExcel:range("F" + STRING(counter-page)):VALUE   = "Valor Total"      .
    chExcel:range("G" + STRING(counter-page)):VALUE   = "Data"     .
/*     chExcel:range("H" + STRING(counter-page)):VALUE   = "Dt. Aprova‡Æo"    . */
/*     chExcel:range("I" + STRING(counter-page)):VALUE   = "Dt. Cancelamento" . */
    
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(1):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(2):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(3):Weight = 3.
    chExcel:Range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):Borders(4):Weight = 3.
    
    chExcel:range("A" + STRING(counter-page) + ":G" + STRING(counter-page)):SELECT.
    chExcel:SELECTION:font:colorindex     = 1.
    chExcel:SELECTION:FONT:bold           = TRUE. /*Negrito*/
    chExcel:SELECTION:interior:colorindex = 44.
    /*Fim formata‡Æo dinamica Excel*/
    
    /* Pendentes */
    ASSIGN counter-page = counter-page + 1
            i-atend = 0.

    RETURN "OK:".

END PROCEDURE.
/* FIM PROCEDURES GERA EXCEL */

chExcel:worksheets:ITEM(1):SELECT.
chExcel:APPLICATION:activeSheet:ChartObjects("Chart 14"):Activate.

chExcel:ActiveChart:SeriesCollection(1):XVALUES = "=Atendimentos!$J$15:$J$" + STRING(i-excel2).
chExcel:ActiveChart:SeriesCollection(1):VALUES = "=Atendimentos!$K$15:$K$" + STRING(i-excel2).

chExcel:worksheets:ITEM(1):SELECT.
chExcel:APPLICATION:activeSheet:ChartObjects("Chart 12"):Activate.

chExcel:ActiveChart:SeriesCollection(1):NAME   = "=Atendimentos!$M$15:$M$" + STRING(14 + i-excel).
chExcel:ActiveChart:SeriesCollection(1):VALUES = "=Atendimentos!$N$15:$N$" + STRING(14 + i-excel).

chExcel:worksheets:ITEM(1):SELECT.
chExcel:APPLICATION:activeSheet:ChartObjects("Chart 3"):Activate.

chExcel:ActiveChart:SeriesCollection(2):VALUES = "=Horas!$C$12:$K$12".

chExcel:VISIBLE = TRUE.
chExcel:APPLICATION:WindowState = 3.  /*-4140 Minimizado -4143 Maxmizado */     
chExcel:sheets:ITEM(1):SELECT.
chExcel:range("A10"):SELECT.


/*Finaliza handle‹s do excel*/
IF VALID-HANDLE(ch-planilha1) THEN 
  RELEASE OBJECT ch-planilha1 NO-ERROR.  

IF VALID-HANDLE(ch-arquivo) THEN 
  RELEASE OBJECT ch-arquivo  NO-ERROR.                

IF VALID-HANDLE(chExcel) THEN 
 RELEASE OBJECT chExcel  NO-ERROR.

SESSION:SET-WAIT-STATE ("").

RELEASE OBJECT chExcel NO-ERROR.
