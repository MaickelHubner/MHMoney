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

{func\tt_info.i}

/* Parameters Definitions ---                                           */
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR tt-info.

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE qh   AS WIDGET-HANDLE.
DEFINE VARIABLE cQuery AS CHARACTER  NO-UNDO.
DEFINE VARIABLE bh AS WIDGET-HANDLE.
DEFINE VARIABLE fh AS WIDGET-HANDLE.
DEFINE NEW GLOBAL SHARED VARIABLE glImplantar AS LOGICAL    NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brInfo

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-info

/* Definitions for BROWSE brInfo                                        */
&Scoped-define FIELDS-IN-QUERY-brInfo tt-info.campo tt-info.valor tt-info.descricao   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInfo tt-info.valor   
&Scoped-define ENABLED-TABLES-IN-QUERY-brInfo tt-info
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-brInfo tt-info
&Scoped-define SELF-NAME brInfo
&Scoped-define QUERY-STRING-brInfo FOR EACH tt-info
&Scoped-define OPEN-QUERY-brInfo OPEN QUERY {&SELF-NAME} FOR EACH tt-info.
&Scoped-define TABLES-IN-QUERY-brInfo tt-info
&Scoped-define FIRST-TABLE-IN-QUERY-brInfo tt-info


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brInfo}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brInfo btOK btCancel 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Go" 
     SIZE 6.14 BY 1.79 TOOLTIP "OK".

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInfo FOR 
      tt-info SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInfo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInfo C-Win _FREEFORM
  QUERY brInfo DISPLAY
      tt-info.campo
 tt-info.valor
 tt-info.descricao
 ENABLE
 tt-info.valor
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS NO-SCROLLBAR-VERTICAL SIZE 58 BY 4.75
         FONT 7.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     brInfo AT ROW 1.5 COL 3
     btOK AT ROW 6.5 COL 49
     btCancel AT ROW 6.5 COL 55.14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 61.43 BY 7.54
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
         TITLE              = "Informa‡äes Adicionais"
         HEIGHT             = 7.54
         WIDTH              = 61.43
         MAX-HEIGHT         = 7.54
         MAX-WIDTH          = 61.43
         VIRTUAL-HEIGHT     = 7.54
         VIRTUAL-WIDTH      = 61.43
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
                                                                        */
/* BROWSE-TAB brInfo 1 DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInfo
/* Query rebuild information for BROWSE brInfo
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-info.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brInfo */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Informa‡äes Adicionais */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Informa‡äes Adicionais */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInfo
&Scoped-define SELF-NAME brInfo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInfo C-Win
ON ROW-DISPLAY OF brInfo IN FRAME DEFAULT-FRAME
DO:
  
    IF tt-info.valor <> "" THEN
        APPLY "LEAVE" TO tt-info.valor IN BROWSE brInfo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN "NOK".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* Go */
DO:
    RUN som.p(INPUT "music\click.wav").
    ASSIGN INPUT BROWSE brInfo tt-info.valor tt-info.descricao.    
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN "OK".
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

ON 'LEAVE':U OF tt-info.valor IN BROWSE brInfo
DO:
    ASSIGN INPUT BROWSE brInfo tt-info.valor.
    IF tt-info.tabela <> "" THEN DO:
        IF tt-info.valor <> "" THEN DO:
            CREATE QUERY qh.
            CREATE BUFFER bh FOR TABLE tt-info.tabela.
            qh:SET-BUFFERS(bh).
            ASSIGN cQuery = "FOR EACH " + tt-info.tabela + " NO-LOCK WHERE " + tt-info.tabela + "." +
                              tt-info.campo-proc + " = " + tt-info.valor.
            qh:QUERY-PREPARE(cQuery).
            qh:QUERY-OPEN.
            qh:GET-FIRST.

            IF NOT qh:QUERY-OFF-END THEN DO:
                fh = bh:BUFFER-FIELD(tt-info.campo-desc).
                ASSIGN tt-info.descricao = STRING(fh:BUFFER-VALUE).
                DISP tt-info.descricao WITH BROWSE brInfo NO-ERROR.
                DELETE WIDGET bh.
            END.
            ELSE DO:
                ASSIGN tt-info.descricao = "".
                DISP tt-info.descricao WITH BROWSE brInfo NO-ERROR.
            END.
        END.
        ELSE DO:
            ASSIGN tt-info.descricao = "".
            DISP tt-info.descricao WITH BROWSE brInfo NO-ERROR.
        END.
    END.
END.

ON F5 OF tt-info.valor IN BROWSE brInfo
OR 'MOUSE-SELECT-DBLCLICK' OF tt-info.valor IN BROWSE brInfo
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    DEFINE VARIABLE cProg AS CHARACTER  NO-UNDO.

    IF tt-info.tabela <> "" THEN DO:
        ASSIGN glImplantar = YES
               cProg = "zoom\z" + tt-info.tabela + ".w".
        {func\run.i &Programa = "VALUE(cProg) (OUTPUT rReturn)"}

        IF RETURN-VALUE = "OK" THEN DO:
            CREATE QUERY qh.
            CREATE BUFFER bh FOR TABLE tt-info.tabela.
            qh:SET-BUFFERS(bh).
            ASSIGN cQuery = "FOR EACH " + tt-info.tabela + " NO-LOCK WHERE STRING(ROWID(" + tt-info.tabela + ")) = ~"" + STRING(rReturn) + "~"".
            qh:QUERY-PREPARE(cQuery).
            qh:QUERY-OPEN.
            qh:GET-FIRST.

            fh = bh:BUFFER-FIELD(tt-info.campo-proc).
            ASSIGN tt-info.valor = STRING(fh:BUFFER-VALUE).
            DISP tt-info.valor WITH BROWSE brInfo.
            DELETE WIDGET bh.
        END.
    END.

END.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
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
  ENABLE brInfo btOK btCancel 
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

