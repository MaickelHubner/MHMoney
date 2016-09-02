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
&GLOBAL-DEFINE Table        tarefa
&GLOBAL-DEFINE Parent       usuario
&GLOBAL-DEFINE ParentField  nome
&GLOBAL-DEFINE KeyFields    tarefa.sequencia
&GLOBAL-DEFINE FrameFields  tarefa.dt-cri-tarefa tarefa.ds-tarefa ~
                            tarefa.cd-favorecido tarefa.perc-con ~
                            tarefa.dt-alert-tarefa tarefa.situacao ~
                            tarefa.ds-observacao tarefa.responsavel ~
                            tarefa.num-os tarefa.qtd-horas ~
                            tarefa.prioridade tarefa.data-prev-ini ~
                            tarefa.data-prev-fim tarefa.dt-ini-apos ~
                            tarefa.dt-real-ini tarefa.dt-real-fim ~
                            tarefa.seq-pedido-item tarefa.qtd-lib ~
                            tarefa.dt-plan-ini tarefa.dt-plan-fim
&GLOBAL-DEFINE FrameDisp    

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE r-atendimento AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-parent AS ROWID      NO-UNDO.

DEFINE NEW GLOBAL SHARED VARIABLE giNome      AS CHARACTER   NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE glCRM       AS LOGICAL     NO-UNDO.

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
&Scoped-define BROWSE-NAME br-apont

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES apontamento atendimento

/* Definitions for BROWSE br-apont                                      */
&Scoped-define FIELDS-IN-QUERY-br-apont apontamento.nome apontamento.data ~
apontamento.hora-ini apontamento.hora-fim apontamento.qt-apontada 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-apont 
&Scoped-define QUERY-STRING-br-apont FOR EACH apontamento ~
      WHERE apontamento.nome-tarefa = tarefa.nome ~
AND   apontamento.seq-tarefa = tarefa.sequencia NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-apont OPEN QUERY br-apont FOR EACH apontamento ~
      WHERE apontamento.nome-tarefa = tarefa.nome ~
AND   apontamento.seq-tarefa = tarefa.sequencia NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-apont apontamento
&Scoped-define FIRST-TABLE-IN-QUERY-br-apont apontamento


/* Definitions for BROWSE br-atend                                      */
&Scoped-define FIELDS-IN-QUERY-br-atend atendimento.data atendimento.hora ~
atendimento.usuario atendimento.contato 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-atend 
&Scoped-define QUERY-STRING-br-atend FOR EACH atendimento ~
      WHERE atendimento.nome = INPUT FRAME {&FRAME-NAME} tarefa.nome ~
 AND atendimento.sequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia NO-LOCK ~
    BY atendimento.data DESCENDING ~
       BY atendimento.hora DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-atend OPEN QUERY br-atend FOR EACH atendimento ~
      WHERE atendimento.nome = INPUT FRAME {&FRAME-NAME} tarefa.nome ~
 AND atendimento.sequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia NO-LOCK ~
    BY atendimento.data DESCENDING ~
       BY atendimento.hora DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-atend atendimento
&Scoped-define FIRST-TABLE-IN-QUERY-br-atend atendimento


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-apont}~
    ~{&OPEN-QUERY-br-atend}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS tarefa.nome tarefa.perc-con tarefa.situacao ~
tarefa.responsavel tarefa.ds-tarefa tarefa.cd-favorecido ~
tarefa.ds-observacao tarefa.dt-alert-tarefa tarefa.dt-plan-ini ~
tarefa.dt-real-ini tarefa.dt-plan-fim tarefa.dt-real-fim tarefa.num-os ~
tarefa.prioridade tarefa.seq-pedido-item tarefa.dt-ini-apos ~
tarefa.data-prev-ini tarefa.data-prev-fim tarefa.qtd-horas tarefa.qtd-lib 
&Scoped-define ENABLED-TABLES tarefa
&Scoped-define FIRST-ENABLED-TABLE tarefa
&Scoped-Define ENABLED-OBJECTS desc-fav br-atend obs-atend cb-pred br-apont ~
bt-eliminar-atend bt-incluir-atend bt-modificar-atend RECT-2 RECT-9 RECT-10 ~
RECT-21 
&Scoped-Define DISPLAYED-FIELDS tarefa.nome tarefa.perc-con ~
tarefa.sequencia tarefa.situacao tarefa.responsavel tarefa.ds-tarefa ~
tarefa.cd-favorecido tarefa.ds-observacao tarefa.dt-cri-tarefa ~
tarefa.dt-alert-tarefa tarefa.dt-plan-ini tarefa.dt-real-ini ~
tarefa.dt-plan-fim tarefa.dt-real-fim tarefa.num-os tarefa.prioridade ~
tarefa.seq-pedido-item tarefa.dt-ini-apos tarefa.data-prev-ini ~
tarefa.data-prev-fim tarefa.qtd-horas tarefa.qtd-lib 
&Scoped-define DISPLAYED-TABLES tarefa
&Scoped-define FIRST-DISPLAYED-TABLE tarefa
&Scoped-Define DISPLAYED-OBJECTS desc-fav obs-atend cb-pred de-tot-hrs ~
de-tot-apont de-tot-saldo de-tot-con obs-apont 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-eliminar-atend 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON bt-incluir-atend 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON bt-modificar-atend 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

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

