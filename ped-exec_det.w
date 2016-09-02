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

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        ped-exec
&GLOBAL-DEFINE Parent       usuario
&GLOBAL-DEFINE KeyFields    ped-exec.sequencia
&GLOBAL-DEFINE FrameFields  ped-exec.nome ped-exec.dt-pedido-exec ~
                            ped-exec.hr-pedido-exec ped-exec.ds-pedido-exec ~
                            ped-exec.ds-caminho ped-exec.tipo-periodo ~
                            ped-exec.num-periodo
&GLOBAL-DEFINE FrameDisp    

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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS ped-exec.sequencia ped-exec.nome ~
ped-exec.dt-pedido-exec ped-exec.hr-pedido-exec ped-exec.ds-pedido-exec ~
ped-exec.ds-caminho ped-exec.num-periodo ped-exec.tipo-periodo 
&Scoped-define ENABLED-TABLES ped-exec
&Scoped-define FIRST-ENABLED-TABLE ped-exec
&Scoped-Define ENABLED-OBJECTS RECT-2 
&Scoped-Define DISPLAYED-FIELDS ped-exec.sequencia ped-exec.nome ~
ped-exec.dt-pedido-exec ped-exec.hr-pedido-exec ped-exec.ds-pedido-exec ~
ped-exec.ds-caminho ped-exec.num-periodo ped-exec.tipo-periodo 
&Scoped-define DISPLAYED-TABLES ped-exec
&Scoped-define FIRST-DISPLAYED-TABLE ped-exec


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
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE BUTTON btSearch 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Procurar".

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     ped-exec.sequencia AT ROW 1.5 COL 12 COLON-ALIGNED WIDGET-ID 58
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btSearch AT ROW 4.75 COL 73 WIDGET-ID 20
     ped-exec.nome AT ROW 3.25 COL 12 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     ped-exec.dt-pedido-exec AT ROW 3.25 COL 54 COLON-ALIGNED WIDGET-ID 60
          LABEL "Èltima Execuá∆o"
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     ped-exec.hr-pedido-exec AT ROW 3.25 COL 64 COLON-ALIGNED NO-LABEL WIDGET-ID 62
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     ped-exec.ds-pedido-exec AT ROW 4.25 COL 12 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 59 BY .79
     ped-exec.ds-caminho AT ROW 5.25 COL 12 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 59 BY .79
     ped-exec.num-periodo AT ROW 6.25 COL 65 COLON-ALIGNED WIDGET-ID 64
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     ped-exec.tipo-periodo AT ROW 6.75 COL 14 NO-LABEL WIDGET-ID 66
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Mensal", 1,
"Semanal", 2,
"Di†rio", 3,
"Hora", 4,
"Minuto", 5
          SIZE 20 BY 5.75
     btCancel AT ROW 10.75 COL 74.14
     btOK AT ROW 10.75 COL 68
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 11.83
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
         TITLE              = "Template Padr∆o de Detalhe"
         HEIGHT             = 11.83
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
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btSearch IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ped-exec.dt-pedido-exec IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Detalhe */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Detalhe */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cad_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cad_ok.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSearch C-Win
ON CHOOSE OF btSearch IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    DEFINE VARIABLE procname  AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    SYSTEM-DIALOG GET-FILE procname
          TITLE      "Procurar Arquivo"
          FILTERS    "Todos os Arquivos"      "*.*"
          MUST-EXIST
          USE-FILENAME
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:
        ASSIGN ped-exec.ds-caminho:SCREEN-VALUE = procname.
        APPLY "ENTRY" TO ped-exec.ds-caminho.
    END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ped-exec.ds-caminho
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-exec.ds-caminho C-Win
ON ENTRY OF ped-exec.ds-caminho IN FRAME DEFAULT-FRAME /* Caminho Arquivo */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-exec.ds-caminho C-Win
ON LEAVE OF ped-exec.ds-caminho IN FRAME DEFAULT-FRAME /* Caminho Arquivo */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ped-exec.ds-pedido-exec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-exec.ds-pedido-exec C-Win
ON ENTRY OF ped-exec.ds-pedido-exec IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-exec.ds-pedido-exec C-Win
ON LEAVE OF ped-exec.ds-pedido-exec IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ped-exec.nome
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-exec.nome C-Win
ON ENTRY OF ped-exec.nome IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-exec.nome C-Win
ON LEAVE OF ped-exec.nome IN FRAME DEFAULT-FRAME /* Nome */
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

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i ped-exec_det}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterAssignFields C-Win 
PROCEDURE afterAssignFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE assignIniFields C-Win 
PROCEDURE assignIniFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND LAST bf-ped-exec OF pedido-item NO-LOCK NO-ERROR.
    IF AVAIL bf-ped-exec THEN
        ASSIGN ped-exec.sequencia = bf-ped-exec.sequencia + 1.
    ELSE
        ASSIGN ped-exec.sequencia = 1.

    ASSIGN ped-exec.nome = gcUsuario
           ped-exec.dt-pedido-exec = TODAY
           ped-exec.hr-pedido-exec = STRING(TIME, "HH:MM:SS").

    RETURN "OK".

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

{func\detalhe\display.i}

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
  IF AVAILABLE ped-exec THEN 
    DISPLAY ped-exec.sequencia ped-exec.nome ped-exec.dt-pedido-exec 
          ped-exec.hr-pedido-exec ped-exec.ds-pedido-exec ped-exec.ds-caminho 
          ped-exec.num-periodo ped-exec.tipo-periodo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 ped-exec.sequencia ped-exec.nome ped-exec.dt-pedido-exec 
         ped-exec.hr-pedido-exec ped-exec.ds-pedido-exec ped-exec.ds-caminho 
         ped-exec.num-periodo ped-exec.tipo-periodo 
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

{func\detalhe\initialize.i}

ENABLE btSearch
    WITH FRAME {&FRAME-NAME}.

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

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-ped-exec NO-LOCK
        WHERE bf-ped-exec.sequencia = INPUT FRAME {&FRAME-NAME} ped-exec.sequencia
        AND   ROWID(bf-ped-exec) <> ROWID(ped-exec) NO-ERROR.
    IF AVAIL bf-ped-exec THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:
    IF INPUT FRAME {&FRAME-NAME} ped-exec.ds-caminho = "" THEN DO:
        {func\valida.i &Mensagem  = "Caminho n∆o informado!"
                       &Ajuda     = "Vocà deve informar um caminho de arquivo a ser executado."
                       &Campo     = ped-exec.ds-caminho}
    END.
    ELSE DO:
        IF SEARCH(INPUT FRAME {&FRAME-NAME} ped-exec.ds-caminho) = ? THEN DO:
            {func\valida.i &Mensagem  = "Caminho n∆o existente!"
                           &Ajuda     = "N∆o existe o caminho informado."
                           &Campo     = ped-exec.ds-caminho}
        END.
    END.
END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

