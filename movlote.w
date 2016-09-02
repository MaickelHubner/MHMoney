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

/* Parameters Definitions ---                                           */

DEFINE INPUT  PARAMETER rTab AS ROWID      NO-UNDO.

/* Local Variable Definitions ---                                       */

{seg.i}

find first lote-mov where rowid(lote-mov) = rTab NO-LOCK.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-3

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES lote-mov-campo

/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 lote-mov-campo.campo ~
lote-mov-campo.Antes lote-mov-campo.depois lote-mov-campo.chave 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH lote-mov-campo ~
      WHERE lote-mov-campo.numero = lote-mov.numero ~
 AND lote-mov-campo.num-mov = lote-mov.num-mov ~
 AND lote-mov-campo.origem = lote-mov.origem NO-LOCK ~
    BY lote-mov-campo.chave DESCENDING
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH lote-mov-campo ~
      WHERE lote-mov-campo.numero = lote-mov.numero ~
 AND lote-mov-campo.num-mov = lote-mov.num-mov ~
 AND lote-mov-campo.origem = lote-mov.origem NO-LOCK ~
    BY lote-mov-campo.chave DESCENDING.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 lote-mov-campo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 lote-mov-campo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-3}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btExit RECT-5 BROWSE-3 
&Scoped-Define DISPLAYED-FIELDS lote-mov.numero lote-mov.origem ~
lote-mov.num-mov lote-mov.operacao lote-mov.tabela 
&Scoped-define DISPLAYED-TABLES lote-mov
&Scoped-define FIRST-DISPLAYED-TABLE lote-mov


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 72.43 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-3 FOR 
      lote-mov-campo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 C-Win _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      lote-mov-campo.campo FORMAT "X(30)":U WIDTH 20
      lote-mov-campo.Antes FORMAT "X(300)":U WIDTH 20
      lote-mov-campo.depois FORMAT "X(300)":U WIDTH 20
      lote-mov-campo.chave FORMAT "Sim/NÆo":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 72 BY 12.25
         FONT 1
         TITLE "Campos do Movimento" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btExit AT ROW 1.5 COL 67.43
     lote-mov.numero AT ROW 3.75 COL 14 COLON-ALIGNED
          LABEL "Lote"
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     lote-mov.origem AT ROW 3.75 COL 41 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     lote-mov.num-mov AT ROW 3.75 COL 59 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     lote-mov.operacao AT ROW 4.75 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7.14 BY .79
     lote-mov.tabela AT ROW 4.75 COL 29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 36 BY .79
     BROWSE-3 AT ROW 5.75 COL 2
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 74.29 BY 17.33
         FONT 1.


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
         TITLE              = "Campos do Movimento"
         HEIGHT             = 17.33
         WIDTH              = 74.29
         MAX-HEIGHT         = 23.04
         MAX-WIDTH          = 114.29
         VIRTUAL-HEIGHT     = 23.04
         VIRTUAL-WIDTH      = 114.29
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
/* BROWSE-TAB BROWSE-3 tabela DEFAULT-FRAME */
ASSIGN 
       BROWSE-3:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       BROWSE-3:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN lote-mov.num-mov IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN lote-mov.numero IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN lote-mov.operacao IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN lote-mov.origem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN lote-mov.tabela IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "money.lote-mov-campo"
     _Options          = "NO-LOCK"
     _OrdList          = "money.lote-mov-campo.chave|no"
     _Where[1]         = "lote-mov-campo.numero = lote-mov.numero
 AND lote-mov-campo.num-mov = lote-mov.num-mov
 AND lote-mov-campo.origem = lote-mov.origem"
     _FldNameList[1]   > money.lote-mov-campo.campo
"lote-mov-campo.campo" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[2]   > money.lote-mov-campo.Antes
"lote-mov-campo.Antes" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[3]   > money.lote-mov-campo.depois
"lote-mov-campo.depois" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[4]   = money.lote-mov-campo.chave
     _Query            is OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Campos do Movimento */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Campos do Movimento */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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


&Scoped-define BROWSE-NAME BROWSE-3
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
  {version.i movlote}
  RUN enable_UI.
  C-Win:top-only = yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  IF AVAILABLE lote-mov THEN 
    DISPLAY lote-mov.numero lote-mov.origem lote-mov.num-mov lote-mov.operacao 
          lote-mov.tabela 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btExit RECT-5 BROWSE-3 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

