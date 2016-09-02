&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
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

&GLOBAL-DEFINE FrameFields  mes-ini ano-ini mes-fim ano-fim moeda l-resumido ignora

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

DEFINE TEMP-TABLE tt-cat
    FIELD cod-cat AS INT
    FIELD ds-cat AS CHAR FORMAT "X(40)" COLUMN-LABEL "Categoria"
    FIELD pc-inf AS DEC FORMAT ">>9.9999" COLUMN-LABEL "Percentual"
    FIELD valor AS DEC
    FIELD pc-total AS DEC FORMAT "->>>9.9999"
    INDEX vl-des valor
    INDEX inf-des pc-inf DESCENDING.

DEFINE TEMP-TABLE tt-item
    FIELD ds-item AS CHAR
    FIELD cod-cat AS INT
    FIELD cod-item AS INT
    FIELD vl-ini AS DEC
    FIELD vl-fim AS DEC
    FIELD pc-inf AS DEC FORMAT "->>>9.9999".

{cotacao.i}
{func\data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brCat

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-cat

/* Definitions for BROWSE brCat                                         */
&Scoped-define FIELDS-IN-QUERY-brCat tt-cat.ds-cat tt-cat.pc-inf   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brCat tt-cat.pc-inf   
&Scoped-define ENABLED-TABLES-IN-QUERY-brCat tt-cat
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-brCat tt-cat
&Scoped-define SELF-NAME brCat
&Scoped-define QUERY-STRING-brCat FOR EACH tt-cat BY tt-cat.pc-inf DESCENDING
&Scoped-define OPEN-QUERY-brCat OPEN QUERY {&SELF-NAME} FOR EACH tt-cat BY tt-cat.pc-inf DESCENDING.
&Scoped-define TABLES-IN-QUERY-brCat tt-cat
&Scoped-define FIRST-TABLE-IN-QUERY-brCat tt-cat


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brCat}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-5 IMAGE-6 RECT-10 mes-ini btCancel ~
ano-ini mes-fim ano-fim moeda l-resumido ignora btOK brCat 
&Scoped-Define DISPLAYED-OBJECTS mes-ini ano-ini mes-fim ano-fim moeda ~
l-resumido ignora 

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

DEFINE VARIABLE mes-fim AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Maráo",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE mes-ini AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Per°odo" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Maráo",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE ano-fim AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE ano-ini AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE ignora AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 2000 
     LABEL "M†ximo Considerar" 
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
     SIZE 78 BY 11.25.

DEFINE VARIABLE l-resumido AS LOGICAL INITIAL no 
     LABEL "Resumido" 
     VIEW-AS TOGGLE-BOX
     SIZE 10 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brCat FOR 
      tt-cat SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brCat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brCat C-Win _FREEFORM
  QUERY brCat DISPLAY
      tt-cat.ds-cat
 tt-cat.pc-inf
 ENABLE
 tt-cat.pc-inf
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 50 BY 7.25
         FONT 7.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     mes-ini AT ROW 2 COL 16 COLON-ALIGNED
     btCancel AT ROW 10.25 COL 73
     ano-ini AT ROW 2 COL 32.29 COLON-ALIGNED NO-LABEL
     mes-fim AT ROW 2 COL 44.72 COLON-ALIGNED NO-LABEL
     ano-fim AT ROW 2 COL 61 COLON-ALIGNED NO-LABEL
     moeda AT ROW 3 COL 16 COLON-ALIGNED
     l-resumido AT ROW 3 COL 59
     ignora AT ROW 4 COL 52 COLON-ALIGNED
     btOK AT ROW 8.5 COL 73
     brCat AT ROW 5 COL 18
     IMAGE-5 AT ROW 1.63 COL 38
     IMAGE-6 AT ROW 1.63 COL 42.43
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 12.25
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
         HEIGHT             = 12.25
         WIDTH              = 80
         MAX-HEIGHT         = 14.29
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 14.29
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
/* BROWSE-TAB brCat btOK DEFAULT-FRAME */
ASSIGN 
       brCat:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brCat:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brCat
/* Query rebuild information for BROWSE brCat
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-cat BY tt-cat.pc-inf DESCENDING.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brCat */
&ANALYZE-RESUME

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
       ROW             = 12.5
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(brCat:HANDLE IN FRAME DEFAULT-FRAME).

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


