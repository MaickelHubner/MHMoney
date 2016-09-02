&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-nf NO-UNDO LIKE pedido.
DEFINE TEMP-TABLE tt-pedido NO-UNDO LIKE pedido
       field r-rowid as rowid
       field marcado as logical.



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

{func\definitions.i}
{func\data.i}
{campos\cd-favorecido.i}

DEFINE VARIABLE cCliente AS CHARACTER COLUMN-LABEL "Cliente" FORMAT "X(28)" NO-UNDO.
DEFINE VARIABLE cCli-fat AS CHARACTER COLUMN-LABEL "Cliente Faturamento" FORMAT "X(28)" NO-UNDO.

DEFINE NEW GLOBAL SHARED VARIABLE r-pedido AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-nota-fiscal AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brNF

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-nf tt-pedido

/* Definitions for BROWSE brNF                                          */
&Scoped-define FIELDS-IN-QUERY-brNF ~
fnCd-favorecido(tt-nf.cd-favorecido) @ cCliente tt-nf.val-total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brNF 
&Scoped-define QUERY-STRING-brNF FOR EACH tt-nf NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brNF OPEN QUERY brNF FOR EACH tt-nf NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brNF tt-nf
&Scoped-define FIRST-TABLE-IN-QUERY-brNF tt-nf


/* Definitions for BROWSE brPed                                         */
&Scoped-define FIELDS-IN-QUERY-brPed tt-pedido.marcado tt-pedido.nr-pedido tt-pedido.dt-pedido tt-pedido.num-cliente fnCd-favorecido(tt-pedido.cd-favorecido) @ cCliente fnCd-favorecido(tt-pedido.cliente-fat) @ cCli-fat tt-pedido.val-total   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPed   
&Scoped-define SELF-NAME brPed
&Scoped-define QUERY-STRING-brPed FOR EACH tt-pedido NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brPed OPEN QUERY {&SELF-NAME} FOR EACH tt-pedido NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brPed tt-pedido
&Scoped-define FIRST-TABLE-IN-QUERY-brPed tt-pedido


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brNF}~
    ~{&OPEN-QUERY-brPed}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btExit RECT-7 IMAGE-5 IMAGE-6 dt-ini dt-fim ~
iCd-favorecido des-cli brPed btMarc btTodos btNenhum btDet brNF btGera ~
tg-recibo 
&Scoped-Define DISPLAYED-OBJECTS dt-ini dt-fim iCd-favorecido des-cli ~
tg-recibo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btDet 
     LABEL "Detalhes" 
     SIZE 10 BY 1.

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btGera 
     LABEL "Faturar" 
     SIZE 10 BY 1.

DEFINE BUTTON btMarc 
     LABEL "Marcar" 
     SIZE 10 BY 1.

DEFINE BUTTON btNenhum 
     LABEL "Nenhum" 
     SIZE 10 BY 1.

DEFINE BUTTON btTodos 
     LABEL "Todos" 
     SIZE 10 BY 1.

DEFINE VARIABLE des-cli AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .79 NO-UNDO.

DEFINE VARIABLE dt-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE VARIABLE dt-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Per°odo" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE VARIABLE iCd-favorecido AS INTEGER FORMAT "9999" INITIAL 0 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 80 BY 2.75.

DEFINE VARIABLE tg-recibo AS LOGICAL INITIAL no 
     LABEL "Faturar como Recibo" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brNF FOR 
      tt-nf SCROLLING.

DEFINE QUERY brPed FOR 
      tt-pedido SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brNF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brNF C-Win _STRUCTURED
  QUERY brNF NO-LOCK DISPLAY
      fnCd-favorecido(tt-nf.cd-favorecido) @ cCliente
      tt-nf.val-total FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 80 BY 4.5
         FONT 1
         TITLE "Notas Fiscais / Recibos".

