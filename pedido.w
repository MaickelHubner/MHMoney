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

DEF VAR de-valor-antecip LIKE pedido.val-total.

/* Parameters Definitions ---                                           */

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        pedido
&GLOBAL-DEFINE KeyFields    pedido.nr-pedido
&GLOBAL-DEFINE FrameFields  pedido.num-cliente pedido.cd-favorecido ~
                            pedido.dt-pedido pedido.cliente-fat ~
                            pedido.situacao pedido.val-total ~
                            pedido.rua pedido.numero ~
                            pedido.complemento pedido.cidade ~
                            pedido.bairro pedido.telefone ~
                            pedido.cep pedido.ds-observacao ~
                            pedido.pc-impto pedido.val-itens ~
                            pedido.val-impostos pedido.val-desconto ~
                            pedido.nom-projeto pedido.dt-previsao-fat ~
                            pedido.estado des-cli des-cli-fat ~
                            pedido.dias-garantia pedido.responsavel ~
                            pedido.nps pedido.ds-obs-cli pedido.dt-aprovacao ~
                            pedido.dt-lib-homolog pedido.dt-encerramento ~
                            pedido.prob-fec pedido.dt-validade ~
                            pedido.usuar-indicacao
                            

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE dt-ped    AS DATE        NO-UNDO.

/* Buffers */

DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.

