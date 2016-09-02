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
&GLOBAL-DEFINE Table        parc-nota-fiscal
&GLOBAL-DEFINE Parent       nota-fiscal
&GLOBAL-DEFINE ParentField  nr-controle
&GLOBAL-DEFINE KeyFields    parc-nota-fiscal.sequencia
&GLOBAL-DEFINE FrameFields  parc-nota-fiscal.dt-parcela parc-nota-fiscal.val-parcela ~
                            parc-nota-fiscal.situacao parc-nota-fiscal.cd-conta ~
                            parc-nota-fiscal.cd-sequencia parc-nota-fiscal.dt-pagto-parc
&GLOBAL-DEFINE FrameDisp    nota-fiscal.cd-favorecido favorecido.ds-favorecido

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
&Scoped-define INTERNAL-TABLES tabela-preco-item pedido favorecido ~
nota-fiscal parc-nota-fiscal

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME parc-nota-fiscal.situacao ~
parc-nota-fiscal.nr-controle nota-fiscal.cd-favorecido ~
favorecido.ds-favorecido parc-nota-fiscal.sequencia ~
parc-nota-fiscal.dt-parcela parc-nota-fiscal.val-parcela ~
parc-nota-fiscal.cd-conta parc-nota-fiscal.cd-sequencia ~
parc-nota-fiscal.dt-pagto-parc 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
parc-nota-fiscal.situacao parc-nota-fiscal.nr-controle ~
nota-fiscal.cd-favorecido favorecido.ds-favorecido ~
parc-nota-fiscal.sequencia parc-nota-fiscal.dt-parcela ~
parc-nota-fiscal.val-parcela parc-nota-fiscal.cd-conta ~
parc-nota-fiscal.cd-sequencia parc-nota-fiscal.dt-pagto-parc 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME parc-nota-fiscal ~
nota-fiscal favorecido
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME parc-nota-fiscal
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME nota-fiscal
&Scoped-define THIRD-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME favorecido
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH tabela-preco-item SHARE-LOCK, ~
      EACH pedido WHERE TRUE /* Join to tabela-preco-item incomplete */ SHARE-LOCK, ~
      EACH favorecido OF pedido SHARE-LOCK, ~
      EACH nota-fiscal OF pedido SHARE-LOCK, ~
      EACH parc-nota-fiscal OF nota-fiscal SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH tabela-preco-item SHARE-LOCK, ~
      EACH pedido WHERE TRUE /* Join to tabela-preco-item incomplete */ SHARE-LOCK, ~
      EACH favorecido OF pedido SHARE-LOCK, ~
      EACH nota-fiscal OF pedido SHARE-LOCK, ~
      EACH parc-nota-fiscal OF nota-fiscal SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME tabela-preco-item pedido ~
favorecido nota-fiscal parc-nota-fiscal
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME tabela-preco-item
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define THIRD-TABLE-IN-QUERY-DEFAULT-FRAME favorecido
&Scoped-define FOURTH-TABLE-IN-QUERY-DEFAULT-FRAME nota-fiscal
&Scoped-define FIFTH-TABLE-IN-QUERY-DEFAULT-FRAME parc-nota-fiscal


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS parc-nota-fiscal.situacao ~
parc-nota-fiscal.nr-controle nota-fiscal.cd-favorecido ~
favorecido.ds-favorecido parc-nota-fiscal.sequencia ~
parc-nota-fiscal.dt-parcela parc-nota-fiscal.val-parcela ~
parc-nota-fiscal.cd-conta parc-nota-fiscal.cd-sequencia ~
parc-nota-fiscal.dt-pagto-parc 
&Scoped-define ENABLED-TABLES parc-nota-fiscal nota-fiscal favorecido
&Scoped-define FIRST-ENABLED-TABLE parc-nota-fiscal
&Scoped-define SECOND-ENABLED-TABLE nota-fiscal
&Scoped-define THIRD-ENABLED-TABLE favorecido
&Scoped-Define ENABLED-OBJECTS des-conta RECT-2 RECT-9 
&Scoped-Define DISPLAYED-FIELDS parc-nota-fiscal.situacao ~
parc-nota-fiscal.nr-controle nota-fiscal.cd-favorecido ~
favorecido.ds-favorecido parc-nota-fiscal.sequencia ~
parc-nota-fiscal.dt-parcela parc-nota-fiscal.val-parcela ~
parc-nota-fiscal.cd-conta parc-nota-fiscal.cd-sequencia ~
parc-nota-fiscal.dt-pagto-parc 
&Scoped-define DISPLAYED-TABLES parc-nota-fiscal nota-fiscal favorecido
&Scoped-define FIRST-DISPLAYED-TABLE parc-nota-fiscal
&Scoped-define SECOND-DISPLAYED-TABLE nota-fiscal
&Scoped-define THIRD-DISPLAYED-TABLE favorecido
&Scoped-Define DISPLAYED-OBJECTS des-conta 

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

