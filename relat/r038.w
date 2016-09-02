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

&GLOBAL-DEFINE FrameFields  data-ini data-fim moeda iConta iFavC iFavV

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta.

DEFINE TEMP-TABLE tt-acao-c NO-UNDO
    FIELD nome AS CHAR FORMAT "X(25)"
    FIELD data AS DATE FORMAT "99/99/9999"
    FIELD valor AS DEC
    FIELD quantidade AS INT
    FIELD taxa AS DEC
    INDEX idx AS PRIMARY UNIQUE data nome
    INDEX idx2 nome.

DEFINE TEMP-TABLE tt-custodia NO-UNDO
    FIELD nome AS CHAR FORMAT "X(25)"
    FIELD data AS DATE FORMAT "99/99/9999"
    FIELD valor AS DEC
    FIELD comp AS DEC
    INDEX idx AS PRIMARY UNIQUE data nome
    INDEX idx2 nome.

DEFINE TEMP-TABLE tt-lucro NO-UNDO
    FIELD nome AS CHAR FORMAT "X(25)"
    FIELD data AS DATE FORMAT "99/99/9999"
    FIELD deVlC AS DECIMAL
    FIELD deVlV AS DECIMAL
    FIELD deVlCt AS DECIMAL
    FIELD deVlL AS DECIMAL
    FIELD deVlPL AS DECIMAL
    FIELD deVlTx AS DECIMAL
    FIELD cMes AS CHAR FORMAT "X(15)"
    FIELD iMes AS INT
    INDEX idx AS PRIMARY UNIQUE data nome
    INDEX idx2 nome
    INDEX idx3 iMes.

DEFINE TEMP-TABLE tt-acao-v LIKE tt-acao-c.

DEFINE BUFFER bfConta FOR conta.
DEFINE BUFFER bfMov FOR mov-conta.
DEFINE BUFFER bfAcaoC FOR tt-acao-c.
DEFINE BUFFER bfAcaoV FOR tt-acao-v.

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
data-fim iConta iFavC iFavV moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim iConta des-conta iFavC ~
des-fav-c iFavV des-fav-v moeda 

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

DEFINE VARIABLE des-fav-c AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .79 NO-UNDO.

DEFINE VARIABLE des-fav-v AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .79 NO-UNDO.

DEFINE VARIABLE iConta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE iFavC AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Favorecido Compra" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE iFavV AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Favorecido Venda" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

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
     iFavC AT ROW 4 COL 22 COLON-ALIGNED
     des-fav-c AT ROW 4 COL 26.29 COLON-ALIGNED NO-LABEL
     iFavV AT ROW 5 COL 22 COLON-ALIGNED WIDGET-ID 4
     des-fav-v AT ROW 5 COL 26.29 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     moeda AT ROW 6 COL 22 COLON-ALIGNED
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
/* SETTINGS FOR FILL-IN des-fav-c IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN des-fav-v IN FRAME DEFAULT-FRAME
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
      CtrlFrame:MOVE-AFTER(moeda:HANDLE IN FRAME DEFAULT-FRAME).

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


&Scoped-define SELF-NAME iFavC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iFavC C-Win
ON ENTRY OF iFavC IN FRAME DEFAULT-FRAME /* Favorecido Compra */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iFavC C-Win
ON LEAVE OF iFavC IN FRAME DEFAULT-FRAME /* Favorecido Compra */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela="iFavC"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-fav-c"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iFavC C-Win
ON MOUSE-SELECT-DBLCLICK OF iFavC IN FRAME DEFAULT-FRAME /* Favorecido Compra */
OR F5 OF iFavC DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="iFavC"
                 &Campo2="ds-favorecido"
                 &Tela2="des-fav-c"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iFavV
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iFavV C-Win
ON ENTRY OF iFavV IN FRAME DEFAULT-FRAME /* Favorecido Venda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iFavV C-Win
ON LEAVE OF iFavV IN FRAME DEFAULT-FRAME /* Favorecido Venda */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela="iFavV"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-fav-v"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iFavV C-Win
ON MOUSE-SELECT-DBLCLICK OF iFavV IN FRAME DEFAULT-FRAME /* Favorecido Venda */
OR F5 OF iFavV DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="iFavV"
                 &Campo2="ds-favorecido"
                 &Tela2="des-fav-v"}
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
  {version.i r038}
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

