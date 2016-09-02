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
&GLOBAL-DEFINE Table        tabela-preco-item
&GLOBAL-DEFINE Parent       tabela-preco
&GLOBAL-DEFINE ParentField  cd-tabela
&GLOBAL-DEFINE KeyFields    tabela-preco-item.cd-item
&GLOBAL-DEFINE FrameFields  tabela-preco-item.val-unitario
&GLOBAL-DEFINE FrameDisp    tabela-preco.ds-tabela

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
&Scoped-define INTERNAL-TABLES tabela-preco-item tabela-preco

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME tabela-preco-item.cd-item ~
tabela-preco-item.cd-tabela-preco tabela-preco-item.val-unitario ~
tabela-preco.ds-tabela-preco 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
tabela-preco-item.cd-item tabela-preco-item.cd-tabela-preco ~
tabela-preco-item.val-unitario tabela-preco.ds-tabela-preco 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME tabela-preco-item ~
tabela-preco
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME tabela-preco-item
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME tabela-preco
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH tabela-preco-item SHARE-LOCK, ~
      EACH tabela-preco OF tabela-preco-item SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH tabela-preco-item SHARE-LOCK, ~
      EACH tabela-preco OF tabela-preco-item SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME tabela-preco-item tabela-preco
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME tabela-preco-item
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME tabela-preco


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS tabela-preco-item.cd-item ~
tabela-preco-item.cd-tabela-preco tabela-preco-item.val-unitario ~
tabela-preco.ds-tabela-preco 
&Scoped-define ENABLED-TABLES tabela-preco-item tabela-preco
&Scoped-define FIRST-ENABLED-TABLE tabela-preco-item
&Scoped-define SECOND-ENABLED-TABLE tabela-preco
&Scoped-Define ENABLED-OBJECTS desc-item RECT-2 
&Scoped-Define DISPLAYED-FIELDS tabela-preco-item.cd-item ~
tabela-preco-item.cd-tabela-preco tabela-preco-item.val-unitario ~
tabela-preco.ds-tabela-preco 
&Scoped-define DISPLAYED-TABLES tabela-preco-item tabela-preco
&Scoped-define FIRST-DISPLAYED-TABLE tabela-preco-item
&Scoped-define SECOND-DISPLAYED-TABLE tabela-preco
&Scoped-Define DISPLAYED-OBJECTS desc-item 

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

DEFINE VARIABLE desc-item AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      tabela-preco-item, 
      tabela-preco SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 8.5 COL 74.14
     btOK AT ROW 8.5 COL 68
     tabela-preco-item.cd-item AT ROW 3.25 COL 16 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     tabela-preco-item.cd-tabela-preco AT ROW 1.5 COL 16 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     tabela-preco-item.val-unitario AT ROW 4.25 COL 16 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tabela-preco.ds-tabela-preco AT ROW 1.5 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     desc-item AT ROW 3.25 COL 22 COLON-ALIGNED NO-LABEL WIDGET-ID 10 NO-TAB-STOP 
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 9.46
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
         HEIGHT             = 9.46
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
ASSIGN 
       desc-item:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.tabela-preco-item,money.tabela-preco OF money.tabela-preco-item"
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


&Scoped-define SELF-NAME tabela-preco-item.cd-item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-preco-item.cd-item C-Win
ON ENTRY OF tabela-preco-item.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-preco-item.cd-item C-Win
ON LEAVE OF tabela-preco-item.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\leave.i &Tabela="item"
                  &Campo="cd-item"
                  &CampoProc="ds-item"
                  &Tela="desc-item"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-preco-item.cd-item C-Win
ON MOUSE-SELECT-DBLCLICK OF tabela-preco-item.cd-item IN FRAME DEFAULT-FRAME /* Item */
OR F5 OF {&Table}.cd-item DO:
    {func\zoom.i &Tabela="item"
                 &Campo1="cd-item"
                 &Tela1="tabela-preco-item.cd-item"
                 &Campo2="ds-item"
                 &Tela2="desc-item"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tabela-preco-item.val-unitario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-preco-item.val-unitario C-Win
ON ENTRY OF tabela-preco-item.val-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-preco-item.val-unitario C-Win
ON LEAVE OF tabela-preco-item.val-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
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
                          &OBJETO = desc-item
                          &FOREACH = "item BY item.ds-item"
                          &CAMPO = item.ds-item
                          &ObjPai = tabela-preco-item.cd-item}
                          
{func\calc.i tabela-preco-item.val-unitario}

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
  {version.i tabela-preco-item_det}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

{func\detalhe\display.i}

APPLY "LEAVE" TO tabela-preco-item.cd-item.

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
  DISPLAY desc-item 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE tabela-preco THEN 
    DISPLAY tabela-preco.ds-tabela-preco 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE tabela-preco-item THEN 
    DISPLAY tabela-preco-item.cd-item tabela-preco-item.cd-tabela-preco 
          tabela-preco-item.val-unitario 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE tabela-preco-item.cd-item tabela-preco-item.cd-tabela-preco 
         tabela-preco-item.val-unitario tabela-preco.ds-tabela-preco desc-item 
         RECT-2 
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

{func\cursor.i tabela-preco-item.cd-item}

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

IF cObject = "desc-item" THEN DO:
    FIND FIRST item NO-LOCK
        WHERE item.ds-item = INPUT FRAME {&FRAME-NAME} desc-item NO-ERROR.
    IF AVAIL item THEN DO:
        ASSIGN tabela-preco-item.cd-item:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(item.cd-item).
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
    FIND FIRST bf-tabela-preco-item NO-LOCK
        WHERE bf-tabela-preco-item.cd-tabela = INPUT FRAME {&FRAME-NAME} tabela-preco-item.cd-tabela
        AND   bf-tabela-preco-item.cd-item = INPUT FRAME {&FRAME-NAME} tabela-preco-item.cd-item
        AND   ROWID(bf-tabela-preco-item) <> ROWID(tabela-preco-item) NO-ERROR.
    IF AVAIL bf-tabela-preco-item THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:
    FIND FIRST item NO-LOCK
        WHERE item.cd-item = INPUT FRAME {&FRAME-NAME} tabela-preco-item.cd-item NO-ERROR.
    IF NOT AVAIL item THEN DO:
        {func\valida.i &Mensagem  = "Item n∆o existente!"
                       &Ajuda     = "Vocà deve informar um item existente."
                       &Campo     = tabela-preco-item.cd-item}
    END.
    ELSE DO:
        IF item.tipo = 1 /* Compra */ THEN DO:
            {func\valida.i &Mensagem  = "Item n∆o Ç de Venda!"
                           &Ajuda     = "Vocà deve informar um item do tipo Venda."
                           &Campo     = tabela-preco-item.cd-item}
        END.
    END.
END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

