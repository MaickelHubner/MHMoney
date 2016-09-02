&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-disp NO-UNDO LIKE pedido-item-usu.
DEFINE TEMP-TABLE tt-sel NO-UNDO LIKE pedido-item-usu.



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
DEFINE VARIABLE iCont AS INTEGER     NO-UNDO.
/* Parameters Definitions ---                                           */
DEFINE INPUT  PARAMETER rMovto AS ROWID       NO-UNDO.

/* Pr‚-processadores */
&GLOBAL-DEFINE Table         pedido-item
&GLOBAL-DEFINE TableDisp     tt-disp
&GLOBAL-DEFINE TableSelect   tt-sel
&GLOBAL-DEFINE ParentFields  pedido-item.nr-pedido pedido-item.sequencia
&GLOBAL-DEFINE CamposDisp    tt-disp.nome
&GLOBAL-DEFINE CamposSelect  tt-sel.nome

/* Local Variable Definitions ---                                       */

/* Buffers */

{func\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-disp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES {&TableDisp} {&TableSelect}

/* Definitions for BROWSE br-disp                                       */
&Scoped-define FIELDS-IN-QUERY-br-disp {&CamposDisp}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-disp   
&Scoped-define SELF-NAME br-disp
&Scoped-define QUERY-STRING-br-disp FOR EACH {&TableDisp} NO-LOCK     WHERE {&TableDisp}.nome >= INPUT FRAME {&FRAME-NAME} nom-ini     AND   {&TableDisp}.nome <= INPUT FRAME {&FRAME-NAME} nom-fim INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-disp OPEN QUERY {&SELF-NAME} FOR EACH {&TableDisp} NO-LOCK     WHERE {&TableDisp}.nome >= INPUT FRAME {&FRAME-NAME} nom-ini     AND   {&TableDisp}.nome <= INPUT FRAME {&FRAME-NAME} nom-fim INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-disp {&TableDisp}
&Scoped-define FIRST-TABLE-IN-QUERY-br-disp {&TableDisp}


/* Definitions for BROWSE br-select                                     */
&Scoped-define FIELDS-IN-QUERY-br-select {&CamposSelect}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-select   
&Scoped-define SELF-NAME br-select
&Scoped-define QUERY-STRING-br-select FOR EACH {&TableSelect} OF {&Table} NO-LOCK INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE
&Scoped-define OPEN-QUERY-br-select OPEN QUERY {&SELF-NAME} FOR EACH {&TableSelect} OF {&Table} NO-LOCK INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-select {&TableSelect}
&Scoped-define FIRST-TABLE-IN-QUERY-br-select {&TableSelect}


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-disp}~
    ~{&OPEN-QUERY-br-select}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS pedido-item.sequencia pedido-item.nr-pedido 
&Scoped-define ENABLED-TABLES pedido-item
&Scoped-define FIRST-ENABLED-TABLE pedido-item
&Scoped-Define ENABLED-OBJECTS br-select btAdd btAddAll btDel btDelAll ~
btExit btFiltra btFirst btLast btNext btPrev nom-ini nom-fim br-disp ~
IMAGE-1 IMAGE-2 RECT-5 RECT-6 RECT-9 
&Scoped-Define DISPLAYED-FIELDS pedido-item.sequencia pedido-item.nr-pedido 
&Scoped-define DISPLAYED-TABLES pedido-item
&Scoped-define FIRST-DISPLAYED-TABLE pedido-item
&Scoped-Define DISPLAYED-OBJECTS nom-ini nom-fim 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-fled.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fled.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL ">>" 
     SIZE 6.14 BY 1.79 TOOLTIP "Adicionar".

DEFINE BUTTON btAddAll 
     IMAGE-UP FILE "image/im-fledt.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fledt.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL ">>>>" 
     SIZE 6.14 BY 1.79 TOOLTIP "Adicionar Todos".

DEFINE BUTTON btDel 
     IMAGE-UP FILE "image/im-flee.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-flee.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "<<" 
     SIZE 6.14 BY 1.79 TOOLTIP "Retirar".

DEFINE BUTTON btDelAll 
     IMAGE-UP FILE "image/im-fleet.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fleet.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "<<<<" 
     SIZE 6.14 BY 1.79 TOOLTIP "Retirar Todos".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btFiltra 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Filtra" 
     SIZE 6.14 BY 1.79 TOOLTIP "Filtrar Dispon¡veis".

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "éltimo".

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

DEFINE VARIABLE nom-fim AS CHARACTER FORMAT "X(256)":U INITIAL "ZZZZZZZZ" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE VARIABLE nom-ini AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nome" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-2
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 101 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 44 BY 2.25.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 101 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-disp FOR 
      {&TableDisp} SCROLLING.

