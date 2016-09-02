&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-mov-conta NO-UNDO LIKE mov-conta.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cStatus AS CHARACTER COLUMN-LABEL "Status" FORMAT "X(12)" NO-UNDO.

DEFINE BUFFER bfMov FOR mov-conta.
DEFINE BUFFER bf-mov-conta FOR mov-conta.

DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-favorecido AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE pcActionBT AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-Parent   AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-agenda AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

DEFINE VARIABLE cCategoria AS CHARACTER FORMAT "X(40)" COLUMN-LABEL "Categoria"  NO-UNDO.
DEFINE VARIABLE cSubCat AS CHARACTER FORMAT "X(40)" COLUMN-LABEL "Sub-Categoria"  NO-UNDO.

{seg.i}
{func\tt_info.i}
{campos\cd-favorecido.i}
{campos\cd-conta.i}
{func\data.i}
{proxpag.i}

DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO INITIAL 1.
DEFINE BUFFER bfProg FOR prog-agenda.
DEFINE BUFFER bfProg-mes FOR prog-agenda.
DEFINE BUFFER bfProg-sem FOR prog-agenda.
DEFINE BUFFER bfProg-dia FOR prog-agenda.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brProx

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-mov-conta

/* Definitions for BROWSE brProx                                        */
&Scoped-define FIELDS-IN-QUERY-brProx tt-mov-conta.dt-mov ~
fnCd-favorecido(tt-mov-conta.cd-favorecido) @ cCd-favorecido ~
fnCatSub(tt-mov-conta.cod-categoria, 0) @ cCategoria ~
fnCatSub(tt-mov-conta.cod-categoria, tt-mov-conta.cd-sub) @ cSubCat ~
fnCd-conta(tt-mov-conta.cd-conta) @ cCd-conta tt-mov-conta.usuar-resp ~
fnStatus() @ cStatus tt-mov-conta.de-valor 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brProx 
&Scoped-define QUERY-STRING-brProx FOR EACH tt-mov-conta NO-LOCK ~
    BY tt-mov-conta.dt-mov
&Scoped-define OPEN-QUERY-brProx OPEN QUERY brProx FOR EACH tt-mov-conta NO-LOCK ~
    BY tt-mov-conta.dt-mov.
&Scoped-define TABLES-IN-QUERY-brProx tt-mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-brProx tt-mov-conta