DEFINE VARIABLE des-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 2.75.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      tabela-preco-item, 
      pedido, 
      favorecido, 
      nota-fiscal, 
      parc-nota-fiscal SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     des-conta AT ROW 7.25 COL 20 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     parc-nota-fiscal.situacao AT ROW 3.5 COL 53 COLON-ALIGNED WIDGET-ID 48
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Pendente",1,
                     "Liquidada",2
          DROP-DOWN-LIST
          SIZE 16 BY 1
     btCancel AT ROW 9.75 COL 74.14
     btOK AT ROW 9.75 COL 68
     parc-nota-fiscal.nr-controle AT ROW 1.5 COL 16 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 6.86 BY .79
     nota-fiscal.cd-favorecido AT ROW 1.5 COL 31 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     favorecido.ds-favorecido AT ROW 1.5 COL 36 COLON-ALIGNED NO-LABEL WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 33 BY .79
     parc-nota-fiscal.sequencia AT ROW 3.5 COL 16 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     parc-nota-fiscal.dt-parcela AT ROW 4.5 COL 16 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     parc-nota-fiscal.val-parcela AT ROW 5.5 COL 59 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     parc-nota-fiscal.cd-conta AT ROW 7.25 COL 16 COLON-ALIGNED WIDGET-ID 52
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     parc-nota-fiscal.cd-sequencia AT ROW 8.25 COL 16 COLON-ALIGNED WIDGET-ID 54
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     parc-nota-fiscal.dt-pagto-parc AT ROW 5.5 COL 16 COLON-ALIGNED WIDGET-ID 58
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     RECT-2 AT ROW 1.25 COL 2
     RECT-9 AT ROW 6.75 COL 3 WIDGET-ID 50
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 10.75
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
         HEIGHT             = 10.75
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
     _TblList          = "money.tabela-preco-item,money.pedido WHERE money.tabela-preco-item ...,money.favorecido OF money.pedido,money.nota-fiscal OF money.pedido,money.parc-nota-fiscal OF money.nota-fiscal"
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


&Scoped-define SELF-NAME parc-nota-fiscal.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.cd-conta C-Win
ON ENTRY OF parc-nota-fiscal.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.cd-conta C-Win
ON LEAVE OF parc-nota-fiscal.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoProc="ds-conta"
                  &Tela="des-conta"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.cd-conta C-Win
ON MOUSE-SELECT-DBLCLICK OF parc-nota-fiscal.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF {&Table}.cd-conta DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="parc-nota-fiscal.cd-conta"
                 &Campo2="ds-conta"
                 &Tela2="des-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME parc-nota-fiscal.cd-sequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.cd-sequencia C-Win
ON ENTRY OF parc-nota-fiscal.cd-sequencia IN FRAME DEFAULT-FRAME /* Sequencia */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.cd-sequencia C-Win
ON LEAVE OF parc-nota-fiscal.cd-sequencia IN FRAME DEFAULT-FRAME /* Sequencia */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME parc-nota-fiscal.dt-parcela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.dt-parcela C-Win
ON ENTRY OF parc-nota-fiscal.dt-parcela IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.dt-parcela C-Win
ON LEAVE OF parc-nota-fiscal.dt-parcela IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_leave.i}
    IF INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.dt-pagto-parc = ? THEN
        ASSIGN parc-nota-fiscal.dt-pagto-parc:SCREEN-VALUE = parc-nota-fiscal.dt-parcela:SCREEN-VALUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME parc-nota-fiscal.nr-controle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.nr-controle C-Win
ON ENTRY OF parc-nota-fiscal.nr-controle IN FRAME DEFAULT-FRAME /* Controle */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.nr-controle C-Win
ON LEAVE OF parc-nota-fiscal.nr-controle IN FRAME DEFAULT-FRAME /* Controle */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME parc-nota-fiscal.sequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.sequencia C-Win
ON ENTRY OF parc-nota-fiscal.sequencia IN FRAME DEFAULT-FRAME /* Sequància */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.sequencia C-Win
ON LEAVE OF parc-nota-fiscal.sequencia IN FRAME DEFAULT-FRAME /* Sequància */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME parc-nota-fiscal.situacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.situacao C-Win
ON ENTRY OF parc-nota-fiscal.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.situacao C-Win
ON LEAVE OF parc-nota-fiscal.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.situacao C-Win
ON VALUE-CHANGED OF parc-nota-fiscal.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.situacao = 2 /* Liquidada */ THEN DO:
        ENABLE parc-nota-fiscal.cd-conta
               parc-nota-fiscal.cd-sequencia
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE parc-nota-fiscal.cd-conta
                parc-nota-fiscal.cd-sequencia
            WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME parc-nota-fiscal.val-parcela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.val-parcela C-Win
