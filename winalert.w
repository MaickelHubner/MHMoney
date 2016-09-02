&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

{winalert.i}
{gerapend.i}

/* Parameters Definitions ---                                           */

DEFINE INPUT  PARAMETER piPonto AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER prObj AS ROWID      NO-UNDO.
DEFINE INPUT  PARAMETER lMostraJanela AS LOGICAL    NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE FOR tt-alerta.

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE cParamRelat AS CHAR NO-UNDO.

{seg.i}

{func\data.i}
{orcamento.i}

{proxpag.i}

DEFINE BUFFER bf-mov-conta FOR mov-conta.
DEFINE BUFFER bf-alerta FOR tt-alerta.

DEFINE NEW GLOBAL SHARED VARIABLE iUltOrc AS INTEGER    NO-UNDO INITIAL 0.
DEFINE NEW GLOBAL SHARED VARIABLE iUltTpOrc AS INTEGER    NO-UNDO INITIAL 0.

DEFINE BUFFER bf-conta FOR conta.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAlertas

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-alerta

/* Definitions for BROWSE brAlertas                                     */
&Scoped-define FIELDS-IN-QUERY-brAlertas tt-alerta.alerta   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAlertas   
&Scoped-define SELF-NAME brAlertas
&Scoped-define QUERY-STRING-brAlertas FOR EACH tt-alerta
&Scoped-define OPEN-QUERY-brAlertas OPEN QUERY {&SELF-NAME} FOR EACH tt-alerta.
&Scoped-define TABLES-IN-QUERY-brAlertas tt-alerta
&Scoped-define FIRST-TABLE-IN-QUERY-brAlertas tt-alerta


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brAlertas}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS im-alert RECT-11 brAlertas btOK EDITOR-1 
&Scoped-Define DISPLAYED-OBJECTS EDITOR-1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btEx 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Executar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar...".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "OK" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE EDITOR-1 AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 77 BY 7.5
     FONT 2 NO-UNDO.

DEFINE IMAGE im-alert
     FILENAME "image/alerta.ico":U
     SIZE 6 BY 1.5.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 77 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAlertas FOR 
      tt-alerta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAlertas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAlertas C-Win _FREEFORM
  QUERY brAlertas DISPLAY
      tt-alerta.alerta FORMAT "X(80)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 69 BY 5
         FONT 1 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btEx AT ROW 1.5 COL 3
     brAlertas AT ROW 3.75 COL 10
     btOK AT ROW 1.5 COL 72
     EDITOR-1 AT ROW 9 COL 2 NO-LABEL
     im-alert AT ROW 5.25 COL 3
     RECT-11 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 79.29 BY 15.67.


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
         TITLE              = "Alerta"
         HEIGHT             = 15.67
         WIDTH              = 79.29
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 30.04
         VIRTUAL-WIDTH      = 146.29
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = no
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
   FRAME-NAME                                                           */
/* BROWSE-TAB brAlertas RECT-11 DEFAULT-FRAME */
ASSIGN 
       brAlertas:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brAlertas:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR BUTTON btEx IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       EDITOR-1:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAlertas
/* Query rebuild information for BROWSE brAlertas
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-alerta.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brAlertas */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Alerta */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Alerta */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAlertas
&Scoped-define SELF-NAME brAlertas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAlertas C-Win
ON VALUE-CHANGED OF brAlertas IN FRAME DEFAULT-FRAME
DO:
  
    IF AVAIL tt-alerta THEN DO:
        ASSIGN editor-1:SCREEN-VALUE IN FRAME default-frame = tt-alerta.descricao.
        IF tt-alerta.executa THEN
            ENABLE btEx WITH FRAME default-frame.
        ELSE
            DISABLE btEx WITH FRAME default-frame.

        IF tt-alerta.alerta MATCHES("*venceu*") THEN DO:
            im-alert:LOAD-IMAGE("image\erro.ico").
        END.
        ELSE DO:
            IF tt-alerta.alerta MATCHES("*saldo da conta*")
            OR tt-alerta.alerta MATCHES("*valor previsto*") THEN DO:
                im-alert:LOAD-IMAGE("image\alerta.ico").
            END.
            ELSE DO:
                IF tt-alerta.alerta MATCHES("*valor*")
                OR tt-alerta.alerta MATCHES("*vencer *") THEN DO:
                    im-alert:LOAD-IMAGE("image\info.ico").
                END.
                ELSE DO:
                    im-alert:LOAD-IMAGE("image\executa.ico").
                END.
            END.
        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btEx
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btEx C-Win
ON CHOOSE OF btEx IN FRAME DEFAULT-FRAME /* Executar */
DO:
    RUN som.p(INPUT "music\click.wav").
    {winalert_exec.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* OK */
DO:
  
    {func\bt_fechar.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
ASSIGN C-Win:HIDDEN = YES.

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
  {version.i winalert}
  RUN pesquisaAlertas IN THIS-PROCEDURE.
  IF RETURN-VALUE = "NOK" OR NOT lMostraJanela THEN DO:
      APPLY "CLOSE" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
  END.
  ELSE DO:
      RUN som.p(INPUT "music\lembrete.wav").
      ASSIGN C-Win:HIDDEN = NO.
      RUN enable_UI.
      RUN initialize.
  END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta1 C-Win 
PROCEDURE alerta1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
DEFINE VARIABLE cTipo AS CHARACTER  NO-UNDO.
DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

FOR EACH agenda NO-LOCK
    WHERE agenda.dt-fim >= agenda.dt-ultimo-pag
    AND NOT agenda.simulado:

    ASSIGN dtTemp = fnProxDataPag(ROWID(agenda)).

    IF dtTemp > agenda.dt-fim THEN NEXT.

    FIND FIRST agenda-valor NO-LOCK
        WHERE agenda-valor.cd-agenda = agenda.cd-agenda
        AND   agenda-valor.dt-ini <= dtTemp
        AND   agenda-valor.dt-end >= dtTemp NO-ERROR.
    IF NOT AVAIL agenda-valor THEN NEXT.

    IF dtTemp > TODAY THEN NEXT.
    IF dtTemp > agenda.dt-fim THEN NEXT.

    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 1
                AND   alerta-exc.cd-favorecido = agenda.cd-favorecido
                AND NOT alerta-exc.outro-valor) THEN NEXT.
    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 1
                AND   alerta-exc.cod-categoria = agenda.cod-categoria
                AND   alerta-exc.cd-sub = 0
                AND NOT alerta-exc.outro-valor) THEN NEXT.
    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 1
                AND   alerta-exc.cod-categoria = agenda.cod-categoria
                AND   alerta-exc.cd-sub = agenda.cd-sub
                AND NOT alerta-exc.outro-valor) THEN NEXT.

    IF agenda.vl-atual = 0 THEN
        ASSIGN deValor = agenda-valor.valor.
    ELSE
        ASSIGN deValor = agenda.vl-atual.

    IF deValor < 0 THEN
        ASSIGN deValor = (-1) * deValor.

    FIND FIRST alerta-exc
        WHERE alerta-exc.usuario = gcUsuario
        AND   alerta-exc.tipo = 1
        AND   alerta-exc.cd-favorecido = agenda.cd-favorecido
        AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
    IF NOT AVAIL alerta-exc AND agenda.id-tipo <> 3 THEN DO:
        FIND FIRST alerta-exc
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 1
            AND   alerta-exc.cod-categoria = agenda.cod-categoria
            AND   alerta-exc.cd-sub = 0
            AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 1
                AND   alerta-exc.cod-categoria = agenda.cod-categoria
                AND   alerta-exc.cd-sub = agenda.cd-sub
                AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
        END.
    END.

    IF NOT AVAIL alerta-exc THEN DO:
        IF deValor < alerta.valor-minimo THEN NEXT.
    END.
    ELSE DO:
        IF deValor < alerta-exc.valor-minimo THEN NEXT.
    END.

    FIND FIRST favorecido WHERE favorecido.cd-favorecido = agenda.cd-favorecido NO-LOCK.                
    FIND FIRST conta WHERE conta.cd-conta = agenda.cd-conta NO-LOCK.
    CASE agenda.id-tipo:
        WHEN 1 THEN ASSIGN cTipo = "Dep¢sito".
        WHEN 2 THEN ASSIGN cTipo = "Cr‚dito".
        WHEN 3 THEN ASSIGN cTipo = "Transferˆncia".
        WHEN 4 THEN ASSIGN cTipo = "Cheque".
        WHEN 5 THEN ASSIGN cTipo = "Pagamento".
        WHEN 6 THEN ASSIGN cTipo = "Saque em Dinheiro".
        WHEN 7 THEN ASSIGN cTipo = "D‚bito".
    END CASE.

    IF agenda.id-tipo <> 3 THEN
        FIND FIRST moeda OF conta NO-LOCK NO-ERROR.
    ELSE DO:
        FIND FIRST bf-conta WHERE bf-conta.cd-conta = agenda.conta-transf NO-LOCK.
        FIND FIRST moeda OF bf-conta NO-LOCK NO-ERROR.
    END.

    CREATE tt-alerta.
    ASSIGN tt-alerta.alerta = "Agendamento de " + favorecido.ds-favorecido + " venceu no dia " + STRING(dtTemp,"99/99/9999") + "."
           tt-alerta.descricao = "Valor: " + moeda.sigla + " " + (IF agenda.vl-atual = 0 THEN TRIM(STRING(agenda-valor.valor,"->>>,>>>,>>9.99")) ELSE TRIM(STRING(agenda.vl-atual,"->>>,>>>,>>9.99"))) + CHR(10) +
                                 "Tipo:  " + cTipo + " C¢digo: " + STRING(agenda.cd-agenda) + CHR(10) +
                                 "Conta: " + conta.ds-conta.
    IF agenda.id-tipo = 3 THEN DO:
        FIND FIRST conta WHERE conta.cd-conta = agenda.conta-transf NO-LOCK.
        ASSIGN tt-alerta.descricao = tt-alerta.descricao + CHR(10) + 
                                     "Para:  " + conta.ds-conta.
    END.
    ELSE DO:
        FIND FIRST categoria WHERE categoria.cod-categoria = agenda.cod-categoria NO-LOCK.
        FIND FIRST sub-cat
            WHERE sub-cat.cod-categoria = agenda.cod-categoria
            AND   sub-cat.cd-sub = agenda.cd-sub NO-LOCK.
        ASSIGN tt-alerta.descricao = tt-alerta.descricao + CHR(10) +
                                     "Local: " + categoria.ds-categoria + "/" + sub-cat.ds-sub.
    END.                