{func\data.i}
{func\definitions.i}
{viab.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES pedido favorecido

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME pedido.nr-pedido ~
pedido.situacao pedido.cd-favorecido pedido.nom-projeto pedido.num-cliente ~
pedido.dias-garantia pedido.prob-fec pedido.cliente-fat pedido.responsavel ~
pedido.usuar-indicacao pedido.dt-pedido pedido.dt-validade ~
pedido.dt-aprovacao pedido.dt-lib-homolog pedido.dt-previsao-fat ~
pedido.dt-encerramento pedido.val-itens pedido.pc-impto pedido.val-impostos ~
pedido.val-desconto pedido.val-total pedido.nps pedido.ds-obs-cli ~
pedido.ds-observacao pedido.rua pedido.numero pedido.complemento pedido.cep ~
pedido.cidade pedido.estado pedido.bairro pedido.telefone 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME pedido.nr-pedido ~
pedido.situacao pedido.cd-favorecido pedido.nom-projeto pedido.num-cliente ~
pedido.dias-garantia pedido.prob-fec pedido.cliente-fat pedido.responsavel ~
pedido.usuar-indicacao pedido.dt-pedido pedido.dt-validade ~
pedido.dt-aprovacao pedido.dt-lib-homolog pedido.dt-previsao-fat ~
pedido.dt-encerramento pedido.val-itens pedido.pc-impto pedido.val-impostos ~
pedido.val-desconto pedido.val-total pedido.nps pedido.ds-obs-cli ~
pedido.ds-observacao pedido.rua pedido.numero pedido.complemento pedido.cep ~
pedido.cidade pedido.estado pedido.bairro pedido.telefone 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH pedido SHARE-LOCK, ~
      EACH favorecido OF pedido SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH pedido SHARE-LOCK, ~
      EACH favorecido OF pedido SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME pedido favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME favorecido


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS pedido.nr-pedido pedido.situacao ~
pedido.cd-favorecido pedido.nom-projeto pedido.num-cliente ~
pedido.dias-garantia pedido.prob-fec pedido.cliente-fat pedido.responsavel ~
pedido.usuar-indicacao pedido.dt-pedido pedido.dt-validade ~
pedido.dt-aprovacao pedido.dt-lib-homolog pedido.dt-previsao-fat ~
pedido.dt-encerramento pedido.val-itens pedido.pc-impto pedido.val-impostos ~
pedido.val-desconto pedido.val-total pedido.nps pedido.ds-obs-cli ~
pedido.ds-observacao pedido.rua pedido.numero pedido.complemento pedido.cep ~
pedido.cidade pedido.estado pedido.bairro pedido.telefone 
&Scoped-define ENABLED-TABLES pedido
&Scoped-define FIRST-ENABLED-TABLE pedido
&Scoped-Define ENABLED-OBJECTS des-cli btViab des-cli-fat btAntecip btFaixa ~
btGoTo btFirst btLast btNext btPrev btAdd btDel btExit btUpdate btZoom ~
RECT-4 RECT-5 RECT-6 RECT-14 RECT-15 RECT-16 RECT-18 RECT-19 
&Scoped-Define DISPLAYED-FIELDS pedido.nr-pedido pedido.situacao ~
pedido.cd-favorecido pedido.nom-projeto pedido.num-cliente ~
pedido.dias-garantia pedido.prob-fec pedido.cliente-fat pedido.responsavel ~
pedido.usuar-indicacao pedido.dt-pedido pedido.dt-validade ~
pedido.dt-aprovacao pedido.dt-lib-homolog pedido.dt-previsao-fat ~
pedido.dt-encerramento pedido.val-itens pedido.pc-impto pedido.val-impostos ~
pedido.val-desconto pedido.val-total pedido.nps pedido.ds-obs-cli ~
pedido.ds-observacao pedido.rua pedido.numero pedido.complemento pedido.cep ~
pedido.cidade pedido.estado pedido.bairro pedido.telefone 
&Scoped-define DISPLAYED-TABLES pedido
&Scoped-define FIRST-DISPLAYED-TABLE pedido
&Scoped-Define DISPLAYED-OBJECTS des-cli des-cli-fat val-antecip de-saldo ~
de-tot-custos de-tot-imp de-tot-margem de-tot-lucr de-tot-hr-fat ~
de-tot-hr-apont de-tot-saldo de-tot-perc-hr 

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

DEFINE BUTTON btAntecip 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Antecip" 
     SIZE 6.14 BY 1.79 TOOLTIP "Antecipaá‰es".

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

DEFINE BUTTON btFaixa 
     IMAGE-UP FILE "image/im-sub.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-sub.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Itens do Pedido".

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

DEFINE BUTTON btViab 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Viab" 
     SIZE 6.14 BY 1.79 TOOLTIP "Estudo de Viabilidade do Pedido".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE de-saldo AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-custos AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Custos" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-hr-apont AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Horas Apontadas" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-hr-fat AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Horas Faturadas" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-imp AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Impostos" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-lucr AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Lucratividade" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE de-tot-margem AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Margem L°quida" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-perc-hr AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "% Saldo de Horas" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE de-tot-saldo AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo em Horas" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE des-cli AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE des-cli-fat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE val-antecip AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor Antecipado" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 9.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 33 BY 4.25.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 7.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 33 BY 4.25.

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 67 BY 4.5.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 67 BY 7.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 98 BY 2.25.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 5.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      pedido, 
      favorecido SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     pedido.nr-pedido AT ROW 4.5 COL 15 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     pedido.situacao AT ROW 4.5 COL 49 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS COMBO-BOX INNER-LINES 7
          LIST-ITEM-PAIRS "Pendente",1,
                     "Iniciado",2,
                     "Atendido",3,
                     "Faturado",4,
                     "Em Homologaá∆o",5,
                     "Em Garantia",6,
                     "Cancelado",9
          DROP-DOWN-LIST
          SIZE 17 BY 1
     pedido.cd-favorecido AT ROW 5.5 COL 15 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     des-cli AT ROW 5.5 COL 20 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     pedido.nom-projeto AT ROW 6.5 COL 15 COLON-ALIGNED WIDGET-ID 66
          VIEW-AS FILL-IN 
          SIZE 51 BY .79
     pedido.num-cliente AT ROW 7.5 COL 15 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     pedido.dias-garantia AT ROW 7.5 COL 39 COLON-ALIGNED WIDGET-ID 100
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btViab AT ROW 1.5 COL 75 WIDGET-ID 76
     pedido.prob-fec AT ROW 7.5 COL 58 COLON-ALIGNED WIDGET-ID 130
          LABEL "Prob Fecham"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Baixa",1,
                     "MÇdia",2,
                     "Alta",3
          DROP-DOWN-LIST
          SIZE 8 BY 1
     pedido.cliente-fat AT ROW 8.5 COL 15 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     des-cli-fat AT ROW 8.5 COL 20 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     pedido.responsavel AT ROW 9.5 COL 15 COLON-ALIGNED WIDGET-ID 98
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     pedido.usuar-indicacao AT ROW 9.5 COL 53 COLON-ALIGNED WIDGET-ID 134
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     btAntecip AT ROW 1.5 COL 69 WIDGET-ID 68
     pedido.dt-pedido AT ROW 4.5 COL 86 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.dt-validade AT ROW 5.5 COL 86 COLON-ALIGNED WIDGET-ID 136
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.dt-aprovacao AT ROW 6.5 COL 86 COLON-ALIGNED WIDGET-ID 92
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.dt-lib-homolog AT ROW 7.5 COL 86 COLON-ALIGNED WIDGET-ID 96
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.dt-previsao-fat AT ROW 8.5 COL 86 COLON-ALIGNED WIDGET-ID 74
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.dt-encerramento AT ROW 9.5 COL 86 COLON-ALIGNED WIDGET-ID 94
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.val-itens AT ROW 12.25 COL 86 COLON-ALIGNED WIDGET-ID 62
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.pc-impto AT ROW 13.25 COL 86 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.val-impostos AT ROW 14.25 COL 86 COLON-ALIGNED WIDGET-ID 60
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.val-desconto AT ROW 15.25 COL 86 COLON-ALIGNED WIDGET-ID 58
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido.val-total AT ROW 16.25 COL 86 COLON-ALIGNED WIDGET-ID 30
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
          BGCOLOR 21 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 99.57 BY 26.96
         FONT 7.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     val-antecip AT ROW 17.25 COL 86 COLON-ALIGNED WIDGET-ID 70
     de-saldo AT ROW 18.25 COL 86 COLON-ALIGNED WIDGET-ID 72
     de-tot-custos AT ROW 11.5 COL 19 COLON-ALIGNED WIDGET-ID 82
     de-tot-imp AT ROW 12.5 COL 19 COLON-ALIGNED WIDGET-ID 84
     de-tot-margem AT ROW 13.5 COL 19 COLON-ALIGNED WIDGET-ID 86
     de-tot-lucr AT ROW 14.5 COL 19 COLON-ALIGNED WIDGET-ID 88
     de-tot-hr-fat AT ROW 11.5 COL 53 COLON-ALIGNED WIDGET-ID 104
     de-tot-hr-apont AT ROW 12.5 COL 53 COLON-ALIGNED WIDGET-ID 106
     de-tot-saldo AT ROW 13.5 COL 53 COLON-ALIGNED WIDGET-ID 110
     de-tot-perc-hr AT ROW 14.5 COL 53 COLON-ALIGNED WIDGET-ID 108
     pedido.nps AT ROW 16 COL 3 NO-LABEL WIDGET-ID 114
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "N∆o Avaliado", 0,
"1", 1,
"2", 2,
"3", 3,
"4", 4,
"5", 5,
"6", 6,
"7", 7,
"8", 8,
"9", 9,
"10", 10
          SIZE 65 BY .75
     pedido.ds-obs-cli AT ROW 17 COL 3 NO-LABEL WIDGET-ID 128
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 65 BY 3
     pedido.ds-observacao AT ROW 20.5 COL 2 NO-LABEL WIDGET-ID 46
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 39 BY 5.25
     pedido.rua AT ROW 21.25 COL 47 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 49 BY .79
     pedido.numero AT ROW 22.25 COL 47 COLON-ALIGNED WIDGET-ID 48
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     pedido.complemento AT ROW 22.25 COL 71 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 25 BY .79
     pedido.cep AT ROW 23.25 COL 47 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btFaixa AT ROW 1.5 COL 63
     pedido.cidade AT ROW 23.25 COL 64 COLON-ALIGNED WIDGET-ID 42
          VIEW-AS FILL-IN 
          SIZE 28 BY .79
     pedido.estado AT ROW 23.25 COL 92 COLON-ALIGNED NO-LABEL WIDGET-ID 78
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btGoTo AT ROW 1.5 COL 48.43
     pedido.bairro AT ROW 24.25 COL 47 COLON-ALIGNED WIDGET-ID 36
          VIEW-AS FILL-IN 
          SIZE 25 BY .79
     pedido.telefone AT ROW 24.25 COL 80 COLON-ALIGNED WIDGET-ID 52
          VIEW-AS FILL-IN 
          SIZE 16 BY .79
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 25.75 COL 94.14
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 93
     btOK AT ROW 25.75 COL 88
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     "Entrega:" VIEW-AS TEXT
          SIZE 6 BY .54 AT ROW 20.25 COL 43 WIDGET-ID 34
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-6 AT ROW 20.5 COL 42 WIDGET-ID 32
     RECT-14 AT ROW 11.25 COL 70 WIDGET-ID 64
     RECT-15 AT ROW 11.25 COL 2 WIDGET-ID 80
     RECT-16 AT ROW 4 COL 70 WIDGET-ID 90
     RECT-18 AT ROW 11.25 COL 36 WIDGET-ID 112
     RECT-19 AT ROW 15.75 COL 2 WIDGET-ID 126
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 99.57 BY 26.96
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
         HEIGHT             = 26.96
         WIDTH              = 99.57
         MAX-HEIGHT         = 27.96
         MAX-WIDTH          = 147.14
         VIRTUAL-HEIGHT     = 27.96
         VIRTUAL-WIDTH      = 147.14
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
/* SETTINGS FOR FILL-IN de-saldo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-custos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-hr-apont IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-hr-fat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-imp IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-lucr IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-margem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-perc-hr IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-saldo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       des-cli:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       des-cli-fat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       pedido.ds-obs-cli:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

ASSIGN 
       pedido.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

/* SETTINGS FOR COMBO-BOX pedido.prob-fec IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN val-antecip IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.pedido,money.favorecido OF money.pedido"
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


&Scoped-define SELF-NAME pedido.bairro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.bairro C-Win
ON ENTRY OF pedido.bairro IN FRAME DEFAULT-FRAME /* Bairro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.bairro C-Win
ON LEAVE OF pedido.bairro IN FRAME DEFAULT-FRAME /* Bairro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE cNum AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.

    {func\bt_add.i "nr-pedido"}

    ASSIGN pedido.pc-impto:SCREEN-VALUE = STRING(param-mn.perc-impto-padrao).

    SELECT MAX(num-cliente) INTO cNum FROM pedido 
        WHERE pedido.dt-pedido = TODAY
        AND   pedido.num-cliente BEGINS "20".
    IF cNum <> ""
    AND cNum <> ? THEN DO:
        ASSIGN iAux = INT(SUBSTRING(cNum, 9, 1)) + 1.
        ASSIGN OVERLAY(cNum, 9, 1) = STRING(iAux).
    END.
    ELSE
        ASSIGN cNum = STRING(YEAR(TODAY), "9999") + STRING(MONTH(TODAY), "99") + STRING(DAY(TODAY), "99") + "1".

    ASSIGN pedido.num-cliente:SCREEN-VALUE = cNum.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAntecip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAntecip C-Win
ON CHOOSE OF btAntecip IN FRAME DEFAULT-FRAME /* Antecip */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "pedido-ant.w"}
    FIND FIRST {&TABLE} NO-LOCK
         WHERE {&TABLE}.nr-pedido = giNr-pedido NO-ERROR.    
    IF AVAIL {&TABLE} THEN            
        RUN displayFields IN THIS-PROCEDURE.     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").
    IF VALID-HANDLE(hLastWidget) THEN
        ASSIGN hLastWidget:BGCOLOR = ?.
    IF cAction = "ADD" THEN DO:
        FIND FIRST bf-{&Table} WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-LOCK.
        FIND PREV bf-{&Table} NO-LOCK 
            WHERE bf-{&table}.nr-pedido-ant = 0 NO-ERROR.
        IF NOT AVAIL bf-{&Table} THEN DO:
            FIND FIRST bf-{&Table} 
                WHERE ROWID(bf-{&Table}) <> ROWID({&Table}) NO-LOCK NO-ERROR.
        END.
        FIND CURRENT {&Table} EXCLUSIVE-LOCK.
        DELETE {&Table}.
        IF AVAIL bf-{&Table} THEN DO:
            FIND FIRST {&Table} WHERE ROWID({&Table}) = ROWID(bf-{&Table}) NO-LOCK NO-ERROR.
        END.
    END.
    ASSIGN cAction = "".
    RUN displayFields IN THIS-PROCEDURE.    
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


