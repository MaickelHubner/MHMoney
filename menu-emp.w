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

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE deValor AS DECIMAL COLUMN-LABEL "Valor" FORMAT "->>>,>>>,>>9.99" NO-UNDO.

DEFINE BUFFER bfConta FOR conta.

{seg.i "new global"}

DEFINE NEW GLOBAL SHARED VARIABLE hProgsMenu AS HANDLE     NO-UNDO EXTENT 200.
DEFINE NEW GLOBAL SHARED VARIABLE iProgsCont AS INTEGER    NO-UNDO INITIAL 1.
DEFINE NEW GLOBAL SHARED VARIABLE r-conta AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE cParamRelat AS CHAR NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-pedido AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.

ASSIGN iProgsCont = 0.

{winalert.i}

{func\tt_graf.i}

{func\data.i}

DEFINE VARIABLE chGrafico AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chTitulo AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chConstantes AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chDesenho AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia1 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia2 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia3 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chPlanilha AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chLabels AS COM-HANDLE  NO-UNDO.

DEFINE BUFFER bf-conta FOR conta.

{cotacao.i}

DEFINE VARIABLE hProg AS HANDLE     NO-UNDO.

{func\maxim\var.i}

DEFINE VARIABLE cPerc AS CHARACTER COLUMN-LABEL "Variaá∆o" FORMAT "X(15)"  NO-UNDO.
DEFINE VARIABLE cUltCot AS CHARACTER COLUMN-LABEL "Èltima Cotaá∆o" FORMAT "X(15)"  NO-UNDO.

DEFINE VARIABLE deValTotal AS DEC COLUMN-LABEL "Val Total" NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fPag01
&Scoped-define BROWSE-NAME brAlerta

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-alerta moeda cotacao tt-graf pedido ~
favorecido conta

/* Definitions for BROWSE brAlerta                                      */
&Scoped-define FIELDS-IN-QUERY-brAlerta tt-alerta.alerta   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAlerta   
&Scoped-define SELF-NAME brAlerta
&Scoped-define QUERY-STRING-brAlerta FOR EACH tt-alerta
&Scoped-define OPEN-QUERY-brAlerta OPEN QUERY {&SELF-NAME} FOR EACH tt-alerta.
&Scoped-define TABLES-IN-QUERY-brAlerta tt-alerta
&Scoped-define FIRST-TABLE-IN-QUERY-brAlerta tt-alerta


/* Definitions for BROWSE brCotacao                                     */
&Scoped-define FIELDS-IN-QUERY-brCotacao moeda.sigla moeda.ds-moeda ~
cotacao.valor fnPerc(cotacao.cd-moeda) @ cPerc ~
fnUltCot(cotacao.cd-moeda) @ cUltCot 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brCotacao 
&Scoped-define QUERY-STRING-brCotacao FOR EACH moeda NO-LOCK, ~
      EACH cotacao OF moeda ~
      WHERE cotacao.dt-ini <= TODAY ~
 AND cotacao.dt-end >= TODAY NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brCotacao OPEN QUERY brCotacao FOR EACH moeda NO-LOCK, ~
      EACH cotacao OF moeda ~
      WHERE cotacao.dt-ini <= TODAY ~
 AND cotacao.dt-end >= TODAY NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brCotacao moeda cotacao
&Scoped-define FIRST-TABLE-IN-QUERY-brCotacao moeda
&Scoped-define SECOND-TABLE-IN-QUERY-brCotacao cotacao


/* Definitions for BROWSE brDados                                       */
&Scoped-define FIELDS-IN-QUERY-brDados tt-graf.dado tt-graf.valor[1]   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brDados   
&Scoped-define SELF-NAME brDados
&Scoped-define QUERY-STRING-brDados FOR EACH tt-graf BY tt-graf.seq
&Scoped-define OPEN-QUERY-brDados OPEN QUERY {&SELF-NAME} FOR EACH tt-graf BY tt-graf.seq.
&Scoped-define TABLES-IN-QUERY-brDados tt-graf
&Scoped-define FIRST-TABLE-IN-QUERY-brDados tt-graf


/* Definitions for BROWSE brFat                                         */
&Scoped-define FIELDS-IN-QUERY-brFat pedido.nr-pedido ~
pedido.dt-previsao-fat favorecido.ds-favorecido pedido.num-cliente ~
pedido.nom-projeto fnVal-total(pedido.val-total) @ deValTotal 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brFat 
&Scoped-define QUERY-STRING-brFat FOR EACH pedido ~
      WHERE pedido.situacao = 3 NO-LOCK, ~
      EACH favorecido OF pedido NO-LOCK ~
    BY pedido.dt-previsao-fat INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brFat OPEN QUERY brFat FOR EACH pedido ~
      WHERE pedido.situacao = 3 NO-LOCK, ~
      EACH favorecido OF pedido NO-LOCK ~
    BY pedido.dt-previsao-fat INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brFat pedido favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-brFat pedido
&Scoped-define SECOND-TABLE-IN-QUERY-brFat favorecido


/* Definitions for BROWSE brPedidos                                     */
&Scoped-define FIELDS-IN-QUERY-brPedidos pedido.nr-pedido pedido.dt-pedido ~
favorecido.ds-favorecido pedido.num-cliente pedido.nom-projeto ~
pedido.val-total fnVal-total(pedido.val-total) @ deValTotal 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPedidos 
&Scoped-define QUERY-STRING-brPedidos FOR EACH pedido ~
      WHERE pedido.situacao <> 3 /* Atendido */ ~
 AND pedido.situacao <> 4 /* Faturado */ ~
 AND pedido.situacao <> 9 /* Cancelado */ NO-LOCK, ~
      EACH favorecido OF pedido NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brPedidos OPEN QUERY brPedidos FOR EACH pedido ~
      WHERE pedido.situacao <> 3 /* Atendido */ ~
 AND pedido.situacao <> 4 /* Faturado */ ~
 AND pedido.situacao <> 9 /* Cancelado */ NO-LOCK, ~
      EACH favorecido OF pedido NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brPedidos pedido favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-brPedidos pedido
&Scoped-define SECOND-TABLE-IN-QUERY-brPedidos favorecido


/* Definitions for BROWSE brSaldo                                       */
&Scoped-define FIELDS-IN-QUERY-brSaldo conta.cd-conta conta.ds-conta ~
conta.dt-saldo moeda.sigla conta.vl-saldo fnValor(conta.cd-conta) @ deValor 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brSaldo 
&Scoped-define QUERY-STRING-brSaldo FOR EACH conta ~
      WHERE conta.id-encerrada = FALSE NO-LOCK, ~
      EACH moeda OF conta NO-LOCK ~
    BY conta.cd-conta
&Scoped-define OPEN-QUERY-brSaldo OPEN QUERY brSaldo FOR EACH conta ~
      WHERE conta.id-encerrada = FALSE NO-LOCK, ~
      EACH moeda OF conta NO-LOCK ~
    BY conta.cd-conta.
&Scoped-define TABLES-IN-QUERY-brSaldo conta moeda
&Scoped-define FIRST-TABLE-IN-QUERY-brSaldo conta
&Scoped-define SECOND-TABLE-IN-QUERY-brSaldo moeda