END.

IF param-mn.perfil = 2 /* Empresarial */ THEN DO:

    FOR EACH parc-nota-fiscal NO-LOCK
        WHERE parc-nota-fiscal.situacao = 1 /* Pendente */
        AND   parc-nota-fiscal.dt-pagto-parc <= TODAY:
    
        FIND FIRST nota-fiscal OF parc-nota-fiscal NO-LOCK NO-ERROR.
    
        IF CAN-FIND(FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cd-favorecido = nota-fiscal.cd-favorecido
                    AND NOT alerta-exc.outro-valor) THEN NEXT.
        IF CAN-FIND(FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                    AND   alerta-exc.cd-sub = 0
                    AND NOT alerta-exc.outro-valor) THEN NEXT.
        IF CAN-FIND(FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                    AND   alerta-exc.cd-sub = nota-fiscal.cd-sub
                    AND NOT alerta-exc.outro-valor) THEN NEXT.

        ASSIGN deValor = parc-nota-fiscal.val-parcela.
    
        FIND FIRST alerta-exc
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 1
            AND   alerta-exc.cd-favorecido = nota-fiscal.cd-favorecido
            AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 1
                AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                AND   alerta-exc.cd-sub = 0
                AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
            IF NOT AVAIL alerta-exc THEN DO:
                FIND FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                    AND   alerta-exc.cd-sub = nota-fiscal.cd-sub
                    AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
            END.
        END.
    
        IF NOT AVAIL alerta-exc THEN DO:
            IF deValor < alerta.valor-minimo THEN NEXT.
        END.
        ELSE DO:
            IF deValor < alerta-exc.valor-minimo THEN NEXT.
        END.
    
        FIND FIRST favorecido OF nota-fiscal NO-LOCK.                
        FIND FIRST categoria OF nota-fiscal NO-LOCK.
        FIND FIRST sub-cat OF nota-fiscal NO-LOCK.
        FIND FIRST conta NO-LOCK
            WHERE conta.id-tipo = 1 /* Conta Corrente */
            AND   NOT conta.id-encerrada
            AND   conta.cd-moeda = 0 NO-ERROR.
        FIND FIRST moeda OF conta NO-LOCK NO-ERROR.

        CREATE tt-alerta.
        ASSIGN tt-alerta.alerta = "Faturamento de NF " + nota-fiscal.nr-nota + " (Controle: " + STRING(nota-fiscal.nr-controle) + " \ Parcela " + STRING(parc-nota-fiscal.sequencia) + ") do cliente " + TRIM(favorecido.ds-favorecido) + " venceu no dia " + STRING(parc-nota-fiscal.dt-pagto-parc,"99/99/9999") + "."
               tt-alerta.descricao = "Valor: " + moeda.sigla + " " + TRIM(STRING(parc-nota-fiscal.val-parcela,"->>>,>>>,>>9.99")) + CHR(10) +
                                     "Tipo: Dep¢sito" + CHR(10) +
                                     "Conta: " + conta.ds-conta + CHR(10) +
                                     "Local: " + categoria.ds-categoria + "/" + sub-cat.ds-sub + CHR(10) + CHR(10) +
                                     "Pedidos:".

        FOR EACH pedido OF nota-fiscal NO-LOCK:
            ASSIGN tt-alerta.descricao = tt-alerta.descricao + " " + STRING(pedido.nr-pedido). 
        END.
    
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta2 C-Win 
PROCEDURE alerta2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
DEFINE VARIABLE cTipo AS CHARACTER  NO-UNDO.
DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