&Scoped-define SELF-NAME btFaixa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFaixa C-Win
ON CHOOSE OF btFaixa IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "ped-item.w"}
    RUN displayFields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_first.i codigo "{&table}.nr-pedido-ant = 0"}
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
    {func\bt_last.i codigo "{&table}.nr-pedido-ant = 0"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_next.i codigo "{&table}.nr-pedido-ant = 0"}
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


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i codigo "{&table}.nr-pedido-ant = 0"}
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


&Scoped-define SELF-NAME btViab
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btViab C-Win
ON CHOOSE OF btViab IN FRAME DEFAULT-FRAME /* Viab */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "pedido-viab.w (INPUT pedido.nr-pedido, INPUT TABLE tt-calc-viab)"}
    RUN displayFields.
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


&Scoped-define SELF-NAME pedido.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cd-favorecido C-Win
ON ENTRY OF pedido.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cd-favorecido C-Win
ON LEAVE OF pedido.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-cli"}    
                  
    IF AVAIL bfl-favorecido THEN DO:

        IF INPUT FRAME {&FRAME-NAME} pedido.cliente-fat = 0 THEN DO:
            ASSIGN pedido.cliente-fat:SCREEN-VALUE = pedido.cd-favorecido:SCREEN-VALUE.
            APPLY "LEAVE" TO pedido.cliente-fat.
        END.

        IF cAction <> "" THEN DO:
            IF INPUT FRAME {&FRAME-NAME} pedido.rua = "" THEN DO:
                ASSIGN pedido.rua:SCREEN-VALUE         = bfl-favorecido.rua
                       pedido.numero:SCREEN-VALUE      = STRING(bfl-favorecido.numero)
                       pedido.complemento:SCREEN-VALUE = bfl-favorecido.complemento
                       pedido.cidade:SCREEN-VALUE      = bfl-favorecido.cidade
                       pedido.estado:SCREEN-VALUE      = bfl-favorecido.estado
                       pedido.bairro:SCREEN-VALUE      = bfl-favorecido.bairro
                       pedido.telefone:SCREEN-VALUE    = bfl-favorecido.telefone
                       pedido.cep:SCREEN-VALUE         = bfl-favorecido.cep.
            END.
        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF pedido.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="pedido.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="des-cli"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.cep
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cep C-Win
ON ENTRY OF pedido.cep IN FRAME DEFAULT-FRAME /* CEP */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cep C-Win
ON LEAVE OF pedido.cep IN FRAME DEFAULT-FRAME /* CEP */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.cidade
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cidade C-Win
ON ENTRY OF pedido.cidade IN FRAME DEFAULT-FRAME /* Cidade */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cidade C-Win
ON LEAVE OF pedido.cidade IN FRAME DEFAULT-FRAME /* Cidade */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.cliente-fat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cliente-fat C-Win
ON ENTRY OF pedido.cliente-fat IN FRAME DEFAULT-FRAME /* Cliente Faturamento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cliente-fat C-Win
ON LEAVE OF pedido.cliente-fat IN FRAME DEFAULT-FRAME /* Cliente Faturamento */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela="cliente-fat"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-cli-fat"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.cliente-fat C-Win
ON MOUSE-SELECT-DBLCLICK OF pedido.cliente-fat IN FRAME DEFAULT-FRAME /* Cliente Faturamento */
OR F5 OF {&Table}.cliente-fat DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="pedido.cliente-fat"
                 &Campo2="ds-favorecido"
                 &Tela2="des-cli-fat"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.complemento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.complemento C-Win