/* Definitions for FRAME fPag01                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPag01 ~
    ~{&OPEN-QUERY-brAlerta}~
    ~{&OPEN-QUERY-brCotacao}~
    ~{&OPEN-QUERY-brDados}~
    ~{&OPEN-QUERY-brFat}~
    ~{&OPEN-QUERY-brPedidos}~
    ~{&OPEN-QUERY-brSaldo}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-1 brFat brPedidos brDados brAlerta ~
brSaldo descr brCotacao 
&Scoped-Define DISPLAYED-OBJECTS descr 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnGravaDado C-Win 
FUNCTION fnGravaDado RETURNS CHARACTER
  ( i-linha as int, i-coluna as int, c-valor as char, c-formato as CHAR ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnPerc C-Win 
FUNCTION fnPerc RETURNS CHARACTER
  ( iMoeda AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnUltCot C-Win 
FUNCTION fnUltCot RETURNS CHARACTER
  ( iMoeda AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnVal-Total C-Win 
FUNCTION fnVal-Total RETURNS DECIMAL
  ( INPUT deValTotal AS DECIMAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnValor C-Win 
FUNCTION fnValor RETURNS DECIMAL
  ( iConta AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Admin 
       MENU-ITEM m_PROPATH      LABEL "PROPATH"       
       RULE
       MENU-ITEM m_Editor_do_PROGRESS LABEL "Editor do PROGRESS"
       MENU-ITEM m_APP_Builder  LABEL "APP Builder"   
       RULE
       MENU-ITEM m_Data_Administrator LABEL "Data Administrator"
       MENU-ITEM m_Data_Dictionary LABEL "Data Dictionary"
       MENU-ITEM m_Aplication_Compiler LABEL "Aplication Compiler"
       RULE
       MENU-ITEM m_F11          LABEL "F11"           .

DEFINE SUB-MENU m_Usurio 
       MENU-ITEM m_Login        LABEL "Log&in"        
       MENU-ITEM m_Logout       LABEL "Log&out"       
       RULE
       MENU-ITEM m_Restries     LABEL "Restriá‰es do Usu†rio"
       MENU-ITEM m_Alertas      LABEL "Alertas do Usu†rio"
       RULE
       SUB-MENU  m_Admin        LABEL "Administrador" 
       RULE
       MENU-ITEM m_Apontamentos LABEL "Apontamentos"  
       MENU-ITEM m_Gerar_Folha_de_Apontamentos LABEL "Gerar Folha de Apontamentos"
       RULE
       MENU-ITEM m_Tarefas_do_Usurio LABEL "Tarefas"       
       MENU-ITEM m_Compromissos LABEL "Compromissos"  
       RULE
       MENU-ITEM m_Sair         LABEL "Sair"          .

DEFINE SUB-MENU m_Cadastros 
       MENU-ITEM m_Parmetros_Locais LABEL "ParÉmetros Locais"
       MENU-ITEM m_Usurios      LABEL "Usu†rios"      
       RULE
       MENU-ITEM m_Moedas       LABEL "Moedas"        
       MENU-ITEM m_Feriados     LABEL "Feriados"      
       RULE
       MENU-ITEM m_Favorecidos  LABEL "Clientes ~\ Fornecedores"
       MENU-ITEM m_Item         LABEL "Itens"         
       RULE
       MENU-ITEM m_Impostos     LABEL "Impostos"      
       MENU-ITEM m_Formas_de_Pagamento LABEL "Formas de Pagamento".

DEFINE SUB-MENU m_Formao_de_Preo 
       MENU-ITEM m_Tabela_de_Preo LABEL "Tabela de Preáo"
       MENU-ITEM m_Itens_da_Tabela_de_Preo LABEL "Itens da Tabela de Preáo".

DEFINE SUB-MENU m_Pedidos 
       MENU-ITEM m_Manuteno_de_Pedidos LABEL "Manutená∆o de Pedidos"
       MENU-ITEM m_Itens_do_Pedido LABEL "Itens do Pedido"
       RULE
       MENU-ITEM m_Faturamento_de_Pedidos LABEL "Faturamento de Pedidos".

DEFINE SUB-MENU m_Notas_Fiscais 
       MENU-ITEM m_Manuteno_de_Notas_Fiscais LABEL "Manutená∆o de Notas Fiscais"
       RULE
       MENU-ITEM m_Itens_da_Nota_Fiscal LABEL "Itens da Nota Fiscal"
       MENU-ITEM m_Pagamentos   LABEL "Parcelas da Nota Fiscal"
       MENU-ITEM m_Pedidos_da_Nota_Fiscal LABEL "Pedidos da Nota Fiscal".

DEFINE SUB-MENU m_Vendas 
       SUB-MENU  m_Formao_de_Preo LABEL "Formaá∆o de Preáo"
       RULE
       SUB-MENU  m_Pedidos      LABEL "Pedidos"       
       SUB-MENU  m_Notas_Fiscais LABEL "Notas Fiscais" 
       RULE
       MENU-ITEM m_Faturamento_de_Balco LABEL "Faturamento de Balc∆o".

DEFINE SUB-MENU m_Financeiro 
       MENU-ITEM m_Contas       LABEL "Contas"        
       MENU-ITEM m_Movimentos_da_Conta_Selecio LABEL "Movimentos da Conta"
       RULE
       MENU-ITEM m_Categorias   LABEL "Categorias"    
       MENU-ITEM m_Sub-Categorias LABEL "Sub-Categorias"
       RULE
       MENU-ITEM m_Agendamentos2 LABEL "Agendamentos"  
       MENU-ITEM m_Valores_de_Agendamentos LABEL "Valores de Agendamentos"
       RULE
       MENU-ITEM m_Metas        LABEL "Metas"         
       RULE
       MENU-ITEM m_Cotao_de_Moedas LABEL "Cotaá∆o de Moedas"
       MENU-ITEM m_Controle_de_Reembolsos LABEL "Controle de Reembolsos"
       MENU-ITEM m_Consulta_de_Custos LABEL "Consulta de Custos"
       RULE
       MENU-ITEM m_Agendamentos LABEL "Pr¢ximos Movimentos Agendados".

DEFINE SUB-MENU m_Patrimnio 
       MENU-ITEM m_Bens         LABEL "Bens"          
       MENU-ITEM m_Movimentos_do_Bem LABEL "Movimentos do Bem".

DEFINE SUB-MENU m_Oramento3 
       MENU-ITEM m_Oramento     LABEL "Manutená∆o de Oráamentos"
       RULE
       MENU-ITEM m_Previsto_X_Realizado LABEL "Previsto X Realizado"
       MENU-ITEM m_R033         LABEL "Relat¢rio de Acompanhamento".

DEFINE SUB-MENU m_Poupana3 
       MENU-ITEM m_Poupana      LABEL "Manutená∆o de Poupanáas"
       MENU-ITEM m_Poupana_Ano_a_An LABEL "Plan. Anual de Poupanáa"
       RULE
       MENU-ITEM m_R032         LABEL "Previsto X Realizado"
       MENU-ITEM m_R034         LABEL "Taxa de Retorno"
       MENU-ITEM m_R035         LABEL "Percentual de Formaá∆o de Juros"
       RULE
       MENU-ITEM m_R036         LABEL "Projeá∆o em Poupanáa".

DEFINE SUB-MENU m_Planejamento 
       SUB-MENU  m_Oramento3    LABEL "Oráamento"     
       SUB-MENU  m_Poupana3     LABEL "Poupanáa"      
       MENU-ITEM m_Projeto      LABEL "Projetos"      .

DEFINE SUB-MENU m_Estoque 
       MENU-ITEM m_Itens_em_Estoque LABEL "Itens em Estoque"
       RULE
       MENU-ITEM m_Inventrio_de_Itens LABEL "Invent†rio de Itens".

DEFINE SUB-MENU m_Compras 
       MENU-ITEM m_Compra       LABEL "Cadastro de Compras"
       MENU-ITEM m_Itens_da_Compra LABEL "Itens da Compra"
       RULE
       MENU-ITEM m_Histrico_do_Item LABEL "Hist¢rico do Item"
       RULE
       SUB-MENU  m_Estoque      LABEL "Estoque"       .

DEFINE SUB-MENU m_CRM 
       MENU-ITEM m_Cockpit      LABEL "Cockpit"       
       RULE
       MENU-ITEM m_Clientes     LABEL "Clientes"      
       MENU-ITEM m_Caractersticas LABEL "Caracter°sticas"
       RULE
       MENU-ITEM m_Caractersticas_do_Contato LABEL "Caracter°sticas do Contato"
       RULE
       MENU-ITEM m_Visitas_Comerciais LABEL "Visitas Comerciais"
       MENU-ITEM m_E-mail_Marketing LABEL "E-mail Marketing"
       RULE
       MENU-ITEM m_Potencial_de_Vendas LABEL "Potencial de Vendas".

DEFINE SUB-MENU m_Servios 
       MENU-ITEM m_Ordem_de_Servio LABEL "Ordem de Serviáo"
       MENU-ITEM m_Tarefas_da_OS LABEL "Tarefas da OS" 
       RULE
       MENU-ITEM m_Painel_de_Servios LABEL "Painel de Serviáos".

DEFINE SUB-MENU m_Mensais 
       MENU-ITEM m_R001         LABEL "Balanáo Mensal"
       MENU-ITEM m_R006         LABEL "Custos X Despesas"
       MENU-ITEM m_R007         LABEL "Rendimentos X Despesas"
       RULE
       MENU-ITEM m_R002         LABEL "Fluxo de Caixa"
       MENU-ITEM m_R003         LABEL "Extrato Mensal"
       RULE
       MENU-ITEM m_R009         LABEL "Relat¢rio Mensal"
       MENU-ITEM m_R028         LABEL "Comparativo Mensal"
       RULE
       MENU-ITEM m_Valor_de_Bens LABEL "Valor de Bens" .

DEFINE SUB-MENU m_Anuais 
       MENU-ITEM m_R008         LABEL "Patrimìnio Financeiro Màs a Màs"
       MENU-ITEM m_R030         LABEL "Evoluá∆o Patrimonial"
       RULE
       MENU-ITEM m_R010         LABEL "Rendimento X Despesas Màs a Màs"
       MENU-ITEM m_R027         LABEL "Custos Màs a Màs"
       MENU-ITEM m_R021         LABEL "Èltimas Faturas Pagas"
       RULE
       MENU-ITEM m_R024         LABEL "Balanáo Anual" 
       RULE
       MENU-ITEM m_R025         LABEL "Balanáa Comercial Anual"
       MENU-ITEM m_R026         LABEL "Acompanhamento de Balanáa Comercial"
       RULE
       MENU-ITEM m_R039         LABEL "Lucratividade de Investimento"
       MENU-ITEM m_Lucratividade_de_Aes LABEL "Lucratividade de Aá‰es"
       MENU-ITEM m_R029         LABEL "Juros de Poupanáa"
       RULE
       MENU-ITEM m_r014         LABEL "Inflaá∆o de Item no Per°odo"
       MENU-ITEM m_Inflao_no_Perodo LABEL "Inflaá∆o no Per°odo"
       RULE
       MENU-ITEM m_R011         LABEL "Relat¢rio Anual"
       RULE
       MENU-ITEM m_R037         LABEL "Dados para Imposto de Renda".

DEFINE SUB-MENU m_Geral 
       MENU-ITEM m_R005         LABEL "Previs∆o de Saldo"
       MENU-ITEM m_R004         LABEL "Patrimìnio Financeiro Di†rio"
       RULE
       MENU-ITEM m_R018         LABEL "Principais Categorias"
       MENU-ITEM m_R019         LABEL "Principais Sub-Categorias"
       MENU-ITEM m_R020         LABEL "Maiores Favorecidos"
       RULE
       MENU-ITEM m_R031         LABEL "Resumo de Movimentaá∆o"
       MENU-ITEM m_Movimentao_por_Responsvel LABEL "Movimentaá∆o por Respons†vel"
       MENU-ITEM m_Movimentao_por_Favorecido LABEL "Movimentaá∆o por Favorecido"
       RULE
       MENU-ITEM m_Despesas_da_Categoria_por_R LABEL "Despesas da Categoria por Respons†vel"
       RULE
       MENU-ITEM m_Lista_de_Compras LABEL "Lista de Compras"
       RULE
       MENU-ITEM m_Simulao_de_Oramento LABEL "Simulaá∆o de Oráamento".

DEFINE SUB-MENU m_Emp 
       MENU-ITEM m_ValorHora_por_Pedido LABEL "Valor/Hora por Pedido"
       MENU-ITEM m_Clientes_por_CidadoEstado LABEL "Clientes por Cidado/Estado".

DEFINE SUB-MENU m_Relatrios 
       SUB-MENU  m_Mensais      LABEL "Mensal"        
       SUB-MENU  m_Anuais       LABEL "Anual"         
       SUB-MENU  m_Geral        LABEL "Geral"         
       SUB-MENU  m_Emp          LABEL "Empresarial"   .

DEFINE SUB-MENU m_Mensal 
       MENU-ITEM m_Evoluo_de_Saldo LABEL "Evoluá∆o de Saldo".

DEFINE SUB-MENU m_Anual 
       MENU-ITEM m_Patrimnio_Financeiro_Ms_a_M LABEL "Patrimìnio Financeiro Màs a Màs"
       MENU-ITEM m_Rendimentos_X_Despesas_Ms_a LABEL "Rendimento X Despesas Màs a Màs"
       MENU-ITEM m_Custos_Ms_a_Ms LABEL "Custos Màs a Màs"
       RULE
       MENU-ITEM m_Evoluo_Patrimnial LABEL "Evoluá∆o Patrimìnial".

DEFINE SUB-MENU m_Geral2 
       MENU-ITEM m_Previso_de_Saldo LABEL "Previs∆o de Saldo"
       MENU-ITEM m_Patrimnio_Financeiro LABEL "Patrimìnio Financeiro Di†rio"
       RULE
       MENU-ITEM m_Principais_Categorias LABEL "Principais Categorias"
       MENU-ITEM m_Principais_Sub-Categorias LABEL "Principais Sub-Categorias"
       MENU-ITEM m_Maiores_Favorecidos2 LABEL "Maiores Favorecidos"
       RULE
       MENU-ITEM m_Movimentao_da_Categoria LABEL "Movimentaá∆o da Categoria~\Sub-Categoria".

DEFINE SUB-MENU m_Grficos 
       SUB-MENU  m_Mensal       LABEL "Mensal"        
       SUB-MENU  m_Anual        LABEL "Anual"         
       SUB-MENU  m_Geral2       LABEL "Geral"         .

DEFINE SUB-MENU m_Dados 
       MENU-ITEM m_Backup_de_Dados LABEL "Backup do Sistema"
       MENU-ITEM m_Importao_de_Arquivos LABEL "Importaá∆o de Arquivos"
       MENU-ITEM m_Sincronizao_de_Dados LABEL "Sincronizaá∆o de Dados".

DEFINE SUB-MENU m_Ferramentas 
       SUB-MENU  m_Dados        LABEL "Dados"         
       RULE
       MENU-ITEM m_Calculadora  LABEL "Calculadora"   
       MENU-ITEM m_Calendrio    LABEL "Calend†rio"    
       RULE
       MENU-ITEM m_Monitor_de_Pedidos_de_Execu LABEL "Monitor de Pedidos de Execuá∆o".

DEFINE SUB-MENU m_Ajuda 
       MENU-ITEM m_Manual       LABEL "Conte£do"      
       RULE
       MENU-ITEM m_Atualizao_Automtica_MHMoney LABEL "Atualizaá∆o Autom†tica MHMoney 2005"
       MENU-ITEM m_Registro_do_Produto LABEL "Registro do Produto"
       RULE
       MENU-ITEM m_Sobre        LABEL "Sobre o MH Money 2005...".

DEFINE MENU MENU-BAR-C-Win MENUBAR
       SUB-MENU  m_Usurio       LABEL "&Usu†rio"      
       SUB-MENU  m_Cadastros    LABEL "&Cadastros"    
       SUB-MENU  m_Vendas       LABEL "&Vendas"       
       SUB-MENU  m_Financeiro   LABEL "&Financeiro"   
       SUB-MENU  m_Patrimnio    LABEL "&Patrimìnio"   
       SUB-MENU  m_Planejamento LABEL "&Planejamento" 
       SUB-MENU  m_Compras      LABEL "&Compras"      
       SUB-MENU  m_CRM          LABEL "CR&M"          
       SUB-MENU  m_Servios      LABEL "&Serviáos"     
       SUB-MENU  m_Relatrios    LABEL "&Relat¢rios"   
       SUB-MENU  m_Grficos      LABEL "&Gr†ficos"     
       SUB-MENU  m_Ferramentas  LABEL "&Utilit†rios"  
       SUB-MENU  m_Ajuda        LABEL "A&juda"        .


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE CtrlFrame-2 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-2 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btExec 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar...".

DEFINE VARIABLE descr AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 58 BY 2.75 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/mhmoney.bmp":U
     SIZE 18 BY 1.75.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAlerta FOR 
      tt-alerta SCROLLING.

DEFINE QUERY brCotacao FOR 
      moeda, 
      cotacao SCROLLING.

DEFINE QUERY brDados FOR 
      tt-graf SCROLLING.

DEFINE QUERY brFat FOR 
      pedido, 
      favorecido SCROLLING.

DEFINE QUERY brPedidos FOR 
      pedido, 
      favorecido SCROLLING.

DEFINE QUERY brSaldo FOR 
      conta, 
      moeda SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAlerta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAlerta C-Win _FREEFORM
  QUERY brAlerta DISPLAY
      tt-alerta.alerta FORMAT "X(100)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ROW-MARKERS SIZE 58 BY 4.79
         FONT 1
         TITLE "Alertas do Dia" FIT-LAST-COLUMN.

DEFINE BROWSE brCotacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brCotacao C-Win _STRUCTURED
  QUERY brCotacao NO-LOCK DISPLAY
      moeda.sigla FORMAT "X(3)":U WIDTH 4
      moeda.ds-moeda FORMAT "X(40)":U WIDTH 27
      cotacao.valor FORMAT "->>,>>9.999999":U
      fnPerc(cotacao.cd-moeda) @ cPerc
      fnUltCot(cotacao.cd-moeda) @ cUltCot
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS SIZE 44 BY 3.75
         FONT 1
         TITLE "Cotaá∆o de Moedas" FIT-LAST-COLUMN.

DEFINE BROWSE brDados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brDados C-Win _FREEFORM
  QUERY brDados DISPLAY
      tt-graf.dado FORMAT "X(256)" LABEL ""
      tt-graf.valor[1] FORMAT "->>>>,>>9.99" LABEL ""
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 44 BY 4.25
         FONT 1
         TITLE "Gr†fico do Dia".

DEFINE BROWSE brFat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brFat C-Win _STRUCTURED
  QUERY brFat NO-LOCK DISPLAY
      pedido.nr-pedido FORMAT ">>>>,>>9":U
      pedido.dt-previsao-fat FORMAT "99/99/9999":U
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 15
      pedido.num-cliente FORMAT "x(12)":U
      pedido.nom-projeto FORMAT "x(80)":U WIDTH 35
      fnVal-total(pedido.val-total) @ deValTotal COLUMN-LABEL "Saldo"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 58 BY 7.25
         FONT 1
         TITLE "Pedidos a Faturar" FIT-LAST-COLUMN.

DEFINE BROWSE brPedidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPedidos C-Win _STRUCTURED
  QUERY brPedidos NO-LOCK DISPLAY
      pedido.nr-pedido FORMAT ">>>>,>>9":U
      pedido.dt-pedido FORMAT "99/99/9999":U
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 15
      pedido.num-cliente FORMAT "x(12)":U
      pedido.nom-projeto FORMAT "x(80)":U WIDTH 35
      pedido.val-total FORMAT "->>,>>9.99":U
      fnVal-total(pedido.val-total) @ deValTotal COLUMN-LABEL "Saldo"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 58 BY 6.75
         FONT 1
         TITLE "Pedidos Pendentes" FIT-LAST-COLUMN.

DEFINE BROWSE brSaldo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brSaldo C-Win _STRUCTURED
  QUERY brSaldo NO-LOCK DISPLAY
      conta.cd-conta FORMAT "999":U
      conta.ds-conta FORMAT "X(30)":U
      conta.dt-saldo FORMAT "99/99/9999":U
      moeda.sigla FORMAT "X(3)":U WIDTH 4
      conta.vl-saldo FORMAT "->>,>>9.99":U
      fnValor(conta.cd-conta) @ deValor
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ROW-MARKERS SIZE 44 BY 5
         FONT 1
         TITLE "Saldo das Contas" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fPag01
     btExec AT ROW 23.75 COL 48
     brFat AT ROW 1.5 COL 47 WIDGET-ID 200
     brPedidos AT ROW 9 COL 47 WIDGET-ID 100
     brDados AT ROW 12 COL 2
     brAlerta AT ROW 16 COL 47
     brSaldo AT ROW 16.5 COL 2
     descr AT ROW 21 COL 47 NO-LABEL
     brCotacao AT ROW 21.75 COL 2
     IMAGE-1 AT ROW 24 COL 87.72
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.29 BY 24.75
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
         TITLE              = "MH Money 2005"
         HEIGHT             = 24.75
         WIDTH              = 105.29
         MAX-HEIGHT         = 39.75
         MAX-WIDTH          = 182.86
         VIRTUAL-HEIGHT     = 39.75
         VIRTUAL-WIDTH      = 182.86
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

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-C-Win:HANDLE.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("image/mhmoney.ico":U) THEN
    MESSAGE "Unable to load icon: image/mhmoney.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME fPag01
   FRAME-NAME                                                           */
