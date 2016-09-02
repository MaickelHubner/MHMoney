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

DEFINE NEW GLOBAL SHARED VAR r-pedido-item AS ROWID NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE glCompromisso AS LOGICAL     NO-UNDO.

{campos\situacao.i}

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE NEW GLOBAL SHARED VARIABLE r-apontamento AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-tarefa AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giNome      AS CHARACTER   NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSeqTar    AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-visita AS ROWID      NO-UNDO.

DEFINE VARIABLE cRowid AS CHAR.

DEFINE VARIABLE cAux AS CHARACTER FORMAT "X(39)"  NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER   NO-UNDO.
DEFINE VARIABLE deApont AS DECIMAL COLUMN-LABEL "Apont"    NO-UNDO.

{func\data.i}
{func\definitions.i}

DEFINE BUFFER bf-apontamento FOR apontamento.
DEFINE BUFFER bf-tarefa FOR tarefa.
DEFINE BUFFER bf-mov FOR mov-conta.

FORM apontamento.data AT 5
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont FORMAT "->>>9.99"
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 132 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-pedido. 

FORM apontamento.data AT 10
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont FORMAT "->>>9.99"
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 132 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-periodo.

FORM apontamento.nome AT 5
     apontamento.data
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont FORMAT "->>>9.99"
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 132 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-pedido-g. 

FORM apontamento.nome AT 10
     apontamento.data
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont FORMAT "->>>9.99"
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 132 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-periodo-g.

DEFINE TEMP-TABLE tt-un
    FIELD un AS CHAR
    FIELD qt AS DEC.
DEFINE TEMP-TABLE tt-ped LIKE tt-un.

{gerapend.i}

DEFINE VARIABLE cMotivo AS CHARACTER COLUMN-LABEL "Motivo" FORMAT "X(60)" NO-UNDO.

RUN aniversarios.w.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAgend

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES agenda agenda-valor apontamento mov-conta ~
favorecido categoria sub-cat visita pedido-item item pedido-item-usu ~
bf-apontamento pedido tt-pend tarefa ordem-serv usuario

/* Definitions for BROWSE brAgend                                       */
&Scoped-define FIELDS-IN-QUERY-brAgend agenda.prox-data-pag ~
fnMotivo(agenda.cod-categoria,agenda.cd-sub,agenda.cd-favorecido,"") @ cMotivo ~
IF agenda.vl-atual = 0 THEN (agenda-valor.valor * -1) ELSE (agenda.vl-atual * -1) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAgend 
&Scoped-define QUERY-STRING-brAgend FOR EACH agenda ~
      WHERE (agenda.usuar-resp = usuario.nome ~
 OR agenda.cd-favorecido = usuario.cd-favorecido) ~
 AND agenda.prox-data-pag <= agenda.dt-fim ~
 AND agenda.prox-data-pag >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND agenda.prox-data-pag <= INPUT FRAME {&FRAME-NAME} dt-fim ~
AND (agenda.cod-categoria = 0 ~
 OR (agenda.cod-categoria = 4 ~
 AND agenda.cd-sub <> 2 ~
 AND agenda.cd-sub <> 5 ~
 AND agenda.cd-sub <> 6 ~
 AND agenda.cd-sub <> 10 ~
 AND agenda.cd-sub <> 11) ~
 OR agenda.cod-categoria = 7) NO-LOCK, ~
      EACH agenda-valor WHERE agenda-valor.cd-agenda = agenda.cd-agenda ~
      AND agenda-valor.dt-ini <= agenda.prox-data-pag ~
 AND agenda-valor.dt-end >= agenda.prox-data-pag NO-LOCK ~
    BY agenda.prox-data-pag INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brAgend OPEN QUERY brAgend FOR EACH agenda ~
      WHERE (agenda.usuar-resp = usuario.nome ~
 OR agenda.cd-favorecido = usuario.cd-favorecido) ~
 AND agenda.prox-data-pag <= agenda.dt-fim ~
 AND agenda.prox-data-pag >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND agenda.prox-data-pag <= INPUT FRAME {&FRAME-NAME} dt-fim ~
AND (agenda.cod-categoria = 0 ~
 OR (agenda.cod-categoria = 4 ~
 AND agenda.cd-sub <> 2 ~
 AND agenda.cd-sub <> 5 ~
 AND agenda.cd-sub <> 6 ~
 AND agenda.cd-sub <> 10 ~
 AND agenda.cd-sub <> 11) ~
 OR agenda.cod-categoria = 7) NO-LOCK, ~
      EACH agenda-valor WHERE agenda-valor.cd-agenda = agenda.cd-agenda ~
      AND agenda-valor.dt-ini <= agenda.prox-data-pag ~
 AND agenda-valor.dt-end >= agenda.prox-data-pag NO-LOCK ~
    BY agenda.prox-data-pag INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brAgend agenda agenda-valor
&Scoped-define FIRST-TABLE-IN-QUERY-brAgend agenda
&Scoped-define SECOND-TABLE-IN-QUERY-brAgend agenda-valor


/* Definitions for BROWSE brApont                                       */
&Scoped-define FIELDS-IN-QUERY-brApont apontamento.data ~
apontamento.hora-ini apontamento.hora-fim apontamento.qt-apontada ~
apontamento.ds-apontamento 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brApont 
&Scoped-define QUERY-STRING-brApont FOR EACH apontamento ~
      WHERE apontamento.nr-pedido = pedido-item.nr-pedido ~
AND apontamento.sequencia = pedido-item.sequencia ~
AND apontamento.nome = cNome ~
AND apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini ~
AND apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim NO-LOCK ~
    BY apontamento.data DESCENDING ~
       BY apontamento.hora-ini DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brApont OPEN QUERY brApont FOR EACH apontamento ~
      WHERE apontamento.nr-pedido = pedido-item.nr-pedido ~
AND apontamento.sequencia = pedido-item.sequencia ~
AND apontamento.nome = cNome ~
AND apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini ~
AND apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim NO-LOCK ~
    BY apontamento.data DESCENDING ~
       BY apontamento.hora-ini DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brApont apontamento
&Scoped-define FIRST-TABLE-IN-QUERY-brApont apontamento


/* Definitions for BROWSE brApontProj                                   */
&Scoped-define FIELDS-IN-QUERY-brApontProj apontamento.nome ~
apontamento.data apontamento.hora-ini apontamento.hora-fim 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brApontProj 
&Scoped-define QUERY-STRING-brApontProj FOR EACH apontamento ~
      WHERE (IF AVAIL tarefa THEN apontamento.nome-tarefa = tarefa.nome ELSE FALSE) ~
 AND apontamento.seq-tarefa = tarefa.sequencia NO-LOCK ~
    BY apontamento.data DESCENDING ~
       BY apontamento.hora-ini DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brApontProj OPEN QUERY brApontProj FOR EACH apontamento ~
      WHERE (IF AVAIL tarefa THEN apontamento.nome-tarefa = tarefa.nome ELSE FALSE) ~
 AND apontamento.seq-tarefa = tarefa.sequencia NO-LOCK ~
    BY apontamento.data DESCENDING ~
       BY apontamento.hora-ini DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brApontProj apontamento
&Scoped-define FIRST-TABLE-IN-QUERY-brApontProj apontamento


/* Definitions for BROWSE brBenef                                       */
&Scoped-define FIELDS-IN-QUERY-brBenef mov-conta.dt-mov sub-cat.ds-sub ~
(mov-conta.de-valor * -1) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brBenef 
&Scoped-define QUERY-STRING-brBenef FOR EACH mov-conta ~
      WHERE mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND (mov-conta.cod-categoria = 4  ~
 AND (mov-conta.cd-sub = 2 ~
 OR mov-conta.cd-sub = 5 ~
 OR mov-conta.cd-sub = 6 ~
 OR mov-conta.cd-sub = 10 ~
 OR mov-conta.cd-sub = 11)) NO-LOCK, ~
      EACH favorecido OF mov-conta NO-LOCK, ~
      EACH categoria OF mov-conta NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brBenef OPEN QUERY brBenef FOR EACH mov-conta ~
      WHERE mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND (mov-conta.cod-categoria = 4  ~
 AND (mov-conta.cd-sub = 2 ~
 OR mov-conta.cd-sub = 5 ~
 OR mov-conta.cd-sub = 6 ~
 OR mov-conta.cd-sub = 10 ~
 OR mov-conta.cd-sub = 11)) NO-LOCK, ~
      EACH favorecido OF mov-conta NO-LOCK, ~
      EACH categoria OF mov-conta NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brBenef mov-conta favorecido categoria ~
sub-cat
&Scoped-define FIRST-TABLE-IN-QUERY-brBenef mov-conta
&Scoped-define SECOND-TABLE-IN-QUERY-brBenef favorecido
&Scoped-define THIRD-TABLE-IN-QUERY-brBenef categoria
&Scoped-define FOURTH-TABLE-IN-QUERY-brBenef sub-cat


/* Definitions for BROWSE brComp                                        */
&Scoped-define FIELDS-IN-QUERY-brComp visita.dt-visita visita.hora-inicio ~
visita.hora-fim fnSituacaoCompromisso(visita.situacao) @ cSituacao ~
visita.ds-visita 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brComp 
&Scoped-define QUERY-STRING-brComp FOR EACH visita ~
      WHERE visita.nome = gcUsuario ~
 AND visita.dt-visita >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND visita.dt-visita <= INPUT FRAME DEFAULT-FRAME dt-fim  ~
 AND visita.compromisso ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (visita.situacao < 8) ELSE TRUE) ~
 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brComp OPEN QUERY brComp FOR EACH visita ~
      WHERE visita.nome = gcUsuario ~
 AND visita.dt-visita >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND visita.dt-visita <= INPUT FRAME DEFAULT-FRAME dt-fim  ~
 AND visita.compromisso ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (visita.situacao < 8) ELSE TRUE) ~
 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brComp visita
&Scoped-define FIRST-TABLE-IN-QUERY-brComp visita


/* Definitions for BROWSE brDesp                                        */
&Scoped-define FIELDS-IN-QUERY-brDesp mov-conta.dt-mov ~
categoria.ds-categoria sub-cat.ds-sub (mov-conta.de-valor * -1) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brDesp 
&Scoped-define QUERY-STRING-brDesp FOR EACH mov-conta ~
      WHERE mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.id-tipo <> 0 ~
 AND mov-conta.cod-categoria <> 1 ~
 AND mov-conta.cod-categoria <> 4 ~
 AND mov-conta.cod-categoria <> 7 ~
 AND mov-conta.cod-categoria <> 11 ~
 AND mov-conta.cod-categoria <> 12 ~
 AND mov-conta.cod-categoria <> 13 ~
 NO-LOCK, ~
      EACH categoria OF mov-conta NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brDesp OPEN QUERY brDesp FOR EACH mov-conta ~
      WHERE mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.id-tipo <> 0 ~
 AND mov-conta.cod-categoria <> 1 ~
 AND mov-conta.cod-categoria <> 4 ~
 AND mov-conta.cod-categoria <> 7 ~
 AND mov-conta.cod-categoria <> 11 ~
 AND mov-conta.cod-categoria <> 12 ~
 AND mov-conta.cod-categoria <> 13 ~
 NO-LOCK, ~
      EACH categoria OF mov-conta NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brDesp mov-conta categoria sub-cat
&Scoped-define FIRST-TABLE-IN-QUERY-brDesp mov-conta
&Scoped-define SECOND-TABLE-IN-QUERY-brDesp categoria
&Scoped-define THIRD-TABLE-IN-QUERY-brDesp sub-cat


/* Definitions for BROWSE brItem                                        */
&Scoped-define FIELDS-IN-QUERY-brItem pedido-item.sequencia ~
pedido-item.ds-pedido-item pedido-item.qt-pedida pedido-item.qt-liberada ~
pedido-item.qt-atendida 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brItem 
&Scoped-define QUERY-STRING-brItem FOR EACH pedido-item ~
      WHERE pedido-item.nr-pedido = pedido.nr-pedido ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN pedido-item.situacao < 3 ELSE TRUE) NO-LOCK, ~
      EACH item OF pedido-item NO-LOCK, ~
      EACH pedido-item-usu OF pedido-item ~
      WHERE pedido-item-usu.nome = gcUsuario NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brItem OPEN QUERY brItem FOR EACH pedido-item ~
      WHERE pedido-item.nr-pedido = pedido.nr-pedido ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN pedido-item.situacao < 3 ELSE TRUE) NO-LOCK, ~
      EACH item OF pedido-item NO-LOCK, ~
      EACH pedido-item-usu OF pedido-item ~
      WHERE pedido-item-usu.nome = gcUsuario NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brItem pedido-item item pedido-item-usu
&Scoped-define FIRST-TABLE-IN-QUERY-brItem pedido-item
&Scoped-define SECOND-TABLE-IN-QUERY-brItem item
&Scoped-define THIRD-TABLE-IN-QUERY-brItem pedido-item-usu


/* Definitions for BROWSE brMov                                         */
&Scoped-define FIELDS-IN-QUERY-brMov mov-conta.dt-mov ~
fnMotivo(mov-conta.cod-categoria,mov-conta.cd-sub,mov-conta.cd-favorecido,mov-conta.ds-observacao) @ cMotivo ~
(mov-conta.de-valor * -1) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brMov 
&Scoped-define QUERY-STRING-brMov FOR EACH mov-conta ~
      WHERE (mov-conta.cd-conta = 1 OR mov-conta.cd-conta = 4) ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.id-tipo <> 0 ~
 AND mov-conta.cd-conta <> 5 ~
 AND mov-conta.cd-conta <> 8 ~
 AND (mov-conta.cod-categoria = 0 ~
 OR (mov-conta.cod-categoria = 4 ~
 AND mov-conta.cd-sub <> 2 ~
 AND mov-conta.cd-sub <> 5 ~
 AND mov-conta.cd-sub <> 6 ~
 AND mov-conta.cd-sub <> 10 ~
 AND mov-conta.cd-sub <> 11) ~
 OR mov-conta.cod-categoria = 7) ~
 AND (mov-conta.usuar-resp = usuario.nome ~
 OR mov-conta.cd-favorecido = usuario.cd-favorecido) NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brMov OPEN QUERY brMov FOR EACH mov-conta ~
      WHERE (mov-conta.cd-conta = 1 OR mov-conta.cd-conta = 4) ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.id-tipo <> 0 ~
 AND mov-conta.cd-conta <> 5 ~
 AND mov-conta.cd-conta <> 8 ~
 AND (mov-conta.cod-categoria = 0 ~
 OR (mov-conta.cod-categoria = 4 ~
 AND mov-conta.cd-sub <> 2 ~
 AND mov-conta.cd-sub <> 5 ~
 AND mov-conta.cd-sub <> 6 ~
 AND mov-conta.cd-sub <> 10 ~
 AND mov-conta.cd-sub <> 11) ~
 OR mov-conta.cod-categoria = 7) ~
 AND (mov-conta.usuar-resp = usuario.nome ~
 OR mov-conta.cd-favorecido = usuario.cd-favorecido) NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brMov mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-brMov mov-conta


/* Definitions for BROWSE brOutros                                      */
&Scoped-define FIELDS-IN-QUERY-brOutros bf-apontamento.nome bf-apontamento.data bf-apontamento.hora-ini bf-apontamento.hora-fim bf-apontamento.qt-apontada bf-apontamento.ds-apontamento   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brOutros   
&Scoped-define SELF-NAME brOutros
&Scoped-define QUERY-STRING-brOutros FOR EACH bf-apontamento       WHERE bf-apontamento.nr-pedido = pedido-item.nr-pedido AND bf-apontamento.sequencia = pedido-item.sequencia AND bf-apontamento.nome <> cNome AND bf-apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini AND bf-apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim NO-LOCK     BY bf-apontamento.data INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brOutros OPEN QUERY {&SELF-NAME} FOR EACH bf-apontamento       WHERE bf-apontamento.nr-pedido = pedido-item.nr-pedido AND bf-apontamento.sequencia = pedido-item.sequencia AND bf-apontamento.nome <> cNome AND bf-apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini AND bf-apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim NO-LOCK     BY bf-apontamento.data INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brOutros bf-apontamento
&Scoped-define FIRST-TABLE-IN-QUERY-brOutros bf-apontamento


/* Definitions for BROWSE brPed                                         */
&Scoped-define FIELDS-IN-QUERY-brPed pedido.nr-pedido favorecido.ds-favorecido pedido.dt-pedido fnSituacao(pedido.situacao) @ cSituacao pedido.nom-projeto pedido.val-total   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPed   
&Scoped-define SELF-NAME brPed
&Scoped-define OPEN-QUERY-brPed RUN pesq_ped. OPEN QUERY {&SELF-NAME} FOR EACH pedido       WHERE LOOKUP(STRING(ROWID(pedido)), ~
       cRowid) <> 0 NO-LOCK, ~
             FIRST favorecido OF pedido NO-LOCK       INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brPed pedido favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-brPed pedido
&Scoped-define SECOND-TABLE-IN-QUERY-brPed favorecido


/* Definitions for BROWSE brPendAtras                                   */
&Scoped-define FIELDS-IN-QUERY-brPendAtras tt-pend.dt-pend tt-pend.tipo tt-pend.ds-pend   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPendAtras   
&Scoped-define SELF-NAME brPendAtras
&Scoped-define QUERY-STRING-brPendAtras FOR EACH tt-pend WHERE tt-pend.dt-pend < TODAY
&Scoped-define OPEN-QUERY-brPendAtras OPEN QUERY {&SELF-NAME} FOR EACH tt-pend WHERE tt-pend.dt-pend < TODAY.
&Scoped-define TABLES-IN-QUERY-brPendAtras tt-pend
&Scoped-define FIRST-TABLE-IN-QUERY-brPendAtras tt-pend


/* Definitions for BROWSE brPendFut                                     */
&Scoped-define FIELDS-IN-QUERY-brPendFut tt-pend.dt-pend tt-pend.tipo tt-pend.ds-pend   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPendFut   
&Scoped-define SELF-NAME brPendFut
&Scoped-define QUERY-STRING-brPendFut FOR EACH tt-pend WHERE tt-pend.dt-pend > TODAY
&Scoped-define OPEN-QUERY-brPendFut OPEN QUERY {&SELF-NAME} FOR EACH tt-pend WHERE tt-pend.dt-pend > TODAY.
&Scoped-define TABLES-IN-QUERY-brPendFut tt-pend
&Scoped-define FIRST-TABLE-IN-QUERY-brPendFut tt-pend


/* Definitions for BROWSE brPendHoje                                    */
&Scoped-define FIELDS-IN-QUERY-brPendHoje tt-pend.dt-pend tt-pend.tipo tt-pend.ds-pend   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPendHoje   
&Scoped-define SELF-NAME brPendHoje
&Scoped-define QUERY-STRING-brPendHoje FOR EACH tt-pend WHERE tt-pend.dt-pend = TODAY
&Scoped-define OPEN-QUERY-brPendHoje OPEN QUERY {&SELF-NAME} FOR EACH tt-pend WHERE tt-pend.dt-pend = TODAY.
&Scoped-define TABLES-IN-QUERY-brPendHoje tt-pend
&Scoped-define FIRST-TABLE-IN-QUERY-brPendHoje tt-pend


/* Definitions for BROWSE brTarCRM                                      */
&Scoped-define FIELDS-IN-QUERY-brTarCRM tarefa.dt-alert-tarefa ~
favorecido.ds-favorecido tarefa.ds-tarefa ~
fnSituacaoTarefa(tarefa.situacao) @ cSituacao tarefa.perc-con 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTarCRM 
&Scoped-define QUERY-STRING-brTarCRM FOR EACH tarefa ~
      WHERE tarefa.responsavel = gcUsuario ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (tarefa.situacao < 8) ELSE TRUE) ~
 AND tarefa.num-os = 0 ~
 AND tarefa.dt-alert-tarefa >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND tarefa.dt-alert-tarefa <= INPUT FRAME DEFAULT-FRAME dt-fim NO-LOCK, ~
      EACH favorecido OF tarefa NO-LOCK ~
    BY tarefa.dt-alert-tarefa INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brTarCRM OPEN QUERY brTarCRM FOR EACH tarefa ~
      WHERE tarefa.responsavel = gcUsuario ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (tarefa.situacao < 8) ELSE TRUE) ~
 AND tarefa.num-os = 0 ~
 AND tarefa.dt-alert-tarefa >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND tarefa.dt-alert-tarefa <= INPUT FRAME DEFAULT-FRAME dt-fim NO-LOCK, ~
      EACH favorecido OF tarefa NO-LOCK ~
    BY tarefa.dt-alert-tarefa INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brTarCRM tarefa favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-brTarCRM tarefa
&Scoped-define SECOND-TABLE-IN-QUERY-brTarCRM favorecido


