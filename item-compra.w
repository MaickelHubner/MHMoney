&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
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

{func\tt_info.i}

DEFINE BUFFER bf-item-compra FOR item-compra.
DEFINE BUFFER bf-mov-conta FOR mov-conta.

DEFINE TEMP-TABLE tt-agrup
    FIELD cod-categoria LIKE categoria.cod-categoria
    FIELD cd-sub LIKE sub-cat.cd-sub
    FIELD valor AS DECIMAL
    FIELD itens AS CHAR
    INDEX idx cod-categoria cd-sub.

/* Parameters Definitions ---                                           */

/* PrÇ-processadores */
&GLOBAL-DEFINE Table         compra
&GLOBAL-DEFINE Filho         item-compra
&GLOBAL-DEFINE LabelFilho    
&GLOBAL-DEFINE ParentFields  compra.cd-compra compra.dt-compra
&GLOBAL-DEFINE KeyFields     compra.cd-compra
&GLOBAL-DEFINE CamposFilho   fnCd-item(item-compra.cd-item) @ cCd-item ~
                             item-compra.quantidade ~
                             fnUnidade(item-compra.cd-item) @ cUnidade ~
                             item-compra.vl-unitario ~
                             item-compra.vl-total

/* Local Variable Definitions ---                                       */

/* Buffers */

{func\definitions.i}

/* Campos Extrangeiros */
{campos\cd-item.i}

DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE pcActionBT AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-Parent   AS ROWID      NO-UNDO.
DEFINE VARIABLE val-compr-ant-tot AS DECIMAL NO-UNDO.
DEFINE VARIABLE val-compr-tot AS DECIMAL NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-page1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES {&Filho} ITEM

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 {&CamposFilho}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define QUERY-STRING-br-page1 FOR EACH {&Filho} OF {&Table} NO-LOCK, ~
           EACH ITEM OF {&Filho} NO-LOCK     BY ITEM.ds-item INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE
&Scoped-define OPEN-QUERY-br-page1 OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK, ~
           EACH ITEM OF {&Filho} NO-LOCK     BY ITEM.ds-item INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-page1 {&Filho} ITEM
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 {&Filho}
&Scoped-define SECOND-TABLE-IN-QUERY-br-page1 ITEM


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS compra.cd-compra compra.dt-compra 
&Scoped-define ENABLED-TABLES compra
&Scoped-define FIRST-ENABLED-TABLE compra
&Scoped-Define ENABLED-OBJECTS br-page1 btFec btAdd-page1 btDel-page1 ~
btExit btFirst btLast btNext btPrev btUpdate-page1 btGoTo btZoom RECT-5 ~
RECT-6 
&Scoped-Define DISPLAYED-FIELDS compra.cd-compra compra.dt-compra 
&Scoped-define DISPLAYED-TABLES compra
&Scoped-define FIRST-DISPLAYED-TABLE compra
&Scoped-Define DISPLAYED-OBJECTS vl-total desc-fav vl-perc-ult-compr 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd-page1 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btDel-page1 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btFec 
     IMAGE-UP FILE "image/im-saltar.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saltar.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Gerar Movimento de Compra".

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btGoTo 
     IMAGE-UP FILE "image/im-goto.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-goto.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "GoTo" 
     SIZE 6.14 BY 1.79 TOOLTIP "V† Para".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE desc-fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY .79 NO-UNDO.

DEFINE VARIABLE vl-perc-ult-compr AS DECIMAL FORMAT "->>,>>>,>>9.9999":U INITIAL 0 
     LABEL "% Variaá∆o" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE vl-total AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor Total" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-page1 FOR 
      {&Filho}, 
      ITEM SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-page1 C-Win _FREEFORM
  QUERY br-page1 NO-LOCK DISPLAY
      {&CamposFilho}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 93 BY 8.71
         FONT 7
         TITLE "".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-page1 AT ROW 6 COL 2
     btFec AT ROW 1.5 COL 81.86
     vl-total AT ROW 15.25 COL 60 COLON-ALIGNED
     desc-fav AT ROW 4.5 COL 38.57 COLON-ALIGNED NO-LABEL
     btAdd-page1 AT ROW 14.79 COL 2
     btDel-page1 AT ROW 14.79 COL 14.29
     btExit AT ROW 1.5 COL 88
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btUpdate-page1 AT ROW 14.79 COL 8.14
     compra.cd-compra AT ROW 4.5 COL 21 COLON-ALIGNED
          LABEL "Compra"
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     compra.dt-compra AT ROW 4.5 COL 28.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btGoTo AT ROW 1.5 COL 29
     btZoom AT ROW 1.5 COL 35.14
     vl-perc-ult-compr AT ROW 15.25 COL 83 COLON-ALIGNED WIDGET-ID 2
     RECT-5 AT ROW 4 COL 2
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 95 BY 15.71
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
         TITLE              = "Template Padr∆o de Master-Detail"
         HEIGHT             = 15.71
         WIDTH              = 95
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 95
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 95
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
/* BROWSE-TAB br-page1 1 DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN compra.cd-compra IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN desc-fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-perc-ult-compr IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-total IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK,
    EACH ITEM OF {&Filho} NO-LOCK
    BY ITEM.ds-item INDEXED-REPOSITION.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Master-Detail */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Master-Detail */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-page1