FOR EACH agenda NO-LOCK
    WHERE agenda.dt-fim > TODAY
    AND NOT agenda.simulado:

    ASSIGN dtTemp = fnProxDataPag(ROWID(agenda)).
    IF dtTemp > agenda.dt-fim THEN NEXT.

    FIND FIRST agenda-valor NO-LOCK
        WHERE agenda-valor.cd-agenda = agenda.cd-agenda
        AND   agenda-valor.dt-ini <= dtTemp
        AND   agenda-valor.dt-end >= dtTemp NO-ERROR.

    IF NOT AVAIL agenda-valor THEN NEXT.

    /*IF (dtTemp - 5) > TODAY THEN NEXT.*/
    IF dtTemp <= TODAY THEN NEXT.

    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 2
                AND   alerta-exc.cd-favorecido = agenda.cd-favorecido
                AND NOT alerta-exc.outro-valor) THEN NEXT.
    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 2
                AND   alerta-exc.cod-categoria = agenda.cod-categoria
                AND   alerta-exc.cd-sub = 0
                AND NOT alerta-exc.outro-valor) THEN NEXT.
    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 2
                AND   alerta-exc.cod-categoria = agenda.cod-categoria
                AND   alerta-exc.cd-sub = agenda.cd-sub
                AND NOT alerta-exc.outro-valor) THEN NEXT.

    IF agenda.vl-atual = 0 THEN
        ASSIGN deValor = agenda-valor.valor.
    ELSE
        ASSIGN deValor = agenda.vl-atual.

    IF deValor < 0 THEN
        ASSIGN deValor = (-1) * deValor.

    FIND FIRST alerta-exc
        WHERE alerta-exc.usuario = gcUsuario
        AND   alerta-exc.tipo = 2
        AND   alerta-exc.cd-favorecido = agenda.cd-favorecido
        AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
    IF NOT AVAIL alerta-exc AND agenda.id-tipo <> 3 THEN DO:
        FIND FIRST alerta-exc
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 2
            AND   alerta-exc.cod-categoria = agenda.cod-categoria
            AND   alerta-exc.cd-sub = 0
            AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 2
                AND   alerta-exc.cod-categoria = agenda.cod-categoria
                AND   alerta-exc.cd-sub = agenda.cd-sub
                AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
        END.
    END.

    IF NOT AVAIL alerta-exc THEN DO:
        IF deValor < alerta.valor-minimo THEN NEXT.
        IF dtTemp > (TODAY + alerta.num-dias) THEN NEXT.
    END.
    ELSE DO:
        IF deValor < alerta-exc.valor-minimo THEN NEXT.
        IF dtTemp > (TODAY + alerta-exc.num-dias) THEN NEXT.
    END.

    FIND FIRST favorecido WHERE favorecido.cd-favorecido = agenda.cd-favorecido NO-LOCK.
    FIND FIRST conta WHERE conta.cd-conta = agenda.cd-conta NO-LOCK.
    CASE agenda.id-tipo:
        WHEN 1 THEN ASSIGN cTipo = "Dep¢sito".
        WHEN 2 THEN ASSIGN cTipo = "Cr‚dito".
        WHEN 3 THEN ASSIGN cTipo = "Transferˆncia".
        WHEN 4 THEN ASSIGN cTipo = "Cheque".
        WHEN 5 THEN ASSIGN cTipo = "Pagamento".
        WHEN 6 THEN ASSIGN cTipo = "Saque em Dinheiro".
        WHEN 7 THEN ASSIGN cTipo = "D‚bito".
    END CASE.

    IF agenda.id-tipo <> 3 THEN
        FIND FIRST moeda OF conta NO-LOCK NO-ERROR.
    ELSE DO:
        FIND FIRST bf-conta WHERE bf-conta.cd-conta = agenda.conta-transf NO-LOCK.
        FIND FIRST moeda OF bf-conta NO-LOCK NO-ERROR.
    END.

    CREATE tt-alerta.
    ASSIGN tt-alerta.alerta = "Agendamento de " + favorecido.ds-favorecido + " vencer  no dia " + STRING(dtTemp,"99/99/9999") + "."
           tt-alerta.descricao = "Valor: " + moeda.sigla + " " + (IF agenda.vl-atual = 0 THEN TRIM(STRING(agenda-valor.valor,"->>>,>>>,>>9.99")) ELSE TRIM(STRING(agenda.vl-atual,"->>>,>>>,>>9.99"))) + CHR(10) +
                                 "Tipo:  " + cTipo + " C¢digo: " + STRING(agenda.cd-agenda) + CHR(10) +
                                 "Conta: " + conta.ds-conta.
    IF agenda.id-tipo = 3 THEN DO:
        FIND FIRST conta WHERE conta.cd-conta = agenda.conta-transf NO-LOCK.
        ASSIGN tt-alerta.descricao = tt-alerta.descricao + CHR(10) + 
                                     "Para:  " + conta.ds-conta.
    END.
    ELSE DO:
        FIND FIRST categoria WHERE categoria.cod-categoria = agenda.cod-categoria NO-LOCK.
        FIND FIRST sub-cat
            WHERE sub-cat.cod-categoria = agenda.cod-categoria
            AND   sub-cat.cd-sub = agenda.cd-sub NO-LOCK.
        ASSIGN tt-alerta.descricao = tt-alerta.descricao + CHR(10) +
                                     "Local: " + categoria.ds-categoria + "/" + sub-cat.ds-sub.
    END.                

END.

IF param-mn.perfil = 2 /* Empresarial */ THEN DO:

    FOR EACH parc-nota-fiscal NO-LOCK
        WHERE parc-nota-fiscal.situacao = 1 /* Pendente */
        AND   parc-nota-fiscal.dt-pagto-parc > TODAY:
    
        FIND FIRST nota-fiscal OF parc-nota-fiscal NO-LOCK NO-ERROR.
    
        IF CAN-FIND(FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cd-favorecido = nota-fiscal.cd-favorecido
                    AND NOT alerta-exc.outro-valor) THEN NEXT.
        IF CAN-FIND(FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                    AND   alerta-exc.cd-sub = 0
                    AND NOT alerta-exc.outro-valor) THEN NEXT.
        IF CAN-FIND(FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                    AND   alerta-exc.cd-sub = nota-fiscal.cd-sub
                    AND NOT alerta-exc.outro-valor) THEN NEXT.

        ASSIGN deValor = parc-nota-fiscal.val-parcela.
    
        FIND FIRST alerta-exc
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 1
            AND   alerta-exc.cd-favorecido = nota-fiscal.cd-favorecido
            AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 1
                AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                AND   alerta-exc.cd-sub = 0
                AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
            IF NOT AVAIL alerta-exc THEN DO:
                FIND FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 1
                    AND   alerta-exc.cod-categoria = nota-fiscal.cod-categoria
                    AND   alerta-exc.cd-sub = nota-fiscal.cd-sub
                    AND alerta-exc.outro-valor NO-LOCK NO-ERROR.
            END.
        END.
    
        IF NOT AVAIL alerta-exc THEN DO:
            IF deValor < alerta.valor-minimo THEN NEXT.
            IF parc-nota-fiscal.dt-pagto-parc > (TODAY + alerta.num-dias) THEN NEXT.
        END.
        ELSE DO:
            IF deValor < alerta-exc.valor-minimo THEN NEXT.
            IF parc-nota-fiscal.dt-pagto-parc > (TODAY + alerta-exc.num-dias) THEN NEXT.
        END.
    
        FIND FIRST favorecido OF nota-fiscal NO-LOCK.                
        FIND FIRST categoria OF nota-fiscal NO-LOCK.
        FIND FIRST sub-cat OF nota-fiscal NO-LOCK.
        FIND FIRST conta NO-LOCK
            WHERE conta.id-tipo = 1 /* Conta Corrente */
            AND   NOT conta.id-encerrada
            AND   conta.cd-moeda = 0 NO-ERROR.
        FIND FIRST moeda OF conta NO-LOCK NO-ERROR.

        CREATE tt-alerta.
        ASSIGN tt-alerta.alerta = "Faturamento de NF " + nota-fiscal.nr-nota + " (Controle: " + STRING(nota-fiscal.nr-controle) + " \ Parcela " + STRING(parc-nota-fiscal.sequencia) + ") do cliente " + TRIM(favorecido.ds-favorecido) + " vencer  no dia " + STRING(parc-nota-fiscal.dt-pagto-parc,"99/99/9999") + "."
               tt-alerta.descricao = "Valor: " + moeda.sigla + " " + TRIM(STRING(parc-nota-fiscal.val-parcela,"->>>,>>>,>>9.99")) + CHR(10) +
                                     "Tipo: Dep¢sito" + CHR(10) +
                                     "Conta: " + conta.ds-conta + CHR(10) +
                                     "Local: " + categoria.ds-categoria + "/" + sub-cat.ds-sub + CHR(10) + CHR(10) +
                                     "Pedidos:".

        FOR EACH pedido OF nota-fiscal NO-LOCK:
            ASSIGN tt-alerta.descricao = tt-alerta.descricao + " " + STRING(pedido.nr-pedido). 
        END.
    
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta3 C-Win 
PROCEDURE alerta3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.
DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

ASSIGN rTemp = prObj.
FIND FIRST mov-conta WHERE ROWID(mov-conta) = prObj NO-LOCK NO-ERROR.
IF AVAIL mov-conta THEN DO:
    FIND FIRST conta WHERE conta.cd-conta = mov-conta.cd-conta NO-LOCK.
    ASSIGN rTemp = ROWID(conta)
           dtTemp = mov-conta.dt-mov.
END.