DEFINE BROWSE brPed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPed C-Win _FREEFORM
  QUERY brPed NO-LOCK DISPLAY
      tt-pedido.marcado WIDTH 1.5 COLUMN-LABEL "" view-as toggle-box
      tt-pedido.nr-pedido FORMAT ">>>>,>>9"
      tt-pedido.dt-pedido FORMAT "99/99/9999"
      tt-pedido.num-cliente FORMAT "x(12)"
      fnCd-favorecido(tt-pedido.cd-favorecido) @ cCliente
      fnCd-favorecido(tt-pedido.cliente-fat) @ cCli-fat
      tt-pedido.val-total FORMAT "->>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 80 BY 7.25
         FONT 1
         TITLE "Pedidos Atendidos no Per°odo".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btExit AT ROW 1.75 COL 75 WIDGET-ID 44
     dt-ini AT ROW 1.75 COL 20 COLON-ALIGNED WIDGET-ID 22
     dt-fim AT ROW 1.75 COL 39 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     iCd-favorecido AT ROW 2.75 COL 20 COLON-ALIGNED WIDGET-ID 16
     des-cli AT ROW 2.75 COL 25 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     brPed AT ROW 4.25 COL 2 WIDGET-ID 200
     btMarc AT ROW 11.5 COL 2 WIDGET-ID 30
     btTodos AT ROW 11.5 COL 12 WIDGET-ID 32
     btNenhum AT ROW 11.5 COL 22 WIDGET-ID 34
     btDet AT ROW 11.5 COL 32 WIDGET-ID 36
     brNF AT ROW 12.75 COL 2 WIDGET-ID 300
     btGera AT ROW 17.25 COL 2 WIDGET-ID 38
     tg-recibo AT ROW 17.38 COL 13 WIDGET-ID 42
     RECT-7 AT ROW 1.25 COL 2 WIDGET-ID 20
     IMAGE-5 AT ROW 1.33 COL 31 WIDGET-ID 24
     IMAGE-6 AT ROW 1.33 COL 35.43 WIDGET-ID 26
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 81.43 BY 17.5
         FONT 1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-nf T "?" NO-UNDO money pedido
      TABLE: tt-pedido T "?" NO-UNDO money pedido
      ADDITIONAL-FIELDS:
          field r-rowid as rowid
          field marcado as logical
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 17.5
         WIDTH              = 81.43
         MAX-HEIGHT         = 20.38
         MAX-WIDTH          = 99.57
         VIRTUAL-HEIGHT     = 20.38
         VIRTUAL-WIDTH      = 99.57
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = yes
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
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
   FRAME-NAME                                                           */
/* BROWSE-TAB brPed des-cli DEFAULT-FRAME */
/* BROWSE-TAB brNF btDet DEFAULT-FRAME */
ASSIGN 
       des-cli:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brNF
/* Query rebuild information for BROWSE brNF
     _TblList          = "Temp-Tables.tt-nf"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > "_<CALC>"
"fnCd-favorecido(tt-nf.cd-favorecido) @ cCliente" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = Temp-Tables.tt-nf.val-total
     _Query            is OPENED
*/  /* BROWSE brNF */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPed
/* Query rebuild information for BROWSE brPed
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-pedido NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brPed */
&ANALYZE-RESUME

 



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


&Scoped-define BROWSE-NAME brPed
&Scoped-define SELF-NAME brPed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON MOUSE-SELECT-CLICK OF brPed IN FRAME DEFAULT-FRAME /* Pedidos Atendidos no Per°odo */
DO:
  /*APPLY "CHOOSE" TO btMarc.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON MOUSE-SELECT-DBLCLICK OF brPed IN FRAME DEFAULT-FRAME /* Pedidos Atendidos no Per°odo */
DO:
    APPLY "CHOOSE" TO btMarc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON RETURN OF brPed IN FRAME DEFAULT-FRAME /* Pedidos Atendidos no Per°odo */
