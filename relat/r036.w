&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
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
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  data-ini data-fim moeda iConta iPoup vl-conta vl-quebra

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta.

DEFINE BUFFER bfConta FOR conta.

DEFINE VARIABLE lPrimeiro AS LOGICAL    NO-UNDO.

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
data-fim iConta iPoup moeda vl-conta vl-quebra btOK 
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim iConta des-conta iPoup ~
des-poup moeda vl-conta vl-quebra 

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
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 40.29 BY 1 NO-UNDO.

DEFINE VARIABLE data-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE des-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .79 NO-UNDO.

DEFINE VARIABLE des-poup AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .79 NO-UNDO.

DEFINE VARIABLE iConta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE iPoup AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Poupanáa" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE vl-conta AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 500 
     LABEL "Valor M°nimo" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE VARIABLE vl-quebra AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 25 
     LABEL "Quebra" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 5.25 COL 73
     data-ini AT ROW 2 COL 22 COLON-ALIGNED
     data-fim AT ROW 2 COL 40 COLON-ALIGNED NO-LABEL
     iConta AT ROW 3 COL 22 COLON-ALIGNED
     des-conta AT ROW 3 COL 26.29 COLON-ALIGNED NO-LABEL
     iPoup AT ROW 4 COL 22 COLON-ALIGNED
     des-poup AT ROW 4 COL 26.29 COLON-ALIGNED NO-LABEL
     moeda AT ROW 5 COL 22 COLON-ALIGNED
     vl-conta AT ROW 6 COL 22 COLON-ALIGNED
     vl-quebra AT ROW 6 COL 48.29 COLON-ALIGNED
     btOK AT ROW 3.5 COL 73
     IMAGE-5 AT ROW 1.5 COL 33
     IMAGE-6 AT ROW 1.5 COL 37.43
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.25
         FONT 7.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Template Padr∆o de Relat¢rio"
         HEIGHT             = 7.25
         WIDTH              = 80
         MAX-HEIGHT         = 9.79
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 9.79
         VIRTUAL-WIDTH      = 80
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
/* SETTINGS FOR FILL-IN des-poup IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

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
       ROW             = 7.5
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(vl-quebra:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Relat¢rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Relat¢rio */
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
    {func\relat\bt_executar.i}
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


&Scoped-define SELF-NAME iPoup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON ENTRY OF iPoup IN FRAME DEFAULT-FRAME /* Poupanáa */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON LEAVE OF iPoup IN FRAME DEFAULT-FRAME /* Poupanáa */
DO:
    {func\leave.i &Tabela="poupanca"
                  &Campo="cd-poupanca"
                  &CampoTela="iPoup"
                  &CampoProc = "ds-poupanca"
                  &Tela="des-poup"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON MOUSE-SELECT-DBLCLICK OF iPoup IN FRAME DEFAULT-FRAME /* Poupanáa */
OR F5 OF iPoup DO:
    {func\zoom.i &Tabela="poupanca"
                 &Campo1="cd-poupanca"
                 &Tela1="iPoup"
                 &Campo2="ds-poupanca"
                 &Tela2="des-poup"}
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


&Scoped-define SELF-NAME vl-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-conta C-Win
ON ENTRY OF vl-conta IN FRAME DEFAULT-FRAME /* Valor M°nimo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-conta C-Win
ON LEAVE OF vl-conta IN FRAME DEFAULT-FRAME /* Valor M°nimo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vl-quebra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-quebra C-Win
ON ENTRY OF vl-quebra IN FRAME DEFAULT-FRAME /* Quebra */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-quebra C-Win
ON LEAVE OF vl-quebra IN FRAME DEFAULT-FRAME /* Quebra */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\relat\main_block.i}

{ttmovto.i data-ini data-fim YES}

{campos\cd-moeda.i}                

{func\calendar.i data-ini}
{func\calendar.i data-fim}

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
  {version.i r036}
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

