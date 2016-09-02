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

DEFINE INPUT  PARAMETER iProj AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER iPai AS INTEGER    NO-UNDO.

/* Local Variable Definitions ---                                       */

DEFINE BUFFER bfNivel FOR nivel-projeto.
DEFINE VARIABLE iNivel AS INTEGER    NO-UNDO INITIAL 1.

FIND FIRST projeto WHERE projeto.cd-projeto = iProj NO-LOCK NO-ERROR.
FIND LAST bfNivel NO-LOCK
    WHERE bfNivel.cd-projeto = iProj.
IF AVAIL bfNivel THEN
    ASSIGN iNivel = bfNivel.cd-nivel + 1.

CREATE nivel-projeto.
ASSIGN nivel-projeto.cd-projeto = iProj
       nivel-projeto.nivel-pai = iPai
       nivel-projeto.cd-nivel = iNivel.

FIND FIRST bfNivel NO-LOCK
    WHERE bfNivel.cd-projeto = iProj
    AND   bfNivel.cd-nivel = iPai NO-ERROR.

{seg.i}

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS nivel-projeto.ds-nivel 
&Scoped-define ENABLED-TABLES nivel-projeto
&Scoped-define FIRST-ENABLED-TABLE nivel-projeto
&Scoped-Define ENABLED-OBJECTS RECT-2 btOK btCan 
&Scoped-Define DISPLAYED-FIELDS nivel-projeto.cd-projeto ~
nivel-projeto.nivel-pai nivel-projeto.cd-nivel nivel-projeto.ds-nivel 
&Scoped-define DISPLAYED-TABLES nivel-projeto
&Scoped-define FIRST-DISPLAYED-TABLE nivel-projeto
&Scoped-Define DISPLAYED-OBJECTS ds-projeto ds-pai 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCan 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U
     LABEL "Cancela" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U
     LABEL "OK" 
     SIZE 6 BY 1.79.

DEFINE VARIABLE ds-pai AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .79 NO-UNDO.

DEFINE VARIABLE ds-projeto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     nivel-projeto.cd-projeto AT ROW 1.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-projeto AT ROW 1.5 COL 20.29 COLON-ALIGNED NO-LABEL
     nivel-projeto.nivel-pai AT ROW 2.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-pai AT ROW 2.5 COL 20.29 COLON-ALIGNED NO-LABEL
     nivel-projeto.cd-nivel AT ROW 4 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     nivel-projeto.ds-nivel AT ROW 5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 53 BY .79
     btOK AT ROW 6.25 COL 67.86
     btCan AT ROW 6.25 COL 74
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.04
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
         TITLE              = "Sub-N¡vel"
         HEIGHT             = 7.04
         WIDTH              = 80
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 30.04
         VIRTUAL-WIDTH      = 146.29
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
/* SETTINGS FOR FILL-IN nivel-projeto.cd-nivel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.cd-projeto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-pai IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-projeto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.nivel-pai IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Sub-N¡vel */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Sub-N¡vel */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCan C-Win
ON CHOOSE OF btCan IN FRAME DEFAULT-FRAME /* Cancela */
DO:
    
    RUN som.p(INPUT "music\click.wav").
    DELETE nivel-projeto.
    APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* OK */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND CURRENT nivel-projeto EXCLUSIVE-LOCK.
    ASSIGN INPUT FRAME default-frame nivel-projeto.ds-nivel.
    APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nivel-projeto.cd-nivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.cd-nivel C-Win
ON ENTRY OF nivel-projeto.cd-nivel IN FRAME DEFAULT-FRAME /* C¢digo N¡vel */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.cd-nivel C-Win
ON LEAVE OF nivel-projeto.cd-nivel IN FRAME DEFAULT-FRAME /* C¢digo N¡vel */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nivel-projeto.ds-nivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.ds-nivel C-Win
ON ENTRY OF nivel-projeto.ds-nivel IN FRAME DEFAULT-FRAME /* Descri‡Æo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.ds-nivel C-Win
ON LEAVE OF nivel-projeto.ds-nivel IN FRAME DEFAULT-FRAME /* Descri‡Æo */
DO:
    {func\set_leave.i}    
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

ASSIGN ds-projeto = projeto.ds-projeto
       ds-pai     = bfNivel.ds-nivel.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i subniv}
  RUN enable_UI.
  RUN initialize.
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
  DISPLAY ds-projeto ds-pai 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE nivel-projeto THEN 
    DISPLAY nivel-projeto.cd-projeto nivel-projeto.nivel-pai 
          nivel-projeto.cd-nivel nivel-projeto.ds-nivel 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 nivel-projeto.ds-nivel btOK btCan 
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

DISPLAY nivel-projeto.nivel-pai
        nivel-projeto.cd-nivel WITH FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