&Scoped-define SELF-NAME ano-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-fim C-Win
ON ENTRY OF ano-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-fim C-Win
ON LEAVE OF ano-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} ano-fim <> ano-fim THEN DO:
        RUN recalculaCat.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ano-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-ini C-Win
ON ENTRY OF ano-ini IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-ini C-Win
ON LEAVE OF ano-ini IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} ano-ini <> ano-ini THEN DO:
        RUN recalculaCat.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brCat
&Scoped-define SELF-NAME brCat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCat C-Win
ON ROW-LEAVE OF brCat IN FRAME DEFAULT-FRAME
DO:
    assign input browse brCat tt-cat.pc-inf.
    DISPLAY tt-cat.pc-inf WITH BROWSE brCat.
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


&Scoped-define SELF-NAME ignora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ignora C-Win
ON ENTRY OF ignora IN FRAME DEFAULT-FRAME /* M†ximo Considerar */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ignora C-Win
ON LEAVE OF ignora IN FRAME DEFAULT-FRAME /* M†ximo Considerar */
DO:
    {func\set_leave.i}    
    IF INPUT FRAME {&FRAME-NAME} ignora <> ignora THEN DO:
        RUN recalculaCat.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-fim C-Win
ON ENTRY OF mes-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-fim C-Win
ON LEAVE OF mes-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-fim C-Win
ON VALUE-CHANGED OF mes-fim IN FRAME DEFAULT-FRAME
DO:
    IF INPUT FRAME {&FRAME-NAME} mes-fim <> mes-fim THEN DO:
        RUN recalculaCat.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON ENTRY OF mes-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON LEAVE OF mes-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON VALUE-CHANGED OF mes-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    IF INPUT FRAME {&FRAME-NAME} mes-ini <> mes-ini THEN DO:
        RUN recalculaCat.
    END.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON VALUE-CHANGED OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    IF INPUT FRAME {&FRAME-NAME} moeda <> moeda THEN DO:
        RUN recalculaCat.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\relat\main_block.i &Cotacao=NO
                         &Data=NO}

{campos\cd-moeda.i}                

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
  {version.i r017}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculaPC C-Win 
PROCEDURE calculaPC :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE deAux AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deTot AS DECIMAL    NO-UNDO.

IF CAN-FIND(FIRST tt-cat) THEN DO:
    FOR EACH tt-cat:
        ASSIGN deAux = deAux + tt-cat.valor.
    END.

    ASSIGN deTot = 0.
    FOR EACH tt-cat
        USE-INDEX vl-des:

        ASSIGN tt-cat.pc-inf = ((tt-cat.valor * 100) / deAux)
               deTot = deTot + tt-cat.pc-inf.

    END.

    IF deTot < 100 THEN DO:
        FIND LAST tt-cat USE-INDEX vl-des.
        ASSIGN tt-cat.pc-inf = tt-cat.pc-inf + (100 - deTot).
    END.
END.

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

