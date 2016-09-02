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
&GLOBAL-DEFINE Table        cotacao
&GLOBAL-DEFINE Parent       moeda
&GLOBAL-DEFINE ParentField  cd-moeda
&GLOBAL-DEFINE KeyFields    cotacao.dt-ini
&GLOBAL-DEFINE FrameFields  cotacao.dt-end cotacao.valor de-val-ori
&GLOBAL-DEFINE FrameDisp    moeda.ds-moeda moeda

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\definitions.i}
{cotacao.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS cotacao.cd-moeda cotacao.dt-ini ~
cotacao.dt-end cotacao.valor 
&Scoped-define ENABLED-TABLES cotacao
&Scoped-define FIRST-ENABLED-TABLE cotacao
&Scoped-Define ENABLED-OBJECTS de-val-ori moeda RECT-2 
&Scoped-Define DISPLAYED-FIELDS cotacao.cd-moeda moeda.ds-moeda ~
cotacao.dt-ini cotacao.dt-end cotacao.valor 
&Scoped-define DISPLAYED-TABLES cotacao moeda
&Scoped-define FIRST-DISPLAYED-TABLE cotacao
&Scoped-define SECOND-DISPLAYED-TABLE moeda
&Scoped-Define DISPLAYED-OBJECTS de-val-ori moeda 

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

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 21.29 BY 1 NO-UNDO.

DEFINE VARIABLE de-val-ori AS DECIMAL FORMAT "->>,>>9.999999":U INITIAL 0 
     LABEL "Valor Original" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     cotacao.cd-moeda AT ROW 1.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btOK AT ROW 6.75 COL 68
     moeda.ds-moeda AT ROW 1.5 COL 21.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     btCancel AT ROW 6.75 COL 74.14
     cotacao.dt-ini AT ROW 3.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     cotacao.dt-end AT ROW 4.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     de-val-ori AT ROW 5.25 COL 34 COLON-ALIGNED WIDGET-ID 2
     moeda AT ROW 6.25 COL 34 COLON-ALIGNED WIDGET-ID 4
     cotacao.valor AT ROW 7.25 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
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
/* SETTINGS FOR FILL-IN moeda.ds-moeda IN FRAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME cotacao.cd-moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.cd-moeda C-Win
ON ENTRY OF cotacao.cd-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.cd-moeda C-Win
ON LEAVE OF cotacao.cd-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME de-val-ori
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL de-val-ori C-Win
ON ENTRY OF de-val-ori IN FRAME DEFAULT-FRAME /* Valor Original */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL de-val-ori C-Win
ON LEAVE OF de-val-ori IN FRAME DEFAULT-FRAME /* Valor Original */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL de-val-ori C-Win
ON RETURN OF de-val-ori IN FRAME DEFAULT-FRAME /* Valor Original */
DO:
    APPLY "CHOOSE" TO btOK.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL de-val-ori C-Win
ON VALUE-CHANGED OF de-val-ori IN FRAME DEFAULT-FRAME /* Valor Original */
DO:
  
    APPLY "VALUE-CHANGED" TO moeda.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME moeda.ds-moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda.ds-moeda C-Win
ON ENTRY OF moeda.ds-moeda IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda.ds-moeda C-Win
ON LEAVE OF moeda.ds-moeda IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cotacao.dt-end
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.dt-end C-Win
ON ENTRY OF cotacao.dt-end IN FRAME DEFAULT-FRAME /* Data Fim */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.dt-end C-Win
ON LEAVE OF cotacao.dt-end IN FRAME DEFAULT-FRAME /* Data Fim */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.dt-end C-Win
ON RETURN OF cotacao.dt-end IN FRAME DEFAULT-FRAME /* Data Fim */
DO:
    APPLY "CHOOSE" TO btOK.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cotacao.dt-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.dt-ini C-Win
ON ENTRY OF cotacao.dt-ini IN FRAME DEFAULT-FRAME /* Data In°cio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.dt-ini C-Win
ON LEAVE OF cotacao.dt-ini IN FRAME DEFAULT-FRAME /* Data In°cio */
DO:
    {func\set_leave.i}   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON ENTRY OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON LEAVE OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON VALUE-CHANGED OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
  
    ASSIGN cotacao.valor:SCREEN-VALUE = STRING(fnCotacao(INPUT FRAME {&FRAME-NAME} de-val-ori,
                                            INPUT FRAME {&FRAME-NAME} moeda,
                                            0, INPUT FRAME {&FRAME-NAME} cotacao.dt-end)).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cotacao.valor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.valor C-Win
ON ENTRY OF cotacao.valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.valor C-Win
ON LEAVE OF cotacao.valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao.valor C-Win
ON RETURN OF cotacao.valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
    APPLY "CHOOSE" TO btOK.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\calendar.i cotacao.dt-ini}
{func\calendar.i cotacao.dt-end}
{func\calc.i cotacao.valor}
{func\calc.i de-val-ori}