FOR EACH conta
    WHERE NOT conta.id-encerrada NO-LOCK:

    IF rTemp <> ? AND ROWID(conta) <> rTemp THEN NEXT.

    IF CAN-FIND(FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 3
                AND   alerta-exc.cd-conta = conta.cd-conta
                AND NOT alerta-exc.outro-valor) THEN NEXT.

    IF dtTemp = ? THEN
        ASSIGN dtTemp = conta.dt-saldo.

    /*    ASSIGN deValor = conta.vl-saldo.
    FOR EACH mov-conta OF conta
        WHERE mov-conta.id-situacao <> 3
        AND   mov-conta.dt-mov <= TODAY NO-LOCK:

        ASSIGN deValor = deValor + mov-conta.de-valor.

    END.*/

    ASSIGN deValor = conta.vl-saldo-ini.
    FOR EACH mov-conta OF conta
        WHERE mov-conta.dt-mov <= dtTemp
        AND   mov-conta.agrupado = 0 NO-LOCK:

        ASSIGN deValor = deValor + mov-conta.de-valor.

    END.

    FIND FIRST agenda NO-LOCK
        WHERE (agenda.conta = conta.cd-conta
        OR    agenda.conta-transf = conta.cd-conta)
        AND   agenda.cd-favorecido = conta.cd-fav-padrao
        AND   agenda.id-tipo = 3
        AND   agenda.dt-ultimo-pag > dtTemp NO-ERROR.
    IF AVAIL agenda THEN DO:
        FIND FIRST mov-conta OF agenda NO-LOCK
            WHERE mov-conta.cd-conta = conta.cd-conta
            AND   mov-conta.dt-mov = agenda.dt-ultimo-pag NO-ERROR.
        IF AVAIL mov-conta THEN DO:
            ASSIGN deValor = deValor + mov-conta.de-valor.
        END.
    END.

    FIND FIRST moeda OF conta NO-LOCK NO-ERROR.

    FIND FIRST alerta-exc
        WHERE alerta-exc.usuario = gcUsuario
        AND   alerta-exc.tipo = 3
        AND   alerta-exc.cd-conta = conta.cd-conta
        AND alerta-exc.outro-valor NO-LOCK NO-ERROR.

    IF NOT AVAIL alerta-exc THEN DO:
        IF deValor < alerta.valor-minimo THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "Saldo da conta " + conta.ds-conta + " est  abaixo do valor m¡nimo!"
                   tt-alerta.descricao = "Saldo: " + moeda.sigla + " " + TRIM(STRING(deValor,"->>>,>>>,>>9.99")).
        END.
        IF deValor > alerta.valor-m ximo THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "Saldo da conta " + conta.ds-conta + " est  acima do valor m ximo!"
                   tt-alerta.descricao = "Saldo: " + moeda.sigla + " " + TRIM(STRING(deValor,"->>>,>>>,>>9.99")).
        END.
    END.
    ELSE DO:
        IF deValor < alerta-exc.valor-minimo THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "Saldo da conta " + conta.ds-conta + " est  abaixo do valor m¡nimo!"
                   tt-alerta.descricao = "Saldo: " + moeda.sigla + " " + TRIM(STRING(deValor,"->>>,>>>,>>9.99")).
        END.
        IF deValor > alerta-exc.valor-m ximo THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "Saldo da conta " + conta.ds-conta + " est  acima do valor m ximo!"
                   tt-alerta.descricao = "Saldo: " + moeda.sigla + " " + TRIM(STRING(deValor,"->>>,>>>,>>9.99")).
        END.
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta4 C-Win 
PROCEDURE alerta4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE lPoup AS LOGICAL    NO-UNDO.
DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.
DEFINE VARIABLE rMov AS ROWID      NO-UNDO.
DEFINE VARIABLE iPer AS INTEGER    NO-UNDO.
DEFINE VARIABLE pcAlerta AS DECIMAL    NO-UNDO.

ASSIGN iPer = alerta.periodo
       pcAlerta = alerta.percentual.

FIND FIRST mov-conta WHERE ROWID(mov-conta) = prObj NO-LOCK NO-ERROR.
IF AVAIL mov-conta THEN DO: /* énico */

    FIND FIRST moeda WHERE moeda.cd-moeda = 0.

    FIND FIRST alerta-exc
        WHERE alerta-exc.usuario = gcUsuario
        AND   alerta-exc.tipo = 4
        AND   alerta-exc.cd-favorecido = mov-conta.cd-favorecido NO-LOCK NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        FIND FIRST alerta-exc
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 4
            AND   alerta-exc.cod-categoria = mov-conta.cod-categoria
            AND   alerta-exc.cd-sub = 0 NO-LOCK NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 4
                AND   alerta-exc.cod-categoria = mov-conta.cod-categoria
                AND   alerta-exc.cd-sub = mov-conta.cd-sub NO-LOCK NO-ERROR.
        END.
    END.
    IF AVAIL alerta-exc THEN DO:
        IF NOT alerta-exc.outro-valor THEN 
            RETURN.
        ELSE DO:
            ASSIGN iPer = alerta-exc.periodo
                   pcAlerta = alerta-exc.percentual.
        END.
    END.

    IF iUltOrc <> MONTH(mov-conta.dt-mov)
    OR iUltTpOrc <> iPer THEN DO:

        FIND LAST orcamento WHERE orcamento.ano = YEAR(mov-conta.dt-mov) NO-LOCK NO-ERROR.
        IF NOT AVAIL orcamento THEN RETURN.

        CASE iPer:
            WHEN 1 THEN DO:
                RUN criaTTacomp(INPUT MONTH(mov-conta.dt-mov), INPUT MONTH(mov-conta.dt-mov), INPUT orcamento.cd-orcamento).
                ASSIGN iUltTpOrc = 1.
            END.
            WHEN 2 THEN DO:
                RUN criaTTacomp(INPUT 1, INPUT 12, INPUT orcamento.cd-orcamento).
                ASSIGN iUltTpOrc = 2.
            END.
            WHEN 3 THEN DO:
                RUN criaTTacomp(INPUT 1, INPUT MONTH(mov-conta.dt-mov), INPUT orcamento.cd-orcamento).
                ASSIGN iUltTpOrc = 3.
            END.
        END CASE.
        FIND FIRST mov-conta WHERE ROWID(mov-conta) = prObj NO-LOCK NO-ERROR.
        ASSIGN iUltOrc = MONTH(mov-conta.dt-mov).
    END.

    IF mov-conta.id-tipo = 0 THEN DO:
        ASSIGN rTemp = prObj.
        FOR EACH bf-mov-conta NO-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
            AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
            ASSIGN prObj = ROWID(bf-mov-conta).
            RUN alerta4 IN THIS-PROCEDURE.
        END.
        ASSIGN prObj = rTemp.
    END.
    ELSE DO:
        IF mov-conta.id-tipo <> 3 THEN DO:
            FIND FIRST tt-acomp 
                WHERE tt-acomp.cod-cat = mov-conta.cod-categoria
                AND   tt-acomp.cd-sub = mov-conta.cd-sub NO-ERROR.
            IF NOT AVAIL tt-acomp THEN DO:
                FIND FIRST tt-acomp 
                    WHERE tt-acomp.cod-cat = mov-conta.cod-categoria
                    AND   tt-acomp.cd-sub = 999 NO-ERROR.
                IF NOT AVAIL tt-acomp THEN DO:
                    IF mov-conta.de-valor > 0 THEN
                        FIND FIRST tt-acomp 
                            WHERE tt-acomp.cod-cat = 999
                            AND   tt-acomp.cd-sub = 999 NO-ERROR.
                    ELSE
                        FIND FIRST tt-acomp 
                            WHERE tt-acomp.cod-cat = 998
                            AND   tt-acomp.cd-sub = 999 NO-ERROR.
                END.
            END.
        END.
        ELSE DO:
            ASSIGN lPoup = NO.
            FIND FIRST conta OF mov-conta NO-LOCK.
            IF conta.id-tipo = 2 THEN DO:
                ASSIGN lPoup = YES.
                FIND FIRST tt-acomp 
                    WHERE tt-acomp.cod-cat = 997
                    AND   tt-acomp.cd-sub = mov-conta.cd-conta NO-ERROR.
            END.
            IF NOT AVAIL tt-acomp THEN DO:
                FIND FIRST conta WHERE conta.cd-conta = mov-conta.conta-transf NO-LOCK.
                IF conta.id-tipo = 2 THEN DO:
                    ASSIGN lPoup = YES.
                    FIND FIRST tt-acomp 
                        WHERE tt-acomp.cod-cat = 997
                        AND   tt-acomp.cd-sub = mov-conta.conta-transf NO-ERROR.
                END.
            END.
            IF lPoup THEN DO:
                IF NOT AVAIL tt-acomp THEN DO:
                    FIND FIRST tt-acomp 
                        WHERE tt-acomp.cod-cat = 997
                        AND   tt-acomp.cd-sub = 999 NO-ERROR.
                END.
            END.
            ELSE DO:
                NEXT.
            END.
        END.
        IF AVAIL tt-acomp THEN DO:
            IF tt-acomp.vl-real >= ((pcAlerta / 100) * tt-acomp.vl-prev) THEN DO:

                IF tt-acomp.descricao = "" THEN NEXT.
                IF tt-acomp.vl-prev = 0 THEN NEXT.

                CREATE tt-alerta.
                ASSIGN tt-alerta.descricao = "Valor Previsto: " + moeda.sigla + " " + TRIM(STRING(tt-acomp.vl-prev,"->>>,>>>,>>9.99")) + CHR(13) +
                                             "Valor Atual:    " + moeda.sigla + " " + TRIM(STRING(tt-acomp.vl-real,"->>>,>>>,>>9.99")) + CHR(13) +
                                             "---------------" + CHR(13) +
                                             "Diferen‡a:      " + moeda.sigla + " " + TRIM(STRING((tt-acomp.vl-real - tt-acomp.vl-prev),"->>>,>>>,>>9.99")) + CHR(13) + CHR(13).
                FIND FIRST categoria WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
                IF AVAIL categoria THEN DO:
                    ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Categoria:      " + categoria.ds-categoria + CHR(13).
                    FIND FIRST sub-cat OF categoria
                        WHERE sub-cat.cd-sub = tt-acomp.cd-sub NO-ERROR.
                    IF AVAIL sub-cat THEN
                        ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Sub-Categoria:  " + sub-cat.ds-sub.
                    IF TRIM(tt-acomp.descricao) = "GERAL" THEN
                        ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Sub-Categoria:  GERAL".
                END.

                IF TRIM(tt-acomp.descricao) <> "GERAL" THEN DO:
                    IF tt-acomp.vl-real > tt-acomp.vl-prev THEN
                        ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " acima do previsto.".
                    ELSE
                        ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " pr¢ximo do previsto.".
                END.
                ELSE DO:
                    IF AVAIL categoria THEN
                        IF tt-acomp.vl-real > tt-acomp.vl-prev THEN
                            ASSIGN tt-alerta.alerta = "Valor real de " + categoria.ds-categoria + ":GERAL" + " acima do previsto.".
                        ELSE
                            ASSIGN tt-alerta.alerta = "Valor real de " + categoria.ds-categoria + ":GERAL" + " pr¢ximo do previsto.".
                    ELSE
                        IF tt-acomp.vl-real > tt-acomp.vl-prev THEN
                            ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " acima do previsto.".
                        ELSE
                            ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " pr¢ximo do previsto.".
                END.

                IF TRIM(tt-acomp.descricao) = "OUTROS" THEN DO:
                    CASE tt-acomp.cod-cat:
                        WHEN 999 THEN
                            ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Outras Receitas".
                        WHEN 998 THEN
                            ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Outras Despesas".
                        WHEN 997 THEN
                            ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Outros Investimentos em Poupan‡a".
                    END CASE.
                END.

                IF CAN-FIND(FIRST bf-alerta
                            WHERE ROWID(bf-alerta) <> ROWID(tt-alerta)
                            AND   bf-alerta.alerta = tt-alerta.alerta) THEN DO:
                    DELETE tt-alerta.
                END.

            END.
        END.
    END.