DEFINE QUERY br-select FOR 
      {&TableSelect} SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-disp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-disp C-Win _FREEFORM
  QUERY br-disp NO-LOCK DISPLAY
      {&CamposDisp}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE SIZE 44 BY 8.75
         FONT 7
         TITLE "Dispon¡veis" ROW-HEIGHT-CHARS .46 FIT-LAST-COLUMN.

DEFINE BROWSE br-select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-select C-Win _FREEFORM
  QUERY br-select NO-LOCK DISPLAY
      {&CamposSelect}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE SIZE 44 BY 11.25
         FONT 7
         TITLE "Selecionados" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-select AT ROW 5.75 COL 59
     btAdd AT ROW 11.54 COL 49
     btAddAll AT ROW 9.75 COL 49
     btDel AT ROW 13.33 COL 49
     btDelAll AT ROW 15.13 COL 49
     btExit AT ROW 1.5 COL 96
     btFiltra AT ROW 6 COL 39
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     nom-ini AT ROW 6.58 COL 9 COLON-ALIGNED
     nom-fim AT ROW 6.58 COL 26 COLON-ALIGNED NO-LABEL
     br-disp AT ROW 8.25 COL 2
     pedido-item.sequencia AT ROW 4.25 COL 57 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     pedido-item.nr-pedido AT ROW 4.25 COL 38 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     IMAGE-1 AT ROW 6.25 COL 19
     IMAGE-2 AT ROW 6.25 COL 23.43
     RECT-5 AT ROW 3.75 COL 2
     RECT-6 AT ROW 5.75 COL 2
     RECT-9 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 102.57 BY 16.25
         FONT 7.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-disp T "?" NO-UNDO money pedido-item-usu
      TABLE: tt-sel T "?" NO-UNDO money pedido-item-usu
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Restri‡äes do Usu rio"
         HEIGHT             = 16.25
         WIDTH              = 102.57
         MAX-HEIGHT         = 16.25
         MAX-WIDTH          = 102.57
         VIRTUAL-HEIGHT     = 16.25
         VIRTUAL-WIDTH      = 102.57
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
/* BROWSE-TAB br-select 1 DEFAULT-FRAME */
/* BROWSE-TAB br-disp nom-fim DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-disp
/* Query rebuild information for BROWSE br-disp
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&TableDisp} NO-LOCK
    WHERE {&TableDisp}.nome >= INPUT FRAME {&FRAME-NAME} nom-ini
    AND   {&TableDisp}.nome <= INPUT FRAME {&FRAME-NAME} nom-fim INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-disp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-select
/* Query rebuild information for BROWSE br-select
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&TableSelect} OF {&Table} NO-LOCK INDEXED-REPOSITION.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-select */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Restri‡äes do Usu rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Restri‡äes do Usu rio */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* >> */
DO:
    /*     {func\formation\bt_add.i} */
    RUN som.p(INPUT "music\click.wav").
    RUN validateRecord IN THIS-PROCEDURE NO-ERROR.


    IF RETURN-VALUE = "OK" THEN DO:
        blk:
        DO TRANSACTION:
            REPEAT iCont = 1 TO br-disp:NUM-SELECTED-ROWS:
                br-disp:FETCH-SELECTED-ROW(iCont) IN FRAME {&FRAME-NAME}.

                CREATE {&TableSelect}.
                BUFFER-COPY {&TableDisp} TO {&TableSelect} NO-ERROR.
            END.
        END. 

        RUN setCampos IN THIS-PROCEDURE NO-ERROR.
        RUN afterChange IN THIS-PROCEDURE NO-ERROR.
        {&OPEN-QUERY-br-select}
        {&OPEN-QUERY-br-disp}
        RUN controlButtons IN THIS-PROCEDURE.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAddAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAddAll C-Win