OCXFile = SEARCH( "r038.wrx":U ).
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
ELSE MESSAGE "r038.wrx":U SKIP(1)
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
APPLY "LEAVE" TO iFavC IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO iFavV IN FRAME {&FRAME-NAME}.

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
  DISPLAY data-ini data-fim iConta des-conta iFavC des-fav-c iFavV des-fav-v 
          moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 data-ini data-fim iConta iFavC iFavV 
         moeda btOK 
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

DEFINE VARIABLE iMax AS INTEGER     NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER   NO-UNDO.
DEFINE VARIABLE deTot AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deTx AS DECIMAL     NO-UNDO.
DEFINE VARIABLE cAux AS CHARACTER FORMAT "X(15)"  NO-UNDO.
DEFINE VARIABLE deTotVlL AS DECIMAL     NO-UNDO.

SELECT COUNT(*) INTO iMax FROM mov-conta
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.dt-mov >= data-ini
    AND   mov-conta.dt-mov <= data-fim.

/* Output padr∆o */
{func\relat\ini.i iMax}

FIND FIRST conta NO-LOCK
    WHERE conta.cd-conta = iConta NO-ERROR.

ASSIGN cTemp = "Per°odo:  " + STRING(data-ini,"99/99/9999") + " AtÇ: " + STRING(data-fim,"99/99/9999") + "<br>" +
               "Conta:    " + STRING(iConta,"999") + " - " + conta.ds-conta.
{func\relat\capitulo.i cTemp 800}
{func\relat\end-capitulo.i}

/* L¢gica do Relat¢rio */

EMPTY TEMP-TABLE tt-acao-c.
EMPTY TEMP-TABLE tt-acao-v.
EMPTY TEMP-TABLE tt-custodia.
EMPTY TEMP-TABLE tt-lucro.

/*Compras*/ 
FOR EACH mov-conta OF conta
    WHERE mov-conta.dt-mov <= data-fim
    AND   mov-conta.cd-favorecido = iFavC:

    FIND FIRST bfConta NO-LOCK
        WHERE bfConta.cd-conta = mov-conta.conta-transf.

    FIND FIRST bfMov NO-LOCK
        WHERE bfMov.cd-conta = mov-conta.conta-transf
        AND   bfMov.cd-sequencia = mov-conta.seq-transf.

    FIND FIRST tt-acao-c
        WHERE tt-acao-c.nome = bfConta.ds-conta
        AND   tt-acao-c.data = mov-conta.dt-mov NO-ERROR.
    IF NOT AVAIL tt-acao-c THEN DO:
        CREATE tt-acao-c.
        ASSIGN tt-acao-c.nome = bfConta.ds-conta
               tt-acao-c.data = mov-conta.dt-mov.
    END.

    ASSIGN tt-acao-c.valor = tt-acao-c.valor - mov-conta.de-valor
           tt-acao-c.quantidade = tt-acao-c.quantidade + bfMov.de-valor.

END.

FOR EACH tt-acao-c
    BREAK BY tt-acao-c.data:

    IF FIRST-OF(tt-acao-c.data) THEN DO:
        ASSIGN deTot = 0.
    END.

    ASSIGN deTot = deTot + tt-acao-c.valor.

    IF LAST-OF(tt-acao-c.data) THEN DO:
        ASSIGN deTx = 0.
        FOR EACH mov-conta OF conta
            WHERE mov-conta.id-tipo <> 3
            AND   mov-conta.dt-mov = tt-acao-c.data
            AND   mov-conta.de-valor < 0:
            ASSIGN deTx = deTx + mov-conta.de-valor.
        END.
        FOR EACH bfAcaoC
            WHERE bfAcaoC.data = tt-acao-c.data:
            ASSIGN bfAcaoC.taxa = (deTx * (- bfAcaoC.valor / deTot)).
        END.
    END.

