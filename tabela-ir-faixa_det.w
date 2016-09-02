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
&GLOBAL-DEFINE Table        tabela-ir-faixa
&GLOBAL-DEFINE Parent       tabela-ir
&GLOBAL-DEFINE ParentField  cd-tabela
&GLOBAL-DEFINE KeyFields    tabela-ir-faixa.val-ini
&GLOBAL-DEFINE FrameFields  tabela-ir-faixa.val-end tabela-ir-faixa.val-abate ~
                            tabela-ir-faixa.pc-ir
&GLOBAL-DEFINE FrameDisp    tabela-ir.ds-tabela

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
&Scoped-Define ENABLED-FIELDS tabela-ir-faixa.cd-tabela ~
tabela-ir-faixa.val-ini tabela-ir-faixa.val-end tabela-ir-faixa.pc-ir ~
tabela-ir-faixa.val-abate 
&Scoped-define ENABLED-TABLES tabela-ir-faixa
&Scoped-define FIRST-ENABLED-TABLE tabela-ir-faixa
&Scoped-Define ENABLED-OBJECTS RECT-2 
&Scoped-Define DISPLAYED-FIELDS tabela-ir-faixa.cd-tabela ~
tabela-ir.ds-tabela tabela-ir-faixa.val-ini tabela-ir-faixa.val-end ~
tabela-ir-faixa.pc-ir tabela-ir-faixa.val-abate 
&Scoped-define DISPLAYED-TABLES tabela-ir-faixa tabela-ir
&Scoped-define FIRST-DISPLAYED-TABLE tabela-ir-faixa
&Scoped-define SECOND-DISPLAYED-TABLE tabela-ir


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
     SIZE 78 BY 1.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 6.75 COL 74.14
     tabela-ir-faixa.cd-tabela AT ROW 1.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     tabela-ir.ds-tabela AT ROW 1.5 COL 21.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     btOK AT ROW 6.75 COL 68
     tabela-ir-faixa.val-ini AT ROW 3.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tabela-ir-faixa.val-end AT ROW 4.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tabela-ir-faixa.pc-ir AT ROW 5.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tabela-ir-faixa.val-abate AT ROW 6.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.75
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
         HEIGHT             = 7.75
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
/* SETTINGS FOR FILL-IN tabela-ir.ds-tabela IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
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


&Scoped-define SELF-NAME tabela-ir-faixa.cd-tabela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.cd-tabela C-Win
ON ENTRY OF tabela-ir-faixa.cd-tabela IN FRAME DEFAULT-FRAME /* Tabela */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.cd-tabela C-Win
ON LEAVE OF tabela-ir-faixa.cd-tabela IN FRAME DEFAULT-FRAME /* Tabela */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tabela-ir.ds-tabela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir.ds-tabela C-Win
ON ENTRY OF tabela-ir.ds-tabela IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir.ds-tabela C-Win
ON LEAVE OF tabela-ir.ds-tabela IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tabela-ir-faixa.pc-ir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.pc-ir C-Win
ON ENTRY OF tabela-ir-faixa.pc-ir IN FRAME DEFAULT-FRAME /* % IR */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.pc-ir C-Win
ON LEAVE OF tabela-ir-faixa.pc-ir IN FRAME DEFAULT-FRAME /* % IR */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tabela-ir-faixa.val-abate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.val-abate C-Win
ON ENTRY OF tabela-ir-faixa.val-abate IN FRAME DEFAULT-FRAME /* Abatimento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.val-abate C-Win
ON LEAVE OF tabela-ir-faixa.val-abate IN FRAME DEFAULT-FRAME /* Abatimento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tabela-ir-faixa.val-end
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.val-end C-Win
ON ENTRY OF tabela-ir-faixa.val-end IN FRAME DEFAULT-FRAME /* Valor Final */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.val-end C-Win
ON LEAVE OF tabela-ir-faixa.val-end IN FRAME DEFAULT-FRAME /* Valor Final */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tabela-ir-faixa.val-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.val-ini C-Win
ON ENTRY OF tabela-ir-faixa.val-ini IN FRAME DEFAULT-FRAME /* Valor Inicial */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tabela-ir-faixa.val-ini C-Win
ON LEAVE OF tabela-ir-faixa.val-ini IN FRAME DEFAULT-FRAME /* Valor Inicial */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\calendar.i tabela-ir-faixa.val-ini}
{func\calendar.i tabela-ir-faixa.val-end}
{func\calc.i tabela-ir-faixa.val-abat}

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
  {version.i tabela-ir-faixa_det}
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
  IF AVAILABLE tabela-ir THEN 
    DISPLAY tabela-ir.ds-tabela 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE tabela-ir-faixa THEN 
    DISPLAY tabela-ir-faixa.cd-tabela tabela-ir-faixa.val-ini 
          tabela-ir-faixa.val-end tabela-ir-faixa.pc-ir 
          tabela-ir-faixa.val-abate 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE tabela-ir-faixa.cd-tabela tabela-ir-faixa.val-ini 
         tabela-ir-faixa.val-end tabela-ir-faixa.pc-ir 
         tabela-ir-faixa.val-abate RECT-2 
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

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-tabela-ir-faixa NO-LOCK
        WHERE bf-tabela-ir-faixa.cd-tabela        = INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.cd-tabela
        AND   bf-tabela-ir-faixa.val-ini  = INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.val-ini
        AND   ROWID(bf-tabela-ir-faixa) <> ROWID(tabela-ir-faixa) NO-ERROR.
    IF AVAIL bf-tabela-ir-faixa THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
    IF CAN-FIND(FIRST bf-tabela-ir-faixa
                WHERE bf-tabela-ir-faixa.cd-tabela        = INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.cd-tabela
                AND   bf-tabela-ir-faixa.val-ini         <= INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.val-ini
                AND   bf-tabela-ir-faixa.val-end         >= INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.val-ini
                AND   ROWID(bf-tabela-ir-faixa) <> ROWID(tabela-ir-faixa)) THEN DO:
        {func\valida.i &Mensagem  = "Valor Inicial Inv†lido!"
                       &Ajuda     = "J† existe faixa para o valor informado."
                       &Campo     = tabela-ir-faixa.val-ini}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:
    IF CAN-FIND(FIRST bf-tabela-ir-faixa
                WHERE bf-tabela-ir-faixa.cd-tabela        = INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.cd-tabela
                AND   bf-tabela-ir-faixa.val-ini         <= INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.val-end
                AND   bf-tabela-ir-faixa.val-end         >= INPUT FRAME {&FRAME-NAME} tabela-ir-faixa.val-end
                AND   ROWID(bf-tabela-ir-faixa)         <> ROWID(tabela-ir-faixa)) THEN DO:
        {func\valida.i &Mensagem  = "Valor Final Inv†lido!"
                       &Ajuda     = "J† existe faixa para o valor informado."
                       &Campo     = tabela-ir-faixa.val-end}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