/* BROWSE-TAB brFat IMAGE-1 fPag01 */
/* BROWSE-TAB brPedidos brFat fPag01 */
/* BROWSE-TAB brDados brPedidos fPag01 */
/* BROWSE-TAB brAlerta brDados fPag01 */
/* BROWSE-TAB brSaldo brAlerta fPag01 */
/* BROWSE-TAB brCotacao descr fPag01 */
ASSIGN 
       brCotacao:NUM-LOCKED-COLUMNS IN FRAME fPag01     = 1.

/* SETTINGS FOR BUTTON btExec IN FRAME fPag01
   NO-ENABLE                                                            */
ASSIGN 
       descr:READ-ONLY IN FRAME fPag01        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAlerta
/* Query rebuild information for BROWSE brAlerta
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-alerta.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brAlerta */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brCotacao
/* Query rebuild information for BROWSE brCotacao
     _TblList          = "money.moeda,money.cotacao OF money.moeda"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[2]         = "cotacao.dt-ini <= TODAY
 AND cotacao.dt-end >= TODAY"
     _FldNameList[1]   > money.moeda.sigla
"moeda.sigla" ? ? "character" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > money.moeda.ds-moeda
"moeda.ds-moeda" ? ? "character" ? ? ? ? ? ? no ? no no "27" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.cotacao.valor
     _FldNameList[4]   > "_<CALC>"
"fnPerc(cotacao.cd-moeda) @ cPerc" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"fnUltCot(cotacao.cd-moeda) @ cUltCot" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brCotacao */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brDados
/* Query rebuild information for BROWSE brDados
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-graf BY tt-graf.seq.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brDados */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brFat
/* Query rebuild information for BROWSE brFat
     _TblList          = "money.pedido,money.favorecido OF money.pedido"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.pedido.dt-previsao-fat|yes"
     _Where[1]         = "pedido.situacao = 3"
     _FldNameList[1]   = money.pedido.nr-pedido
     _FldNameList[2]   = money.pedido.dt-previsao-fat
     _FldNameList[3]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente" ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = money.pedido.num-cliente
     _FldNameList[5]   > money.pedido.nom-projeto
"pedido.nom-projeto" ? ? "character" ? ? ? ? ? ? no ? no no "35" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"fnVal-total(pedido.val-total) @ deValTotal" "Saldo" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brFat */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPedidos
/* Query rebuild information for BROWSE brPedidos
     _TblList          = "money.pedido,money.favorecido OF money.pedido"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "pedido.situacao <> 3 /* Atendido */
 AND pedido.situacao <> 4 /* Faturado */
 AND pedido.situacao <> 9 /* Cancelado */"
     _FldNameList[1]   = money.pedido.nr-pedido
     _FldNameList[2]   = money.pedido.dt-pedido
     _FldNameList[3]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente" ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = money.pedido.num-cliente
     _FldNameList[5]   > money.pedido.nom-projeto
"pedido.nom-projeto" ? ? "character" ? ? ? ? ? ? no ? no no "35" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = money.pedido.val-total
     _FldNameList[7]   > "_<CALC>"
"fnVal-total(pedido.val-total) @ deValTotal" "Saldo" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brPedidos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brSaldo
/* Query rebuild information for BROWSE brSaldo
     _TblList          = "money.conta,money.moeda OF money.conta"
     _Options          = "NO-LOCK"
     _OrdList          = "money.conta.cd-conta|yes"
     _Where[1]         = "conta.id-encerrada = FALSE"
     _FldNameList[1]   = money.conta.cd-conta
     _FldNameList[2]   = money.conta.ds-conta
     _FldNameList[3]   = money.conta.dt-saldo
     _FldNameList[4]   > money.moeda.sigla
"moeda.sigla" ? ? "character" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = money.conta.vl-saldo
     _FldNameList[6]   > "_<CALC>"
"fnValor(conta.cd-conta) @ deValor" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brSaldo */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fPag01:HANDLE
       ROW             = 1.5
       COLUMN          = 2
       HEIGHT          = 10.17
       WIDTH           = 43.72
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME fPag01:HANDLE
       ROW             = 24.5
       COLUMN          = 67
       HEIGHT          = .75
       WIDTH           = 15
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0002E500-0000-0000-C000-000000000046} type: ChartSpace */
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {0002E510-0000-0000-C000-000000000046} type: Spreadsheet */
      CtrlFrame-2:MOVE-AFTER(brCotacao:HANDLE IN FRAME fPag01).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* MH Money 2005 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* MH Money 2005 */