ON CHOOSE OF btAddAll IN FRAME DEFAULT-FRAME /* >>>> */
DO:
    {func\formation\bt_add_all.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel C-Win
ON CHOOSE OF btDel IN FRAME DEFAULT-FRAME /* << */
DO:
    /*{func\formation\bt_del.i}  */

    RUN som.p(INPUT "music\click.wav").
    RUN validateRecord IN THIS-PROCEDURE NO-ERROR.

    IF RETURN-VALUE = "OK" THEN DO:
        blk:
        DO TRANSACTION:
            REPEAT iCont = 1 TO br-select:NUM-SELECTED-ROWS:
                br-select:FETCH-SELECTED-ROW(iCont) IN FRAME {&FRAME-NAME}.

                IF AVAILABLE {&TableSelect} THEN
                    DELETE {&TableSelect}.
            END.
        END. 

        RUN afterChange IN THIS-PROCEDURE NO-ERROR.
        {&OPEN-QUERY-br-select}
        {&OPEN-QUERY-br-disp}
        RUN controlButtons IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDelAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDelAll C-Win
ON CHOOSE OF btDelAll IN FRAME DEFAULT-FRAME /* <<<< */
DO:
    {func\formation\bt_del_all.i}  
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


&Scoped-define SELF-NAME btFiltra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFiltra C-Win
ON CHOOSE OF btFiltra IN FRAME DEFAULT-FRAME /* Filtra */
DO:
    {func\formation\bt_filtro.i}
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


&Scoped-define SELF-NAME nom-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nom-fim C-Win
ON ENTRY OF nom-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nom-fim C-Win
ON LEAVE OF nom-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nom-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nom-ini C-Win
ON ENTRY OF nom-ini IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nom-ini C-Win
ON LEAVE OF nom-ini IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-disp
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\formation\campo_filtro.i &Campo=nom}

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
  {version.i usuarped}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterChange C-Win 
PROCEDURE afterChange :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FOR EACH pedido-item-usu 
        WHERE pedido-item-usu.nr-pedido = pedido-item.nr-pedido
        AND   pedido-item-usu.sequencia = pedido-item.sequencia EXCLUSIVE-LOCK:
        FIND FIRST tt-sel OF pedido-item-usu NO-LOCK NO-ERROR.
        IF NOT AVAIL tt-sel THEN DO:
            DELETE pedido-item-usu.
        END.
        ELSE DO:
            DELETE tt-sel.
        END.
    END.

    FOR EACH tt-sel:
        CREATE pedido-item-usu.
        ASSIGN pedido-item-usu.nr-pedido = pedido-item.nr-pedido
               pedido-item-usu.sequencia = pedido-item.sequencia
               pedido-item-usu.nome = tt-sel.nome.
    END.

    RUN ProgDisp IN THIS-PROCEDURE.

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

    {func\formation\control_buttons.i}

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

RUN ProgDisp IN THIS-PROCEDURE.

{func\formation\display.i}

IF NOT AVAIL {&Table} THEN DO:

    ASSIGN pedido-item.nr-pedido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           pedido-item.sequencia:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?.

END.

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
  DISPLAY nom-ini nom-fim 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE pedido-item THEN 
    DISPLAY pedido-item.sequencia pedido-item.nr-pedido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-select btAdd btAddAll btDel btDelAll btExit btFiltra btFirst btLast 
         btNext btPrev nom-ini nom-fim br-disp pedido-item.sequencia 
         pedido-item.nr-pedido IMAGE-1 IMAGE-2 RECT-5 RECT-6 RECT-9 
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
ASSIGN r-pedido-item = rMovto.

{func\initialize.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProgDisp C-Win 
PROCEDURE ProgDisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

EMPTY TEMP-TABLE tt-disp.
EMPTY TEMP-TABLE tt-sel.

FOR EACH usuario NO-LOCK:
    FIND FIRST favorecido OF usuario NO-LOCK NO-ERROR.
    IF AVAIL favorecido
    AND favorecido.ativo THEN DO:
        CREATE tt-disp.
        BUFFER-COPY pedido-item TO tt-disp.
        ASSIGN tt-disp.nome = usuario.nome.
    END.
END.


FOR EACH pedido-item-usu NO-LOCK
    WHERE pedido-item-usu.nr-pedido = pedido-item.nr-pedido
    AND   pedido-item-usu.sequencia = pedido-item.sequencia:
    CREATE tt-sel.
    BUFFER-COPY pedido-item-usu TO tt-sel.
END.

FOR EACH tt-sel NO-LOCK:
    FIND FIRST tt-disp WHERE tt-disp.nome = tt-sel.nome NO-ERROR.
    IF AVAIL tt-disp THEN
        DELETE tt-disp.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setCampos C-Win 
PROCEDURE setCampos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN {&TableSelect}.nr-pedido = {&Table}.nr-pedido
           {&TableSelect}.sequencia = {&Table}.sequencia.

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

/*IF CAN-FIND(FIRST {&TableSelect}
            WHERE {&TableSelect}.nr-pedido   = {&TableDisp}.nr-pedido
            AND   {&TableSelect}.nr-controle = {&Table}.nr-controle) THEN DO:
    {func\valida.i &Mensagem  = "Pedido inv lido!"
                   &Ajuda     = "Esse Pedido j  est  relacionado … Nota Fiscal."}
    RETURN "NOK".
END.*/

RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

