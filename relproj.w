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

&GLOBAL-DEFINE Table        mov-conta

/* Parameters Definitions ---                                           */

DEFINE INPUT  PARAMETER iConta AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER iSeq AS INTEGER    NO-UNDO.

/* Local Variable Definitions ---                                       */

def var chTreeView       as com-handle no-undo.
def var h-Node           as char   no-undo.

DEFINE VARIABLE iNivel AS INTEGER    NO-UNDO.

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
&Scoped-Define ENABLED-FIELDS mov-conta.cd-projeto 
&Scoped-define ENABLED-TABLES mov-conta
&Scoped-define FIRST-ENABLED-TABLE mov-conta
&Scoped-Define ENABLED-OBJECTS btElim btOK btExit RECT-10 RECT-12 
&Scoped-Define DISPLAYED-FIELDS mov-conta.cd-conta mov-conta.cd-sequencia ~
mov-conta.cd-projeto 
&Scoped-define DISPLAYED-TABLES mov-conta
&Scoped-define FIRST-DISPLAYED-TABLE mov-conta
&Scoped-Define DISPLAYED-OBJECTS ds-conta ds-proj 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnCriaNivel C-Win 
FUNCTION fnCriaNivel RETURNS CHARACTER
  ( iProj AS INTEGER, iPai AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame-2 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-2 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btElim 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Desassociar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Desassociar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "OK" 
     SIZE 6.14 BY 1.79 TOOLTIP "Associar".

DEFINE VARIABLE ds-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .79 NO-UNDO.

DEFINE VARIABLE ds-proj AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44.72 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.25.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btElim AT ROW 12.25 COL 73
     btOK AT ROW 10.46 COL 73
     mov-conta.cd-conta AT ROW 4.25 COL 15 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-conta AT ROW 4.25 COL 19.29 COLON-ALIGNED NO-LABEL
     mov-conta.cd-sequencia AT ROW 4.25 COL 54.57 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9.43 BY .79
     mov-conta.cd-projeto AT ROW 5.25 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-proj AT ROW 5.25 COL 19.29 COLON-ALIGNED NO-LABEL
     btExit AT ROW 1.5 COL 73
     RECT-10 AT ROW 1.25 COL 2
     RECT-12 AT ROW 3.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 79.72 BY 13.25
         FONT 1.


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
         TITLE              = "Movimentos X Projeto"
         HEIGHT             = 13.25
         WIDTH              = 79.72
         MAX-HEIGHT         = 16.25
         MAX-WIDTH          = 87.14
         VIRTUAL-HEIGHT     = 16.25
         VIRTUAL-WIDTH      = 87.14
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
/* SETTINGS FOR FILL-IN mov-conta.cd-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-proj IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 6.75
       COLUMN          = 2
       HEIGHT          = 7.25
       WIDTH           = 70
       WIDGET-ID       = 2
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {C74190B6-8589-11D1-B16A-00C0F0283628} type: TreeView */

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Movimentos X Projeto */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Movimentos X Projeto */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btElim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btElim C-Win
ON CHOOSE OF btElim IN FRAME DEFAULT-FRAME /* Desassociar */
DO:

    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Movimento X Projeto (046)', INPUT 'Deseja remover o relacionamento ?', INPUT 'Deseja realmente remover o relacionamento entre o movimento e o projeto ?')"}
    IF RETURN-VALUE = "OK":U THEN DO:
        FIND CURRENT mov-conta EXCLUSIVE-LOCK.
        ASSIGN mov-conta.cd-projeto = 0
               mov-conta.cd-nivel   = 0.
        APPLY "CLOSE" TO THIS-PROCEDURE.
    END.

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


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* OK */
DO:

    ASSIGN h-Node = chTreeView:SelectedItem:Key.
    RUN pi-ClickTreeView.
    
    RUN som.p(INPUT "music\click.wav").
    FIND FIRST projeto WHERE projeto.cd-projeto = INPUT FRAME default-frame mov-conta.cd-projeto NO-LOCK NO-ERROR.
    IF AVAIL projeto THEN DO:
    
        IF NOT CAN-FIND(FIRST nivel-projeto OF projeto NO-LOCK
                        WHERE nivel-projeto.nivel-pai = iNivel) THEN DO:
      
            FIND CURRENT mov-conta EXCLUSIVE-LOCK.
            ASSIGN INPUT FRAME default-frame mov-conta.cd-projeto
                   mov-conta.cd-nivel = iNivel.
        
            APPLY "CLOSE" TO THIS-PROCEDURE.

        END.
        ELSE DO:

            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Associa‡Æo de Projeto (027)', INPUT 'N¡vel inv lido!', INPUT 'Vocˆ s¢ pode associar um movimento a um n¡vel final do projeto. O n¡vel selecionado ainda possui filhos.')"}

        END.

    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Associa‡Æo de Projeto (028)', INPUT 'Projeto inv lido!', INPUT 'Vocˆ deve informar um projeto v lido.')"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-conta C-Win
ON ENTRY OF mov-conta.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-conta C-Win
ON LEAVE OF mov-conta.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-projeto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-projeto C-Win
ON ENTRY OF mov-conta.cd-projeto IN FRAME DEFAULT-FRAME /* Projeto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-projeto C-Win
ON LEAVE OF mov-conta.cd-projeto IN FRAME DEFAULT-FRAME /* Projeto */
DO:

    {func\set_leave.i}  
    FIND FIRST projeto WHERE projeto.cd-projeto = INPUT FRAME default-frame mov-conta.cd-projeto NO-LOCK NO-ERROR.
    IF AVAIL projeto THEN DO:
        ASSIGN ds-proj:SCREEN-VALUE IN FRAME default-frame = projeto.ds-projeto.
        RUN pi-criaTreeView.
    END.
    ELSE
        ASSIGN ds-proj:SCREEN-VALUE IN FRAME default-frame = ""
               iNivel = 0.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-projeto C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-conta.cd-projeto IN FRAME DEFAULT-FRAME /* Projeto */
OR F5 OF mov-conta.cd-projeto DO:
    {func\zoom.i &Tabela="projeto"
                 &Campo1="cd-projeto"
                 &Tela1="mov-conta.cd-projeto"
                 &Campo2="ds-projeto"
                 &Tela2="ds-proj"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-sequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sequencia C-Win
ON ENTRY OF mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME /* Seq */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sequencia C-Win
ON LEAVE OF mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME /* Seq */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.Click
PROCEDURE CtrlFrame-2.TreeView.Click .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN h-Node = chTreeView:SelectedItem:Key.
RUN pi-ClickTreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.NodeClick
PROCEDURE CtrlFrame-2.TreeView.NodeClick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Required for OCX.
    Node
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER p-Node AS COM-HANDLE NO-UNDO.

ASSIGN h-Node = chTreeView:SelectedItem:Key.
RUN pi-ClickTreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ds-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-conta C-Win
ON ENTRY OF ds-conta IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-conta C-Win
ON LEAVE OF ds-conta IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ds-proj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-proj C-Win
ON ENTRY OF ds-proj IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-proj C-Win
ON LEAVE OF ds-proj IN FRAME DEFAULT-FRAME
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
  {version.i relproj}
  RUN initialize.
  RUN enable_UI.
  RUN afterinitialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterinitialize C-Win 
PROCEDURE afterinitialize :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

APPLY "LEAVE" TO mov-conta.cd-projeto IN FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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

OCXFile = SEARCH( "relproj.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame-2 = CtrlFrame-2:COM-HANDLE
    UIB_S = chCtrlFrame-2:LoadControls( OCXFile, "CtrlFrame-2":U)
    CtrlFrame-2:NAME = "CtrlFrame-2":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "relproj.wrx":U SKIP(1)
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
  DISPLAY ds-conta ds-proj 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE mov-conta THEN 
    DISPLAY mov-conta.cd-conta mov-conta.cd-sequencia mov-conta.cd-projeto 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btElim btOK mov-conta.cd-projeto btExit RECT-10 RECT-12 
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

FIND FIRST mov-conta 
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.cd-sequencia = iSeq EXCLUSIVE-LOCK NO-ERROR.

FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK NO-ERROR.
IF AVAIL conta THEN
    ASSIGN ds-conta = conta.ds-conta.

{func\cursor.i mov-conta.cd-projeto 1 "IN FRAME {&FRAME-NAME}"}

DISPLAY mov-conta.cd-projeto WITH FRAME default-frame.

RUN pi-criaTreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initialize-controls C-Win 
PROCEDURE initialize-controls :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 assign chTreeView            = chctrlframe-2:TreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pi-clickTreeView C-Win 
PROCEDURE pi-clickTreeView :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF LENGTH(h-node) = 4 THEN DO:

        FIND FIRST nivel-projeto NO-LOCK
            WHERE nivel-projeto.cd-projeto = INPUT FRAME default-frame mov-conta.cd-projeto
            AND   nivel-projeto.cd-nivel = 0
            AND   nivel-projeto.nivel-pai = 0 NO-ERROR.
        IF AVAIL nivel-projeto THEN DO:

            ASSIGN iNivel = nivel-projeto.cd-nivel.

        END.

    END.
    ELSE DO:

        FIND FIRST nivel-projeto NO-LOCK
            WHERE nivel-projeto.cd-projeto = INPUT FRAME default-frame mov-conta.cd-projeto
            AND   nivel-projeto.cd-nivel = INTEGER(SUBSTRING(h-node,6,3)) NO-ERROR.
        IF AVAIL nivel-projeto THEN DO:

            ASSIGN iNivel = nivel-projeto.cd-nivel.

        END.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pi-criaTreeView C-Win 
PROCEDURE pi-criaTreeView :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE i-cont AS INTEGER    NO-UNDO.

    IF AVAIL projeto THEN DO:

        IF chTreeView:Nodes:COUNT > 0 THEN DO:
            DO i-cont = chTreeView:Nodes:COUNT TO 1 BY -1:
                chTreeView:Nodes:Remove(i-cont).
            END.
        END.

        chTreeView:Nodes:Add(,,"P" + STRING(projeto.cd-projeto,"999") + "N000",
                             projeto.ds-projeto,0).
        fnCriaNivel(projeto.cd-projeto,0).
    END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnCriaNivel C-Win 
FUNCTION fnCriaNivel RETURNS CHARACTER
  ( iProj AS INTEGER, iPai AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/


    FOR EACH nivel-projeto NO-LOCK
        WHERE nivel-projeto.cd-projeto = iProj
        AND   nivel-projeto.nivel-pai = iPai:

        IF nivel-projeto.cd-nivel = 0 THEN NEXT.
        
        IF nivel-projeto.cd-nivel <> mov-conta.cd-nivel THEN DO:
            chTreeView:Nodes:Add("P" + STRING(nivel-projeto.cd-projeto,"999") +
                                 "N" + STRING(nivel-projeto.nivel-pai,"999"),4,
                                 "P" + STRING(nivel-projeto.cd-projeto,"999") +
                                 "N" + STRING(nivel-projeto.cd-nivel,"999"),
                                 nivel-projeto.ds-nivel,0).
        END.
        ELSE DO:
            chTreeView:SelectedItem = chTreeView:Nodes:Add("P" + STRING(nivel-projeto.cd-projeto,"999") +
                                 "N" + STRING(nivel-projeto.nivel-pai,"999"),4,
                                 "P" + STRING(nivel-projeto.cd-projeto,"999") +
                                 "N" + STRING(nivel-projeto.cd-nivel,"999"),
                                 nivel-projeto.ds-nivel,0).
        END.


        fnCriaNivel(iProj,nivel-projeto.cd-nivel).

    END.

    RETURN "OK".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