/* Definitions for BROWSE brTarOS                                       */
&Scoped-define FIELDS-IN-QUERY-brTarOS tarefa.prioridade ~
tarefa.data-prev-ini tarefa.data-prev-fim tarefa.qtd-lib ~
fnApontTar(tarefa.nome, tarefa.sequencia) @ deApont tarefa.perc-con ~
favorecido.ds-favorecido tarefa.ds-tarefa ~
fnSituacaoTarefa(tarefa.situacao) @ cSituacao tarefa.num-os ~
ordem-serv.ds-os 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTarOS 
&Scoped-define QUERY-STRING-brTarOS FOR EACH tarefa ~
      WHERE tarefa.responsavel = gcUsuario ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (tarefa.situacao < 8) ELSE TRUE) ~
 AND tarefa.num-os <> 0 ~
 AND tarefa.data-prev-ini >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND tarefa.data-prev-ini <= INPUT FRAME DEFAULT-FRAME dt-fim NO-LOCK, ~
      EACH favorecido OF tarefa NO-LOCK, ~
      EACH ordem-serv OF tarefa NO-LOCK ~
    BY tarefa.prioridade ~
       BY tarefa.data-prev-ini INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brTarOS OPEN QUERY brTarOS FOR EACH tarefa ~
      WHERE tarefa.responsavel = gcUsuario ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (tarefa.situacao < 8) ELSE TRUE) ~
 AND tarefa.num-os <> 0 ~
 AND tarefa.data-prev-ini >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND tarefa.data-prev-ini <= INPUT FRAME DEFAULT-FRAME dt-fim NO-LOCK, ~
      EACH favorecido OF tarefa NO-LOCK, ~
      EACH ordem-serv OF tarefa NO-LOCK ~
    BY tarefa.prioridade ~
       BY tarefa.data-prev-ini INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brTarOS tarefa favorecido ordem-serv
&Scoped-define FIRST-TABLE-IN-QUERY-brTarOS tarefa
&Scoped-define SECOND-TABLE-IN-QUERY-brTarOS favorecido
&Scoped-define THIRD-TABLE-IN-QUERY-brTarOS ordem-serv


/* Definitions for BROWSE brTre                                         */
&Scoped-define FIELDS-IN-QUERY-brTre mov-conta.dt-mov (de-valor * -1) ~
mov-conta.ds-observacao 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTre 
&Scoped-define QUERY-STRING-brTre FOR EACH mov-conta ~
      WHERE mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.cod-categoria = 12 ~
 AND mov-conta.cd-sub = 1 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brTre OPEN QUERY brTre FOR EACH mov-conta ~
      WHERE mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome ~
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.cod-categoria = 12 ~
 AND mov-conta.cd-sub = 1 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brTre mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-brTre mov-conta


/* Definitions for BROWSE brViag                                        */
&Scoped-define FIELDS-IN-QUERY-brViag mov-conta.dt-mov sub-cat.ds-sub ~
(mov-conta.de-valor * -1) mov-conta.ds-observacao 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brViag 
&Scoped-define QUERY-STRING-brViag FOR EACH mov-conta ~
      WHERE mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.cod-categoria = 11 NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK, ~
      EACH favorecido OF mov-conta NO-LOCK, ~
      EACH usuario OF favorecido ~
      WHERE usuario.nome = gcUsuario NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brViag OPEN QUERY brViag FOR EACH mov-conta ~
      WHERE mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini ~
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim ~
 AND mov-conta.cod-categoria = 11 NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK, ~
      EACH favorecido OF mov-conta NO-LOCK, ~
      EACH usuario OF favorecido ~
      WHERE usuario.nome = gcUsuario NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brViag mov-conta sub-cat favorecido usuario
&Scoped-define FIRST-TABLE-IN-QUERY-brViag mov-conta
&Scoped-define SECOND-TABLE-IN-QUERY-brViag sub-cat
&Scoped-define THIRD-TABLE-IN-QUERY-brViag favorecido
&Scoped-define FOURTH-TABLE-IN-QUERY-brViag usuario


/* Definitions for BROWSE brVisita                                      */
&Scoped-define FIELDS-IN-QUERY-brVisita visita.dt-visita ~
favorecido.ds-favorecido visita.hora-inicio visita.hora-fim ~
fnSituacaoVisita(visita.situacao) @ cSituacao visita.ds-visita 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brVisita 
&Scoped-define QUERY-STRING-brVisita FOR EACH visita ~
      WHERE visita.nome = gcUsuario ~
 AND visita.dt-visita >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND visita.dt-visita <= INPUT FRAME DEFAULT-FRAME dt-fim  ~
 AND NOT visita.compromisso ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (visita.situacao < 8) ELSE TRUE) ~
 NO-LOCK, ~
      EACH favorecido OF visita NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brVisita OPEN QUERY brVisita FOR EACH visita ~
      WHERE visita.nome = gcUsuario ~
 AND visita.dt-visita >= INPUT FRAME DEFAULT-FRAME dt-ini ~
 AND visita.dt-visita <= INPUT FRAME DEFAULT-FRAME dt-fim  ~
 AND NOT visita.compromisso ~
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (visita.situacao < 8) ELSE TRUE) ~
 NO-LOCK, ~
      EACH favorecido OF visita NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brVisita visita favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-brVisita visita
&Scoped-define SECOND-TABLE-IN-QUERY-brVisita favorecido


/* Definitions for FRAME fApont                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fApont ~
    ~{&OPEN-QUERY-brApont}~
    ~{&OPEN-QUERY-brItem}~
    ~{&OPEN-QUERY-brOutros}~
    ~{&OPEN-QUERY-brPed}

/* Definitions for FRAME fBen                                           */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fBen ~
    ~{&OPEN-QUERY-brBenef}~
    ~{&OPEN-QUERY-brDesp}~
    ~{&OPEN-QUERY-brTre}~
    ~{&OPEN-QUERY-brViag}

/* Definitions for FRAME fGer                                           */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fGer ~
    ~{&OPEN-QUERY-brPendAtras}~
    ~{&OPEN-QUERY-brPendFut}~
    ~{&OPEN-QUERY-brPendHoje}

/* Definitions for FRAME fPagto                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPagto ~
    ~{&OPEN-QUERY-brAgend}~
    ~{&OPEN-QUERY-brMov}

/* Definitions for FRAME fProj                                          */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fProj ~
    ~{&OPEN-QUERY-brApontProj}~
    ~{&OPEN-QUERY-brTarOS}

/* Definitions for FRAME fTar                                           */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fTar ~
    ~{&OPEN-QUERY-brComp}~
    ~{&OPEN-QUERY-brTarCRM}~
    ~{&OPEN-QUERY-brVisita}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS favorecido.ds-favorecido favorecido.data-nasc 