END.

/*Vendas*/ 
FOR EACH mov-conta OF conta
    WHERE mov-conta.dt-mov <= data-fim
    AND   mov-conta.cd-favorecido = iFavV:

    FIND FIRST bfConta NO-LOCK
        WHERE bfConta.cd-conta = mov-conta.conta-transf.

    FIND FIRST bfMov NO-LOCK
        WHERE bfMov.cd-conta = mov-conta.conta-transf
        AND   bfMov.cd-sequencia = mov-conta.seq-transf.

    FIND FIRST tt-acao-v
        WHERE tt-acao-v.nome = bfConta.ds-conta
        AND   tt-acao-v.data = mov-conta.dt-mov NO-ERROR.
    IF NOT AVAIL tt-acao-v THEN DO:
        CREATE tt-acao-v.
        ASSIGN tt-acao-v.nome = bfConta.ds-conta
               tt-acao-v.data = mov-conta.dt-mov.
    END.

    ASSIGN tt-acao-v.valor = tt-acao-v.valor + mov-conta.de-valor
           tt-acao-v.quantidade = tt-acao-v.quantidade - bfMov.de-valor.

END.

FOR EACH tt-acao-v
    BREAK BY tt-acao-v.data:

    IF FIRST-OF(tt-acao-v.data) THEN DO:
        ASSIGN deTot = 0.
    END.

    ASSIGN deTot = deTot + tt-acao-v.valor.

    IF LAST-OF(tt-acao-v.data) THEN DO:
        ASSIGN deTx = 0.
        FOR EACH mov-conta OF conta
            WHERE mov-conta.id-tipo <> 3
            AND   mov-conta.dt-mov = tt-acao-v.data
            AND   mov-conta.de-valor < 0:
            ASSIGN deTx = deTx - mov-conta.de-valor.
        END.
        FOR EACH bfAcaoV
            WHERE bfAcaoV.data = tt-acao-v.data:
            ASSIGN bfAcaoV.taxa = (deTx * (bfAcaoV.valor / deTot)).
        END.
    END.

END.

/*Cust¢dia*/
FOR EACH mov-conta OF conta
    WHERE mov-conta.de-valor < 0
    AND   mov-conta.id-tipo <> 3:

    IF CAN-FIND(FIRST tt-acao-c
                WHERE tt-acao-c.data = mov-conta.dt-mov) THEN NEXT.
    IF CAN-FIND(FIRST tt-acao-v
                WHERE tt-acao-v.data = mov-conta.dt-mov) THEN NEXT.

    ASSIGN deTot = 0.

    FOR EACH tt-acao-c
        WHERE tt-acao-c.data < mov-conta.dt-mov:

        IF NOT CAN-FIND(FIRST tt-acao-v
                        WHERE tt-acao-v.data < mov-conta.dt-mov
                        AND   tt-acao-v.nome = tt-acao-c.nome) THEN DO:

            FIND FIRST tt-custodia
                WHERE tt-custodia.nome = tt-acao-c.nome
                AND   tt-custodia.data = mov-conta.dt-mov NO-ERROR.
            IF NOT AVAIL tt-custodia THEN DO:
                CREATE tt-custodia.
                ASSIGN tt-custodia.nome = tt-acao-c.nome
                       tt-custodia.data = mov-conta.dt-mov
                       tt-custodia.comp = tt-acao-c.valor
                       deTot = deTot + tt-acao-c.valor.
            END.

        END.

    END.

    FOR EACH tt-custodia
        WHERE tt-custodia.data = mov-conta.dt-mov:
        ASSIGN tt-custodia.valor = (- mov-conta.de-valor * (tt-custodia.comp / deTot)).
    END.

END.

{func\relat\capitulo.i '"Compras"' 620}