ON ENTRY OF parc-nota-fiscal.val-parcela IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL parc-nota-fiscal.val-parcela C-Win
ON LEAVE OF parc-nota-fiscal.val-parcela IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-conta
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = parc-nota-fiscal.cd-conta}
                          
{func\calc.i parc-nota-fiscal.val-parcela}
{func\calendar.i parc-nota-fiscal.dt-parcela}

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
  {version.i parc-nota-fiscal_det}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE assignIniFields C-Win 
PROCEDURE assignIniFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND LAST bf-parc-nota-fiscal OF nota-fiscal NO-LOCK NO-ERROR.
    IF AVAIL bf-parc-nota-fiscal THEN
        ASSIGN parc-nota-fiscal.sequencia = bf-parc-nota-fiscal.sequencia + 1.
    ELSE
        ASSIGN parc-nota-fiscal.sequencia = 1.

    IF parc-nota-fiscal.dt-pagto-parc = ? THEN
        ASSIGN parc-nota-fiscal.dt-pagto-parc = parc-nota-fiscal.dt-parcela.
        
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

FIND FIRST favorecido OF nota-fiscal NO-LOCK NO-ERROR.

{func\detalhe\display.i}

APPLY "LEAVE" TO parc-nota-fiscal.cd-conta.

DISABLE parc-nota-fiscal.sequencia
    WITH FRAME {&FRAME-NAME}.

APPLY "VALUE-CHANGED" TO parc-nota-fiscal.situacao.

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
  DISPLAY des-conta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.ds-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE nota-fiscal THEN 
    DISPLAY nota-fiscal.cd-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE parc-nota-fiscal THEN 
    DISPLAY parc-nota-fiscal.situacao parc-nota-fiscal.nr-controle 
          parc-nota-fiscal.sequencia parc-nota-fiscal.dt-parcela 
          parc-nota-fiscal.val-parcela parc-nota-fiscal.cd-conta 
          parc-nota-fiscal.cd-sequencia parc-nota-fiscal.dt-pagto-parc 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE des-conta parc-nota-fiscal.situacao parc-nota-fiscal.nr-controle 
         nota-fiscal.cd-favorecido favorecido.ds-favorecido 
         parc-nota-fiscal.sequencia parc-nota-fiscal.dt-parcela 
         parc-nota-fiscal.val-parcela parc-nota-fiscal.cd-conta 
         parc-nota-fiscal.cd-sequencia parc-nota-fiscal.dt-pagto-parc RECT-2 
         RECT-9 
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

{func\cursor.i parc-nota-fiscal.cd-conta}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE leaveObject C-Win 
PROCEDURE leaveObject :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER cObject AS CHARACTER  NO-UNDO.

IF cObject = "des-conta" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} des-conta NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN parc-nota-fiscal.cd-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.

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
    FIND FIRST bf-parc-nota-fiscal NO-LOCK
        WHERE bf-parc-nota-fiscal.nr-controle = INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.nr-controle
        AND   bf-parc-nota-fiscal.sequencia = INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.sequencia
        AND   ROWID(bf-parc-nota-fiscal) <> ROWID(parc-nota-fiscal) NO-ERROR.
    IF AVAIL bf-parc-nota-fiscal THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:

    IF INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.situacao = 2 /* Liquidada */ THEN DO:
        FIND FIRST conta NO-LOCK
            WHERE conta.cd-conta = INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.cd-conta NO-ERROR.
        IF NOT AVAIL conta THEN DO:
            {func\valida.i &Mensagem  = "Conta n∆o existente!"
                           &Ajuda     = "Vocà deve informar a conta de liquidaá∆o da parcela."
                           &Campo     = parc-nota-fiscal.cd-conta}
        END.
        ELSE DO:
            FIND FIRST mov-conta NO-LOCK
                WHERE mov-conta.cd-conta = INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.cd-conta
                AND   mov-conta.cd-sequencia = INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.cd-sequencia NO-ERROR.
            IF NOT AVAIL mov-conta THEN DO:
                {func\valida.i &Mensagem  = "Movimento n∆o existente!"
                               &Ajuda     = "Vocà deve informar a sequencia correta do movimento de liquidaá∆o da parcela."
                               &Campo     = parc-nota-fiscal.cd-sequencia}
            END.
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.val-parcela = 0 THEN DO:
        {func\valida.i &Mensagem  = "Valor n∆o informado!"
                       &Ajuda     = "Vocà deve informar o valor da Parcela."
                       &Campo     = parc-nota-fiscal.val-parcela}
    END.

    IF INPUT FRAME {&FRAME-NAME} parc-nota-fiscal.dt-parcela = ? THEN DO:
        {func\valida.i &Mensagem  = "Data n∆o informada!"
                       &Ajuda     = "Vocà deve informar a data prevista de pagamento da Parcela."
                       &Campo     = parc-nota-fiscal.dt-parcela}
    END.

END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

