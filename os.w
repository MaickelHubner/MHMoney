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
&GLOBAL-DEFINE Table        ordem-serv
&GLOBAL-DEFINE KeyFields    ordem-serv.num-os
&GLOBAL-DEFINE FrameFields  ordem-serv.dt-os ordem-serv.cd-favorecido ~
                            ordem-serv.ds-os ordem-serv.nome ~
                            ordem-serv.situacao ordem-serv.nr-pedido ~
                            ordem-serv.obs-os desc-fav

/* Local Variable Definitions ---                                       */

/* Buffers */

DEFINE NEW GLOBAL SHARED VAR gcusuario AS CHARACTER NO-UNDO.

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
&Scoped-define INTERNAL-TABLES ordem-serv

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME ordem-serv.num-os ~
ordem-serv.ds-os ordem-serv.dt-os ordem-serv.nome ordem-serv.situacao ~
ordem-serv.cd-favorecido ordem-serv.nr-pedido ordem-serv.obs-os 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ordem-serv.num-os ~
ordem-serv.ds-os ordem-serv.dt-os ordem-serv.nome ordem-serv.situacao ~
ordem-serv.cd-favorecido ordem-serv.nr-pedido ordem-serv.obs-os 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME ordem-serv
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME ordem-serv
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH ordem-serv SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH ordem-serv SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME ordem-serv
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME ordem-serv


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS ordem-serv.num-os ordem-serv.ds-os ~
ordem-serv.dt-os ordem-serv.nome ordem-serv.situacao ~
ordem-serv.cd-favorecido ordem-serv.nr-pedido ordem-serv.obs-os 
&Scoped-define ENABLED-TABLES ordem-serv
&Scoped-define FIRST-ENABLED-TABLE ordem-serv
&Scoped-Define ENABLED-OBJECTS btPlan btItens btGoTo btFirst btLast btNext ~
btPrev btAdd btDel btExit btUpdate btZoom RECT-4 RECT-5 RECT-11 
&Scoped-Define DISPLAYED-FIELDS ordem-serv.num-os ordem-serv.ds-os ~
ordem-serv.dt-os ordem-serv.nome ordem-serv.situacao ~
ordem-serv.cd-favorecido ordem-serv.nr-pedido ordem-serv.obs-os 
&Scoped-define DISPLAYED-TABLES ordem-serv
&Scoped-define FIRST-DISPLAYED-TABLE ordem-serv
&Scoped-Define DISPLAYED-OBJECTS hr-tot desc-fav hr-real hr-pend dt-prev 

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

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

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

DEFINE BUTTON btItens 
     IMAGE-UP FILE "image/im-sub.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-sub.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Tarefas Relacionadas".

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

DEFINE BUTTON btPlan 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Planejar Tarefas da OS".

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

DEFINE VARIABLE desc-fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY .79 NO-UNDO.

DEFINE VARIABLE dt-prev AS DATE FORMAT "99/99/9999":U 
     LABEL "Data Prevista TÇrmino" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE hr-pend AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Horas Restantes" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79
     FGCOLOR 22  NO-UNDO.

DEFINE VARIABLE hr-real AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Horas Realizadas" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79 NO-UNDO.

DEFINE VARIABLE hr-tot AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total Horas" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.75.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 8.25.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      ordem-serv SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btPlan AT ROW 1.5 COL 70 WIDGET-ID 34
     hr-tot AT ROW 13 COL 31 COLON-ALIGNED WIDGET-ID 26
     ordem-serv.num-os AT ROW 4.75 COL 14 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     btItens AT ROW 1.5 COL 64
     ordem-serv.ds-os AT ROW 4.75 COL 31 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 52 BY .79
     ordem-serv.dt-os AT ROW 5.75 COL 14 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     desc-fav AT ROW 6.75 COL 19 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     ordem-serv.nome AT ROW 5.75 COL 31 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     btGoTo AT ROW 1.5 COL 48.43
     ordem-serv.situacao AT ROW 5.75 COL 60 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Criada",1,
                     "Atribu°da",2,
                     "Iniciada",3,
                     "Conclu°da",8,
                     "Cancelada",9
          DROP-DOWN-LIST
          SIZE 23 BY 1
     ordem-serv.cd-favorecido AT ROW 6.75 COL 14 COLON-ALIGNED WIDGET-ID 2
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btFirst AT ROW 1.5 COL 3
     ordem-serv.nr-pedido AT ROW 6.75 COL 74 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 8.86 BY .79
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     ordem-serv.obs-os AT ROW 7.75 COL 16 NO-LABEL WIDGET-ID 18
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 69 BY 4
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 15.5 COL 81.14
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 15.5 COL 75
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     hr-real AT ROW 14 COL 31 COLON-ALIGNED WIDGET-ID 28
     hr-pend AT ROW 13 COL 62 COLON-ALIGNED WIDGET-ID 30
     dt-prev AT ROW 14 COL 62 COLON-ALIGNED WIDGET-ID 32
     "Observaá∆o:" VIEW-AS TEXT
          SIZE 9 BY .54 AT ROW 7.75 COL 7 WIDGET-ID 20
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-11 AT ROW 12.5 COL 2 WIDGET-ID 24
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 16.38
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
         HEIGHT             = 16.38
         WIDTH              = 86.72
         MAX-HEIGHT         = 28.71
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 28.71
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
/* SETTINGS FOR FILL-IN ordem-serv.cd-favorecido IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN desc-fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       desc-fav:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN dt-prev IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN hr-pend IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN hr-real IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN hr-tot IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.ordem-serv"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
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
    {func\bt_add.i "num-os"}
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


&Scoped-define SELF-NAME btItens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btItens C-Win
ON CHOOSE OF btItens IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "tarefa-os.w"}
    RUN displayFields IN THIS-PROCEDURE.
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
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPlan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPlan C-Win
ON CHOOSE OF btPlan IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    FOR EACH tarefa OF ordem-serv:
        IF tarefa.dt-plan-ini = ? THEN
            ASSIGN tarefa.dt-plan-ini = tarefa.data-prev-ini.
        IF tarefa.dt-plan-fim = ? THEN
            ASSIGN tarefa.dt-plan-fim = tarefa.data-prev-fim.
    END.
    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Planejamento de Tarefas (060)', INPUT 'Planejamento atribu°do com sucesso!', INPUT 'As datas de planejamento das tarefas foram atribu°das com sucesso!')"}

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


&Scoped-define SELF-NAME ordem-serv.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ordem-serv.cd-favorecido C-Win
ON LEAVE OF ordem-serv.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="desc-fav"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ordem-serv.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF ordem-serv.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="ordem-serv.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="desc-fav"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ordem-serv.nr-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ordem-serv.nr-pedido C-Win
ON MOUSE-SELECT-DBLCLICK OF ordem-serv.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
OR F5 OF {&Table}.nr-pedido DO:
    DEFINE VARIABLE i-favorecido AS INTEGER NO-UNDO.
    ASSIGN i-favorecido = INPUT FRAME {&FRAME-NAME} ordem-serv.cd-favorecido.
    {func\zoom.i &Tabela="pedido"
                 &Campo1="nr-pedido"
                 &Tela1="ordem-serv.nr-pedido"
                 &CampoFiltro1="cd-favorecido"
                 &ValorFiltro1=STRING(i-favorecido)
                 &CampoFiltroIniFim1="situacao"
                 &ValorFiltroIni1="1"
                 &ValorFiltroFim1="2"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-fav
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = ordem-serv.cd-favorecido}

{func\calendar.i ordem-serv.dt-os}

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
  {version.i os}
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

IF ordem-serv.situacao = 9 /* Cancelada */ THEN DO:
    FOR EACH tarefa OF ordem-serv EXCLUSIVE-LOCK:
        ASSIGN tarefa.situacao = 9 /* Cancelada */.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\control_buttons.i}