&Scoped-define ENABLED-TABLES favorecido
&Scoped-define FIRST-ENABLED-TABLE favorecido
&Scoped-Define ENABLED-OBJECTS dt-ini dt-fim l-pend btRelApont btRelPeR ~
btRelPeR-2 btGeral btApont btProj btTar btPagtos btBen btRelRes RECT-7 ~
IMAGE-1 IMAGE-2 IMAGE-3 IMAGE-4 
&Scoped-Define DISPLAYED-FIELDS favorecido.ds-favorecido ~
favorecido.data-nasc 
&Scoped-define DISPLAYED-TABLES favorecido
&Scoped-define FIRST-DISPLAYED-TABLE favorecido
&Scoped-Define DISPLAYED-OBJECTS dt-ini dt-fim l-pend cNome 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnApontTar C-Win 
FUNCTION fnApontTar RETURNS DECIMAL
  ( cNome AS CHAR, iSeq AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnMotivo C-Win 
FUNCTION fnMotivo RETURNS CHARACTER
  ( iCat AS INT, iSub AS INT, iFav AS INT, cObs AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.
DEFINE VARIABLE CtrlFrame-2 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-2 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btApont 
     LABEL "Pedidos" 
     SIZE 15 BY 1.13.

DEFINE BUTTON btBen 
     LABEL "Benef°cios" 
     SIZE 15 BY 1.13.

DEFINE BUTTON btGeral 
     LABEL "Vis∆o Geral" 
     SIZE 15 BY 1.13.

DEFINE BUTTON btPagtos 
     LABEL "Pagamentos" 
     SIZE 15 BY 1.13.

DEFINE BUTTON btProj 
     LABEL "Projetos" 
     SIZE 15 BY 1.13.

DEFINE BUTTON btRelApont 
     LABEL "Apont" 
     SIZE 10 BY 1.

DEFINE BUTTON btRelPeR 
     LABEL "Relat¢rio" 
     SIZE 10 BY 1.

DEFINE BUTTON btRelPeR-2 
     LABEL "Geral" 
     SIZE 10 BY 1.

DEFINE BUTTON btRelRes 
     LABEL "Resumo" 
     SIZE 10 BY 1.

DEFINE BUTTON btTar 
     LABEL "Adm/Comercial" 
     SIZE 15 BY 1.13.

DEFINE VARIABLE cNome AS CHARACTER FORMAT "X(8)" 
     LABEL "Usu†rio" 
      VIEW-AS TEXT 
     SIZE 11 BY .67.

DEFINE VARIABLE dt-fim AS DATE FORMAT "99/99/9999" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79.

DEFINE VARIABLE dt-ini AS DATE FORMAT "99/99/9999" 
     LABEL "Per°odo" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79.

DEFINE IMAGE IMAGE-1
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-2
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-3
     FILENAME "\\10.0.0.101\Marketing\Logo\logo_otima_money.bmp":U
     STRETCH-TO-FIT
     SIZE 23 BY 3.

DEFINE IMAGE IMAGE-4
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 18 BY 5.5.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130 BY 6.

DEFINE VARIABLE l-pend AS LOGICAL INITIAL yes 
     LABEL "Somente Pendentes" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .83 NO-UNDO.

DEFINE BUTTON btAnexos 
     LABEL "Anexos" 
     SIZE 10 BY 1.

DEFINE BUTTON btEli 
     LABEL "Eliminar" 
     SIZE 10 BY 1.

DEFINE BUTTON btInc 
     LABEL "Incluir" 
     SIZE 10 BY 1.

DEFINE BUTTON btMod 
     LABEL "Modificar" 
     SIZE 10 BY 1.

DEFINE BUTTON btRelPed 
     LABEL "Relat¢rio" 
     SIZE 10 BY 1.

DEFINE BUTTON btRelPed-2 
     LABEL "Geral" 
     SIZE 10 BY 1.

DEFINE VARIABLE deTotM AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total Meus" 
      VIEW-AS TEXT 
     SIZE 10.57 BY .67 NO-UNDO.

DEFINE VARIABLE deTotO AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total Outros" 
      VIEW-AS TEXT 
     SIZE 10.57 BY .67 NO-UNDO.

DEFINE VARIABLE de-tot-reemb AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total de Reembolsos" 
     VIEW-AS FILL-IN 
     SIZE 11.86 BY .79 NO-UNDO.

DEFINE VARIABLE de-fat AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Faturamento" 
      VIEW-AS TEXT 
     SIZE 12 BY .67 NO-UNDO.

DEFINE VARIABLE de-lucr AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Lucro" 
      VIEW-AS TEXT 
     SIZE 12 BY .67 NO-UNDO.

DEFINE VARIABLE de-ppr AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "PPR Estimado" 
      VIEW-AS TEXT 
     SIZE 12 BY .67
     FGCOLOR 9  NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT
     SIZE 75 BY 8.25.

DEFINE VARIABLE de-tot-agend AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     LABEL "Total Agendamentos Programados" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-pag AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     LABEL "Total Pagamentos Efetuados" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY .79 NO-UNDO.

DEFINE BUTTON btAtu 
     LABEL "Atualizar" 
     SIZE 10 BY 1.

DEFINE BUTTON btEliProj 
     LABEL "Eliminar" 
     SIZE 10 BY 1.

DEFINE BUTTON btIncProj 
     LABEL "Incluir" 
     SIZE 10 BY 1.

DEFINE BUTTON btModProj 
     LABEL "Modificar" 
     SIZE 10 BY 1.

DEFINE BUTTON btMovDown 
     LABEL "- Prioridade" 
     SIZE 10 BY 1.

DEFINE BUTTON btMoveUp 
     LABEL "+ Prioridade" 
     SIZE 10 BY 1.

DEFINE BUTTON btRecalc 
     LABEL "Recalcular" 
     SIZE 10 BY 1.

DEFINE VARIABLE obs-apont-proj AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 35 BY 5.25 NO-UNDO.

DEFINE VARIABLE obs-tar-proj AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 76 BY 3.25 NO-UNDO.

DEFINE VARIABLE carga AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Carga Total (Hrs)" 
     VIEW-AS FILL-IN 
     SIZE 10.57 BY .79 NO-UNDO.

DEFINE BUTTON btDesp 
     LABEL "Despesas" 
     SIZE 10 BY 1.

DEFINE BUTTON btEliComp 
     LABEL "Eliminar" 
     SIZE 10 BY 1.

DEFINE BUTTON btEliTar 
     LABEL "Eliminar" 
     SIZE 10 BY 1.

DEFINE BUTTON btEliVis 
     LABEL "Eliminar" 
     SIZE 10 BY 1.

DEFINE BUTTON btIncComp 
     LABEL "Incluir" 
     SIZE 10 BY 1.

DEFINE BUTTON btIncTar 
     LABEL "Incluir" 
     SIZE 10 BY 1.

DEFINE BUTTON btIncVis 
     LABEL "Incluir" 
     SIZE 10 BY 1.

DEFINE BUTTON btModComp 
     LABEL "Modificar" 
     SIZE 10 BY 1.

DEFINE BUTTON btModTar 
     LABEL "Modificar" 
     SIZE 10 BY 1.

DEFINE BUTTON btModVis 
     LABEL "Modificar" 
     SIZE 10 BY 1.

DEFINE VARIABLE obs-comp AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 55 BY 4.25 NO-UNDO.

DEFINE VARIABLE obs-tar AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 56 BY 4.25 NO-UNDO.

DEFINE VARIABLE obs-vis AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 55 BY 4.25 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAgend FOR 
      agenda, 
      agenda-valor SCROLLING.

DEFINE QUERY brApont FOR 
      apontamento SCROLLING.

DEFINE QUERY brApontProj FOR 
      apontamento SCROLLING.

DEFINE QUERY brBenef FOR 
      mov-conta, 
      favorecido, 
      categoria, 
      sub-cat SCROLLING.

DEFINE QUERY brComp FOR 
      visita SCROLLING.

DEFINE QUERY brDesp FOR 
      mov-conta, 
      categoria, 
      sub-cat SCROLLING.

DEFINE QUERY brItem FOR 
      pedido-item, 
      item, 
      pedido-item-usu SCROLLING.

DEFINE QUERY brMov FOR 
      mov-conta SCROLLING.

DEFINE QUERY brOutros FOR 
      bf-apontamento SCROLLING.

DEFINE QUERY brPed FOR 
      pedido, 
      favorecido SCROLLING.

DEFINE QUERY brPendAtras FOR 
      tt-pend SCROLLING.

DEFINE QUERY brPendFut FOR 
      tt-pend SCROLLING.

DEFINE QUERY brPendHoje FOR 
      tt-pend SCROLLING.

DEFINE QUERY brTarCRM FOR 
      tarefa, 
      favorecido SCROLLING.

DEFINE QUERY brTarOS FOR 
      tarefa, 
      favorecido, 
      ordem-serv SCROLLING.

DEFINE QUERY brTre FOR 
      mov-conta SCROLLING.

DEFINE QUERY brViag FOR 
      mov-conta, 
      sub-cat, 
      favorecido, 
      usuario SCROLLING.

DEFINE QUERY brVisita FOR 
      visita, 
      favorecido SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAgend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAgend C-Win _STRUCTURED
  QUERY brAgend NO-LOCK DISPLAY
      agenda.prox-data-pag COLUMN-LABEL "Data" FORMAT "99/99/9999":U
      fnMotivo(agenda.cod-categoria,agenda.cd-sub,agenda.cd-favorecido,"") @ cMotivo
      IF agenda.vl-atual = 0 THEN (agenda-valor.valor * -1) ELSE (agenda.vl-atual * -1) COLUMN-LABEL "Valor" FORMAT "->>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 55.43 BY 15.75
         FONT 1
         TITLE "Pagamentos e Benef°cios Agendados".

DEFINE BROWSE brApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brApont C-Win _STRUCTURED
  QUERY brApont NO-LOCK DISPLAY
      apontamento.data FORMAT "99/99/9999":U
      apontamento.hora-ini FORMAT "x(5)":U
      apontamento.hora-fim FORMAT "x(5)":U
      apontamento.qt-apontada COLUMN-LABEL "Qtde" FORMAT "->>,>>9.99":U
      apontamento.ds-apontamento FORMAT "x(80)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 49 BY 10
         FONT 1
         TITLE "Meus Apontamentos".

DEFINE BROWSE brApontProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brApontProj C-Win _STRUCTURED
  QUERY brApontProj NO-LOCK DISPLAY
      apontamento.nome FORMAT "X(8)":U WIDTH 10
      apontamento.data FORMAT "99/99/9999":U
      apontamento.hora-ini FORMAT "x(5)":U WIDTH 6
      apontamento.hora-fim FORMAT "x(5)":U WIDTH 6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 35 BY 10.5
         FONT 1
         TITLE "Apontamentos da Tarefa".

DEFINE BROWSE brBenef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brBenef C-Win _STRUCTURED
  QUERY brBenef NO-LOCK DISPLAY
      mov-conta.dt-mov FORMAT "99/99/9999":U
      sub-cat.ds-sub COLUMN-LABEL "Benef°cio" FORMAT "X(40)":U
            WIDTH 20
      (mov-conta.de-valor * -1) COLUMN-LABEL "Valor" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.72
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 48 BY 11.25
         FONT 1
         TITLE "Benef°cios Recebidos".

DEFINE BROWSE brComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brComp C-Win _STRUCTURED
  QUERY brComp NO-LOCK DISPLAY
      visita.dt-visita FORMAT "99/99/9999":U
      visita.hora-inicio FORMAT "x(5)":U
      visita.hora-fim FORMAT "x(5)":U
      fnSituacaoCompromisso(visita.situacao) @ cSituacao COLUMN-LABEL "Situaá∆o"
            WIDTH 8
      visita.ds-visita FORMAT "x(80)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 55 BY 3.75
         FONT 1
         TITLE "Meus Compromissos".

DEFINE BROWSE brDesp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brDesp C-Win _STRUCTURED
  QUERY brDesp NO-LOCK DISPLAY
      mov-conta.dt-mov FORMAT "99/99/9999":U
      categoria.ds-categoria COLUMN-LABEL "Despesa" FORMAT "X(40)":U
            WIDTH 19
      sub-cat.ds-sub COLUMN-LABEL "" FORMAT "X(40)":U WIDTH 19
      (mov-conta.de-valor * -1) COLUMN-LABEL "Valor" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.72
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 63 BY 7.5
         FONT 1
         TITLE "Outras Despesas Reembolsadas".

DEFINE BROWSE brItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brItem C-Win _STRUCTURED
  QUERY brItem NO-LOCK DISPLAY
      pedido-item.sequencia FORMAT ">>>9":U
      pedido-item.ds-pedido-item COLUMN-LABEL "Item" FORMAT "x(40)":U
            WIDTH 16
      pedido-item.qt-pedida FORMAT "->>,>>9.99":U
      pedido-item.qt-liberada FORMAT "->>,>>9.99":U
      pedido-item.qt-atendida FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 49 BY 4.5
         FONT 1
         TITLE "Itens do Pedido Liberados".

DEFINE BROWSE brMov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brMov C-Win _STRUCTURED
  QUERY brMov NO-LOCK DISPLAY
      mov-conta.dt-mov FORMAT "99/99/9999":U
      fnMotivo(mov-conta.cod-categoria,mov-conta.cd-sub,mov-conta.cd-favorecido,mov-conta.ds-observacao) @ cMotivo
      (mov-conta.de-valor * -1) COLUMN-LABEL "Valor" FORMAT "->>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 55.43 BY 15.75
         FONT 1
         TITLE "Pagamentos Efetuados".

DEFINE BROWSE brOutros
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brOutros C-Win _FREEFORM
  QUERY brOutros NO-LOCK DISPLAY
      bf-apontamento.nome FORMAT "X(8)":U WIDTH 10
      bf-apontamento.data FORMAT "99/99/9999":U
      bf-apontamento.hora-ini FORMAT "x(5)":U
      bf-apontamento.hora-fim FORMAT "x(5)":U
      bf-apontamento.qt-apontada COLUMN-LABEL "Qtde" FORMAT "->>,>>9.99":U
      bf-apontamento.ds-apontamento FORMAT "X(80)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 62 BY 5.25
         FONT 1
         TITLE "Outros Apontamentos".

DEFINE BROWSE brPed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPed C-Win _FREEFORM
  QUERY brPed NO-LOCK DISPLAY
      pedido.nr-pedido FORMAT ">>>>,>>9":U
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 10
      pedido.dt-pedido FORMAT "99/99/9999":U
      fnSituacao(pedido.situacao) @ cSituacao
      pedido.nom-projeto FORMAT "x(80)":U
      pedido.val-total FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 62 BY 10.25
         FONT 1
         TITLE "Pedidos Liberados".

DEFINE BROWSE brPendAtras
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPendAtras C-Win _FREEFORM
  QUERY brPendAtras NO-LOCK DISPLAY
      tt-pend.dt-pend
 tt-pend.tipo
 tt-pend.ds-pend
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ASSIGN MULTIPLE SIZE 36 BY 3.5
         FGCOLOR 12 FONT 1
         TITLE FGCOLOR 12 "Em Atraso".

DEFINE BROWSE brPendFut
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPendFut C-Win _FREEFORM
  QUERY brPendFut NO-LOCK DISPLAY
      tt-pend.dt-pend
 tt-pend.tipo
 tt-pend.ds-pend
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ASSIGN MULTIPLE SIZE 75 BY 8.25
         FONT 1
         TITLE "Pendàncias Futuras".

DEFINE BROWSE brPendHoje
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPendHoje C-Win _FREEFORM
  QUERY brPendHoje NO-LOCK DISPLAY
      tt-pend.dt-pend
 tt-pend.tipo
 tt-pend.ds-pend
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ASSIGN MULTIPLE SIZE 36 BY 3.5
         FONT 1
         TITLE "Hoje".

DEFINE BROWSE brTarCRM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTarCRM C-Win _STRUCTURED
  QUERY brTarCRM NO-LOCK DISPLAY
      tarefa.dt-alert-tarefa FORMAT "99/99/9999":U
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 12
      tarefa.ds-tarefa FORMAT "x(40)":U
      fnSituacaoTarefa(tarefa.situacao) @ cSituacao WIDTH 12
      tarefa.perc-con FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 56 BY 11.5
         FONT 1
         TITLE "Minhas Tarefas".

DEFINE BROWSE brTarOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTarOS C-Win _STRUCTURED
  QUERY brTarOS NO-LOCK DISPLAY
      tarefa.prioridade FORMAT ">>>>>9":U WIDTH 3
      tarefa.data-prev-ini COLUMN-LABEL "Dt Prev Ini" FORMAT "99/99/9999":U
            WIDTH 9
      tarefa.data-prev-fim COLUMN-LABEL "Dt Prev Fim" FORMAT "99/99/9999":U
            WIDTH 9
      tarefa.qtd-lib COLUMN-LABEL "Hrs" FORMAT "->>,>>9.99":U WIDTH 5
      fnApontTar(tarefa.nome, tarefa.sequencia) @ deApont COLUMN-LABEL "Apont" FORMAT "->>,>>9.99":U
            WIDTH 5
      tarefa.perc-con COLUMN-LABEL "% Con" FORMAT "->>,>>9.99":U
            WIDTH 5
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 12
      tarefa.ds-tarefa FORMAT "x(40)":U WIDTH 23
      fnSituacaoTarefa(tarefa.situacao) @ cSituacao WIDTH 12
      tarefa.num-os COLUMN-LABEL "OS" FORMAT "999999":U WIDTH 5
      ordem-serv.ds-os COLUMN-LABEL "Descriá∆o OS" FORMAT "x(40)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 76 BY 12.5
         FONT 1
         TITLE "Minhas Tarefas de Projeto".

DEFINE BROWSE brTre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTre C-Win _STRUCTURED
  QUERY brTre NO-LOCK DISPLAY
      mov-conta.dt-mov FORMAT "99/99/9999":U
      (de-valor * -1) COLUMN-LABEL "Valor" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.72
      mov-conta.ds-observacao FORMAT "X(256)":U WIDTH 40
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 48 BY 5.25
         FONT 1
         TITLE "Treinamentos Recebidos".

DEFINE BROWSE brViag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brViag C-Win _STRUCTURED
  QUERY brViag NO-LOCK DISPLAY
      mov-conta.dt-mov FORMAT "99/99/9999":U
      sub-cat.ds-sub FORMAT "X(40)":U WIDTH 24
      (mov-conta.de-valor * -1) COLUMN-LABEL "Valor" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.72
      mov-conta.ds-observacao FORMAT "X(256)":U WIDTH 40
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 63 BY 8
         FONT 1
         TITLE "Reembolsos de Despesas de Viagem".

DEFINE BROWSE brVisita
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brVisita C-Win _STRUCTURED
  QUERY brVisita NO-LOCK DISPLAY
      visita.dt-visita FORMAT "99/99/9999":U
      favorecido.ds-favorecido COLUMN-LABEL "Cliente/Prospect" FORMAT "X(40)":U
            WIDTH 12
      visita.hora-inicio FORMAT "x(5)":U
      visita.hora-fim FORMAT "x(5)":U
      fnSituacaoVisita(visita.situacao) @ cSituacao COLUMN-LABEL "Situaá∆o"
            WIDTH 8
      visita.ds-visita FORMAT "x(80)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 55 BY 3.75
         FONT 1
         TITLE "Minhas Visitas".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     dt-ini AT ROW 4.67 COL 33 COLON-ALIGNED WIDGET-ID 8
     dt-fim AT ROW 4.63 COL 49.29 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     l-pend AT ROW 4.63 COL 61 WIDGET-ID 46
     btRelApont AT ROW 5.5 COL 35 WIDGET-ID 54
     btRelPeR AT ROW 5.5 COL 55 WIDGET-ID 30
     cNome AT ROW 2.75 COL 33 COLON-ALIGNED WIDGET-ID 4
     btRelPeR-2 AT ROW 5.5 COL 65 WIDGET-ID 34
     btGeral AT ROW 7.5 COL 2 WIDGET-ID 56
     btApont AT ROW 10 COL 2 WIDGET-ID 38
     btProj AT ROW 8.75 COL 2 WIDGET-ID 52
     btTar AT ROW 11.25 COL 2 WIDGET-ID 50
     favorecido.ds-favorecido AT ROW 1.75 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 44
           VIEW-AS TEXT 
          SIZE 45 BY .67
          FGCOLOR 4 FONT 9
     btPagtos AT ROW 12.5 COL 2 WIDGET-ID 40
     btBen AT ROW 13.75 COL 2 WIDGET-ID 48
     favorecido.data-nasc AT ROW 2.75 COL 54 COLON-ALIGNED WIDGET-ID 42
           VIEW-AS TEXT 
          SIZE 10 BY .67
     btRelRes AT ROW 5.5 COL 45 WIDGET-ID 58
     RECT-7 AT ROW 1.25 COL 2 WIDGET-ID 6
     IMAGE-1 AT ROW 4.25 COL 43 WIDGET-ID 10
     IMAGE-2 AT ROW 4.25 COL 46.86 WIDGET-ID 12
     IMAGE-3 AT ROW 2.75 COL 105 WIDGET-ID 16
     IMAGE-4 AT ROW 1.5 COL 3 WIDGET-ID 36
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.86 BY 24.58
         FONT 1 WIDGET-ID 100.

DEFINE FRAME fTar
     brTarCRM AT ROW 1.25 COL 2 WIDGET-ID 1600
     brVisita AT ROW 1.25 COL 59 WIDGET-ID 1900
     obs-vis AT ROW 3.75 COL 59 NO-LABEL WIDGET-ID 40
     btIncVis AT ROW 8 COL 59 WIDGET-ID 44
     btModVis AT ROW 8 COL 69 WIDGET-ID 46
     btEliVis AT ROW 8 COL 79 WIDGET-ID 42
     btDesp AT ROW 8 COL 89 WIDGET-ID 66
     brComp AT ROW 9 COL 59 WIDGET-ID 2400
     obs-tar AT ROW 12.75 COL 2 NO-LABEL WIDGET-ID 38
     obs-comp AT ROW 12.75 COL 59 NO-LABEL WIDGET-ID 64
     btIncTar AT ROW 17 COL 2 WIDGET-ID 30
     btModTar AT ROW 17 COL 12 WIDGET-ID 32
     btEliTar AT ROW 17 COL 22 WIDGET-ID 34
     btIncComp AT ROW 17 COL 59 WIDGET-ID 60
     btModComp AT ROW 17 COL 69 WIDGET-ID 62
     btEliComp AT ROW 17 COL 79 WIDGET-ID 58
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 18 ROW 7.5
         SIZE 114 BY 18
         FONT 1
         TITLE "Administrativo e Comercial" WIDGET-ID 1500.

DEFINE FRAME fBen
     brBenef AT ROW 1.25 COL 2 WIDGET-ID 1200
     brViag AT ROW 1.25 COL 51 WIDGET-ID 1300
     brDesp AT ROW 9.5 COL 51 WIDGET-ID 1400
     brTre AT ROW 12.75 COL 2 WIDGET-ID 1100
     de-tot-reemb AT ROW 17.13 COL 100.14 COLON-ALIGNED WIDGET-ID 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 18 ROW 7.5
         SIZE 114 BY 18
         FONT 1
         TITLE "Benef°cios e Reembolsos" WIDGET-ID 1000.

DEFINE FRAME fPagto
     brMov AT ROW 1.25 COL 2 WIDGET-ID 800
     brAgend AT ROW 1.25 COL 58 WIDGET-ID 900
     de-tot-pag AT ROW 17.17 COL 43 COLON-ALIGNED WIDGET-ID 2
     de-tot-agend AT ROW 17.17 COL 99 COLON-ALIGNED WIDGET-ID 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 18 ROW 7.5
         SIZE 114 BY 18
         FONT 1
         TITLE "Pagamentos" WIDGET-ID 700.

DEFINE FRAME fApont
     brPed AT ROW 1.25 COL 2 WIDGET-ID 200
     brItem AT ROW 1.25 COL 65 WIDGET-ID 400
     btAnexos AT ROW 5.75 COL 65 WIDGET-ID 34
     brApont AT ROW 7 COL 65 WIDGET-ID 300
     btRelPed AT ROW 11.5 COL 2 WIDGET-ID 28
     btRelPed-2 AT ROW 11.5 COL 12 WIDGET-ID 32
     brOutros AT ROW 12.75 COL 2 WIDGET-ID 500
     btInc AT ROW 17 COL 65 WIDGET-ID 22
     btMod AT ROW 17 COL 75 WIDGET-ID 24
     btEli AT ROW 17 COL 85 WIDGET-ID 26
     deTotO AT ROW 11.75 COL 31 COLON-ALIGNED WIDGET-ID 20
     deTotM AT ROW 11.75 COL 51 COLON-ALIGNED WIDGET-ID 18
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 18 ROW 7.5
         SIZE 114 BY 18
         FONT 1
         TITLE "Pedidos" WIDGET-ID 600.

DEFINE FRAME fProj
     brTarOS AT ROW 1.25 COL 2 WIDGET-ID 1600
     brApontProj AT ROW 1.25 COL 79 WIDGET-ID 1800
     obs-apont-proj AT ROW 11.75 COL 79 NO-LABEL WIDGET-ID 44
     obs-tar-proj AT ROW 13.75 COL 2 NO-LABEL WIDGET-ID 38
     btMoveUp AT ROW 17 COL 2 WIDGET-ID 30
     btMovDown AT ROW 17 COL 12 WIDGET-ID 32
     btAtu AT ROW 17 COL 22 WIDGET-ID 34
     btRecalc AT ROW 17 COL 32 WIDGET-ID 40
     btIncProj AT ROW 17 COL 79 WIDGET-ID 22
     btModProj AT ROW 17 COL 89 WIDGET-ID 24
     btEliProj AT ROW 17 COL 99 WIDGET-ID 26
     carga AT ROW 17.04 COL 65.43 COLON-ALIGNED WIDGET-ID 42
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 18 ROW 7.5
         SIZE 114 BY 18
         FONT 1
         TITLE "Projetos" WIDGET-ID 1700.

DEFINE FRAME fGer
     brPendAtras AT ROW 1.25 COL 2 WIDGET-ID 2100
     brPendHoje AT ROW 5 COL 2 WIDGET-ID 2200
     brPendFut AT ROW 9.75 COL 39 WIDGET-ID 2300
     de-fat AT ROW 13.25 COL 24 COLON-ALIGNED WIDGET-ID 4
     de-lucr AT ROW 15.25 COL 24 COLON-ALIGNED WIDGET-ID 8
     de-ppr AT ROW 17.25 COL 24 COLON-ALIGNED WIDGET-ID 10
     IMAGE-5 AT ROW 1.25 COL 39 WIDGET-ID 16
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 18 ROW 7.5
         SIZE 114 BY 18
         FONT 1
         TITLE "Vis∆o Geral" WIDGET-ID 2000.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 24.58
         WIDTH              = 131.86
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
/* REPARENT FRAME */
ASSIGN FRAME fApont:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fBen:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fGer:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPagto:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fProj:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fTar:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fApont:MOVE-AFTER-TAB-ITEM (btBen:HANDLE IN FRAME DEFAULT-FRAME)
       XXTABVALXX = FRAME fGer:MOVE-BEFORE-TAB-ITEM (btRelRes:HANDLE IN FRAME DEFAULT-FRAME)
       XXTABVALXX = FRAME fTar:MOVE-BEFORE-TAB-ITEM (FRAME fGer:HANDLE)
       XXTABVALXX = FRAME fProj:MOVE-BEFORE-TAB-ITEM (FRAME fTar:HANDLE)
       XXTABVALXX = FRAME fPagto:MOVE-BEFORE-TAB-ITEM (FRAME fProj:HANDLE)
       XXTABVALXX = FRAME fBen:MOVE-BEFORE-TAB-ITEM (FRAME fPagto:HANDLE)
       XXTABVALXX = FRAME fApont:MOVE-BEFORE-TAB-ITEM (FRAME fBen:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FILL-IN cNome IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN favorecido.ds-favorecido IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FRAME fApont
                                                                        */
/* BROWSE-TAB brPed 1 fApont */
/* BROWSE-TAB brItem brPed fApont */
/* BROWSE-TAB brApont btAnexos fApont */
/* BROWSE-TAB brOutros btRelPed-2 fApont */
ASSIGN 
       brPed:ALLOW-COLUMN-SEARCHING IN FRAME fApont = TRUE.

/* SETTINGS FOR FILL-IN deTotM IN FRAME fApont
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deTotO IN FRAME fApont
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fBen
                                                                        */
/* BROWSE-TAB brBenef 1 fBen */
/* BROWSE-TAB brViag brBenef fBen */
/* BROWSE-TAB brDesp brViag fBen */
/* BROWSE-TAB brTre brDesp fBen */
/* SETTINGS FOR FILL-IN de-tot-reemb IN FRAME fBen
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fGer
                                                                        */
/* BROWSE-TAB brPendAtras IMAGE-5 fGer */
/* BROWSE-TAB brPendHoje brPendAtras fGer */
/* BROWSE-TAB brPendFut brPendHoje fGer */
/* SETTINGS FOR FRAME fPagto
                                                                        */
/* BROWSE-TAB brMov 1 fPagto */
/* BROWSE-TAB brAgend brMov fPagto */
/* SETTINGS FOR FILL-IN de-tot-agend IN FRAME fPagto
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-pag IN FRAME fPagto
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fProj
                                                                        */
/* BROWSE-TAB brTarOS 1 fProj */
/* BROWSE-TAB brApontProj brTarOS fProj */
ASSIGN 
       brTarOS:ALLOW-COLUMN-SEARCHING IN FRAME fProj = TRUE.

/* SETTINGS FOR FILL-IN carga IN FRAME fProj
   NO-ENABLE                                                            */
ASSIGN 
       obs-apont-proj:RETURN-INSERTED IN FRAME fProj  = TRUE
       obs-apont-proj:READ-ONLY IN FRAME fProj        = TRUE.

ASSIGN 
       obs-tar-proj:READ-ONLY IN FRAME fProj        = TRUE.

/* SETTINGS FOR FRAME fTar
                                                                        */
/* BROWSE-TAB brTarCRM 1 fTar */
/* BROWSE-TAB brVisita brTarCRM fTar */
/* BROWSE-TAB brComp btDesp fTar */
ASSIGN 
       obs-comp:READ-ONLY IN FRAME fTar        = TRUE.

ASSIGN 
       obs-tar:READ-ONLY IN FRAME fTar        = TRUE.

ASSIGN 
       obs-vis:READ-ONLY IN FRAME fTar        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAgend
/* Query rebuild information for BROWSE brAgend
     _TblList          = "money.agenda,money.agenda-valor WHERE money.agenda ..."
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.agenda.prox-data-pag|yes"
     _Where[1]         = "(agenda.usuar-resp = usuario.nome
 OR agenda.cd-favorecido = usuario.cd-favorecido)
 AND agenda.prox-data-pag <= agenda.dt-fim
 AND agenda.prox-data-pag >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND agenda.prox-data-pag <= INPUT FRAME {&FRAME-NAME} dt-fim
AND (agenda.cod-categoria = 0
 OR (agenda.cod-categoria = 4
 AND agenda.cd-sub <> 2
 AND agenda.cd-sub <> 5
 AND agenda.cd-sub <> 6
 AND agenda.cd-sub <> 10
 AND agenda.cd-sub <> 11)
 OR agenda.cod-categoria = 7)"
     _JoinCode[2]      = "agenda-valor.cd-agenda = agenda.cd-agenda"
     _Where[2]         = "agenda-valor.dt-ini <= agenda.prox-data-pag
 AND agenda-valor.dt-end >= agenda.prox-data-pag"
     _FldNameList[1]   > money.agenda.prox-data-pag
"agenda.prox-data-pag" "Data" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"fnMotivo(agenda.cod-categoria,agenda.cd-sub,agenda.cd-favorecido,"""") @ cMotivo" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF agenda.vl-atual = 0 THEN (agenda-valor.valor * -1) ELSE (agenda.vl-atual * -1)" "Valor" "->>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brAgend */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brApont
/* Query rebuild information for BROWSE brApont
     _TblList          = "money.apontamento"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.apontamento.data|no,money.apontamento.hora-ini|no"
     _Where[1]         = "apontamento.nr-pedido = pedido-item.nr-pedido
AND apontamento.sequencia = pedido-item.sequencia
AND apontamento.nome = cNome
AND apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini
AND apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim"
     _FldNameList[1]   = money.apontamento.data
     _FldNameList[2]   = money.apontamento.hora-ini
     _FldNameList[3]   = money.apontamento.hora-fim
     _FldNameList[4]   > money.apontamento.qt-apontada
"apontamento.qt-apontada" "Qtde" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > money.apontamento.ds-apontamento
"apontamento.ds-apontamento" ? "x(80)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brApont */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brApontProj
/* Query rebuild information for BROWSE brApontProj
     _TblList          = "money.apontamento"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.apontamento.data|no,money.apontamento.hora-ini|no"
     _Where[1]         = "(IF AVAIL tarefa THEN apontamento.nome-tarefa = tarefa.nome ELSE FALSE)
 AND apontamento.seq-tarefa = tarefa.sequencia"
     _FldNameList[1]   > money.apontamento.nome
"apontamento.nome" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = money.apontamento.data
     _FldNameList[3]   > money.apontamento.hora-ini
"apontamento.hora-ini" ? ? "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.apontamento.hora-fim
"apontamento.hora-fim" ? ? "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brApontProj */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brBenef
/* Query rebuild information for BROWSE brBenef
     _TblList          = "money.mov-conta,money.favorecido OF money.mov-conta,money.categoria OF money.mov-conta,money.sub-cat OF money.mov-conta"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.mov-conta.dt-mov|yes"
     _Where[1]         = "mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
 AND (mov-conta.cod-categoria = 4 
 AND (mov-conta.cd-sub = 2
 OR mov-conta.cd-sub = 5
 OR mov-conta.cd-sub = 6
 OR mov-conta.cd-sub = 10
 OR mov-conta.cd-sub = 11))"
     _FldNameList[1]   = money.mov-conta.dt-mov
     _FldNameList[2]   > money.sub-cat.ds-sub
"sub-cat.ds-sub" "Benef°cio" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"(mov-conta.de-valor * -1)" "Valor" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brBenef */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brComp
/* Query rebuild information for BROWSE brComp
     _TblList          = "money.visita"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "visita.nome = gcUsuario
 AND visita.dt-visita >= INPUT FRAME DEFAULT-FRAME dt-ini
 AND visita.dt-visita <= INPUT FRAME DEFAULT-FRAME dt-fim 
 AND visita.compromisso
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (visita.situacao < 8) ELSE TRUE)
"
     _FldNameList[1]   = money.visita.dt-visita
     _FldNameList[2]   = money.visita.hora-inicio
     _FldNameList[3]   = money.visita.hora-fim
     _FldNameList[4]   > "_<CALC>"
"fnSituacaoCompromisso(visita.situacao) @ cSituacao" "Situaá∆o" ? ? ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = money.visita.ds-visita
     _Query            is OPENED
*/  /* BROWSE brComp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brDesp
/* Query rebuild information for BROWSE brDesp
     _TblList          = "money.mov-conta,money.categoria OF money.mov-conta,money.sub-cat OF money.mov-conta"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
 AND mov-conta.id-tipo <> 0
 AND mov-conta.cod-categoria <> 1
 AND mov-conta.cod-categoria <> 4
 AND mov-conta.cod-categoria <> 7
 AND mov-conta.cod-categoria <> 11
 AND mov-conta.cod-categoria <> 12
 AND mov-conta.cod-categoria <> 13
"
     _FldNameList[1]   = money.mov-conta.dt-mov
     _FldNameList[2]   > money.categoria.ds-categoria
"categoria.ds-categoria" "Despesa" ? "character" ? ? ? ? ? ? no ? no no "19" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.sub-cat.ds-sub
"sub-cat.ds-sub" "" ? "character" ? ? ? ? ? ? no ? no no "19" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"(mov-conta.de-valor * -1)" "Valor" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brDesp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brItem
/* Query rebuild information for BROWSE brItem
     _TblList          = "money.pedido-item,money.item OF money.pedido-item,money.pedido-item-usu OF money.pedido-item"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "pedido-item.nr-pedido = pedido.nr-pedido
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN pedido-item.situacao < 3 ELSE TRUE)"
     _Where[3]         = "pedido-item-usu.nome = gcUsuario"
     _FldNameList[1]   = money.pedido-item.sequencia
     _FldNameList[2]   > money.pedido-item.ds-pedido-item
"pedido-item.ds-pedido-item" "Item" ? "character" ? ? ? ? ? ? no ? no no "16" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.pedido-item.qt-pedida
     _FldNameList[4]   = money.pedido-item.qt-liberada
     _FldNameList[5]   = money.pedido-item.qt-atendida
     _Query            is OPENED
*/  /* BROWSE brItem */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brMov
/* Query rebuild information for BROWSE brMov
     _TblList          = "money.mov-conta"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.mov-conta.dt-mov|yes"
     _Where[1]         = "(mov-conta.cd-conta = 1 OR mov-conta.cd-conta = 4)
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
 AND mov-conta.id-tipo <> 0
 AND mov-conta.cd-conta <> 5
 AND mov-conta.cd-conta <> 8
 AND (mov-conta.cod-categoria = 0
 OR (mov-conta.cod-categoria = 4
 AND mov-conta.cd-sub <> 2
 AND mov-conta.cd-sub <> 5
 AND mov-conta.cd-sub <> 6
 AND mov-conta.cd-sub <> 10
 AND mov-conta.cd-sub <> 11)
 OR mov-conta.cod-categoria = 7)
 AND (mov-conta.usuar-resp = usuario.nome
 OR mov-conta.cd-favorecido = usuario.cd-favorecido)"
     _FldNameList[1]   = money.mov-conta.dt-mov
     _FldNameList[2]   > "_<CALC>"
"fnMotivo(mov-conta.cod-categoria,mov-conta.cd-sub,mov-conta.cd-favorecido,mov-conta.ds-observacao) @ cMotivo" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"(mov-conta.de-valor * -1)" "Valor" "->>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brMov */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brOutros
/* Query rebuild information for BROWSE brOutros
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH bf-apontamento
      WHERE bf-apontamento.nr-pedido = pedido-item.nr-pedido
AND bf-apontamento.sequencia = pedido-item.sequencia
AND bf-apontamento.nome <> cNome
AND bf-apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini
AND bf-apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim NO-LOCK
    BY bf-apontamento.data INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.apontamento.data|yes"
     _Where[1]         = "apontamento.nr-pedido = pedido-item.nr-pedido
AND apontamento.sequencia = pedido-item.sequencia
AND apontamento.nome <> cNome
AND apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini
AND apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim"
     _Query            is OPENED
*/  /* BROWSE brOutros */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPed
/* Query rebuild information for BROWSE brPed
     _START_FREEFORM
RUN pesq_ped.
OPEN QUERY {&SELF-NAME} FOR EACH pedido
      WHERE LOOKUP(STRING(ROWID(pedido)), cRowid) <> 0 NO-LOCK,
      FIRST favorecido OF pedido NO-LOCK
      INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ",, FIRST, FIRST"
     _Where[1]         = "pedido.dt-pedido >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND pedido.dt-pedido <= INPUT FRAME {&FRAME-NAME} dt-fim"
     _JoinCode[2]      = "pedido.dt-pedido >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND pedido.dt-pedido <= INPUT FRAME {&FRAME-NAME} dt-fim
 AND (IF INPUT FRAME {&FRAME-NAME} l-Pend THEN pedido.situacao <= 2 ELSE TRUE)"
     _Where[2]         = "pedido-item-usu.nome = INPUT FRAME {&FRAME-NAME} cNome"
     _Query            is OPENED
*/  /* BROWSE brPed */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPendAtras
/* Query rebuild information for BROWSE brPendAtras
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-pend WHERE tt-pend.dt-pend < TODAY.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brPendAtras */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPendFut
/* Query rebuild information for BROWSE brPendFut
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-pend WHERE tt-pend.dt-pend > TODAY.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brPendFut */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPendHoje
/* Query rebuild information for BROWSE brPendHoje
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-pend WHERE tt-pend.dt-pend = TODAY.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brPendHoje */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTarCRM
/* Query rebuild information for BROWSE brTarCRM
     _TblList          = "money.tarefa,money.favorecido OF money.tarefa"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.tarefa.dt-alert-tarefa|yes"
     _Where[1]         = "tarefa.responsavel = gcUsuario
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (tarefa.situacao < 8) ELSE TRUE)
 AND tarefa.num-os = 0
 AND tarefa.dt-alert-tarefa >= INPUT FRAME DEFAULT-FRAME dt-ini
 AND tarefa.dt-alert-tarefa <= INPUT FRAME DEFAULT-FRAME dt-fim"
     _FldNameList[1]   = money.tarefa.dt-alert-tarefa
     _FldNameList[2]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente" ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.tarefa.ds-tarefa
     _FldNameList[4]   > "_<CALC>"
"fnSituacaoTarefa(tarefa.situacao) @ cSituacao" ? ? ? ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = money.tarefa.perc-con
     _Query            is OPENED
*/  /* BROWSE brTarCRM */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTarOS
/* Query rebuild information for BROWSE brTarOS
     _TblList          = "money.tarefa,money.favorecido OF money.tarefa,money.ordem-serv OF money.tarefa"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.tarefa.prioridade|yes,money.tarefa.data-prev-ini|yes"
     _Where[1]         = "tarefa.responsavel = gcUsuario
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (tarefa.situacao < 8) ELSE TRUE)
 AND tarefa.num-os <> 0
 AND tarefa.data-prev-ini >= INPUT FRAME DEFAULT-FRAME dt-ini
 AND tarefa.data-prev-ini <= INPUT FRAME DEFAULT-FRAME dt-fim"
     _FldNameList[1]   > money.tarefa.prioridade
"tarefa.prioridade" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > money.tarefa.data-prev-ini
"tarefa.data-prev-ini" "Dt Prev Ini" ? "date" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.tarefa.data-prev-fim
"tarefa.data-prev-fim" "Dt Prev Fim" ? "date" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.tarefa.qtd-lib
"tarefa.qtd-lib" "Hrs" ? "decimal" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"fnApontTar(tarefa.nome, tarefa.sequencia) @ deApont" "Apont" "->>,>>9.99" ? ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > money.tarefa.perc-con
"tarefa.perc-con" "% Con" ? "decimal" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente" ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > money.tarefa.ds-tarefa
"tarefa.ds-tarefa" ? ? "character" ? ? ? ? ? ? no ? no no "23" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > "_<CALC>"
"fnSituacaoTarefa(tarefa.situacao) @ cSituacao" ? ? ? ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > money.tarefa.num-os
"tarefa.num-os" "OS" ? "integer" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > money.ordem-serv.ds-os
"ordem-serv.ds-os" "Descriá∆o OS" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brTarOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTre
/* Query rebuild information for BROWSE brTre
     _TblList          = "money.mov-conta"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "mov-conta.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome
 AND mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
 AND mov-conta.cod-categoria = 12
 AND mov-conta.cd-sub = 1"
     _FldNameList[1]   = money.mov-conta.dt-mov
     _FldNameList[2]   > "_<CALC>"
"(de-valor * -1)" "Valor" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > money.mov-conta.ds-observacao
"mov-conta.ds-observacao" ? ? "character" ? ? ? ? ? ? no ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brTre */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brViag
/* Query rebuild information for BROWSE brViag
     _TblList          = "money.mov-conta,money.sub-cat OF money.mov-conta,money.favorecido OF money.mov-conta,money.usuario OF money.favorecido"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.mov-conta.dt-mov|yes"
     _Where[1]         = "mov-conta.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
 AND mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
 AND mov-conta.cod-categoria = 11"
     _Where[4]         = "usuario.nome = gcUsuario"
     _FldNameList[1]   = money.mov-conta.dt-mov
     _FldNameList[2]   > money.sub-cat.ds-sub
"sub-cat.ds-sub" ? ? "character" ? ? ? ? ? ? no ? no no "24" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"(mov-conta.de-valor * -1)" "Valor" "->>>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > money.mov-conta.ds-observacao
"mov-conta.ds-observacao" ? ? "character" ? ? ? ? ? ? no ? no no "40" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brViag */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brVisita
/* Query rebuild information for BROWSE brVisita
     _TblList          = "money.visita,money.favorecido OF money.visita"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "visita.nome = gcUsuario
 AND visita.dt-visita >= INPUT FRAME DEFAULT-FRAME dt-ini
 AND visita.dt-visita <= INPUT FRAME DEFAULT-FRAME dt-fim 
 AND NOT visita.compromisso
 AND (IF INPUT FRAME DEFAULT-FRAME l-pend THEN (visita.situacao < 8) ELSE TRUE)
"
     _FldNameList[1]   = money.visita.dt-visita
     _FldNameList[2]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente/Prospect" ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.visita.hora-inicio
     _FldNameList[4]   = money.visita.hora-fim
     _FldNameList[5]   > "_<CALC>"
"fnSituacaoVisita(visita.situacao) @ cSituacao" "Situaá∆o" ? ? ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = money.visita.ds-visita
     _Query            is OPENED
*/  /* BROWSE brVisita */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME fGer:HANDLE
       ROW             = 14
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 36
       WIDGET-ID       = 12
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME fGer:HANDLE
       ROW             = 16
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 36
       WIDGET-ID       = 14
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(brPendFut:HANDLE IN FRAME fGer).
      CtrlFrame-2:MOVE-AFTER(CtrlFrame).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESIZED OF C-Win /* <insert window title> */
DO:
    DEFINE VARIABLE hLabel AS HANDLE      NO-UNDO.

    ASSIGN FRAME default-frame:WIDTH = C-Win:WIDTH
           FRAME default-frame:HEIGHT = C-Win:HEIGHT
           FRAME default-frame:VIRTUAL-WIDTH = C-Win:WIDTH
           FRAME default-frame:VIRTUAL-HEIGHT = C-Win:HEIGHT NO-ERROR.

    DO WITH FRAME {&FRAME-NAME}:
        ASSIGN RECT-7:WIDTH = C-Win:WIDTH - 1.86
               IMAGE-3:COLUMN = C-Win:WIDTH - 26.86
               FRAME fApont:WIDTH = C-Win:WIDTH - 17.86
               FRAME fApont:HEIGHT = C-Win:HEIGHT - 6.79
               FRAME fBen:WIDTH = FRAME fApont:WIDTH
               FRAME fBen:HEIGHT = FRAME fApont:HEIGHT
               FRAME fPagto:WIDTH = FRAME fApont:WIDTH
               FRAME fPagto:HEIGHT = FRAME fApont:HEIGHT
               FRAME fProj:WIDTH = FRAME fApont:WIDTH
               FRAME fProj:HEIGHT = FRAME fApont:HEIGHT
               FRAME fTar:WIDTH = FRAME fApont:WIDTH
               FRAME fTar:HEIGHT = FRAME fApont:HEIGHT
               FRAME fGer:WIDTH = FRAME fApont:WIDTH
               FRAME fGer:HEIGHT = FRAME fApont:HEIGHT NO-ERROR.

        ASSIGN FRAME fApont:VIRTUAL-WIDTH = C-Win:WIDTH - 17.86
               FRAME fApont:VIRTUAL-HEIGHT = C-Win:HEIGHT - 6.79
               FRAME fBen:VIRTUAL-WIDTH = FRAME fApont:WIDTH
               FRAME fBen:VIRTUAL-HEIGHT = FRAME fApont:HEIGHT
               FRAME fPagto:VIRTUAL-WIDTH = FRAME fApont:WIDTH
               FRAME fPagto:VIRTUAL-HEIGHT = FRAME fApont:HEIGHT
               FRAME fProj:VIRTUAL-WIDTH = FRAME fApont:WIDTH
               FRAME fProj:VIRTUAL-HEIGHT = FRAME fApont:HEIGHT
               FRAME fTar:VIRTUAL-WIDTH = FRAME fApont:WIDTH
               FRAME fTar:VIRTUAL-HEIGHT = FRAME fApont:HEIGHT
               FRAME fGer:VIRTUAL-WIDTH = FRAME fApont:WIDTH
               FRAME fGer:VIRTUAL-HEIGHT = FRAME fApont:HEIGHT NO-ERROR.
    END.

    DO WITH FRAME fProj:
        ASSIGN brApontProj:COL = FRAME fProj:WIDTH - 34.50 /*35*/
               obs-apont-proj:COL = FRAME fProj:WIDTH - 35.00
               btIncProj:COL = FRAME fProj:WIDTH - 35.00
               btModProj:COL = FRAME fProj:WIDTH - 25.00
               btEliProj:COL = FRAME fProj:WIDTH - 15.00
               obs-apont-proj:ROW = FRAME fProj:HEIGHT - 6.25
               btIncProj:ROW = FRAME fProj:HEIGHT - 1.00
               btModProj:ROW = FRAME fProj:HEIGHT - 1.00
               btEliProj:ROW = FRAME fProj:HEIGHT - 1.00
               brApontProj:HEIGHT = FRAME fProj:HEIGHT - 7.50
               brTarOS:WIDTH = FRAME fProj:WIDTH - 38.00
               obs-tar-proj:WIDTH = FRAME fProj:WIDTH - 38.00
               obs-tar-proj:ROW = FRAME fProj:HEIGHT - 4.25
               btMoveUp:ROW = FRAME fProj:HEIGHT - 1.00
               btMovDown:ROW = FRAME fProj:HEIGHT - 1.00
               btAtu:ROW = FRAME fProj:HEIGHT - 1.00
               btRecalc:ROW = FRAME fProj:HEIGHT - 1.00
               carga:ROW = FRAME fProj:HEIGHT - 1.00
               carga:COL = FRAME fProj:WIDTH - 46.57
               brTarOS:HEIGHT = FRAME fProj:HEIGHT - 5.50 NO-ERROR.

        ASSIGN hLabel = carga:SIDE-LABEL-HANDLE
               hLabel:ROW = FRAME fProj:HEIGHT - 0.96
               hLabel:COL = FRAME fProj:WIDTH - 46.57
               hLabel:COL = carga:COL - 13 NO-ERROR.
    END.

    DO WITH FRAME fApont:
        ASSIGN brItem:COL = FRAME fApont:WIDTH - 49.00
               btAnexos:COL = FRAME fApont:WIDTH - 49.00
               brApont:COL = FRAME fApont:WIDTH - 49.00
               btInc:COL = FRAME fApont:WIDTH - 49.00
               btMod:COL = FRAME fApont:WIDTH - 39.00
               btEli:COL = FRAME fApont:WIDTH - 29.00
               btInc:ROW = FRAME fApont:HEIGHT - 1.00
               btMod:ROW = FRAME fApont:HEIGHT - 1.00
               btEli:ROW = FRAME fApont:HEIGHT - 1.00
               brApont:HEIGHT = FRAME fApont:HEIGHT - 8.00
               brPed:WIDTH = FRAME fApont:WIDTH - 52.00
               brOutros:WIDTH = FRAME fApont:WIDTH - 52.00
               brOutros:HEIGHT = FRAME fApont:HEIGHT - 12.75 NO-ERROR.
    END.

    DO WITH FRAME fTar:
        ASSIGN brVisita:COL = FRAME fTar:WIDTH - 55.00
               obs-vis:COL = FRAME fTar:WIDTH - 55.00
               btIncVis:COL = FRAME fTar:WIDTH - 55.00
               btModVis:COL = FRAME fTar:WIDTH - 45.00
               btEliVis:COL = FRAME fTar:WIDTH - 35.00
               btDesp:COL = FRAME fTar:WIDTH - 25.00
               brComp:COL = FRAME fTar:WIDTH - 55.00
               obs-comp:COL = FRAME fTar:WIDTH - 55.00
               btIncComp:COL = FRAME fTar:WIDTH - 55.00
               btModComp:COL = FRAME fTar:WIDTH - 45.00
               btEliComp:COL = FRAME fTar:WIDTH - 35.00
               obs-vis:ROW = (FRAME fTar:HEIGHT / 2) - 5.25
               btIncVis:ROW = (FRAME fTar:HEIGHT / 2) - 1.00
               btModVis:ROW = (FRAME fTar:HEIGHT / 2) - 1.00
               btEliVis:ROW = (FRAME fTar:HEIGHT / 2) - 1.00
               btDesp:ROW = (FRAME fTar:HEIGHT / 2) - 1.00
               brVisita:HEIGHT = (FRAME fTar:HEIGHT / 2) - /*6.50*/ 5.25
               obs-comp:ROW = FRAME fTar:HEIGHT - 5.25
               btIncComp:ROW = FRAME fTar:HEIGHT - 1.00
               btModComp:ROW = FRAME fTar:HEIGHT - 1.00
               btEliComp:ROW = FRAME fTar:HEIGHT - 1.00
               brComp:HEIGHT = (FRAME fTar:HEIGHT / 2) - 5.25
               brComp:ROW = (FRAME fTar:HEIGHT / 2)
               obs-tar:ROW = FRAME fTar:HEIGHT - 5.25
               btIncTar:ROW = FRAME fTar:HEIGHT - 1.00
               btModTar:ROW = FRAME fTar:HEIGHT - 1.00
               btEliTar:ROW = FRAME fTar:HEIGHT - 1.00
               brTarCRM:HEIGHT = FRAME fTar:HEIGHT - 7.00 /*6.5*/
               obs-tar:WIDTH = FRAME fTar:WIDTH - 58.00
               brTarCRM:WIDTH = FRAME fTar:WIDTH - 58.00 NO-ERROR.                              
    END.

    DO WITH FRAME fPagto:
        ASSIGN brMov:WIDTH = (FRAME fPagto:WIDTH - 3.14) / 2
               brAgend:WIDTH = (FRAME fPagto:WIDTH - 3.14) / 2
               brAgend:COL = brMov:WIDTH + 2.57
               brMov:HEIGHT = FRAME fPagto:HEIGHT - 2.25
               brAgend:HEIGHT = FRAME fPagto:HEIGHT - 2.25
               hLabel = de-tot-pag:SIDE-LABEL-HANDLE
               de-tot-pag:ROW = FRAME fPagto:HEIGHT - 0.83
               hLabel:ROW = de-tot-pag:ROW
               de-tot-pag:COL = brMov:WIDTH - 10.43
               hLabel:COL = brMov:WIDTH - 10.43
               hLabel = de-tot-agend:SIDE-LABEL-HANDLE
               de-tot-agend:ROW = FRAME fPagto:HEIGHT - 0.83
               hLabel:ROW = de-tot-agend:ROW
               de-tot-agend:COL = FRAME fPagto:WIDTH - 12.83
               hLabel:COL = FRAME fPagto:WIDTH - 12.83 NO-ERROR.                              
    END.

    DO WITH FRAME fPagto:
        ASSIGN brMov:WIDTH = (FRAME fPagto:WIDTH - 3.14) / 2
               brAgend:WIDTH = (FRAME fPagto:WIDTH - 3.14) / 2
               brAgend:COL = brMov:WIDTH + 2.57
               brMov:HEIGHT = FRAME fPagto:HEIGHT - 2.25
               brAgend:HEIGHT = FRAME fPagto:HEIGHT - 2.25
               hLabel = de-tot-pag:SIDE-LABEL-HANDLE
               de-tot-pag:ROW = FRAME fPagto:HEIGHT - 0.83
               hLabel:ROW = de-tot-pag:ROW
               de-tot-pag:COL = brMov:WIDTH - 10.43
               hLabel:COL = brMov:WIDTH - 10.43
               hLabel = de-tot-agend:SIDE-LABEL-HANDLE
               de-tot-agend:ROW = FRAME fPagto:HEIGHT - 0.83
               hLabel:ROW = de-tot-agend:ROW
               de-tot-agend:COL = FRAME fPagto:WIDTH - 12.83
               hLabel:COL = FRAME fPagto:WIDTH - 12.83 NO-ERROR.

        ASSIGN hLabel = de-tot-pag:SIDE-LABEL-HANDLE
               hLabel:COL = de-tot-pag:COL - 20.5.

        ASSIGN hLabel = de-tot-agend:SIDE-LABEL-HANDLE
               hLabel:COL = de-tot-agend:COL - 24.5.
    END.

    DO WITH FRAME fBen:
        ASSIGN brViag:COL = FRAME fBen:WIDTH - 63.00
               brDesp:COL = FRAME fBen:WIDTH - 63.00
               hLabel = de-tot-reemb:SIDE-LABEL-HANDLE
               de-tot-reemb:COL = FRAME fBen:WIDTH - 11.86
               hLabel:COL = FRAME fBen:WIDTH - 11.86
               brDesp:ROW = FRAME fBen:HEIGHT - 8.50
               de-tot-reemb:ROW = FRAME fBen:HEIGHT - 0.87
               hLabel:ROW = FRAME fBen:HEIGHT - 0.87
               brViag:HEIGHT = FRAME fBen:HEIGHT - 10.00
               brBenef:WIDTH = FRAME fBen:WIDTH - 66.00
               brTre:WIDTH = FRAME fBen:WIDTH - 66.00
               brTre:ROW = FRAME fBen:HEIGHT - 5.25
               brBenef:HEIGHT = FRAME fBen:HEIGHT - 6.75 NO-ERROR.                              

        ASSIGN hLabel = de-tot-reemb:SIDE-LABEL-HANDLE
               hLabel:COL = de-tot-reemb:COL - 15.
    END.

    DO WITH FRAME fGer:
        ASSIGN brPendAtras:WIDTH = (FRAME fGer:WIDTH + 17) / 3
               brPendHoje:WIDTH = (FRAME fGer:WIDTH + 17) / 3
               de-fat:COL = brPendHoje:WIDTH - 12.00
               de-lucr:COL = brPendHoje:WIDTH - 12.00
               de-ppr:COL = brPendHoje:WIDTH - 12.00
               brPendAtras:HEIGHT = (FRAME fGer:HEIGHT - 7.5) / 2
               brPendHoje:HEIGHT = (FRAME fGer:HEIGHT - 7.5) / 2
               brPendHoje:ROW = brPendAtras:HEIGHT + 1.5
               de-fat:ROW = FRAME fGer:HEIGHT - 4.75
               CtrlFrame:ROW = FRAME fGer:HEIGHT - 3.75
               de-lucr:ROW = FRAME fGer:HEIGHT - 2.75
               CtrlFrame-2:ROW = FRAME fGer:HEIGHT - 2.00
               de-ppr:ROW = FRAME fGer:HEIGHT - 0.75
               CtrlFrame:WIDTH = brPendHoje:WIDTH
               CtrlFrame-2:WIDTH = brPendHoje:WIDTH
               hLabel = de-fat:SIDE-LABEL-HANDLE
               hLabel:ROW = de-fat:ROW
               hLabel:COL = de-fat:COL
               hLabel = de-lucr:SIDE-LABEL-HANDLE
               hLabel:ROW = de-lucr:ROW
               hLabel:COL = de-lucr:COL
               hLabel = de-ppr:SIDE-LABEL-HANDLE
               hLabel:ROW = de-ppr:ROW
               hLabel:COL = de-ppr:COL
               IMAGE-5:WIDTH = FRAME fGer:WIDTH - brPendAtras:WIDTH - 3
               IMAGE-5:HEIGHT = (FRAME fGer:HEIGHT - 1.75) / 2               
               IMAGE-5:COL = brPendAtras:WIDTH + 3
               brPendFut:COL = brPendAtras:WIDTH + 3
               brPendFut:HEIGHT = IMAGE-5:HEIGHT
               brPendFut:ROW = brPendFut:HEIGHT + 1.5
               brPendFut:WIDTH = IMAGE-5:WIDTH
               NO-ERROR.

        ASSIGN hLabel = de-fat:SIDE-LABEL-HANDLE
               hLabel:COL = de-fat:COL - 12.

        ASSIGN hLabel = de-lucr:SIDE-LABEL-HANDLE
               hLabel:COL = de-lucr:COL - 7.

        ASSIGN hLabel = de-ppr:SIDE-LABEL-HANDLE
               hLabel:COL = de-ppr:COL - 12.
    END.

    IF FRAME default-frame:WIDTH > C-Win:WIDTH THEN
        ASSIGN FRAME default-frame:WIDTH = C-Win:WIDTH
               FRAME default-frame:HEIGHT = C-Win:HEIGHT
               FRAME default-frame:VIRTUAL-WIDTH = C-Win:WIDTH
               FRAME default-frame:VIRTUAL-HEIGHT = C-Win:HEIGHT NO-ERROR.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brApont
&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME brApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApont C-Win
ON MOUSE-SELECT-DBLCLICK OF brApont IN FRAME fApont /* Meus Apontamentos */
DO:

    APPLY "CHOOSE" to btMod. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brApontProj
&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME brApontProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApontProj C-Win
ON MOUSE-SELECT-DBLCLICK OF brApontProj IN FRAME fProj /* Apontamentos da Tarefa */
DO:
  
    APPLY "CHOOSE" TO btModProj.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApontProj C-Win
ON VALUE-CHANGED OF brApontProj IN FRAME fProj /* Apontamentos da Tarefa */
DO:
  
    IF AVAIL apontamento THEN
        ASSIGN obs-apont-proj:SCREEN-VALUE IN FRAME fProj = apontamento.ds-apontamento.
    ELSE
        ASSIGN obs-apont-proj:SCREEN-VALUE IN FRAME fProj = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brComp
&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME brComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brComp C-Win
ON ROW-DISPLAY OF brComp IN FRAME fTar /* Meus Compromissos */
DO:

    IF visita.dt-visita < TODAY THEN DO:
        ASSIGN visita.dt-visita:FGCOLOR IN BROWSE brVisita         = 12
               visita.ds-visita:FGCOLOR IN BROWSE brVisita         = 12
               cSituacao:FGCOLOR IN BROWSE brVisita                = 12
               visita.hora-ini:FGCOLOR IN BROWSE brVisita          = 12
               visita.hora-fim:FGCOLOR IN BROWSE brVisita          = 12.
    END.

    IF visita.situacao = 8 /* Conclu°da */ THEN DO:
        ASSIGN visita.dt-visita:FGCOLOR IN BROWSE brVisita         = 2
               visita.ds-visita:FGCOLOR IN BROWSE brVisita         = 2
               cSituacao:FGCOLOR IN BROWSE brVisita                = 2
               visita.hora-ini:FGCOLOR IN BROWSE brVisita          = 2
               visita.hora-fim:FGCOLOR IN BROWSE brVisita          = 2.
    END.

    IF visita.situacao = 9 /* Cancelada */ THEN DO:
        ASSIGN visita.dt-visita:FGCOLOR IN BROWSE brVisita         = 8
               visita.ds-visita:FGCOLOR IN BROWSE brVisita         = 8
               cSituacao:FGCOLOR IN BROWSE brVisita                = 8
               visita.hora-ini:FGCOLOR IN BROWSE brVisita          = 8
               visita.hora-fim:FGCOLOR IN BROWSE brVisita          = 8.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brComp C-Win
ON VALUE-CHANGED OF brComp IN FRAME fTar /* Meus Compromissos */
DO:
  
    IF AVAIL visita THEN
        ASSIGN obs-comp:SCREEN-VALUE IN FRAME fTar = visita.ds-observacao.
    ELSE
        ASSIGN obs-comp:SCREEN-VALUE IN FRAME fTar = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brItem
&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME brItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brItem C-Win
ON VALUE-CHANGED OF brItem IN FRAME fApont /* Itens do Pedido Liberados */
DO:
  
    RUN apont.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brPed
&Scoped-define SELF-NAME brPed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON START-SEARCH OF brPed IN FRAME fApont /* Pedidos Liberados */
DO:
    DEF VAR cWhere AS CHAR NO-UNDO.
    DEF VAR hQuery AS HANDLE NO-UNDO.
    DEF VAR cBy    AS CHAR NO-UNDO.
    
    ASSIGN cWhere = "FOR EACH pedido WHERE LOOKUP(STRING(ROWID(pedido)), '" + cRowid + "') <> 0 NO-LOCK, FIRST favorecido OF pedido NO-LOCK " /*+ "BY pedido.nr-pedido INDEXED-REPOSITION."*/ .

    ASSIGN cBy = "BY pedido.nr-pedido INDEXED-REPOSITION.".

    /* Se a coluna clicada n∆o foi clicada anteriormente faáa */
    IF SELF :CURRENT-COLUMN :SORT-ASCENDING = ? THEN DO:
       SELF :CLEAR-SORT-ARROWS(). /* Limpa as setas das outras colunas */
       SELF :CURRENT-COLUMN :SORT-ASCENDING = FALSE. /* Ordena a coluna ascendentemente */
    END.
    /* Sen∆o ordena a coluna ao inverso do que j† est† ordenada */
    ELSE SELF :CURRENT-COLUMN :SORT-ASCENDING = NOT SELF :CURRENT-COLUMN :SORT-ASCENDING.
    
    /* Armazena a coluna recem selecionada */
    IF SELF :CURRENT-COLUMN :SORT-ASCENDING = FALSE OR SELF :CURRENT-COLUMN :SORT-ASCENDING = TRUE THEN DO:
        CASE SELF :CURRENT-COLUMN :NAME:
            WHEN "cSituacao" THEN DO: /*Trata as funá‰es*/
                ASSIGN cBy = "BY pedido.situacao".
            END.
            OTHERWISE DO: /*Campos padr∆o*/
                ASSIGN cBy = "BY " + SELF :CURRENT-COLUMN :NAME.
            END.
        END CASE.
    
        IF SELF :CURRENT-COLUMN :SORT-ASCENDING = TRUE THEN
            ASSIGN cBy = cBy + " DESCENDING.".
        ELSE
            ASSIGN cBy = cBy + ".".
    END.
    ELSE DO:
        SELF :CLEAR-SORT-ARROWS().
        RETURN.
    END.
    
    /* Executa a nova query para o Browse */
    ASSIGN hQuery = SELF :QUERY :HANDLE.
    hQuery:QUERY-PREPARE(cWhere + cBy).
    hQuery:QUERY-OPEN().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON VALUE-CHANGED OF brPed IN FRAME fApont /* Pedidos Liberados */
DO:
  
    IF AVAIL pedido THEN DO:
        {&OPEN-QUERY-brItem}
        APPLY "VALUE-CHANGED" TO brItem IN FRAME fApont.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brTarCRM
&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME brTarCRM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarCRM C-Win
ON MOUSE-SELECT-DBLCLICK OF brTarCRM IN FRAME fTar /* Minhas Tarefas */
DO:
  
    APPLY "CHOOSE" TO btModTar.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarCRM C-Win
ON ROW-DISPLAY OF brTarCRM IN FRAME fTar /* Minhas Tarefas */
DO:
  
    IF tarefa.dt-alert-tarefa < TODAY THEN DO:
        ASSIGN tarefa.dt-alert-tarefa:FGCOLOR IN BROWSE brTarCRM   = 12
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brTarCRM = 12
               tarefa.ds-tarefa:FGCOLOR IN BROWSE brTarCRM         = 12
               cSituacao:FGCOLOR IN BROWSE brTarCRM                = 12
               tarefa.perc-con:FGCOLOR IN BROWSE brTarCRM          = 12.
    END.

    IF tarefa.situacao = 8 /* Conclu°da */ THEN DO:
        ASSIGN tarefa.dt-alert-tarefa:FGCOLOR IN BROWSE brTarCRM   = 2
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brTarCRM = 2
               tarefa.ds-tarefa:FGCOLOR IN BROWSE brTarCRM         = 2
               cSituacao:FGCOLOR IN BROWSE brTarCRM                = 2
               tarefa.perc-con:FGCOLOR IN BROWSE brTarCRM          = 2.
    END.

    IF tarefa.situacao = 9 /* Cancelada */ THEN DO:
        ASSIGN tarefa.dt-alert-tarefa:FGCOLOR IN BROWSE brTarCRM   = 8
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brTarCRM = 8
               tarefa.ds-tarefa:FGCOLOR IN BROWSE brTarCRM         = 8
               cSituacao:FGCOLOR IN BROWSE brTarCRM                = 8
               tarefa.perc-con:FGCOLOR IN BROWSE brTarCRM          = 8.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarCRM C-Win
ON VALUE-CHANGED OF brTarCRM IN FRAME fTar /* Minhas Tarefas */
DO:
  
    IF AVAIL tarefa THEN
        ASSIGN obs-tar:SCREEN-VALUE IN FRAME fTar = tarefa.ds-observacao.
    ELSE
        ASSIGN obs-tar:SCREEN-VALUE IN FRAME fTar = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brTarOS
&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME brTarOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarOS C-Win
ON MOUSE-SELECT-DBLCLICK OF brTarOS IN FRAME fProj /* Minhas Tarefas de Projeto */
DO:
  
    APPLY "CHOOSE" TO btAtu.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarOS C-Win
ON ROW-DISPLAY OF brTarOS IN FRAME fProj /* Minhas Tarefas de Projeto */
DO:
  
    IF tarefa.dt-alert-tarefa < TODAY THEN DO:
        ASSIGN tarefa.prioridade:FGCOLOR IN BROWSE brTarOS        = 12
               tarefa.data-prev-ini:FGCOLOR IN BROWSE brTarOS     = 12
               tarefa.ds-tarefa:FGCOLOR IN BROWSE brTarOS         = 12
               tarefa.qtd-lib:FGCOLOR IN BROWSE brTarOS           = 12
               cSituacao:FGCOLOR IN BROWSE brTarOS                = 12
               tarefa.perc-con:FGCOLOR IN BROWSE brTarOS          = 12
               tarefa.data-prev-fim:FGCOLOR IN BROWSE brTarOS     = 12
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brTarOS = 12
               tarefa.num-os:FGCOLOR IN BROWSE brTarOS            = 12
               ordem-serv.ds-os:FGCOLOR IN BROWSE brTarOS         = 12
               deApont:FGCOLOR IN BROWSE brTarOS                  = 12.
    END.

    IF tarefa.situacao = 8 /* Conclu°da */ THEN DO:
        ASSIGN tarefa.prioridade:FGCOLOR IN BROWSE brTarOS        = 2
               tarefa.data-prev-ini:FGCOLOR IN BROWSE brTarOS     = 2
               tarefa.ds-tarefa:FGCOLOR IN BROWSE brTarOS         = 2
               tarefa.qtd-lib:FGCOLOR IN BROWSE brTarOS           = 2
               cSituacao:FGCOLOR IN BROWSE brTarOS                = 2
               tarefa.perc-con:FGCOLOR IN BROWSE brTarOS          = 2
               tarefa.data-prev-fim:FGCOLOR IN BROWSE brTarOS     = 2
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brTarOS = 2
               tarefa.num-os:FGCOLOR IN BROWSE brTarOS            = 2
               ordem-serv.ds-os:FGCOLOR IN BROWSE brTarOS         = 2
               deApont:FGCOLOR IN BROWSE brTarOS                  = 2.
    END.

    IF tarefa.situacao = 9 /* Cancelada */ THEN DO:
        ASSIGN tarefa.prioridade:FGCOLOR IN BROWSE brTarOS        = 8
               tarefa.data-prev-ini:FGCOLOR IN BROWSE brTarOS     = 8
               tarefa.ds-tarefa:FGCOLOR IN BROWSE brTarOS         = 8
               tarefa.qtd-lib:FGCOLOR IN BROWSE brTarOS           = 8
               cSituacao:FGCOLOR IN BROWSE brTarOS                = 8
               tarefa.perc-con:FGCOLOR IN BROWSE brTarOS          = 8
               tarefa.data-prev-fim:FGCOLOR IN BROWSE brTarOS     = 8
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brTarOS = 8
               tarefa.num-os:FGCOLOR IN BROWSE brTarOS            = 8
               ordem-serv.ds-os:FGCOLOR IN BROWSE brTarOS         = 8
               deApont:FGCOLOR IN BROWSE brTarOS                  = 8.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarOS C-Win
ON START-SEARCH OF brTarOS IN FRAME fProj /* Minhas Tarefas de Projeto */
DO:
    DEF VAR cWhere AS CHAR NO-UNDO.
    DEF VAR hQuery AS HANDLE NO-UNDO.
    DEF VAR cBy    AS CHAR NO-UNDO.
    
    ASSIGN cWhere = "FOR ".
    ASSIGN cWhere = cWhere + "EACH money.tarefa ".
    ASSIGN cWhere = cWhere + "WHERE tarefa.responsavel = '" + gcUsuario + "' ".
    ASSIGN cWhere = cWhere + "AND (IF " + INPUT FRAME DEFAULT-FRAME l-pend + " THEN (tarefa.situacao < 8) ELSE TRUE) ".
    ASSIGN cWhere = cWhere + "AND tarefa.num-os <> 0 ".
    ASSIGN cWhere = cWhere + "AND tarefa.data-prev-ini >= " + INPUT FRAME DEFAULT-FRAME dt-ini + " ".
    ASSIGN cWhere = cWhere + "AND tarefa.data-prev-ini <= " + INPUT FRAME DEFAULT-FRAME dt-fim + " NO-LOCK, ".
    ASSIGN cWhere = cWhere + "EACH money.favorecido OF money.tarefa NO-LOCK, ".
    ASSIGN cWhere = cWhere + "EACH money.ordem-serv OF money.tarefa NO-LOCK ".

    ASSIGN cBy = "BY tarefa.prioridade INDEXED-REPOSITION".

    /* Se a coluna clicada n∆o foi clicada anteriormente faáa */
    IF SELF :CURRENT-COLUMN :SORT-ASCENDING = ? THEN DO:
       SELF :CLEAR-SORT-ARROWS(). /* Limpa as setas das outras colunas */
       SELF :CURRENT-COLUMN :SORT-ASCENDING = FALSE. /* Ordena a coluna ascendentemente */
    END.
    /* Sen∆o ordena a coluna ao inverso do que j† est† ordenada */
    ELSE SELF :CURRENT-COLUMN :SORT-ASCENDING = NOT SELF :CURRENT-COLUMN :SORT-ASCENDING.

    IF SELF :CURRENT-COLUMN :NAME = "deApont" THEN DO:
        RETURN NO-APPLY.
    END.

    /* Armazena a coluna recem selecionada */
    IF SELF :CURRENT-COLUMN :SORT-ASCENDING = FALSE OR SELF :CURRENT-COLUMN :SORT-ASCENDING = TRUE THEN DO:
        CASE SELF :CURRENT-COLUMN :NAME:
            WHEN "cSituacao" THEN DO: /*Trata as funá‰es*/
                ASSIGN cBy = "BY tarefa.situacao".
            END.
            OTHERWISE DO: /*Campos padr∆o*/
                ASSIGN cBy = "BY " + SELF :CURRENT-COLUMN :NAME.
            END.
        END CASE.
    
        IF SELF :CURRENT-COLUMN :SORT-ASCENDING = TRUE THEN
            ASSIGN cBy = cBy + " DESCENDING.".
        ELSE
            ASSIGN cBy = cBy + ".".
    END.
    ELSE DO:
        SELF :CLEAR-SORT-ARROWS().
        RETURN.
    END.
    
    /* Executa a nova query para o Browse */
    ASSIGN hQuery = SELF :QUERY :HANDLE.
    hQuery:QUERY-PREPARE(cWhere + cBy).
    hQuery:QUERY-OPEN().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTarOS C-Win
ON VALUE-CHANGED OF brTarOS IN FRAME fProj /* Minhas Tarefas de Projeto */
DO:
  
    IF AVAIL tarefa THEN
        ASSIGN obs-tar-proj:SCREEN-VALUE IN FRAME fProj = tarefa.ds-observacao.
    ELSE
        ASSIGN obs-tar-proj:SCREEN-VALUE IN FRAME fProj = "".

    {&OPEN-QUERY-brApontProj}
    APPLY "VALUE-CHANGED" TO brApontProj.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brVisita
&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME brVisita
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brVisita C-Win
ON MOUSE-SELECT-DBLCLICK OF brVisita IN FRAME fTar /* Minhas Visitas */
DO:
  APPLY 'CHOOSE' TO btModVis.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brVisita C-Win
ON ROW-DISPLAY OF brVisita IN FRAME fTar /* Minhas Visitas */
DO:

    IF visita.dt-visita < TODAY THEN DO:
        ASSIGN visita.dt-visita:FGCOLOR IN BROWSE brVisita         = 12
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brVisita = 12
               visita.ds-visita:FGCOLOR IN BROWSE brVisita         = 12
               cSituacao:FGCOLOR IN BROWSE brVisita                = 12
               visita.hora-ini:FGCOLOR IN BROWSE brVisita          = 12
               visita.hora-fim:FGCOLOR IN BROWSE brVisita          = 12.
    END.

    IF visita.situacao = 8 /* Conclu°da */ THEN DO:
        ASSIGN visita.dt-visita:FGCOLOR IN BROWSE brVisita         = 2
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brVisita = 2
               visita.ds-visita:FGCOLOR IN BROWSE brVisita         = 2
               cSituacao:FGCOLOR IN BROWSE brVisita                = 2
               visita.hora-ini:FGCOLOR IN BROWSE brVisita          = 2
               visita.hora-fim:FGCOLOR IN BROWSE brVisita          = 2.
    END.

    IF visita.situacao = 9 /* Cancelada */ THEN DO:
        ASSIGN visita.dt-visita:FGCOLOR IN BROWSE brVisita         = 8
               favorecido.ds-favorecido:FGCOLOR IN BROWSE brVisita = 8
               visita.ds-visita:FGCOLOR IN BROWSE brVisita         = 8
               cSituacao:FGCOLOR IN BROWSE brVisita                = 8
               visita.hora-ini:FGCOLOR IN BROWSE brVisita          = 8
               visita.hora-fim:FGCOLOR IN BROWSE brVisita          = 8.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brVisita C-Win
ON VALUE-CHANGED OF brVisita IN FRAME fTar /* Minhas Visitas */
DO:
  
    IF AVAIL visita THEN
        ASSIGN obs-vis:SCREEN-VALUE IN FRAME fTar = visita.ds-observacao.
    ELSE
        ASSIGN obs-vis:SCREEN-VALUE IN FRAME fTar = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME btAnexos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAnexos C-Win
ON CHOOSE OF btAnexos IN FRAME fApont /* Anexos */
DO:

    IF AVAIL pedido-item THEN DO:        
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-pedido-item = ROWID(pedido-item).
        {func\run.i &Programa = "anexo.w"}    
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btApont C-Win
ON CHOOSE OF btApont IN FRAME DEFAULT-FRAME /* Pedidos */
DO:
  
    VIEW FRAME fApont.
    HIDE FRAME fPagto.
    HIDE FRAME fBen.
    HIDE FRAME fTar.
    HIDE FRAME fProj.
    HIDE FRAME fGer.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME btAtu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAtu C-Win
ON CHOOSE OF btAtu IN FRAME fProj /* Atualizar */
DO:
    IF AVAIL tarefa THEN DO:              
        ASSIGN r-parent = ROWID(usuario)
               r-tarefa = ROWID(tarefa)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "tarefa_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN calcCarga.
            {&OPEN-QUERY-brTarOS}
            APPLY "VALUE-CHANGED" TO brTarOS.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btBen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btBen C-Win
ON CHOOSE OF btBen IN FRAME DEFAULT-FRAME /* Benef°cios */
DO:
  
    VIEW FRAME fBen.
    HIDE FRAME fApont.
    HIDE FRAME fPagto.
    HIDE FRAME fTar.
    HIDE FRAME fProj.
    HIDE FRAME fGer.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btDesp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDesp C-Win
ON CHOOSE OF btDesp IN FRAME fTar /* Despesas */
DO:

    RUN som.p(INPUT "music\click.wav").
    IF AVAIL visita AND NOT visita.compromisso THEN DO:
        {func\run.i &Programa = "desp-viag.w (INPUT visita.sequencia)"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME btEli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btEli C-Win
ON CHOOSE OF btEli IN FRAME fApont /* Eliminar */
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

        RUN apont.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btEliComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btEliComp C-Win
ON CHOOSE OF btEliComp IN FRAME fTar /* Eliminar */
DO:
    ASSIGN glCompromisso = TRUE.
    IF AVAIL visita AND visita.compromisso THEN DO:
        {func\bt_del_page.i visita}
        {&OPEN-QUERY-brComp}
        APPLY "VALUE-CHANGED" TO brComp IN FRAME fTar.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME btEliProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btEliProj C-Win
ON CHOOSE OF btEliProj IN FRAME fProj /* Eliminar */
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

        FIND FIRST ordem-serv OF tarefa NO-LOCK NO-ERROR.
        IF AVAIL ordem-serv THEN DO:
            FIND FIRST pedido-item EXCLUSIVE-LOCK
                WHERE pedido-item.nr-pedido = ordem-serv.nr-pedido
                AND   pedido-item.sequencia = tarefa.seq-pedido-item NO-ERROR.
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

        END.

        APPLY "VALUE-CHANGED" TO brTarOS.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btEliTar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btEliTar C-Win
ON CHOOSE OF btEliTar IN FRAME fTar /* Eliminar */
DO:
    IF AVAIL tarefa THEN DO:
        {func\bt_del_page.i tarefa}
        {&OPEN-QUERY-brTarCRM}
        APPLY "VALUE-CHANGED" TO brTarCRM.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btEliVis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btEliVis C-Win
ON CHOOSE OF btEliVis IN FRAME fTar /* Eliminar */
DO:
    ASSIGN glCompromisso = FALSE.
    IF AVAIL visita AND visita.compromisso THEN DO:
        {func\bt_del_page.i visita}
        {&OPEN-QUERY-brVisita}
        APPLY "VALUE-CHANGED" TO brVisita IN FRAME fTar.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btGeral
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGeral C-Win
ON CHOOSE OF btGeral IN FRAME DEFAULT-FRAME /* Vis∆o Geral */
DO:
  
    VIEW FRAME fGer.
    HIDE FRAME fProj.
    HIDE FRAME fBen.
    HIDE FRAME fApont.
    HIDE FRAME fPagto.
    HIDE FRAME fTar.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME btInc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btInc C-Win
ON CHOOSE OF btInc IN FRAME fApont /* Incluir */
DO:

    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN pcActionBT = "ADD"
               r-parent = ROWID(usuario)
               giNr-pedido = pedido-item.nr-pedido
               giSequencia = pedido-item.sequencia
               giNome = ""
               giSeqTar = 0.
        {func\run.i &Programa = "apontamento_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN apont.
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btIncComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btIncComp C-Win
ON CHOOSE OF btIncComp IN FRAME fTar /* Incluir */
DO:

    RUN som.p(INPUT "music\click.wav").
    ASSIGN pcActionBT = "ADD"
           r-parent = ROWID(usuario)
           glCompromisso = TRUE.
    {func\run.i &Programa = "visita_det.w"}
    IF RETURN-VALUE = "OK" THEN DO:
        {&OPEN-QUERY-brComp}
        APPLY "VALUE-CHANGED" TO brComp IN FRAME fTar.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME btIncProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btIncProj C-Win
ON CHOOSE OF btIncProj IN FRAME fProj /* Incluir */
DO:

    IF AVAIL tarefa THEN DO:
        RUN som.p(INPUT "music\click.wav").
        FIND FIRST ordem-serv OF tarefa NO-LOCK NO-ERROR.
        IF AVAIL ordem-serv THEN DO:
            FIND FIRST pedido-item NO-LOCK
                WHERE pedido-item.nr-pedido = ordem-serv.nr-pedido
                AND   pedido-item.sequencia = tarefa.seq-pedido-item NO-ERROR.
            IF AVAIL pedido-item THEN DO:
                FIND FIRST usuario NO-LOCK
                    WHERE usuario.nome = gcUsuario.
                ASSIGN pcActionBT = "ADD"
                       r-parent = ROWID(usuario)
                       giNome = tarefa.nome
                       giSeqTar = tarefa.sequencia
                       giNr-pedido = pedido-item.nr-pedido
                       giSequencia = pedido-item.sequencia.
                {func\run.i &Programa = "apontamento_det.w"}
                IF RETURN-VALUE = "OK" THEN DO:
                    APPLY "VALUE-CHANGED" TO brTarOS.
                END.
            END.
            ELSE DO:
                {func\valida.i &Mensagem  = "Tarefa Avulsa!"
                               &Ajuda     = "Essa tarefa nao pemite apontamento por projeto. Contate o gestor de desenvolvimento e solicite liberaá∆o ou aponte diretamente no pedido."}
            END.
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btIncTar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btIncTar C-Win
ON CHOOSE OF btIncTar IN FRAME fTar /* Incluir */
DO:
    DO TRANS:
        
        FIND LAST bf-tarefa NO-LOCK
            WHERE bf-tarefa.nome = gcUsuario NO-ERROR.
    
        CREATE tarefa.
        ASSIGN tarefa.nome = gcUsuario
               tarefa.sequencia = (IF AVAIL bf-tarefa THEN bf-tarefa.sequencia + 1 ELSE 1)
               tarefa.dt-cri-tarefa = TODAY
               tarefa.responsavel = tarefa.nome.
               
        ASSIGN r-parent = ROWID(usuario)
               r-tarefa = ROWID(tarefa)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "tarefa_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-brTarCRM}
            APPLY "VALUE-CHANGED" TO brTarCRM.
        END.
        ELSE DO:
            UNDO, LEAVE.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btIncVis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btIncVis C-Win
ON CHOOSE OF btIncVis IN FRAME fTar /* Incluir */
DO:

    RUN som.p(INPUT "music\click.wav").
    ASSIGN pcActionBT = "ADD"
           r-parent = ROWID(usuario)
           glCompromisso = FALSE.
    {func\run.i &Programa = "visita_det.w"}
    IF RETURN-VALUE = "OK" THEN DO:
        {&OPEN-QUERY-brVisita}
        APPLY "VALUE-CHANGED" TO brVisita IN FRAME fTar.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME btMod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMod C-Win
ON CHOOSE OF btMod IN FRAME fApont /* Modificar */
DO:

    IF AVAIL apontamento THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-parent = ROWID(usuario)
               r-apontamento = ROWID(apontamento)
               pcActionBT = "UPDATE"
               giNome = ""
               giSeqTar = 0.
        {func\run.i &Programa = "apontamento_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN apont.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btModComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btModComp C-Win
ON CHOOSE OF btModComp IN FRAME fTar /* Modificar */
DO:
    IF AVAIL visita AND visita.compromisso THEN DO:              
        ASSIGN r-parent = ROWID(usuario)
               r-visita = ROWID(visita)
               pcActionBT = "UPDATE"
               glCompromisso = TRUE.
        {func\run.i &Programa = "visita_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-brComp}
            APPLY "VALUE-CHANGED" TO brComp IN FRAME fTar.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME btModProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btModProj C-Win
ON CHOOSE OF btModProj IN FRAME fProj /* Modificar */
DO:

    IF AVAIL apontamento THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-parent = ROWID(usuario)
               r-apontamento = ROWID(apontamento)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "apontamento_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            APPLY "VALUE-CHANGED" TO brTarOS.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fTar
&Scoped-define SELF-NAME btModTar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btModTar C-Win
ON CHOOSE OF btModTar IN FRAME fTar /* Modificar */
DO:
    IF AVAIL tarefa THEN DO:              
        ASSIGN r-parent = ROWID(usuario)
               r-tarefa = ROWID(tarefa)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "tarefa_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-brTarCRM}
            APPLY "VALUE-CHANGED" TO brTarCRM.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btModVis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btModVis C-Win
ON CHOOSE OF btModVis IN FRAME fTar /* Modificar */
DO:
    IF AVAIL visita AND NOT visita.compromisso THEN DO:              
        ASSIGN r-parent = ROWID(usuario)
               r-visita = ROWID(visita)
               pcActionBT = "UPDATE"
               glCompromisso = FALSE.
        {func\run.i &Programa = "visita_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-brVisita}
            APPLY "VALUE-CHANGED" TO brVisita IN FRAME fTar.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME btMovDown
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMovDown C-Win
ON CHOOSE OF btMovDown IN FRAME fProj /* - Prioridade */
DO:
    DEFINE VARIABLE iMaxPri AS INTEGER     NO-UNDO.
    DEFINE VARIABLE rTemp AS ROWID       NO-UNDO.
    
    IF AVAIL tarefa THEN DO:

        ASSIGN rTemp = ROWID(tarefa).

        SELECT MAX(prioridade) INTO iMaxPri FROM tarefa
            WHERE tarefa.responsavel = gcUsuario
            AND   tarefa.num-os <> 0
            AND   tarefa.situacao < 8 /* Conclu°da */.

        IF tarefa.prioridade < iMaxPri THEN DO:

            FIND FIRST bf-tarefa EXCLUSIVE-LOCK
                WHERE bf-tarefa.responsavel = gcUsuario
                AND   bf-tarefa.num-os <> 0
                AND   bf-tarefa.situacao < 8 /* Conclu°da */
                AND   bf-tarefa.prioridade = (tarefa.prioridade + 1) NO-ERROR.
            IF AVAIL bf-tarefa THEN
                ASSIGN bf-tarefa.prioridade = bf-tarefa.prioridade - 1.

            FIND CURRENT tarefa EXCLUSIVE-LOCK.
            ASSIGN tarefa.prioridade = tarefa.prioridade + 1.

            APPLY "CHOOSE" TO btRecalc.
            REPOSITION brTarOS TO ROWID rTemp.

        END.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMoveUp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMoveUp C-Win
ON CHOOSE OF btMoveUp IN FRAME fProj /* + Prioridade */
DO:
    DEFINE VARIABLE rTemp AS ROWID       NO-UNDO.

    IF AVAIL tarefa THEN DO:

        ASSIGN rTemp = ROWID(tarefa).

        IF tarefa.prioridade > 1 THEN DO:

            FIND FIRST bf-tarefa EXCLUSIVE-LOCK
                WHERE bf-tarefa.responsavel = gcUsuario
                AND   bf-tarefa.num-os <> 0
                AND   bf-tarefa.situacao < 8 /* Conclu°da */
                AND   bf-tarefa.prioridade = (tarefa.prioridade - 1) NO-ERROR.
            IF AVAIL bf-tarefa THEN
                ASSIGN bf-tarefa.prioridade = bf-tarefa.prioridade + 1.

            FIND CURRENT tarefa EXCLUSIVE-LOCK.
            ASSIGN tarefa.prioridade = tarefa.prioridade - 1.

            APPLY "CHOOSE" TO btRecalc.
            REPOSITION brTarOS TO ROWID rTemp.

        END.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btPagtos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPagtos C-Win
ON CHOOSE OF btPagtos IN FRAME DEFAULT-FRAME /* Pagamentos */
DO:
  
    VIEW FRAME fPagto.
    HIDE FRAME fApont.
    HIDE FRAME fBen.
    HIDE FRAME fTar.
    HIDE FRAME fProj.
    HIDE FRAME fGer.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btProj C-Win
ON CHOOSE OF btProj IN FRAME DEFAULT-FRAME /* Projetos */
DO:
  
    VIEW FRAME fProj.
    HIDE FRAME fBen.
    HIDE FRAME fApont.
    HIDE FRAME fPagto.
    HIDE FRAME fTar.
    HIDE FRAME fGer.

    {&OPEN-QUERY-brTarOS}
    APPLY "VALUE-CHANGED" TO brTarOS IN FRAME fProj.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fProj
&Scoped-define SELF-NAME btRecalc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRecalc C-Win
ON CHOOSE OF btRecalc IN FRAME fProj /* Recalcular */
DO:
    RUN calc_prioridade.p (INPUT gcUsuario, INPUT TODAY).
    RUN calcCarga.
    {&OPEN-QUERY-brTarOS}
    APPLY "VALUE-CHANGED" TO brTarOS.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btRelApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelApont C-Win
ON CHOOSE OF btRelApont IN FRAME DEFAULT-FRAME /* Apont */
DO:
    DEFINE VARIABLE iLinha AS INTEGER     NO-UNDO INITIAL 4.
    DEFINE VARIABLE c-apont AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE deTot AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE deGeral AS DECIMAL     NO-UNDO.
    
    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario NO-ERROR.
    IF NOT AVAIL usuario THEN RETURN "NOK".
    
    FIND FIRST favorecido OF usuario NO-LOCK NO-ERROR.
    IF NOT AVAIL favorecido THEN RETURN "NOK".
    
    DEFINE VARIABLE ch-excel     AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE ch-planilha  AS COM-HANDLE NO-UNDO.
    DEFINE VARIABLE ch-arquivo   AS COM-HANDLE NO-UNDO.
    
    CREATE "Excel.Application" ch-excel.
    ASSIGN ch-arquivo = ch-excel:Workbooks:Add().        
    ASSIGN ch-planilha = ch-arquivo:Sheets:Item(1).        

    /* Cabeáalho */
    ch-planilha:Cells(1, 1):Value = "Controle de Apontamentos: Tetra Consultoria".
    ch-planilha:Cells(1, 1):Font:Bold = True.
    ch-planilha:Cells(1, 1):Font:Size = 16.
    ch-planilha:Cells(1, 1):Font:ColorIndex = 30.
    ch-planilha:Cells(2, 1):Value = "Colaborador:".
    ch-planilha:Cells(2, 2):Value = favorecido.ds-favorecido.
    ch-planilha:Cells(2, 2):Font:Bold = True.
    ch-planilha:Cells(3, 1):Value = "Per°odo:".
    ch-planilha:Cells(3, 2):Value = INPUT FRAME {&FRAME-NAME} dt-ini.
    ch-planilha:Cells(3, 2):Font:Bold = True.
    ch-planilha:Cells(3, 3):Value = "atÇ".
    ch-planilha:Cells(3, 3):HorizontalAlignment = -4108.
    ch-planilha:Cells(3, 4):Value = INPUT FRAME {&FRAME-NAME} dt-fim.
    ch-planilha:Cells(3, 4):Font:Bold = True.

    ch-planilha:Columns("A"):ColumnWidth = 14.
    ch-planilha:Columns("B"):ColumnWidth = 11.
    ch-planilha:Columns("C"):ColumnWidth = 11.
    ch-planilha:Columns("D"):ColumnWidth = 12.
    ch-planilha:Columns("E"):ColumnWidth = 30.
    ch-planilha:Columns("F"):ColumnWidth = 30.
    ch-planilha:Columns("H"):ColumnWidth = 60.

    for each apontamento no-lock
        where apontamento.nome =  gcUsuario      
        and   apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini 
        and   apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim,
        each  pedido-item of apontamento no-lock,
        each item of pedido-item NO-LOCK
        where item.unidade matches "*HR*", 
        EACH pedido OF pedido-item,
        EACH favorecido OF pedido NO-LOCK
        break by apontamento.data:

        IF FIRST-OF(apontamento.data) THEN DO:
            ASSIGN iLinha = iLinha + 1.
            ch-planilha:Cells(iLinha, 1):Value = "Dia:".
            ch-planilha:Cells(iLinha, 1):HorizontalAlignment = -4152.
            ch-planilha:Cells(iLinha, 2):Value = apontamento.data.
            ch-planilha:Cells(iLinha, 2):Font:Bold = True.
            ASSIGN iLinha = iLinha + 2.
            ch-planilha:Cells(iLinha, 2):Value = "Hora Ini".
            ch-planilha:Cells(iLinha, 2):Font:Bold = True.
            ch-planilha:Cells(iLinha, 3):Value = "Hora Fim".
            ch-planilha:Cells(iLinha, 3):Font:Bold = True.
            ch-planilha:Cells(iLinha, 4):Value = "Cliente".
            ch-planilha:Cells(iLinha, 4):Font:Bold = True.
            ch-planilha:Cells(iLinha, 5):Value = "Projeto".
            ch-planilha:Cells(iLinha, 5):Font:Bold = True.
            ch-planilha:Cells(iLinha, 6):Value = "Item".
            ch-planilha:Cells(iLinha, 6):Font:Bold = True.
            ch-planilha:Cells(iLinha, 7):Value = "Qt Apont".
            ch-planilha:Cells(iLinha, 7):Font:Bold = True.
            ch-planilha:Cells(iLinha, 8):Value = "Observaá∆o".
            ch-planilha:Cells(iLinha, 8):Font:Bold = True.
            ASSIGN iLinha = iLinha + 1.
            ASSIGN deTot = 0.
        END.

        ASSIGN c-apont = REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " ")
               deTot = deTot + apontamento.qt-apontada
               deGeral = deGeral + apontamento.qt-apontada.

        ch-planilha:Cells(iLinha, 2):Value = apontamento.hora-ini.
        ch-planilha:Cells(iLinha, 2):HorizontalAlignment = -4108.
        ch-planilha:Cells(iLinha, 3):Value = apontamento.hora-fim.
        ch-planilha:Cells(iLinha, 3):HorizontalAlignment = -4108.
        ch-planilha:Cells(iLinha, 4):Value = favorecido.ds-favorecido.
        ch-planilha:Cells(iLinha, 5):Value = pedido.nom-projeto.
        ch-planilha:Cells(iLinha, 6):Value = pedido-item.ds-pedido-item.
        ch-planilha:Cells(iLinha, 7):Value = apontamento.qt-apontada.
        ch-planilha:Cells(iLinha, 7):HorizontalAlignment = -4108.
        ch-planilha:Cells(iLinha, 8):Value = c-apont.
        ASSIGN iLinha = iLinha + 1.

        IF LAST-OF(apontamento.data) THEN DO:
            ch-planilha:Cells(iLinha, 4):Value = "TOTAL".
            ch-planilha:Cells(iLinha, 4):Font:Bold = True.
            ch-planilha:Cells(iLinha, 7):Value = deTot.
            ch-planilha:Cells(iLinha, 7):Font:Bold = True.
            ch-planilha:Cells(iLinha, 7):HorizontalAlignment = -4108.
            ASSIGN iLinha = iLinha + 1.
        END.

    END.

    ASSIGN iLinha = iLinha + 1.
    ch-planilha:Cells(iLinha, 4):Value = "TOTAL DO PER÷ODO:".
    ch-planilha:Cells(iLinha, 4):Font:Bold = True.
    ch-planilha:Cells(iLinha, 7):Value = deGeral.
    ch-planilha:Cells(iLinha, 7):Font:Bold = True.
    ch-planilha:Cells(iLinha, 7):HorizontalAlignment = -4108.

    ch-Excel:VISIBLE = TRUE.

  
    IF VALID-HANDLE(ch-Excel) THEN
        RELEASE OBJECT ch-Excel NO-ERROR.

    IF VALID-HANDLE(ch-arquivo) THEN
        RELEASE OBJECT ch-arquivo NO-ERROR.

    IF VALID-HANDLE(ch-planilha) THEN
        RELEASE OBJECT ch-planilha NO-ERROR.

    RETURN "OK".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fApont
&Scoped-define SELF-NAME btRelPed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelPed C-Win
ON CHOOSE OF btRelPed IN FRAME fApont /* Relat¢rio */
DO:
    DEFINE VARIABLE deCont AS DECIMAL     NO-UNDO.

    IF AVAIL pedido THEN DO:
        RUN som.p(INPUT "music\click.wav").
        OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "rel_ped.txt") CONVERT TARGET "iso8859-1".

        FIND FIRST favorecido OF pedido NO-LOCK.

        PUT UNFORMATTED "====================================================================================================================================" SKIP
                        "Usu†rio: " cNome SKIP
                        "Pedido: " pedido.nr-pedido " - " favorecido.ds-favorecido " - " STRING(pedido.dt-pedido, "99/99/9999") " - " pedido.nom-projeto SKIP
                        "====================================================================================================================================".

        FOR EACH pedido-item OF pedido NO-LOCK:

            FIND FIRST item OF pedido-item NO-LOCK.

            PUT UNFORMATTED SKIP(2) "    Item: " pedido-item.ds-pedido-item SKIP(2).

            DISP "Data" @ apontamento.data
                 "Hr Ini" @ apontamento.hora-ini
                 "Hr Fim" @ apontamento.hora-fim
                 "Qt Apont" @ apontamento.qt-apont
                 "Descriá∆o" @ apontamento.ds-apontamento
                WITH FRAME f-pedido.
            DOWN WITH FRAME f-pedido.
            UNDERLINE apontamento.data
                 apontamento.hora-ini
                 apontamento.hora-fim
                 apontamento.qt-apont
                 apontamento.ds-apontamento
                WITH FRAME f-pedido.
            DOWN WITH FRAME f-pedido.

            ASSIGN deCont = 0.
            FOR EACH apontamento OF pedido-item
                WHERE apontamento.nome = cNome
                BY apontamento.data:

                ASSIGN cTemp = TRIM(REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " "))
                       cAux = SUBSTRING(cTemp, 1, 80).

                DISP apontamento.data
                     apontamento.hora-ini
                     apontamento.hora-fim
                     apontamento.qt-apont
                     cAux @ apontamento.ds-apontamento
                    WITH FRAME f-pedido.
                DOWN WITH FRAME f-pedido.
                ASSIGN deCont = deCont + apontamento.qt-apont.

                ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                IF cTemp <> "" THEN DO:
                    REPEAT:
                        ASSIGN cAux = SUBSTRING(cTemp, 1, 80).
                        DISP cAux @ apontamento.ds-apontamento
                            WITH FRAME f-pedido.
                        DOWN WITH FRAME f-pedido.
                        ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                        IF cTemp = "" THEN LEAVE.
                    END.
                END.

            END.

            PUT UNFORMATTED SKIP(2) 
                            "    ================================================================================================================================" SKIP
                            "    TOTAL de " pedido-item.ds-pedido-item ": " TRIM(STRING(deCont,"->>>,>>9.99")) SKIP
                            "    ================================================================================================================================".

        END.

        OUTPUT CLOSE.
        DOS SILENT VALUE("notepad.exe " + SESSION:TEMP-DIRECTORY + "rel_ped.txt").
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRelPed-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelPed-2 C-Win
ON CHOOSE OF btRelPed-2 IN FRAME fApont /* Geral */
DO:
    DEFINE VARIABLE deCont AS DECIMAL     NO-UNDO.

    IF AVAIL pedido THEN DO:
        RUN som.p(INPUT "music\click.wav").
        OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "rel_ped.txt") CONVERT TARGET "iso8859-1".

        FIND FIRST favorecido OF pedido NO-LOCK.

        PUT UNFORMATTED "====================================================================================================================================" SKIP
                        "Pedido: " pedido.nr-pedido " - " favorecido.ds-favorecido " - " STRING(pedido.dt-pedido, "99/99/9999") " - " pedido.nom-projeto SKIP
                        "====================================================================================================================================".

        FOR EACH pedido-item OF pedido NO-LOCK:

            FIND FIRST item OF pedido-item NO-LOCK.

            PUT UNFORMATTED SKIP(2) "    ITEM: " pedido-item.ds-pedido-item.

            ASSIGN deCont = 0.
            FOR EACH ordem-serv OF pedido NO-LOCK:
                FOR EACH tarefa OF ordem-serv
                    WHERE tarefa.seq-pedido-item = pedido-item.sequencia NO-LOCK:
                    IF CAN-FIND(FIRST apontamento
                                    WHERE apontamento.nome-tarefa = tarefa.nome
                                    AND   apontamento.seq-tarefa = tarefa.sequencia) THEN DO:

                        PUT UNFORMATTED SKIP(2) "    Tarefa: " tarefa.ds-tarefa SKIP(2).

                        DISP "Usu†rio" @ apontamento.nome
                             "Data" @ apontamento.data
                             "Hr Ini" @ apontamento.hora-ini
                             "Hr Fim" @ apontamento.hora-fim
                             "Qt Apont" @ apontamento.qt-apont
                             "Descriá∆o" @ apontamento.ds-apontamento
                            WITH FRAME f-pedido-g.
                        DOWN WITH FRAME f-pedido-g.
                        UNDERLINE apontamento.nome
                             apontamento.data
                             apontamento.hora-ini
                             apontamento.hora-fim
                             apontamento.qt-apont
                             apontamento.ds-apontamento
                            WITH FRAME f-pedido-g.
                        DOWN WITH FRAME f-pedido-g.

                        FOR EACH apontamento NO-LOCK
                            WHERE apontamento.nome-tarefa = tarefa.nome
                            AND   apontamento.seq-tarefa = tarefa.sequencia
                            BY apontamento.data:

                            ASSIGN cTemp = TRIM(REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " "))
                                   cAux = SUBSTRING(cTemp, 1, 80).

                            DISP apontamento.nome
                                 apontamento.data
                                 apontamento.hora-ini
                                 apontamento.hora-fim
                                 apontamento.qt-apont
                                 cAux @ apontamento.ds-apontamento
                                WITH FRAME f-pedido-g.
                            DOWN WITH FRAME f-pedido-g.
                            ASSIGN deCont = deCont + apontamento.qt-apont.

                            ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                            IF cTemp <> "" THEN DO:
                                REPEAT:
                                    ASSIGN cAux = SUBSTRING(cTemp, 1, 80).
                                    DISP cAux @ apontamento.ds-apontamento
                                        WITH FRAME f-pedido-g.
                                    DOWN WITH FRAME f-pedido-g.
                                    ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                                    IF cTemp = "" THEN LEAVE.
                                END.
                            END.

                        END.

                    END.
                END.
            END.

            IF CAN-FIND(FIRST apontamento OF pedido-item
                    WHERE (apontamento.nome-tarefa = ? OR apontamento.nome-tarefa = "")) THEN DO:

                PUT UNFORMATTED SKIP(2) "    Apontamentos sem Tarefa: " SKIP(2).

                DISP "Usu†rio" @ apontamento.nome
                     "Data" @ apontamento.data
                     "Hr Ini" @ apontamento.hora-ini
                     "Hr Fim" @ apontamento.hora-fim
                     "Qt Apont" @ apontamento.qt-apont
                     "Descriá∆o" @ apontamento.ds-apontamento
                    WITH FRAME f-pedido-g.
                DOWN WITH FRAME f-pedido-g.
                UNDERLINE apontamento.nome
                     apontamento.data
                     apontamento.hora-ini
                     apontamento.hora-fim
                     apontamento.qt-apont
                     apontamento.ds-apontamento
                    WITH FRAME f-pedido-g.
                DOWN WITH FRAME f-pedido-g.

                FOR EACH apontamento OF pedido-item NO-LOCK
                    WHERE (apontamento.nome-tarefa = ? OR apontamento.nome-tarefa = "")
                    BY apontamento.data:

                    ASSIGN cTemp = TRIM(REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " "))
                           cAux = SUBSTRING(cTemp, 1, 80).

                    DISP apontamento.nome
                         apontamento.data
                         apontamento.hora-ini
                         apontamento.hora-fim
                         apontamento.qt-apont
                         cAux @ apontamento.ds-apontamento
                        WITH FRAME f-pedido-g.
                    DOWN WITH FRAME f-pedido-g.
                    ASSIGN deCont = deCont + apontamento.qt-apont.

                    ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                    IF cTemp <> "" THEN DO:
                        REPEAT:
                            ASSIGN cAux = SUBSTRING(cTemp, 1, 80).
                            DISP cAux @ apontamento.ds-apontamento
                                WITH FRAME f-pedido-g.
                            DOWN WITH FRAME f-pedido-g.
                            ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                            IF cTemp = "" THEN LEAVE.
                        END.
                    END.

                END.

            END.

            PUT UNFORMATTED SKIP(2) 
                            "    ================================================================================================================================" SKIP
                            "    TOTAL de " pedido-item.ds-pedido-item ": " TRIM(STRING(deCont,"->>>,>>9.99")) SKIP
                            "    ================================================================================================================================".

        END.

        OUTPUT CLOSE.
        DOS SILENT VALUE("notepad.exe " + SESSION:TEMP-DIRECTORY + "rel_ped.txt").
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btRelPeR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelPeR C-Win
ON CHOOSE OF btRelPeR IN FRAME DEFAULT-FRAME /* Relat¢rio */
DO:
    DEFINE VARIABLE deCont AS DECIMAL     NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    EMPTY TEMP-TABLE tt-un.

    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "rel_per.txt") CONVERT TARGET "iso8859-1".
                    
    PUT UNFORMATTED "====================================================================================================================================" SKIP
                    "Usu†rio: " cNome SKIP
                    "Per°odo: " STRING(INPUT FRAME {&FRAME-NAME} dt-ini, "99/99/9999") " atÇ " STRING(INPUT FRAME {&FRAME-NAME} dt-fim, "99/99/9999") SKIP
                    "====================================================================================================================================".

    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome = cNome
        AND   apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini
        AND   apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim
        BREAK BY apontamento.nr-pedido
        BY apontamento.sequencia
        BY apontamento.data:

        IF FIRST-OF(apontamento.nr-pedido) THEN DO:

            FIND FIRST pedido OF apontamento NO-LOCK.
            FIND FIRST favorecido OF pedido NO-LOCK.

            PUT UNFORMATTED SKIP(2)
                            "    ================================================================================================================================" SKIP
                            "    Pedido: " pedido.nr-pedido " - " favorecido.ds-favorecido " - " STRING(pedido.dt-pedido, "99/99/9999") " - " pedido.nom-projeto SKIP
                            "    ================================================================================================================================".

            EMPTY TEMP-TABLE tt-ped.

        END.

        IF FIRST-OF(apontamento.sequencia) THEN DO:

            FIND FIRST pedido-item OF apontamento NO-LOCK.
            FIND FIRST item OF pedido-item NO-LOCK.

            PUT UNFORMATTED SKIP(2)
                            "         -------------------------------------" SKIP
                            "         Item: " pedido-item.ds-pedido-item SKIP
                            "         -------------------------------------" SKIP(2).

            ASSIGN deCont = 0.

            DISP "Data" @ apontamento.data
                 "Hr Ini" @ apontamento.hora-ini
                 "Hr Fim" @ apontamento.hora-fim
                 "Qt Apont" @ apontamento.qt-apont
                 "Descriá∆o" @ apontamento.ds-apontamento
                WITH FRAME f-periodo.
            DOWN WITH FRAME f-periodo.
            UNDERLINE apontamento.data
                 apontamento.hora-ini
                 apontamento.hora-fim
                 apontamento.qt-apont
                 apontamento.ds-apontamento
                WITH FRAME f-periodo.
            DOWN WITH FRAME f-periodo.

        END.

        ASSIGN cTemp = TRIM(REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " "))
               cAux = SUBSTRING(cTemp, 1, 80).

        DISP apontamento.data
             apontamento.hora-ini
             apontamento.hora-fim
             apontamento.qt-apont
             cAux @ apontamento.ds-apontamento
            WITH FRAME f-periodo.
        DOWN WITH FRAME f-periodo.
        ASSIGN deCont = deCont + apontamento.qt-apont.

        ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
        IF cTemp <> "" THEN DO:
            REPEAT:
                ASSIGN cAux = SUBSTRING(cTemp, 1, 80).
                DISP cAux @ apontamento.ds-apontamento
                    WITH FRAME f-periodo.
                DOWN WITH FRAME f-periodo.
                ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                IF cTemp = "" THEN LEAVE.
            END.
        END.

        FIND FIRST tt-un
            WHERE tt-un.un = item.un NO-ERROR.
        IF NOT AVAIL tt-un THEN DO:
            CREATE tt-un.
            ASSIGN tt-un.un = item.un.
        END.
        IF NOT pedido-item.hora-fechada THEN
            ASSIGN tt-un.qt = tt-un.qt + apontamento.qt-apont.
        ELSE DO:
            IF LAST-OF(apontamento.sequencia) THEN
                ASSIGN tt-un.qt = tt-un.qt + pedido-item.qt-liberada.
        END.

        FIND FIRST tt-ped
            WHERE tt-ped.un = item.un NO-ERROR.
        IF NOT AVAIL tt-ped THEN DO:
            CREATE tt-ped.
            ASSIGN tt-ped.un = item.un.
        END.
        IF NOT pedido-item.hora-fechada THEN
            ASSIGN tt-ped.qt = tt-ped.qt + apontamento.qt-apont.
        ELSE DO:
            IF LAST-OF(apontamento.sequencia) THEN
                ASSIGN tt-ped.qt = tt-ped.qt + pedido-item.qt-liberada.
        END.

        IF LAST-OF(apontamento.sequencia) THEN DO:
            PUT UNFORMATTED SKIP(2) 
                            "         -------------------------------------" SKIP
                            "         Total de " pedido-item.ds-pedido-item ": " TRIM(STRING(deCont,"->>>,>>9.99")) SKIP
                            "         -------------------------------------".
        END.

        IF LAST-OF(apontamento.nr-pedido) THEN DO:
            PUT UNFORMATTED SKIP(2)
                            "         -------------------------------------" SKIP
                            "         TOTAL DO PEDIDO: " SKIP(1).
            FOR EACH tt-ped:
                PUT UNFORMATTED "              " CAPS(tt-ped.un) ": " TRIM(STRING(tt-ped.qt,"->>>,>>9.99")) SKIP.
            END.
            PUT UNFORMATTED SKIP(1) "         -------------------------------------" SKIP.
        END.

    END.

    PUT UNFORMATTED SKIP(2)
                    "    ================================================================================================================================" SKIP
                    "    TOTAL APONTADO NO PER÷ODO: " SKIP(1).

    FOR EACH tt-un:
        PUT UNFORMATTED "         " CAPS(tt-un.un) ": " TRIM(STRING(tt-un.qt,"->>>,>>9.99")) SKIP.
    END.

    PUT UNFORMATTED SKIP(1) "    ================================================================================================================================".

    OUTPUT CLOSE.
    DOS SILENT VALUE("notepad.exe " + SESSION:TEMP-DIRECTORY + "rel_per.txt").
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRelPeR-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelPeR-2 C-Win
ON CHOOSE OF btRelPeR-2 IN FRAME DEFAULT-FRAME /* Geral */
DO:
    DEFINE VARIABLE deCont AS DECIMAL     NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    EMPTY TEMP-TABLE tt-un.

    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "rel_per.txt") CONVERT TARGET "iso8859-1".

    PUT UNFORMATTED "====================================================================================================================================" SKIP
                    "Per°odo: " STRING(INPUT FRAME {&FRAME-NAME} dt-ini, "99/99/9999") " atÇ " STRING(INPUT FRAME {&FRAME-NAME} dt-fim, "99/99/9999") SKIP
                    "====================================================================================================================================".

    FOR EACH apontamento NO-LOCK
        WHERE apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini
        AND   apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim
        BREAK BY apontamento.nr-pedido
        BY apontamento.sequencia
        BY apontamento.data:

        IF FIRST-OF(apontamento.nr-pedido) THEN DO:

            FIND FIRST pedido OF apontamento NO-LOCK.
            FIND FIRST favorecido OF pedido NO-LOCK.

            PUT UNFORMATTED SKIP(2)
                            "    ================================================================================================================================" SKIP
                            "    Pedido: " pedido.nr-pedido " - " favorecido.ds-favorecido " - " STRING(pedido.dt-pedido, "99/99/9999") " - " pedido.nom-projeto SKIP
                            "    ================================================================================================================================".

            EMPTY TEMP-TABLE tt-ped.

        END.

        IF FIRST-OF(apontamento.sequencia) THEN DO:

            FIND FIRST pedido-item OF apontamento NO-LOCK.
            FIND FIRST item OF pedido-item NO-LOCK.

            PUT UNFORMATTED SKIP(2)
                            "         -------------------------------------" SKIP
                            "         Item: " pedido-item.ds-pedido-item SKIP
                            "         -------------------------------------" SKIP(2).

            ASSIGN deCont = 0.

            DISP "Usu†rio" @ apontamento.nome
                 "Data" @ apontamento.data
                 "Hr Ini" @ apontamento.hora-ini
                 "Hr Fim" @ apontamento.hora-fim
                 "Qt Apont" @ apontamento.qt-apont
                 "Descriá∆o" @ apontamento.ds-apontamento
                WITH FRAME f-periodo-g.
            DOWN WITH FRAME f-periodo-g.
            UNDERLINE apontamento.nome
                 apontamento.data
                 apontamento.hora-ini
                 apontamento.hora-fim
                 apontamento.qt-apont
                 apontamento.ds-apontamento
                WITH FRAME f-periodo-g.
            DOWN WITH FRAME f-periodo-g.

        END.

        ASSIGN cTemp = TRIM(REPLACE(REPLACE(apontamento.ds-apontamento, CHR(10), " "), CHR(13), " "))
               cAux = SUBSTRING(cTemp, 1, 80).

        DISP apontamento.nome
             apontamento.data
             apontamento.hora-ini
             apontamento.hora-fim
             apontamento.qt-apont
             cAux @ apontamento.ds-apontamento
            WITH FRAME f-periodo-g.
        DOWN WITH FRAME f-periodo-g.
        ASSIGN deCont = deCont + apontamento.qt-apont.

        ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
        IF cTemp <> "" THEN DO:
            REPEAT:
                ASSIGN cAux = SUBSTRING(cTemp, 1, 80).
                DISP cAux @ apontamento.ds-apontamento
                    WITH FRAME f-periodo-g.
                DOWN WITH FRAME f-periodo-g.
                ASSIGN cTemp = SUBSTRING(cTemp, 81, LENGTH(cTemp)).
                IF cTemp = "" THEN LEAVE.
            END.
        END.

        FIND FIRST tt-un
            WHERE tt-un.un = item.un NO-ERROR.
        IF NOT AVAIL tt-un THEN DO:
            CREATE tt-un.
            ASSIGN tt-un.un = item.un.
        END.
        IF NOT pedido-item.hora-fechada THEN
            ASSIGN tt-un.qt = tt-un.qt + apontamento.qt-apont.
        ELSE DO:
            IF LAST-OF(apontamento.sequencia) THEN
                ASSIGN tt-un.qt = tt-un.qt + pedido-item.qt-liberada.
        END.

        FIND FIRST tt-ped
            WHERE tt-ped.un = item.un NO-ERROR.
        IF NOT AVAIL tt-ped THEN DO:
            CREATE tt-ped.
            ASSIGN tt-ped.un = item.un.
        END.
        IF NOT pedido-item.hora-fechada THEN
            ASSIGN tt-ped.qt = tt-ped.qt + apontamento.qt-apont.
        ELSE DO:
            IF LAST-OF(apontamento.sequencia) THEN
                ASSIGN tt-ped.qt = tt-ped.qt + pedido-item.qt-liberada.
        END.

        IF LAST-OF(apontamento.sequencia) THEN DO:
            PUT UNFORMATTED SKIP(2) 
                            "         -------------------------------------" SKIP
                            "         Total de " pedido-item.ds-pedido-item ": " TRIM(STRING(deCont,"->>>,>>9.99")) SKIP
                            "         -------------------------------------".
        END.

        IF LAST-OF(apontamento.nr-pedido) THEN DO:
            PUT UNFORMATTED SKIP(2)
                            "         -------------------------------------" SKIP
                            "         TOTAL DO PEDIDO: " SKIP(1).
            FOR EACH tt-ped:
                PUT UNFORMATTED "              " CAPS(tt-ped.un) ": " TRIM(STRING(tt-ped.qt,"->>>,>>9.99")) SKIP.
            END.
            PUT UNFORMATTED SKIP(1) "         -------------------------------------" SKIP.
        END.

    END.

    PUT UNFORMATTED SKIP(2)
                    "    ================================================================================================================================" SKIP
                    "    TOTAL APONTADO NO PER÷ODO: " SKIP(1).

    FOR EACH tt-un:
        PUT UNFORMATTED "         " CAPS(tt-un.un) ": " TRIM(STRING(tt-un.qt,"->>>,>>9.99")) SKIP.
    END.

    PUT UNFORMATTED SKIP(1) "    ================================================================================================================================".

    OUTPUT CLOSE.
    DOS SILENT VALUE("notepad.exe " + SESSION:TEMP-DIRECTORY + "rel_per.txt").
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRelRes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelRes C-Win
ON CHOOSE OF btRelRes IN FRAME DEFAULT-FRAME /* Resumo */
DO:
    RUN gera-resumo.p (INPUT cNome,
                       INPUT INPUT FRAME {&FRAME-NAME} dt-ini,
                       INPUT INPUT FRAME {&FRAME-NAME} dt-fim).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btTar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btTar C-Win