DO:
  
    APPLY "CHOOSE" TO btMarc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON ROW-DISPLAY OF brPed IN FRAME DEFAULT-FRAME /* Pedidos Atendidos no Per°odo */
DO:
  
    IF tt-pedido.nr-pedido-ant <> 0 THEN DO:

        ASSIGN tt-pedido.nr-pedido:FGCOLOR IN BROWSE brPed = 2
               tt-pedido.dt-pedido:FGCOLOR IN BROWSE brPed = 2
               cCliente:FGCOLOR IN BROWSE brPed = 2
               cCli-fat:FGCOLOR IN BROWSE brPed = 2
               tt-pedido.val-total:FGCOLOR IN BROWSE brPed = 2
               tt-pedido.num-cliente:FGCOLOR IN BROWSE brPed = 2.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPed C-Win
ON VALUE-CHANGED OF brPed IN FRAME DEFAULT-FRAME /* Pedidos Atendidos no Per°odo */
DO:
  
    IF AVAIL tt-pedido THEN DO:
        IF tt-pedido.marcado THEN
            ASSIGN btMarc:LABEL = "Desmarcar".
        ELSE
            ASSIGN btMarc:LABEL = "Marcar".
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDet C-Win
ON CHOOSE OF btDet IN FRAME DEFAULT-FRAME /* Detalhes */
DO:
  
    IF AVAIL tt-pedido THEN DO:

        ASSIGN r-pedido = tt-pedido.r-rowid.
        {func\run.i &Programa = "pedido.w"}

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