OCXFile = SEARCH( "r036.wrx":U ).
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
ELSE MESSAGE "r036.wrx":U SKIP(1)
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
APPLY "LEAVE" TO iPoup IN FRAME {&FRAME-NAME}.

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
  DISPLAY data-ini data-fim iConta des-conta iPoup des-poup moeda vl-conta 
          vl-quebra 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 data-ini data-fim iConta iPoup moeda 
         vl-conta vl-quebra btOK 
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

/* Definiá∆o das vari†veis */
{func\relat\var.i}

DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
DEFINE VARIABLE Soma AS DECIMAL    NO-UNDO.

FOR EACH tt-mov-conta:
    DELETE tt-mov-conta.
END.

ASSIGN lPrimeiro = YES.

DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE cMes AS CHARACTER FORMAT "X(20)" NO-UNDO.
DEFINE VARIABLE vl-min AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-poup AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-sim AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-prev AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-extra AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-sobra AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-dif AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deDep AS DECIMAL    NO-UNDO EXTENT 2000.
DEFINE VARIABLE vl-ini AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-dep AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-tot AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-jur AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deAux AS DECIMAL    NO-UNDO.
DEFINE VARIABLE l-entra AS LOGICAL    NO-UNDO.
DEFINE VARIABLE iMes-aux AS INTEGER    NO-UNDO.
DEFINE VARIABLE iAno-aux AS INTEGER    NO-UNDO.
DEFINE VARIABLE dtCont AS DATE       NO-UNDO.
DEFINE VARIABLE deVl AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deSaldoProx AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-min-prox AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-prev-prox AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-extra-prox AS DECIMAL    NO-UNDO.
DEFINE VARIABLE vl-sobra-prox AS DECIMAL    NO-UNDO.
DEFINE VARIABLE dtAux-prox AS DATE       NO-UNDO.
DEFINE VARIABLE iDia AS INTEGER     NO-UNDO.
DEFINE VARIABLE dtAux AS DATE       NO-UNDO.

/* Output padr∆o */
{func\relat\ini.i 1}

/* L¢gica do relat¢rio */
IF data-ini < TODAY THEN
    ASSIGN data-ini = TODAY.

FIND FIRST conta NO-LOCK
    WHERE conta.cd-conta = iConta NO-ERROR.

FIND FIRST poupanca NO-LOCK
    WHERE poupanca.cd-poupanca = iPoup NO-ERROR.

FIND LAST agenda NO-LOCK
    WHERE (agenda.cd-conta = iConta OR agenda.conta-transf = iConta)
    AND   agenda.cd-favorecido = poupanca.cd-fav-padrao NO-ERROR.
IF AVAIL agenda THEN DO:
    FIND FIRST prog-agenda OF agenda
        WHERE prog-agenda.id-tipo = 2 NO-ERROR.
    IF AVAIL prog-agenda THEN DO:
        ASSIGN iDia = prog-agenda.valor.
    END.
    ELSE
        ASSIGN iDia = 1.
END.
ELSE
    ASSIGN iDia = 1.

ASSIGN chProgressBar:VALUE = 0.

ASSIGN cTemp = "Per°odo:  " + STRING(data-ini,"99/99/9999") + " AtÇ: " + STRING(data-fim,"99/99/9999") + "<br>" +
               "Conta:    " + STRING(iConta,"999") + " - " + conta.ds-conta + "<br>" +
               "Poupanáa: " + STRING(iPoup,"999") + " - " + poupanca.ds-poupanca.
{func\relat\capitulo.i cTemp 800}
{func\relat\end-capitulo.i}

ASSIGN dtAux-prox = data-fim
       dtAux = data-ini
       data-fim = fnUltimoDia(MONTH(fnUltimoDia(MONTH(data-fim),YEAR(data-fim)) + 1),YEAR(fnUltimoDia(MONTH(data-fim),YEAR(data-fim)) + 1))
       data-ini = data-ini - 30.

RUN criaTT.
ASSIGN iContReg = chProgressBar:VALUE
       iTotReg  = chProgressBar:MAX
       data-fim = dtAux-prox
       data-ini = dtAux.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini
    AND   mov-conta.dt-mov <= data-fim
    AND   mov-conta.agrupado = 0
    USE-INDEX data:

     CREATE tt-mov-conta.
     BUFFER-COPY mov-conta TO tt-mov-conta.

