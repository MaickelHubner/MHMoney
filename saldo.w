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
&GLOBAL-DEFINE Table         conta
&GLOBAL-DEFINE Filho         mov-conta
&GLOBAL-DEFINE LabelFilho    Movimentos Pendentes
&GLOBAL-DEFINE ParentFields  conta.cd-conta conta.ds-conta ~
                             conta.dt-saldo conta.vl-saldo
&GLOBAL-DEFINE KeyFields     conta.cd-conta
&GLOBAL-DEFINE CamposFilho   mov-conta.dt-mov ~
                             fnSit(mov-conta.id-situacao) @ cSit ~
                             mov-conta.nr-mov ~
                             fnTipo(mov-conta.id-tipo) @ cTipo ~
                             fnCd-favorecido(mov-conta.cd-favorecido) @ cCd-favorecido ~
                             mov-conta.de-valor


DEFINE NEW GLOBAL SHARED VARIABLE cCamposIniSaldo AS CHARACTER  NO-UNDO.

/* Local Variable Definitions ---                                       */

{disp_movto.i}
{winalert.i}

/* Buffers */

DEFINE BUFFER bf-{&Filho} FOR {&Filho}.

{func\definitions.i}

/* Campos Extrangeiros */
{campos\cd-favorecido.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-page1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES {&Filho} conta

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 {&CamposFilho}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define QUERY-STRING-br-page1 FOR EACH {&Filho} OF {&Table} NO-LOCK     WHERE {&Filho}.id-situacao <> 3     AND   {&Filho}.agrupado = 0     BY    {&Filho}.dt-mov     BY    {&Filho}.sequencia INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE
&Scoped-define OPEN-QUERY-br-page1 OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK     WHERE {&Filho}.id-situacao <> 3     AND   {&Filho}.agrupado = 0     BY    {&Filho}.dt-mov     BY    {&Filho}.sequencia INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-page1 {&Filho}
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 {&Filho}


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME conta.cd-conta conta.ds-conta ~
conta.dt-saldo conta.vl-saldo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME conta.cd-conta ~
conta.ds-conta conta.dt-saldo conta.vl-saldo 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME conta
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME conta
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH conta SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH conta SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME conta
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME conta


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS conta.cd-conta conta.ds-conta conta.dt-saldo ~
conta.vl-saldo 
&Scoped-define ENABLED-TABLES conta
&Scoped-define FIRST-ENABLED-TABLE conta
&Scoped-Define ENABLED-OBJECTS br-page1 btValor btConf btUpdate-page1 ~
btAdd-page1 btDel-page1 btExit btFirst btLast btNext btPrev btGoTo btZoom ~
data RECT-4 RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS conta.cd-conta conta.ds-conta ~
conta.dt-saldo conta.vl-saldo 
&Scoped-define DISPLAYED-TABLES conta
&Scoped-define FIRST-DISPLAYED-TABLE conta
&Scoped-Define DISPLAYED-OBJECTS valor data final 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd-page1 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btConf 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Conf" 
     SIZE 6.14 BY 1.79 TOOLTIP "Reconciliar o Saldo da Conta".

DEFINE BUTTON btDel-page1 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
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

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Compensar".

DEFINE BUTTON btValor 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Valor" 
     SIZE 6.14 BY 1.79 TOOLTIP "Alterar valor do movimento".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE data AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE final AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo Final" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE VARIABLE saldo-ofc AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor OFC" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE VARIABLE valor AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor Compensado" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 3.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-page1 FOR 
      {&Filho} SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-page1 C-Win _FREEFORM
  QUERY br-page1 NO-LOCK DISPLAY
      {&CamposFilho}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 93 BY 8.71
         FONT 7
         TITLE "" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-page1 AT ROW 10 COL 2
     btValor AT ROW 18.79 COL 14.29 WIDGET-ID 2
     saldo-ofc AT ROW 7.5 COL 57 COLON-ALIGNED
     btConf AT ROW 7 COL 87
     btUpdate-page1 AT ROW 18.79 COL 8.14
     btAdd-page1 AT ROW 18.79 COL 2
     btDel-page1 AT ROW 18.79 COL 20.43
     btExit AT ROW 1.5 COL 88
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     conta.cd-conta AT ROW 4.5 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     conta.ds-conta AT ROW 4.5 COL 33.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 41 BY .79
     btGoTo AT ROW 1.5 COL 29
     btZoom AT ROW 1.5 COL 35.14
     conta.dt-saldo AT ROW 6.5 COL 19 COLON-ALIGNED
          LABEL "Data Saldo Anterior"
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     conta.vl-saldo AT ROW 7.5 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY .79
     valor AT ROW 8.5 COL 19 COLON-ALIGNED
     data AT ROW 6.5 COL 57 COLON-ALIGNED
     final AT ROW 8.5 COL 57 COLON-ALIGNED
     RECT-4 AT ROW 6 COL 2
     RECT-5 AT ROW 4 COL 2
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 95 BY 19.58
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
         TITLE              = "Template Padr∆o de Master-Detail"
         HEIGHT             = 19.58
         WIDTH              = 95
         MAX-HEIGHT         = 21.08
         MAX-WIDTH          = 95
         VIRTUAL-HEIGHT     = 21.08
         VIRTUAL-WIDTH      = 95
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
/* BROWSE-TAB br-page1 1 DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN conta.dt-saldo IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN final IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN saldo-ofc IN FRAME DEFAULT-FRAME
   NO-DISPLAY NO-ENABLE                                                 */
ASSIGN 
       saldo-ofc:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

/* SETTINGS FOR FILL-IN valor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK
    WHERE {&Filho}.id-situacao <> 3
    AND   {&Filho}.agrupado = 0
    BY    {&Filho}.dt-mov
    BY    {&Filho}.sequencia INDEXED-REPOSITION.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.conta"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Master-Detail */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Master-Detail */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-page1
&Scoped-define SELF-NAME br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON MOUSE-SELECT-DBLCLICK OF br-page1 IN FRAME DEFAULT-FRAME
OR RETURN OF br-page1 DO:
    {func\br_dbclick.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON ROW-DISPLAY OF br-page1 IN FRAME DEFAULT-FRAME
DO:
    IF mov-conta.id-tipo = 0 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 5
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 5
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 5
               cSit:FGCOLOR IN BROWSE br-page1 = 5
               cTipo:FGCOLOR IN BROWSE br-page1 = 5
               mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 5.

    IF mov-conta.id-tipo = 3 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 3
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 3
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 3
               cSit:FGCOLOR IN BROWSE br-page1 = 3
               cTipo:FGCOLOR IN BROWSE br-page1 = 3
               mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 3.

    IF mov-conta.id-tipo = 1
    OR mov-conta.id-tipo = 2 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 1
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 1
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 1
               cSit:FGCOLOR IN BROWSE br-page1 = 1
               cTipo:FGCOLOR IN BROWSE br-page1 = 1
               mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 1.

    IF mov-conta.id-situacao <> 1 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 8
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 8
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 8
               cSit:FGCOLOR IN BROWSE br-page1 = 8
               cTipo:FGCOLOR IN BROWSE br-page1 = 8
               mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 8.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    {func\bt_add_page.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btConf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btConf C-Win
ON CHOOSE OF btConf IN FRAME DEFAULT-FRAME /* Conf */
DO:

    DEFINE VARIABLE l-OK AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE hTemp AS HANDLE     NO-UNDO.
    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    IF INPUT FRAME {&FRAME-NAME} saldo-ofc = 0 
    OR (INPUT FRAME {&FRAME-NAME} saldo-ofc <> 0 AND INPUT FRAME {&FRAME-NAME} final = INPUT FRAME {&FRAME-NAME} saldo-ofc) THEN DO:

        FIND CURRENT conta EXCLUSIVE-LOCK.
    
        ASSIGN conta.vl-saldo = INPUT FRAME {&FRAME-NAME} final
               conta.dt-saldo = INPUT FRAME {&FRAME-NAME} data
               cLista = "MOVIMENTOS PAGOS NESTA FATURA" + CHR(10) +
                        "=============================" + CHR(10) + CHR(10).
    
        FOR EACH bf-mov-conta OF conta
            WHERE bf-mov-conta.id-situacao = 2
            AND   bf-mov-conta.agrupado = 0 NO-LOCK:

            FIND FIRST favorecido OF bf-mov-conta NO-LOCK NO-ERROR.
            ASSIGN cLista = cLista + STRING(bf-mov-conta.dt-mov,"99/99/9999") + " " +
                                     STRING(favorecido.ds-favorecido,"X(30)") + " " +
                                     STRING(bf-mov-conta.de-valor,"->>,>>9.99") + CHR(10).
    
        END.
        FOR EACH bf-mov-conta OF conta
            WHERE bf-mov-conta.id-situacao = 2 EXCLUSIVE-LOCK:

            ASSIGN bf-mov-conta.id-situacao = 3.
    
        END.
    
        IF conta.id-tipo = 3 THEN DO:
            IF NOT conta.dinheiro THEN DO:
                IF CAN-FIND(FIRST agenda
                            WHERE agenda.cd-favorecido = conta.cd-fav-padrao
                            AND   (agenda.cd-conta     = conta.cd-conta
                            OR     agenda.conta-transf = conta.cd-conta)
                            AND   agenda.id-tipo       = 3) THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Efetuar Pagamento (006)', INPUT 'Deseja efetuar o pagamento da fatura agora ?', INPUT 'Se for confirmado ser† gerado um movimento de pagamento da fatura no valor total do saldo para a data informada.')"}
                    IF RETURN-VALUE = "OK" THEN DO:
                        FIND LAST bf-mov-conta OF conta NO-LOCK NO-ERROR.
                        CREATE mov-conta.
                        ASSIGN mov-conta.cd-conta      = conta.cd-conta
                               mov-conta.cd-sequencia  = bf-mov-conta.cd-sequencia + 1
                               mov-conta.dt-mov        = conta.dt-saldo
                               mov-conta.de-valor      = (-1) * conta.vl-saldo
                               mov-conta.id-tipo       = 3
                               mov-conta.id-situacao   = 1
                               mov-conta.cd-favorecido = conta.cd-fav-padrao
                               mov-conta.ds-observacao = cLista
                               pcActionBT              = "UPDATE"
                               r-mov-conta             = ROWID(mov-conta)
                               r-parent                = ROWID(conta).
                        {func\run.i &Programa = "mov-conta_det.w"}
                    END.
                END.
            END.
        END.
    
        RUN winalert.w (INPUT 3, INPUT ROWID(conta), INPUT YES, OUTPUT TABLE tt-alerta).
    
        DISABLE final WITH FRAME {&FRAME-NAME}.
    
        RUN displayFields IN THIS-PROCEDURE.

        RUN som.p(INPUT "music\regist.wav").

    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Atualizar Saldo (019)', INPUT 'Saldo n∆o confere com o valor do OFC!', INPUT 'O saldo dos movimentos compensados n∆o confere com o valor final no arquivo OFC')"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    {func\bt_del_page.i}
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


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    /*{func\bt_update_page.i}*/
  
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    IF AVAIL mov-conta THEN DO:
    
        FIND CURRENT mov-conta EXCLUSIVE-LOCK.
        ASSIGN rTemp = ROWID(mov-conta).
    
        IF mov-conta.id-situacao = 1 THEN DO:
            {func\run.i &Programa = "data.w (INPUT 'Data de Compensaá∆o', INPUT mov-conta.dt-mov, OUTPUT dtTemp)"}
            IF RETURN-VALUE = "OK" THEN DO:
                IF dtTemp < mov-conta.dt-mov THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (024)', INPUT 'Data inv†lida!', INPUT 'A data de compensaá∆o n∆o pode ser menor que a data do movimento.')"}
                    RETURN "NOK".
                END.
                ASSIGN mov-conta.id-situacao = 2
                       mov-conta.dt-compensacao = dtTemp.
            END.
        END.
        ELSE DO:
            ASSIGN mov-conta.id-situacao = 1
                   mov-conta.dt-compensacao = ?.
        END.
        IF mov-conta.id-tipo = 0 THEN DO:
            FOR EACH bf-mov-conta EXCLUSIVE-LOCK
                WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
                AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia.
                ASSIGN bf-mov-conta.id-situacao = mov-conta.id-situacao
                       bf-mov-conta.dt-compensacao = mov-conta.dt-compensacao.
            END.
        END.
    
        RUN som.p(INPUT "music\ok.wav").

        {&OPEN-QUERY-{&BROWSE-NAME}}
        REPOSITION br-page1 TO ROWID rTemp.
    
        RUN recalcula IN THIS-PROCEDURE.
    
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btValor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btValor C-Win
ON CHOOSE OF btValor IN FRAME DEFAULT-FRAME /* Valor */
DO:

    DEFINE VARIABLE deTemp AS DECIMAL       NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL mov-conta AND mov-conta.id-situacao = 1 THEN DO:

        {func\run.i &Programa = "valor.w (INPUT 'Valor do Movimento', INPUT mov-conta.de-valor, OUTPUT deTemp)"}
        IF deTemp <> ? THEN DO:
            FIND CURRENT mov-conta EXCLUSIVE-LOCK.
            ASSIGN mov-conta.de-valor = deTemp.
            DISPLAY mov-conta.de-valor WITH BROWSE br-page1.
        END.

    END.

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


&Scoped-define SELF-NAME data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data C-Win
ON ENTRY OF data IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data C-Win
ON LEAVE OF data IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME final
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL final C-Win
ON ENTRY OF final IN FRAME DEFAULT-FRAME /* Saldo Final */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL final C-Win
ON LEAVE OF final IN FRAME DEFAULT-FRAME /* Saldo Final */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{func\calendar.i data}
{func\calc.i final}

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

ON F11 ANYWHERE
DO:
    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario NO-ERROR.
    IF AVAIL usuario AND usuario.administrador THEN DO:
        ENABLE final
               btConf WITH FRAME default-frame.
    END.
END.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i saldo}
  RUN enable_UI.
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
{func\master_detail\control_buttons.i}

ASSIGN btFirst:HIDDEN IN FRAME {&FRAME-NAME} = YES
       btPrev:HIDDEN IN FRAME {&FRAME-NAME} = YES
       btNext:HIDDEN IN FRAME {&FRAME-NAME} = YES
       btLast:HIDDEN IN FRAME {&FRAME-NAME} = YES
       btGoTo:HIDDEN IN FRAME {&FRAME-NAME} = YES
       btZoom:HIDDEN IN FRAME {&FRAME-NAME} = YES
       btDel-page1:HIDDEN IN FRAME {&FRAME-NAME} = YES.

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
{func\master_detail\display.i}

RUN recalcula IN THIS-PROCEDURE.

{func\assign_ini_fields.i cCamposIniSaldo}

IF INPUT FRAME {&FRAME-NAME} saldo-ofc <> 0 THEN DO:
    ASSIGN saldo-ofc:HIDDEN IN FRAME {&FRAME-NAME} = NO.
    DISABLE data WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ASSIGN saldo-ofc:HIDDEN IN FRAME {&FRAME-NAME} = YES.
    ENABLE data WITH FRAME {&FRAME-NAME}.
END.

IF NOT AVAIL {&Table} THEN DO:

    ASSIGN conta.cd-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           conta.ds-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

END.

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
  DISPLAY valor data final 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE conta THEN 
    DISPLAY conta.cd-conta conta.ds-conta conta.dt-saldo conta.vl-saldo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-page1 btValor btConf btUpdate-page1 btAdd-page1 btDel-page1 btExit 
         btFirst btLast btNext btPrev conta.cd-conta conta.ds-conta btGoTo 
         btZoom conta.dt-saldo conta.vl-saldo data RECT-4 RECT-5 RECT-6 
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

ASSIGN data = TODAY.
DISPLAY data WITH FRAME {&FRAME-NAME}.

{func\initialize.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalcula C-Win 
PROCEDURE recalcula :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN valor = 0.
FOR EACH bf-{&Filho} OF {&TABLE} NO-LOCK
    WHERE bf-{&Filho}.id-situacao = 2
    AND   bf-{&Filho}.agrupado = 0:

    ASSIGN valor = valor + bf-{&Filho}.de-valor.

END.

ASSIGN final = conta.vl-saldo + valor.

DISPLAY valor
        final WITH FRAME {&FRAME-NAME}.

IF valor <> 0 THEN
    ENABLE btConf WITH FRAME {&FRAME-NAME}.
ELSE
    IF CAN-FIND(FIRST bf-{&Filho} OF {&TABLE}
                WHERE bf-{&Filho}.id-situacao = 2) THEN
        ENABLE btConf WITH FRAME {&FRAME-NAME}.
    ELSE
        DISABLE btConf WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