END.
ELSE DO: /* Todos */

    FIND LAST orcamento WHERE orcamento.ano = YEAR(TODAY) NO-LOCK NO-ERROR.
    IF NOT AVAIL orcamento THEN RETURN.

    CASE iPer:
        WHEN 1 THEN DO:
            RUN criaTTacomp(INPUT MONTH(TODAY), INPUT MONTH(TODAY), INPUT orcamento.cd-orcamento).
        END.
        WHEN 2 THEN DO:
            RUN criaTTacomp(INPUT 1, INPUT 12, INPUT orcamento.cd-orcamento).
        END.
        WHEN 3 THEN DO:
            RUN criaTTacomp(INPUT 1, INPUT MONTH(TODAY), INPUT orcamento.cd-orcamento).
        END.
    END CASE.

    FOR EACH tt-acomp:

        IF tt-acomp.vl-real > 0 THEN DO:
            FIND FIRST alerta-exc
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 4
                AND   alerta-exc.cod-categoria = tt-acomp.cod-cat
                AND   alerta-exc.cd-sub = 0 NO-LOCK NO-ERROR.
            IF NOT AVAIL alerta-exc THEN DO:
                FIND FIRST alerta-exc
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 4
                    AND   alerta-exc.cod-categoria = tt-acomp.cod-cat
                    AND   alerta-exc.cd-sub = tt-acomp.cd-sub NO-LOCK NO-ERROR.
            END.
            IF AVAIL alerta-exc THEN DO:
                IF alerta-exc.outro-valor THEN DO:
                    CREATE mov-conta.
                    ASSIGN mov-conta.cd-conta = 9999
                           mov-conta.cod-categoria = alerta-exc.cod-categoria
                           mov-conta.cd-sub = alerta-exc.cd-sub
                           rTemp = prObj
                           rMov = ROWID(mov-conta)
                           prObj = ROWID(mov-conta).
                    CASE alerta-exc.periodo:
                        WHEN 2 THEN DO:
                            ASSIGN mov-conta.dt-mov = fnUltimoDia(12,YEAR(TODAY)).
                        END.
                        OTHERWISE DO:
                            ASSIGN mov-conta.dt-mov = fnUltimoDia(MONTH(TODAY),YEAR(TODAY)).
                        END.
                    END CASE.
                    RUN alerta4 IN THIS-PROCEDURE.
                    ASSIGN prObj = rTemp.
                    FIND FIRST mov-conta EXCLUSIVE-LOCK
                        WHERE ROWID(mov-conta) = rMov NO-ERROR.
                    DELETE mov-conta.
                END.
                NEXT.
            END.
        END.

        IF tt-acomp.vl-real >= ((pcAlerta / 100) * tt-acomp.vl-prev) THEN DO:

            IF tt-acomp.descricao = "" THEN NEXT.
            IF tt-acomp.vl-prev = 0 THEN NEXT.

            CREATE tt-alerta.
            ASSIGN tt-alerta.descricao = "Valor Previsto: " + moeda.sigla + " " + STRING(tt-acomp.vl-prev) + CHR(13) +
                                         "Valor Atual:    " + moeda.sigla + " " + STRING(tt-acomp.vl-real) + CHR(13) +
                                         "---------------" + CHR(13) +
                                         "Diferen‡a:      " + moeda.sigla + " " + STRING((tt-acomp.vl-real - tt-acomp.vl-prev)) + CHR(13) + CHR(13).
            FIND FIRST categoria WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
            IF AVAIL categoria THEN DO:
                ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Categoria:      " + categoria.ds-categoria + CHR(13).
                FIND FIRST sub-cat OF categoria
                    WHERE sub-cat.cd-sub = tt-acomp.cd-sub NO-ERROR.
                IF AVAIL sub-cat THEN
                    ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Sub-Categoria:  " + sub-cat.ds-sub.
                IF TRIM(tt-acomp.descricao) = "GERAL" THEN
                    ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Sub-Categoria:  GERAL".
            END.

            IF TRIM(tt-acomp.descricao) <> "GERAL" THEN DO:
                IF tt-acomp.vl-real > tt-acomp.vl-prev THEN
                    ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " acima do previsto.".
                ELSE
                    ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " pr¢ximo do previsto.".
            END.
            ELSE DO:
                IF AVAIL categoria THEN
                    IF tt-acomp.vl-real > tt-acomp.vl-prev THEN
                        ASSIGN tt-alerta.alerta = "Valor real de " + categoria.ds-categoria + ":GERAL" + " acima do previsto.".
                    ELSE
                        ASSIGN tt-alerta.alerta = "Valor real de " + categoria.ds-categoria + ":GERAL" + " pr¢ximo do previsto.".
                ELSE
                    IF tt-acomp.vl-real > tt-acomp.vl-prev THEN
                        ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " acima do previsto.".
                    ELSE
                        ASSIGN tt-alerta.alerta = "Valor real de " + TRIM(tt-acomp.descricao) + " pr¢ximo do previsto.".
            END.

            IF TRIM(tt-acomp.descricao) = "OUTROS" THEN DO:
                CASE tt-acomp.cod-cat:
                    WHEN 999 THEN
                        ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Outras Receitas".
                    WHEN 998 THEN
                        ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Outras Despesas".
                    WHEN 997 THEN
                        ASSIGN tt-alerta.descricao = tt-alerta.descricao + "Outros Investimentos em Poupan‡a".
                END CASE.
            END.

            IF CAN-FIND(FIRST bf-alerta
                        WHERE ROWID(bf-alerta) <> ROWID(tt-alerta)
                        AND   bf-alerta.alerta = tt-alerta.alerta) THEN DO:
                DELETE tt-alerta.
            END.

        END.

    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta5 C-Win 