ON ENTRY OF pedido.complemento IN FRAME DEFAULT-FRAME /* Complemento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.complemento C-Win
ON LEAVE OF pedido.complemento IN FRAME DEFAULT-FRAME /* Complemento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.dias-garantia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dias-garantia C-Win
ON ENTRY OF pedido.dias-garantia IN FRAME DEFAULT-FRAME /* Dias Garantia */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dias-garantia C-Win
ON LEAVE OF pedido.dias-garantia IN FRAME DEFAULT-FRAME /* Dias Garantia */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.ds-obs-cli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.ds-obs-cli C-Win
ON ENTRY OF pedido.ds-obs-cli IN FRAME DEFAULT-FRAME /* Observaá‰es Cliente */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.ds-obs-cli C-Win
ON LEAVE OF pedido.ds-obs-cli IN FRAME DEFAULT-FRAME /* Observaá‰es Cliente */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.ds-observacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.ds-observacao C-Win
ON ENTRY OF pedido.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.ds-observacao C-Win
ON LEAVE OF pedido.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.dt-aprovacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-aprovacao C-Win
ON ENTRY OF pedido.dt-aprovacao IN FRAME DEFAULT-FRAME /* Data Aprovaá∆o */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-aprovacao C-Win
ON LEAVE OF pedido.dt-aprovacao IN FRAME DEFAULT-FRAME /* Data Aprovaá∆o */
DO:
    {func\set_leave.i}

    RUN criaDatas.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.dt-encerramento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-encerramento C-Win