{campos\cd-moeda.i}                

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
  {version.i cotacao_det}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterCalc C-Win 
PROCEDURE afterCalc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER c-obj AS CHARACTER   NO-UNDO.

    CASE c-obj:
        WHEN "de-val-ori" THEN DO:
            APPLY "VALUE-CHANGED" TO moeda IN FRAME {&FRAME-NAME}.
        END.
    END CASE.

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

IF pcActionBT = "ADD" THEN DO:
    ASSIGN cotacao.dt-end = 12/31/9999.
END.

ASSIGN de-val-ori = cotacao.valor.

{func\detalhe\display.i}

DISABLE cotacao.valor
    WITH FRAME {&FRAME-NAME}.

ENABLE moeda
    WITH FRAME {&FRAME-NAME}.

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
  DISPLAY de-val-ori moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE cotacao THEN 
    DISPLAY cotacao.cd-moeda cotacao.dt-ini cotacao.dt-end cotacao.valor 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE moeda THEN 
    DISPLAY moeda.ds-moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE cotacao.cd-moeda cotacao.dt-ini cotacao.dt-end de-val-ori moeda 
         cotacao.valor RECT-2 
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

{func/cb-lista.i cd-moeda moeda}

ASSIGN moeda = 0.

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
    FIND FIRST bf-cotacao NO-LOCK
        WHERE bf-cotacao.cd-moeda        = INPUT FRAME {&FRAME-NAME} cotacao.cd-moeda
        AND   bf-cotacao.dt-ini  = INPUT FRAME {&FRAME-NAME} cotacao.dt-ini
        AND   ROWID(bf-cotacao) <> ROWID(cotacao) NO-ERROR.
    IF AVAIL bf-cotacao THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
    IF CAN-FIND(FIRST bf-cotacao
                WHERE bf-cotacao.cd-moeda        = INPUT FRAME {&FRAME-NAME} cotacao.cd-moeda
                AND   bf-cotacao.dt-ini         <= INPUT FRAME {&FRAME-NAME} cotacao.dt-ini
                AND   bf-cotacao.dt-end         >= INPUT FRAME {&FRAME-NAME} cotacao.dt-ini
                AND   ROWID(bf-cotacao) <> ROWID(cotacao)) THEN DO:
        {func\valida.i &Mensagem  = "Data Inicial Inv†lida!"
                       &Ajuda     = "J† existe cotaá∆o para o per°odo informado."
                       &Campo     = cotacao.dt-ini}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:
    IF CAN-FIND(FIRST bf-cotacao
                WHERE bf-cotacao.cd-moeda        = INPUT FRAME {&FRAME-NAME} cotacao.cd-moeda
                AND   bf-cotacao.dt-ini         <= INPUT FRAME {&FRAME-NAME} cotacao.dt-end
                AND   bf-cotacao.dt-end         >= INPUT FRAME {&FRAME-NAME} cotacao.dt-end
                AND   ROWID(bf-cotacao)         <> ROWID(cotacao)) THEN DO:
        {func\valida.i &Mensagem  = "Data Final Inv†lida!"
                       &Ajuda     = "J† existe cotaá∆o para o per°odo informado."
                       &Campo     = cotacao.dt-end}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