PROCEDURE alerta5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND FIRST mov-conta WHERE ROWID(mov-conta) = prObj NO-LOCK NO-ERROR.
IF AVAIL mov-conta THEN DO:

    FIND FIRST moeda OF mov-conta NO-LOCK NO-ERROR.

    FIND FIRST alerta-exc NO-LOCK
        WHERE alerta-exc.usuario = gcUsuario
        AND   alerta-exc.tipo = 5
        AND   alerta-exc.cd-conta = mov-conta.cd-conta NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        FIND FIRST alerta-exc NO-LOCK
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 5
            AND   alerta-exc.cd-favorecido = mov-conta.cd-favorecido NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc NO-LOCK
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 5
                AND   alerta-exc.cod-cat = mov-conta.cod-categoria
                AND   alerta-exc.cd-sub = mov-conta.cd-sub NO-ERROR.
        END.
    END.
    IF AVAIL alerta-exc THEN DO:
        IF NOT alerta-exc.outro-valor THEN 
            RETURN.
        ELSE DO:
            IF mov-conta.de-valor < alerta-exc.valor-minimo
                OR mov-conta.de-valor > alerta-exc.valor-maximo THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "O valor do movimento est  fora dos limites estipulados!"
                       tt-alerta.descricao = "M¡nimo: " + moeda.sigla + " " + TRIM(STRING(alerta-exc.valor-minimo,"->>>,>>>,>>9.99")) + CHR(10) +
                                             "M ximo: " + moeda.sigla + " " + TRIM(STRING(alerta-exc.valor-maximo,"->>>,>>>,>>9.99")) + CHR(10) +
                                             "Valor:  " + moeda.sigla + " " + TRIM(STRING(mov-conta.de-valor,"->>>,>>>,>>9.99")).
            END.
        END.
    END.
    ELSE DO:
        IF mov-conta.de-valor < alerta.valor-minimo
            OR mov-conta.de-valor > alerta.valor-maximo THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "O valor do movimento est  fora dos limites estipulados!"
                   tt-alerta.descricao = "M¡nimo: " + moeda.sigla + " " + TRIM(STRING(alerta.valor-minimo,"->>>,>>>,>>9.99")) + CHR(10) +
                                         "M ximo: " + moeda.sigla + " " + TRIM(STRING(alerta.valor-maximo,"->>>,>>>,>>9.99")) + CHR(10) +
                                         "Valor:  " + moeda.sigla + " " + TRIM(STRING(mov-conta.de-valor,"->>>,>>>,>>9.99")).
        END.
    END.

END.
ELSE DO:

    FIND FIRST conta WHERE ROWID(conta) = prObj NO-LOCK NO-ERROR.
    FOR EACH mov-conta OF conta NO-LOCK:
        
        FIND FIRST alerta-exc NO-LOCK
            WHERE alerta-exc.usuario = gcUsuario
            AND   alerta-exc.tipo = 5
            AND   alerta-exc.cd-conta = mov-conta.cd-conta NO-ERROR.
        IF NOT AVAIL alerta-exc THEN DO:
            FIND FIRST alerta-exc NO-LOCK
                WHERE alerta-exc.usuario = gcUsuario
                AND   alerta-exc.tipo = 5
                AND   alerta-exc.cd-favorecido = mov-conta.cd-favorecido NO-ERROR.
            IF NOT AVAIL alerta-exc THEN DO:
                FIND FIRST alerta-exc NO-LOCK
                    WHERE alerta-exc.usuario = gcUsuario
                    AND   alerta-exc.tipo = 5
                    AND   alerta-exc.cod-cat = mov-conta.cod-categoria
                    AND   alerta-exc.cd-sub = mov-conta.cd-sub NO-ERROR.
            END.
        END.
        IF AVAIL alerta-exc THEN DO:
            IF NOT alerta-exc.outro-valor THEN 
                NEXT.
            ELSE DO:
                IF mov-conta.de-valor < alerta-exc.valor-minimo
                    OR mov-conta.de-valor > alerta-exc.valor-maximo THEN DO:
                    CREATE tt-alerta.
                    ASSIGN tt-alerta.alerta = "O valor do movimento est  fora dos limites estipulados!"
                           tt-alerta.descricao = "M¡nimo: " + moeda.sigla + " " + STRING(alerta-exc.valor-minimo) + CHR(10) +
                                                 "M ximo: " + moeda.sigla + " " + STRING(alerta-exc.valor-maximo) + CHR(10) +
                                                 "Valor:  " + moeda.sigla + " " + STRING(mov-conta.de-valor) + CHR(10) +
                                                 "Data:   " + moeda.sigla + " " + STRING(mov-conta.dt-mov,"99/99/9999") + CHR(10) +
                                                 "Conta: " + STRING(conta.cd-conta,"999") + " - " + conta.ds-conta.
                END.
            END.
        END.
        ELSE DO:
            IF mov-conta.de-valor < alerta.valor-minimo
                OR mov-conta.de-valor > alerta.valor-maximo THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "O valor do movimento est  fora dos limites estipulados!"
                       tt-alerta.descricao = "M¡nimo: " + moeda.sigla + " " + STRING(alerta.valor-minimo) + CHR(10) +
                                             "M ximo: " + moeda.sigla + " " + STRING(alerta.valor-maximo) + CHR(10) +
                                             "Valor:  " + moeda.sigla + " " + STRING(mov-conta.de-valor) + CHR(10) +
                                             "Data:   " + moeda.sigla + " " + STRING(mov-conta.dt-mov,"99/99/9999") + CHR(10) +
                                             "Conta: " + STRING(conta.cd-conta,"999") + " - " + conta.ds-conta.
            END.
        END.

    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta6 C-Win 