ON CHOOSE OF btTar IN FRAME DEFAULT-FRAME /* Adm/Comercial */
DO:
  
    VIEW FRAME fTar.
    HIDE FRAME fBen.
    HIDE FRAME fApont.
    HIDE FRAME fPagto.
    HIDE FRAME fProj.
    HIDE FRAME fGer.

    {&OPEN-QUERY-brTarCRM}
    APPLY "VALUE-CHANGED" TO brTarCRM IN FRAME fTar.
    {&OPEN-QUERY-brVisita}
    APPLY "VALUE-CHANGED" TO brVisita IN FRAME fTar.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dt-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-fim C-Win
ON LEAVE OF dt-fim IN FRAME DEFAULT-FRAME
DO:

    RUN dispDados.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dt-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-ini C-Win
ON LEAVE OF dt-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:

    RUN dispDados.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME l-pend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL l-pend C-Win
ON VALUE-CHANGED OF l-pend IN FRAME DEFAULT-FRAME /* Somente Pendentes */
DO:

    RUN dispDados.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAgend
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
  {version.i USUAR_APONT}
  RUN initialize.
  RUN enable_UI.
  RUN afterDisplay.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterDisplay C-Win 
PROCEDURE afterDisplay :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE hColumn AS HANDLE      NO-UNDO.

    IF CAN-FIND(FIRST usuario-prog
                WHERE usuario-prog.nome = cNome
                AND   usuario-prog.programa = "PEDIDO.W") THEN DO:
        ASSIGN hColumn = brPed:GET-BROWSE-COLUMN(6) IN FRAME fApont
               hColumn:VISIBLE = FALSE
               btRelPed-2:VISIBLE IN FRAME fApont = FALSE
               btRelPer-2:VISIBLE IN FRAME DEFAULT-FRAME = FALSE.
    END.

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario NO-ERROR.
    FIND FIRST favorecido OF usuario NO-LOCK.

    IF favorecido.foto <> "" 
    AND SEARCH(favorecido.foto) <> ? THEN
        image-4:LOAD-IMAGE(SEARCH(favorecido.foto)) IN FRAME DEFAULT-FRAME.
    ELSE
        image-4:LOAD-IMAGE(SEARCH("image\im-naodisp.bmp")) IN FRAME DEFAULT-FRAME.

    DISPLAY favorecido.ds-favorecido
            favorecido.data-nasc
        WITH FRAME {&FRAME-NAME}.

    RUN dispDados.

    APPLY "CHOOSE" TO btGeral.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE apont C-Win 