DEFINE VARIABLE cb-pred AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Predecessora" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0","1"
     DROP-DOWN-LIST
     SIZE 49 BY 1 NO-UNDO.

DEFINE VARIABLE obs-apont AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 62 BY 2.5 NO-UNDO.

DEFINE VARIABLE obs-atend AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 60 BY 5.25 NO-UNDO.

DEFINE VARIABLE de-tot-apont AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Horas Apontadas" 
     VIEW-AS FILL-IN 
     SIZE 9.86 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-con AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "% Conclus∆o Estimado" 
     VIEW-AS FILL-IN 
     SIZE 9.86 BY .79
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE de-tot-hrs AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Horas Faltantes" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE de-tot-saldo AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Saldo Horas" 
     VIEW-AS FILL-IN 
     SIZE 9.86 BY .79 NO-UNDO.

DEFINE VARIABLE desc-fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62 BY 4.75.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 123 BY 1.5.

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62 BY 3.25.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 60 BY 9.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-apont FOR 
      apontamento SCROLLING.

DEFINE QUERY br-atend FOR 
      atendimento SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-apont C-Win _STRUCTURED
  QUERY br-apont NO-LOCK DISPLAY
      apontamento.nome FORMAT "X(8)":U WIDTH 8
      apontamento.data FORMAT "99/99/9999":U
      apontamento.hora-ini FORMAT "x(5)":U WIDTH 5
      apontamento.hora-fim FORMAT "x(5)":U WIDTH 6
      apontamento.qt-apontada FORMAT "->>,>>9.99":U WIDTH 9
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 62 BY 9.25
         FONT 7
         TITLE "Apontamentos da Tarefa".