END.

ASSIGN deSaldo = conta.vl-saldo-ini.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.agrupado = 0
    AND   mov-conta.dt-mov < data-ini
    USE-INDEX data:

    ASSIGN deSaldo = deSaldo + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).

END.

IF data-ini > TODAY THEN DO:

    FOR EACH tt-mov-conta OF conta NO-LOCK
        WHERE tt-mov-conta.agrupado = 0
        AND   tt-mov-conta.dt-mov < data-ini
        USE-INDEX data:

        ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,0,tt-mov-conta.dt-mov).

    END.

    FOR EACH tt-mov-conta NO-LOCK
        WHERE tt-mov-conta.conta-transf = conta.cd-conta
        AND   tt-mov-conta.agrupado = 0
        AND   tt-mov-conta.dt-mov < data-ini
        USE-INDEX data:

        ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,0,tt-mov-conta.dt-mov).

    END.

END.

/* Calcula o Saldo atÇ a pr¢xima data agendada de transferància */
IF DATE(MONTH(data-ini), iDia, YEAR(data-ini)) > data-ini THEN DO:
    FOR EACH tt-mov-conta OF conta NO-LOCK
        WHERE tt-mov-conta.agrupado = 0
        AND   tt-mov-conta.dt-mov >= data-ini
        AND   tt-mov-conta.dt-mov < DATE(MONTH(data-ini), iDia, YEAR(data-ini))
        USE-INDEX data:

        ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,0,tt-mov-conta.dt-mov).

    END.
END.

{func\relat\capitulo.i '"Movimentaá∆o da Conta"' 800}
{func\relat\titulo.i &Coluna1='"Màs"'
                     &Tamanho1=200
                     &Coluna2='"Vl Base"'
                     &Tamanho2=100
                     &Coluna3='"Vl Simulado"'
                     &Tamanho3=100
                     &Coluna4='"Poupanáa"'
                     &Tamanho4=100
                     &Coluna5='"Vl Previsto"'
                     &Tamanho5=100
                     &Coluna6='"Poup. Extra"'
                     &Tamanho6=100
                     &Coluna7='"Sobra"'
                     &Tamanho7=100}
                     
ASSIGN iCont = 1.

REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):
    REPEAT iMes = (IF iAno = YEAR(data-ini) THEN MONTH(data-ini) ELSE 1) TO (IF iAno = YEAR(data-fim) THEN MONTH(data-fim) ELSE 12):

        ASSIGN cMes =  fnMes(iMes) + "/" + STRING(iAno,"9999")
               vl-min = /*deSaldo*/ 9999999
               vl-poup = 0
               vl-sim = 0
               dtAux = (fnUltimoDia(iMes, iAno) + 1).

        /* Calcula o menor saldo no màs */
        FOR EACH tt-mov-conta
            /*WHERE MONTH(tt-mov-conta.dt-mov) = iMes
            AND   YEAR(tt-mov-conta.dt-mov) = iAno*/
            WHERE tt-mov-conta.dt-mov >= DATE(iMes, iDia, iAno)
            AND   tt-mov-conta.dt-mov < DATE(MONTH(dtAux), iDia, YEAR(dtAux))
            BREAK BY tt-mov-conta.dt-mov:

            IF tt-mov-conta.id-tipo <> 3 THEN
                ASSIGN deSaldo = deSaldo + tt-mov-conta.de-valor.
            ELSE DO:
                FIND FIRST conta NO-LOCK
                    WHERE conta.cd-conta = iConta NO-ERROR.
                IF tt-mov-conta.cd-moeda <> conta.cd-moeda THEN
                    ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,conta.cd-moeda,tt-mov-conta.dt-mov).
                ELSE
                    ASSIGN deSaldo = deSaldo + tt-mov-conta.de-valor.
            END.

            IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
                IF deSaldo < vl-min THEN
                    ASSIGN vl-min = deSaldo.
            END.

        END.

        /* Calcula o menor saldo no pr¢ximo màs */
        ASSIGN deSaldoProx = deSaldo
               vl-min-prox = /*deSaldo*/ 9999999
               dtAux = (fnUltimoDia(MONTH(fnUltimoDia(iMes,iAno) + 1), YEAR(fnUltimoDia(iMes,iAno) + 1)) + 1).
        FOR EACH tt-mov-conta
            /*WHERE MONTH(tt-mov-conta.dt-mov) = MONTH(fnUltimoDia(iMes,iAno) + 1)
            AND   YEAR(tt-mov-conta.dt-mov) = YEAR(fnUltimoDia(iMes,iAno) + 1)*/
            WHERE tt-mov-conta.dt-mov >= DATE(MONTH(fnUltimoDia(iMes,iAno) + 1), iDia, YEAR(fnUltimoDia(iMes,iAno) + 1))
            AND   tt-mov-conta.dt-mov < DATE(MONTH(dtAux), iDia, YEAR(dtAux))
            BREAK BY tt-mov-conta.dt-mov:

            IF tt-mov-conta.id-tipo <> 3 THEN
                ASSIGN deSaldoProx = deSaldoProx + tt-mov-conta.de-valor.
            ELSE DO:
                FIND FIRST conta NO-LOCK
                    WHERE conta.cd-conta = iConta NO-ERROR.
                IF tt-mov-conta.cd-moeda <> conta.cd-moeda THEN
                    ASSIGN deSaldoProx = deSaldoProx + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,conta.cd-moeda,tt-mov-conta.dt-mov).
                ELSE
                    ASSIGN deSaldoProx = deSaldoProx + tt-mov-conta.de-valor.
            END.

            IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
                IF deSaldoProx < vl-min-prox THEN
                    ASSIGN vl-min-prox = deSaldoProx.
            END.

        END.

        /* Calcula valor simulado */
        FOR EACH tt-mov-conta
            WHERE MONTH(tt-mov-conta.dt-mov) = iMes
            AND   YEAR(tt-mov-conta.dt-mov) = iAno
            BREAK BY tt-mov-conta.dt-mov:

            FIND FIRST agenda OF tt-mov-conta NO-LOCK NO-ERROR.
            IF AVAIL agenda THEN DO:
                IF NOT agenda.simulado THEN NEXT.
            END.
            ELSE DO:
                NEXT.
            END.
            
            ASSIGN vl-sim = vl-sim + fnCotacao(tt-mov-conta.de-valor,tt-mov-conta.cd-moeda,moeda,tt-mov-conta.dt-mov).

        END.

        /* Calcula o valor em poupanáa */
        FOR EACH tt-mov-conta
            WHERE MONTH(tt-mov-conta.dt-mov) = iMes
            AND   YEAR(tt-mov-conta.dt-mov) = iAno
            AND   tt-mov-conta.id-tipo = 3:

            IF CAN-FIND(FIRST poup-conta
                        WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca
                        AND   poup-conta.cd-conta = tt-mov-conta.conta-transf
                        OR    poup-conta.cd-conta = tt-mov-conta.cd-conta) THEN DO:
                ASSIGN vl-poup = vl-poup + (tt-mov-conta.de-valor * (-1)).
            END.

        END.

        /* Controle de moeda */
        FIND FIRST conta NO-LOCK
            WHERE conta.cd-conta = iConta NO-ERROR.
        IF moeda <> conta.cd-moeda THEN DO:
            ASSIGN vl-min = fnCotacao(vl-min,conta.cd-moeda,moeda,fnUltimoDia(iMes,iAno))
                   vl-sim = fnCotacao(vl-sim,conta.cd-moeda,moeda,fnUltimoDia(iMes,iAno))
                   vl-poup = fnCotacao(vl-poup,conta.cd-moeda,moeda,fnUltimoDia(iMes,iAno)).
        END.

        /* Calcula o valor previsto */
        ASSIGN vl-prev = vl-min + /*vl-sim +*/ vl-dif.

        /* Calcula poupanáa extra */
        ASSIGN vl-extra = (INT(ENTRY(1,STRING((IF (vl-prev > vl-conta) THEN (vl-prev - vl-conta) ELSE 0) / vl-quebra))) * vl-quebra).

        /* Calcula sobra e difererenáa */
        ASSIGN vl-sobra = vl-prev - vl-extra
               vl-dif = vl-sobra - vl-min.

        IF vl-sobra < vl-conta
        AND vl-extra > vl-quebra THEN
            ASSIGN vl-sobra = vl-sobra + vl-quebra
                   vl-extra = vl-extra - vl-quebra.

        /* Calcula o valor previsto no pr¢pximo màs */
        ASSIGN vl-prev-prox = vl-min-prox + /*vl-sim +*/ vl-dif.

        /* Calcula poupanáa extra no pr¢ximo màs */
        ASSIGN vl-extra-prox = (INT(ENTRY(1,STRING((IF (vl-prev-prox > vl-conta) THEN (vl-prev-prox - vl-conta) ELSE 0) / vl-quebra))) * vl-quebra).

        /* Calcula sobra no pr¢ximo màs */
        ASSIGN vl-sobra-prox = vl-prev-prox - vl-extra-prox.

        IF vl-sobra-prox < vl-conta
        AND vl-extra-prox > vl-quebra THEN
            ASSIGN vl-sobra-prox = vl-sobra-prox + vl-quebra
                   vl-extra-prox = vl-extra-prox - vl-quebra.

        /* Se no pr¢ximo màs ficar abaixo do valor da conta */
        IF vl-sobra-prox < vl-conta THEN DO:

            /* Reduz a poupanáa extra */
            ASSIGN vl-extra = vl-extra - (INT(ENTRY(1,STRING((vl-conta - vl-sobra-prox) / vl-quebra))) * vl-quebra)
                   vl-sobra-prox = vl-sobra-prox + (INT(ENTRY(1,STRING((vl-conta - vl-sobra-prox) / vl-quebra))) * vl-quebra).

            IF vl-sobra-prox < vl-conta
            AND vl-extra > vl-quebra THEN
                ASSIGN vl-extra = vl-extra - vl-quebra
                       vl-sobra-prox = vl-sobra-prox + vl-quebra.

            IF vl-extra < 0 THEN
                ASSIGN vl-extra = 0.

            /* Calcula nova sobra e difererenáa */
            ASSIGN vl-sobra = vl-prev - vl-extra
                   vl-dif = vl-sobra - vl-min.

            IF vl-sobra < vl-conta
            AND vl-extra > vl-quebra THEN
                ASSIGN vl-sobra = vl-sobra + vl-quebra
                       vl-extra = vl-extra - vl-quebra.
        END.

        ASSIGN deDep[iCont] = vl-poup + vl-extra
               iCont = iCont + 1.

        {func\relat\linha.i &Coluna1=cMes
                            &Align1="left"
                            &Coluna2=vl-min
                            &Align2="right"
                            &Coluna3=vl-sim
                            &Align3="right"
                            &Coluna4=vl-poup
                            &Align4="right"
                            &Coluna5=vl-prev
                            &Align5="right"
                            &Coluna6=vl-extra
                            &Align6="right"
                            &Coluna7=vl-sobra
                            &Align7="right"}

    END.