PROCEDURE apont :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN deTotM = 0
           deTotO = 0.

    IF AVAIL pedido-item THEN DO:
        FOR EACH apontamento NO-LOCK
            WHERE apontamento.nr-pedido = pedido-item.nr-pedido
            AND apontamento.sequencia = pedido-item.sequencia
            AND apontamento.data >= INPUT FRAME {&FRAME-NAME} dt-ini
            AND apontamento.data <= INPUT FRAME {&FRAME-NAME} dt-fim:
            IF apontamento.nome = cNome THEN
                ASSIGN deTotM = deTotM + apontamento.qt-apontada.
            ELSE
                ASSIGN deTotO = deTotO + apontamento.qt-apontada.
        END.
    END.

    DISPLAY deTotM
            deTotO
        WITH FRAME fApont.

    {&OPEN-QUERY-brApont}
    APPLY "VALUE-CHANGED" TO brApont IN FRAME fApont.

    {&OPEN-QUERY-brOutros}

    IF deTotM > 0 THEN
        ENABLE btMod
               btEli
            WITH FRAME fApont.
    ELSE
        DISABLE btMod
                btEli
            WITH FRAME fApont.

    IF AVAIL pedido-item THEN DO:
        FIND CURRENT pedido-item NO-LOCK.
        DISPLAY pedido-item.qt-atend WITH BROWSE brItem.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcCarga C-Win 