{func\relat\titulo.i &Coluna1='"Aá∆o"'
                     &Tamanho1=200
                     &Coluna2='"Dt Compra"'
                     &Tamanho2=80
                     &Coluna3='"Quantidade"'
                     &Tamanho3=100
                     &Coluna4='"Vl Compra"'
                     &Tamanho4=120
                     &Coluna5='"Tx Compra"'
                     &Tamanho5=120}
                     
FOR EACH tt-acao-c
    WHERE tt-acao-c.data >= data-ini
    AND   tt-acao-c.data <= data-fim:
    {func\relat\linha.i &Coluna1=tt-acao-c.nome
                        &Align1="left"
                        &Coluna2=tt-acao-c.data
                        &Align2="left"
                        &Coluna3=tt-acao-c.quantidade
                        &Align3="right"
                        &Coluna4=tt-acao-c.valor
                        &Align4="right"
                        &Coluna5=tt-acao-c.taxa
                        &Align5="right"}
END.
                            
{func\relat\end-capitulo.i}

{func\relat\capitulo.i '"Vendas"' 620}

{func\relat\titulo.i &Coluna1='"Aá∆o"'
                     &Tamanho1=200
                     &Coluna2='"Dt Venda"'
                     &Tamanho2=80
                     &Coluna3='"Quantidade"'
                     &Tamanho3=100
                     &Coluna4='"Vl Venda"'
                     &Tamanho4=120
                     &Coluna5='"Tx Venda"'
                     &Tamanho5=120}
                     
FOR EACH tt-acao-v
    WHERE tt-acao-v.data >= data-ini
    AND   tt-acao-v.data <= data-fim:
    {func\relat\linha.i &Coluna1=tt-acao-v.nome
                        &Align1="left"
                        &Coluna2=tt-acao-v.data
                        &Align2="left"
                        &Coluna3=tt-acao-v.quantidade
                        &Align3="right"
                        &Coluna4=tt-acao-v.valor
                        &Align4="right"
                        &Coluna5=tt-acao-v.taxa
                        &Align5="right"}
END.
                            
{func\relat\end-capitulo.i}

{func\relat\capitulo.i '"Lucro"' 800}

{func\relat\titulo.i &Coluna1='"Aá∆o"'
                     &Tamanho1=200
                     &Coluna2='"Màs"'
                     &Tamanho2=80
                     &Coluna3='"Vl Compra"'
                     &Tamanho3=100
                     &Coluna4='"Vl Venda"'
                     &Tamanho4=100
                     &Coluna5='"Vl Taxas"'
                     &Tamanho5=80
                     &Coluna6='"Vl Cust"'
                     &Tamanho6=80
                     &Coluna7='"Lucro"'
                     &Tamanho7=80
                     &Coluna8='"% Lucro"'
                     &Tamanho8=80}
                     
ASSIGN deTotVlL = 0.