PROCEDURE alerta6 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH alerta-exc NO-LOCK
    WHERE alerta-exc.tipo = 6
    AND   alerta-exc.usuario = gcUsuario
    AND   alerta-exc.outro-valor:

    CASE alerta-exc.cd-favorecido:
        WHEN 1 THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "Patrim“nio Di rio"
                   tt-alerta.descricao = "Clique em executar para ver o patrim“nio do dia." + CHR(10) +
                                         "O patrim“nio mostra quanto dinheiro se tem dispon¡vel, descontando-se as contas a pagar e d‚bitos em cartÆo de cr‚dito."
                   tt-alerta.executa = YES
                   tt-alerta.programa = "relat\r004.w"
                   tt-alerta.parametros = "".
        END.
        WHEN 2 THEN DO:
            IF DAY(TODAY) = 8
            OR DAY(TODAY) = 15
            OR DAY(TODAY) = 22
            OR DAY(TODAY) = 30 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Balan‡o Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o balan‡o do mˆs corrente." + CHR(10) +
                                             "O Balan‡o serve para visualizar os gastos semanais (de sete em sete dias) de cada categoria\sub-categoria."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r001.w"
                       tt-alerta.parametros = "".
            END.
            IF DAY(TODAY) = 1
            OR DAY(TODAY) = 2
            OR DAY(TODAY) = 3
            OR DAY(TODAY) = 4
            OR DAY(TODAY) = 5 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Balan‡o Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o balan‡o do mˆs anterior." + CHR(10) +
                                             "O Balan‡o serve para visualizar os gastos semanais (de sete em sete dias) de cada categoria\sub-categoria."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r001.w"
                       tt-alerta.parametros = "mes=" + (IF MONTH(TODAY) <> 1 THEN STRING(MONTH(TODAY) - 1) ELSE "12") +
                                              ",ano=" + (IF MONTH(TODAY) <> 1 THEN STRING(YEAR(TODAY)) ELSE STRING(YEAR(TODAY) - 1)).
            END.
        END.
        WHEN 3 THEN DO:
            IF DAY(TODAY) = 10
            OR DAY(TODAY) = 15
            OR DAY(TODAY) = 20
            OR DAY(TODAY) = 25
            OR DAY(TODAY) = 30 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Fluxo Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o fluxo de caixa do mˆs corrente." + CHR(10) +
                                             "O Fluxo de caixa mostra o que entrou e o que saiu da conta principal."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r002.w"
                       tt-alerta.parametros = "".
            END.
            IF DAY(TODAY) = 1
            OR DAY(TODAY) = 2
            OR DAY(TODAY) = 3
            OR DAY(TODAY) = 4
            OR DAY(TODAY) = 5 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Fluxo Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o fluxo de caixa do mˆs anterior." + CHR(10) +
                                             "O Fluxo de caixa mostra o que entrou e o que saiu da conta principal."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r002.w"
                       tt-alerta.parametros = "mes=" + (IF MONTH(TODAY) <> 1 THEN STRING(MONTH(TODAY) - 1) ELSE "12") +
                                              ",ano=" + (IF MONTH(TODAY) <> 1 THEN STRING(YEAR(TODAY)) ELSE STRING(YEAR(TODAY) - 1)).
            END.
        END.
        WHEN 4 THEN DO:
            IF DAY(TODAY) = 10
            OR DAY(TODAY) = 20 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Extrato Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o extrato mensal." + CHR(10) +
                                             "O Extrato mostra os movimentos da conta principal como no comprovante banc rio."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r003.w"
                       tt-alerta.parametros = "".
            END.
            IF DAY(TODAY) = 1
            OR DAY(TODAY) = 2
            OR DAY(TODAY) = 3
            OR DAY(TODAY) = 4
            OR DAY(TODAY) = 5 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Extrato Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o extrato do mˆs anterior." + CHR(10) +
                                             "O Extrato mostra os movimentos da conta principal como no comprovante banc rio."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r003.w"
                       tt-alerta.parametros = "mes=" + (IF MONTH(TODAY) <> 1 THEN STRING(MONTH(TODAY) - 1) ELSE "12") +
                                              ",ano=" + (IF MONTH(TODAY) <> 1 THEN STRING(YEAR(TODAY)) ELSE STRING(YEAR(TODAY) - 1)).
            END.
        END.
        WHEN 5 THEN DO:
            IF DAY(TODAY) = 1
            OR DAY(TODAY) = 2
            OR DAY(TODAY) = 3
            OR DAY(TODAY) = 4
            OR DAY(TODAY) = 5 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Relat¢rio Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o relat¢rio do mˆs anterior." + CHR(10) +
                                             "O Relat¢rio traz diversas informa‡äes, como principais despesas, aumento patrimonial e custos do mˆs anterior em comparativo com o mes predecessor."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r009.w"
                       tt-alerta.parametros = "mes=" + (IF MONTH(TODAY) <> 1 THEN STRING(MONTH(TODAY) - 1) ELSE "12") +
                                              ",ano=" + (IF MONTH(TODAY) <> 1 THEN STRING(YEAR(TODAY)) ELSE STRING(YEAR(TODAY) - 1)).
            END.
        END.
        WHEN 6 THEN DO:
            IF DAY(TODAY) = 1
            OR DAY(TODAY) = 18 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Comparativo Mensal"
                       tt-alerta.descricao = "Clique em executar para ver o comparativo do mˆs corrente." + CHR(10) +
                                             "Este relat¢rio faz uma compara‡Æo do mˆs atual com o mˆs anterior e com o mesmo mˆs no ano anterior."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r028.w"
                       tt-alerta.parametros = "".
            END.
        END.
        WHEN 7 THEN DO:
            IF DAY(TODAY) = 6
            OR DAY(TODAY) = 28 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Balan‡o Anual"
                       tt-alerta.descricao = "Clique em executar para ver o balan‡o do ano corrente." + CHR(10) +
                                             "O Balan‡o mostra a distribui‡Æo dos gastos mˆs a mˆs em cada categoria\sub-categoria."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r024.w"
                       tt-alerta.parametros = "".
            END.
        END.
        WHEN 8 THEN DO:
            IF DAY(TODAY) = 2
            OR DAY(TODAY) = 17 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Acompanhamento de Balan‡a Comercial"
                       tt-alerta.descricao = "Clique em executar para ver o acompanhamento da balan‡a comercial." + CHR(10) +
                                             "Este acompanhamento mostra os resultados nos £ltimos 3, 6 e 12 meses al‚m do resultado no ano at‚ o mˆs corrente."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r026.w"
                       tt-alerta.parametros = "".
            END.
        END.
        WHEN 9 THEN DO:
            IF DAY(TODAY) = 3
            OR DAY(TODAY) = 17 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Relat¢rio Anual"
                       tt-alerta.descricao = "Clique em executar para ver o relat¢rio do ano corrente." + CHR(10) +
                                             "O Relat¢rio traz diversas informa‡äes, como principais despesas, aumento patrimonial e custos do ano corrente em comparativo com o ano anterior."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r011.w"
                       tt-alerta.parametros = "".
            END.
        END.
        WHEN 10 THEN DO:
            FIND FIRST conta NO-LOCK
                WHERE conta.id-tipo = 1 NO-ERROR.
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "PrevisÆo de Saldo"
                   tt-alerta.descricao = "Clique em executar para ver a previsÆo de saldo dos pr¢ximos trinta dias." + CHR(10) +
                                         "Mostra uma previsÆo de saldo para os pr¢ximos 30 dias na conta principal, levando em conta agendamentos e simula‡äes, al‚m dos movimentos j  lan‡ados."
                   tt-alerta.executa = YES
                   tt-alerta.programa = "relat\r005.w"
                   tt-alerta.parametros = "data-fim=" + STRING((TODAY + 30),"99/99/9999") + ",simula=YES".
            IF AVAIL conta THEN DO:
                ASSIGN tt-alerta.parametros = tt-alerta.parametros + ",iConta=" + STRING(conta.cd-conta).
            END.
        END.
        WHEN 11 THEN DO:
            IF DAY(TODAY) = 4
            OR DAY(TODAY) = 16
            OR DAY(TODAY) = 26
            OR DAY(TODAY) = 30 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Patrim“nio Anual (Gr fico)"
                       tt-alerta.descricao = "Clique em executar para ver a evolu‡Æo do patrim“nio ao longo do ano." + CHR(10) +
                                             "O patrim“nio representa o ac£mulo de dinheiro no mˆs a mˆs."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "graf\g004.w"
                       tt-alerta.parametros = "data-ini=" + STRING(DATE(1,1,YEAR(TODAY)),"99/99/9999") + ",data-fim=" + STRING(TODAY,"99/99/9999").
            END.
        END.
        WHEN 12 THEN DO:
            IF DAY(TODAY) = 3
            OR DAY(TODAY) = 10
            OR DAY(TODAY) = 17
            OR DAY(TODAY) = 24
            OR DAY(TODAY) = 30 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Custos Anuais (Gr fico)"
                       tt-alerta.descricao = "Clique em executar para ver um demonstrativo de custos ao longo do ano." + CHR(10) +
                                             "O demonstrativo mostra a rela‡Æo entre as despesas e os custos mˆs a mˆs."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "graf\g018.w"
                       tt-alerta.parametros = "data-ini=" + STRING(DATE(1,1,YEAR(TODAY)),"99/99/9999") + ",data-fim=" + STRING(TODAY,"99/99/9999").
            END.
        END.
        WHEN 13 THEN DO:
            IF DAY(TODAY) = 6
            OR DAY(TODAY) = 19
            OR DAY(TODAY) = 27 THEN DO:
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Evolu‡Æo Patrimonial (Gr fico)"
                       tt-alerta.descricao = "Clique em executar para ver a evolu‡Æo do patrim“nio total (bens + financeiro) nos £ltimos 12 meses." + CHR(10) +
                                             "O patrim“nio total representa o ac£mulo de dinheiro mais a varia‡Æo de valor dos bens no mˆs a mˆs."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "graf\g021.w"
                       tt-alerta.parametros = "data-ini=" + STRING((TODAY - 365),"99/99/9999") + ",data-fim=" + STRING(TODAY,"99/99/9999").
            END.
        END.
        WHEN 14 THEN DO:
            IF DAY(TODAY) = 6
            OR DAY(TODAY) = 14
            OR DAY(TODAY) = 21
            OR DAY(TODAY) = 28 THEN DO:
                FIND FIRST item-poupanca NO-LOCK
                    WHERE item-poupanca.ano = YEAR(TODAY) NO-ERROR.
                CREATE tt-alerta.
                ASSIGN tt-alerta.alerta = "Acompanhamento de Poupan‡a"
                       tt-alerta.descricao = "Clique em executar para acompanhar a evolu‡Æo da poupan‡a principal." + CHR(10) +
                                             "Este acompanhamento previsto x realizado mostra o andamento de seu planejamento de poupan‡a."
                       tt-alerta.executa = YES
                       tt-alerta.programa = "relat\r032.w".
                IF AVAIL item-poupanca THEN DO:
                    ASSIGN tt-alerta.parametros = "iPoup=" + STRING(item-poupanca.cd-poupanca).
                END.
            END.
        END.
        WHEN 15 THEN DO:
            IF DAY(TODAY) = 1
            OR DAY(TODAY) = 5
            OR DAY(TODAY) = 9
            OR DAY(TODAY) = 13
            OR DAY(TODAY) = 17
            OR DAY(TODAY) = 21
            OR DAY(TODAY) = 25
            OR DAY(TODAY) = 29 THEN DO:
                FIND LAST orcamento NO-LOCK
                    WHERE orcamento.ano = YEAR(TODAY) NO-ERROR.
                IF AVAIL orcamento THEN DO:
                    CREATE tt-alerta.
                    ASSIGN tt-alerta.alerta = "Acompanhamento de Or‡amento"
                           tt-alerta.descricao = "Clique em executar para acompanhar o or‡amento principal do ano." + CHR(10) +
                                                 "Este acompanhamento mostra quais categorias\sub-categorias estÆo acima\dentro\abaixo do previsto."
                           tt-alerta.executa = YES
                           tt-alerta.programa = "relat\r033.w"
                           tt-alerta.parametros = "iOrc=" + STRING(orcamento.cd-orcamento).
                END.
            END.
        END.
        WHEN 16 THEN DO:
            CREATE tt-alerta.
            ASSIGN tt-alerta.alerta = "Lista de Compras"
                   tt-alerta.descricao = "Clique em executar para ver uma lista dos itens que devem ser comprados na pr¢xima ida ao mercado." + CHR(10) +
                                         "A lista ‚ feita com base no per¡odo de reposi‡Æo de cada item, que ‚ calculado automaticamente a cada compra. Alguns itens presentes nessa lista podem nÆo necessitar ser comprados nesse momento."
                   tt-alerta.executa = YES
                   tt-alerta.programa = "relat\r040.w"
                   tt-alerta.parametros = "".
            IF AVAIL conta THEN DO:
                ASSIGN tt-alerta.parametros = tt-alerta.parametros + ",iConta=" + STRING(conta.cd-conta).
            END.
        END.
    END CASE.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta7 C-Win 