ON ENTRY OF pedido.dt-encerramento IN FRAME DEFAULT-FRAME /* Data Encerramento */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-encerramento C-Win
ON LEAVE OF pedido.dt-encerramento IN FRAME DEFAULT-FRAME /* Data Encerramento */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.dt-lib-homolog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-lib-homolog C-Win
ON ENTRY OF pedido.dt-lib-homolog IN FRAME DEFAULT-FRAME /* Data Lib Homologaá∆o */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-lib-homolog C-Win
ON LEAVE OF pedido.dt-lib-homolog IN FRAME DEFAULT-FRAME /* Data Lib Homologaá∆o */
DO:
    {func\set_leave.i}
    ASSIGN pedido.dt-encerramento:SCREEN-VALUE = STRING(INPUT FRAME {&FRAME-NAME} pedido.dt-lib-homolog + INPUT FRAME {&FRAME-NAME} pedido.dias-garantia, "99/99/9999").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.dt-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-pedido C-Win
ON ENTRY OF pedido.dt-pedido IN FRAME DEFAULT-FRAME /* Data Pedido */
DO:
    {func\set_entry.i}
    ASSIGN dt-ped = INPUT FRAME {&FRAME-NAME} pedido.dt-pedido.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.dt-pedido C-Win
ON LEAVE OF pedido.dt-pedido IN FRAME DEFAULT-FRAME /* Data Pedido */
DO:
    {func\set_leave.i}
    IF INPUT FRAME {&FRAME-NAME} pedido.dt-pedido <> dt-ped THEN DO:
        ASSIGN pedido.dt-validade:SCREEN-VALUE = STRING(INPUT FRAME {&FRAME-NAME} pedido.dt-pedido + (pedido.dt-validade - pedido.dt-pedido), "99/99/9999").
    END.
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


&Scoped-define SELF-NAME pedido.num-cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.num-cliente C-Win
ON ENTRY OF pedido.num-cliente IN FRAME DEFAULT-FRAME /* N£mero Cliente */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.num-cliente C-Win
ON LEAVE OF pedido.num-cliente IN FRAME DEFAULT-FRAME /* N£mero Cliente */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.numero C-Win
ON ENTRY OF pedido.numero IN FRAME DEFAULT-FRAME /* N£mero */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.numero C-Win
ON LEAVE OF pedido.numero IN FRAME DEFAULT-FRAME /* N£mero */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.pc-impto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.pc-impto C-Win
ON LEAVE OF pedido.pc-impto IN FRAME DEFAULT-FRAME /* % Imposto */
DO:
  
    RUN recalc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.prob-fec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.prob-fec C-Win
ON ENTRY OF pedido.prob-fec IN FRAME DEFAULT-FRAME /* Prob Fecham */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.responsavel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.responsavel C-Win
ON ENTRY OF pedido.responsavel IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.responsavel C-Win
ON LEAVE OF pedido.responsavel IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.rua
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.rua C-Win
ON ENTRY OF pedido.rua IN FRAME DEFAULT-FRAME /* Rua */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.rua C-Win
ON LEAVE OF pedido.rua IN FRAME DEFAULT-FRAME /* Rua */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.situacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.situacao C-Win
ON ENTRY OF pedido.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.situacao C-Win
ON LEAVE OF pedido.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.telefone
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.telefone C-Win
ON ENTRY OF pedido.telefone IN FRAME DEFAULT-FRAME /* Telefone */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.telefone C-Win
ON LEAVE OF pedido.telefone IN FRAME DEFAULT-FRAME /* Telefone */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.usuar-indicacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.usuar-indicacao C-Win
ON MOUSE-SELECT-DBLCLICK OF pedido.usuar-indicacao IN FRAME DEFAULT-FRAME /* Indicaá∆o */
OR F5 OF {&Table}.usuar-indicacao DO:
    {func\zoom.i &Tabela="usuario"
                 &Campo1="nome"
                 &Tela1="pedido.usuar-indicacao"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido.val-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido.val-desconto C-Win
ON LEAVE OF pedido.val-desconto IN FRAME DEFAULT-FRAME /* Valor Desconto */
DO:
  
    RUN recalc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-cli
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = pedido.cd-favorecido}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-cli-fat
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = pedido.cliente-fat}
                          