OCXFile = SEARCH( "r017.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "r017.wrx":U SKIP(1)
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

RUN recalculaCat.

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
  DISPLAY mes-ini ano-ini mes-fim ano-fim moeda l-resumido ignora 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE IMAGE-5 IMAGE-6 RECT-10 mes-ini btCancel ano-ini mes-fim ano-fim moeda 
         l-resumido ignora btOK brCat 
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

DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO FORMAT "X(250)".
DEFINE VARIABLE deInf AS DECIMAL  FORMAT "->>>9.9999"   NO-UNDO.
DEFINE VARIABLE iContIt AS INTEGER    NO-UNDO.
DEFINE VARIABLE dePCFinal AS DECIMAL  FORMAT "->>>9.9999"   NO-UNDO.
DEFINE VARIABLE dePCTot AS DECIMAL  FORMAT "->>>9.9999"   NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE deVlMes AS DECIMAL     NO-UNDO.
DEFINE VARIABLE cData AS CHARACTER   NO-UNDO.
DEFINE VARIABLE dtUlt AS DATE    NO-UNDO.
DEFINE VARIABLE iQtdMov AS INTEGER     NO-UNDO.

/* Acerto de Datas */
FIND FIRST item-compra NO-LOCK NO-ERROR.
IF AVAIL item-compra THEN DO:
    FIND FIRST compra OF item-compra NO-LOCK.
    IF compra.dt-compra > fnUltimoDia(mes-ini,ano-ini) THEN DO:
        ASSIGN mes-ini = MONTH(compra.dt-compra)
               ano-ini = YEAR(compra.dt-compra).
    END.
END.

ASSIGN iCont = 0.
FOR EACH tt-cat
    WHERE tt-cat.pc-inf > 0:
    ASSIGN iCont = iCont + 1.
END.
/* Output padr∆o */
{func\relat\ini.i iCont}

/* L¢gica do relat¢rio */
FOR EACH tt-item:
    DELETE tt-item.
END.
FOR EACH compra NO-LOCK
    WHERE compra.dt-compra >= DATE(mes-ini,1,ano-ini)
    AND   compra.dt-compra <= fnUltimoDia(mes-fim,ano-fim),
    EACH item-compra OF compra NO-LOCK,
    FIRST ITEM OF item-compra NO-LOCK
    BREAK BY ITEM.cd-item
    BY compra.dt-compra:

    IF FIRST-OF(ITEM.cd-item) THEN DO:
        CREATE tt-item.
        ASSIGN tt-item.ds-item = ITEM.ds-item
               tt-item.cod-cat = ITEM.cod-categoria
               tt-item.cod-item = ITEM.cd-item
               tt-item.vl-ini = fnCotacao(item-compra.vl-unitario,0,moeda,compra.dt-compra).
    END.

    IF LAST-OF(ITEM.cd-item) THEN DO:
        ASSIGN tt-item.vl-fim = fnCotacao(item-compra.vl-unitario,0,moeda,compra.dt-compra).
    END.

END.

FOR EACH sub-cat NO-LOCK
    WHERE sub-cat.inflacao:

    CREATE tt-item.
    ASSIGN tt-item.ds-item = sub-cat.ds-sub
           tt-item.cod-cat = sub-cat.cod-categoria
           tt-item.cod-item = sub-cat.cd-sub
           cData = ""
           deVlMes = 0
           iQtdMov = 0.

    FOR EACH mov-conta NO-LOCK
        WHERE mov-conta.cod-categoria = sub-cat.cod-categoria
        AND   mov-conta.cd-sub = sub-cat.cd-sub
        AND   mov-conta.dt-mov >= DATE(mes-ini,1,ano-ini)
        AND   mov-conta.dt-mov <= fnUltimoDia(mes-fim,ano-fim)
        AND   mov-conta.de-valor < 0
        AND   mov-conta.de-valor > ((-1) * INPUT FRAME {&FRAME-NAME} ignora)
        AND   NOT mov-conta.ds-observacao MATCHES("*ITENS DA COMPRA:*")
        BY mov-conta.dt-mov:

        IF STRING(YEAR(mov-conta.dt-mov),"9999") + "-" + STRING(MONTH(mov-conta.dt-mov),"99") <> cData THEN DO:
            IF tt-item.vl-ini = 0 AND cData <> "" 
            AND MONTH(dtUlt) = mes-ini
            AND YEAR(dtUlt) = ano-ini THEN
                IF iQtdMov > 0 THEN
                    ASSIGN tt-item.vl-ini = (deVlMes / iQtdMov).
                ELSE
                    ASSIGN tt-item.vl-ini = 0.
            ASSIGN deVlMes = 0
                   iQtdMov = 0
                   cData = STRING(YEAR(mov-conta.dt-mov),"9999") + "-" + STRING(MONTH(mov-conta.dt-mov),"99").
        END.

        ASSIGN deVlMes = deVlMes + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov))
               dtUlt = mov-conta.dt-mov
               iQtdMov = iQtdMov + 1.

    END.

    IF MONTH(dtUlt) = mes-fim
    AND YEAR(dtUlt) = ano-fim THEN
        IF iQtdMov > 0 THEN
            ASSIGN tt-item.vl-fim = (deVlMes / iQtdMov).
        ELSE
            ASSIGN tt-item.vl-fim = 0.

    IF tt-item.vl-ini = 0 AND tt-item.vl-fim = 0 THEN
        DELETE tt-item.