PROCEDURE calcCarga :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN carga = 0.
FOR EACH tarefa NO-LOCK
      WHERE tarefa.responsavel = gcUsuario
      AND   tarefa.situacao < 8
      AND tarefa.num-os <> 0
      AND tarefa.data-prev-ini >= INPUT FRAME DEFAULT-FRAME dt-ini
      AND tarefa.data-prev-ini <= INPUT FRAME DEFAULT-FRAME dt-fim:
    ASSIGN carga = carga + (tarefa.qtd-horas * ((100 - tarefa.perc-con) / 100)).
END.
DISP carga
    WITH FRAME fProj.

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

OCXFile = SEARCH( "usuar_apont.wrx":U ).
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
ELSE MESSAGE "usuar_apont.wrx":U SKIP(1)
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE dispDados C-Win 
PROCEDURE dispDados :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    /* Vis∆o Geral */
    RUN pend.

    /* Projetos */
    RUN calcCarga.
    {&OPEN-QUERY-brTarOS}
    APPLY "VALUE-CHANGED" TO brTarOS IN FRAME fProj.

    /* Pedidos */
    {&OPEN-QUERY-brPed}
    APPLY "VALUE-CHANGED" TO brPed IN FRAME fApont.
    RUN apont.

    /* Adm/Comercial */
    {&OPEN-QUERY-brTarCRM}
    APPLY "VALUE-CHANGED" TO brTarCRM IN FRAME fTar.
    {&OPEN-QUERY-brVisita}
    APPLY "VALUE-CHANGED" TO brVisita IN FRAME fTar.
    {&OPEN-QUERY-brComp}
    APPLY "VALUE-CHANGED" TO brComp IN FRAME fTar.

    /* Pagamentos */
    RUN pagtos.
    {&OPEN-QUERY-brMov}
    {&OPEN-QUERY-brAgend}

    /* Benef°cios */
    RUN reemb.
    {&OPEN-QUERY-brBenef}
    {&OPEN-QUERY-brTre}
    {&OPEN-QUERY-brViag}
    {&OPEN-QUERY-brDesp}

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario.

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
  DISPLAY dt-ini dt-fim l-pend cNome 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.ds-favorecido favorecido.data-nasc 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE dt-ini dt-fim l-pend btRelApont btRelPeR btRelPeR-2 btGeral btApont 
         btProj btTar favorecido.ds-favorecido btPagtos btBen 
         favorecido.data-nasc btRelRes RECT-7 IMAGE-1 IMAGE-2 IMAGE-3 IMAGE-4 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY deTotO deTotM 
      WITH FRAME fApont IN WINDOW C-Win.
  ENABLE brPed brItem btAnexos brApont btRelPed btRelPed-2 brOutros btInc btMod 
         btEli 
      WITH FRAME fApont IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fApont}
  DISPLAY de-tot-reemb 
      WITH FRAME fBen IN WINDOW C-Win.
  ENABLE brBenef brViag brDesp brTre 
      WITH FRAME fBen IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fBen}
  DISPLAY de-fat de-lucr de-ppr 
      WITH FRAME fGer IN WINDOW C-Win.
  ENABLE IMAGE-5 brPendAtras brPendHoje brPendFut de-fat de-lucr de-ppr 
      WITH FRAME fGer IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fGer}
  DISPLAY de-tot-pag de-tot-agend 
      WITH FRAME fPagto IN WINDOW C-Win.
  ENABLE brMov brAgend 
      WITH FRAME fPagto IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPagto}
  DISPLAY obs-apont-proj obs-tar-proj carga 
      WITH FRAME fProj IN WINDOW C-Win.
  ENABLE brTarOS brApontProj obs-apont-proj obs-tar-proj btMoveUp btMovDown 
         btAtu btRecalc btIncProj btModProj btEliProj 
      WITH FRAME fProj IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fProj}
  DISPLAY obs-vis obs-tar obs-comp 
      WITH FRAME fTar IN WINDOW C-Win.
  ENABLE brTarCRM brVisita obs-vis btIncVis btModVis btEliVis btDesp brComp 
         obs-tar obs-comp btIncTar btModTar btEliTar btIncComp btModComp 
         btEliComp 
      WITH FRAME fTar IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fTar}
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

    FIND FIRST usuario
        WHERE usuario.nome = gcUsuario NO-LOCK NO-ERROR.
    FIND FIRST favorecido OF usuario NO-LOCK.

    ASSIGN cNome = usuario.nome
           dt-ini = DATE(MONTH(TODAY), 1, YEAR(TODAY))
           dt-fim = fnUltimoDia(MONTH(TODAY), YEAR(TODAY)).
           
    CASE (DAY(TODAY) MOD 10):
        WHEN 0 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\Quota.png") IN FRAME fGer.
        WHEN 1 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\Caixa.png") IN FRAME fGer.
        WHEN 2 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\Descontos.png") IN FRAME fGer.
        WHEN 3 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\DistFaturamento.png") IN FRAME fGer.
        WHEN 4 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\Faturamento.png") IN FRAME fGer.
        WHEN 5 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\HorasProjetos.png") IN FRAME fGer.
        WHEN 6 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\NPS.png") IN FRAME fGer.
        WHEN 7 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\Propostas.png") IN FRAME fGer.
        WHEN 8 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\RentProjetos.png") IN FRAME fGer.
        WHEN 9 THEN IMAGE-5:LOAD-IMAGE("\\10.0.0.101\Administrativo\Documentos\Indicadores\Atendimentos.png") IN FRAME fGer.
    END CASE.

    ASSIGN C-Win:WINDOW-STATE = WINDOW-MAXIMIZED.
    APPLY "WINDOW-RESIZED" TO C-Win.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pagtos C-Win 