&Scoped-define SELF-NAME br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON DELETE-CHARACTER OF br-page1 IN FRAME DEFAULT-FRAME
DO:
    {func\br_del.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON MOUSE-SELECT-DBLCLICK OF br-page1 IN FRAME DEFAULT-FRAME
OR RETURN OF br-page1 DO:
    {func\br_dbclick.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    {func\bt_add_page.i}
    RUN recalculaTotal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    {func\bt_del_page.i}
    RUN recalculaTotal.
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


&Scoped-define SELF-NAME btFec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFec C-Win
ON CHOOSE OF btFec IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE iConta AS INTEGER    NO-UNDO INITIAL 0.
    DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iNumItens AS INTEGER     NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "geramovtocompra.w(INPUT ROWID(compra))"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_first.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btGoTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGoTo C-Win
ON CHOOSE OF btGoTo IN FRAME DEFAULT-FRAME /* GoTo */
DO:
    {func\bt_goto.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_last.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:  
   {func\bt_next.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    {func\bt_update_page.i}  
    RUN recalculaTotal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btZoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btZoom C-Win
ON CHOOSE OF btZoom IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_zoom.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

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
  {version.i item-compra}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcPerc C-Win 
PROCEDURE calcPerc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN  val-compr-tot     = 0
            val-compr-ant-tot = 0.
    
    FOR EACH item-compra                                                    
        WHERE item-compra.cd-compra = compra.cd-compra : 
        ASSIGN val-compr-tot = val-compr-tot + (item-compra.vl-unitario * item-compra.quantidade).
        blk-ult-compra:
        FOR EACH bf-compra
            WHERE bf-compra.dt-compra < compra.dt-compra,
            FIRST bf-item-compra OF bf-compra 
                WHERE bf-item-compra.cd-item = item-compra.cd-item
                BY bf-compra.dt-compra DESC:
            ASSIGN val-compr-ant-tot = val-compr-ant-tot + (bf-item-compra.vl-unitario * item-compra.quantidade).
            LEAVE blk-ult-compra.
        END.
        IF NOT AVAIL bf-item-compra THEN DO:
            ASSIGN val-compr-ant-tot = val-compr-ant-tot + (item-compra.vl-unitario * item-compra.quantidade).
        END.
    END.
    
    ASSIGN vl-perc-ult-compr = (((val-compr-tot - val-compr-ant-tot) * 100) / val-compr-ant-tot).
    
    DISP vl-perc-ult-compr
        WITH FRAME DEFAULT-FRAME.
    
    IF vl-perc-ult-compr <= 0 THEN
        ASSIGN vl-perc-ult-compr:BGCOLOR IN FRAME DEFAULT-FRAME = 21.
    ELSE
        ASSIGN vl-perc-ult-compr:BGCOLOR IN FRAME DEFAULT-FRAME = 12.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\master_detail\control_buttons.i}

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

IF AVAIL {&Table} THEN DO:
    FIND FIRST favorecido OF compra NO-LOCK NO-ERROR.
    IF AVAIL favorecido THEN
        ASSIGN desc-fav = favorecido.ds-favorecido.

    RUN recalculaTotal.

    {func\master_detail\display.i}

    DISPLAY desc-fav WITH FRAME {&FRAME-NAME}.

    IF compra.gerada THEN
        DISABLE btFec
                btAdd-page1
                btUpdate-page1
                btDel-page1 WITH FRAME {&FRAME-NAME}.
    ELSE
        ENABLE btFec WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:

    ASSIGN compra.cd-compra:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           compra.dt-compra:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

END.

RUN calcPerc.

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
  DISPLAY vl-total desc-fav vl-perc-ult-compr 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE compra THEN 
    DISPLAY compra.cd-compra compra.dt-compra 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-page1 btFec btAdd-page1 btDel-page1 btExit btFirst btLast btNext 
         btPrev btUpdate-page1 compra.cd-compra compra.dt-compra btGoTo btZoom 
         RECT-5 RECT-6 
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
{func\initialize.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalculaTotal C-Win 
PROCEDURE recalculaTotal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN vl-total = 0.
    FOR EACH bf-item-compra OF compra NO-LOCK:
        ASSIGN vl-total = vl-total + bf-item-compra.vl-total.
    END.
    DISPLAY vl-total WITH FRAME {&FRAME-NAME}.

    RUN calcPerc.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