FOR EACH tt-acao-v
    WHERE tt-acao-v.data >= data-ini
    AND   tt-acao-v.data <= data-fim:

    CREATE tt-lucro.
    ASSIGN tt-lucro.nome = tt-acao-v.nome
           tt-lucro.data = tt-acao-v.data
           tt-lucro.iMes = MONTH(tt-acao-v.data).

    FOR EACH tt-acao-c
        WHERE tt-acao-c.nome = tt-acao-v.nome
        AND   tt-acao-c.data < tt-acao-v.data:
        ASSIGN tt-lucro.deVlC = tt-lucro.deVlC + tt-acao-c.valor
               tt-lucro.deVlTx = tt-lucro.deVlTx + tt-acao-c.taxa.
    END.

    ASSIGN tt-lucro.deVlV = tt-acao-v.valor
           tt-lucro.deVlTx = tt-lucro.deVlTx + tt-acao-v.taxa.

    ASSIGN tt-lucro.deVlCt = 0.
    FOR EACH tt-custodia
        WHERE tt-custodia.nome = tt-acao-v.nome
        AND   tt-custodia.data < tt-acao-v.data:
        ASSIGN tt-lucro.deVlCt = tt-lucro.deVlCt + tt-custodia.valor.
    END.

    ASSIGN tt-lucro.deVlL = tt-lucro.deVlV - (tt-lucro.deVlC + tt-lucro.deVlTx + tt-lucro.deVlCt)
           tt-lucro.deVlPL = ((tt-lucro.deVlL / tt-lucro.deVlC) * 100)
           tt-lucro.cMes = fnMes(MONTH(tt-lucro.data)) + "/" + STRING(YEAR(tt-lucro.data))
           deTotVlL = deTotVlL + tt-lucro.deVlL.

    {func\relat\linha.i &Coluna1=tt-acao-v.nome
                        &Align1="left"
                        &Coluna2=tt-lucro.cMes
                        &Align2="left"
                        &Coluna3=tt-lucro.deVlC
                        &Align3="right"
                        &Coluna4=tt-lucro.deVlV
                        &Align4="right"
                        &Coluna5=tt-lucro.deVlTx
                        &Align5="right"
                        &Coluna6=tt-lucro.deVlCt
                        &Align6="right"
                        &Coluna7=tt-lucro.deVlL
                        &Align7="right"
                        &Coluna8=tt-lucro.deVlPL
                        &Align8="right"}
END.
                            
{func\relat\total.i &Coluna1='Total'
                    &Align1="left"
                    &Coluna2=''
                    &Align2="left"
                    &Coluna3=''
                    &Align3="right"
                    &Coluna4=''
                    &Align4="right"
                    &Coluna5=''
                    &Align5="right"
                    &Coluna6=''
                    &Align6="right"
                    &Coluna7=deTotVlL
                    &Align7="right"
                    &Coluna8=''
                    &Align8="right"}

{func\relat\end-capitulo.i}

{func\relat\capitulo.i '"Apuraá∆o de Imposto"' 600}

{func\relat\titulo.i &Coluna1='"Màs"'
                     &Tamanho1=200
                     &Coluna2='"Vl Venda"'
                     &Tamanho2=200
                     &Coluna3='"Imposto"'
                     &Tamanho3=200}
                     
ASSIGN deTot = 0
       deTotVlL = 0.
FOR EACH tt-lucro
    BREAK BY tt-lucro.iMes:

    ASSIGN deTot = deTot + tt-lucro.deVlV.

    IF LAST-OF(tt-lucro.iMes) THEN DO:

        IF deTot > 20000 THEN
            ASSIGN deTx = deTot * 0.15.
        ELSE
            ASSIGN deTx = 0.

        ASSIGN deTotVlL = deTotVlL + deTx.

        {func\relat\linha.i &Coluna1=tt-lucro.cMes
                            &Align1="left"
                            &Coluna2=deTot
                            &Align2="right"
                            &Coluna3=deTx
                            &Align3="right"}
                            
        ASSIGN deTot = 0.
                            
    END.

END.

{func\relat\total.i &Coluna1='Total'
                    &Align1="left"
                    &Coluna2=''
                    &Align2="left"
                    &Coluna3=deTotVlL
                    &Align3="right"}

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

FIND FIRST favorecido NO-LOCK
    WHERE favorecido.ds-favorecido MATCHES("*compra*aá‰es*") NO-ERROR.
IF AVAIL favorecido THEN DO:
    ASSIGN iFavC = favorecido.cd-favorecido.
END.

FIND FIRST favorecido NO-LOCK
    WHERE favorecido.ds-favorecido MATCHES("*venda*aá‰es*") NO-ERROR.
IF AVAIL favorecido THEN DO:
    ASSIGN iFavV = favorecido.cd-favorecido.
END.

ASSIGN data-ini = DATE(1,1,0001)
       data-fim = DATE(12,31,YEAR(TODAY)).

{func\relat\initialize.i}

{func\cursor.i iConta}
{func\cursor.i iFavC}
{func\cursor.i iFavV}

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