PROCEDURE alerta7 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH favorecido
    WHERE DATE(MONTH(favorecido.data-nasc), DAY(favorecido.data-nasc), YEAR(TODAY)) >= TODAY
    AND   DATE(MONTH(favorecido.data-nasc), DAY(favorecido.data-nasc), YEAR(TODAY)) <= (TODAY + 7)
    AND   favorecido.ativo:

    CREATE tt-alerta.
    ASSIGN tt-alerta.alerta = "Anivers rio de " + favorecido.ds-favorecido + " no dia " + SUBSTRING(STRING(favorecido.data-nasc,"99/99/9999"), 1, 5) + "."
           tt-alerta.descricao = "Data de Nascimento: " + STRING(favorecido.data-nasc,"99/99/9999").

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE alerta8 C-Win 
PROCEDURE alerta8 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF param-mn.perfil = 2 /* Empresarial */ THEN DO:

    RUN gerapend.p (INPUT gcUsuario,
                    INPUT DATE(MONTH(TODAY), 1, YEAR(TODAY)),
                    INPUT TODAY,
                    OUTPUT TABLE tt-pend).
    
    FOR EACH tt-pend
        WHERE tt-pend.dt-pend <= TODAY:
        CREATE tt-alerta.
        ASSIGN tt-alerta.alerta = tt-pend.tipo + " " + tt-pend.ds-pend + " [" + STRING(tt-pend.dt-pend, "99/99/9999") + "]".
               tt-alerta.descricao = tt-pend.ds-pend + CHR(10) + tt-pend.ds-observacao.
    END.
    
END.


/*FOR EACH tarefa NO-LOCK
    WHERE tarefa.dt-alert-tarefa <= TODAY
    AND   tarefa.responsavel = gcUsuario
    AND   tarefa.situacao < 8 /* Concluisa */
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.

    CREATE tt-alerta.
    ASSIGN tt-alerta.alerta = "TAREFA [" + STRING(tarefa.dt-alert-tarefa, "99/99/9999") + "] " + TRIM(favorecido.ds-favorecido) + " - " + tarefa.ds-tarefa.
           tt-alerta.descricao = "Criador: " + tarefa.nome + CHR(10) +
                                 "Data Cria‡Æo: " + STRING(tarefa.dt-cri-tarefa, "99/99/9999") + CHR(10) +
                                 "Observa‡Æo: " + tarefa.ds-observacao.

END.*/

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
  DISPLAY EDITOR-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE im-alert RECT-11 brAlertas btOK EDITOR-1 
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

APPLY "VALUE-CHANGED" TO brAlertas IN FRAME default-frame.

ASSIGN C-Win:TOP-ONLY = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pesquisaAlertas C-Win 
PROCEDURE pesquisaAlertas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

SESSION:SET-WAIT-STATE("image\calc.cur").

FOR EACH tt-alerta:
    DELETE tt-alerta.
END.

IF piPonto = 1 THEN DO:
    FOR EACH feriado NO-LOCK
        WHERE feriado.dt-feriado >= TODAY
        AND   feriado.dt-feriado <= (TODAY + 7):
        CREATE tt-alerta.
        ASSIGN tt-alerta.alerta = "Feriado dia " + STRING(feriado.dt-feriado,"99/99/9999") + " - " + TRIM(feriado.ds-feriado).
    END.
    RUN alerta7.
    RUN alerta8.
END.

FOR EACH alerta 
    WHERE alerta.usuario = gcUsuario
    AND alerta.ponto[piPonto]
    AND alerta.ativo NO-LOCK:

    CASE alerta.tipo:
        WHEN 1 THEN DO:
            RUN alerta1.
        END.
        WHEN 2 THEN DO:
            RUN alerta2.
        END.
        WHEN 3 THEN DO:
            RUN alerta3.
        END.
        WHEN 4 THEN DO:
            RUN alerta4.
        END.
        WHEN 5 THEN DO:
            RUN alerta5.
        END. 
        WHEN 6 THEN DO:
            RUN alerta6.
        END.
    END CASE.

END.

/*RUN alerta7.*/

ASSIGN iUltOrc = 0.

SESSION:SET-WAIT-STATE("").

IF NOT CAN-FIND(FIRST tt-alerta) THEN
    RETURN "NOK".
ELSE
    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

