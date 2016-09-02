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
&GLOBAL-DEFINE Table        poupanca
&GLOBAL-DEFINE KeyFields    poupanca.cd-poupanca
&GLOBAL-DEFINE FrameFields  poupanca.ds-poupanca poupanca.cd-conta ~
                            poupanca.cd-fav-padrao poupanca.simulacao ~
                            poupanca.calc-ir conta favor

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

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
&Scoped-Define ENABLED-FIELDS poupanca.cd-poupanca poupanca.ds-poupanca ~
poupanca.cd-conta poupanca.cd-fav-padrao poupanca.simulacao ~
poupanca.calc-ir 
&Scoped-define ENABLED-TABLES poupanca
&Scoped-define FIRST-ENABLED-TABLE poupanca
&Scoped-Define ENABLED-OBJECTS btAno btConta btGoTo btFirst btLast conta ~
btNext btPrev btAdd favor btDel btExit btUpdate btZoom RECT-4 RECT-5 
&Scoped-Define DISPLAYED-FIELDS poupanca.cd-poupanca poupanca.ds-poupanca ~
poupanca.cd-conta poupanca.cd-fav-padrao poupanca.simulacao ~
poupanca.calc-ir 
&Scoped-define DISPLAYED-TABLES poupanca
&Scoped-define FIRST-DISPLAYED-TABLE poupanca
&Scoped-Define DISPLAYED-OBJECTS conta favor 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btAno 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Valores Anuais".

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btConta 
     IMAGE-UP FILE "image/im-sub.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-sub.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Contas Relacionadas".

DEFINE BUTTON btDel 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btGoTo 
     IMAGE-UP FILE "image/im-goto.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-goto.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "GoTo" 
     SIZE 6.14 BY 1.79 TOOLTIP "V† Para".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btUpdate 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .79 NO-UNDO.

DEFINE VARIABLE favor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 5.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAno AT ROW 1.5 COL 64
     btConta AT ROW 1.5 COL 70.14
     btGoTo AT ROW 1.5 COL 48.43
     poupanca.cd-poupanca AT ROW 4.5 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     poupanca.ds-poupanca AT ROW 5.5 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 45.29 BY .79
     btFirst AT ROW 1.5 COL 3
     poupanca.cd-conta AT ROW 6.5 COL 27 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btLast AT ROW 1.5 COL 21.43
     conta AT ROW 6.5 COL 31.29 COLON-ALIGNED NO-LABEL
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     poupanca.cd-fav-padrao AT ROW 7.5 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btAdd AT ROW 1.5 COL 30
     favor AT ROW 7.5 COL 32.29 COLON-ALIGNED NO-LABEL
     btCancel AT ROW 10 COL 81.14
     poupanca.simulacao AT ROW 8.5 COL 29
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .83
     poupanca.calc-ir AT ROW 8.5 COL 42
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .83
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 10 COL 75
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 10.79
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
         TITLE              = "Template Padr∆o de Cadastro"
         HEIGHT             = 10.79
         WIDTH              = 86.72
         MAX-HEIGHT         = 11.38
         MAX-WIDTH          = 86.72
         VIRTUAL-HEIGHT     = 11.38
         VIRTUAL-WIDTH      = 86.72
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
/* SETTINGS FOR FILL-IN poupanca.cd-conta IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Cadastro */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Cadastro */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_add.i "cd-poupanca"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAno C-Win
ON CHOOSE OF btAno IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "poupano.w"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btConta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btConta C-Win
ON CHOOSE OF btConta IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "poup-conta.w"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel C-Win
ON CHOOSE OF btDel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_del.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExit C-Win
ON CHOOSE OF btExit IN FRAME DEFAULT-FRAME /* Button 1 */
DO:
  
    {func\bt_fechar.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_first.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btGoTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGoTo C-Win
ON CHOOSE OF btGoTo IN FRAME DEFAULT-FRAME /* GoTo */
DO:
    {func\bt_goto.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_last.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_next.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_ok.i}

    IF NOT CAN-FIND(FIRST poup-conta
                    WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca
                    AND   poup-conta.cd-conta    = poupanca.cd-conta) THEN DO:

        CREATE poup-conta.
        ASSIGN poup-conta.cd-poupanca = poupanca.cd-poupanca
               poup-conta.cd-conta    = poupanca.cd-conta.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate C-Win
ON CHOOSE OF btUpdate IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_update.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btZoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btZoom C-Win
ON CHOOSE OF btZoom IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_zoom.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME poupanca.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-conta C-Win
ON ENTRY OF poupanca.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-conta C-Win
ON LEAVE OF poupanca.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoProc = "ds-conta"
                  &Tela="conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-conta C-Win
ON MOUSE-SELECT-DBLCLICK OF poupanca.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF {&Table}.cd-conta DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="poupanca.cd-conta"
                 &Campo2="ds-conta"
                 &Tela2="conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME poupanca.cd-fav-padrao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-fav-padrao C-Win
ON ENTRY OF poupanca.cd-fav-padrao IN FRAME DEFAULT-FRAME /* Favorecido Padr∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-fav-padrao C-Win
ON LEAVE OF poupanca.cd-fav-padrao IN FRAME DEFAULT-FRAME /* Favorecido Padr∆o */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela="cd-fav-padrao"
                  &CampoProc = "ds-favorecido"
                  &Tela="favor"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-fav-padrao C-Win
ON MOUSE-SELECT-DBLCLICK OF poupanca.cd-fav-padrao IN FRAME DEFAULT-FRAME /* Favorecido Padr∆o */
OR F5 OF {&Table}.cd-fav-padrao DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="poupanca.cd-fav-padrao"
                 &Campo2="ds-favorecido"
                 &Tela2="favor"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME poupanca.cd-poupanca
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-poupanca C-Win
ON ENTRY OF poupanca.cd-poupanca IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.cd-poupanca C-Win
ON LEAVE OF poupanca.cd-poupanca IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME poupanca.ds-poupanca
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.ds-poupanca C-Win
ON ENTRY OF poupanca.ds-poupanca IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL poupanca.ds-poupanca C-Win
ON LEAVE OF poupanca.ds-poupanca IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = favor
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = poupanca.cd-fav-padrao}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = conta
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = poupanca.cd-conta}

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
  RUN enable_UI.
  {version.i poup}
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\control_buttons.i}