&Scoped-define SELF-NAME btGera
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGera C-Win
ON CHOOSE OF btGera IN FRAME DEFAULT-FRAME /* Faturar */
DO:
    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO INITIAL 1.
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE iMov AS INTEGER     NO-UNDO.

    IF AVAIL tt-nf THEN DO:

        FIND FIRST param-mn NO-LOCK NO-ERROR.
        IF INPUT FRAME {&FRAME-NAME} tg-recibo AND param-mn.conta-recibo = 0 THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Pedidos (051)', INPUT 'Parametrizaá∆o incorreta.', INPUT 'Vocà deve informar os parÉmetros para geraá∆o de Recibo.')"}
            RETURN "NOK".
        END.

        FIND LAST nota-fiscal NO-LOCK NO-ERROR.
        IF AVAIL nota-fiscal THEN
            ASSIGN iAux = nota-fiscal.nr-controle + 1.
        ELSE
            ASSIGN iAux = 1.

        CREATE nota-fiscal.
        ASSIGN nota-fiscal.nr-controle = iAux
               nota-fiscal.tipo = (IF INPUT FRAME {&FRAME-NAME} tg-recibo THEN 2 /* Recibo */ ELSE 1 /* Nota Fiscal */)
               nota-fiscal.cd-favorecido = tt-nf.cd-favorecido
               nota-fiscal.dt-emissao = TODAY
               nota-fiscal.val-itens = tt-nf.val-total
               nota-fiscal.val-total = tt-nf.val-total
               nota-fiscal.cod-categoria = param-mn.categoria-nf
               nota-fiscal.cd-sub = param-mn.sub-nf.

        FOR EACH tt-pedido
            WHERE tt-pedido.marcado
            AND   tt-pedido.cliente-fat = tt-nf.cd-favorecido:            

            FIND FIRST pedido EXCLUSIVE-LOCK
                WHERE ROWID(pedido) = tt-pedido.r-rowid NO-ERROR.

            FOR EACH pedido-item OF pedido NO-LOCK:

                FIND FIRST nota-fiscal-item EXCLUSIVE-LOCK
                    WHERE nota-fiscal-item.nr-controle = iAux
                    AND   nota-fiscal-item.cd-item = pedido-item.cd-item
                    AND   nota-fiscal-item.val-unitario = pedido-item.val-unitario NO-ERROR.
                IF NOT AVAIL nota-fiscal-item THEN DO:
                    CREATE nota-fiscal-item.
                    ASSIGN nota-fiscal-item.nr-controle = iAux
                           nota-fiscal-item.sequencia = iSeq
                           nota-fiscal-item.cd-item = pedido-item.cd-item
                           nota-fiscal-item.val-unitario = pedido-item.val-unitario
                           iSeq = iSeq + 1.
                END.

                ASSIGN nota-fiscal-item.quantidade = nota-fiscal-item.quantidade + pedido-item.qt-pedida
                       nota-fiscal-item.val-total = nota-fiscal-item.quantidade * nota-fiscal-item.val-unitario.

                IF CAN-FIND(FIRST pedido-item-anexo OF pedido-item) THEN DO:

                    ASSIGN nota-fiscal-item.ds-observacao = nota-fiscal-item.ds-observacao +
                           "Arquivos Pedido " + (IF pedido.num-cliente <> "" THEN pedido.num-cliente ELSE STRING(pedido.nr-pedido)) + ": " + CHR(13) + CHR(13).

                    FOR EACH pedido-item-anexo OF pedido-item NO-LOCK:
                        ASSIGN nota-fiscal-item.ds-observacao = nota-fiscal-item.ds-observacao + pedido-item-anexo.ds-arquivo + CHR(13).
                    END.
                END.

                IF CAN-FIND(FIRST apontamento OF pedido-item) THEN DO:

                    ASSIGN nota-fiscal-item.ds-observacao = nota-fiscal-item.ds-observacao + (IF nota-fiscal-item.ds-observacao <> "" THEN CHR(13) ELSE "") +
                           "Apontamentos Pedido " + (IF pedido.num-cliente <> "" THEN pedido.num-cliente ELSE STRING(pedido.nr-pedido)) + ": " + CHR(13) + CHR(13).

                    FOR EACH apontamento OF pedido-item NO-LOCK:
                        ASSIGN nota-fiscal-item.ds-observacao = nota-fiscal-item.ds-observacao +
                               STRING(apontamento.data) + " " + apontamento.hora-ini + " - " + 
                               apontamento.hora-fim + " : " + REPLACE(REPLACE(apontamento.ds-apontamento, CHR(13), " "), CHR(10), " ") + CHR(13).
                    END.
                END.

            END.

            ASSIGN pedido.nr-controle = iAux
                   pedido.situacao = 4 /* Faturado */.

        END.

        IF NOT INPUT FRAME {&FRAME-NAME} tg-recibo THEN DO:
            ASSIGN r-nota-fiscal = ROWID(nota-fiscal).
            REPEAT:
                ASSIGN pgInitialize = "UPDATE".
                {func\run.i &Programa = "nota.w"}
                IF nota-fiscal.nr-nota = "" THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Pedidos (051)', INPUT 'Dados n∆o foram informados.', INPUT 'Vocà deve informar todos os dados necess†rios para geraá∆o da Nota Fiscal.')"}
                END.
                ELSE LEAVE.
            END.
            RUN calcImpNF.p (INPUT ROWID(nota-fiscal)).
            REPEAT:
                {func\run.i &Programa = "geraparc.w (INPUT ROWID(nota-fiscal))"}
                IF NOT CAN-FIND(FIRST parc-nota-fiscal OF nota-fiscal) THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Pedidos (051)', INPUT 'Parcelas n∆o informadas.', INPUT 'Vocà deve gerar no m°nimo uma parcela para pagamento da Nota Fiscal.')"}
                END.
                ELSE LEAVE.
            END.
        END.
        ELSE DO:

            FIND FIRST conta NO-LOCK
                WHERE conta.cd-conta = param-mn.conta-recibo NO-ERROR.
            IF AVAIL conta THEN DO:
                FIND LAST mov-conta OF conta NO-LOCK NO-ERROR.
                IF AVAIL mov-conta THEN
                    ASSIGN iMov = mov-conta.cd-sequencia + 1.
                ELSE
                    ASSIGN iMov = 1.
            END.

            CREATE parc-nota-fiscal.
            ASSIGN parc-nota-fiscal.nr-controle = nota-fiscal.nr-controle
                   parc-nota-fiscal.sequencia = 1
                   parc-nota-fiscal.situacao = 2 /* Liquidada */
                   parc-nota-fiscal.dt-parcela = TODAY
                   parc-nota-fiscal.val-parcela = nota-fiscal.val-total
                   parc-nota-fiscal.cd-conta = conta.cd-conta
                   parc-nota-fiscal.cd-sequencia = iMov.

            ASSIGN nota-fiscal.cod-categoria = param-mn.categoria-recibo
                   nota-fiscal.cd-sub = param-mn.sub-recibo.

            CREATE mov-conta.
            ASSIGN mov-conta.cd-conta = param-mn.conta-recibo
                   mov-conta.cd-sequencia = iMov
                   mov-conta.id-tipo = (IF conta.id-tipo <> 3 THEN 1 ELSE 2)
                   mov-conta.id-situacao = 1 /* N∆o Compensado */
                   mov-conta.dt-mov = TODAY
                   mov-conta.de-valor = nota-fiscal.val-total
                   mov-conta.cd-favorecido = nota-fiscal.cd-favorecido
                   mov-conta.cod-categoria = param-mn.categoria-recibo
                   mov-conta.cd-sub = param-mn.sub-recibo.
            ASSIGN pcActionBT = "UPDATE"
                   r-parent = ROWID(conta)
                   r-mov-conta = ROWID(mov-conta).
            {func\run.i &Programa = "mov-conta_det.w"}

        END.

        ASSIGN cAux = "Foi gerada a Nota Fiscal \ Recibo com o n£mero de controle " + STRING(iAux) + ".".
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Pedidos (051)', INPUT 'Faturamento efetuado com sucesso.', INPUT cAux)"}

        RUN recalc.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMarc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMarc C-Win