IF lHabilita THEN DO:
    DISABLE btItens WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ENABLE btItens WITH FRAME {&FRAME-NAME}.
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

IF cAction = "ADD" THEN DO:
    ASSIGN ordem-serv.dt-os = TODAY
           ordem-serv.nome = gcUsuario.
END.

{func\cadastro\display.i}

APPLY "LEAVE" TO ordem-serv.cd-favorecido.

ASSIGN hr-tot = 0
       hr-real = 0
       hr-pend = 0
       dt-prev = TODAY - 1000.
FOR EACH tarefa OF ordem-serv NO-LOCK:
    ASSIGN hr-tot = hr-tot + tarefa.qtd-horas
           hr-real = hr-real + (tarefa.qtd-horas * (tarefa.perc-con / 100)).
    IF tarefa.data-prev-fim > dt-prev THEN
        ASSIGN dt-prev = tarefa.data-prev-fim.
END.
ASSIGN hr-pend = hr-tot - hr-real.
DISP hr-tot
     hr-real
     hr-pend
     dt-prev
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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY hr-tot desc-fav hr-real hr-pend dt-prev 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE ordem-serv THEN 
    DISPLAY ordem-serv.num-os ordem-serv.ds-os ordem-serv.dt-os ordem-serv.nome 
          ordem-serv.situacao ordem-serv.cd-favorecido ordem-serv.nr-pedido 
          ordem-serv.obs-os 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btPlan ordem-serv.num-os btItens ordem-serv.ds-os ordem-serv.dt-os 
         ordem-serv.nome btGoTo ordem-serv.situacao ordem-serv.cd-favorecido 
         btFirst ordem-serv.nr-pedido btLast btNext ordem-serv.obs-os btPrev 
         btAdd btDel btExit btUpdate btZoom RECT-4 RECT-5 RECT-11 
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

{func\cursor.i ordem-serv.cd-favorecido}
{func\cursor.i ordem-serv.nr-pedido}

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

IF cObject = "desc-fav" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} desc-fav NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN ordem-serv.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
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

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-ordem-serv NO-LOCK
        WHERE bf-ordem-serv.num-os = INPUT FRAME {&FRAME-NAME} ordem-serv.num-os
        AND   ROWID(bf-ordem-serv) <> ROWID(ordem-serv) NO-ERROR.
    IF AVAIL bf-ordem-serv THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction <> "DEL" THEN DO:
    IF NOT CAN-FIND(FIRST favorecido 
                    WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} ordem-serv.cd-favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Cliente inv†lido!"
                       &Ajuda     = "Deve ser informado um cliente v†lido para a Ordem de Serviáo."
                       &Campo     = ordem-serv.cd-favorecido}
    END.
    IF NOT CAN-FIND(FIRST pedido 
                    WHERE pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} ordem-serv.nr-pedido
                    AND   pedido.cd-favorecido = INPUT FRAME {&FRAME-NAME} ordem-serv.cd-favorecido
                    AND   pedido.situacao <= 2 /* Iniciado */) THEN DO:
        {func\valida.i &Mensagem  = "Pedido inv†lido!"
                       &Ajuda     = "Deve ser informado um pedido n∆o atendido do cliente para a Ordem de Serviáo."
                       &Campo     = ordem-serv.nr-pedido}
    END.
END.

IF cAction = "DEL" THEN DO:
    IF CAN-FIND(FIRST tarefa OF ordem-serv) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Essa Ordem de Serviáo j† possui tarefas relacionadas."}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