{func\calendar.i pedido.dt-pedido}

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
  {version.i pedido}
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

/* cancelar o itens do pedido e as antecipacoes */
IF INPUT FRAME {&FRAME-NAME} pedido.situacao = 9 THEN DO:

    IF pedido.dt-encerramento = ? THEN
        ASSIGN pedido.dt-encerramento = TODAY.

    FOR EACH pedido-item OF pedido EXCLUSIVE-LOCK:
      ASSIGN pedido-item.situacao = 9.               
    END.
    RELEASE pedido-item NO-ERROR.
    
    FOR EACH bf-pedido EXCLUSIVE-LOCK
      WHERE bf-pedido.nr-pedido-ant = pedido.nr-pedido:
       ASSIGN bf-pedido.situacao = 9.
    END.
    RELEASE bf-pedido NO-ERROR.

END.

RETURN "OK".

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
    DISABLE btFaixa 
            btAntecip
            btViab WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ENABLE btFaixa
           btAntecip
           btViab WITH FRAME {&FRAME-NAME}.
END.

DISABLE pedido.val-total
        pedido.val-itens
        pedido.val-impostos
    WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaDatas C-Win 
PROCEDURE criaDatas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp    AS DATE        NO-UNDO. 
    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.

    IF INPUT FRAME {&FRAME-NAME} pedido.dt-previsao-fat <> ? THEN
        RETURN "OK".
    
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} pedido.cd-favorecido NO-ERROR.
    
    IF AVAIL favorecido THEN DO:

        IF favorecido.dia-pagto-padrao = 0 THEN
            RETURN "OK".

        ASSIGN dtTemp = fnUltimoDia(MONTH(INPUT FRAME {&FRAME-NAME} pedido.dt-aprovacao),YEAR(INPUT FRAME {&FRAME-NAME} pedido.dt-aprovacao)) + 1
               dtTemp = DATE(MONTH(dtTemp), favorecido.dia-pagto-padrao, YEAR(dtTemp))
               dtTemp = fnProxDiaUtil(dtTemp).

        REPEAT iAux = 1 TO favorecido.dias-uteis-pagto:
            ASSIGN dtTemp = dtTemp + 1
                   dtTemp = fnProxDiaUtil(dtTemp).
        END.

        IF favorecido.dia-semana-pagto <> 0 THEN DO:
            REPEAT iAux = 1 TO 2000:
                IF WEEKDAY(dtTemp) <> favorecido.dia-semana-pagto THEN DO:
                    ASSIGN dtTemp = dtTemp + 1
                           dtTemp = fnProxDiaUtil(dtTemp).
                END.
                ELSE
                    LEAVE.
            END.
        END.

    END.
        
    ASSIGN pedido.dt-previsao-fat:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(dtTemp).
     
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
    ASSIGN pedido.dt-pedido = TODAY
           pedido.dt-validade = TODAY + 15
           pedido.situacao = 1.
END.

{func\cadastro\display.i}

APPLY "LEAVE" TO pedido.cd-favorecido.
APPLY "LEAVE" TO pedido.cliente-fat.

ASSIGN giNr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido.

ASSIGN de-valor-antecip = 0.
FOR EACH bf-pedido NO-LOCK
   WHERE bf-pedido.nr-pedido-ant = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido:

    ASSIGN de-valor-antecip = de-valor-antecip + bf-pedido.val-total.
END.
RUN recalc.

DISABLE pedido.dt-encerramento
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
  DISPLAY des-cli des-cli-fat val-antecip de-saldo de-tot-custos de-tot-imp 
          de-tot-margem de-tot-lucr de-tot-hr-fat de-tot-hr-apont de-tot-saldo 
          de-tot-perc-hr 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE pedido THEN 
    DISPLAY pedido.nr-pedido pedido.situacao pedido.cd-favorecido 
          pedido.nom-projeto pedido.num-cliente pedido.dias-garantia 
          pedido.prob-fec pedido.cliente-fat pedido.responsavel 
          pedido.usuar-indicacao pedido.dt-pedido pedido.dt-validade 
          pedido.dt-aprovacao pedido.dt-lib-homolog pedido.dt-previsao-fat 
          pedido.dt-encerramento pedido.val-itens pedido.pc-impto 
          pedido.val-impostos pedido.val-desconto pedido.val-total pedido.nps 
          pedido.ds-obs-cli pedido.ds-observacao pedido.rua pedido.numero 
          pedido.complemento pedido.cep pedido.cidade pedido.estado 
          pedido.bairro pedido.telefone 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE pedido.nr-pedido pedido.situacao pedido.cd-favorecido des-cli 
         pedido.nom-projeto pedido.num-cliente pedido.dias-garantia btViab 
         pedido.prob-fec pedido.cliente-fat des-cli-fat pedido.responsavel 
         pedido.usuar-indicacao btAntecip pedido.dt-pedido pedido.dt-validade 
         pedido.dt-aprovacao pedido.dt-lib-homolog pedido.dt-previsao-fat 
         pedido.dt-encerramento pedido.val-itens pedido.pc-impto 
         pedido.val-impostos pedido.val-desconto pedido.val-total pedido.nps 
         pedido.ds-obs-cli pedido.ds-observacao pedido.rua pedido.numero 
         pedido.complemento pedido.cep btFaixa pedido.cidade pedido.estado 
         btGoTo pedido.bairro pedido.telefone btFirst btLast btNext btPrev 
         btAdd btDel btExit btUpdate btZoom RECT-4 RECT-5 RECT-6 RECT-14 
         RECT-15 RECT-16 RECT-18 RECT-19 
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

