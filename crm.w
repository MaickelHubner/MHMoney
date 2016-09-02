&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

/* PrÇ-processadores */
&GLOBAL-DEFINE Table         favorecido
&GLOBAL-DEFINE Filho         contato
&GLOBAL-DEFINE LabelFilho    Contatos
&GLOBAL-DEFINE ParentFields  favorecido.cd-favorecido
&GLOBAL-DEFINE KeyFields     favorecido.cd-favorecido
&GLOBAL-DEFINE CamposFilho   contato.cd-contato

DEFINE NEW GLOBAL SHARED VARIABLE r-contato   AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-atendimento AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-pedido-item AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-apontamento AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-tarefa AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-usuario AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-pedido AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE glCRM       AS LOGICAL     NO-UNDO.

DEFINE BUFFER bf-ped FOR pedido.

{func\definitions.i}
{campos\situacao.i}

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF VAR c-situacao-ped AS CHAR NO-UNDO.

DEFINE BUFFER bf-tarefa FOR tarefa.

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
&Scoped-define INTERNAL-TABLES apontamento atendimento contato pedido-item ~
item pedido tarefa

/* Definitions for BROWSE br-apont                                      */
&Scoped-define FIELDS-IN-QUERY-br-apont apontamento.data apontamento.nome ~
apontamento.hora-ini apontamento.hora-fim apontamento.qt-apontada 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-apont 
&Scoped-define QUERY-STRING-br-apont FOR EACH apontamento ~
      WHERE apontamento.nr-pedido = pedido.nr-pedido ~
 AND apontamento.sequencia = pedido-item.sequencia  NO-LOCK ~
    BY apontamento.data DESCENDING ~
       BY apontamento.sequencia ~
        BY apontamento.nome ~
         BY apontamento.hora-ini DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-apont OPEN QUERY br-apont FOR EACH apontamento ~
      WHERE apontamento.nr-pedido = pedido.nr-pedido ~
 AND apontamento.sequencia = pedido-item.sequencia  NO-LOCK ~
    BY apontamento.data DESCENDING ~
       BY apontamento.sequencia ~
        BY apontamento.nome ~
         BY apontamento.hora-ini DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-apont apontamento
&Scoped-define FIRST-TABLE-IN-QUERY-br-apont apontamento


/* Definitions for BROWSE br-atendimentos                               */
&Scoped-define FIELDS-IN-QUERY-br-atendimentos atendimento.data ~
atendimento.hora atendimento.usuario atendimento.contato ~
atendimento.observacao 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-atendimentos 
&Scoped-define QUERY-STRING-br-atendimentos FOR EACH atendimento ~
      WHERE atendimento.cd-favorecido = input frame {&frame-name} i-cd-favorecido NO-LOCK ~
    BY atendimento.data DESCENDING ~
       BY atendimento.hora DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-atendimentos OPEN QUERY br-atendimentos FOR EACH atendimento ~
      WHERE atendimento.cd-favorecido = input frame {&frame-name} i-cd-favorecido NO-LOCK ~
    BY atendimento.data DESCENDING ~
       BY atendimento.hora DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-atendimentos atendimento
&Scoped-define FIRST-TABLE-IN-QUERY-br-atendimentos atendimento


/* Definitions for BROWSE br-contatos                                   */
&Scoped-define FIELDS-IN-QUERY-br-contatos contato.nome-apelido ~
contato.telefone contato.celular contato.cargo contato.email contato.nome ~
contato.data-nasc 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-contatos 
&Scoped-define QUERY-STRING-br-contatos FOR EACH contato ~
      WHERE contato.cd-favorecido = input frame {&frame-name} i-cd-favorecido ~
AND (IF INPUT FRAME DEFAULT-FRAME l-contatos-ativos THEN contato.ativo ELSE TRUE) NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-contatos OPEN QUERY br-contatos FOR EACH contato ~
      WHERE contato.cd-favorecido = input frame {&frame-name} i-cd-favorecido ~
AND (IF INPUT FRAME DEFAULT-FRAME l-contatos-ativos THEN contato.ativo ELSE TRUE) NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-contatos contato
&Scoped-define FIRST-TABLE-IN-QUERY-br-contatos contato


/* Definitions for BROWSE br-itens                                      */
&Scoped-define FIELDS-IN-QUERY-br-itens pedido-item.ds-pedido-item 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-itens 
&Scoped-define QUERY-STRING-br-itens FOR EACH pedido-item ~
      WHERE pedido-item.nr-pedido = pedido.nr-pedido NO-LOCK, ~
      EACH item OF pedido-item NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-itens OPEN QUERY br-itens FOR EACH pedido-item ~
      WHERE pedido-item.nr-pedido = pedido.nr-pedido NO-LOCK, ~
      EACH item OF pedido-item NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-itens pedido-item item
&Scoped-define FIRST-TABLE-IN-QUERY-br-itens pedido-item
&Scoped-define SECOND-TABLE-IN-QUERY-br-itens item


/* Definitions for BROWSE br-pedidos                                    */
&Scoped-define FIELDS-IN-QUERY-br-pedidos pedido.nr-pedido ~
pedido.num-cliente pedido.val-total pedido.nom-projeto pedido.val-desconto ~
fnSituacaoPedido(pedido.situacao) @ c-situacao-ped pedido.dt-pedido ~
pedido.dt-previsao-fat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-pedidos 
&Scoped-define QUERY-STRING-br-pedidos FOR EACH pedido ~
      WHERE pedido.cd-favorecido = input frame {&frame-name} i-cd-favorecido ~
 AND (IF INPUT FRAME {&FRAME-NAME} pend THEN pedido.situacao < 4 ELSE TRUE) ~
 AND (IF INPUT FRAME {&FRAME-NAME} ped-ant THEN TRUE ELSE pedido.nr-pedido-ant = 0) NO-LOCK ~
    BY pedido.dt-pedido DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-pedidos OPEN QUERY br-pedidos FOR EACH pedido ~
      WHERE pedido.cd-favorecido = input frame {&frame-name} i-cd-favorecido ~
 AND (IF INPUT FRAME {&FRAME-NAME} pend THEN pedido.situacao < 4 ELSE TRUE) ~
 AND (IF INPUT FRAME {&FRAME-NAME} ped-ant THEN TRUE ELSE pedido.nr-pedido-ant = 0) NO-LOCK ~
    BY pedido.dt-pedido DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-pedidos pedido
&Scoped-define FIRST-TABLE-IN-QUERY-br-pedidos pedido