ON CHOOSE OF btMarc IN FRAME DEFAULT-FRAME /* Marcar */
DO:
  
    IF AVAIL tt-pedido THEN DO:
        ASSIGN tt-pedido.marcado = NOT tt-pedido.marcado.
        RUN gerarNFs.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNenhum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNenhum C-Win
ON CHOOSE OF btNenhum IN FRAME DEFAULT-FRAME /* Nenhum */
DO:
  
    FOR EACH tt-pedido:
        ASSIGN tt-pedido.marcado = FALSE.
    END.
    FIND FIRST tt-pedido NO-ERROR.
    RUN gerarNFs.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btTodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btTodos C-Win
ON CHOOSE OF btTodos IN FRAME DEFAULT-FRAME /* Todos */
DO:
  
    FOR EACH tt-pedido:
        ASSIGN tt-pedido.marcado = TRUE.
    END.
    FIND FIRST tt-pedido NO-ERROR.
    RUN gerarNFs.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dt-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-fim C-Win
ON ENTRY OF dt-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-fim C-Win
ON LEAVE OF dt-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} dt-fim <> dt-fim THEN DO:
        RUN recalc.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dt-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-ini C-Win
ON ENTRY OF dt-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-ini C-Win
ON LEAVE OF dt-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} dt-ini <> dt-ini THEN DO:
        RUN recalc.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iCd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-favorecido C-Win
ON ENTRY OF iCd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-favorecido C-Win
ON LEAVE OF iCd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela="iCd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-cli"}
                  
    IF INPUT FRAME {&FRAME-NAME} iCd-favorecido = 0 THEN DO:

        ASSIGN des-cli = "Todos".
        DISPLAY des-cli
            WITH FRAME {&FRAME-NAME}.

    END.

    IF INPUT FRAME {&FRAME-NAME} iCd-favorecido <> iCd-favorecido THEN DO:
        RUN recalc.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF iCd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF iCd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="iCd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="des-cli"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brNF
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-cli
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = iCd-favorecido}
                          