END.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i '"Projeá∆o em Poupanáa"' 600}
{func\relat\titulo.i &Coluna1='"Màs"'
                     &Tamanho1=200
                     &Coluna2='"Vl Inicial"'
                     &Tamanho2=100
                     &Coluna3='"Vl Dep¢sito"'
                     &Tamanho3=100
                     &Coluna4='"Total"'
                     &Tamanho4=100
                     &Coluna5='"Juros"'
                     &Tamanho5=100}

FOR EACH poup-conta NO-LOCK
    WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca:

    FIND FIRST conta WHERE conta.cd-conta = poup-conta.cd-conta NO-LOCK.

    ASSIGN vl-ini = conta.vl-saldo-ini
           iCont = 1.

    FOR EACH mov-conta OF conta NO-LOCK
        WHERE mov-conta.agrupado = 0
        AND   mov-conta.dt-mov < fnUltimoDia(MONTH(data-ini),YEAR(data-ini))
        USE-INDEX data:

        ASSIGN vl-ini = vl-ini + mov-conta.de-valor.

    END.

    IF conta.cd-moeda <> 0 THEN
        ASSIGN vl-ini = fnCotacao(vl-ini,conta.cd-moeda,0,fnUltimoDia(MONTH(data-ini),YEAR(data-ini))).

    ASSIGN deAux = deAux + vl-ini.