/* Definitions for FRAME DEFAULT-FRAME                                  */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brProx btFav data-ini data-end btValor ~
ls-tipo btAgenda ls-conta l-simula btSaltar btPagar btExit ls-resp IMAGE-1 ~
IMAGE-2 RECT-1 
&Scoped-Define DISPLAYED-OBJECTS deTot data-ini data-end ls-tipo ls-conta ~
l-simula ls-resp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnCatSub C-Win 
FUNCTION fnCatSub RETURNS CHARACTER
  ( iCat AS INT, iSub AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnConta C-Win 
FUNCTION fnConta RETURNS CHARACTER
  ( iCod AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnCriaMov C-Win 
FUNCTION fnCriaMov RETURNS CHARACTER
  ( iAgend AS INT, dtTemp AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnFavor C-Win 
FUNCTION fnFavor RETURNS CHARACTER
  ( iCod AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnStatus C-Win 
FUNCTION fnStatus RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAgenda 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Agenda" 
     SIZE 6.14 BY 1.79 TOOLTIP "Agendamentos".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btFav 
     IMAGE-UP FILE "image/im-login.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-login.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Fav" 
     SIZE 6.14 BY 1.79 TOOLTIP "Manutená∆o de Favorecidos".

DEFINE BUTTON btPagar 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Pagar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Gerar Movimento".

DEFINE BUTTON btSaltar 
     IMAGE-UP FILE "image/im-saltar.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saltar.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Saltar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Saltar Agendamento".

DEFINE BUTTON btValor 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Valor" 
     SIZE 6.14 BY 1.79 TOOLTIP "Alterar Valor".

DEFINE VARIABLE ls-conta AS CHARACTER FORMAT "X(256)":U INITIAL "Todas" 
     LABEL "Conta" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Todas" 
     DROP-DOWN-LIST
     SIZE 41 BY 1 NO-UNDO.

DEFINE VARIABLE ls-resp AS CHARACTER FORMAT "X(256)":U INITIAL "Todos" 
     LABEL "Respons†vel" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "Todos" 
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE ls-tipo AS CHARACTER FORMAT "X(256)":U INITIAL "Todas" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Todas","A Pagar","A Receber","Transferàncias" 
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE data-end AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE deTot AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total" 
     VIEW-AS FILL-IN 
     SIZE 10.57 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/im-flee.bmp":U
     SIZE 6 BY 1.5.

DEFINE IMAGE IMAGE-2
     FILENAME "image/im-fled.bmp":U
     SIZE 6 BY 1.5.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 159 BY 2.25.

DEFINE VARIABLE l-simula AS LOGICAL INITIAL no 
     LABEL "Incluir Simulaá‰es" 
     VIEW-AS TOGGLE-BOX
     SIZE 15 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brProx FOR 
      tt-mov-conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brProx
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brProx C-Win _STRUCTURED
  QUERY brProx NO-LOCK DISPLAY
      tt-mov-conta.dt-mov FORMAT "99/99/9999":U
      fnCd-favorecido(tt-mov-conta.cd-favorecido) @ cCd-favorecido
      fnCatSub(tt-mov-conta.cod-categoria, 0) @ cCategoria
      fnCatSub(tt-mov-conta.cod-categoria, tt-mov-conta.cd-sub) @ cSubCat
      fnCd-conta(tt-mov-conta.cd-conta) @ cCd-conta
      tt-mov-conta.usuar-resp FORMAT "X(8)":U
      fnStatus() @ cStatus
      tt-mov-conta.de-valor FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 159 BY 18
         FONT 1
         TITLE "Pr¢ximas Contas a Pagar / Receber".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     brProx AT ROW 5 COL 2
     btFav AT ROW 1.5 COL 142 WIDGET-ID 84
     deTot AT ROW 23.25 COL 148 COLON-ALIGNED WIDGET-ID 2
     data-ini AT ROW 1.92 COL 58 COLON-ALIGNED
     data-end AT ROW 1.92 COL 79 COLON-ALIGNED NO-LABEL
     btValor AT ROW 23 COL 14.29
     ls-tipo AT ROW 3.75 COL 2 NO-LABEL
     btAgenda AT ROW 1.5 COL 148
     ls-conta AT ROW 3.75 COL 23 COLON-ALIGNED
     l-simula AT ROW 3.75 COL 145
     btSaltar AT ROW 23 COL 8.14
     btPagar AT ROW 23 COL 2
     btExit AT ROW 1.5 COL 154.14
     ls-resp AT ROW 3.75 COL 125 COLON-ALIGNED WIDGET-ID 4
     IMAGE-1 AT ROW 1.5 COL 71
     IMAGE-2 AT ROW 1.5 COL 75
     RECT-1 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160.72 BY 23.83
         FONT 1.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-mov-conta T "?" NO-UNDO money mov-conta
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Pr¢ximos Movimentos"
         HEIGHT             = 23.83
         WIDTH              = 160.72
         MAX-HEIGHT         = 24.5
         MAX-WIDTH          = 161.86
         VIRTUAL-HEIGHT     = 24.5
         VIRTUAL-WIDTH      = 161.86
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = yes
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB brProx 1 DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN deTot IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX ls-tipo IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brProx
/* Query rebuild information for BROWSE brProx
     _TblList          = "Temp-Tables.tt-mov-conta"
     _Options          = "NO-LOCK"
     _OrdList          = "Temp-Tables.tt-mov-conta.dt-mov|yes"
     _FldNameList[1]   = Temp-Tables.tt-mov-conta.dt-mov
     _FldNameList[2]   > "_<CALC>"
"fnCd-favorecido(tt-mov-conta.cd-favorecido) @ cCd-favorecido" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"fnCatSub(tt-mov-conta.cod-categoria, 0) @ cCategoria" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"fnCatSub(tt-mov-conta.cod-categoria, tt-mov-conta.cd-sub) @ cSubCat" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"fnCd-conta(tt-mov-conta.cd-conta) @ cCd-conta" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = Temp-Tables.tt-mov-conta.usuar-resp
     _FldNameList[7]   > "_<CALC>"
"fnStatus() @ cStatus" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   = Temp-Tables.tt-mov-conta.de-valor
     _Query            is NOT OPENED
*/  /* BROWSE brProx */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Pr¢ximos Movimentos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Pr¢ximos Movimentos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brProx
&Scoped-define SELF-NAME brProx
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brProx C-Win
ON ROW-DISPLAY OF brProx IN FRAME DEFAULT-FRAME /* Pr¢ximas Contas a Pagar / Receber */
DO:
  
    IF tt-mov-conta.de-valor < 0 THEN
        ASSIGN tt-mov-conta.de-valor:FGCOLOR IN BROWSE brProx = 12.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brProx C-Win
ON VALUE-CHANGED OF brProx IN FRAME DEFAULT-FRAME /* Pr¢ximas Contas a Pagar / Receber */
DO:  
    DEFINE VARIABLE iCont AS INTEGER     NO-UNDO.

    ASSIGN deTot = 0.
    IF brProx:NUM-SELECTED-ROWS > 0 THEN DO:

        REPEAT iCont = 1 TO brProx:NUM-SELECTED-ROWS:

            brProx:FETCH-SELECTED-ROW(iCont).
            ASSIGN deTot = deTot + tt-mov-conta.de-valor.

        END.

    END.
    DISPLAY deTot WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAgenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAgenda C-Win
ON CHOOSE OF btAgenda IN FRAME DEFAULT-FRAME /* Agenda */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND FIRST agenda OF tt-mov-conta NO-LOCK NO-ERROR.
    IF AVAIL agenda THEN DO:
        ASSIGN r-agenda = ROWID(agenda).
        {func\run.i &Programa = "agend.w"}
        RUN displayFields.
    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Agendamentos (011)', INPUT 'Este movimento n∆o possui agendamento!', INPUT 'Esse movimento foi gerado a partir de uma parcela de NF e n∆o possui agendamento associado.')"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExit C-Win
ON CHOOSE OF btExit IN FRAME DEFAULT-FRAME /* Button 1 */
DO:
  
    {func\bt_fechar.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btFav
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFav C-Win
ON CHOOSE OF btFav IN FRAME DEFAULT-FRAME /* Fav */
DO:

    IF AVAIL tt-mov-conta THEN DO:
        FIND FIRST favorecido NO-LOCK
            WHERE favorecido.cd-favorecido = tt-mov-conta.cd-favorecido NO-ERROR.
        IF AVAIL favorecido THEN DO:
            ASSIGN r-favorecido = ROWID(favorecido).
            {func\run.i &Programa = "fav.w"}
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPagar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPagar C-Win
ON CHOOSE OF btPagar IN FRAME DEFAULT-FRAME /* Pagar */
DO:

    DEFINE VARIABLE l-OK AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE iConta AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iFav AS INTEGER    NO-UNDO.
    DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.

    DEF VAR i-cod-fav            AS INT.
    DEF VAR d-max                LIKE tt-mov-conta.de-valor.
    
    RUN som.p(INPUT "music\click.wav").

    IF brProx:NUM-SELECTED-ROWS > 0 THEN DO:
        IF brProx:NUM-SELECTED-ROWS = 1 THEN DO:

            IF tt-mov-conta.ds-observacao MATCHES("*PAGAMENTO DE IMPOSTO RETIDO - Controle:*") THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Pagar (011)', INPUT 'N∆o Ç permitido pagar esse movimento isoladamente!', INPUT 'Por se tratar de um movimento de imposto retido em NF, ele deve ser pago agrupado com o movimento de faturamento da respectiva NF.')"}
            END.
            ELSE DO:

                blk-trans:
                DO TRANSACTION:
        
                    FIND FIRST agenda EXCLUSIVE-LOCK
                        WHERE agenda.cd-agenda = tt-mov-conta.cd-agenda NO-ERROR.
        
                    IF tt-mov-conta.cd-agenda = 0 OR tt-mov-conta.dt-mov = fnProxDataPag(ROWID(agenda)) THEN DO:
                        CREATE mov-conta.
                        FIND LAST bfMov 
                            WHERE bfMov.cd-conta = tt-mov-conta.cd-conta NO-ERROR.
                        IF AVAIL bfMov THEN
                            ASSIGN mov-conta.cd-sequencia = bfMov.cd-sequencia + 1.
                        ELSE
                            ASSIGN mov-conta.cd-sequencia = 1.
                        BUFFER-COPY tt-mov-conta EXCEPT cd-sequencia TO mov-conta.
                        ASSIGN mov-conta.dt-mov = TODAY
                               mov-conta.usuar-resp = agenda.usuar-resp WHEN AVAIL agenda.
                        IF AVAIL agenda THEN
                            ASSIGN agenda.vl-atual = 0.
                        FIND FIRST conta OF mov-conta NO-LOCK.
                        ASSIGN r-mov-conta = ROWID(mov-conta)
                               r-parent = ROWID(conta)
                               pcActionBT = "UPDATE".
                        {func\run.i &Programa = "mov-conta_det.w"}
                        IF RETURN-VALUE <> "OK" THEN DO:
                            UNDO blk-trans, LEAVE blk-trans.
                        END.
    
                        RUN displayFields.
    
                    END.
                    ELSE DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Pagar (011)', INPUT 'Esta n∆o Ç a primeira ocorrància do agendamento!', INPUT 'S¢ Ç permitido pagar a primeira ocorrància do agendamento.')"}
                    END.
    
                END. /* blk-trans */

            END.

        END.
        ELSE DO:
    
            blk-trans:
            DO TRANSACTION:

                ASSIGN rTemp = ?.
        
                {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Agrupar ? (012)', INPUT 'Deseja agrupar os movimentos selecionados ?', INPUT 'Os movimentos selecionados ser∆o mostrados como um £nico movimento de agrupamento, mas poder∆o ser acessados e alterados individualmente de forma normal.')"}
                IF RETURN-VALUE = "OK" THEN DO:
                    
                    /** quando agrupar, deve abrir a tela seguinte: info.w, com o favorecido com o maior valor (dos que foram selecionados) **/
                    ASSIGN d-max = 0.
                    REPEAT iCont = 1 TO brProx:NUM-SELECTED-ROWS:
                        brProx:FETCH-SELECTED-ROW(iCont).

                        IF INPUT FRAME {&FRAME-NAME} deTot > 0 THEN DO:
                            IF tt-mov-conta.de-valor > d-max THEN
                                ASSIGN d-max = tt-mov-conta.de-valor
                                       i-cod-fav = tt-mov-conta.cd-favorecido.
                        END.
                        ELSE DO:
                            IF tt-mov-conta.de-valor < d-max THEN
                                ASSIGN d-max = tt-mov-conta.de-valor
                                       i-cod-fav = tt-mov-conta.cd-favorecido.

                        END.
                                                    
                    END.

                    FOR EACH tt-info:
                        DELETE tt-info.
                    END.
                    CREATE tt-info.
                    ASSIGN tt-info.campo = "Conta"
                           tt-info.tabela = "conta"
                           tt-info.campo-proc = "cd-conta"
                           tt-info.valor = STRING(tt-mov-conta.cd-conta)
                           tt-info.campo-desc = "ds-conta".

                    CREATE tt-info.
                    ASSIGN tt-info.campo = "Favorecido"
                           tt-info.tabela = "favorecido"
                           tt-info.campo-proc = "cd-favorecido"
                           tt-info.valor = STRING(i-cod-fav)
                           tt-info.campo-desc = "ds-favorecido".


                    {func\run.i &Programa = "func\info.w (INPUT-OUTPUT TABLE tt-info)"}

                    IF RETURN-VALUE = "OK" THEN DO:

                        FIND FIRST tt-info
                            WHERE tt-info.campo = "Conta".
                        IF tt-info.descricao = "" THEN DO:
                            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Conta Inv†lida (013)', INPUT 'N∆o foi informada conta v†lida!', INPUT 'N∆o foi informada uma conta v†lida no programa de Informaá‰es Adicionais para gerar o agrupamento.')"}
                            LEAVE blk-trans.
                        END.
                        ELSE DO:
                            ASSIGN iConta = INT(tt-info.valor).
                        END.

                        FIND FIRST tt-info
                            WHERE tt-info.campo = "Favorecido".
                        IF tt-info.descricao = "" THEN DO:
                            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Favorecido Inv†lido (014)', INPUT 'N∆o foi informado favorecido v†lido!', INPUT 'N∆o foi informado um favorecido v†lido no programa de Informaá‰es Adicionais para gerar o agrupamento.')"}
                            LEAVE blk-trans.
                        END.
                        ELSE DO:
                            ASSIGN iFav = INT(tt-info.valor).
                        END.

                    END.
                    ELSE DO:

                        LEAVE blk-trans.

                    END.

                    FIND LAST bfMov 
                        WHERE bfMov.cd-conta = iConta NO-ERROR.
                    IF AVAIL bfMov THEN
                        ASSIGN iSeq = bfMov.cd-sequencia + 1.
                    ELSE
                        ASSIGN iSeq = 1.
    
                    CREATE mov-conta.
                    ASSIGN mov-conta.cd-conta = iConta
                           mov-conta.cd-sequencia = iSeq
                           mov-conta.id-tipo = 0
                           mov-conta.dt-mov = TODAY
                           mov-conta.cd-favorecido = iFav
                           mov-conta.id-situacao = 1.
    
                    ASSIGN rTemp = ROWID(mov-conta).

                END. /* Deseja criar agrupamento ? */

                REPEAT iCont = 1 TO brProx:NUM-SELECTED-ROWS:
                    brProx:FETCH-SELECTED-ROW(iCont).

                    FIND FIRST agenda EXCLUSIVE-LOCK
                        WHERE agenda.cd-agenda = tt-mov-conta.cd-agenda NO-ERROR.

                    IF tt-mov-conta.cd-agenda = 0 OR tt-mov-conta.dt-mov = fnProxDataPag(ROWID(agenda)) THEN DO:

                        CREATE mov-conta.
                        FIND LAST bfMov 
                            WHERE bfMov.cd-conta = tt-mov-conta.cd-conta NO-ERROR.
                        IF AVAIL bfMov THEN
                            ASSIGN mov-conta.cd-sequencia = bfMov.cd-sequencia + 1.
                        ELSE
                            ASSIGN mov-conta.cd-sequencia = 1.
                        BUFFER-COPY tt-mov-conta EXCEPT cd-sequencia TO mov-conta.
                        ASSIGN mov-conta.dt-mov = TODAY
                               mov-conta.usuar-resp = agenda.usuar-resp WHEN AVAIL agenda.

                        IF rTemp <> ? THEN DO:
                            IF mov-conta.cd-conta = iConta THEN
                                ASSIGN mov-conta.agrupado = iSeq.
                        END.

                        IF tt-mov-conta.id-tipo = 3 THEN DO:
                            CREATE bf-mov-conta.
                            FIND LAST bfMov 
                                WHERE bfMov.cd-conta = tt-mov-conta.conta-transf NO-ERROR.
                            IF AVAIL bfMov THEN
                                ASSIGN bf-mov-conta.cd-sequencia = bfMov.cd-sequencia + 1
                                       bf-mov-conta.cd-conta = tt-mov-conta.conta-transf.
                            ELSE
                                ASSIGN bf-mov-conta.cd-sequencia = 1
                                       bf-mov-conta.cd-conta = tt-mov-conta.conta-transf.
                            BUFFER-COPY tt-mov-conta EXCEPT cd-sequencia cd-conta TO bf-mov-conta.
                            ASSIGN bf-mov-conta.dt-mov = TODAY
                                   bf-mov-conta.conta-transf = tt-mov-conta.cd-conta
                                   bf-mov-conta.seq-transf   = mov-conta.cd-sequencia
                                   mov-conta.seq-transf = bf-mov-conta.cd-sequencia
                                   bf-mov-conta.de-valor = (-1) * mov-conta.de-valor.

                            IF rTemp <> ? THEN DO:
                                IF bf-mov-conta.cd-conta = iConta THEN
                                    ASSIGN bf-mov-conta.agrupado = iSeq.
                            END.

                        END.
                        IF AVAIL agenda THEN
                            ASSIGN agenda.vl-atual = 0.
                    END.
                    ELSE DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Pagar (011)', INPUT 'Esta n∆o Ç a primeira ocorrància do agendamento!', INPUT 'S¢ Ç permitido pagar a primeira ocorrància do agendamento.')"}
                        UNDO blk-trans, LEAVE blk-trans.
                    END.

                END.
                                       
                IF rTemp <> ? THEN DO:
                    FIND FIRST mov-conta EXCLUSIVE-LOCK
                        WHERE ROWID(mov-conta) = rTemp.
                    FOR EACH bfMov NO-LOCK
                        WHERE bfMov.cd-conta = mov-conta.cd-conta
                        AND   bfMov.agrupado = mov-conta.cd-sequencia:
                        ASSIGN mov-conta.de-valor = mov-conta.de-valor + bfMov.de-valor.
                    END.
                    FIND FIRST conta OF mov-conta NO-LOCK.
                    ASSIGN r-mov-conta = rTemp
                           r-parent = ROWID(conta)
                           pcActionBT = "UPDATE".
                    {func\run.i &Programa = "mov-conta_det.w"}
                    IF RETURN-VALUE <> "OK" THEN DO:
                        UNDO blk-trans, LEAVE blk-trans.
                    END.
                END.
                ELSE DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Geraá∆o OK (015)', INPUT 'Movimentos gerados com sucesso!', INPUT 'Foram gerados os movimentos correspondentes aos agendamentos selecionados.')"}
                END.

                RUN displayFields.

            END. /* blk-trans */

        END. /* Mais de um registro selecionado */

    END. /* Nenhum registro selecionado */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSaltar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSaltar C-Win
ON CHOOSE OF btSaltar IN FRAME DEFAULT-FRAME /* Saltar */
DO:
    DEFINE VARIABLE dtProx AS DATE    NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").

    IF brProx:NUM-SELECTED-ROWS = 1 THEN DO:

        IF tt-mov-conta.ds-observacao MATCHES("*PAGAMENTO DE IMPOSTO RETIDO - Controle:*")
        OR tt-mov-conta.ds-observacao MATCHES("*FATURAMENTO - Controle:*") THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Saltar pagamento (009)', INPUT 'N∆o Ç permitido saltar esse movimento!', INPUT 'Movimento relacionado Ö pagamento de NF ou a imposto retido em NF n∆o pode ser saltado.')"}
        END.
        ELSE DO:
            FIND FIRST agenda EXCLUSIVE-LOCK
                WHERE agenda.cd-agenda = tt-mov-conta.cd-agenda NO-ERROR.
            IF AVAIL agenda THEN DO:
                IF tt-mov-conta.dt-mov = fnProxDataPag(ROWID(agenda)) THEN DO:
                    RUN calculaProximoPag(INPUT agenda.cd-agenda, INPUT tt-mov-conta.dt-mov, INPUT TRUE, OUTPUT dtProx).
                    ASSIGN agenda.dt-ultimo-pag = tt-mov-conta.dt-mov
                           agenda.vl-atual = 0.
                    RUN som.p(INPUT "music\ok.wav").
                    RUN displayFields.
                END.
                ELSE DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Saltar pagamento (009)', INPUT 'Esta n∆o Ç a primeira ocorrància do agendamento!', INPUT 'S¢ Ç permitido saltar o pagamento da primeira ocorrància do agendamento.')"}
                END.
            END.    
        END.

    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Saltar pagamento (010)', INPUT 'Mais de um movimento est† selecionado!', INPUT 'Para saltar o pagamento s¢ um registro pode estar selecionado.')"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btValor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btValor C-Win
ON CHOOSE OF btValor IN FRAME DEFAULT-FRAME /* Valor */
DO:
  
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    IF brProx:NUM-SELECTED-ROWS = 1 THEN DO:

        IF tt-mov-conta.ds-observacao MATCHES("*PAGAMENTO DE IMPOSTO RETIDO - Controle:*")
        OR tt-mov-conta.ds-observacao MATCHES("*FATURAMENTO - Controle:*") THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Alteraá∆o de valor (007)', INPUT 'N∆o Ç permitido alterar valor para esse movimento!', INPUT 'Movimento relacionado Ö pagamento de NF ou a imposto retido em NF n∆o pode ter seu valor alterado por este programa.')"}
        END.
        ELSE DO:

            FIND FIRST agenda EXCLUSIVE-LOCK
                WHERE agenda.cd-agenda = tt-mov-conta.cd-agenda.
        
            IF tt-mov-conta.dt-mov = fnProxDataPag(ROWID(agenda)) THEN DO:
                {func\run.i &Programa = "valor.w (INPUT 'Atualizar Valor', INPUT tt-mov-conta.de-valor, OUTPUT deTemp)"}
                IF deTemp = agenda.valor THEN DO:
                    ASSIGN agenda.vl-atual = 0.
                END.
                ELSE DO:
                    ASSIGN agenda.vl-atual = deTemp.
                END.
                RUN displayFields.
            END.
            ELSE DO:
                {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Alteraá∆o de valor (007)', INPUT 'Esta n∆o Ç a primeira ocorrància do agendamento!', INPUT 'S¢ Ç permitido alterar o valor da primeira ocorrància do agendamento.')"}
            END.

        END.

    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Alteraá∆o de valor (008)', INPUT 'Mais de um movimento est† selecionado!', INPUT 'Para alterar o valor s¢ um registro pode estar selecionado.')"}
    END.
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data-end
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-end C-Win
ON ENTRY OF data-end IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-end C-Win
ON LEAVE OF data-end IN FRAME DEFAULT-FRAME
DO:

    DEFINE VARIABLE dtAnt AS DATE    NO-UNDO.

    {func\set_leave.i}  
    ASSIGN dtAnt = data-end
           INPUT FRAME {&FRAME-NAME} data-end.
    IF dtAnt <> data-end THEN
        RUN displayFields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-ini C-Win
ON ENTRY OF data-ini IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-ini C-Win
ON LEAVE OF data-ini IN FRAME DEFAULT-FRAME /* Data */
DO:
    DEFINE VARIABLE dtAnt AS DATE    NO-UNDO.

    {func\set_leave.i}  
    ASSIGN dtAnt = data-ini
           INPUT FRAME {&FRAME-NAME} data-ini.
    IF dtAnt <> data-ini THEN
        RUN displayFields.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME l-simula
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL l-simula C-Win
ON VALUE-CHANGED OF l-simula IN FRAME DEFAULT-FRAME /* Incluir Simulaá‰es */
DO:

    RUN displayFields.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ls-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-conta C-Win
ON ENTRY OF ls-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-conta C-Win
ON LEAVE OF ls-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-conta C-Win
ON VALUE-CHANGED OF ls-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:

    ASSIGN INPUT FRAME {&FRAME-NAME} ls-conta.
    RUN displayFields.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ls-resp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-resp C-Win
ON ENTRY OF ls-resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-resp C-Win
ON LEAVE OF ls-resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-resp C-Win
ON VALUE-CHANGED OF ls-resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:

    ASSIGN INPUT FRAME {&FRAME-NAME} ls-resp.
    RUN displayFields.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ls-tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-tipo C-Win
ON ENTRY OF ls-tipo IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-tipo C-Win
ON LEAVE OF ls-tipo IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ls-tipo C-Win
ON VALUE-CHANGED OF ls-tipo IN FRAME DEFAULT-FRAME
DO:

    ASSIGN INPUT FRAME {&FRAME-NAME} ls-tipo.
    RUN displayFields.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i prox}
  RUN initialize.
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaTT C-Win 
PROCEDURE criaTT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.

DEFINE VARIABLE dtCont AS DATE       NO-UNDO.
DEFINE VARIABLE dtProx AS DATE       NO-UNDO.
DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
DEFINE VARIABLE l-sim AS LOGICAL    NO-UNDO.
DEFINE VARIABLE iAuxDiaNval AS INTEGER    NO-UNDO.

DEFINE VARIABLE de-val-imp AS DECIMAL     NO-UNDO.

SESSION:SET-WAIT-STATE("image\calc.cur").

ASSIGN INPUT FRAME default-frame data-ini data-end.

EMPTY TEMP-TABLE tt-mov-conta.

FOR EACH agenda NO-LOCK
    WHERE agenda.dt-ini <= data-ini
    AND   agenda.prox-data-pag >= data-ini
    AND   agenda.prox-data-pag <= data-end:

    ASSIGN dtCont = ?
           dtProx = agenda.prox-data-pag.

    REPEAT WHILE ((dtProx <= data-end) AND (dtCont <> dtProx)):
        ASSIGN dtCont = dtProx.
        fnCriaMov(agenda.cd-agenda, dtCont).
        RUN calculaProximoPag (INPUT agenda.cd-agenda, INPUT dtCont, INPUT FALSE, OUTPUT dtProx).
    END.

END.

IF param-mn.perfil = 2 /* Empresarial */ THEN DO:

    FIND FIRST conta NO-LOCK
        WHERE conta.id-tipo = 1 /* Conta Corrente */
        AND   NOT conta.id-encerrada
        AND   conta.cd-moeda = 0 NO-ERROR.
    IF AVAIL conta THEN DO:
        FOR EACH parc-nota-fiscal NO-LOCK
            WHERE parc-nota-fiscal.situacao = 1 /* Pendente */
            AND   parc-nota-fiscal.dt-pagto-parc >= data-ini
            AND   parc-nota-fiscal.dt-pagto-parc <= data-end:

            ASSIGN de-val-imp = 0.

            FIND FIRST nota-fiscal OF parc-nota-fiscal NO-LOCK NO-ERROR.

            IF parc-nota-fiscal.sequencia = 1 THEN DO:
                FOR EACH nota-fiscal-imp OF nota-fiscal NO-LOCK
                    WHERE nota-fiscal-imp.situacao = 2 /* Retido */:
                    FIND FIRST imposto OF nota-fiscal-imp NO-LOCK NO-ERROR.
                    IF imposto.tipo = 1 /* Retido */ THEN DO:
                        FIND FIRST agenda OF nota-fiscal-imp NO-LOCK NO-ERROR.
                        CREATE tt-mov-conta.
                        ASSIGN tt-mov-conta.cd-conta      = agenda.cd-conta
                               tt-mov-conta.cd-favorecido = agenda.cd-favorecido
                               tt-mov-conta.cod-categoria = imposto.cod-categoria
                               tt-mov-conta.cd-sub        = imposto.cd-sub
                               tt-mov-conta.id-tipo       = agenda.id-tipo
                               tt-mov-conta.de-valor      = (-1) * nota-fiscal-imp.val-imposto
                               tt-mov-conta.cd-sequencia  = iSeq
                               tt-mov-conta.dt-mov        = parc-nota-fiscal.dt-pagto-parc
                               tt-mov-conta.id-situacao   = 1
                               tt-mov-conta.nr-controle   = nota-fiscal.nr-controle
                               tt-mov-conta.cod-imposto   = nota-fiscal-imp.cod-imposto
                               tt-mov-conta.nr-mov        = nota-fiscal.nr-nota
                               tt-mov-conta.ds-observacao = "PAGAMENTO DE IMPOSTO RETIDO - Controle: " + STRING(nota-fiscal.nr-controle) + " - NF-em: " + STRING(nota-fiscal.nr-nota)
                               tt-mov-conta.usuar-resp    = "Todos"
                               iSeq = iSeq + 1
                               de-val-imp = de-val-imp + nota-fiscal-imp.val-imposto.
                    END.
                END.
            END.

            CREATE tt-mov-conta.
            ASSIGN tt-mov-conta.cd-conta      = conta.cd-conta
                   tt-mov-conta.cd-favorecido = nota-fiscal.cd-favorecido
                   tt-mov-conta.cod-categoria = nota-fiscal.cod-categoria
                   tt-mov-conta.cd-sub        = nota-fiscal.cd-sub
                   tt-mov-conta.id-tipo       = 1
                   tt-mov-conta.de-valor      = parc-nota-fiscal.val-parcela + de-val-imp
                   tt-mov-conta.cd-sequencia  = iSeq
                   tt-mov-conta.dt-mov        = parc-nota-fiscal.dt-pagto-parc
                   tt-mov-conta.id-situacao   = 1
                   tt-mov-conta.nr-controle   = nota-fiscal.nr-controle
                   tt-mov-conta.sequencia     = parc-nota-fiscal.sequencia
                   tt-mov-conta.nr-mov        = nota-fiscal.nr-nota
                   tt-mov-conta.ds-observacao = "FATURAMENTO - Controle: " + STRING(nota-fiscal.nr-controle) + " - NF-em: " + STRING(nota-fiscal.nr-nota) + " PARCELA: " + STRING(parc-nota-fiscal.sequencia)
                   tt-mov-conta.usuar-resp    = "Todos"
                   iSeq = iSeq + 1.

        END.
    END.

END.

FOR EACH tt-mov-conta EXCLUSIVE-LOCK
    WHERE tt-mov-conta.dt-mov > data-end
    OR    tt-mov-conta.dt-mov < data-ini:
    DELETE tt-mov-conta.
END.

SESSION:SET-WAIT-STATE("").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN INPUT FRAME default-frame l-simula.

    DISPLAY data-ini data-end 
        WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.

    RUN criaTT.

    ASSIGN ls-conta:LIST-ITEMS IN FRAME {&FRAME-NAME} = "Todas".
    FOR EACH tt-mov-conta:
        FIND FIRST conta OF tt-mov-conta NO-LOCK NO-ERROR.
        IF LOOKUP(conta.ds-conta,ls-conta:LIST-ITEMS IN FRAME {&FRAME-NAME}) = 0 THEN
            ASSIGN ls-conta:LIST-ITEMS IN FRAME {&FRAME-NAME} = ls-conta:LIST-ITEMS IN FRAME {&FRAME-NAME} + "," + conta.ds-conta.
    END.
    DISPLAY ls-conta WITH FRAME {&FRAME-NAME}.

    ASSIGN ls-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = "Todos".
    FOR EACH tt-mov-conta
        BREAK BY tt-mov-conta.usuar-resp:
        IF FIRST-OF(tt-mov-conta.usuar-resp) AND LOOKUP(tt-mov-conta.usuar-resp,ls-resp:LIST-ITEMS IN FRAME {&FRAME-NAME}) = 0 THEN
            ASSIGN ls-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = ls-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} + "," + tt-mov-conta.usuar-resp.
    END.
    IF INDEX(ls-resp:LIST-ITEMS IN FRAME {&FRAME-NAME}, ls-resp) = 0 THEN
        ASSIGN ls-resp = "Todos".
    DISPLAY ls-resp WITH FRAME {&FRAME-NAME}.

    CASE ls-tipo:
        WHEN "Transferàncias" THEN DO:
            FOR EACH tt-mov-conta
                WHERE tt-mov-conta.id-tipo <> 3:
                DELETE tt-mov-conta.
            END.
        END.
        WHEN "A Pagar" THEN DO:
            FOR EACH tt-mov-conta
                WHERE tt-mov-conta.de-valor > 0
                OR    tt-mov-conta.id-tipo = 3:
                DELETE tt-mov-conta.
            END.
        END.
        WHEN "A Receber" THEN DO:
            FOR EACH tt-mov-conta
                WHERE tt-mov-conta.de-valor < 0
                OR    tt-mov-conta.id-tipo = 3:
                DELETE tt-mov-conta.
            END.
        END.
    END CASE.

    IF ls-conta <> "Todas" THEN DO:
        FIND FIRST conta NO-LOCK
            WHERE conta.ds-conta = ls-conta.
        FOR EACH tt-mov-conta:
            IF tt-mov-conta.cd-conta <> conta.cd-conta THEN
                DELETE tt-mov-conta.
        END.
    END.

    IF ls-resp <> "Todos" THEN DO:
        FOR EACH tt-mov-conta:
            IF tt-mov-conta.usuar-resp <> ls-resp THEN
                DELETE tt-mov-conta.
        END.
    END.

    {&OPEN-QUERY-brProx}
    IF CAN-FIND(FIRST tt-mov-conta) THEN
        brProx:SELECT-ROW(1).
    APPLY "VALUE-CHANGED" TO brProx.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY deTot data-ini data-end ls-tipo ls-conta l-simula ls-resp 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE brProx btFav data-ini data-end btValor ls-tipo btAgenda ls-conta 
         l-simula btSaltar btPagar btExit ls-resp IMAGE-1 IMAGE-2 RECT-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initialize C-Win 
PROCEDURE initialize :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ASSIGN data-ini = DATE(12,31,9999)
         data-end = TODAY + 30.

  FOR EACH agenda NO-LOCK
      WHERE agenda.prox-data-pag < agenda.dt-fim
      AND   agenda.dt-fim >= TODAY
      AND NOT agenda.simulado:
      IF CAN-FIND(FIRST agenda-valor
                  WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                  AND   agenda-valor.dt-ini <= agenda.prox-data-pag
                  AND   agenda-valor.dt-end >= agenda.prox-data-pag) THEN DO:
          IF agenda.prox-data-pag < data-ini THEN DO:
              ASSIGN data-ini = agenda.prox-data-pag.
          END.
      END.
  END.

  IF param-mn.perfil = 2 /* Empresarial */ THEN DO:
      FOR EACH parc-nota-fiscal NO-LOCK
          WHERE parc-nota-fiscal.situacao = 1 /* Pendente */:
          IF parc-nota-fiscal.dt-pagto-parc < data-ini THEN
              ASSIGN data-ini = parc-nota-fiscal.dt-parcela.
      END.
  END.

  ASSIGN data-ini = data-ini - 7.

  IF data-ini > TODAY THEN
      ASSIGN data-ini = TODAY.

  IF WEEKDAY(data-ini) = 2 THEN
      ASSIGN data-ini = data-ini - 2.
  REPEAT:
      IF CAN-FIND(FIRST feriado WHERE feriado.dt-feriado = (data-ini - 1)) THEN DO:
          ASSIGN data-ini = data-ini - 1.
      END.
      ELSE DO:
          IF WEEKDAY(data-ini) = 2 THEN
              ASSIGN data-ini = data-ini - 2.
          LEAVE.
      END.
  END.

  RUN displayFields.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnCatSub C-Win 
FUNCTION fnCatSub RETURNS CHARACTER
  ( iCat AS INT, iSub AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST categoria NO-LOCK
        WHERE categoria.cod-categoria = iCat NO-ERROR.
    IF NOT AVAIL categoria THEN
        RETURN "".   /* Function return value. */

    IF iSub = 0 THEN
        RETURN categoria.ds-categoria.
    ELSE DO:
        FIND FIRST sub-cat OF categoria NO-LOCK
            WHERE sub-cat.cd-sub = iSub NO-ERROR.
        IF AVAIL sub-cat THEN
            RETURN sub-cat.ds-sub.
        ELSE
            RETURN "Sub-categoria n∆o existente!".
    END.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnConta C-Win 
FUNCTION fnConta RETURNS CHARACTER
  ( iCod AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST conta WHERE cd-conta = iCod NO-LOCK NO-ERROR.
    IF AVAIL conta THEN
        RETURN conta.ds-conta.
    ELSE
        RETURN "".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnCriaMov C-Win 
FUNCTION fnCriaMov RETURNS CHARACTER
  ( iAgend AS INT, dtTemp AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iContDia AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dtContAux AS DATE       NO-UNDO.
    DEFINE BUFFER bfAgend FOR agenda.

    FIND FIRST bfAgend NO-LOCK
        WHERE bfAgend.cd-agenda = iAgend NO-ERROR.
    IF NOT AVAIL bfAgend THEN RETURN "NOK".

    IF NOT l-simula THEN DO:
        IF bfAgend.simulado THEN RETURN "NOK".
    END.

    IF bfAgend.dt-ultimo-pag >= bfAgend.dt-fim THEN RETURN "OK".
    IF dtTemp <= bfAgend.dt-ultimo-pag THEN RETURN "OK".
    IF dtTemp >= bfAgend.dt-fim THEN RETURN "OK".

    FIND FIRST agenda-valor NO-LOCK
        WHERE agenda-valor.cd-agenda = bfAgend.cd-agenda
        AND   agenda-valor.dt-ini <= dtTemp
        AND   agenda-valor.dt-end >= dtTemp NO-ERROR.
    IF NOT AVAIL agenda-valor THEN RETURN "NOK".

    CREATE tt-mov-conta.
    ASSIGN tt-mov-conta.cd-conta      = bfAgend.cd-conta
           tt-mov-conta.cd-favorecido = bfAgend.cd-favorecido
           tt-mov-conta.cod-categoria = bfAgend.cod-categoria
           tt-mov-conta.cd-sub        = bfAgend.cd-sub
           tt-mov-conta.conta-transf  = bfAgend.conta-transf
           tt-mov-conta.id-tipo       = bfAgend.id-tipo
           tt-mov-conta.de-valor      = agenda-valor.valor
           tt-mov-conta.cd-sequencia  = iSeq
           tt-mov-conta.dt-mov        = dtTemp
           tt-mov-conta.id-situacao   = 1
           tt-mov-conta.cd-agenda     = bfAgend.cd-agenda
           tt-mov-conta.usuar-resp    = (IF bfAgend.usuar-resp <> "" THEN bfAgend.usuar-resp ELSE "Todos")
           iSeq = iSeq + 1.

    IF param-mn.perfil = 2 /* Empresarial */ THEN DO:
        IF tt-mov-conta.dt-mov = fnProxDataPag(ROWID(bfAgend)) THEN DO:
            IF CAN-FIND(FIRST imposto OF bfAgend) THEN DO:
                ASSIGN tt-mov-conta.de-valor = 0.
                FOR EACH imposto OF bfAgend NO-LOCK:
                    FOR EACH nota-fiscal-imp OF imposto NO-LOCK
                        WHERE nota-fiscal-imp.situacao = 1 /* Pendente */:
                        FIND FIRST nota-fiscal OF nota-fiscal-imp NO-LOCK NO-ERROR.
                        IF nota-fiscal.dt-emissao < DATE(MONTH(tt-mov-conta.dt-mov), 1, YEAR(tt-mov-conta.dt-mov)) THEN DO:
                            ASSIGN tt-mov-conta.de-valor = tt-mov-conta.de-valor - nota-fiscal-imp.val-imposto.
                        END.
                    END.
                END.
            END.
        END.
    END.

    /* Verifica se foi atualizado */
    IF bfAgend.vl-atual <> 0 THEN DO:
        IF tt-mov-conta.dt-mov = bfAgend.prox-data-pag THEN DO:
            ASSIGN tt-mov-conta.de-valor = bfAgend.vl-atual.
        END.
    END.

    /* Verifica se j† n∆o foi pago */
    IF tt-mov-conta.dt-mov < bfAgend.prox-data-pag THEN
        DELETE tt-mov-conta.

    RETURN "OK".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnFavor C-Win 
FUNCTION fnFavor RETURNS CHARACTER
  ( iCod AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST favorecido WHERE cd-favorecido = iCod NO-LOCK NO-ERROR.
    IF AVAIL favorecido THEN
        RETURN favorecido.ds-favorecido.
    ELSE
        RETURN "".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnStatus C-Win 
FUNCTION fnStatus RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO INITIAL "".

    FIND FIRST agenda NO-LOCK
        WHERE agenda.cd-agenda = tt-mov-conta.cd-agenda no-error.

    IF tt-mov-conta.dt-mov = fnProxDataPag(ROWID(agenda)) THEN DO:
        IF agenda.vl-atual <> 0 THEN DO:
            ASSIGN cReturn = "Atualizado".
        END.
    END.

    IF tt-mov-conta.dt-mov < TODAY THEN
        ASSIGN cReturn = "Vencido".

    RETURN cReturn.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

