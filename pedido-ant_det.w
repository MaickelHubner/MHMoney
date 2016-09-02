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
DEFINE BUFFER bf-ped-pai FOR pedido.

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        pedido
&GLOBAL-DEFINE Parent       bf-ped-pai
&GLOBAL-DEFINE ParentField  nr-pedido-ant
&GLOBAL-DEFINE KeyFields    pedido.nr-pedido 
&GLOBAL-DEFINE FrameFields  pedido.dt-pedido pedido.val-total ~
                            pedido.dt-previsao-fat
&GLOBAL-DEFINE FrameDisp    pedido.nom-projeto

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.

/*DEF VAR i-nr-pedido-ant LIKE pedido.nr-pedido.
DEF VAR i-nr-pedido     LIKE pedido.nr-pedido.
DEF VAR v-dt-pedido     LIKE pedido.dt-pedido.
DEF VAR de-val-total    LIKE pedido.val-total.
DEF VAR c-nom-projeto   LIKE pedido.nom-projeto.*/
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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES pedido

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME pedido.nr-pedido-ant ~
pedido.nr-pedido pedido.dt-pedido pedido.val-total pedido.nom-projeto ~
pedido.dt-previsao-fat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME pedido.nr-pedido-ant ~
pedido.nr-pedido pedido.dt-pedido pedido.val-total pedido.nom-projeto ~
pedido.dt-previsao-fat 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH pedido ~
      WHERE pedido.nr-pedido = giNr-pedido SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH pedido ~
      WHERE pedido.nr-pedido = giNr-pedido SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME pedido


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS pedido.nr-pedido-ant pedido.nr-pedido ~
pedido.dt-pedido pedido.val-total pedido.nom-projeto pedido.dt-previsao-fat 
&Scoped-define ENABLED-TABLES pedido
&Scoped-define FIRST-ENABLED-TABLE pedido
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-7 
&Scoped-Define DISPLAYED-FIELDS pedido.nr-pedido-ant pedido.nr-pedido ~
pedido.dt-pedido pedido.val-total pedido.nom-projeto pedido.dt-previsao-fat 
&Scoped-define DISPLAYED-TABLES pedido
&Scoped-define FIRST-DISPLAYED-TABLE pedido


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

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.5.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      pedido SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 6.21 COL 74
     pedido.nr-pedido-ant AT ROW 1.5 COL 16 COLON-ALIGNED WIDGET-ID 48
          VIEW-AS FILL-IN 
          SIZE 8 BY .88
     pedido.nr-pedido AT ROW 2.5 COL 16 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 8 BY .88
     btOK AT ROW 6.21 COL 67.86
     pedido.dt-pedido AT ROW 4.04 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 10 BY .88
     pedido.val-total AT ROW 5.04 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 46
          VIEW-AS FILL-IN 
          SIZE 10 BY .88
     pedido.nom-projeto AT ROW 1.5 COL 24 COLON-ALIGNED NO-LABEL WIDGET-ID 52
          VIEW-AS FILL-IN 
          SIZE 52 BY .88
     pedido.dt-previsao-fat AT ROW 4.08 COL 44 COLON-ALIGNED WIDGET-ID 60
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     "Data Antecipaá∆o:" VIEW-AS TEXT
          SIZE 13 BY .54 AT ROW 4.21 COL 4.86 WIDGET-ID 56
     "Valor Antecipaá∆o:" VIEW-AS TEXT
          SIZE 13 BY .54 AT ROW 5.21 COL 4.86 WIDGET-ID 58
     RECT-2 AT ROW 1.25 COL 2
     RECT-7 AT ROW 3.83 COL 2 WIDGET-ID 32
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.17
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
         HEIGHT             = 7.17
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
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.pedido"
     _Where[1]         = "pedido.nr-pedido = giNr-pedido"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Detalhe */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:

    FIND FIRST bf-pedido EXCLUSIVE-LOCK
         WHERE bf-pedido.nr-pedido = 0 NO-ERROR.
    IF AVAIL bf-pedido THEN
        DELETE bf-pedido.

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