DEFINE BROWSE br-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-atend C-Win _STRUCTURED
  QUERY br-atend NO-LOCK DISPLAY
      atendimento.data FORMAT "99/99/9999":U
      atendimento.hora FORMAT "x(05)":U WIDTH 4
      atendimento.usuario FORMAT "x(20)":U WIDTH 7
      atendimento.contato FORMAT "x(60)":U WIDTH 28
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 60 BY 5.25
         FONT 7
         TITLE "Atendimentos da Tarefa".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     tarefa.nome AT ROW 1.5 COL 12 COLON-ALIGNED WIDGET-ID 30
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     tarefa.perc-con AT ROW 1.5 COL 51 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     tarefa.sequencia AT ROW 3.5 COL 10 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     tarefa.situacao AT ROW 3.5 COL 24.43 COLON-ALIGNED WIDGET-ID 32
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Pendente",1,
                     "Em Andamento",2,
                     "Conclu°da",8,
                     "Cancelada",9
          DROP-DOWN-LIST
          SIZE 15 BY 1
     tarefa.responsavel AT ROW 3.5 COL 50 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     tarefa.ds-tarefa AT ROW 4.5 COL 10 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 49 BY .79
     tarefa.cd-favorecido AT ROW 5.5 COL 10 COLON-ALIGNED WIDGET-ID 16
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     desc-fav AT ROW 5.5 COL 15 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     tarefa.ds-observacao AT ROW 6.5 COL 12 NO-LABEL WIDGET-ID 34
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 28 BY 5.75
     btCancel AT ROW 23.25 COL 119
     tarefa.dt-cri-tarefa AT ROW 6.5 COL 49 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.dt-alert-tarefa AT ROW 7.5 COL 49 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.dt-plan-ini AT ROW 8.5 COL 49 COLON-ALIGNED WIDGET-ID 94
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.dt-real-ini AT ROW 9.5 COL 49 COLON-ALIGNED WIDGET-ID 72
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.dt-plan-fim AT ROW 10.54 COL 49 COLON-ALIGNED WIDGET-ID 92
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.dt-real-fim AT ROW 11.5 COL 49 COLON-ALIGNED WIDGET-ID 70
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     br-atend AT ROW 12.75 COL 2 WIDGET-ID 100
     obs-atend AT ROW 18 COL 2 NO-LABEL WIDGET-ID 42
     tarefa.num-os AT ROW 3.5 COL 73 COLON-ALIGNED WIDGET-ID 62
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     btOK AT ROW 23.25 COL 113
     tarefa.prioridade AT ROW 3.5 COL 116 COLON-ALIGNED WIDGET-ID 64
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     tarefa.seq-pedido-item AT ROW 4.5 COL 73 COLON-ALIGNED WIDGET-ID 90
          LABEL "Item do Pedido"
          VIEW-AS COMBO-BOX SORT INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 49 BY 1
     tarefa.dt-ini-apos AT ROW 5.5 COL 73 COLON-ALIGNED WIDGET-ID 68
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.data-prev-ini AT ROW 5.5 COL 93 COLON-ALIGNED WIDGET-ID 60
          LABEL "Prev. In°cio"
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     tarefa.data-prev-fim AT ROW 5.5 COL 112 COLON-ALIGNED WIDGET-ID 58
          LABEL "Prev. Fim"
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     cb-pred AT ROW 6.5 COL 73 COLON-ALIGNED WIDGET-ID 74
     tarefa.qtd-horas AT ROW 8.25 COL 73 COLON-ALIGNED WIDGET-ID 66
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.86 BY 24.04
         FONT 7.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     tarefa.qtd-lib AT ROW 9.25 COL 73 COLON-ALIGNED WIDGET-ID 76
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     de-tot-hrs AT ROW 10.25 COL 73 COLON-ALIGNED WIDGET-ID 86
     de-tot-apont AT ROW 8.25 COL 112 COLON-ALIGNED WIDGET-ID 80
     de-tot-saldo AT ROW 9.25 COL 112 COLON-ALIGNED WIDGET-ID 82
     de-tot-con AT ROW 10.25 COL 112 COLON-ALIGNED WIDGET-ID 84
     br-apont AT ROW 11.5 COL 63 WIDGET-ID 200
     obs-apont AT ROW 20.75 COL 63 NO-LABEL WIDGET-ID 88
     bt-eliminar-atend AT ROW 23.25 COL 14 WIDGET-ID 50
     bt-incluir-atend AT ROW 23.25 COL 2 WIDGET-ID 52
     bt-modificar-atend AT ROW 23.25 COL 8 WIDGET-ID 54
     "Observaá∆o:" VIEW-AS TEXT
          SIZE 9 BY .54 AT ROW 6.75 COL 3 WIDGET-ID 36
     RECT-2 AT ROW 1.25 COL 2
     RECT-9 AT ROW 3 COL 2 WIDGET-ID 40
     RECT-10 AT ROW 3 COL 63 WIDGET-ID 56
     RECT-21 AT ROW 8 COL 63 WIDGET-ID 78
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.86 BY 24.04
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
         HEIGHT             = 24.04
         WIDTH              = 124.86
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 148
         VIRTUAL-HEIGHT     = 30.04
         VIRTUAL-WIDTH      = 148
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
/* BROWSE-TAB br-atend dt-real-fim DEFAULT-FRAME */
/* BROWSE-TAB br-apont de-tot-con DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN tarefa.cd-favorecido IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN tarefa.data-prev-fim IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN tarefa.data-prev-ini IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN de-tot-apont IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-con IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-hrs IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-saldo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN tarefa.dt-cri-tarefa IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR obs-apont IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       obs-apont:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

ASSIGN 
       obs-atend:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR COMBO-BOX tarefa.seq-pedido-item IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN tarefa.sequencia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-apont
/* Query rebuild information for BROWSE br-apont
     _TblList          = "money.apontamento"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "apontamento.nome-tarefa = tarefa.nome
AND   apontamento.seq-tarefa = tarefa.sequencia"
     _FldNameList[1]   > money.apontamento.nome
"apontamento.nome" ? ? "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = money.apontamento.data
     _FldNameList[3]   > money.apontamento.hora-ini
"apontamento.hora-ini" ? ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.apontamento.hora-fim
"apontamento.hora-fim" ? ? "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > money.apontamento.qt-apontada
"apontamento.qt-apontada" ? ? "decimal" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br-apont */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-atend
/* Query rebuild information for BROWSE br-atend
     _TblList          = "money.atendimento"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.atendimento.data|no,money.atendimento.hora|no"
     _Where[1]         = "atendimento.nome = INPUT FRAME {&FRAME-NAME} tarefa.nome
 AND atendimento.sequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia"
     _FldNameList[1]   = money.atendimento.data
     _FldNameList[2]   > money.atendimento.hora
"atendimento.hora" ? ? "character" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.atendimento.usuario
"atendimento.usuario" ? ? "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.atendimento.contato
"atendimento.contato" ? ? "character" ? ? ? ? ? ? no ? no no "28" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br-atend */
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