/* Definitions for BROWSE br-tarefas                                    */
&Scoped-define FIELDS-IN-QUERY-br-tarefas tarefa.dt-alert-tarefa tarefa.responsavel tarefa.ds-tarefa fnSituacaoTarefa(tarefa.situacao) @ cSituacao tarefa.perc-con tarefa.dt-cri-tarefa tarefa.nome   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-tarefas   
&Scoped-define SELF-NAME br-tarefas
&Scoped-define QUERY-STRING-br-tarefas FOR EACH tarefa OF favorecido       WHERE (IF INPUT FRAME DEFAULT-FRAME l-tarefas-encerradas THEN TRUE ELSE tarefa.situacao <= 7) /* Nao concluidas e nao canceladas */       AND tarefa.num-os = 0 NO-LOCK       BY tarefa.dt-alert-tarefa INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-tarefas OPEN QUERY {&SELF-NAME} FOR EACH tarefa OF favorecido       WHERE (IF INPUT FRAME DEFAULT-FRAME l-tarefas-encerradas THEN TRUE ELSE tarefa.situacao <= 7) /* Nao concluidas e nao canceladas */       AND tarefa.num-os = 0 NO-LOCK       BY tarefa.dt-alert-tarefa INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-tarefas tarefa
&Scoped-define FIRST-TABLE-IN-QUERY-br-tarefas tarefa


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-apont}~
    ~{&OPEN-QUERY-br-atendimentos}~
    ~{&OPEN-QUERY-br-contatos}~
    ~{&OPEN-QUERY-br-itens}~
    ~{&OPEN-QUERY-br-pedidos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br-apont br-itens br-tarefas bt-data btNext ~
potl ped-ant pend btProp bt-minhas-tarefas btCli bt-anexos obs-cont ~
bt-caracteristica bt-eliminar-atend bt-eliminar-contato bt-incluir-atend ~
bt-incluir-contato bt-modificar-atend bt-modificar-contato btExit ~
i-cd-favorecido c-ds-favorecido bt-eliminar-apont br-pedidos ~
br-atendimentos bt-incluir-apont bt-modificar-apont br-contatos obs-tarefa ~
bt-eliminar-tarefa bt-incluir-tarefa bt-modificar-tarefa ~
l-tarefas-encerradas l-contatos-ativos RECT-8 IMAGE-1 
&Scoped-Define DISPLAYED-OBJECTS pot potl ped-ant pend obs-apont obs-cont ~
i-cd-favorecido c-ds-favorecido cCidade cEstado obs-tarefa ~
l-tarefas-encerradas l-contatos-ativos 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnSituacaoPedido C-Win 
FUNCTION fnSituacaoPedido RETURNS CHARACTER
  ( INPUT i-sit AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-anexos 
     IMAGE-UP FILE "image/im-save.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-save.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Anexos" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anexos".

DEFINE BUTTON bt-caracteristica 
     IMAGE-UP FILE "image/im-login.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-login.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Caracter°sticas" 
     SIZE 6.14 BY 1.79 TOOLTIP "Caracter°sticas".

DEFINE BUTTON bt-data 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Data" 
     SIZE 6.14 BY 1.79 TOOLTIP "Altera data de alerta da tarefa".

DEFINE BUTTON bt-eliminar-apont 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON bt-eliminar-atend 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON bt-eliminar-contato 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON bt-eliminar-tarefa 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON bt-incluir-apont 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON bt-incluir-atend 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON bt-incluir-contato 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON bt-incluir-tarefa 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON bt-minhas-tarefas 
     IMAGE-UP FILE "image/im-plan.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-plan.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Minhas" 
     SIZE 6.14 BY 1.79 TOOLTIP "Minhas Tarefas".

DEFINE BUTTON bt-modificar-apont 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON bt-modificar-atend 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON bt-modificar-contato 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON bt-modificar-tarefa 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btCli 
     IMAGE-UP FILE "image/im-login.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-login.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Manutená∆o de Clientes".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-fled.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fled.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo Cliente".

DEFINE BUTTON btProp 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cadastro de Pedidos".

DEFINE VARIABLE obs-apont AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 61 BY 3.25 NO-UNDO.

DEFINE VARIABLE obs-cont AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 46 BY 10 NO-UNDO.

DEFINE VARIABLE obs-tarefa AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 57 BY 3.75 NO-UNDO.

DEFINE VARIABLE c-ds-favorecido AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .79 NO-UNDO.

DEFINE VARIABLE cCidade AS CHARACTER FORMAT "X(30)" 
     LABEL "Cidade" 
     VIEW-AS FILL-IN 
     SIZE 29 BY .79.

DEFINE VARIABLE cEstado AS CHARACTER FORMAT "X(2)" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79.

DEFINE VARIABLE i-cd-favorecido AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 8 BY .79 NO-UNDO.

DEFINE VARIABLE pot AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 7 BY .67
     FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE potl AS CHARACTER FORMAT "X(256)":U INITIAL "Potencial R$:" 
      VIEW-AS TEXT 
     SIZE 9 BY .67
     FGCOLOR 12  NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 17 BY 4.5.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 167.43 BY 2.17.

DEFINE VARIABLE l-contatos-ativos AS LOGICAL INITIAL yes 
     LABEL "Somente Ativos" 
     VIEW-AS TOGGLE-BOX
     SIZE 13 BY .83 NO-UNDO.

DEFINE VARIABLE l-tarefas-encerradas AS LOGICAL INITIAL no 
     LABEL "Mostrar Encerradas" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .83 NO-UNDO.

DEFINE VARIABLE ped-ant AS LOGICAL INITIAL no 
     LABEL "Mostrar Antecipaá‰es" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE pend AS LOGICAL INITIAL yes 
     LABEL "Somente Ativos" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-apont FOR 
      apontamento SCROLLING.

DEFINE QUERY br-atendimentos FOR 
      atendimento SCROLLING.

DEFINE QUERY br-contatos FOR 
      contato SCROLLING.

DEFINE QUERY br-itens FOR 
      pedido-item, 
      item SCROLLING.

DEFINE QUERY br-pedidos FOR 
      pedido SCROLLING.

DEFINE QUERY br-tarefas FOR 
      tarefa SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-apont C-Win _STRUCTURED
  QUERY br-apont NO-LOCK DISPLAY
      apontamento.data FORMAT "99/99/9999":U
      apontamento.nome FORMAT "X(10)":U
      apontamento.hora-ini FORMAT "x(6)":U
      apontamento.hora-fim FORMAT "x(6)":U
      apontamento.qt-apontada FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 37 BY 8.75
         FONT 4
         TITLE "Apontamentos".

DEFINE BROWSE br-atendimentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-atendimentos C-Win _STRUCTURED
  QUERY br-atendimentos NO-LOCK DISPLAY
      atendimento.data FORMAT "99/99/9999":U WIDTH 9.43
      atendimento.hora FORMAT "x(05)":U WIDTH 5
      atendimento.usuario FORMAT "x(10)":U
      atendimento.contato FORMAT "x(20)":U WIDTH 13.86
      atendimento.observacao FORMAT "x(2000)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 46 BY 12.25
         FONT 4
         TITLE "Atendimentos" FIT-LAST-COLUMN.

DEFINE BROWSE br-contatos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-contatos C-Win _STRUCTURED
  QUERY br-contatos NO-LOCK DISPLAY
      contato.nome-apelido FORMAT "X(20)":U WIDTH 10
      contato.telefone FORMAT "X(20)":U WIDTH 12
      contato.celular FORMAT "X(20)":U WIDTH 12
      contato.cargo FORMAT "x(40)":U WIDTH 20
      contato.email FORMAT "x(100)":U WIDTH 40
      contato.nome FORMAT "X(60)":U WIDTH 40
      contato.data-nasc FORMAT "99/99/9999":U WIDTH 12
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 57 BY 10.5
         FONT 4
         TITLE "Contatos" ROW-HEIGHT-CHARS .54.

DEFINE BROWSE br-itens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-itens C-Win _STRUCTURED
  QUERY br-itens NO-LOCK DISPLAY
      pedido-item.ds-pedido-item FORMAT "x(40)":U WIDTH 20
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ROW-MARKERS SEPARATORS SIZE 24 BY 8.75
         FONT 4
         TITLE "Itens do Pedido".

DEFINE BROWSE br-pedidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-pedidos C-Win _STRUCTURED
  QUERY br-pedidos NO-LOCK DISPLAY
      pedido.nr-pedido FORMAT ">>>>,>>9":U WIDTH 6
      pedido.num-cliente FORMAT "x(12)":U
      pedido.val-total FORMAT "->>,>>9.99":U WIDTH 9.43
      pedido.nom-projeto FORMAT "x(80)":U
      pedido.val-desconto FORMAT "->>,>>9.99":U
      fnSituacaoPedido(pedido.situacao) @ c-situacao-ped COLUMN-LABEL "Situaá∆o"
            WIDTH 8.43
      pedido.dt-pedido FORMAT "99/99/9999":U WIDTH 9.72
      pedido.dt-previsao-fat FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 61 BY 6.75
         FONT 4
         TITLE "Pedidos" ROW-HEIGHT-CHARS .54.

DEFINE BROWSE br-tarefas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-tarefas C-Win _FREEFORM
  QUERY br-tarefas NO-LOCK DISPLAY
      tarefa.dt-alert-tarefa FORMAT "99/99/9999":U
      tarefa.responsavel FORMAT "X(8)":U
      tarefa.ds-tarefa FORMAT "x(40)":U
      fnSituacaoTarefa(tarefa.situacao) @ cSituacao WIDTH 10
      tarefa.perc-con FORMAT "->>,>>9.99":U
      tarefa.dt-cri-tarefa FORMAT "99/99/9999":U
      tarefa.nome FORMAT "X(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 57 BY 6
         FONT 4
         TITLE "Tarefas".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-apont AT ROW 11 COL 131 WIDGET-ID 500
     br-itens AT ROW 11 COL 107 WIDGET-ID 600
     br-tarefas AT ROW 16 COL 2 WIDGET-ID 700
     bt-data AT ROW 25.75 COL 20 WIDGET-ID 102
     btNext AT ROW 1.25 COL 3 WIDGET-ID 100
     pot AT ROW 3.38 COL 159 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     potl AT ROW 3.38 COL 149 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     ped-ant AT ROW 3.25 COL 127 WIDGET-ID 92
     pend AT ROW 3.25 COL 108 WIDGET-ID 90
     btProp AT ROW 1.25 COL 156 WIDGET-ID 88
     bt-minhas-tarefas AT ROW 25.75 COL 26 WIDGET-ID 86
     btCli AT ROW 1.25 COL 150 WIDGET-ID 84
     bt-anexos AT ROW 23 COL 125 WIDGET-ID 64
     obs-apont AT ROW 19.75 COL 107 NO-LABEL WIDGET-ID 62
     obs-cont AT ROW 15.75 COL 60 NO-LABEL WIDGET-ID 60
     bt-caracteristica AT ROW 14 COL 20 WIDGET-ID 56
     bt-eliminar-atend AT ROW 25.75 COL 72 WIDGET-ID 50
     bt-eliminar-contato AT ROW 14 COL 14 WIDGET-ID 46
     bt-incluir-atend AT ROW 25.75 COL 60 WIDGET-ID 52
     bt-incluir-contato AT ROW 14 COL 2 WIDGET-ID 44
     bt-modificar-atend AT ROW 25.75 COL 66 WIDGET-ID 54
     bt-modificar-contato AT ROW 14 COL 8 WIDGET-ID 48
     btExit AT ROW 1.25 COL 162 WIDGET-ID 42
     i-cd-favorecido AT ROW 1.75 COL 14 COLON-ALIGNED WIDGET-ID 2
     c-ds-favorecido AT ROW 1.75 COL 22 COLON-ALIGNED NO-LABEL WIDGET-ID 6 NO-TAB-STOP 
     bt-eliminar-apont AT ROW 23 COL 119 WIDGET-ID 66
     br-pedidos AT ROW 4.25 COL 107 WIDGET-ID 400
     br-atendimentos AT ROW 3.5 COL 60 WIDGET-ID 300
     bt-incluir-apont AT ROW 23 COL 107 WIDGET-ID 68
     bt-modificar-apont AT ROW 23 COL 113 WIDGET-ID 70
     br-contatos AT ROW 3.5 COL 2 WIDGET-ID 200
     cCidade AT ROW 1.75 COL 79 COLON-ALIGNED WIDGET-ID 72
     cEstado AT ROW 1.75 COL 108 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     obs-tarefa AT ROW 22 COL 2 NO-LABEL WIDGET-ID 76
     bt-eliminar-tarefa AT ROW 25.75 COL 14 WIDGET-ID 78
     bt-incluir-tarefa AT ROW 25.75 COL 2 WIDGET-ID 80
     bt-modificar-tarefa AT ROW 25.75 COL 8 WIDGET-ID 82
     l-tarefas-encerradas AT ROW 25.75 COL 43 WIDGET-ID 104
     l-contatos-ativos AT ROW 14 COL 46 WIDGET-ID 106
     RECT-8 AT ROW 1.08 COL 1.57 WIDGET-ID 4
     IMAGE-1 AT ROW 23 COL 151 WIDGET-ID 58
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 168 BY 26.54
         FONT 4 WIDGET-ID 100.


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
         TITLE              = "CRM"
         HEIGHT             = 26.54
         WIDTH              = 168
         MAX-HEIGHT         = 34.92
         MAX-WIDTH          = 228.57
         VIRTUAL-HEIGHT     = 34.92
         VIRTUAL-WIDTH      = 228.57
         RESIZE             = yes
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
/* BROWSE-TAB br-apont 1 DEFAULT-FRAME */
/* BROWSE-TAB br-itens br-apont DEFAULT-FRAME */
/* BROWSE-TAB br-tarefas br-itens DEFAULT-FRAME */
/* BROWSE-TAB br-pedidos bt-eliminar-apont DEFAULT-FRAME */
/* BROWSE-TAB br-atendimentos br-pedidos DEFAULT-FRAME */
/* BROWSE-TAB br-contatos bt-modificar-apont DEFAULT-FRAME */
ASSIGN 
       br-contatos:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

ASSIGN 
       br-pedidos:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

ASSIGN 
       c-ds-favorecido:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN cCidade IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN cEstado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR obs-apont IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       obs-apont:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       obs-cont:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       obs-tarefa:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN pot IN FRAME DEFAULT-FRAME
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
     _TblOptList       = ", FIRST, FIRST"
     _OrdList          = "money.apontamento.data|no,money.apontamento.sequencia|yes,money.apontamento.nome|yes,money.apontamento.hora-ini|no"
     _Where[1]         = "apontamento.nr-pedido = pedido.nr-pedido
 AND apontamento.sequencia = pedido-item.sequencia "
     _FldNameList[1]   = money.apontamento.data
     _FldNameList[2]   > money.apontamento.nome
"apontamento.nome" ? "X(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.apontamento.hora-ini
"apontamento.hora-ini" ? "x(6)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.apontamento.hora-fim
"apontamento.hora-fim" ? "x(6)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = money.apontamento.qt-apontada
     _Query            is OPENED
*/  /* BROWSE br-apont */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-atendimentos
/* Query rebuild information for BROWSE br-atendimentos
     _TblList          = "money.atendimento"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.atendimento.data|no,money.atendimento.hora|no"
     _Where[1]         = "atendimento.cd-favorecido = input frame {&frame-name} i-cd-favorecido"
     _FldNameList[1]   > money.atendimento.data
"atendimento.data" ? ? "date" ? ? ? ? ? ? no ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > money.atendimento.hora
"atendimento.hora" ? ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.atendimento.usuario
"atendimento.usuario" ? "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.atendimento.contato
"atendimento.contato" ? "x(20)" "character" ? ? ? ? ? ? no ? no no "13.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = money.atendimento.observacao
     _Query            is OPENED
*/  /* BROWSE br-atendimentos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-contatos
/* Query rebuild information for BROWSE br-contatos
     _TblList          = "money.contato"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "contato.cd-favorecido = input frame {&frame-name} i-cd-favorecido
AND (IF INPUT FRAME DEFAULT-FRAME l-contatos-ativos THEN contato.ativo ELSE TRUE)"
     _FldNameList[1]   > money.contato.nome-apelido
"contato.nome-apelido" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > money.contato.telefone
"contato.telefone" ? ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.contato.celular
"contato.celular" ? ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.contato.cargo
"contato.cargo" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > money.contato.email
"contato.email" ? ? "character" ? ? ? ? ? ? no ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > money.contato.nome
"contato.nome" ? ? "character" ? ? ? ? ? ? no ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > money.contato.data-nasc
"contato.data-nasc" ? ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br-contatos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-itens
/* Query rebuild information for BROWSE br-itens
     _TblList          = "money.pedido-item,money.item OF money.pedido-item"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "pedido-item.nr-pedido = pedido.nr-pedido"
     _FldNameList[1]   > money.pedido-item.ds-pedido-item
"pedido-item.ds-pedido-item" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br-itens */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-pedidos
/* Query rebuild information for BROWSE br-pedidos
     _TblList          = "money.pedido"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.pedido.dt-pedido|no"
     _Where[1]         = "pedido.cd-favorecido = input frame {&frame-name} i-cd-favorecido
 AND (IF INPUT FRAME {&FRAME-NAME} pend THEN pedido.situacao < 4 ELSE TRUE)
 AND (IF INPUT FRAME {&FRAME-NAME} ped-ant THEN TRUE ELSE pedido.nr-pedido-ant = 0)"
     _FldNameList[1]   > money.pedido.nr-pedido
"pedido.nr-pedido" ? ? "integer" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = money.pedido.num-cliente
     _FldNameList[3]   > money.pedido.val-total
"pedido.val-total" ? ? "decimal" ? ? ? ? ? ? no ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = money.pedido.nom-projeto
     _FldNameList[5]   = money.pedido.val-desconto
     _FldNameList[6]   > "_<CALC>"
"fnSituacaoPedido(pedido.situacao) @ c-situacao-ped" "Situaá∆o" ? ? ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > money.pedido.dt-pedido
"pedido.dt-pedido" ? ? "date" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   = money.pedido.dt-previsao-fat
     _Query            is OPENED
*/  /* BROWSE br-pedidos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-tarefas
/* Query rebuild information for BROWSE br-tarefas
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tarefa OF favorecido
      WHERE (IF INPUT FRAME DEFAULT-FRAME l-tarefas-encerradas THEN TRUE ELSE tarefa.situacao <= 7) /* Nao concluidas e nao canceladas */
      AND tarefa.num-os = 0 NO-LOCK
      BY tarefa.dt-alert-tarefa INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.tarefa OF money.favorecido.dt-alert-tarefa|yes"
     _Where[1]         = "tarefa.situacao <= 7 /* Nao concluidas e nao canceladas */
 AND tarefa.num-os = 0"
     _Query            is NOT OPENED
*/  /* BROWSE br-tarefas */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* CRM */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* CRM */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESIZED OF C-Win /* CRM */
DO:
    
    ASSIGN FRAME default-frame:WIDTH = C-Win:WIDTH
           FRAME default-frame:HEIGHT = C-Win:HEIGHT.
    
    DO WITH FRAME {&FRAME-NAME}:
        ASSIGN RECT-8:WIDTH = C-Win:WIDTH - 0.57
               btExit:COLUMN = C-Win:WIDTH - 6
               btProp:COLUMN = C-Win:WIDTH - 12
               btCli:COLUMN = C-Win:WIDTH - 18
               br-pedidos:COLUMN = C-Win:WIDTH - 61
               br-apont:COLUMN = C-Win:WIDTH - 37
               br-itens:COLUMN = C-Win:WIDTH - 61
               obs-apont:COLUMN = C-Win:WIDTH - 61
               image-1:COLUMN = C-Win:WIDTH - 17
               bt-incluir-apont:COLUMN = C-Win:WIDTH - 61
               bt-modificar-apont:COLUMN = C-Win:WIDTH - 55
               bt-eliminar-apont:COLUMN = C-Win:WIDTH - 49
               bt-anexos:COLUMN = C-Win:WIDTH - 43
               br-atendimentos:WIDTH = C-Win:WIDTH - 122
               obs-cont:WIDTH = C-Win:WIDTH - 122
               bt-incluir-atend:ROW = C-Win:HEIGHT - 0.79
               bt-modificar-atend:ROW = C-Win:HEIGHT - 0.79
               bt-eliminar-atend:ROW = C-Win:HEIGHT - 0.79
               obs-cont:ROW = C-Win:HEIGHT - 10.79
               br-atendimentos:HEIGHT = C-Win:HEIGHT - 14.29
               bt-incluir-tarefa:ROW = C-Win:HEIGHT - 0.79
               bt-modificar-tarefa:ROW = C-Win:HEIGHT - 0.79
               bt-eliminar-tarefa:ROW = C-Win:HEIGHT - 0.79
               bt-data:ROW = C-Win:HEIGHT - 0.79
               bt-minhas-tarefas:ROW = C-Win:HEIGHT - 0.79
               obs-tarefa:ROW = C-Win:HEIGHT - 4.54
               br-tarefas:ROW = C-Win:HEIGHT - 10.54
               bt-incluir-contato:ROW = C-Win:HEIGHT - 12.54
               bt-modificar-contato:ROW = C-Win:HEIGHT - 12.54
               bt-eliminar-contato:ROW = C-Win:HEIGHT - 12.54
               bt-caracteristica:ROW = C-Win:HEIGHT - 12.54
               br-contatos:HEIGHT = C-Win:HEIGHT - 16.04
               bt-incluir-apont:ROW = C-Win:HEIGHT - 3.54
               bt-modificar-apont:ROW = C-Win:HEIGHT - 3.54
               bt-eliminar-apont:ROW = C-Win:HEIGHT - 3.54
               bt-anexos:ROW = C-Win:HEIGHT - 3.54
               obs-apont:ROW = C-Win:HEIGHT - 6.79
               br-itens:ROW = C-Win:HEIGHT - 15.54
               br-apont:ROW = C-Win:HEIGHT - 15.54
               br-pedidos:HEIGHT = C-Win:HEIGHT - 19.79
               image-1:ROW = C-Win:HEIGHT - 3.54
               pend:COLUMN = C-Win:WIDTH - 60.0
               ped-ant:COLUMN = C-Win:WIDTH - 41.0
               pot:COLUMN = C-Win:WIDTH - 12.0
               potl:COLUMN = C-Win:WIDTH - 22.0
               l-contatos-ativos:ROW = C-Win:HEIGHT - 12.54
               l-tarefas-encerradas:ROW = C-Win:HEIGHT - 0.79.
    END.

    ASSIGN FRAME default-frame:WIDTH = C-Win:WIDTH
           FRAME default-frame:HEIGHT = C-Win:HEIGHT
           FRAME default-frame:VIRTUAL-WIDTH = C-Win:WIDTH
           FRAME default-frame:VIRTUAL-HEIGHT = C-Win:HEIGHT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-apont
&Scoped-define SELF-NAME br-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-apont C-Win
ON MOUSE-SELECT-DBLCLICK OF br-apont IN FRAME DEFAULT-FRAME /* Apontamentos */
DO:
  
    APPLY "CHOOSE" TO bt-modificar-apont.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-apont C-Win
ON VALUE-CHANGED OF br-apont IN FRAME DEFAULT-FRAME /* Apontamentos */
DO:
  
    IF AVAIL apontamento THEN DO:
        ASSIGN obs-apont:SCREEN-VALUE = apontamento.ds-apontamento.
        IF apontamento.nome = gcUsuario THEN
            ENABLE bt-modificar-apont
                   bt-eliminar-apont
                WITH FRAME {&FRAME-NAME}.
        ELSE
            DISABLE bt-modificar-apont
                    bt-eliminar-apont
                WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ASSIGN obs-apont:SCREEN-VALUE = "".
        DISABLE bt-modificar-apont
                bt-eliminar-apont
             WITH FRAME {&FRAME-NAME}.

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-atendimentos
&Scoped-define SELF-NAME br-atendimentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-atendimentos C-Win
ON MOUSE-SELECT-DBLCLICK OF br-atendimentos IN FRAME DEFAULT-FRAME /* Atendimentos */
DO:
  
    APPLY "CHOOSE" TO bt-modificar-atend.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-atendimentos C-Win
ON VALUE-CHANGED OF br-atendimentos IN FRAME DEFAULT-FRAME /* Atendimentos */
DO:
  
    IF AVAIL atendimento THEN
        ASSIGN obs-cont:SCREEN-VALUE = atendimento.observacao.
    ELSE
        ASSIGN obs-cont:SCREEN-VALUE = "".
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-contatos
&Scoped-define SELF-NAME br-contatos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-contatos C-Win
ON MOUSE-SELECT-DBLCLICK OF br-contatos IN FRAME DEFAULT-FRAME /* Contatos */
DO:
  
    APPLY "CHOOSE" TO bt-modificar-contato.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-itens
&Scoped-define SELF-NAME br-itens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-itens C-Win
ON VALUE-CHANGED OF br-itens IN FRAME DEFAULT-FRAME /* Itens do Pedido */
DO:

   {&OPEN-QUERY-br-apont}
   APPLY "VALUE-CHANGED" TO br-apont.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-pedidos
&Scoped-define SELF-NAME br-pedidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-pedidos C-Win
ON MOUSE-SELECT-DBLCLICK OF br-pedidos IN FRAME DEFAULT-FRAME /* Pedidos */
DO:

    IF AVAIL pedido THEN DO:
        ASSIGN r-pedido = ROWID(pedido).
        {func\run.i &Programa = "pedido.w" &MENU = YES}
        RUN initialize.
        {&OPEN-QUERY-br-pedidos}
        APPLY "VALUE-CHANGED" TO br-pedidos.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-pedidos C-Win
ON ROW-DISPLAY OF br-pedidos IN FRAME DEFAULT-FRAME /* Pedidos */
DO:
  IF pedido.dt-previsao-fat = ?
  AND NOT CAN-FIND(FIRST bf-ped
                   WHERE bf-ped.nr-pedido-ant = pedido.nr-pedido) /* N∆o Fechado */ THEN DO:
      ASSIGN pedido.nr-pedido      :FGCOLOR IN BROWSE br-pedidos = 12
             c-situacao-ped        :FGCOLOR IN BROWSE br-pedidos = 12
             pedido.val-total      :FGCOLOR IN BROWSE br-pedidos = 12
             pedido.val-desconto   :FGCOLOR IN BROWSE br-pedidos = 12
             pedido.dt-pedido      :FGCOLOR IN BROWSE br-pedidos = 12
             pedido.num-cliente    :FGCOLOR IN BROWSE br-pedidos = 12
             pedido.nom-projeto    :FGCOLOR IN BROWSE br-pedidos = 12
             pedido.dt-previsao-fat:FGCOLOR IN BROWSE br-pedidos = 12.
  END.
  IF pedido.situacao = 9 /* Cancelado */ THEN DO:
      ASSIGN pedido.nr-pedido      :FGCOLOR IN BROWSE br-pedidos = 7
             c-situacao-ped        :FGCOLOR IN BROWSE br-pedidos = 7
             pedido.val-total      :FGCOLOR IN BROWSE br-pedidos = 7
             pedido.val-desconto   :FGCOLOR IN BROWSE br-pedidos = 7
             pedido.dt-pedido      :FGCOLOR IN BROWSE br-pedidos = 7
             pedido.num-cliente    :FGCOLOR IN BROWSE br-pedidos = 7
             pedido.nom-projeto    :FGCOLOR IN BROWSE br-pedidos = 7
             pedido.dt-previsao-fat:FGCOLOR IN BROWSE br-pedidos = 7.
  END.
  IF pedido.situacao = 4 /* Faturado */ THEN DO:
      ASSIGN pedido.nr-pedido      :FGCOLOR IN BROWSE br-pedidos = 24
             c-situacao-ped        :FGCOLOR IN BROWSE br-pedidos = 24
             pedido.val-total      :FGCOLOR IN BROWSE br-pedidos = 24
             pedido.val-desconto   :FGCOLOR IN BROWSE br-pedidos = 24
             pedido.dt-pedido      :FGCOLOR IN BROWSE br-pedidos = 24
             pedido.num-cliente    :FGCOLOR IN BROWSE br-pedidos = 24
             pedido.nom-projeto    :FGCOLOR IN BROWSE br-pedidos = 24
             pedido.dt-previsao-fat:FGCOLOR IN BROWSE br-pedidos = 24.
  END.
  IF pedido.nr-pedido-ant <> 0 THEN DO:
      ASSIGN pedido.nr-pedido      :FGCOLOR IN BROWSE br-pedidos = 2
             c-situacao-ped        :FGCOLOR IN BROWSE br-pedidos = 2
             pedido.val-total      :FGCOLOR IN BROWSE br-pedidos = 2
             pedido.val-desconto   :FGCOLOR IN BROWSE br-pedidos = 2
             pedido.dt-pedido      :FGCOLOR IN BROWSE br-pedidos = 2
             pedido.num-cliente    :FGCOLOR IN BROWSE br-pedidos = 2
             pedido.nom-projeto    :FGCOLOR IN BROWSE br-pedidos = 2
             pedido.dt-previsao-fat:FGCOLOR IN BROWSE br-pedidos = 2.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-pedidos C-Win
ON VALUE-CHANGED OF br-pedidos IN FRAME DEFAULT-FRAME /* Pedidos */
DO:

   ASSIGN pot = 0.
   FOR EACH bf-ped NO-LOCK
       WHERE bf-ped.cd-favorecido = input frame {&frame-name} i-cd-favorecido
       AND   bf-ped.situacao < 4 /* Faturado */
       AND   bf-ped.dt-previsao-fat = ? /* N∆o Fechado */
       AND NOT CAN-FIND(FIRST pedido
                        WHERE pedido.nr-pedido-ant = bf-ped.nr-pedido):
       ASSIGN pot = pot + bf-ped.val-total.
   END.

   {&OPEN-QUERY-br-itens}
   APPLY "VALUE-CHANGED" TO br-itens.
   DISP pot
       WITH FRAME {&FRAME-NAME}.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-tarefas
&Scoped-define SELF-NAME br-tarefas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-tarefas C-Win
ON MOUSE-SELECT-DBLCLICK OF br-tarefas IN FRAME DEFAULT-FRAME /* Tarefas */
DO:
  
    APPLY "CHOOSE" TO bt-modificar-tarefa.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-tarefas C-Win
ON ROW-DISPLAY OF br-tarefas IN FRAME DEFAULT-FRAME /* Tarefas */
DO:
  
    IF AVAIL tarefa THEN DO:

        IF tarefa.dt-alert-tarefa <= TODAY THEN DO:

            ASSIGN tarefa.dt-cri-tarefa:FGCOLOR IN BROWSE br-tarefas = 12
                   tarefa.dt-alert-tarefa:FGCOLOR IN BROWSE br-tarefas = 12
                   tarefa.nome:FGCOLOR IN BROWSE br-tarefas = 12
                   tarefa.ds-tarefa:FGCOLOR IN BROWSE br-tarefas = 12
                   cSituacao:FGCOLOR IN BROWSE br-tarefas = 12
                   tarefa.perc-con:FGCOLOR IN BROWSE br-tarefas = 12
                   tarefa.responsavel:FGCOLOR IN BROWSE br-tarefas = 12.

        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-tarefas C-Win
ON VALUE-CHANGED OF br-tarefas IN FRAME DEFAULT-FRAME /* Tarefas */
DO:
  
    IF AVAIL tarefa THEN
        ASSIGN obs-tarefa:SCREEN-VALUE = tarefa.ds-observacao.
    ELSE
        ASSIGN obs-tarefa:SCREEN-VALUE = "".
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-anexos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-anexos C-Win
ON CHOOSE OF bt-anexos IN FRAME DEFAULT-FRAME /* Anexos */
DO:
    IF AVAIL pedido-item THEN DO:        
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-pedido-item = ROWID(pedido-item).
        {func\run.i &Programa = "anexo.w"}    
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-caracteristica
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-caracteristica C-Win
ON CHOOSE OF bt-caracteristica IN FRAME DEFAULT-FRAME /* Caracter°sticas */
DO:
  IF AVAIL contato THEN DO:
      ASSIGN r-contato = ROWID(contato).    
    
      {func\run.i &Programa = "contato-caracteristica.w"}
  END.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-data C-Win
ON CHOOSE OF bt-data IN FRAME DEFAULT-FRAME /* Data */
DO:

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tarefa THEN DO:

        {func\run.i &Programa = "data.w (INPUT 'Data de Alerta', INPUT tarefa.dt-alert-tarefa, OUTPUT dtTemp)"}
        IF dtTemp <> ? AND dtTemp >= TODAY THEN DO:
            FIND CURRENT tarefa EXCLUSIVE-LOCK.
            ASSIGN tarefa.dt-alert-tarefa = dtTemp.
        END.
        {&OPEN-QUERY-br-tarefas}
        APPLY "VALUE-CHANGED" TO br-tarefas.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-eliminar-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-eliminar-apont C-Win
ON CHOOSE OF bt-eliminar-apont IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    DEFINE BUFFER bf-pedido-item FOR pedido-item.

    DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

    IF AVAIL apontamento THEN DO:

        RUN som.p(INPUT "music\click.wav").
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
        IF RETURN-VALUE = "OK" THEN DO:
            FIND CURRENT apontamento EXCLUSIVE-LOCK.
            ASSIGN deAux = apontamento.qt-apontada.
            DELETE apontamento.
        END.

        FIND CURRENT pedido-item EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL pedido-item THEN DO:

            /* Controla qt-atendida do item do pedido */
            ASSIGN pedido-item.qt-atendida = pedido-item.qt-atendida - deAux.

            /* Controla situaá∆o do item do pedido */
            IF pedido-item.qt-atendida = 0 THEN
                ASSIGN pedido-item.situacao = 1 /* Pendente */.
            ELSE
                IF pedido-item.qt-atendida < pedido-item.qt-pedida THEN
                    ASSIGN pedido-item.situacao = 2 /* Iniciado */.
                ELSE
                    ASSIGN pedido-item.situacao = 3 /* Atendido */.

            /* Controla a situaá∆o do pedido */
            FIND FIRST pedido OF pedido-item EXCLUSIVE-LOCK.
            ASSIGN pedido.situacao = 1. /* Pendente */
            IF CAN-FIND(FIRST bf-pedido-item OF pedido
                        WHERE bf-pedido-item.situacao = 2
                        OR    bf-pedido-item.situacao = 3) THEN
                ASSIGN pedido.situacao = 2. /* Iniciado */
            IF NOT CAN-FIND(FIRST bf-pedido-item OF pedido
                            WHERE bf-pedido-item.situacao = 1
                            OR    bf-pedido-item.situacao = 2) THEN
                ASSIGN pedido.situacao = 3. /* Atendido */
            IF NOT CAN-FIND(FIRST bf-pedido-item OF pedido
                            WHERE bf-pedido-item.situacao = 1
                            OR    bf-pedido-item.situacao = 2
                            OR    bf-pedido-item.situacao = 3)
            AND CAN-FIND(FIRST bf-pedido-item OF pedido
                         WHERE bf-pedido-item.situacao = 9) THEN
                ASSIGN pedido.situacao = 9. /* Cancelado */
        END.

        APPLY "VALUE-CHANGED" TO br-itens.
        
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-eliminar-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-eliminar-atend C-Win
ON CHOOSE OF bt-eliminar-atend IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    IF AVAIL atendimento THEN DO:
        {func\bt_del_page.i atendimento}  
        {&OPEN-QUERY-br-atendimentos}
        APPLY "VALUE-CHANGED" TO br-atendimentos.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-eliminar-contato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-eliminar-contato C-Win
ON CHOOSE OF bt-eliminar-contato IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    IF AVAIL contato THEN DO:

        {func\bt_del_page.i}  

        IF RETURN-VALUE = "OK" THEN DO:
            /* eleiminar relacionamentos: Caracteristicas do contato */
            FOR EACH contato-caracteristica OF contato EXCLUSIVE-LOCK:
                DELETE contato-caracteristica.
            END.

            {&OPEN-QUERY-br-contatos}
        END.                         
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-eliminar-tarefa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-eliminar-tarefa C-Win
ON CHOOSE OF bt-eliminar-tarefa IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    IF AVAIL tarefa THEN DO:
        {func\bt_del_page.i tarefa}
        {&OPEN-QUERY-br-tarefas}
        APPLY "VALUE-CHANGED" TO br-tarefas.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-incluir-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluir-apont C-Win
ON CHOOSE OF bt-incluir-apont IN FRAME DEFAULT-FRAME /* Incluir */
DO:

    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN pcActionBT = "ADD"
               r-parent = ROWID(usuario)
               giNr-pedido = pedido-item.nr-pedido
               giSequencia = pedido-item.sequencia.
        {func\run.i &Programa = "apontamento_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            APPLY "VALUE-CHANGED" TO br-itens.
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-incluir-atend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluir-atend C-Win
ON CHOOSE OF bt-incluir-atend IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    IF INPUT FRAME {&FRAME-NAME} i-cd-favorecido <> 0 THEN DO:
        {func\bt_add_page.i atendimento}
        {&OPEN-QUERY-br-atendimentos}
        APPLY "VALUE-CHANGED" TO br-atendimentos.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-incluir-contato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluir-contato C-Win
ON CHOOSE OF bt-incluir-contato IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    IF INPUT FRAME {&FRAME-NAME} i-cd-favorecido <> 0 THEN DO:
        {func\bt_add_page.i}
    
        {&OPEN-QUERY-br-contatos}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-incluir-tarefa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-incluir-tarefa C-Win
ON CHOOSE OF bt-incluir-tarefa IN FRAME DEFAULT-FRAME /* Incluir */
DO:

    IF INPUT FRAME {&FRAME-NAME} i-cd-favorecido <> 0 THEN DO:

        DO TRANS:
            
            FIND LAST bf-tarefa NO-LOCK
                WHERE bf-tarefa.nome = gcUsuario NO-ERROR.

            CREATE tarefa.
            ASSIGN tarefa.nome = gcUsuario
                   tarefa.sequencia = (IF AVAIL bf-tarefa THEN bf-tarefa.sequencia + 1 ELSE 1)
                   tarefa.cd-favorecido = INPUT FRAME {&FRAME-NAME} i-cd-favorecido
                   tarefa.dt-cri-tarefa = TODAY
                   tarefa.responsavel = tarefa.nome.
                   
            RUN som.p(INPUT "music\click.wav").
            ASSIGN r-parent = ROWID(usuario)
                   r-tarefa = ROWID(tarefa)
                   pcActionBT = "UPDATE"
                   glCRM = TRUE.
            {func\run.i &Programa = "tarefa_det.w"}
            IF RETURN-VALUE = "OK" THEN DO:
                {&OPEN-QUERY-br-tarefas}
                APPLY "VALUE-CHANGED" TO br-tarefas.
                {&OPEN-QUERY-br-atendimentos}
                APPLY "VALUE-CHANGED" TO br-atendimentos.
            END.
            ELSE DO:
                UNDO, LEAVE.
            END.
        END.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-minhas-tarefas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-minhas-tarefas C-Win
ON CHOOSE OF bt-minhas-tarefas IN FRAME DEFAULT-FRAME /* Minhas */
DO:

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario.
    ASSIGN r-usuario = ROWID(usuario).
    {func\run.i &Programa = "tarefa.w"}

    {&OPEN-QUERY-br-atendimentos}
    APPLY "VALUE-CHANGED" TO br-atendimentos.
    {&OPEN-QUERY-br-tarefas}
    APPLY "VALUE-CHANGED" TO br-tarefas.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-modificar-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-modificar-apont C-Win
ON CHOOSE OF bt-modificar-apont IN FRAME DEFAULT-FRAME /* Modificar */
DO:

    IF AVAIL apontamento THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-parent = ROWID(usuario)
               r-apontamento = ROWID(apontamento)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "apontamento_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            APPLY "VALUE-CHANGED" TO br-itens.
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
        {func\bt_update_page.i atendimento}  
        {&OPEN-QUERY-br-atendimentos}
        APPLY "VALUE-CHANGED" TO br-atendimentos.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-modificar-contato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-modificar-contato C-Win
ON CHOOSE OF bt-modificar-contato IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    IF AVAIL contato THEN DO:
        {func\bt_update_page.i}  
    
        {&OPEN-QUERY-br-contatos}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-modificar-tarefa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-modificar-tarefa C-Win
ON CHOOSE OF bt-modificar-tarefa IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    IF AVAIL tarefa THEN DO:              
        {func\bt_update_page.i tarefa}  
        {&OPEN-QUERY-br-atendimentos}
        APPLY "VALUE-CHANGED" TO br-atendimentos.
        APPLY "VALUE-CHANGED" TO br-tarefas.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCli C-Win
ON CHOOSE OF btCli IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    ASSIGN r-favorecido = ROWID(favorecido).
    {func\run.i &Programa = "fav.w"}

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


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido > INPUT FRAME {&FRAME-NAME} i-cd-favorecido
        AND   favorecido.ativo
        AND   (favorecido.tipo = 1 /* Cliente */ OR favorecido.tipo = 3 /* Ambos */) NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN i-cd-favorecido = favorecido.cd-favorecido.
        DISP i-cd-favorecido
            WITH FRAME {&FRAME-NAME}.
        APPLY "LEAVE" TO i-cd-favorecido.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btProp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btProp C-Win
ON CHOOSE OF btProp IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    IF AVAIL pedido THEN DO:
        ASSIGN r-pedido = ROWID(pedido).
    END.
    {func\run.i &Programa = "pedido.w" &MENU = YES}
    {&OPEN-QUERY-br-pedidos}
    APPLY "VALUE-CHANGED" TO br-pedidos.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME i-cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-cd-favorecido C-Win
ON ENTRY OF i-cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
  {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-cd-favorecido C-Win
ON LEAVE OF i-cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
  FIND FIRST favorecido NO-LOCK
       WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} i-cd-favorecido NO-ERROR.
  IF AVAIL favorecido THEN DO:
      ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = favorecido.ds-favorecido
             cCidade:SCREEN-VALUE IN FRAME {&FRAME-NAME} = favorecido.cidade
             cEstado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = favorecido.estado.
      IF favorecido.foto <> "" AND SEARCH(favorecido.foto) <> ? THEN
            image-1:LOAD-IMAGE(SEARCH(favorecido.foto)) IN FRAME {&FRAME-NAME}.            
      ELSE
            image-1:LOAD-IMAGE(SEARCH("image\im-naodisp.bmp")) IN FRAME {&FRAME-NAME}.              
  END.
  ELSE DO:
      ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
      image-1:LOAD-IMAGE(SEARCH("image\im-naodisp.bmp")) IN FRAME {&FRAME-NAME}.
  END.

  image-1:HIDDEN IN FRAME {&FRAME-NAME} = NO.    

  {&OPEN-QUERY-br-contatos}
  {&OPEN-QUERY-br-atendimentos}
  {&OPEN-QUERY-br-pedidos}
  {&OPEN-QUERY-br-tarefas}
  APPLY "VALUE-CHANGED" TO br-atendimentos.
  APPLY "VALUE-CHANGED" TO br-pedidos.
  APPLY "VALUE-CHANGED" TO br-tarefas.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF i-cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF i-cd-favorecido DO:    
    {func\zoom.i &ProgramaZoom="zoom\zcliente.w"
                 &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="i-cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="c-ds-favorecido"}
                 
    APPLY "leave" TO i-cd-favorecido IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME l-contatos-ativos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL l-contatos-ativos C-Win
ON VALUE-CHANGED OF l-contatos-ativos IN FRAME DEFAULT-FRAME /* Somente Ativos */
DO:
    {&OPEN-QUERY-br-contatos}
    APPLY "VALUE-CHANGED" TO br-contatos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME l-tarefas-encerradas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL l-tarefas-encerradas C-Win
ON VALUE-CHANGED OF l-tarefas-encerradas IN FRAME DEFAULT-FRAME /* Mostrar Encerradas */
DO:
    {&OPEN-QUERY-br-tarefas}
    APPLY "VALUE-CHANGED" TO br-tarefas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ped-ant
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ped-ant C-Win
ON VALUE-CHANGED OF ped-ant IN FRAME DEFAULT-FRAME /* Mostrar Antecipaá‰es */
DO:
    {&OPEN-QUERY-br-pedidos}
    APPLY "VALUE-CHANGED" TO br-pedidos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pend C-Win
ON VALUE-CHANGED OF pend IN FRAME DEFAULT-FRAME /* Somente Ativos */
DO:
    {&OPEN-QUERY-br-pedidos}
    APPLY "VALUE-CHANGED" TO br-pedidos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-apont
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
ASSIGN C-Win:MAX-WIDTH = ?
       C-Win:MAX-HEIGHT = ?.
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = c-ds-favorecido
                          &FOREACH = "favorecido WHERE favorecido.tipo <> 2 BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = i-cd-favorecido}

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
    {version.i crm}
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
  DISPLAY pot potl ped-ant pend obs-apont obs-cont i-cd-favorecido 
          c-ds-favorecido cCidade cEstado obs-tarefa l-tarefas-encerradas 
          l-contatos-ativos 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-apont br-itens br-tarefas bt-data btNext potl ped-ant pend btProp 
         bt-minhas-tarefas btCli bt-anexos obs-cont bt-caracteristica 
         bt-eliminar-atend bt-eliminar-contato bt-incluir-atend 
         bt-incluir-contato bt-modificar-atend bt-modificar-contato btExit 
         i-cd-favorecido c-ds-favorecido bt-eliminar-apont br-pedidos 
         br-atendimentos bt-incluir-apont bt-modificar-apont br-contatos 
         obs-tarefa bt-eliminar-tarefa bt-incluir-tarefa bt-modificar-tarefa 
         l-tarefas-encerradas l-contatos-ativos RECT-8 IMAGE-1 
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

ASSIGN image-1:HIDDEN IN FRAME {&FRAME-NAME} = YES.

{func\cursor.i i-cd-favorecido}

ASSIGN C-Win:WINDOW-STATE = WINDOW-MAXIMIZED.
APPLY "WINDOW-RESIZED" TO C-Win.

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

IF cObject = "c-ds-favorecido" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} c-ds-favorecido NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN i-cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
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

    IF cTable = "contato" THEN DO:
        IF CAN-FIND(FIRST atendimento OF contato) THEN DO:
            {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                           &Ajuda     = "Esse contato j† possui atendimento associado."}
        END.
    END.

    IF cTable = "tarefa" THEN DO:
        IF CAN-FIND(FIRST atendimento OF tarefa) THEN DO:
            {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                           &Ajuda     = "J† existe atendimento relacionado a essa tarefa."}
        END.    
        IF CAN-FIND(FIRST apontamento
                    WHERE apontamento.nome-tarefa = tarefa.nome
                    AND   apontamento.seq-tarefa = tarefa.sequencia) THEN DO:
            {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                           &Ajuda     = "J† existe apontamento relacionado a essa tarefa."}
        END.    
    END.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnSituacaoPedido C-Win 
FUNCTION fnSituacaoPedido RETURNS CHARACTER
  ( INPUT i-sit AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
CASE i-sit:
    WHEN 1 THEN RETURN "Pendente".
    WHEN 2 THEN RETURN "Iniciado".
    WHEN 3 THEN RETURN "Atendido".
    WHEN 4 THEN RETURN "Faturado".
    WHEN 9 THEN RETURN "Cancelado".
END CASE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