END.

ASSIGN vl-ini = deAux.


/* Controle de moeda */
IF moeda <> 0 THEN DO:
    ASSIGN vl-ini = fnCotacao(vl-ini,0,moeda,fnUltimoDia(iMes,iAno)).
END.

FOR EACH tt-mov-conta:
    DELETE tt-mov-conta.
END.
FOR EACH poup-conta
    WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca NO-LOCK:

    FIND FIRST conta OF poup-conta NO-LOCK NO-ERROR.
    ASSIGN iConta = conta.cd-conta.
    RUN criaTT.

END.

REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):

    FIND FIRST item-poupanca OF poupanca
        WHERE item-poupanca.ano = iAno.

    REPEAT iMes = (IF iAno = YEAR(data-ini) THEN MONTH(data-ini) ELSE 1) TO (IF iAno = YEAR(data-fim) THEN MONTH(data-fim) ELSE 12):

        ASSIGN cMes =  fnMes(iMes) + "/" + STRING(iAno,"9999")
               vl-dep = deDep[iCont]
               iCont = iCont + 1
               dtAux = (fnUltimoDia(iMes, iAno) + 1).

        IF iAno = YEAR(data-ini)
        AND iMes = MONTH(data-ini)
        AND iDia <= DAY(data-ini) THEN
            ASSIGN vl-dep = 0.

        /* Calcula os agendamentos para a poupanáa no per°odo */
        FOR EACH tt-mov-conta NO-LOCK
            /*WHERE tt-mov-conta.dt-mov >= DATE(iMes,1,iAno)
            AND   tt-mov-conta.dt-mov <= fnUltimoDia(iMes,iAno)*/
            WHERE tt-mov-conta.dt-mov >= DATE(iMes, iDia, iAno)
            AND   tt-mov-conta.dt-mov < DATE(MONTH(dtAux), iDia, YEAR(dtAux))
            AND   tt-mov-conta.id-tipo <> 3:

            ASSIGN vl-dep = vl-dep + tt-mov-conta.de-valor.

        END.

        ASSIGN vl-tot = vl-ini + vl-dep
               vl-jur = ((vl-ini * item-poupanca.pc-juros) / 100).

        IF iMes = MONTH(TODAY)
        AND iAno = YEAR(TODAY) THEN DO:
            ASSIGN vl-jur = vl-jur * ((DAY(fnUltimoDia(iMes,iAno)) - DAY(TODAY)) / DAY(fnUltimoDia(iMes,iAno))).
        END.

        {func\relat\linha.i &Coluna1=cMes
                            &Align1="left"
                            &Coluna2=vl-ini
                            &Align2="right"
                            &Coluna3=vl-dep
                            &Align3="right"
                            &Coluna4=vl-tot
                            &Align4="right"
                            &Coluna5=vl-jur
                            &Align5="right"}
                            
        ASSIGN vl-ini = vl-tot + vl-jur.

    END.
END.

ASSIGN data-fim = fnUltimoDia(IF MONTH(data-fim) <> 12 THEN (MONTH(data-fim) + 1) ELSE 1, IF MONTH(data-fim) <> 12 THEN YEAR(data-fim) ELSE (YEAR(data-fim) + 1))
       cMes =  fnMes(MONTH(data-fim)) + "/" + STRING(YEAR(data-fim),"9999").
{func\relat\total.i &Coluna1=cMes
                    &Align1="left"
                    &Coluna2=vl-ini
                    &Align2="right"}

{func\relat\end-capitulo.i}

