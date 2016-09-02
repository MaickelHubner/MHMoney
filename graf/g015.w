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
/* Pr‚-processadores */

&GLOBAL-DEFINE FrameFields  data-ini data-fim moeda tipo agrupa

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}
{func\tt_graf.i}

DEFINE TEMP-TABLE tt-comp
    FIELD cod-categoria LIKE categoria.cod-categoria
    FIELD valor AS DECIMAL
    FIELD pc-valor AS DECIMAL
    INDEX pri valor DESCENDING.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 IMAGE-6 RECT-10 btOK ~
data-ini data-fim tipo moeda agrupa 
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim tipo moeda agrupa 

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

DEFINE VARIABLE tipo AS INTEGER FORMAT "9":U INITIAL 1 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Receita",1,
                     "Despesa",2
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE agrupa AS INTEGER FORMAT ">>9":U INITIAL 5 
     LABEL "Agrupa em" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE VARIABLE data-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 5.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 4.5 COL 73
     btOK AT ROW 2.75 COL 73
     data-ini AT ROW 2 COL 24 COLON-ALIGNED
     data-fim AT ROW 2 COL 42 COLON-ALIGNED NO-LABEL
     tipo AT ROW 3 COL 24 COLON-ALIGNED
     moeda AT ROW 4 COL 24 COLON-ALIGNED
     agrupa AT ROW 5 COL 24 COLON-ALIGNED
     "%" VIEW-AS TEXT
          SIZE 2 BY .54 AT ROW 5.13 COL 36
     IMAGE-5 AT ROW 1.58 COL 35
     IMAGE-6 AT ROW 1.58 COL 39.43
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
         MAX-HEIGHT         = 8.42
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 8.42
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
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(agrupa:HANDLE IN FRAME DEFAULT-FRAME).

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


&Scoped-define SELF-NAME agrupa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agrupa C-Win
ON ENTRY OF agrupa IN FRAME DEFAULT-FRAME /* Agrupa em */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agrupa C-Win
ON LEAVE OF agrupa IN FRAME DEFAULT-FRAME /* Agrupa em */
DO:
    {func\set_leave.i}  
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


&Scoped-define SELF-NAME tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo C-Win
ON ENTRY OF tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo C-Win
ON LEAVE OF tipo IN FRAME DEFAULT-FRAME /* Tipo */
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
  {version.i g015}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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

OCXFile = SEARCH( "g015.wrx":U ).
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
ELSE MESSAGE "g015.wrx":U SKIP(1)
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
  DISPLAY data-ini data-fim tipo moeda agrupa 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 btOK data-ini data-fim tipo moeda 
         agrupa 
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
DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deAgrup AS DECIMAL    NO-UNDO.

FOR EACH tt-comp:
    DELETE tt-comp.
END.

/* Acerto de datas */
FIND FIRST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-ini = mov-conta.dt-mov.
FIND LAST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov <= data-fim USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-fim = mov-conta.dt-mov.

/* Controle da ProgressBar */
ASSIGN iTemp = (data-fim - data-ini) + 1.
{func\relat\ini-prg-bar.i iTemp}

/* L¢gica do relat¢rio */

ASSIGN tt-graf-par.dado-label     = "Categoria"
       tt-graf-par.valor-label[1] = "Valor"
       tt-graf-par.tipo = 19
       tt-graf-par.titulo = tt-graf-par.titulo + " de " + IF tipo = 1 THEN "Receita" ELSE "Despesa".

ASSIGN tt-graf-par.mostra-valores[1] = YES.

ASSIGN deTemp = 0.

FOR EACH mov-conta
    WHERE mov-conta.dt-mov >= data-ini
    AND   mov-conta.dt-mov <= data-fim
    AND   mov-conta.id-tipo <> 3
    AND   mov-conta.id-tipo <> 0
    AND   (IF tipo = 1 THEN mov-conta.de-valor > 0 ELSE mov-conta.de-valor < 0) NO-LOCK
    BREAK BY dt-mov:

    IF FIRST-OF(mov-conta.dt-mov) THEN DO:
        {func\relat\control.i}
    END.

    FIND FIRST tt-comp
        WHERE tt-comp.cod-categoria = mov-conta.cod-categoria NO-ERROR.
    IF AVAIL tt-comp THEN
        ASSIGN tt-comp.valor = tt-comp.valor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
    ELSE DO:
        CREATE tt-comp.
        ASSIGN tt-comp.valor = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov)
               tt-comp.cod-categoria = mov-conta.cod-categoria.
    END.

    ASSIGN deTemp = deTemp + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

END.

IF tipo = 2 THEN DO:
    FOR EACH tt-comp:
        ASSIGN tt-comp.valor = (-1) * tt-comp.valor.
    END.
    ASSIGN deTemp = (-1) * deTemp.
END.

ASSIGN iTemp = 1
       deAgrup = 100.

FOR EACH tt-comp:

    ASSIGN tt-comp.pc-valor = ((tt-comp.valor / deTemp) * 100).

    IF deAgrup > agrupa THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-comp.cod-categoria.

        CREATE tt-graf.
        ASSIGN tt-graf.dado = categoria.ds-categoria
               tt-graf.seq  = iTemp
               iTemp = iTemp + 1
               tt-graf.valor[1] = tt-comp.valor.
    END.
    ELSE DO:

        FIND FIRST tt-graf
            WHERE tt-graf.dado = "Outros" NO-ERROR.
        IF NOT AVAIL tt-graf THEN DO:
            CREATE tt-graf.
            ASSIGN tt-graf.dado = "Outros"
                   tt-graf.seq  = iTemp
                   iTemp = iTemp + 1.
        END.
        ASSIGN tt-graf.valor[1] = tt-graf.valor[1] + tt-comp.valor.

    END.

    ASSIGN deAgrup = deAgrup - tt-comp.pc-valor.


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

ASSIGN data-ini = DATE(1,1,YEAR(TODAY))
       data-fim = TODAY.

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