END.

FOR EACH tt-item:
    IF tt-item.vl-ini <> 0 THEN
        ASSIGN tt-item.pc-inf = (((tt-item.vl-fim - tt-item.vl-ini) * 100) / tt-item.vl-ini).
    ELSE
        ASSIGN tt-item.pc-inf = 100.
END.

IF NOT l-resumido THEN DO:
    ASSIGN cTemp = "Per°odo: " + STRING(mes-ini,"99") + "/" + STRING(ano-ini,"9999") + " atÇ " + STRING(mes-fim,"99") + "/" + STRING(ano-fim,"9999").
    {func\relat\capitulo.i cTemp 800}

    {func\relat\titulo.i &Coluna1='"Categoria"'
                         &Tamanho1=320
                         &Coluna2='"Percentual"'
                         &Tamanho2=120
                         &Coluna3='"Preáo Ini"'
                         &Tamanho3=120
                         &Coluna4='"Preáo Fim"'
                         &Tamanho4=120
                         &Coluna5='"Inflaá∆o"'
                         &Tamanho5=120}
END.
                         
FOR EACH tt-cat
    WHERE tt-cat.pc-inf > 0
    USE-INDEX inf-des:
    IF NOT l-resumido THEN DO:
        {func\relat\linha.i &Coluna1=tt-cat.ds-cat
                            &Align1="left"
                            &Coluna2=tt-cat.pc-inf
                            &Align2="right"
                            &Negrito=YES}
    END.
                        
        {func\relat\control.i}

        ASSIGN deInf = 0
               iContIt = 0.
        FOR EACH tt-item NO-LOCK
            WHERE tt-item.cod-cat = tt-cat.cod-cat
            BY tt-item.pc-inf DESCENDING:
            IF NOT l-resumido THEN DO:
                ASSIGN cTemp = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + tt-item.ds-item.
                {func\relat\linha.i &Coluna1=cTemp
                                    &Align1="left"
                                    &Coluna2=''
                                    &Align2="right"
                                    &Coluna3=tt-item.vl-ini
                                    &Align3="right"
                                    &Coluna4=tt-item.vl-fim
                                    &Align4="right"
                                    &Coluna5=tt-item.pc-inf
                                    &Align5="right"}
            END.
            ASSIGN deInf = deInf + tt-item.pc-inf
                   iContIt = iContIt + 1.
        END.

        IF iContIt > 0 THEN
            ASSIGN deInf = deInf / iContIt.
        ELSE
            ASSIGN deInf = 0.

        ASSIGN tt-cat.pc-total = deInf
               cTemp = "Total de " + tt-cat.ds-cat.

        IF NOT l-resumido THEN DO:
            {func\relat\total.i &Coluna1=cTemp
                                &Align1="left"
                                &Coluna2=''
                                &Align2="right"
                                &Coluna3=''
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"
                                &Coluna5=deInf
                                &Align5="right"}
        END.
END.

IF NOT l-resumido THEN DO:
    {func\relat\end-capitulo.i}
    
    ASSIGN cTemp = "Resumo: ".
    {func\relat\capitulo.i cTemp 680}
END.
ELSE DO:
    {func\relat\capitulo.i '' 680}
END.

{func\relat\titulo.i &Coluna1='"Categoria"'
                     &Tamanho1=320
                     &Coluna2='"Percentual"'
                     &Tamanho2=120
                     &Coluna3='"Inflaá∆o"'
                     &Tamanho3=120
                     &Coluna4='"÷ndice"'
                     &Tamanho4=120}
                     
ASSIGN dePCTot = 0.
FOR EACH tt-cat
    WHERE tt-cat.pc-inf > 0
    USE-INDEX inf-des:
    ASSIGN dePCFinal = (tt-cat.pc-total * (tt-cat.pc-inf / 100))
           dePCTot = dePCTot + dePCFinal.
    {func\relat\linha.i &Coluna1=tt-cat.ds-cat
                        &Align1="left"
                        &Coluna2=tt-cat.pc-inf
                        &Align2="right"
                        &Coluna3=tt-cat.pc-total
                        &Align3="right"
                        &Coluna4=dePCFinal
                        &Align4="right"}     