&Scoped-define SELF-NAME pedido.dt-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-pedido C-Win
ON ENTRY OF pedido.dt-pedido IN FRAME DEFAULT-FRAME /* Dt Pedido */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-pedido C-Win
ON LEAVE OF pedido.dt-pedido IN FRAME DEFAULT-FRAME /* Dt Pedido */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.dt-previsao-fat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-previsao-fat C-Win
ON ENTRY OF pedido.dt-previsao-fat IN FRAME DEFAULT-FRAME /* Data Previs∆o Fat */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-previsao-fat C-Win
ON LEAVE OF pedido.dt-previsao-fat IN FRAME DEFAULT-FRAME /* Data Previs∆o Fat */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.nr-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.nr-pedido C-Win
ON ENTRY OF pedido.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
  {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.nr-pedido C-Win
ON LEAVE OF pedido.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
  {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.nr-pedido-ant
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.nr-pedido-ant C-Win
ON ENTRY OF pedido.nr-pedido-ant IN FRAME DEFAULT-FRAME /* Pedido Ant */
DO:
  {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.nr-pedido-ant C-Win
ON LEAVE OF pedido.nr-pedido-ant IN FRAME DEFAULT-FRAME /* Pedido Ant */
DO:
    FIND FIRST bf-pedido NO-LOCK
         WHERE bf-pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido-ant NO-ERROR.
    IF AVAIL bf-pedido THEN
        ASSIGN pedido.nom-projeto:SCREEN-VALUE IN FRAME {&FRAME-NAME}   = bf-pedido.nom-projeto.
    ELSE
        ASSIGN pedido.nom-projeto:SCREEN-VALUE IN FRAME {&FRAME-NAME}   = "".

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
  {version.i pedido-ant_det}      
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

    BUFFER-COPY bf-ped-pai EXCEPT nr-pedido dt-pedido val-total dt-previsao-fat nr-pedido-ant TO pedido.
        
    ASSIGN pedido.situacao      = 3 /* atendido */
           pedido.pc-impt       = 0
           pedido.val-itens     = 0
           pedido.val-impostos  = 0
           pedido.val-desconto  = 0.
    
    RETURN "OK".

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

    ASSIGN pedido.nr-pedido-ant = bf-ped-pai.nr-pedido.
    
    FIND LAST bf-pedido NO-LOCK NO-ERROR.
    IF AVAIL bf-pedido THEN
        ASSIGN pedido.nr-pedido = bf-pedido.nr-pedido + 1.
    ELSE
        ASSIGN pedido.nr-pedido = 1.

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

APPLY 'leave' TO pedido.nr-pedido-ant IN FRAME {&FRAME-NAME}.

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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  IF AVAILABLE pedido THEN 
    DISPLAY pedido.nr-pedido-ant pedido.nr-pedido pedido.dt-pedido 
          pedido.val-total pedido.nom-projeto pedido.dt-previsao-fat 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE pedido.nr-pedido-ant pedido.nr-pedido pedido.dt-pedido 
         pedido.val-total pedido.nom-projeto pedido.dt-previsao-fat RECT-2 
         RECT-7 
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

DEF VAR tot-val-antecip LIKE pedido.val-total.

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    IF CAN-FIND(FIRST bf-pedido NO-LOCK
                WHERE bf-pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido
                AND ROWID(bf-pedido) <> ROWID(pedido)) THEN DO:   
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
    
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:

    /** validar valor informado **/
    FIND FIRST bf-pedido NO-LOCK
         WHERE bf-pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido-ant NO-ERROR.

    IF INPUT FRAME {&FRAME-NAME} pedido.val-total > bf-pedido.val-total THEN DO:    
        {func\valida.i &Mensagem  = "Valor incorreto!"
                       &Ajuda     = "O valor da antecipaá∆o Ç maior que o valor total do pedido."
                       &Campo     = pedido.val-total}
    END.
    
    ASSIGN tot-val-antecip = 0.
    FOR EACH bf-pedido NO-LOCK
       WHERE bf-pedido.nr-pedido-ant = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido-ant:

        IF pcActionBT = "ADD" THEN
            ASSIGN tot-val-antecip = tot-val-antecip + bf-pedido.val-total.
        ELSE DO:
            IF bf-pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido THEN NEXT.
            ASSIGN tot-val-antecip = tot-val-antecip + bf-pedido.val-total.
        END.
    END.
    ASSIGN tot-val-antecip = tot-val-antecip + INPUT FRAME {&FRAME-NAME} pedido.val-total.

    FIND FIRST bf-pedido NO-LOCK
         WHERE bf-pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido-ant NO-ERROR.
    IF tot-val-antecip > bf-pedido.val-total THEN DO:
        {func\valida.i &Mensagem  = "Valor incorreto!"
                       &Ajuda     = "A soma das antecipaá‰es ultrapassa o valor total do pedido."
                       &Campo     = pedido.val-total}
    END.
    

END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