&Scoped-define BROWSE-NAME br-apont
&Scoped-define SELF-NAME br-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-apont C-Win
ON VALUE-CHANGED OF br-apont IN FRAME DEFAULT-FRAME /* Apontamentos da Tarefa */
DO:
  
    IF AVAIL apontamento THEN
        ASSIGN obs-apont:SCREEN-VALUE = apontamento.ds-apontamento.
    ELSE
        ASSIGN obs-apont:SCREEN-VALUE = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-atend
&Scoped-define SELF-NAME br-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-atend C-Win
ON MOUSE-SELECT-DBLCLICK OF br-atend IN FRAME DEFAULT-FRAME /* Atendimentos da Tarefa */
DO:
  
    APPLY "CHOOSE" TO bt-modificar-atend.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-atend C-Win
ON VALUE-CHANGED OF br-atend IN FRAME DEFAULT-FRAME /* Atendimentos da Tarefa */
DO:
  
    IF AVAIL atendimento THEN
        ASSIGN obs-atend:SCREEN-VALUE = atendimento.observacao.
    ELSE
        ASSIGN obs-atend:SCREEN-VALUE = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-eliminar-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-eliminar-atend C-Win
ON CHOOSE OF bt-eliminar-atend IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    IF AVAIL atendimento THEN DO:
        {func\bt_del_page.i atendimento}  
        {&OPEN-QUERY-br-atend}
        APPLY "VALUE-CHANGED" TO br-atend.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-incluir-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluir-atend C-Win
ON CHOOSE OF bt-incluir-atend IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} tarefa.cd-favorecido NO-ERROR.
    IF AVAIL favorecido THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN pcActionBT = "ADD"
               r-parent = ROWID(favorecido)
               giNome = INPUT FRAME {&FRAME-NAME} tarefa.nome
               giSequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia.
        {func\run.i &Programa = "atendimento_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-br-atend}
            APPLY "VALUE-CHANGED" TO br-atend.
            ASSIGN tarefa.situacao:SCREEN-VALUE = "2".
            DISABLE btCancel
                WITH FRAME {&FRAME-NAME}.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-modificar-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-modificar-atend C-Win
ON CHOOSE OF bt-modificar-atend IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    IF AVAIL atendimento THEN DO:
        FIND FIRST favorecido NO-LOCK
            WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} tarefa.cd-favorecido NO-ERROR.
        IF AVAIL favorecido THEN DO:
            RUN som.p(INPUT "music\click.wav").
            ASSIGN pcActionBT = "UPDATE"
                   r-parent = ROWID(favorecido)
                   r-atendimento = ROWID(atendimento)
                   giNome = INPUT FRAME {&FRAME-NAME} tarefa.nome
                   giSequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia.
            {func\run.i &Programa = "atendimento_det.w"}
            IF RETURN-VALUE = "OK" THEN DO:
                {&OPEN-QUERY-br-atend}
                APPLY "VALUE-CHANGED" TO br-atend.
                ASSIGN tarefa.situacao:SCREEN-VALUE = "2".
                DISABLE btCancel
                    WITH FRAME {&FRAME-NAME}.
            END.
        END.
    END.
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


