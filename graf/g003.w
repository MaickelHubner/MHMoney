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
/* Pr‚-processadores */

&GLOBAL-DEFINE FrameFields  data-ini data-fim moeda iConta tx-juros simula

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}
{func\tt_graf.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 IMAGE-6 RECT-10 data-ini ~
data-fim iConta tx-juros simula moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim iConta des-conta ~
tx-juros simula moeda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Executar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar".

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE data-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE des-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .79 NO-UNDO.

DEFINE VARIABLE iConta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE tx-juros AS DECIMAL FORMAT "->>>9.99":U INITIAL .65 
     LABEL "Taxa de Juros" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 5.25.

DEFINE VARIABLE simula AS LOGICAL INITIAL no 
     LABEL "Considera Simulados" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .83 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 4.5 COL 73
     data-ini AT ROW 1.92 COL 24 COLON-ALIGNED
     data-fim AT ROW 2 COL 42 COLON-ALIGNED NO-LABEL
     iConta AT ROW 3 COL 24 COLON-ALIGNED
     des-conta AT ROW 3 COL 28.29 COLON-ALIGNED NO-LABEL
     tx-juros AT ROW 4 COL 24 COLON-ALIGNED
     simula AT ROW 4 COL 36
     moeda AT ROW 5 COL 24 COLON-ALIGNED
     btOK AT ROW 2.75 COL 73
     IMAGE-5 AT ROW 1.5 COL 35
     IMAGE-6 AT ROW 1.5 COL 39.43
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 6.5
         FONT 7.


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
         TITLE              = "Gr fico"
         HEIGHT             = 6.5
         WIDTH              = 80
         MAX-HEIGHT         = 31
         MAX-WIDTH          = 182.86
         VIRTUAL-HEIGHT     = 31
         VIRTUAL-WIDTH      = 182.86
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
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN des-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 6.75
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(moeda:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Gr fico */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Gr fico */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    {func\relat\bt_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* Executar */
DO:
    {func\graf\bt_executar.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-fim C-Win
ON ENTRY OF data-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-fim C-Win
ON LEAVE OF data-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  
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
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iConta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON ENTRY OF iConta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON LEAVE OF iConta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela="iConta"
                  &CampoProc = "ds-conta"
                  &Tela="des-conta"}
                  
    IF AVAIL bfl-conta THEN DO:
        IF bfl-conta.id-tipo = 2 THEN
            ENABLE tx-juros WITH FRAME {&FRAME-NAME}.
        ELSE
            DISABLE tx-juros WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON MOUSE-SELECT-DBLCLICK OF iConta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF iConta DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="iConta"
                 &Campo2="ds-conta"
                 &Tela2="des-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON ENTRY OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON LEAVE OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tx-juros
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tx-juros C-Win
ON ENTRY OF tx-juros IN FRAME DEFAULT-FRAME /* Taxa de Juros */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tx-juros C-Win
ON LEAVE OF tx-juros IN FRAME DEFAULT-FRAME /* Taxa de Juros */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\graf\main_block.i}

{campos\cd-moeda.i}                

{func\calendar.i data-ini}
{func\calendar.i data-fim}

{ttmovto.i data-ini data-fim simula}

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
  {version.i g003}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlaExecucao C-Win 
PROCEDURE controlaExecucao :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER pMax AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER pAtual AS INTEGER     NO-UNDO.

    ASSIGN chProgressBar:MAX = pMax.

    ASSIGN chProgressBar:VALUE = pAtual.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load C-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "g003.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "g003.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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

{func\relat\display.i}

APPLY "LEAVE" TO iConta IN FRAME {&FRAME-NAME}.

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
  RUN control_load.
  DISPLAY data-ini data-fim iConta des-conta tx-juros simula moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 data-ini data-fim iConta tx-juros 
         simula moeda btOK 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE executaRelatorio C-Win 
PROCEDURE executaRelatorio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Defini‡Æo de vari veis */
{func\graf\var.i}

DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO.
DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO.
DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE iDia AS INTEGER    NO-UNDO.
DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.
DEFINE VARIABLE lFirst AS LOGICAL    NO-UNDO INITIAL YES.
DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
DEFINE VARIABLE iMesAux AS INTEGER    NO-UNDO.

FOR EACH tt-mov-conta:
    DELETE tt-mov-conta.
END.

/* Controle da ProgressBar */
{func\relat\ini-prg-bar.i 1}

/* L¢gica do relat¢rio */

ASSIGN tt-graf-par.dado-label        = "Data"
       tt-graf-par.valor-label[1]    = "Saldo"
       tt-graf-par.mostra-valores[1] = NO
       tt-graf-par.tipo              = 29
       iSeq = 1.

FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK.

ASSIGN deSaldo = conta.vl-saldo-ini
       iMesAux = MONTH(data-ini).

FOR EACH mov-conta OF conta
    WHERE /*mov-conta.id-situacao = 3
    AND*/   mov-conta.agrupado = 0
    AND  mov-conta.dt-mov <= data-ini
    USE-INDEX data NO-LOCK:

    ASSIGN deSaldo = deSaldo + mov-conta.de-valor.

END.

/*FOR EACH mov-conta OF conta
    WHERE mov-conta.dt-mov <= data-ini
    AND   mov-conta.id-situacao <> 3
    AND   mov-conta.agrupado = 0
    USE-INDEX data NO-LOCK:

    CREATE tt-mov-conta.
    BUFFER-COPY mov-conta TO tt-mov-conta.

END.*/

CREATE tt-graf.
ASSIGN tt-graf.seq = iSeq
       tt-graf.dado = STRING(data-ini,"99/99/9999")
       tt-graf.valor[1] = deSaldo
       iSeq = iSeq + 1.

RUN criaTT.
RUN prevFatPed.

FOR EACH mov-conta
    WHERE mov-conta.dt-mov > data-ini
    AND   mov-conta.dt-mov <= data-fim
    AND   mov-conta.cd-conta = iConta
    AND   mov-conta.agrupado = 0
    USE-INDEX data NO-LOCK:

     CREATE tt-mov-conta.
     BUFFER-COPY mov-conta TO tt-mov-conta.

END.

FOR EACH tt-mov-conta
    WHERE tt-mov-conta.dt-mov < data-ini
    USE-INDEX data:

    ASSIGN tt-mov-conta.dt-mov = data-ini.

END.

/*ASSIGN iAux = 0.
FOR EACH tt-mov-conta:
    ASSIGN iAux = iAux + 1.
END.
{func\relat\ini-prg-bar.i iAux}*/
ASSIGN dtTemp = data-ini.

FOR EACH tt-mov-conta
    USE-INDEX data
    BREAK BY tt-mov-conta.dt-mov:

    /*{func\relat\control.i}*/

    IF FIRST-OF(tt-mov-conta.dt-mov) THEN DO:
        /*IF lFirst THEN
            ASSIGN dtTemp = tt-mov-conta.dt-mov
                   lFirst = NO.*/
        IF tt-mov-conta.dt-mov <> dtTemp THEN DO:
            REPEAT iAno = YEAR(dtTemp) TO YEAR(tt-mov-conta.dt-mov):
                REPEAT iMes = IF iAno = year(dtTemp) THEN MONTH(dtTemp) ELSE 1 TO IF iAno = YEAR(tt-mov-conta.dt-mov) THEN MONTH(tt-mov-conta.dt-mov) ELSE 12:
                    REPEAT iDia = (IF (iMes = MONTH(dtTemp)) THEN (DAY(dtTemp) + 1) ELSE 1) TO (IF iMes = MONTH(tt-mov-conta.dt-mov) THEN (DAY(tt-mov-conta.dt-mov) - 1) ELSE DAY(fnUltimoDia(iMes,iAno))):

                        CREATE tt-graf.
                        ASSIGN tt-graf.seq = iSeq
                               tt-graf.dado = STRING(iDia,"99") + "/" + STRING(iMes,"99") + "/" + STRING(iAno,"9999")
                               tt-graf.valor[1] = deSaldo
                               iSeq = iSeq + 1.

                        FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK NO-ERROR.
                        IF conta.id-tipo = 2 THEN DO:
                            IF DATE(iMes,iDia,iAno) = fnUltimoDia(iMes,iAno) THEN DO:
                                ASSIGN tt-graf.valor[1] = tt-graf.valor[1] + fnJuros(tt-graf.valor[1],tx-juros)
                                       deSaldo = deSaldo + fnJuros(tt-graf.valor[1],tx-juros).
                            END.
                        END.

                    END.
                END.
            END.
            ASSIGN dtTemp = tt-mov-conta.dt-mov.
        END.
    END.

    IF MONTH(tt-mov-conta.dt-mov) <> iMesAux THEN DO:
        ASSIGN iMesAux = MONTH(tt-mov-conta.dt-mov).
    END.

    IF tt-mov-conta.cd-moeda = 0 THEN
        ASSIGN deSaldo = deSaldo + tt-mov-conta.de-valor.
    ELSE
        ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,0,tt-mov-conta.dt-mov).
    
    IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
        CREATE tt-graf.
        ASSIGN tt-graf.seq = iSeq
               tt-graf.dado = STRING(tt-mov-conta.dt-mov,"99/99/9999")
               tt-graf.valor[1] = deSaldo
               iSeq = iSeq + 1.
        FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK NO-ERROR.
        IF conta.id-tipo = 2 THEN DO:
            IF tt-mov-conta.dt-mov = fnUltimoDia(MONTH(tt-mov-conta.dt-mov),YEAR(tt-mov-conta.dt-mov)) THEN DO:
                ASSIGN tt-graf.valor[1] = tt-graf.valor[1] + fnJuros(tt-graf.valor[1],tx-juros)
                       deSaldo = deSaldo + fnJuros(tt-graf.valor[1],tx-juros).
            END.
        END.

    END.
END.

ASSIGN dtTemp = DATE(tt-graf.dado).

IF dtTemp <> data-fim THEN DO:
    REPEAT iAno = YEAR(dtTemp) TO YEAR(data-fim):
        REPEAT iMes = IF iAno = year(dtTemp) THEN MONTH(dtTemp) ELSE 1 TO IF iAno = YEAR(data-fim) THEN MONTH(data-fim) ELSE 12:
            REPEAT iDia = (IF (iMes = MONTH(dtTemp)) THEN (DAY(dtTemp) + 1) ELSE 1) TO (IF iMes = MONTH(data-fim) THEN DAY(data-fim) ELSE DAY(fnUltimoDia(iMes,iAno))):

                CREATE tt-graf.
                ASSIGN tt-graf.seq = iSeq
                       tt-graf.dado = STRING(iDia,"99") + "/" + STRING(iMes,"99") + "/" + STRING(iAno,"9999")
                       tt-graf.valor[1] = deSaldo
                       iSeq = iSeq + 1.

                FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK NO-ERROR.
                IF conta.id-tipo = 2 THEN DO:
                    IF DATE(iMes,iDia,iAno) = fnUltimoDia(iMes,iAno) THEN DO:
                        ASSIGN tt-graf.valor[1] = tt-graf.valor[1] + fnJuros(tt-graf.valor[1],tx-juros)
                               deSaldo = deSaldo + fnJuros(tt-graf.valor[1],tx-juros).
                    END.
                END.

            END.
        END.
    END.
END.

IF conta.cd-moeda <> moeda THEN DO:
    FOR EACH tt-graf:
        ASSIGN tt-graf.valor[1] = fnCotacao(tt-graf.valor[1],conta.cd-moeda,moeda,DATE(tt-graf.dado)).
    END.
END.

/* Exibe o Gr fico */
{func\graf\end.i}

RETURN "OK":U.

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
{func/cb-lista.i cd-moeda moeda}

FIND FIRST conta NO-LOCK
    WHERE conta.id-tipo = 1 NO-ERROR.
IF AVAIL conta THEN DO:
    ASSIGN iConta = conta.cd-conta.
END.

ASSIGN data-ini = TODAY
       data-fim = TODAY + 45.

{func\relat\initialize.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validateRecord C-Win 
PROCEDURE validateRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

