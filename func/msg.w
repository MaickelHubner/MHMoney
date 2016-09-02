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

DEFINE INPUT  PARAMETER iTipo AS INTEGER    NO-UNDO.
/* 1 - OK, 2 - Sim/NÆo */
DEFINE INPUT  PARAMETER cTitulo AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER cMensagem AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER cAjuda AS CHARACTER  NO-UNDO.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS EDITOR-1 EDITOR-2 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS EDITOR-1 EDITOR-2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 10 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 10 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE EDITOR-1 AS CHARACTER INITIAL "Mensagem" 
     VIEW-AS EDITOR NO-BOX
     SIZE 48 BY 1
     FGCOLOR 24 FONT 9 NO-UNDO.

DEFINE VARIABLE EDITOR-2 AS CHARACTER INITIAL "Mensagem" 
     VIEW-AS EDITOR
     SIZE 48 BY 3
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     EDITOR-1 AT ROW 1.25 COL 2 NO-LABEL NO-TAB-STOP 
     EDITOR-2 AT ROW 2.5 COL 2 NO-LABEL NO-TAB-STOP 
     Btn_OK AT ROW 5.75 COL 2
     Btn_Cancel AT ROW 5.75 COL 12
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 50 BY 5.75.


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
         TITLE              = "Mensagem"
         HEIGHT             = 5.75
         WIDTH              = 50
         MAX-HEIGHT         = 29.75
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 29.75
         VIRTUAL-WIDTH      = 146.29
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = yes
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         TOP-ONLY           = yes
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
ASSIGN 
       EDITOR-1:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE
       EDITOR-1:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       EDITOR-2:MANUAL-HIGHLIGHT IN FRAME DEFAULT-FRAME = TRUE
       EDITOR-2:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE
       EDITOR-2:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Mensagem */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Mensagem */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN "NOK":U.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME DEFAULT-FRAME /* OK */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN "OK":U.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME EDITOR-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL EDITOR-1 C-Win
ON MOUSE-SELECT-CLICK OF EDITOR-1 IN FRAME DEFAULT-FRAME
DO:
    APPLY "ENTRY" TO Btn_OK.  
    editor-1:CLEAR-SELECTION().  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL EDITOR-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF EDITOR-1 IN FRAME DEFAULT-FRAME
DO:
    APPLY "ENTRY" TO Btn_OK.  
    editor-1:CLEAR-SELECTION().    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME EDITOR-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL EDITOR-2 C-Win
ON MOUSE-SELECT-CLICK OF EDITOR-2 IN FRAME DEFAULT-FRAME
DO:
    APPLY "ENTRY" TO Btn_OK.  
    editor-2:CLEAR-SELECTION().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL EDITOR-2 C-Win
ON MOUSE-SELECT-DBLCLICK OF EDITOR-2 IN FRAME DEFAULT-FRAME
DO:
    APPLY "ENTRY" TO Btn_OK.  
    editor-2:CLEAR-SELECTION().
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
  RUN enable_UI.
  RUN initialize.
  RUN som.p(INPUT "").
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
  DISPLAY EDITOR-1 EDITOR-2 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE EDITOR-1 EDITOR-2 Btn_OK Btn_Cancel 
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

ASSIGN C-Win:TITLE = cTitulo
       editor-1:SCREEN-VALUE IN FRAME {&FRAME-NAME} = cMensagem
       editor-2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = cAjuda.

CASE iTipo:
    WHEN 1 THEN DO:
        ASSIGN Btn_OK:LABEL = "OK"
               Btn_OK:COLUMN = 20.
        HIDE Btn_Cancel.
        VIEW Btn_OK.
    END.
    WHEN 2 THEN DO:
        ASSIGN Btn_OK:LABEL = "Sim"
               Btn_OK:COLUMN = 14.9
               Btn_Cancel:LABEL = "NÆo"
               Btn_Cancel:COLUMN = 25.1.
        VIEW Btn_Cancel.
        VIEW Btn_OK.
    END.
END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