&Scoped-define SELF-NAME cb-pred
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb-pred C-Win
ON VALUE-CHANGED OF cb-pred IN FRAME DEFAULT-FRAME /* Predecessora */
DO:
  
    FIND FIRST bf-tarefa NO-LOCK
        WHERE bf-tarefa.nome = ENTRY(2, cb-pred:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
        AND   bf-tarefa.sequencia = INT(ENTRY(1, cb-pred:SCREEN-VALUE, "-")) NO-ERROR.
    IF AVAIL bf-tarefa THEN DO:
        ASSIGN tarefa.dt-ini-apos:SCREEN-VALUE = STRING(bf-tarefa.data-prev-fim + 1).
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.cd-favorecido C-Win
ON LEAVE OF tarefa.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc="ds-favorecido"
                  &Tela="desc-fav"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF tarefa.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="tarefa.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="desc-fav"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.num-os
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.num-os C-Win
ON LEAVE OF tarefa.num-os IN FRAME DEFAULT-FRAME /* N£mero OS */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} tarefa.num-os <> 0 THEN DO:

        FIND FIRST ordem-serv NO-LOCK
            WHERE ordem-serv.num-os = INPUT FRAME {&FRAME-NAME} tarefa.num-os NO-ERROR.
        IF AVAIL ordem-serv THEN DO:

            FIND FIRST pedido OF ordem-serv NO-LOCK NO-ERROR.
            IF AVAIL pedido THEN DO:

                ASSIGN tarefa.seq-pedido-item:LIST-ITEM-PAIRS = "Avulso (Sem Apontamento),0".
                FOR EACH pedido-item OF pedido NO-LOCK:
                    ASSIGN tarefa.seq-pedido-item:LIST-ITEM-PAIRS = tarefa.seq-pedido-item:LIST-ITEM-PAIRS + "," + pedido-item.ds-pedido-item + "," + STRING(pedido-item.sequencia).
                END.

            END.

        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.perc-con
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.perc-con C-Win
ON LEAVE OF tarefa.perc-con IN FRAME DEFAULT-FRAME /* % Conclus∆o */
DO:
  
    RUN recalc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.qtd-horas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.qtd-horas C-Win
ON LEAVE OF tarefa.qtd-horas IN FRAME DEFAULT-FRAME /* Qtde Horas */
DO:

    RUN calc_qtd_lib.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.qtd-lib
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.qtd-lib C-Win
ON LEAVE OF tarefa.qtd-lib IN FRAME DEFAULT-FRAME /* Qtde Hr Lib */
DO:
  
    RUN recalc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.responsavel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.responsavel C-Win
ON LEAVE OF tarefa.responsavel IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
  
    IF tarefa.responsavel <> INPUT FRAME {&FRAME-NAME} tarefa.responsavel THEN DO:
        FIND LAST bf-tarefa NO-LOCK
            WHERE bf-tarefa.responsavel = INPUT FRAME {&FRAME-NAME} tarefa.responsavel
            AND   bf-tarefa.situacao < 8 /* Conclu°da */
            AND   bf-tarefa.num-os <> 0 USE-INDEX prior NO-ERROR.

        ASSIGN tarefa.prioridade = (IF AVAIL bf-tarefa THEN bf-tarefa.prioridade + 1 ELSE 1).
        DISP tarefa.prioridade
            WITH FRAME {&FRAME-NAME}.
    END.

    RUN calc_qtd_lib.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tarefa.situacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tarefa.situacao C-Win