{func\cursor.i pedido.cd-favorecido}
{func\cursor.i pedido.cliente-fat}
{func\cursor.i pedido.usuar-indicacao}

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

IF cObject = "des-cli" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} des-cli NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN pedido.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.
IF cObject = "des-cli-fat" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} des-cli-fat NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN pedido.cliente-fat:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
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
    ASSIGN val-antecip:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(de-valor-antecip).
    
    ASSIGN pedido.val-impostos:SCREEN-VALUE = STRING((INPUT FRAME {&FRAME-NAME} pedido.val-itens * INPUT FRAME {&FRAME-NAME} pedido.pc-impto) / 100)
           pedido.val-total:SCREEN-VALUE = STRING(INPUT FRAME {&FRAME-NAME} pedido.val-itens - INPUT FRAME {&FRAME-NAME} pedido.val-desconto + INPUT FRAME {&FRAME-NAME} pedido.val-impostos)
           de-saldo:SCREEN-VALUE = STRING(INPUT FRAME {&FRAME-NAME} pedido.val-total - INPUT FRAME {&FRAME-NAME} val-antecip).
           
    /* C†lculo Valores */
    RUN viab.p (INPUT pedido.nr-pedido, 
                OUTPUT TABLE tt-calc-viab).
                
    IF RETURN-VALUE = "OK" THEN DO:
                
        FIND FIRST tt-calc-viab
            WHERE tt-calc-viab.descricao = "  TOTAL DESPESAS" NO-ERROR.
        IF AVAIL tt-calc-viab THEN DO:
            ASSIGN de-tot-custos:SCREEN-VALUE = tt-calc-viab.valor.
        END.
    
        FIND FIRST tt-calc-viab
            WHERE tt-calc-viab.descricao = "  TOTAL IMPOSTOS" NO-ERROR.
        IF AVAIL tt-calc-viab THEN DO:
            ASSIGN de-tot-imp:SCREEN-VALUE = tt-calc-viab.valor.
        END.
    
        FIND FIRST tt-calc-viab
            WHERE tt-calc-viab.descricao = "MARGEM LIQUIDA" NO-ERROR.
        IF AVAIL tt-calc-viab THEN DO:
            ASSIGN de-tot-margem:SCREEN-VALUE = tt-calc-viab.valor.
        END.
    
        FIND FIRST tt-calc-viab
            WHERE tt-calc-viab.descricao = "  Lucratividade" NO-ERROR.
        IF AVAIL tt-calc-viab THEN DO:
            ASSIGN de-tot-lucr:SCREEN-VALUE = TRIM(REPLACE(tt-calc-viab.valor,"%","")).
        END.
        
    END.
    ELSE DO:
        ASSIGN de-tot-custos:SCREEN-VALUE = "0,00"
               de-tot-imp:SCREEN-VALUE = "0,00"
               de-tot-margem:SCREEN-VALUE = "0,00"
               de-tot-lucr:SCREEN-VALUE = "0,00".
    END.
    
    IF DEC(de-tot-lucr:SCREEN-VALUE) < 0 THEN
        ASSIGN de-tot-lucr:BGCOLOR = 4.
    ELSE
        IF DEC(de-tot-lucr:SCREEN-VALUE) < 30 THEN
            ASSIGN de-tot-lucr:BGCOLOR = 6.
        ELSE
            ASSIGN de-tot-lucr:BGCOLOR = 21.        

    /* C†lculo Horas */
    ASSIGN de-tot-hr-fat = 0
           de-tot-hr-apont = 0
           de-tot-saldo = 0
           de-tot-perc-hr = 0.

    FOR EACH pedido-item OF pedido NO-LOCK:
        FIND FIRST item OF pedido-item NO-LOCK NO-ERROR.
        IF NOT item.un MATCHES("*hr*") THEN NEXT.
        IF pedido-item.val-total > 0 THEN DO:
            IF pedido-item.situacao <> 9 THEN
                ASSIGN de-tot-hr-fat = de-tot-hr-fat + pedido-item.qt-pedida.
        END.
        FOR EACH apontamento OF pedido-item:
            ASSIGN de-tot-hr-apont = de-tot-hr-apont + apontamento.qt-apont.
        END.
    END.

    ASSIGN de-tot-saldo = de-tot-hr-fat - de-tot-hr-apont
           de-tot-perc-hr = (de-tot-saldo / de-tot-hr-fat) * 100.

    DISP de-tot-hr-fat
           de-tot-hr-apont
           de-tot-saldo
           de-tot-perc-hr
        WITH FRAME {&FRAME-NAME}.

    IF DEC(de-tot-perc-hr:SCREEN-VALUE) < 0 THEN
        ASSIGN de-tot-perc-hr:BGCOLOR = 4.
    ELSE
        IF DEC(de-tot-perc-hr:SCREEN-VALUE) < 30 THEN
            ASSIGN de-tot-perc-hr:BGCOLOR = 6.
        ELSE
            ASSIGN de-tot-perc-hr:BGCOLOR = 21.        
        
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
    FIND FIRST bf-pedido NO-LOCK
        WHERE bf-pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido.nr-pedido
        AND   ROWID(bf-pedido) <> ROWID(pedido) NO-ERROR.
    IF AVAIL bf-pedido THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "UPDATE" THEN DO:
END.

IF cAction = "ADD" OR cAction = "UPDATE" THEN DO:

    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} pedido.cd-favorecido NO-ERROR.
    IF NOT AVAIL favorecido THEN DO:
        {func\valida.i &Mensagem  = "Cliente inv†lido!"
                       &Ajuda     = "Vocà deve informar o cliente do pedido."
                       &Campo     = pedido.cd-favorecido}
    END.
    ELSE DO:
        IF favorecido.tipo = 2 /* Fornecedor */ THEN DO:
            {func\valida.i &Mensagem  = "Cliente inv†lido!"
                           &Ajuda     = "O cliente informado Ç um fornecedor. No cadastro vocà deve alterar o tipo para Cliente ou Ambos."
                           &Campo     = pedido.cd-favorecido}
        END.
    END.

    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} pedido.cliente-fat NO-ERROR.
    IF NOT AVAIL favorecido THEN DO:
        {func\valida.i &Mensagem  = "Cliente de Faturamento inv†lido!"
                       &Ajuda     = "Vocà deve informar o cliente de faturamento do pedido."
                       &Campo     = pedido.cliente-fat}
    END.
    ELSE DO:
        IF favorecido.tipo = 2 /* Fornecedor */ THEN DO:
            {func\valida.i &Mensagem  = "Cliente de Faturamento inv†lido!"
                           &Ajuda     = "O cliente de faturamento informado Ç um fornecedor. No cadastro vocà deve alterar o tipo para Cliente ou Ambos."
                           &Campo     = pedido.cliente-fat}
        END.
    END.

    CASE INPUT FRAME {&FRAME-NAME} pedido.situacao:
        WHEN 1 /* Pendente */ THEN DO:
            IF CAN-FIND(FIRST pedido-item OF pedido
                        WHERE pedido-item.situacao = 2
                        OR    pedido-item.situacao = 3) THEN DO:
                {func\valida.i &Mensagem  = "Situaá∆o inv†lida!"
                               &Ajuda     = "Existem itens do pedido que j† est∆o iniciados ou atendidos."
                               &Campo     = pedido.situacao}
            END.
        END.
        WHEN 2 /* Iniciado */ THEN DO:
            IF NOT CAN-FIND(FIRST pedido-item OF pedido
                            WHERE pedido-item.situacao = 2
                            OR    pedido-item.situacao = 3) THEN DO:
                {func\valida.i &Mensagem  = "Situaá∆o inv†lida!"
                               &Ajuda     = "N∆o existe nenhum item do pedido j† iniciado ou atendido."
                               &Campo     = pedido.situacao}
            END.
        END.
        WHEN 3 /* Atendido */ THEN DO:
            IF CAN-FIND(FIRST pedido-item OF pedido
                        WHERE pedido-item.situacao < 3) THEN DO:
                {func\valida.i &Mensagem  = "Situaá∆o inv†lida!"
                               &Ajuda     = "Nem todos os itens do pedido est∆o atendidos."
                               &Campo     = pedido.situacao}
            END.
        END.
        WHEN 9 /* Cancelado */ THEN DO:
            
           

        END.
    END CASE.

END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST apontamento OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui apontamentos."}
    END.
    IF CAN-FIND(FIRST pedido-item-anexo OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui arquivos anexos associados a algum item."}
    END.
    IF CAN-FIND(FIRST pedido-item OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui itens."}
    END.
    IF CAN-FIND(FIRST mov-conta OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui movimentaá∆o financeira associada."}
    END.
    IF CAN-FIND(FIRST pedido-item-usu OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui usu†rios associados a itens."}
    END.
    IF CAN-FIND(FIRST ordem-serv OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui ordem de serviáo associada."}
    END.
    IF CAN-FIND(FIRST visita OF pedido) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse pedido j† possui visitas registradas."}
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