{func\calendar.i dt-ini}
{func\calendar.i dt-fim}

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
  {version.i fat}
  RUN initialize.
  RUN enable_UI.
  RUN displayFields.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    APPLY "LEAVE" TO iCd-favorecido IN FRAME {&FRAME-NAME}.

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
  DISPLAY dt-ini dt-fim iCd-favorecido des-cli tg-recibo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btExit RECT-7 IMAGE-5 IMAGE-6 dt-ini dt-fim iCd-favorecido des-cli 
         brPed btMarc btTodos btNenhum btDet brNF btGera tg-recibo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE gerarNFs C-Win 
PROCEDURE gerarNFs :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE rTemp AS ROWID       NO-UNDO.

    EMPTY TEMP-TABLE tt-nf.

    IF AVAIL tt-pedido THEN DO:

        ASSIGN rTemp = ROWID(tt-pedido).

        FOR EACH tt-pedido
            WHERE tt-pedido.marcado:

            FIND FIRST tt-nf
                WHERE tt-nf.cd-favorecido = tt-pedido.cliente-fat NO-ERROR.
            IF NOT AVAIL tt-nf THEN DO:
                CREATE tt-nf.
                BUFFER-COPY tt-pedido TO tt-nf.
                ASSIGN tt-nf.cd-favorecido = tt-pedido.cliente-fat
                       tt-nf.val-total = 0.
            END.
            ASSIGN tt-nf.val-total = tt-nf.val-total + tt-pedido.val-total.

        END.

        {&OPEN-QUERY-brPed}
        REPOSITION brPed TO ROWID rTemp.
        APPLY "VALUE-CHANGED" TO brPed IN FRAME {&FRAME-NAME}.
        {&OPEN-QUERY-brNF}

    END.
    ELSE DO:
        {&OPEN-QUERY-brPed}
        APPLY "VALUE-CHANGED" TO brPed IN FRAME {&FRAME-NAME}.
        {&OPEN-QUERY-brNF}
    END.

    RETURN "OK".

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
    DEFINE VARIABLE dt-aux AS DATE        NO-UNDO.
    
    ASSIGN dt-aux = DATE(MONTH(TODAY), 1, YEAR(TODAY)) - 1
           dt-ini = DATE(MONTH(dt-aux), 1, YEAR(dt-aux))
           dt-fim = fnUltimoDia(MONTH(TODAY), YEAR(TODAY)).

    RETURN "OK".

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
        ASSIGN iCd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
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
    
    ASSIGN INPUT FRAME {&FRAME-NAME} dt-ini dt-fim iCd-favorecido.

    EMPTY TEMP-TABLE tt-pedido.

    FOR EACH pedido NO-LOCK
        WHERE pedido.dt-pedido >= dt-ini
        AND   pedido.dt-pedido <= dt-fim
        AND   pedido.situacao = 3 /* Atendido */:

        IF iCd-favorecido <> 0 THEN
            IF pedido.cliente-fat <> iCd-favorecido THEN NEXT.

        CREATE tt-pedido.
        BUFFER-COPY pedido TO tt-pedido.
        ASSIGN tt-pedido.r-rowid = ROWID(pedido)
               tt-pedido.marcado = YES.
    END.
    
    /** verifica se o pedido tem antecipacoes **/
    FOR EACH tt-pedido WHERE tt-pedido.nr-pedido-ant = 0,
        EACH pedido NO-LOCK
        WHERE pedido.nr-pedido-ant = tt-pedido.nr-pedido:
            ASSIGN tt-pedido.val-total = tt-pedido.val-total - pedido.val-total.        
    END.
    
    FIND FIRST tt-pedido NO-LOCK NO-ERROR.
    RUN gerarNFs.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

