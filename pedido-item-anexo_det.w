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
&GLOBAL-DEFINE Table        pedido-item-anexo
&GLOBAL-DEFINE Parent       pedido-item
&GLOBAL-DEFINE KeyFields    pedido-item-anexo.nr-anexo
&GLOBAL-DEFINE FrameFields  pedido-item-anexo.ds-arquivo pedido-item-anexo.ds-sub-pasta ~
                            pedido-item-anexo.ds-observacao
&GLOBAL-DEFINE FrameDisp    pedido-item.nr-pedido pedido-item.sequencia

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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES pedido-item-anexo pedido pedido-item

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME pedido-item.nr-pedido ~
pedido-item.sequencia pedido-item-anexo.nr-anexo ~
pedido-item-anexo.ds-arquivo pedido-item-anexo.ds-sub-pasta ~
pedido-item-anexo.ds-observacao 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME pedido-item.nr-pedido ~
pedido-item.sequencia pedido-item-anexo.nr-anexo ~
pedido-item-anexo.ds-arquivo pedido-item-anexo.ds-sub-pasta ~
pedido-item-anexo.ds-observacao 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME pedido-item ~
pedido-item-anexo
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME pedido-item
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME pedido-item-anexo
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH pedido-item-anexo SHARE-LOCK, ~
      EACH pedido OF pedido-item-anexo SHARE-LOCK, ~
      EACH pedido-item OF pedido-item-anexo SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH pedido-item-anexo SHARE-LOCK, ~
      EACH pedido OF pedido-item-anexo SHARE-LOCK, ~
      EACH pedido-item OF pedido-item-anexo SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME pedido-item-anexo pedido ~