END.

ASSIGN cTemp = "Inflaá∆o no Per°odo".
{func\relat\total.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=''
                    &Align2="right"
                    &Coluna3=''
                    &Align3="right"
                    &Coluna4=dePCTot
                    &Align4="right"}
                    
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

DEFINE VARIABLE dtAux AS DATE    NO-UNDO.

ASSIGN dtAux = DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1.

{func/cb-lista.i cd-moeda moeda}

ASSIGN mes-ini = MONTH(TODAY - 365)
       ano-ini = YEAR(TODAY - 365)
       mes-fim = MONTH(dtAux)
       ano-fim = YEAR(dtAux).

{func\relat\initialize.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalculaCat C-Win 
PROCEDURE recalculaCat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

    ASSIGN INPUT FRAME {&FRAME-NAME} {&FrameFields}.

    SESSION:SET-WAIT-STATE("image\calc.cur").

    FOR EACH tt-cat:
        DELETE tt-cat.
    END.

    FOR EACH compra NO-LOCK
        WHERE compra.dt-compra >= DATE(mes-ini,1,ano-ini)
        AND   compra.dt-compra <= fnUltimoDia(mes-fim,ano-fim),
        EACH item-compra OF compra,
        FIRST ITEM OF item-compra
        BREAK BY ITEM.cod-categoria:

        IF FIRST-OF(ITEM.cod-categoria) THEN DO:
            FIND FIRST categoria OF ITEM NO-LOCK.
            CREATE tt-cat.
            ASSIGN tt-cat.cod-cat = categoria.cod-categoria
                   tt-cat.ds-cat = categoria.ds-cat.
        END.

        FIND FIRST tt-cat
            WHERE tt-cat.cod-cat = ITEM.cod-categoria.
        ASSIGN tt-cat.valor = tt-cat.valor + fnCotacao(item-compra.vl-unitario,0,moeda,compra.dt-compra).

    END.

    FOR EACH sub-cat NO-LOCK
        WHERE inflacao
        BREAK BY sub-cat.cod-categoria
        BY sub-cat.cd-sub:

        IF FIRST-OF(sub-cat.cd-sub) THEN DO:
            ASSIGN deAux = 0.
        END.

        FOR EACH mov-conta NO-LOCK
            WHERE mov-conta.cod-categoria = sub-cat.cod-categoria
            AND   mov-conta.cd-sub = sub-cat.cd-sub
            AND   mov-conta.dt-mov >= DATE(mes-ini,1,ano-ini)
            AND   mov-conta.dt-mov <= fnUltimoDia(mes-fim,ano-fim)
            AND   mov-conta.de-valor < 0
            AND   mov-conta.de-valor > ((-1) * INPUT FRAME {&FRAME-NAME} ignora)
            AND   NOT mov-conta.ds-observacao MATCHES("*ITENS DA COMPRA:*")
            BY mov-conta.dt-mov:

            ASSIGN deAux = deAux + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov)).

        END.

        IF LAST-OF(sub-cat.cd-sub) THEN DO:
            FIND FIRST tt-cat EXCLUSIVE-LOCK
                WHERE tt-cat.cod-cat = sub-cat.cod-categoria NO-ERROR.
            IF NOT AVAIL tt-cat THEN DO:
                FIND FIRST categoria OF sub-cat NO-LOCK.
                CREATE tt-cat.
                ASSIGN tt-cat.cod-cat = categoria.cod-categoria
                       tt-cat.ds-cat = categoria.ds-cat.
            END.
            ASSIGN tt-cat.valor = tt-cat.valor + deAux.
        END.

    END.

    FOR EACH tt-cat WHERE tt-cat.valor = 0:
        DELETE tt-cat.
    END.

    RUN calculaPC.

    {&OPEN-QUERY-brCat}

    SESSION:SET-WAIT-STATE("").

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
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.

    FOR EACH tt-cat:
        ASSIGN deTemp = deTemp + tt-cat.pc-inf.    
    END.
    IF deTemp < 99.99990
    OR deTemp > 100.00001 THEN DO:
        {func\valida.i &Mensagem  = "Percentual inv†lido!"
                       &Ajuda     = "A soma dos percentuais deve ser 100,00 %."}
    END.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