IF lHabilita THEN DO:
    DISABLE btAno
            btConta WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ENABLE btAno
           btConta WITH FRAME {&FRAME-NAME}.
END.

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
{func\cadastro\display.i}

APPLY "LEAVE" TO poupanca.cd-conta IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO poupanca.cd-fav-padrao IN FRAME {&FRAME-NAME}.

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
  DISPLAY conta favor 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE poupanca THEN 
    DISPLAY poupanca.cd-poupanca poupanca.ds-poupanca poupanca.cd-conta 
          poupanca.cd-fav-padrao poupanca.simulacao poupanca.calc-ir 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btAno btConta btGoTo poupanca.cd-poupanca poupanca.ds-poupanca btFirst 
         poupanca.cd-conta btLast conta btNext btPrev poupanca.cd-fav-padrao 
         btAdd favor poupanca.simulacao poupanca.calc-ir btDel btExit btUpdate 
         btZoom RECT-4 RECT-5 
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
{func\initialize.i}

{func\cursor.i poupanca.cd-conta}
{func\cursor.i poupanca.cd-fav-padrao}

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

IF cObject = "favor" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} favor NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN poupanca.cd-fav-padrao:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.
IF cObject = "conta" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} conta NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN poupanca.cd-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.

RETURN "OK".

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

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-poupanca NO-LOCK
        WHERE bf-poupanca.cd-poupanca = INPUT FRAME {&FRAME-NAME} poupanca.cd-poupanca
        AND   ROWID(bf-poupanca) <> ROWID(poupanca) NO-ERROR.
    IF AVAIL bf-poupanca THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "UPDATE" THEN DO:
END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST item-poupanca OF poupanca) THEN DO:
        {func\valida.i &Mensagem  = "Existem valores planejados para essa poupanáa!"
                       &Ajuda     = "S¢ ser† permitido eliminar a poupanáa quando ela n∆o tiver nenhum planejamento de valores."}
    END.
    IF CAN-FIND(FIRST poup-conta
                WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca) THEN DO:
        {func\valida.i &Mensagem  = "Existem contas associadas a essa poupanáa!"
                       &Ajuda     = "S¢ ser† permitido eliminar a poupanáa quando ela n∆o tiver nenhuma conta associada."}
    END.

END.

FOR EACH poup-conta EXCLUSIVE-LOCK
    WHERE poup-conta.cd-poupanca = INPUT FRAME {&FRAME-NAME} poupanca.cd-poupanca:

    DELETE poup-conta.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