pedido-item
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME pedido-item-anexo
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define THIRD-TABLE-IN-QUERY-DEFAULT-FRAME pedido-item


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS pedido-item.nr-pedido pedido-item.sequencia ~
pedido-item-anexo.nr-anexo pedido-item-anexo.ds-arquivo ~
pedido-item-anexo.ds-sub-pasta pedido-item-anexo.ds-observacao 
&Scoped-define ENABLED-TABLES pedido-item pedido-item-anexo
&Scoped-define FIRST-ENABLED-TABLE pedido-item
&Scoped-define SECOND-ENABLED-TABLE pedido-item-anexo
&Scoped-Define ENABLED-OBJECTS RECT-2 
&Scoped-Define DISPLAYED-FIELDS pedido-item.nr-pedido pedido-item.sequencia ~
pedido-item-anexo.nr-anexo pedido-item-anexo.ds-arquivo ~
pedido-item-anexo.ds-sub-pasta pedido-item-anexo.ds-observacao 
&Scoped-define DISPLAYED-TABLES pedido-item pedido-item-anexo
&Scoped-define FIRST-DISPLAYED-TABLE pedido-item
&Scoped-define SECOND-DISPLAYED-TABLE pedido-item-anexo


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

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      pedido-item-anexo, 
      pedido, 
      pedido-item SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btSearch AT ROW 3.75 COL 73 WIDGET-ID 20
     pedido-item.nr-pedido AT ROW 1.5 COL 27 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     btCancel AT ROW 10.75 COL 74.14
     pedido-item.sequencia AT ROW 1.5 COL 46 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     pedido-item-anexo.nr-anexo AT ROW 3.25 COL 12 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     pedido-item-anexo.ds-arquivo AT ROW 4.25 COL 12 COLON-ALIGNED WIDGET-ID 12 FORMAT "x(200)"
          VIEW-AS FILL-IN 
          SIZE 58.29 BY .79
     pedido-item-anexo.ds-sub-pasta AT ROW 5.25 COL 12 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 15.43 BY .79
     pedido-item-anexo.ds-observacao AT ROW 6.25 COL 14 NO-LABEL WIDGET-ID 46
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 58 BY 4
     btOK AT ROW 10.75 COL 68
     "Observaá∆o:" VIEW-AS TEXT
          SIZE 9 BY .54 AT ROW 6.25 COL 5 WIDGET-ID 54
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
/* SETTINGS FOR FILL-IN pedido-item-anexo.ds-arquivo IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
ASSIGN 
       pedido-item-anexo.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.pedido-item-anexo,money.pedido OF money.pedido-item-anexo,money.pedido-item OF money.pedido-item-anexo"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
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
          TITLE      "Procurar Anexo"
          FILTERS    "Todos os Arquivos"      "*.*"
          MUST-EXIST
          USE-FILENAME
          INITIAL-DIR "\\10.0.0.101\Comercial"
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:
        ASSIGN pedido-item-anexo.ds-arquivo:SCREEN-VALUE = procname.
        APPLY "ENTRY" TO pedido-item-anexo.ds-arquivo.
    END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item-anexo.ds-arquivo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.ds-arquivo C-Win
ON ENTRY OF pedido-item-anexo.ds-arquivo IN FRAME DEFAULT-FRAME /* Arquivo */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.ds-arquivo C-Win
ON LEAVE OF pedido-item-anexo.ds-arquivo IN FRAME DEFAULT-FRAME /* Arquivo */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item-anexo.ds-observacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.ds-observacao C-Win
ON ENTRY OF pedido-item-anexo.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.ds-observacao C-Win
ON LEAVE OF pedido-item-anexo.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item-anexo.ds-sub-pasta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.ds-sub-pasta C-Win
ON ENTRY OF pedido-item-anexo.ds-sub-pasta IN FRAME DEFAULT-FRAME /* Sub-Pasta */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.ds-sub-pasta C-Win
ON LEAVE OF pedido-item-anexo.ds-sub-pasta IN FRAME DEFAULT-FRAME /* Sub-Pasta */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item-anexo.nr-anexo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.nr-anexo C-Win
ON ENTRY OF pedido-item-anexo.nr-anexo IN FRAME DEFAULT-FRAME /* Anexo */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item-anexo.nr-anexo C-Win
ON LEAVE OF pedido-item-anexo.nr-anexo IN FRAME DEFAULT-FRAME /* Anexo */
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
  {version.i pedido-item-anexo_det}
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

    DEFINE VARIABLE cCaminho AS CHARACTER   NO-UNDO.

    ASSIGN pedido-item-anexo.ds-arquivo = REPLACE(pedido-item-anexo.ds-arquivo, "/", "\").

    FIND FIRST param-mn NO-LOCK NO-ERROR.
    IF param-mn.caminho-anexos <> "" THEN DO:

        ASSIGN cCaminho = param-mn.caminho-anexos.

        FIND FIRST pedido OF pedido-item NO-LOCK NO-ERROR.
        ASSIGN cCaminho = cCaminho + "\" + STRING(pedido.cd-favorecido, "9999").

        IF SEARCH(cCaminho) = ? THEN
            OS-CREATE-DIR VALUE(cCaminho).

        IF pedido.num-cliente <> "" THEN
            ASSIGN cCaminho = cCaminho + "\" + pedido.num-cliente.
        ELSE
            ASSIGN cCaminho = cCaminho + "\p" + STRING(pedido.nr-pedido, "99999").

            IF SEARCH(cCaminho) = ? THEN
                OS-CREATE-DIR VALUE(cCaminho).

        IF pedido-item-anexo.ds-sub-pasta <> "" THEN
            ASSIGN cCaminho = cCaminho + "\" + pedido-item-anexo.ds-sub-pasta.

        IF SEARCH(cCaminho) = ? THEN
            OS-CREATE-DIR VALUE(cCaminho).

        ASSIGN cCaminho = cCaminho + "\" + ENTRY(NUM-ENTRIES(pedido-item-anexo.ds-arquivo,"\"), pedido-item-anexo.ds-arquivo, "\").

        OS-COPY VALUE(pedido-item-anexo.ds-arquivo) VALUE(cCaminho).

        ASSIGN pedido-item-anexo.ds-arquivo = cCaminho.

    END.

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

    ASSIGN pedido-item-anexo.nr-pedido = pedido-item.nr-pedido
           pedido-item-anexo.sequencia = pedido-item.sequencia.

    FIND LAST bf-pedido-item-anexo OF pedido-item NO-LOCK NO-ERROR.
    IF AVAIL bf-pedido-item-anexo THEN
        ASSIGN pedido-item-anexo.nr-anexo = bf-pedido-item-anexo.nr-anexo + 1.
    ELSE
        ASSIGN pedido-item-anexo.nr-anexo = 1.

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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  IF AVAILABLE pedido-item THEN 
    DISPLAY pedido-item.nr-pedido pedido-item.sequencia 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE pedido-item-anexo THEN 
    DISPLAY pedido-item-anexo.nr-anexo pedido-item-anexo.ds-arquivo 
          pedido-item-anexo.ds-sub-pasta pedido-item-anexo.ds-observacao 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-2 pedido-item.nr-pedido pedido-item.sequencia 
         pedido-item-anexo.nr-anexo pedido-item-anexo.ds-arquivo 
         pedido-item-anexo.ds-sub-pasta pedido-item-anexo.ds-observacao 
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
    FIND FIRST bf-pedido-item-anexo NO-LOCK
        WHERE bf-pedido-item-anexo.nr-pedido = pedido-item.nr-pedido
        AND   bf-pedido-item-anexo.sequencia = pedido-item.sequencia
        AND   bf-pedido-item-anexo.nr-anexo = INPUT FRAME {&FRAME-NAME} pedido-item-anexo.nr-anexo
        AND   ROWID(bf-pedido-item-anexo) <> ROWID(pedido-item-anexo) NO-ERROR.
    IF AVAIL bf-pedido-item-anexo THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:
    IF INPUT FRAME {&FRAME-NAME} pedido-item-anexo.ds-arquivo = "" THEN DO:
        {func\valida.i &Mensagem  = "Arquivo n∆o informado!"
                       &Ajuda     = "Vocà deve informar um arquivo para ser anexado ao item."
                       &Campo     = pedido-item-anexo.ds-arquivo}
    END.
    ELSE DO:
        IF SEARCH(INPUT FRAME {&FRAME-NAME} pedido-item-anexo.ds-arquivo) = ? THEN DO:
            {func\valida.i &Mensagem  = "Arquivo n∆o existente!"
                           &Ajuda     = "N∆o existe o arquivo informado."
                           &Campo     = pedido-item-anexo.ds-arquivo}
        END.
    END.
END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