DO:
  /* This event will close the window and terminate the procedure.  */

  {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Sair (040)', INPUT 'Deseja realmente fechar o MHMoney 2005 ?', INPUT 'Se vocà clicou nesse bot∆o por engano Ç s¢ responder N∆o. Em caso afirmativo o programa ser† fechado.')"}
  IF RETURN-VALUE <> "OK" THEN RETURN.


  DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

  ASSIGN gcUsuario = "".
  REPEAT iCont = 1 TO iProgsCont:
      IF VALID-HANDLE(hProgsMenu[iCont]) THEN DO:
          DELETE WIDGET hProgsMenu[iCont].
      END.
  END.

  IF CAN-FIND(FIRST lote-mov WHERE lote-mov.numero = 0) THEN DO:
      {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Envio de Movimentos (040)', INPUT 'Confirma exportaá∆o ?', INPUT 'Existem movimentos que n∆o foram exportados. Deseja exportar e enviar esses movimentos por e-mail ?')"}
      IF RETURN-VALUE = "OK" THEN DO:
          RUN exportalote.p.
      END.
  END.

  RUN som.p(INPUT "#music\logoff.wav").

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  QUIT.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-MINIMIZED OF C-Win /* MH Money 2005 */
DO:
  
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE hAux AS HANDLE     NO-UNDO EXTENT 200.
    DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.

    REPEAT iCont = 1 TO iProgsCont:

        IF VALID-HANDLE(hProgsMenu[iCont]) THEN
            ASSIGN hProgsMenu[iCont]:HIDDEN = YES.

    END.

    ASSIGN iAux = 0.
    REPEAT iCont = 1 TO iProgsCont:
        IF VALID-HANDLE(hProgsMenu[iCont]) THEN DO:
            ASSIGN iAux = iAux + 1
                   hAux[iAux] = hProgsMenu[iCont].
        END.
    END.

    REPEAT iCont = 1 TO iAux:
        ASSIGN hProgsMenu[iCont] = hAux[iCont].
    END.
    ASSIGN iProgsCont = iAux.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESIZED OF C-Win /* MH Money 2005 */
DO:

    {func\maxim\objeto.i &Objeto=CtrlFrame
                         &LayoutH="Esquerda"
                         &LayoutV="Topo"}
                         
    {func\maxim\objeto.i &Objeto=brDados
                         &Frame=fPag01
                         &LayoutH="Esquerda"
                         &LayoutV="Abaixo de"
                         &ObjSup=CtrlFrame
                         &FrameSup=NO}

    {func\maxim\objeto.i &Objeto=brSaldo
                         &Frame=fPag01
                         &LayoutH="Esquerda"
                         &LayoutV="Abaixo de"
                         &ObjSup=brDados
                         &MudaAltura="N∆o"}

    {func\maxim\objeto.i &Objeto=brCotacao
                         &Frame=fPag01
                         &LayoutH="Esquerda"
                         &LayoutV="Baixo"
                         &MudaAltura="N∆o"}

    {func\maxim\objeto.i &Objeto=CtrlFrame-2
                         &LayoutH="Esquerda"
                         &MudaTamanho="N∆o"
                         &Visivel="N∆o"}

    {func\maxim\objeto.i &Objeto=brFat
                         &Frame=fPag01
                         &LayoutH="Direita"
                         &LayoutV="Topo"}

    {func\maxim\objeto.i &Objeto=brPedidos
                         &Frame=fPag01
                         &LayoutH="Direita"
                         &LayoutV="Abaixo de"
                         &ObjSup=brFat}

    {func\maxim\objeto.i &Objeto=brAlerta
                         &Frame=fPag01
                         &LayoutH="Direita"
                         &LayoutV="Abaixo de"
                         &ObjSup=brPedidos}

    {func\maxim\objeto.i &Objeto=descr
                         &Frame=fPag01
                         &LayoutH="Direita"
                         &MudaAltura="N∆o"
                         &LayoutV="Abaixo de"
                         &ObjSup=brAlerta}

    {func\maxim\objeto.i &Objeto=btExec
                         &Frame=fPag01
                         &LayoutH="Alinhado Esquerda Com"
                         &ObjAlin="descr"
                         &MudaTamanho="N∆o"
                         &LayoutV="Baixo"
                         &MudaAltura="N∆o"}

    {func\maxim\objeto.i &Objeto=IMAGE-1
                         &Frame=fPag01
                         &LayoutH="Direita"
                         &MudaTamanho="N∆o"
                         &LayoutV="Baixo"
                         &MudaAltura="N∆o"}

    {func\maxim\ini.i &Window=C-Win
                      &Frame=fPag01
                      &MinWidthD=58}


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESTORED OF C-Win /* MH Money 2005 */
DO:

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

    REPEAT iCont = 1 TO iProgsCont:

        IF VALID-HANDLE(hProgsMenu[iCont]) THEN
            ASSIGN hProgsMenu[iCont]:HIDDEN = NO.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAlerta
&Scoped-define SELF-NAME brAlerta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAlerta C-Win
ON ROW-DISPLAY OF brAlerta IN FRAME fPag01 /* Alertas do Dia */
DO:

    IF tt-alerta.alerta MATCHES("*venceu*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.

    IF tt-alerta.alerta MATCHES("*vencer†*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 9.

    IF tt-alerta.alerta MATCHES("*feriado*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 2.

    IF tt-alerta.alerta MATCHES("HOMOLOG*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.

    IF tt-alerta.alerta MATCHES("PROPOSTA*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.

    IF tt-alerta.alerta MATCHES("COMPROM*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.

    IF tt-alerta.alerta MATCHES("VISITA*") THEN
        ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.

    IF tt-alerta.alerta MATCHES("TAREFA*") THEN DO:
        IF DATE(ENTRY(1, ENTRY(2,tt-alerta.alerta, "["), "]")) < TODAY  THEN
            ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.
    END.

    IF tt-alerta.alerta MATCHES("APONT*") THEN DO:
        IF DATE(ENTRY(1, ENTRY(2,tt-alerta.alerta, "["), "]")) < TODAY  THEN
            ASSIGN tt-alerta.alerta:FGCOLOR IN BROWSE brAlerta = 12.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAlerta C-Win
ON VALUE-CHANGED OF brAlerta IN FRAME fPag01 /* Alertas do Dia */
DO:
    IF AVAIL tt-alerta THEN DO:
        ASSIGN descr:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tt-alerta.descricao.
        IF tt-alerta.executa THEN
            ENABLE btExec WITH FRAME {&FRAME-NAME}.
        ELSE
            DISABLE btExec WITH FRAME {&FRAME-NAME}.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brCotacao
&Scoped-define SELF-NAME brCotacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCotacao C-Win
ON ROW-DISPLAY OF brCotacao IN FRAME fPag01 /* Cotaá∆o de Moedas */
DO:
  
    IF fnPerc(cotacao.cd-moeda) MATCHES("*+*") THEN DO:
        ASSIGN cPerc:FGCOLOR IN BROWSE brCotacao = 9.
    END.
    ELSE DO:
        ASSIGN cPerc:FGCOLOR IN BROWSE brCotacao = 12.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCotacao C-Win
ON VALUE-CHANGED OF brCotacao IN FRAME fPag01 /* Cotaá∆o de Moedas */
DO:
  
    IF AVAIL moeda THEN
        brCotacao:DESELECT-SELECTED-ROW(1).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brDados
&Scoped-define SELF-NAME brDados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brDados C-Win
ON VALUE-CHANGED OF brDados IN FRAME fPag01 /* Gr†fico do Dia */
DO:
  
    IF AVAIL tt-graf THEN
        brDados:DESELECT-SELECTED-ROW(1).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brFat
&Scoped-define SELF-NAME brFat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFat C-Win
ON CTRL-R OF brFat IN FRAME fPag01 /* Pedidos a Faturar */
DO:

    IF AVAIL pedido THEN DO:
        RUN relat-apont.p (INPUT pedido.nr-pedido, 
                           INPUT "", 
                           INPUT 01/01/0001, 
                           INPUT 12/31/9999, 
                           INPUT YES).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFat C-Win
ON MOUSE-SELECT-DBLCLICK OF brFat IN FRAME fPag01 /* Pedidos a Faturar */
DO:

    IF AVAIL pedido THEN DO:
        ASSIGN r-pedido = ROWID(pedido).
        {func\run.i &Programa = "ped-item.w" &MENU = YES}
        RUN initialize.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFat C-Win
ON RETURN OF brFat IN FRAME fPag01 /* Pedidos a Faturar */
DO:

    IF AVAIL pedido THEN DO:
        ASSIGN r-pedido = ROWID(pedido).
        {func\run.i &Programa = "pedido.w" &MENU = YES}
        RUN initialize.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFat C-Win
ON ROW-DISPLAY OF brFat IN FRAME fPag01 /* Pedidos a Faturar */
DO:
  IF pedido.nr-pedido-ant <> 0 THEN DO:

        ASSIGN pedido.nr-pedido:FGCOLOR IN BROWSE brFat = 2
               pedido.dt-previsao-fat:FGCOLOR IN BROWSE brFat = 2
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brFat = 2
               pedido.num-cliente:FGCOLOR IN BROWSE brFat = 2
               pedido.nom-projeto:FGCOLOR IN BROWSE brFat = 2               
               deValTotal:FGCOLOR IN BROWSE brFat = 2.
               

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brPedidos
&Scoped-define SELF-NAME brPedidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPedidos C-Win
ON CTRL-R OF brPedidos IN FRAME fPag01 /* Pedidos Pendentes */
DO:

    IF AVAIL pedido THEN DO:
        RUN relat-apont.p (INPUT pedido.nr-pedido, 
                           INPUT "", 
                           INPUT 01/01/0001, 
                           INPUT 12/31/9999, 
                           INPUT YES).
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPedidos C-Win
ON MOUSE-SELECT-DBLCLICK OF brPedidos IN FRAME fPag01 /* Pedidos Pendentes */
DO:

    IF AVAIL pedido THEN DO:
        ASSIGN r-pedido = ROWID(pedido).
        {func\run.i &Programa = "ped-item.w" &MENU = YES}
        RUN initialize.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPedidos C-Win
ON RETURN OF brPedidos IN FRAME fPag01 /* Pedidos Pendentes */
DO:

    IF AVAIL pedido THEN DO:
        ASSIGN r-pedido = ROWID(pedido).
        {func\run.i &Programa = "pedido.w" &MENU = YES}
        RUN initialize.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPedidos C-Win
ON ROW-DISPLAY OF brPedidos IN FRAME fPag01 /* Pedidos Pendentes */
DO:
  
    IF pedido.situacao = 1 /* Pendente */ THEN DO:
        ASSIGN pedido.nr-pedido:FGCOLOR IN BROWSE brPedidos = 9
               pedido.dt-pedido:FGCOLOR IN BROWSE brPedidos = 9
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brPedidos = 9
               pedido.val-total:FGCOLOR IN BROWSE brPedidos = 9
               pedido.nom-projeto:FGCOLOR IN BROWSE brPedidos = 9
               pedido.num-cliente:FGCOLOR IN BROWSE brPedidos = 9
               deValTotal:FGCOLOR IN BROWSE brPedidos = 9.
    END.
    ELSE DO:
        IF pedido.dt-aprovacao = ? /* N∆o Aprovado */ THEN DO:
            IF pedido.dt-validade < TODAY /* Vencido */ THEN DO:
                ASSIGN pedido.nr-pedido:FGCOLOR IN BROWSE brPedidos = 12
                       pedido.dt-pedido:FGCOLOR IN BROWSE brPedidos = 12
                       favorecido.ds-favorecido:FGCOLOR IN BROWSE brPedidos = 12
                       pedido.val-total:FGCOLOR IN BROWSE brPedidos = 12
                       pedido.nom-projeto:FGCOLOR IN BROWSE brPedidos = 12
                       pedido.num-cliente:FGCOLOR IN BROWSE brPedidos = 12
                       deValTotal:FGCOLOR IN BROWSE brPedidos = 12.
            END.
            ELSE DO:
                ASSIGN pedido.nr-pedido:FGCOLOR IN BROWSE brPedidos = 5
                       pedido.dt-pedido:FGCOLOR IN BROWSE brPedidos = 5
                       favorecido.ds-favorecido:FGCOLOR IN BROWSE brPedidos = 5
                       pedido.val-total:FGCOLOR IN BROWSE brPedidos = 5
                       pedido.nom-projeto:FGCOLOR IN BROWSE brPedidos = 5
                       pedido.num-cliente:FGCOLOR IN BROWSE brPedidos = 5
                       deValTotal:FGCOLOR IN BROWSE brPedidos = 5.
            END.
        END.
        ELSE DO:
            IF pedido.dt-lib-homolog <= TODAY 
            AND pedido.dt-encerramento >= TODAY THEN DO:
                ASSIGN pedido.nr-pedido:FGCOLOR IN BROWSE brPedidos = 2
                       pedido.dt-pedido:FGCOLOR IN BROWSE brPedidos = 2
                       favorecido.ds-favorecido:FGCOLOR IN BROWSE brPedidos = 2
                       pedido.val-total:FGCOLOR IN BROWSE brPedidos = 2
                       pedido.nom-projeto:FGCOLOR IN BROWSE brPedidos = 2
                       pedido.num-cliente:FGCOLOR IN BROWSE brPedidos = 2
                       deValTotal:FGCOLOR IN BROWSE brPedidos = 2.
            END.
            ELSE DO:
                IF pedido.dt-encerramento < TODAY /* Garantia Encerrada */ THEN DO:
                    ASSIGN pedido.nr-pedido:FGCOLOR IN BROWSE brPedidos = 12
                           pedido.dt-pedido:FGCOLOR IN BROWSE brPedidos = 12
                           favorecido.ds-favorecido:FGCOLOR IN BROWSE brPedidos = 12
                           pedido.val-total:FGCOLOR IN BROWSE brPedidos = 12
                           pedido.nom-projeto:FGCOLOR IN BROWSE brPedidos = 12
                           pedido.num-cliente:FGCOLOR IN BROWSE brPedidos = 12
                           deValTotal:FGCOLOR IN BROWSE brPedidos = 12.
                END.
            END.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brSaldo
&Scoped-define SELF-NAME brSaldo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brSaldo C-Win
ON MOUSE-SELECT-DBLCLICK OF brSaldo IN FRAME fPag01 /* Saldo das Contas */
DO:

    IF AVAIL conta THEN DO:
        ASSIGN r-conta = ROWID(conta).
        {func\run.i &Programa = "mov.w" &MENU = YES}
        RUN initialize.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brSaldo C-Win
ON RETURN OF brSaldo IN FRAME fPag01 /* Saldo das Contas */
DO:
  
    APPLY "MOUSE-SELECT-DBLCLICK" TO brSaldo IN FRAME fPag01.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brSaldo C-Win
ON ROW-DISPLAY OF brSaldo IN FRAME fPag01 /* Saldo das Contas */
DO:
  
    IF fnValor(conta.cd-conta) < 0 THEN
        ASSIGN deValor:FGCOLOR IN BROWSE brSaldo = 12.

    ASSIGN conta.dt-saldo:FGCOLOR IN BROWSE brSaldo = 7
           conta.vl-saldo:FGCOLOR IN BROWSE brSaldo = 7
           moeda.sigla:FGCOLOR IN BROWSE brSaldo = 7.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btExec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExec C-Win
ON CHOOSE OF btExec IN FRAME fPag01 /* Button 1 */
DO:
  {winalert_exec.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Agendamentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Agendamentos C-Win
ON CHOOSE OF MENU-ITEM m_Agendamentos /* Pr¢ximos Movimentos Agendados */
DO:  
    {run_menu.i prox.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Agendamentos2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Agendamentos2 C-Win
ON CHOOSE OF MENU-ITEM m_Agendamentos2 /* Agendamentos */
DO:
    {run_menu.i agend.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Alertas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Alertas C-Win
ON CHOOSE OF MENU-ITEM m_Alertas /* Alertas do Usu†rio */
DO:
    {run_menu.i alerta.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Aplication_Compiler
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Aplication_Compiler C-Win
ON CHOOSE OF MENU-ITEM m_Aplication_Compiler /* Aplication Compiler */
DO:
  run _comp.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Apontamentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Apontamentos C-Win
ON CHOOSE OF MENU-ITEM m_Apontamentos /* Apontamentos */
DO:
    ASSIGN giNr-pedido = 0
           giSequencia = 0.
    {run_menu.i apont.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_APP_Builder
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_APP_Builder C-Win
ON CHOOSE OF MENU-ITEM m_APP_Builder /* APP Builder */
DO:
  run ab.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Atualizao_Automtica_MHMoney
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Atualizao_Automtica_MHMoney C-Win
ON CHOOSE OF MENU-ITEM m_Atualizao_Automtica_MHMoney /* Atualizaá∆o Autom†tica MHMoney 2005 */
DO:
    {run_menu.i atualiza.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Backup_de_Dados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Backup_de_Dados C-Win
ON CHOOSE OF MENU-ITEM m_Backup_de_Dados /* Backup do Sistema */
DO:
    {run_menu.i backup.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Bens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Bens C-Win
ON CHOOSE OF MENU-ITEM m_Bens /* Bens */
DO:
    {run_menu.i bens.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Calculadora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Calculadora C-Win
ON CHOOSE OF MENU-ITEM m_Calculadora /* Calculadora */
DO:
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    {run_menu.i "func\calc.w (INPUT 0, OUTPUT deTemp)"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Calendrio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Calendrio C-Win
ON CHOOSE OF MENU-ITEM m_Calendrio /* Calend†rio */
DO:
    DEFINE VARIABLE dtTemp AS DATE    NO-UNDO.
    {run_menu.i "func\calendar.w (OUTPUT dtTemp)"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Caractersticas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Caractersticas C-Win
ON CHOOSE OF MENU-ITEM m_Caractersticas /* Caracter°sticas */
DO:
  {run_menu.i caracteristica.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Caractersticas_do_Contato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Caractersticas_do_Contato C-Win
ON CHOOSE OF MENU-ITEM m_Caractersticas_do_Contato /* Caracter°sticas do Contato */
DO:
  {run_menu.i contato-caracteristica.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Categorias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Categorias C-Win
ON CHOOSE OF MENU-ITEM m_Categorias /* Categorias */
DO:
    {run_menu.i cat.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Clientes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Clientes C-Win
ON CHOOSE OF MENU-ITEM m_Clientes /* Clientes */
DO:
  {run_menu.i fav.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Clientes_por_CidadoEstado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Clientes_por_CidadoEstado C-Win
ON CHOOSE OF MENU-ITEM m_Clientes_por_CidadoEstado /* Clientes por Cidado/Estado */
DO:
    {run_menu.i relat\r042.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Cockpit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cockpit C-Win
ON CHOOSE OF MENU-ITEM m_Cockpit /* Cockpit */
DO:
  {run_menu.i crm.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Compra C-Win
ON CHOOSE OF MENU-ITEM m_Compra /* Cadastro de Compras */
DO:
    {run_menu.i compra.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Compromissos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Compromissos C-Win
ON CHOOSE OF MENU-ITEM m_Compromissos /* Compromissos */
DO:
    {run_menu.i compromisso.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Consulta_de_Custos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Consulta_de_Custos C-Win
ON CHOOSE OF MENU-ITEM m_Consulta_de_Custos /* Consulta de Custos */
DO:
    {run_menu.i custo-hora.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Contas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Contas C-Win
ON CHOOSE OF MENU-ITEM m_Contas /* Contas */
DO:
    {run_menu.i contas.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Controle_de_Reembolsos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Controle_de_Reembolsos C-Win
ON CHOOSE OF MENU-ITEM m_Controle_de_Reembolsos /* Controle de Reembolsos */
DO:
    {run_menu.i reembolsa.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Cotao_de_Moedas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Cotao_de_Moedas C-Win
ON CHOOSE OF MENU-ITEM m_Cotao_de_Moedas /* Cotaá∆o de Moedas */
DO:
    {run_menu.i cotacao.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Custos_Ms_a_Ms
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Custos_Ms_a_Ms C-Win
ON CHOOSE OF MENU-ITEM m_Custos_Ms_a_Ms /* Custos Màs a Màs */
DO:
    {run_menu.i graf\g018.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Data_Administrator
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Data_Administrator C-Win
ON CHOOSE OF MENU-ITEM m_Data_Administrator /* Data Administrator */
DO:
  run _admin.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Data_Dictionary
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Data_Dictionary C-Win
ON CHOOSE OF MENU-ITEM m_Data_Dictionary /* Data Dictionary */
DO:
  run _dict.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Despesas_da_Categoria_por_R
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Despesas_da_Categoria_por_R C-Win
ON CHOOSE OF MENU-ITEM m_Despesas_da_Categoria_por_R /* Despesas da Categoria por Respons†vel */
DO:
    {run_menu.i relat\r015.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_E-mail_Marketing
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_E-mail_Marketing C-Win
ON CHOOSE OF MENU-ITEM m_E-mail_Marketing /* E-mail Marketing */
DO:
    {run_menu.i mailmkt.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Editor_do_PROGRESS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Editor_do_PROGRESS C-Win
ON CHOOSE OF MENU-ITEM m_Editor_do_PROGRESS /* Editor do PROGRESS */
DO:
  run _edit.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Evoluo_de_Saldo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Evoluo_de_Saldo C-Win
ON CHOOSE OF MENU-ITEM m_Evoluo_de_Saldo /* Evoluá∆o de Saldo */
DO:
    {run_menu.i graf\g001.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Evoluo_Patrimnial
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Evoluo_Patrimnial C-Win
ON CHOOSE OF MENU-ITEM m_Evoluo_Patrimnial /* Evoluá∆o Patrimìnial */
DO:
    {run_menu.i graf\g021.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_F11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_F11 C-Win
ON CHOOSE OF MENU-ITEM m_F11 /* F11 */
DO:
  run start_f11.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Faturamento_de_Balco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Faturamento_de_Balco C-Win
ON CHOOSE OF MENU-ITEM m_Faturamento_de_Balco /* Faturamento de Balc∆o */
DO:
    {run_menu.i fatbalc.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Faturamento_de_Pedidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Faturamento_de_Pedidos C-Win
ON CHOOSE OF MENU-ITEM m_Faturamento_de_Pedidos /* Faturamento de Pedidos */
DO:
    {run_menu.i fat.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Favorecidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Favorecidos C-Win
ON CHOOSE OF MENU-ITEM m_Favorecidos /* Clientes \ Fornecedores */
DO:
    {run_menu.i fav.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Feriados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Feriados C-Win
ON CHOOSE OF MENU-ITEM m_Feriados /* Feriados */
DO:
    {run_menu.i feriado.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Formas_de_Pagamento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Formas_de_Pagamento C-Win
ON CHOOSE OF MENU-ITEM m_Formas_de_Pagamento /* Formas de Pagamento */
DO:
    {run_menu.i formapag.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Gerar_Folha_de_Apontamentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Gerar_Folha_de_Apontamentos C-Win
ON CHOOSE OF MENU-ITEM m_Gerar_Folha_de_Apontamentos /* Gerar Folha de Apontamentos */
DO:
    {run_menu.i gerarfa.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Histrico_do_Item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Histrico_do_Item C-Win
ON CHOOSE OF MENU-ITEM m_Histrico_do_Item /* Hist¢rico do Item */
DO:
    {run_menu.i hist-item.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Importao_de_Arquivos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Importao_de_Arquivos C-Win
ON CHOOSE OF MENU-ITEM m_Importao_de_Arquivos /* Importaá∆o de Arquivos */
DO:
    {run_menu.i imp.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Impostos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Impostos C-Win
ON CHOOSE OF MENU-ITEM m_Impostos /* Impostos */
DO:
    {run_menu.i imposto.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Inflao_no_Perodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Inflao_no_Perodo C-Win
ON CHOOSE OF MENU-ITEM m_Inflao_no_Perodo /* Inflaá∆o no Per°odo */
DO:
    {run_menu.i relat\r017.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Inventrio_de_Itens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Inventrio_de_Itens C-Win
ON CHOOSE OF MENU-ITEM m_Inventrio_de_Itens /* Invent†rio de Itens */
DO:
    {run_menu.i invent.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Item C-Win
ON CHOOSE OF MENU-ITEM m_Item /* Itens */
DO:
    {run_menu.i item.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Itens_da_Compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Itens_da_Compra C-Win
ON CHOOSE OF MENU-ITEM m_Itens_da_Compra /* Itens da Compra */
DO:
    {run_menu.i item-compra.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Itens_da_Nota_Fiscal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Itens_da_Nota_Fiscal C-Win
ON CHOOSE OF MENU-ITEM m_Itens_da_Nota_Fiscal /* Itens da Nota Fiscal */
DO:
    {run_menu.i item-nota.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Itens_da_Tabela_de_Preo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Itens_da_Tabela_de_Preo C-Win
ON CHOOSE OF MENU-ITEM m_Itens_da_Tabela_de_Preo /* Itens da Tabela de Preáo */
DO:
    {run_menu.i item-tabpreco.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Itens_do_Pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Itens_do_Pedido C-Win
ON CHOOSE OF MENU-ITEM m_Itens_do_Pedido /* Itens do Pedido */
DO:
    {run_menu.i ped-item.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Lista_de_Compras
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Lista_de_Compras C-Win
ON CHOOSE OF MENU-ITEM m_Lista_de_Compras /* Lista de Compras */
DO:
    {run_menu.i relat\r040.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Login C-Win
ON CHOOSE OF MENU-ITEM m_Login /* Login */
DO:
  {run_menu.i senha.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Logout
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Logout C-Win
ON CHOOSE OF MENU-ITEM m_Logout /* Logout */
DO:

  RUN som.p(INPUT "music\click.wav").
  {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Logout (005)', INPUT 'Confirma Logout do usu†rio ' + gcUsuario, INPUT 'Caso o Logout for confirmado, n∆o ser† poss°vel executar nenhum programa enquanto n∆o for feito Login de um novo usu†rio.')"}
  IF RETURN-VALUE = "OK" THEN DO:
      assign gcUsuario = "".
      RUN controlaPermissao IN THIS-PROCEDURE.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Lucratividade_de_Aes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Lucratividade_de_Aes C-Win
ON CHOOSE OF MENU-ITEM m_Lucratividade_de_Aes /* Lucratividade de Aá‰es */
DO:
    {run_menu.i relat\r038.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Maiores_Favorecidos2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Maiores_Favorecidos2 C-Win
ON CHOOSE OF MENU-ITEM m_Maiores_Favorecidos2 /* Maiores Favorecidos */
DO:
    {run_menu.i graf\g017.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Manual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Manual C-Win
ON CHOOSE OF MENU-ITEM m_Manual /* Conte£do */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    RUN applhelp.p.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Manuteno_de_Notas_Fiscais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Manuteno_de_Notas_Fiscais C-Win
ON CHOOSE OF MENU-ITEM m_Manuteno_de_Notas_Fiscais /* Manutená∆o de Notas Fiscais */
DO:
    {run_menu.i nota.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Manuteno_de_Pedidos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Manuteno_de_Pedidos C-Win
ON CHOOSE OF MENU-ITEM m_Manuteno_de_Pedidos /* Manutená∆o de Pedidos */
DO:
    {run_menu.i pedido.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Metas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Metas C-Win
ON CHOOSE OF MENU-ITEM m_Metas /* Metas */
DO:
    {run_menu.i meta.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Moedas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Moedas C-Win
ON CHOOSE OF MENU-ITEM m_Moedas /* Moedas */
DO:
    {run_menu.i moeda.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Monitor_de_Pedidos_de_Execu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Monitor_de_Pedidos_de_Execu C-Win
ON CHOOSE OF MENU-ITEM m_Monitor_de_Pedidos_de_Execu /* Monitor de Pedidos de Execuá∆o */
DO:
    {run_menu.i monitor.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Movimentao_da_Categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Movimentao_da_Categoria C-Win
ON CHOOSE OF MENU-ITEM m_Movimentao_da_Categoria /* Movimentaá∆o da Categoria\Sub-Categoria */
DO:
    {run_menu.i graf\g019.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Movimentao_por_Favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Movimentao_por_Favorecido C-Win
ON CHOOSE OF MENU-ITEM m_Movimentao_por_Favorecido /* Movimentaá∆o por Favorecido */
DO:
    {run_menu.i relat\r022.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Movimentao_por_Responsvel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Movimentao_por_Responsvel C-Win
ON CHOOSE OF MENU-ITEM m_Movimentao_por_Responsvel /* Movimentaá∆o por Respons†vel */
DO:
    {run_menu.i relat\r012.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Movimentos_da_Conta_Selecio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Movimentos_da_Conta_Selecio C-Win
ON CHOOSE OF MENU-ITEM m_Movimentos_da_Conta_Selecio /* Movimentos da Conta */
DO:
  
    IF AVAIL conta THEN DO:
        ASSIGN r-conta = ROWID(conta).
        {run_menu.i mov.w}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Movimentos_do_Bem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Movimentos_do_Bem C-Win
ON CHOOSE OF MENU-ITEM m_Movimentos_do_Bem /* Movimentos do Bem */
DO:
    {run_menu.i mov-bens.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Oramento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Oramento C-Win
ON CHOOSE OF MENU-ITEM m_Oramento /* Manutená∆o de Oráamentos */
DO:
    {run_menu.i orc.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Ordem_de_Servio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Ordem_de_Servio C-Win
ON CHOOSE OF MENU-ITEM m_Ordem_de_Servio /* Ordem de Serviáo */
DO:
    {run_menu.i os.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Pagamentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Pagamentos C-Win
ON CHOOSE OF MENU-ITEM m_Pagamentos /* Parcelas da Nota Fiscal */
DO:
    {run_menu.i parc-nota.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Painel_de_Servios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Painel_de_Servios C-Win
ON CHOOSE OF MENU-ITEM m_Painel_de_Servios /* Painel de Serviáos */
DO:
    {run_menu.i painel-os.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Parmetros_Locais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Parmetros_Locais C-Win
ON CHOOSE OF MENU-ITEM m_Parmetros_Locais /* ParÉmetros Locais */
DO:
    {run_menu.i param.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Patrimnio_Financeiro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Patrimnio_Financeiro C-Win
ON CHOOSE OF MENU-ITEM m_Patrimnio_Financeiro /* Patrimìnio Financeiro Di†rio */
DO:
    {run_menu.i graf\g002.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Patrimnio_Financeiro_Ms_a_M
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Patrimnio_Financeiro_Ms_a_M C-Win
ON CHOOSE OF MENU-ITEM m_Patrimnio_Financeiro_Ms_a_M /* Patrimìnio Financeiro Màs a Màs */
DO:
    {run_menu.i graf\g004.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Pedidos_da_Nota_Fiscal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Pedidos_da_Nota_Fiscal C-Win
ON CHOOSE OF MENU-ITEM m_Pedidos_da_Nota_Fiscal /* Pedidos da Nota Fiscal */
DO:
    {run_menu.i ped-nota.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Potencial_de_Vendas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Potencial_de_Vendas C-Win
ON CHOOSE OF MENU-ITEM m_Potencial_de_Vendas /* Potencial de Vendas */
DO:
    {run_menu.i relat\r041.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Poupana
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Poupana C-Win
ON CHOOSE OF MENU-ITEM m_Poupana /* Manutená∆o de Poupanáas */
DO:
    {run_menu.i poup.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Poupana_Ano_a_An
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Poupana_Ano_a_An C-Win
ON CHOOSE OF MENU-ITEM m_Poupana_Ano_a_An /* Plan. Anual de Poupanáa */
DO:
    {run_menu.i poupano.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Previso_de_Saldo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Previso_de_Saldo C-Win
ON CHOOSE OF MENU-ITEM m_Previso_de_Saldo /* Previs∆o de Saldo */
DO:
    {run_menu.i graf\g003.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Previsto_X_Realizado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Previsto_X_Realizado C-Win
ON CHOOSE OF MENU-ITEM m_Previsto_X_Realizado /* Previsto X Realizado */
DO:
    {run_menu.i orcacomp.w}      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Principais_Categorias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Principais_Categorias C-Win
ON CHOOSE OF MENU-ITEM m_Principais_Categorias /* Principais Categorias */
DO:
    {run_menu.i graf\g015.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Principais_Sub-Categorias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Principais_Sub-Categorias C-Win
ON CHOOSE OF MENU-ITEM m_Principais_Sub-Categorias /* Principais Sub-Categorias */
DO:
    {run_menu.i graf\g016.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Projeto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Projeto C-Win
ON CHOOSE OF MENU-ITEM m_Projeto /* Projetos */
DO:
    {run_menu.i projeto.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_PROPATH
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_PROPATH C-Win
ON CHOOSE OF MENU-ITEM m_PROPATH /* PROPATH */
DO:
    RUN protools/_propath.w.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R001
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R001 C-Win
ON CHOOSE OF MENU-ITEM m_R001 /* Balanáo Mensal */
DO:
    {run_menu.i relat\r001.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R002
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R002 C-Win
ON CHOOSE OF MENU-ITEM m_R002 /* Fluxo de Caixa */
DO:
    {run_menu.i relat\r002.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R003
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R003 C-Win
ON CHOOSE OF MENU-ITEM m_R003 /* Extrato Mensal */
DO:
    {run_menu.i relat\r003.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R004
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R004 C-Win
ON CHOOSE OF MENU-ITEM m_R004 /* Patrimìnio Financeiro Di†rio */
DO:
    {run_menu.i relat\r004.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R005
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R005 C-Win
ON CHOOSE OF MENU-ITEM m_R005 /* Previs∆o de Saldo */
DO:
    {run_menu.i relat\r005.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R006
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R006 C-Win
ON CHOOSE OF MENU-ITEM m_R006 /* Custos X Despesas */
DO:
    {run_menu.i relat\r006.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R007
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R007 C-Win
ON CHOOSE OF MENU-ITEM m_R007 /* Rendimentos X Despesas */
DO:
    {run_menu.i relat\r007.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R008
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R008 C-Win
ON CHOOSE OF MENU-ITEM m_R008 /* Patrimìnio Financeiro Màs a Màs */
DO:
    {run_menu.i relat\r008.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R009
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R009 C-Win
ON CHOOSE OF MENU-ITEM m_R009 /* Relat¢rio Mensal */
DO:
    {run_menu.i relat\r009.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R010
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R010 C-Win
ON CHOOSE OF MENU-ITEM m_R010 /* Rendimento X Despesas Màs a Màs */
DO:
    {run_menu.i relat\r010.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R011
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R011 C-Win
ON CHOOSE OF MENU-ITEM m_R011 /* Relat¢rio Anual */
DO:
    {run_menu.i relat\r011.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_r014
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_r014 C-Win
ON CHOOSE OF MENU-ITEM m_r014 /* Inflaá∆o de Item no Per°odo */
DO:
    {run_menu.i relat\r014.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R018
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R018 C-Win
ON CHOOSE OF MENU-ITEM m_R018 /* Principais Categorias */
DO:
    {run_menu.i relat\r018.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R019
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R019 C-Win
ON CHOOSE OF MENU-ITEM m_R019 /* Principais Sub-Categorias */
DO:
    {run_menu.i relat\r019.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R020
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R020 C-Win
ON CHOOSE OF MENU-ITEM m_R020 /* Maiores Favorecidos */
DO:
    {run_menu.i relat\r020.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R021
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R021 C-Win
ON CHOOSE OF MENU-ITEM m_R021 /* Èltimas Faturas Pagas */
DO:
    {run_menu.i relat\r021.w}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R024
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R024 C-Win
ON CHOOSE OF MENU-ITEM m_R024 /* Balanáo Anual */
DO:
    {run_menu.i relat\r024.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R025
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R025 C-Win
ON CHOOSE OF MENU-ITEM m_R025 /* Balanáa Comercial Anual */
DO:
    {run_menu.i relat\r025.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R026
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R026 C-Win
ON CHOOSE OF MENU-ITEM m_R026 /* Acompanhamento de Balanáa Comercial */
DO:
    {run_menu.i relat\r026.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R027
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R027 C-Win
ON CHOOSE OF MENU-ITEM m_R027 /* Custos Màs a Màs */
DO:
    {run_menu.i relat\r027.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R028
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R028 C-Win
ON CHOOSE OF MENU-ITEM m_R028 /* Comparativo Mensal */
DO:
    {run_menu.i relat\r028.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R029
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R029 C-Win
ON CHOOSE OF MENU-ITEM m_R029 /* Juros de Poupanáa */
DO:
    {run_menu.i relat\r029.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R030
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R030 C-Win
ON CHOOSE OF MENU-ITEM m_R030 /* Evoluá∆o Patrimonial */
DO:
    {run_menu.i relat\r030.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R031
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R031 C-Win
ON CHOOSE OF MENU-ITEM m_R031 /* Resumo de Movimentaá∆o */
DO:
    {run_menu.i relat\r031.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R032
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R032 C-Win
ON CHOOSE OF MENU-ITEM m_R032 /* Previsto X Realizado */
DO:
    {run_menu.i relat\r032.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R033
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R033 C-Win
ON CHOOSE OF MENU-ITEM m_R033 /* Relat¢rio de Acompanhamento */
DO:
    {run_menu.i relat\r033.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R034
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R034 C-Win
ON CHOOSE OF MENU-ITEM m_R034 /* Taxa de Retorno */
DO:
    {run_menu.i relat\r034.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R035
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R035 C-Win
ON CHOOSE OF MENU-ITEM m_R035 /* Percentual de Formaá∆o de Juros */
DO:
    {run_menu.i relat\r035.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R036
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R036 C-Win
ON CHOOSE OF MENU-ITEM m_R036 /* Projeá∆o em Poupanáa */
DO:
    {run_menu.i relat\r036.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R037
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R037 C-Win
ON CHOOSE OF MENU-ITEM m_R037 /* Dados para Imposto de Renda */
DO:
    {run_menu.i relat\r037.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_R039
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_R039 C-Win
ON CHOOSE OF MENU-ITEM m_R039 /* Lucratividade de Investimento */
DO:
    {run_menu.i relat\r039.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Registro_do_Produto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Registro_do_Produto C-Win
ON CHOOSE OF MENU-ITEM m_Registro_do_Produto /* Registro do Produto */
DO:
    {run_menu.i valida.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Rendimentos_X_Despesas_Ms_a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Rendimentos_X_Despesas_Ms_a C-Win
ON CHOOSE OF MENU-ITEM m_Rendimentos_X_Despesas_Ms_a /* Rendimento X Despesas Màs a Màs */
DO:
    {run_menu.i graf\g005.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Restries
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Restries C-Win
ON CHOOSE OF MENU-ITEM m_Restries /* Restriá‰es do Usu†rio */
DO:
    {run_menu.i restricao.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Sair
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Sair C-Win
ON CHOOSE OF MENU-ITEM m_Sair /* Sair */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    APPLY "WINDOW-CLOSE" TO C-Win.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Simulao_de_Oramento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Simulao_de_Oramento C-Win
ON CHOOSE OF MENU-ITEM m_Simulao_de_Oramento /* Simulaá∆o de Oráamento */
DO:
    {run_menu.i relat\r016.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Sincronizao_de_Dados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Sincronizao_de_Dados C-Win
ON CHOOSE OF MENU-ITEM m_Sincronizao_de_Dados /* Sincronizaá∆o de Dados */
DO:
    {run_menu.i lote.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Sobre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Sobre C-Win
ON CHOOSE OF MENU-ITEM m_Sobre /* Sobre o MH Money 2005... */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "sobre.w"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Sub-Categorias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Sub-Categorias C-Win
ON CHOOSE OF MENU-ITEM m_Sub-Categorias /* Sub-Categorias */
DO:
    {run_menu.i subcat.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Tabela_de_Preo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Tabela_de_Preo C-Win
ON CHOOSE OF MENU-ITEM m_Tabela_de_Preo /* Tabela de Preáo */
DO:
    {run_menu.i tabpreco.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Tarefas_da_OS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Tarefas_da_OS C-Win
ON CHOOSE OF MENU-ITEM m_Tarefas_da_OS /* Tarefas da OS */
DO:
    {run_menu.i tarefa-os.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Tarefas_do_Usurio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Tarefas_do_Usurio C-Win
ON CHOOSE OF MENU-ITEM m_Tarefas_do_Usurio /* Tarefas */
DO:
    {run_menu.i tarefa.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Usurios
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Usurios C-Win
ON CHOOSE OF MENU-ITEM m_Usurios /* Usu†rios */
DO:
    {run_menu.i usuario.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Valores_de_Agendamentos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Valores_de_Agendamentos C-Win
ON CHOOSE OF MENU-ITEM m_Valores_de_Agendamentos /* Valores de Agendamentos */
DO:
    {run_menu.i valagend.w}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_ValorHora_por_Pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_ValorHora_por_Pedido C-Win
ON CHOOSE OF MENU-ITEM m_ValorHora_por_Pedido /* Valor/Hora por Pedido */
DO:
    {run_menu.i relat\r023.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Valor_de_Bens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Valor_de_Bens C-Win
ON CHOOSE OF MENU-ITEM m_Valor_de_Bens /* Valor de Bens */
DO:
    {run_menu.i relat\r013.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Visitas_Comerciais
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Visitas_Comerciais C-Win
ON CHOOSE OF MENU-ITEM m_Visitas_Comerciais /* Visitas Comerciais */
DO:
    {run_menu.i visita.w}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAlerta
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

ASSIGN C-Win:VISIBLE = NO.
RUN ini.w PERSISTENT SET hProg.
RUN ENABLE_UI IN hProg.
RUN setaVersao IN hProg.

DEFINE VARIABLE dtValidad AS DATE    NO-UNDO.
DEFINE VARIABLE cMesMenu AS CHARACTER   NO-UNDO.

IF AVAIL param-mn THEN DO:

    ASSIGN dtValidad = DATE(ValidaRegMoney(4, "", param-mn.num-reg)).

    ASSIGN cMesMenu = "A data de validade da licenáa do MHMoney 2005 expirar† em " + STRING(dtValidad, "99/99/9999") + ". Ap¢s essa data n∆o ser† mais poss°vel utilizar o sistema. Entre em contato com maickel.hubner@gmail.com solicitando uma nova licenáa para continuar usando o sistema normalmente.".

    FIND FIRST usuario WHERE usuario.nome = gcUsuario NO-LOCK.
    IF usuario.administrador AND (TODAY + 15) >= dtValidad THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Validade (055)', INPUT 'Data de validade pr¢xima de expirar.', INPUT cMesMenu)" &MENU = YES}
    END.

END.

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
  {version.i MENU}
  /*ASSIGN C-Win:VISIBLE = NO.
  RUN winalert.w (INPUT 1, INPUT ?, INPUT YES, OUTPUT TABLE tt-alerta).
  ASSIGN C-Win:VISIBLE = YES.*/
  ASSIGN {&WINDOW-NAME}:MAX-HEIGHT   = ?
         {&WINDOW-NAME}:MAX-WIDTH    = ?
         {&WINDOW-NAME}:WINDOW-STATE = WINDOW-MAXIMIZED.
  RUN enable_UI.
  run initialize.
  APPLY "WINDOW-RESIZED" TO C-Win.
  RUN som.p(INPUT "#music\logon.wav").
  RUN testaAtualizacao.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlaPermissao C-Win 
PROCEDURE controlaPermissao :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    if gcUsuario <> "" then do:
        assign menu-item m_Login:sensitive in menu MENU-BAR-C-Win = no
               menu-item m_Logout:sensitive in menu MENU-BAR-C-Win = yes.
        find first usuario where usuario.nome = gcUsuario NO-LOCK.
        if usuario.administrador then
            assign sub-menu m_Admin:sensitive in menu MENU-BAR-C-Win = yes.
        else
            assign sub-menu m_Admin:sensitive in menu MENU-BAR-C-Win = no.
    end.
    else do:
        assign menu-item m_Login:sensitive in menu MENU-BAR-C-Win = yes
               menu-item m_Logout:sensitive in menu MENU-BAR-C-Win = no
               sub-menu m_Admin:sensitive in menu MENU-BAR-C-Win = no.
    end.

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

OCXFile = SEARCH( "menu-emp.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
    chCtrlFrame-2 = CtrlFrame-2:COM-HANDLE
    UIB_S = chCtrlFrame-2:LoadControls( OCXFile, "CtrlFrame-2":U)
    CtrlFrame-2:NAME = "CtrlFrame-2":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "menu-emp.wrx":U SKIP(1)
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
  DISPLAY descr 
      WITH FRAME fPag01 IN WINDOW C-Win.
  ENABLE IMAGE-1 brFat brPedidos brDados brAlerta brSaldo descr brCotacao 
      WITH FRAME fPag01 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPag01}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grafDia C-Win 
PROCEDURE grafDia :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO INITIAL 2.
    DEFINE VARIABLE deWidth AS DECIMAL  NO-UNDO.
    DEFINE VARIABLE whColuna AS WIDGET-HANDLE     NO-UNDO.

    IF NOT CAN-FIND(FIRST conta) THEN
        RETURN.

    SESSION:SET-WAIT-STATE("image\calc.cur").

    IF NOT CAN-FIND(FIRST tt-graf) THEN DO:

        CASE (DAY(TODAY) MOD 10):
            WHEN 0 THEN RUN _graf-01.
            WHEN 1 THEN RUN _graf-03.
            WHEN 2 THEN RUN _graf-04.
            WHEN 3 THEN RUN _graf-05.
            WHEN 4 THEN RUN _graf-15.
            WHEN 5 THEN RUN _graf-16.
            WHEN 6 THEN RUN _graf-17.
            WHEN 7 THEN RUN _graf-18.
            WHEN 8 THEN RUN _graf-19.
            WHEN 9 THEN RUN _graf-21.
        END CASE.

        /* Desenha o gr†fico */

        FIND FIRST tt-graf-par.

        chDesenho:Type = tt-graf-par.tipo.

        chSequencia1 = chDesenho:SeriesCollection:Add(-1).

        ASSIGN chTitulo:Caption = tt-graf-par.titulo.

        fnGravaDado(1, 1, tt-graf-par.dado-label, "").
        fnGravaDado(1, 2, tt-graf-par.valor-label[1], "").
        IF tt-graf-par.valor-label[2] <> "" THEN DO:
            fnGravaDado(1, 3, tt-graf-par.valor-label[2], "").
            IF tt-graf-par.tipo >= 18
            AND tt-graf-par.tipo <= 20 THEN DO:
                chGrafico:HasChartSpaceLegend = TRUE.
            END.
        END.
        IF tt-graf-par.valor-label[3] <> "" THEN DO:
            fnGravaDado(1, 4, tt-graf-par.valor-label[3], "").
        END.
        IF tt-graf-par.valor-label[4] <> "" THEN DO:
            fnGravaDado(1, 5, tt-graf-par.valor-label[4], "").
        END.


        /* Dados na Planilha */

        FOR EACH tt-graf:

            IF tt-graf-par.tipo >= 18
            AND tt-graf-par.tipo <= 20 THEN DO:
                fnGravaDado(iCont, 1, tt-graf.dado, "").
            END.
            fnGravaDado(iCont, 2, STRING(tt-graf.valor[1]), "").
            fnGravaDado(iCont, 3, STRING(tt-graf.valor[2]), "").
            fnGravaDado(iCont, 4, STRING(tt-graf.valor[3]), "").
            fnGravaDado(iCont, 5, STRING(tt-graf.valor[4]), "").

            ASSIGN iCont = iCont + 1.

        END.

        chSequencia1:SetData(chConstantes:chDimSeriesNames, 0, "B1").
        chSequencia1:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
        chSequencia1:SetData(chConstantes:chDimValues, 0, ("B2:B" + STRING(iCont - 1))).
        IF tt-graf-par.valor-label[2] <> "" THEN DO:
            chSequencia2 = chDesenho:SeriesCollection:Add(-1).
            chSequencia2:SetData(chConstantes:chDimSeriesNames, 0, "C1").
            chSequencia2:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
            chSequencia2:SetData(chConstantes:chDimValues, 0, ("C2:C" + STRING(iCont - 1))).
            chSequencia2:Interior:COLOR = RGB-VALUE(107,220,169).
            chSequencia2:Line:COLOR = RGB-VALUE(107,220,169).
        END.
        IF tt-graf-par.valor-label[3] <> "" THEN DO:
            chSequencia3 = chDesenho:SeriesCollection:Add(-1).
            chSequencia3:SetData(chConstantes:chDimSeriesNames, 0, "D1").
            chSequencia3:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
            chSequencia3:SetData(chConstantes:chDimValues, 0, ("D2:D" + STRING(iCont - 1))).
            chSequencia3:Interior:COLOR = RGB-VALUE(29,104,68).
            chSequencia3:Line:COLOR = RGB-VALUE(29,104,68).
        END.
        IF tt-graf-par.valor-label[4] <> "" THEN DO:
            chSequencia3 = chDesenho:SeriesCollection:Add(-1).
            chSequencia3:SetData(chConstantes:chDimSeriesNames, 0, "E1").
            chSequencia3:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
            chSequencia3:SetData(chConstantes:chDimValues, 0, ("E2:E" + STRING(iCont - 1))).
            chSequencia3:Interior:COLOR = RGB-VALUE(34,177,76).
            chSequencia3:Line:COLOR = RGB-VALUE(34,177,76).
        END.

        IF tt-graf-par.tipo < 18
        OR tt-graf-par.tipo > 20 THEN DO:
            chSequencia1:Interior:COLOR = RGB-VALUE(49,155,100).
            chSequencia1:Line:Color = RGB-VALUE(49,155,100).
            chGrafico:HasChartSpaceLegend = FALSE.
        END.

        {&OPEN-QUERY-brDados}
        APPLY "VALUE-CHANGED" TO brDados IN FRAME {&FRAME-NAME}.

        ASSIGN whColuna = BROWSE brDados:GET-BROWSE-COLUMN(1)
               whColuna:LABEL = tt-graf-par.dado-label.

        IF tt-graf-par.valor-label[2] = "" THEN
            ASSIGN whColuna:WIDTH = 40.
        ELSE
            ASSIGN whColuna:WIDTH = 13.75.

        ASSIGN whColuna = BROWSE brDados:GET-BROWSE-COLUMN(2)
               whColuna:LABEL = tt-graf-par.valor-label[1]
               whColuna:WIDTH = 13.75.


        IF tt-graf-par.valor-label[2] <> "" THEN DO:
            ASSIGN whColuna = BROWSE brDados:ADD-LIKE-COLUMN("tt-graf.valor[2]")
                   whColuna:LABEL = tt-graf-par.valor-label[2]
                   whColuna:WIDTH = 13.75.
        END.
        IF tt-graf-par.valor-label[3] <> "" THEN DO:
            ASSIGN whColuna = BROWSE brDados:ADD-LIKE-COLUMN("tt-graf.valor[3]")
                   whColuna:LABEL = tt-graf-par.valor-label[3]
                   whColuna:WIDTH = 13.75.
        END.
        IF tt-graf-par.valor-label[4] <> "" THEN DO:
            ASSIGN whColuna = BROWSE brDados:ADD-LIKE-COLUMN("tt-graf.valor[4]")
                   whColuna:LABEL = tt-graf-par.valor-label[4]
                   whColuna:WIDTH = 13.75.
        END.

        ASSIGN chGrafico:Border:Color = RGB-VALUE(128,157,185).


    END.

    SESSION:SET-WAIT-STATE("").

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

    RUN controlaPermissao IN THIS-PROCEDURE.

    {&OPEN-QUERY-brFat}
    {&OPEN-QUERY-brPedidos}
    {&OPEN-QUERY-brSaldo}
    {&OPEN-QUERY-brCotacao}
    APPLY "VALUE-CHANGED" TO brCotacao IN FRAME fPag01.

    IF VALID-HANDLE(hProg) THEN
        RUN texto IN hProg (INPUT "Buscando alertas...").
    RUN winalert.w (INPUT 1, INPUT ?, INPUT NO, OUTPUT TABLE tt-alerta).
    {&OPEN-QUERY-brAlerta}
    APPLY "VALUE-CHANGED" TO brAlerta IN FRAME fPag01.

    IF VALID-HANDLE(hProg) THEN
        RUN texto IN hProg (INPUT "Gerando gr†fico do dia...").
    RUN grafDia IN THIS-PROCEDURE.
    /*ASSIGN BROWSE brDados:TITLE = cTituloGraf.*/

    IF VALID-HANDLE(hProg) THEN DO:
        RUN CLOSE IN hProg.
        ASSIGN C-Win:VISIBLE = YES.
    END.

    IF param-mn.perfil <> 2 /* Empresarial */ THEN DO:
        MENU-ITEM m_ValorHora_por_Pedido:PARENT:SENSITIVE IN MENU MENU-BAR-C-Win = FALSE.
    END.

    RETURN "OK".

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
ASSIGN CtrlFrame-2:HIDDEN = YES.

ASSIGN chGrafico    = chCtrlFrame:ChartSpace
       chPlanilha   = chCtrlFrame-2:SpreadSheet
       chConstantes = chGrafico:Constants
       chGrafico:HasChartSpaceTitle = TRUE
       chGrafico:HasChartSpaceLegend = TRUE
       chTitulo = chGrafico:ChartSpaceTitle.

       chGrafico:ChartSpaceLegend:POSITION = chConstantes:chLegendPositionRight.

       chDesenho = chGrafico:Charts:Add(-1).

       chDesenho:Type = chConstantes:chChartTypeColumnClustered.

       chGrafico:DataSource = chPlanilha.
       chTitulo:Caption = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE testaAtualizacao C-Win 
PROCEDURE testaAtualizacao :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cDirAtu AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE dtNew AS DATE       NO-UNDO.

    FIND FIRST param-mn.
    IF SEARCH(param-mn.prod-dir + "\atualiza.dat") <> ? THEN DO:
        INPUT FROM VALUE(param-mn.prod-dir + "\atualiza.dat").
        IMPORT UNFORMATTED cDirAtu.
        INPUT CLOSE.

        ASSIGN FILE-INFO:FILE-NAME = cDirAtu + "\version"
               dtNew = FILE-INFO:FILE-MOD-DATE
               FILE-INFO:FILE-NAME = param-mn.prod-dir + "\version".
        IF FILE-INFO:FILE-MOD-DATE <> dtNew THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Atualizaá∆o Autom†tica (044)', INPUT 'Deseja atualizar o MHMoney 2005 ?', INPUT 'Existem atualizaá‰es recentes do MHMoney 2005. Se vocà responder SIM ser† aberto o programa de atualizaá∆o autom†tica.')"}
            IF RETURN-VALUE = "OK" THEN DO:
                {run_menu.i atualiza.w}  
            END.
        END.

    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Atualizaá∆o Autom†tica (044)', INPUT 'Deseja configurar atualizaá∆o autom†tica ?', INPUT 'O MHMoney 2005 possui um sistema de atualizaá∆o autom†tica para garantir que os programas estejam sempre em sua vers∆o mais atual. Ap¢s a configuraá∆o dessa funá∆o vocà ser† avisado sempre que existirem vers‰es mais atuais liberadas. Deseja configurar a atualizaá∆o autom†tica agora ?')"}
        IF RETURN-VALUE = "OK" THEN DO:
            {run_menu.i atualiza.w}  
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-01 C-Win 
PROCEDURE _graf-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND FIRST bf-conta NO-LOCK
        WHERE bf-conta.id-tipo = 1
        AND   bf-conta.id-encerrada = NO NO-ERROR.

    ASSIGN cParamRelat = "data-ini=" + STRING(DATE(MONTH(TODAY),1,YEAR(TODAY)),"99/99/9999") +
                         ",data-fim=" + STRING(TODAY,"99/99/9999") +
                         ",iConta=" + STRING(bf-conta.cd-conta).

    {func\returnGraf.i "graf\g001.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO
           tt-graf-par.titulo = tt-graf-par.titulo + " " + bf-conta.ds-conta.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-03 C-Win 
PROCEDURE _graf-03 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND FIRST bf-conta NO-LOCK
        WHERE bf-conta.id-tipo = 1
        AND   bf-conta.id-encerrada = NO NO-ERROR.

    ASSIGN cParamRelat = "data-ini=" + STRING(TODAY,"99/99/9999") +
                         ",data-fim=" + STRING(TODAY + 30,"99/99/9999") +
                         ",iConta=" + STRING(bf-conta.cd-conta).

    {func\returnGraf.i "graf\g003.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO
           tt-graf-par.titulo = tt-graf-par.titulo + " " + bf-conta.ds-conta.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-04 C-Win 
PROCEDURE _graf-04 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN (MONTH(TODAY) + 1) ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN (YEAR(TODAY) - 1) ELSE YEAR(TODAY)).

    ASSIGN cParamRelat = "mes-ini=" + STRING(MONTH(dtTemp),">9") +
                         ",ano-ini=" + STRING(YEAR(dtTemp),"9999") +
                         ",mes-fim=" + STRING(MONTH(TODAY),">9") +
                         ",ano-fim=" + STRING(YEAR(TODAY),"9999").

    {func\returnGraf.i "graf\g004.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-05 C-Win 
PROCEDURE _graf-05 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN MONTH(TODAY) + 1 ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN YEAR(TODAY) - 1 ELSE YEAR(TODAY)).

     ASSIGN cParamRelat = "mes-ini=" + STRING(MONTH(dtTemp),">9") +
                          ",ano-ini=" + STRING(YEAR(dtTemp),"9999").

    {func\returnGraf.i "graf\g005.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-15 C-Win 
PROCEDURE _graf-15 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO.

    IF (DAY(TODAY) MOD 2) = 0 THEN
        ASSIGN iTipo = 1.
    ELSE
        ASSIGN iTipo = 2.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN (MONTH(TODAY) + 1) ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN (YEAR(TODAY) - 1) ELSE YEAR(TODAY)).

    ASSIGN cParamRelat = "data-ini=" + STRING(dtTemp,"99/99/9999") +
                         ",data-fim=" + STRING(TODAY,"99/99/9999") +
                         ",tipo=" + STRING(iTipo).

    {func\returnGraf.i "graf\g015.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO
           tt-graf-par.titulo = tt-graf-par.titulo + " dos £ltimos 12 meses".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-16 C-Win 
PROCEDURE _graf-16 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO.

    IF (DAY(TODAY) MOD 2) = 0 THEN
        ASSIGN iTipo = 1.
    ELSE
        ASSIGN iTipo = 2.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN (MONTH(TODAY) + 1) ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN (YEAR(TODAY) - 1) ELSE YEAR(TODAY)).

    ASSIGN cParamRelat = "data-ini=" + STRING(dtTemp,"99/99/9999") +
                         ",data-fim=" + STRING(TODAY,"99/99/9999") +
                         ",tipo=" + STRING(iTipo).

    {func\returnGraf.i "graf\g016.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO
           tt-graf-par.titulo = tt-graf-par.titulo + " dos £ltimos 12 meses".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-17 C-Win 
PROCEDURE _graf-17 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO.

    IF (DAY(TODAY) MOD 2) = 0 THEN
        ASSIGN iTipo = 1.
    ELSE
        ASSIGN iTipo = 2.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN (MONTH(TODAY) + 1) ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN (YEAR(TODAY) - 1) ELSE YEAR(TODAY)).

    ASSIGN cParamRelat = "data-ini=" + STRING(dtTemp,"99/99/9999") +
                         ",data-fim=" + STRING(TODAY,"99/99/9999") +
                         ",tipo=" + STRING(iTipo).

    {func\returnGraf.i "graf\g017.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO
           tt-graf-par.titulo = tt-graf-par.titulo + " dos £ltimos 12 meses".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-18 C-Win 
PROCEDURE _graf-18 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN (MONTH(TODAY) + 1) ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN (YEAR(TODAY) - 1) ELSE YEAR(TODAY)).

    ASSIGN cParamRelat = "mes-ini=" + STRING(MONTH(dtTemp),">9") +
                         ",ano-ini=" + STRING(YEAR(dtTemp),"9999") +
                         ",mes-fim=" + STRING(MONTH(TODAY),">9") +
                         ",ano-fim=" + STRING(YEAR(TODAY),"9999").

    {func\returnGraf.i "graf\g018.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-19 C-Win 
PROCEDURE _graf-19 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.

    FIND LAST categoria.

    ASSIGN iAux = RANDOM(1, categoria.cod-categoria).

    REPEAT:
        FIND FIRST categoria
            WHERE categoria.cod-categoria = iAux NO-ERROR.
        IF AVAIL categoria THEN 
            LEAVE.
        ELSE
            ASSIGN iAux = iAux - 1.
    END.

    ASSIGN cParamRelat = "mes-ini=1,ano-ini=0001,mes-fim=12,ano-fim=9999,anual=YES" +
                         ",cat=" + STRING(iAux, ">>9").

    {func\returnGraf.i "graf\g019.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _graf-21 C-Win 
PROCEDURE _graf-21 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    ASSIGN dtTemp = DATE(IF MONTH(TODAY) <> 12 THEN (MONTH(TODAY) + 1) ELSE 1,
                         1,
                         IF MONTH(TODAY) <> 12 THEN (YEAR(TODAY) - 1) ELSE YEAR(TODAY)).

    ASSIGN cParamRelat = "mes-ini=" + STRING(MONTH(dtTemp),">9") +
                         ",ano-ini=" + STRING(YEAR(dtTemp),"9999") +
                         ",mes-fim=" + STRING(MONTH(TODAY),">9") +
                         ",ano-fim=" + STRING(YEAR(TODAY),"9999").

    {func\returnGraf.i "graf\g021.w"}

    ASSIGN cParamRelat = "".

    FIND FIRST tt-graf-par.
    ASSIGN tt-graf-par.mostra-valores[1] = NO
           tt-graf-par.mostra-valores[2] = NO
           tt-graf-par.mostra-valores[3] = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnGravaDado C-Win 
FUNCTION fnGravaDado RETURNS CHARACTER
  ( i-linha as int, i-coluna as int, c-valor as char, c-formato as CHAR ):

define var c-conversao  as char    no-undo init ?.
define var de-conversao as decimal no-undo init ?.
define var da-conversao as date    no-undo init ?.
define var i-conversao  as integer no-undo init ?.
def var l-ok as logi init no.

if length(c-valor) = 0 or c-formato = "@" then
    assign c-conversao = c-valor.
else do:
    assign de-conversao = decimal(c-valor) no-error.
    assign da-conversao = date(c-valor) no-error.
    assign i-conversao  = integer(c-valor) no-error.
    assign c-conversao  = c-valor no-error.
end.
if c-formato <> "" then
    chPlanilha:Cells(i-linha, i-coluna ):NumberFormat = c-formato.

if da-conversao <> ? then do:    
    if num-entries(c-valor,'/') > 1 then do:
        /* data */
        assign
            chPlanilha:Cells(i-linha, i-coluna ):Value = da-conversao            
            l-ok = yes.
    end.
end.
if de-conversao <> ? and l-ok = no then do:
      /*if decimal(c-valor) = integer(c-valor) then*/ 
      if de-conversao = i-conversao then
          /* inteiro */
          assign
            chPlanilha:Cells(i-linha, i-coluna ):Value = trim(string(i-conversao,"->>>>>>>>>>>>>>9"))
            l-ok = yes.

      else
          /* decimal */
          assign
            chPlanilha:Cells(i-linha, i-coluna ):Value = replace(trim(string(de-conversao,"->>>>>>>>>>>>>>9.<<<<<<<")),",",".")            
            l-ok = yes.

end.
if l-ok = no then do:
    /* caracter */
    assign
        chPlanilha:Cells(i-linha, i-coluna ):Value = c-conversao
        l-ok = yes.
end.

RETURN "".


END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnPerc C-Win 
FUNCTION fnPerc RETURNS CHARACTER
  ( iMoeda AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE BUFFER bf-cotacao FOR cotacao.
    DEFINE VARIABLE deValor AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE cReturn AS CHARACTER   NO-UNDO.

    FIND FIRST bf-cotacao NO-LOCK
        WHERE bf-cotacao.cd-moeda = iMoeda
        AND   bf-cotacao.dt-ini <= TODAY
        AND   bf-cotacao.dt-end >= TODAY NO-ERROR.
    IF AVAIL bf-cotacao THEN DO:
        
        ASSIGN deValor = bf-cotacao.valor.

        FIND FIRST bf-cotacao NO-LOCK
            WHERE bf-cotacao.cd-moeda = iMoeda
            AND   bf-cotacao.dt-end < TODAY NO-ERROR.
        IF AVAIL bf-cotacao THEN DO:

            ASSIGN cReturn = STRING(DEC(((deValor / bf-cotacao.valor) - 1) * 100),"->>>9.9999").

        END.

    END.

    IF cReturn = "" THEN DO:
        ASSIGN cReturn = "   +0.0000".
    END.
    IF NOT cReturn MATCHES("*-*")
    AND NOT cReturn MATCHES("*+*") THEN DO:
        ASSIGN cReturn = "   +" + TRIM(cReturn).
    END.
    ELSE DO:
        IF cReturn MATCHES("*-*") THEN DO:
            ASSIGN cReturn = "   " + TRIM(cReturn).
        END.
    END.

    ASSIGN cReturn = cReturn + " %".

    RETURN cReturn.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnUltCot C-Win 
FUNCTION fnUltCot RETURNS CHARACTER
  ( iMoeda AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE BUFFER bf-cotacao FOR cotacao.
    DEFINE VARIABLE cReturn AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE dtAux AS DATE    NO-UNDO.
    DEFINE VARIABLE iNumDias AS INTEGER     NO-UNDO.

    FIND FIRST bf-cotacao NO-LOCK
        WHERE bf-cotacao.cd-moeda = iMoeda
        AND   bf-cotacao.dt-ini <= TODAY
        AND   bf-cotacao.dt-end >= TODAY NO-ERROR.
    IF AVAIL bf-cotacao THEN DO:

        ASSIGN dtAux = bf-cotacao.dt-ini.

        FIND FIRST bf-cotacao NO-LOCK
            WHERE bf-cotacao.cd-moeda = iMoeda
            AND   bf-cotacao.dt-end < TODAY NO-ERROR.
        IF AVAIL bf-cotacao THEN DO:

            ASSIGN iNumDias = dtAux - bf-cotacao.dt-ini.

            IF iNumDias < 28 THEN DO:
                /* Cotaá∆o Di†ria */
                ASSIGN cReturn = STRING(dtAux,"99/99/9999").
            END.
            ELSE DO:
                /* Cotaá∆o Mensal */
                CASE MONTH(dtAux):
                    WHEN 1 THEN ASSIGN cReturn = "Jan".
                    WHEN 2 THEN ASSIGN cReturn = "Fev".
                    WHEN 3 THEN ASSIGN cReturn = "Mar".
                    WHEN 4 THEN ASSIGN cReturn = "Abr".
                    WHEN 5 THEN ASSIGN cReturn = "Mai".
                    WHEN 6 THEN ASSIGN cReturn = "Jun".
                    WHEN 7 THEN ASSIGN cReturn = "Jul".
                    WHEN 8 THEN ASSIGN cReturn = "Ago".
                    WHEN 9 THEN ASSIGN cReturn = "Set".
                    WHEN 10 THEN ASSIGN cReturn = "Out".
                    WHEN 11 THEN ASSIGN cReturn = "Nov".
                    WHEN 12 THEN ASSIGN cReturn = "Dez".
                END CASE.
                ASSIGN cReturn = cReturn + "/" + STRING(YEAR(dtAux),"9999").
            END.
        END.
        
    END.

    RETURN cReturn.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnVal-Total C-Win 
FUNCTION fnVal-Total RETURNS DECIMAL
  ( INPUT deValTotal AS DECIMAL ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF BUFFER bf-pedido FOR pedido.

  FOR EACH bf-pedido NO-LOCK
     WHERE bf-pedido.nr-pedido-ant = pedido.nr-pedido:

      ASSIGN deValTotal = deValTotal - bf-pedido.val-total. 
  END.

  RETURN deValTotal.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnValor C-Win 
FUNCTION fnValor RETURNS DECIMAL
  ( iConta AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.

    FIND FIRST bfConta WHERE bfConta.cd-conta = iConta NO-LOCK.

    ASSIGN deTemp = bfConta.vl-saldo.

    IF bfConta.id-tipo = 3
    AND NOT bfConta.dinheiro 
    AND bfConta.dt-saldo > TODAY THEN
        ASSIGN deTemp = 0.

    FOR EACH mov-conta
        WHERE mov-conta.cd-conta = iConta
        AND   mov-conta.id-situacao <> 3
        AND   mov-conta.agrupado = 0
        AND   mov-conta.dt-mov <= (IF (TODAY < bfConta.dt-saldo) THEN bfConta.dt-saldo ELSE TODAY)
        USE-INDEX compensado NO-LOCK:

        IF (TODAY < bfConta.dt-saldo) THEN DO:
            IF mov-conta.id-tipo <> 3 THEN
                ASSIGN deTemp = deTemp + mov-conta.de-valor.
            ELSE
                IF mov-conta.cd-favorecido <> bfConta.cd-fav-padrao THEN
                    IF ((-1) * bfConta.vl-saldo) <> mov-conta.de-valor THEN
                        ASSIGN deTemp = deTemp + mov-conta.de-valor.
        END.
        ELSE DO:
            ASSIGN deTemp = deTemp + mov-conta.de-valor.
        END.

    END.

    IF bfConta.cd-moeda <> 0 THEN DO:
        ASSIGN deTemp = fnCotacao(deTemp,bfConta.cd-moeda,0,TODAY).
    END.

    RETURN deTemp.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