ON VALUE-CHANGED OF tarefa.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:

    IF INPUT FRAME {&FRAME-NAME} tarefa.situacao = 2 /* Em andamento */ THEN DO:
        IF INPUT FRAME {&FRAME-NAME} tarefa.dt-real-ini = ? THEN DO:
            ASSIGN tarefa.dt-real-ini:SCREEN-VALUE = STRING(TODAY, "99/99/9999").
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} tarefa.situacao = 8 /* Concluida */ THEN DO:
        ASSIGN tarefa.perc-con:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "100,00".
    END.
    ELSE DO:
        DISP tarefa.perc-con
            WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-apont
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-fav
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = tarefa.cd-favorecido}
{func\calendar.i tarefa.dt-alert-tarefa}
                          
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
  {version.i tarefa_det}
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

    IF tarefa.situacao >= 8 /* Conclu°da */ THEN DO:
        ASSIGN tarefa.prioridade = 999999
               tarefa.data-prev-fim = TODAY.
        IF tarefa.dt-real-fim = ? THEN
            ASSIGN tarefa.dt-real-fim = TODAY.
        IF tarefa.situacao = 8 /* Conclu°da */ THEN
            ASSIGN tarefa.perc-con = 100.
    END.

    IF tarefa.situacao > 1 /* Pendente */
    AND tarefa.dt-real-ini = ? THEN
        ASSIGN tarefa.dt-real-ini = TODAY.

    IF tarefa.num-os <> 0 THEN DO:
        RUN calc_prioridade.p (INPUT tarefa.responsavel,
                               INPUT TODAY).

        FIND FIRST ordem-serv OF tarefa EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL ordem-serv THEN DO:
            ASSIGN ordem-serv.situacao = 2 /* Atribuida */.
            IF CAN-FIND(FIRST tarefa OF ordem-serv
                        WHERE tarefa.situacao >= 2 /* Em Andamento */) THEN
                ASSIGN ordem-serv.situacao = 3 /* Iniciada */.
            IF NOT CAN-FIND(FIRST tarefa OF ordem-serv
                            WHERE tarefa.situacao < 8 /* Conclu°da */) THEN
                ASSIGN ordem-serv.situacao = 8 /* Conclu°da */.
        END.
    
    END.

    ASSIGN tarefa.rest-nome = ENTRY(2, cb-pred:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
           tarefa.rest-sequencia = INT(ENTRY(1, cb-pred:SCREEN-VALUE, "-")).

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

    FIND LAST bf-tarefa NO-LOCK
        WHERE bf-tarefa.nome = usuario.nome NO-ERROR.
    IF AVAIL bf-tarefa THEN
        ASSIGN tarefa.sequencia = bf-tarefa.sequencia + 1.
    ELSE
        ASSIGN tarefa.sequencia = 1.

    IF tarefa.dt-cri-tarefa = ? THEN
        ASSIGN tarefa.dt-cri-tarefa = TODAY.
        
    ASSIGN tarefa.responsavel = usuario.nome.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calc_qtd_lib C-Win 
PROCEDURE calc_qtd_lib :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
    DEFINE VARIABLE de-aux AS DECIMAL     NO-UNDO.

    IF INPUT FRAME {&FRAME-NAME} tarefa.qtd-horas <> tarefa.qtd-horas
    OR INPUT FRAME {&FRAME-NAME} tarefa.responsavel <> tarefa.responsavel THEN DO:
        FIND FIRST usuario NO-LOCK
            WHERE usuario.nome = INPUT FRAME {&FRAME-NAME} tarefa.responsavel NO-ERROR.
        IF AVAIL usuario THEN DO:
            ASSIGN de-aux = INPUT FRAME {&FRAME-NAME} tarefa.qtd-horas * usuario.performance
                   tarefa.qtd-lib:SCREEN-VALUE = STRING(de-aux).
        END.
        ELSE DO:
            ASSIGN tarefa.qtd-lib:SCREEN-VALUE = tarefa.qtd-horas:SCREEN-VALUE.
        END.
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
DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.

ASSIGN tarefa.seq-pedido-item:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = ",0".
IF tarefa.num-os <> 0 THEN DO:
    FIND FIRST ordem-serv NO-LOCK
        WHERE ordem-serv.num-os = tarefa.num-os NO-ERROR.
    IF AVAIL ordem-serv THEN DO:
        FIND FIRST pedido OF ordem-serv NO-LOCK NO-ERROR.
        IF AVAIL pedido THEN DO:
            ASSIGN cAux = "Avulso (Sem Apontamento),0".
            FOR EACH pedido-item OF pedido NO-LOCK:
                ASSIGN cAux = cAux + "," + pedido-item.ds-pedido-item + "," + STRING(pedido-item.sequencia, ">>>9").
            END.
            ASSIGN tarefa.seq-pedido-item:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = cAux.
        END.
    END.
    DISP tarefa.seq-pedido-item.
END.

{func\detalhe\display.i}

APPLY "LEAVE" TO tarefa.cd-favorecido.

{&OPEN-QUERY-br-atend}
APPLY "VALUE-CHANGED" TO br-atend.

{&OPEN-QUERY-br-apont}
APPLY "VALUE-CHANGED" TO br-apont.

FIND FIRST ordem-serv OF tarefa NO-LOCK NO-ERROR.
IF AVAIL ordem-serv THEN DO:

    IF ordem-serv.nome <> gcUsuario THEN DO:
        DISABLE tarefa.qtd-horas
                tarefa.qtd-lib
                tarefa.num-os
                tarefa.seq-pedido-item
                tarefa.dt-ini-apos
                tarefa.dt-plan-ini
                tarefa.dt-plan-fim
                cb-pred
            WITH FRAME {&FRAME-NAME}.
    END.

END.
ELSE DO:
    DISABLE tarefa.qtd-horas
            tarefa.qtd-lib
            tarefa.num-os
            tarefa.seq-pedido-item
            tarefa.dt-ini-apos
            tarefa.dt-plan-ini
            tarefa.dt-plan-fim
            cb-pred
        WITH FRAME {&FRAME-NAME}.
END.

DISABLE tarefa.dt-real-ini
        tarefa.dt-real-fim
        tarefa.prioridade
        tarefa.data-prev-ini
        tarefa.data-prev-fim
    WITH FRAME {&FRAME-NAME}.

IF tarefa.num-os = 0 THEN
    DISABLE tarefa.dt-ini-apos
            cb-pred
        WITH FRAME {&FRAME-NAME}.

RUN recalc.

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
  DISPLAY desc-fav obs-atend cb-pred de-tot-hrs de-tot-apont de-tot-saldo 
          de-tot-con obs-apont 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE tarefa THEN 
    DISPLAY tarefa.nome tarefa.perc-con tarefa.sequencia tarefa.situacao 
          tarefa.responsavel tarefa.ds-tarefa tarefa.cd-favorecido 
          tarefa.ds-observacao tarefa.dt-cri-tarefa tarefa.dt-alert-tarefa 
          tarefa.dt-plan-ini tarefa.dt-real-ini tarefa.dt-plan-fim 
          tarefa.dt-real-fim tarefa.num-os tarefa.prioridade 
          tarefa.seq-pedido-item tarefa.dt-ini-apos tarefa.data-prev-ini 
          tarefa.data-prev-fim tarefa.qtd-horas tarefa.qtd-lib 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE tarefa.nome tarefa.perc-con tarefa.situacao tarefa.responsavel 
         tarefa.ds-tarefa tarefa.cd-favorecido desc-fav tarefa.ds-observacao 
         tarefa.dt-alert-tarefa tarefa.dt-plan-ini tarefa.dt-real-ini 
         tarefa.dt-plan-fim tarefa.dt-real-fim br-atend obs-atend tarefa.num-os 
         tarefa.prioridade tarefa.seq-pedido-item tarefa.dt-ini-apos 
         tarefa.data-prev-ini tarefa.data-prev-fim cb-pred tarefa.qtd-horas 
         tarefa.qtd-lib br-apont bt-eliminar-atend bt-incluir-atend 
         bt-modificar-atend RECT-2 RECT-9 RECT-10 RECT-21 
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
DEFINE VARIABLE cLista AS CHARACTER   NO-UNDO INITIAL ",0-".

{func\detalhe\initialize.i}

IF INPUT FRAME {&FRAME-NAME} tarefa.num-os <> 0 THEN DO:
    FOR EACH bf-tarefa NO-LOCK
        WHERE bf-tarefa.num-os = INPUT FRAME {&FRAME-NAME} tarefa.num-os:
        IF bf-tarefa.sequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia
        AND bf-tarefa.nome = INPUT FRAME {&FRAME-NAME} tarefa.nome THEN NEXT.
        ASSIGN cLista = cLista + "," + bf-tarefa.ds-tarefa + "," + STRING(bf-tarefa.sequencia) + "-" + bf-tarefa.nome.
    END.
    ASSIGN cb-pred:LIST-ITEM-PAIRS = cLista
           cb-pred = STRING(tarefa.rest-sequencia) + "-" + tarefa.rest-nome.

    DISPLAY cb-pred
        WITH FRAME {&FRAME-NAME}.
END.

{func\cursor.i tarefa.cd-favorecido}

DISABLE tarefa.sequencia
        tarefa.dt-cri-tarefa
    WITH FRAME {&FRAME-NAME}.

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
        ASSIGN tarefa.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalc C-Win 
PROCEDURE recalc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN de-tot-apont = 0
           de-tot-saldo = 0
           de-tot-con = 0
           de-tot-hrs = 0.

    FOR EACH apontamento
        WHERE apontamento.nome-tarefa = tarefa.nome
        AND   apontamento.seq-tarefa = tarefa.sequencia:

        ASSIGN de-tot-apont = de-tot-apont + apontamento.qt-apontada.

    END.

    ASSIGN de-tot-saldo = INPUT FRAME {&FRAME-NAME} tarefa.qtd-lib - de-tot-apont
           de-tot-con = ((INPUT FRAME {&FRAME-NAME} tarefa.qtd-lib - de-tot-saldo) / INPUT FRAME {&FRAME-NAME} tarefa.qtd-lib) * 100
           de-tot-hrs = (((de-tot-apont * 100) / INPUT FRAME {&FRAME-NAME} tarefa.perc-con) - de-tot-apont).

    DISP de-tot-apont
         de-tot-saldo
         de-tot-con
         de-tot-hrs
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
    FIND FIRST bf-tarefa NO-LOCK
        WHERE bf-tarefa.nome = INPUT FRAME {&FRAME-NAME} tarefa.nome
        AND   bf-tarefa.sequencia = INPUT FRAME {&FRAME-NAME} tarefa.sequencia
        AND   ROWID(bf-tarefa) <> ROWID(tarefa) NO-ERROR.
    IF AVAIL bf-tarefa THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "UPDATE" THEN DO:
    IF INPUT FRAME {&FRAME-NAME} tarefa.situacao = 1 /* Pendente */
    AND NOT glCRM
    AND INPUT FRAME {&FRAME-NAME} tarefa.num-os = 0
    AND INPUT FRAME {&FRAME-NAME} tarefa.responsavel = tarefa.responsavel THEN DO:
        {func\valida.i &Mensagem  = "Situaá∆o inv†lida!"
                       &Ajuda     = "Para modificar uma tarefa a situaá∆o n∆o pode ser Pendente."
                       &Campo     = tarefa.situacao}
    END.

    IF  INPUT FRAME {&FRAME-NAME} tarefa.situacao = 1 /* Pendente */
    AND INPUT FRAME {&FRAME-NAME} tarefa.responsavel = tarefa.responsavel
    AND INPUT FRAME {&FRAME-NAME} tarefa.perc-con <> 0
        OR CAN-FIND(FIRST apontamento NO-LOCK
                    WHERE apontamento.nome-tarefa = tarefa.nome
                    AND   apontamento.seq-tarefa  = tarefa.sequencia
                    AND   INPUT FRAME {&FRAME-NAME} tarefa.situacao = 1 /* Pendente */) THEN DO:
        
        {func\valida.i &Mensagem  = "Situaá∆o inv†lida!"
                       &Ajuda     = "N∆o Ç poss°vel alterar uma tarefa em Andamento para situaá∆o Pendente!"
                       &Campo     = tarefa.situacao}
    END.

    IF  INPUT FRAME {&FRAME-NAME} tarefa.situacao = 8 /* Conclu°da*/
    AND INPUT FRAME {&FRAME-NAME} tarefa.perc-con <> 100 THEN DO:
        {func\valida.i &Mensagem  = "Percentual inv†lido!"
                       &Ajuda     = "Tarefas conclu°das devem ter percentual de conclus∆o de 100%"
                       &Campo     = tarefa.situacao}
    END.


END.
IF pcActionBT <> "DELETE" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} tarefa.cd-favorecido NO-ERROR.
    IF NOT AVAIL favorecido THEN DO:
        {func\valida.i &Mensagem  = "Cliente n∆o existente!"
                       &Ajuda     = "Vocà deve informar um cliente existente."
                       &Campo     = tarefa.cd-favorecido}
    END.
    ELSE DO:
        IF favorecido.tipo = 2 /* Fornecedor */ THEN DO:
            {func\valida.i &Mensagem  = "Favorecido n∆o Ç cliente!"
                           &Ajuda     = "Vocà deve informar um favorecido do tipo Cliente ou Ambos."
                           &Campo     = tarefa.cd-favorecido}
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} tarefa.situacao = 2 /* Em Andamento */
    AND INPUT FRAME {&FRAME-NAME} tarefa.perc-con = 0 THEN DO:
        {func\valida.i &Mensagem  = "Percentual de Conclus∆o inv†lido!"
                       &Ajuda     = "Informe o percentual de conclus∆o para a tarefa Em Andamento."
                       &Campo     = tarefa.perc-con}
    END.

    IF INPUT FRAME {&FRAME-NAME} tarefa.num-os <> 0
    AND INPUT FRAME {&FRAME-NAME} tarefa.qtd-horas = 0 THEN DO:
        {func\valida.i &Mensagem  = "Quantidade de Horas inv†lida!"
                       &Ajuda     = "Informe a quantidade de horas necess†rias para conclus∆o da tarefa."
                       &Campo     = tarefa.qtd-horas}
    END.

    IF INDEX(INPUT FRAME {&FRAME-NAME} tarefa.ds-tarefa, ",") <> 0 THEN DO:
        {func\valida.i &Mensagem  = "Descriá∆o da tarefa inv†lida!"
                       &Ajuda     = "Vocà n∆o pode utilizar v°rgula na descriá∆o de uma tarefa."
                       &Campo     = tarefa.ds-tarefa}
    END.

END.

ASSIGN glCRM = FALSE.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

