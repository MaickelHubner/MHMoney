&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

/* Pr‚-processadores */
&GLOBAL-DEFINE Table         usuario
&GLOBAL-DEFINE Filho         ped-exec
&GLOBAL-DEFINE ParentFields  usuario.nome
&GLOBAL-DEFINE KeyFields     usuario.nome

DEFINE NEW GLOBAL shared VARIABLE gcUsuario AS CHARACTER  NO-UNDO.

{func\definitions.i}

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

FIND FIRST usuario NO-LOCK
    WHERE usuario.nome = gcUsuario.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-ped

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ped-exec

/* Definitions for BROWSE br-ped                                        */
&Scoped-define FIELDS-IN-QUERY-br-ped ped-exec.sequencia ~
ped-exec.ds-pedido-exec ped-exec.dt-pedido-exec ped-exec.hr-pedido-exec 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-ped 
&Scoped-define QUERY-STRING-br-ped FOR EACH ped-exec NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-ped OPEN QUERY br-ped FOR EACH ped-exec NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-ped ped-exec
&Scoped-define FIRST-TABLE-IN-QUERY-br-ped ped-exec


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-ped}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br-ped btExec btAdd-page1 btDel-page1 ~
btUpdate-page1 

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

DEFINE BUTTON btExec 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Exec" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar agora".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-ped FOR 
      ped-exec SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-ped
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-ped C-Win _STRUCTURED
  QUERY br-ped NO-LOCK DISPLAY
      ped-exec.sequencia FORMAT ">>>>>>9":U
      ped-exec.ds-pedido-exec FORMAT "x(40)":U
      ped-exec.dt-pedido-exec FORMAT "99/99/9999":U
      ped-exec.hr-pedido-exec FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 56 BY 13.5
         FONT 1
         TITLE "Pedidos Agendados".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-ped AT ROW 1.25 COL 2 WIDGET-ID 200
     btExec AT ROW 14.83 COL 20.43 WIDGET-ID 10
     btAdd-page1 AT ROW 14.83 COL 2 WIDGET-ID 2
     btDel-page1 AT ROW 14.83 COL 14.29 WIDGET-ID 4
     btUpdate-page1 AT ROW 14.83 COL 8.14 WIDGET-ID 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 57.86 BY 16
         FONT 1 WIDGET-ID 100.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 16
         WIDTH              = 57.86
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 114.57
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 114.57
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* BROWSE-TAB br-ped 1 DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-ped
/* Query rebuild information for BROWSE br-ped
     _TblList          = "money.ped-exec"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = money.ped-exec.sequencia
     _FldNameList[2]   = money.ped-exec.ds-pedido-exec
     _FldNameList[3]   = money.ped-exec.dt-pedido-exec
     _FldNameList[4]   = money.ped-exec.hr-pedido-exec
     _Query            is OPENED
*/  /* BROWSE br-ped */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 15
       COLUMN          = 51
       HEIGHT          = 1.5
       WIDTH           = 5.29
       WIDGET-ID       = 8
       HIDDEN          = yes
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {F0B88A90-F5DA-11CF-B545-0020AF6ED35A} type: PSTimer */
      CtrlFrame:MOVE-AFTER(br-ped:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    {func\bt_add_page.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    {func\bt_del_page.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btExec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExec C-Win
ON CHOOSE OF btExec IN FRAME DEFAULT-FRAME /* Exec */
DO:
    IF AVAIL ped-exec THEN DO:
        SESSION:SET-WAIT-STATE("GENERAL").
        RUN VALUE(ped-exec.ds-caminho) NO-ERROR.
        SESSION:SET-WAIT-STATE("").
        FIND CURRENT ped-exec EXCLUSIVE-LOCK.
        ASSIGN ped-exec.dt-pedido-exec = TODAY
               ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").
        RELEASE ped-exec.
        {&OPEN-QUERY-{&BROWSE-NAME}}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    {func\bt_update_page.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame C-Win OCX.Tick
PROCEDURE CtrlFrame.PSTimer.Tick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTick AS DATE    NO-UNDO.
    DEFINE VARIABLE hrTick AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE iMinPed AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMinTic AS INTEGER       NO-UNDO.

    ASSIGN dtTick = TODAY
           hrTick = STRING(TIME, "HH:MM:SS").

    FOR EACH ped-exec EXCLUSIVE-LOCK:

        CASE ped-exec.tipo-periodo:
            WHEN 1 /* Mensal */ THEN DO:
                IF MONTH(ped-exec.dt-pedido-exec) <> MONTH(dtTick) 
                AND hrTick >= ped-exec.hr-pedido-exec THEN DO:
                    SESSION:SET-WAIT-STATE("GENERAL").
                    RUN VALUE(ped-exec.ds-caminho) NO-ERROR.
                    SESSION:SET-WAIT-STATE("").
                    ASSIGN ped-exec.dt-pedido-exec = TODAY
                           ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").
                END.
            END.
            WHEN 2 /* Semanal */ THEN DO:
                IF ped-exec.dt-pedido-exec + 7 <= dtTick 
                AND hrTick >= ped-exec.hr-pedido-exec THEN DO:
                    SESSION:SET-WAIT-STATE("GENERAL").
                    RUN VALUE(ped-exec.ds-caminho) NO-ERROR.
                    SESSION:SET-WAIT-STATE("").
                    ASSIGN ped-exec.dt-pedido-exec = TODAY
                           ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").
                END.
            END.
            WHEN 3 /* Diario */ THEN DO:
                IF ped-exec.dt-pedido-exec < dtTick 
                AND hrTick >= ped-exec.hr-pedido-exec
                AND WEEKDAY(dtTick) > 1 /*Domingo*/
                AND WEEKDAY(dtTick) < 7 /*S bado*/ THEN DO:
                    SESSION:SET-WAIT-STATE("GENERAL").
                    RUN VALUE(ped-exec.ds-caminho) NO-ERROR.
                    SESSION:SET-WAIT-STATE("").
                    ASSIGN ped-exec.dt-pedido-exec = TODAY
                           ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").
                END.
            END.
            WHEN 4 /* Hora */ THEN DO:
                IF INT(SUBSTRING(ped-exec.hr-pedido-exec, 1, 2)) + ped-exec.num-periodo < INT(SUBSTRING(hrTick, 1, 2)) THEN DO:
                    SESSION:SET-WAIT-STATE("GENERAL").
                    RUN VALUE(ped-exec.ds-caminho) NO-ERROR.
                    SESSION:SET-WAIT-STATE("").
                    ASSIGN ped-exec.dt-pedido-exec = TODAY
                           ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").
                END.
            END.
            WHEN 5 /* Minuto */ THEN DO:
                ASSIGN iMinPed = (INT(SUBSTRING(ped-exec.hr-pedido-exec, 1, 2)) * 60) + INT(SUBSTRING(ped-exec.hr-pedido-exec, 4, 2)) + ped-exec.num-periodo
                       iMinTic = (INT(SUBSTRING(hrTick, 1, 2)) * 60) + INT(SUBSTRING(hrTick, 4, 2)).
                IF ped-exec.dt-pedido-exec < dtTick 
                OR iMinPed <= iMinTic THEN DO:
                    SESSION:SET-WAIT-STATE("GENERAL").
                    RUN VALUE(ped-exec.ds-caminho) NO-ERROR.
                    SESSION:SET-WAIT-STATE("").
                    ASSIGN ped-exec.dt-pedido-exec = TODAY
                           ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").
                END.
            END.
        END CASE.

    END.

    {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-ped
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
  {version.i monitor}
  RUN enable_UI.
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

OCXFile = SEARCH( "monitor.wrx":U ).
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
ELSE MESSAGE "monitor.wrx":U SKIP(1)
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
  ENABLE br-ped btExec btAdd-page1 btDel-page1 btUpdate-page1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