PROCEDURE pagtos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario NO-ERROR.

    ASSIGN de-tot-pag = 0.
    FOR EACH bf-mov NO-LOCK
        WHERE (bf-mov.cd-conta = 1 OR bf-mov.cd-conta = 4)
        AND   bf-mov.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
        AND   bf-mov.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
        AND   bf-mov.id-tipo <> 0
        AND  (bf-mov.cod-categoria = 0
        OR   (bf-mov.cod-categoria = 4
          AND bf-mov.cd-sub <> 2
          AND bf-mov.cd-sub <> 5
          AND bf-mov.cd-sub <> 6
          AND bf-mov.cd-sub <> 10
          AND bf-mov.cd-sub <> 11)
        OR    bf-mov.cod-categoria = 7)
        AND  (bf-mov.usuar-resp = usuario.nome
           OR bf-mov.cd-favorecido = usuario.cd-favorecido):
        ASSIGN de-tot-pag = de-tot-pag - bf-mov.de-valor.
    END.

    ASSIGN de-tot-agend = 0.
    FOR EACH agenda NO-LOCK
        WHERE (agenda.usuar-resp = usuario.nome
            OR agenda.cd-favorecido = usuario.cd-favorecido)
        AND    agenda.prox-data-pag <= agenda.dt-fim
        AND agenda.prox-data-pag >= INPUT FRAME {&FRAME-NAME} dt-ini
        AND agenda.prox-data-pag <= INPUT FRAME {&FRAME-NAME} dt-fim
         AND   (agenda.cod-categoria = 0
            OR (agenda.cod-categoria = 4
            AND agenda.cd-sub <> 2
            AND agenda.cd-sub <> 5
            AND agenda.cd-sub <> 6
            AND agenda.cd-sub <> 10
            AND agenda.cd-sub <> 11)
            OR agenda.cod-categoria = 7),
            EACH agenda-valor NO-LOCK
            WHERE agenda-valor.cd-agenda = agenda.cd-agenda
            AND   agenda-valor.dt-ini <= agenda.prox-data-pag
            AND   agenda-valor.dt-end >= agenda.prox-data-pag:
        ASSIGN de-tot-agend = de-tot-agend + IF agenda.vl-atual = 0 THEN (agenda-valor.valor * -1) ELSE (agenda.vl-atual * -1).
    END.

    DISPLAY de-tot-pag
            de-tot-agend
        WITH FRAME fPagto.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pend C-Win 