/* Fecha Output padr∆o */
{func\relat\end.i}

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
FIND LAST item-poupanca NO-LOCK
    WHERE item-poupanca.ano = YEAR(TODAY) NO-ERROR.
IF AVAIL item-poupanca THEN DO:
    ASSIGN iPoup = item-poupanca.cd-poupanca.
END.

ASSIGN data-ini = TODAY
       data-fim = DATE(12,31,YEAR(TODAY)).

{func\relat\initialize.i}

{func\cursor.i iConta}
{func\cursor.i iPoup}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sem-dia C-Win 
PROCEDURE sem-dia :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iMes AS INTEGER    NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER iAno AS INTEGER    NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER deVl AS DECIMAL    NO-UNDO.

DEFINE VARIABLE dtCont AS DATE       NO-UNDO.

REPEAT dtCont = DATE(iMes,1,iAno) TO fnUltimoDia(iMes,iAno):
    IF CAN-FIND(FIRST prog-agenda OF agenda
                WHERE prog-agenda.id-tipo = 4
                AND   prog-agenda.todos) THEN DO:
        IF agenda.vl-atual <> 0
        AND DATE(iMes,prog-agenda.valor,iAno) = fnProxDataPag(ROWID(agenda)) THEN DO:
            ASSIGN deVl = deVl + agenda.vl-atual.
        END.
        ELSE DO:
            FIND FIRST agenda-valor NO-LOCK
                WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                AND   agenda-valor.dt-ini <= dtCont
                AND   agenda-valor.dt-end >= dtCont NO-ERROR.
            IF AVAIL agenda-valor THEN
                ASSIGN deVl = deVl + agenda-valor.valor.
        END.
    END.
    ELSE DO:
        IF CAN-FIND(FIRST prog-agenda OF agenda
                    WHERE prog-agenda.id-tipo = 3
                    AND   (prog-agenda.todo
                    OR    prog-agenda.valor = fnSemana(dtCont)))
        AND CAN-FIND(FIRST prog-agenda OF agenda
                     WHERE prog-agenda.id-tipo = 4
                     AND   prog-agenda.valor = WEEKDAY(dtCont)) THEN DO:
            IF agenda.vl-atual <> 0
            AND DATE(iMes,prog-agenda.valor,iAno) = fnProxDataPag(ROWID(agenda)) THEN DO:
                ASSIGN deVl = deVl + agenda.vl-atual.
            END.
            ELSE DO:
                FIND FIRST agenda-valor NO-LOCK
                    WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                    AND   agenda-valor.dt-ini <= dtCont
                    AND   agenda-valor.dt-end >= dtCont NO-ERROR.
                IF AVAIL agenda-valor THEN
                    ASSIGN deVl = deVl + agenda-valor.valor.
            END.
        END.
        ELSE DO:
            IF fnSemana(dtCont) = fnSemana(fnUltimoDia(iMes,iAno))
            AND CAN-FIND(FIRST prog-agenda OF agenda
                         WHERE prog-agenda.id-tipo = 3
                         AND   prog-agenda.ultimo) THEN DO:
                IF agenda.vl-atual <> 0
                AND DATE(iMes,prog-agenda.valor,iAno) = fnProxDataPag(ROWID(agenda)) THEN DO:
                    ASSIGN deVl = deVl + agenda.vl-atual.
                END.
                ELSE DO:
                    FIND FIRST agenda-valor NO-LOCK
                        WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                        AND   agenda-valor.dt-ini <= dtCont
                        AND   agenda-valor.dt-end >= dtCont NO-ERROR.
                    IF AVAIL agenda-valor THEN
                        ASSIGN deVl = deVl + agenda-valor.valor.
                END.
            END.
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setaMax C-Win 
PROCEDURE setaMax :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER dtIni AS DATE       NO-UNDO.
    DEFINE INPUT  PARAMETER dtFim AS DATE       NO-UNDO.

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

    SELECT COUNT(*) INTO iCont FROM poup-conta WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca.

    ASSIGN chProgressBar:MAX = (((dtFim - dtIni) + 1) * (iCont + 1))
           lPrimeiro = NO.

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