PROCEDURE pend :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE deMetaFat AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE i-aux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE deMetaLucr AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE deDesp AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE de-fat-ano AS DECIMAL     NO-UNDO.

    RUN gerapend.p (INPUT gcUsuario,
                    INPUT INPUT FRAME default-frame dt-ini,
                    INPUT INPUT FRAME default-frame dt-fim,
                    OUTPUT TABLE tt-pend).
    
    ASSIGN de-fat = 0
           de-lucr = 0
           de-ppr = 0.
    FOR EACH mov-conta NO-LOCK
        WHERE YEAR(mov-conta.dt-mov) = YEAR(TODAY)
        AND   mov-conta.id-tipo <> 0
        AND   mov-conta.id-tipo <> 3
        AND   mov-conta.de-valor > 0:

        ASSIGN de-fat = de-fat + mov-conta.de-valor.

    END.
    ASSIGN de-fat-ano = (de-fat / MONTH(TODAY)) * 12.
    FIND FIRST meta NO-LOCK
        WHERE meta.ds-meta BEGINS("Faturamento")
        AND   meta.ano = YEAR(TODAY) NO-ERROR.
    IF AVAIL meta THEN DO:
        REPEAT i-aux = 1 TO 12:
            ASSIGN deMetaFat = deMetaFat + meta.val-meta[i-aux].
        END.
    END.

    FIND FIRST meta NO-LOCK
        WHERE meta.ds-meta BEGINS("Lucro")
        AND   meta.ano = YEAR(TODAY) NO-ERROR.
    IF AVAIL meta THEN DO:
        ASSIGN deMetaLucr = meta.val-meta[1].
    END.

    REPEAT i-aux = 1 TO MONTH(TODAY):
        RUN renddesp.p (INPUT (IF i-aux = MONTH(TODAY) THEN TODAY ELSE fnUltimoDia(i-aux, YEAR(TODAY))),
                        INPUT 0, OUTPUT deDesp).
        ASSIGN de-lucr = de-lucr + deDesp.
    END.
    ASSIGN de-lucr = (de-lucr / de-fat-ano) * 100.

    IF de-fat < deMetaFat THEN
        ASSIGN chCtrlFrame:ProgressBar:MAX = deMetaFat NO-ERROR.
    ELSE
        IF de-fat < (deMetaFat + 250000) THEN
            ASSIGN chCtrlFrame:ProgressBar:MAX = deMetaFat + 250000 NO-ERROR.
        ELSE
            ASSIGN chCtrlFrame:ProgressBar:MAX = de-fat NO-ERROR.

    ASSIGN chCtrlFrame:ProgressBar:VALUE = de-fat.

    IF de-lucr < deMetaLucr THEN
        ASSIGN chCtrlFrame-2:ProgressBar:MAX = deMetaLucr NO-ERROR.
    ELSE
        ASSIGN chCtrlFrame-2:ProgressBar:MAX = de-lucr NO-ERROR.

    IF de-lucr >= 0 THEN
        ASSIGN chCtrlFrame-2:ProgressBar:VALUE = de-lucr NO-ERROR.

    ASSIGN de-ppr = 0.
    FOR EACH agenda NO-LOCK
        WHERE (agenda.usuar-resp = usuario.nome
            OR agenda.cd-favorecido = usuario.cd-favorecido)
        AND    agenda.prox-data-pag <= agenda.dt-fim
        AND   agenda.cod-categoria = 4
        AND   agenda.cd-sub = 4,
            EACH agenda-valor NO-LOCK
            WHERE agenda-valor.cd-agenda = agenda.cd-agenda
            AND   agenda-valor.dt-ini <= fnUltimoDia(12, YEAR(TODAY))
            AND   agenda-valor.dt-end >= fnUltimoDia(12, YEAR(TODAY)):
        ASSIGN de-ppr = agenda-valor.valor * -1.
    END.

    IF de-fat-ano < deMetaFat THEN
        ASSIGN de-ppr = de-ppr * 0.
    ELSE
        IF de-fat-ano < (deMetaFat + 250000) THEN
            ASSIGN de-ppr = de-ppr * 1.
        ELSE
            IF de-fat-ano < (deMetaFat + 500000) THEN
                ASSIGN de-ppr = de-ppr * 2.
            ELSE
                ASSIGN de-ppr = de-ppr * 3.

    IF de-lucr <= 0 THEN
        ASSIGN de-ppr = de-ppr * 0.0.
    ELSE
        IF de-lucr < 3 THEN
            ASSIGN de-ppr = de-ppr * 0.2.
        ELSE
            IF de-lucr < 6 THEN
                ASSIGN de-ppr = de-ppr * 0.4.
            ELSE
                IF de-lucr < 9 THEN
                    ASSIGN de-ppr = de-ppr * 0.6.
                ELSE
                    IF de-lucr < 12 THEN
                        ASSIGN de-ppr = de-ppr * 0.8.
                    ELSE
                        ASSIGN de-ppr = de-ppr * 1.0.

    DISP de-fat
         de-lucr
         de-ppr
        WITH FRAME fGer.

    {&OPEN-QUERY-brPendAtras}
    {&OPEN-QUERY-brPendHoje}
    {&OPEN-QUERY-brPendFut}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pesq_ped C-Win 
PROCEDURE pesq_ped :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN cRowid = "".

FOR EACH pedido NO-LOCK
      WHERE (IF INPUT FRAME DEFAULT-FRAME l-Pend THEN pedido.situacao <= 2 ELSE (
          pedido.dt-pedido >= INPUT FRAME DEFAULT-FRAME dt-ini
          AND pedido.dt-pedido <= INPUT FRAME DEFAULT-FRAME dt-fim)):
      
      FOR EACH pedido-item OF pedido
            WHERE (IF INPUT FRAME DEFAULT-FRAME l-Pend THEN pedido-item.situacao <= 2 ELSE TRUE):
            
            IF CAN-FIND(FIRST pedido-item-usu OF pedido-item
                        WHERE pedido-item-usu.nome = INPUT FRAME DEFAULT-FRAME cNome) THEN DO:
                        
                IF cRowid = "" THEN
                    ASSIGN cRowid = STRING(ROWID(pedido)).
                ELSE
                    ASSIGN cRowid = cRowid + "," + STRING(ROWID(pedido)).
                        
                        
            END.
            
      END.
      
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE reemb C-Win 
PROCEDURE reemb :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN de-tot-reemb = 0.
    FOR EACH bf-mov NO-LOCK
        WHERE bf-mov.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome
        AND   bf-mov.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
        AND   bf-mov.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
        AND   bf-mov.cod-categoria = 11,
      EACH favorecido OF bf-mov NO-LOCK,
      EACH usuario OF favorecido
      WHERE usuario.nome = gcUsuario NO-LOCK:
        ASSIGN de-tot-reemb = de-tot-reemb - bf-mov.de-valor.
    END.

    FOR EACH bf-mov NO-LOCK
        WHERE bf-mov.usuar-resp = INPUT FRAME {&FRAME-NAME} cNome
        AND   bf-mov.dt-mov >= INPUT FRAME {&FRAME-NAME} dt-ini
        AND   bf-mov.dt-mov <= INPUT FRAME {&FRAME-NAME} dt-fim
        AND   bf-mov.id-tipo <> 0
        AND   bf-mov.cod-categoria <> 0
        AND   bf-mov.cod-categoria <> 1
        AND   bf-mov.cod-categoria <> 4
        AND   bf-mov.cod-categoria <> 7
        AND   bf-mov.cod-categoria <> 11
        AND   bf-mov.cod-categoria <> 12
        AND   bf-mov.cod-categoria <> 13:
        ASSIGN de-tot-reemb = de-tot-reemb - bf-mov.de-valor.
    END.

    DISP de-tot-reemb
        WITH FRAME fBen.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnApontTar C-Win 
FUNCTION fnApontTar RETURNS DECIMAL
  ( cNome AS CHAR, iSeq AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE de-apont AS DECIMAL     NO-UNDO.

    FOR EACH bf-apontamento NO-LOCK
        WHERE bf-apontamento.nome-tarefa = cNome
        AND   bf-apontamento.seq-tarefa = iSeq:
        ASSIGN de-apont = de-apont + bf-apontamento.qt-apont.
    END.

    RETURN de-apont.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnMotivo C-Win 
FUNCTION fnMotivo RETURNS CHARACTER
  ( iCat AS INT, iSub AS INT, iFav AS INT, cObs AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    IF iCat <> 0 THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = iCat NO-ERROR.
        FIND FIRST sub-cat OF categoria NO-LOCK
            WHERE sub-cat.cd-sub = iSub NO-ERROR.
        RETURN categoria.ds-categoria + "/" + sub-cat.ds-sub.
    END.
    ELSE DO:
        IF cObs <> "" THEN
            RETURN cObs.
        ELSE DO:
            FIND FIRST favorecido NO-LOCK
                WHERE favorecido.cd-favorecido = ifav NO-ERROR.
            RETURN favorecido.ds-favorecido.
        END.
    END.

    RETURN "".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

