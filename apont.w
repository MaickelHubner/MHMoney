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

DEFINE VARIABLE cCliente AS CHARACTER FORMAT "X(12)"  NO-UNDO COLUMN-LABEL "Cliente".
DEFINE VARIABLE cPedido AS CHARACTER FORMAT "X(40)"  NO-UNDO COLUMN-LABEL "Projeto".
DEFINE VARIABLE cDescItem AS CHARACTER FORMAT "X(20)"  NO-UNDO COLUMN-LABEL "Item".

/* Parameters Definitions ---                                           */

/* Pr‚-processadores */
&GLOBAL-DEFINE Table         usuario
&GLOBAL-DEFINE Filho         apontamento
&GLOBAL-DEFINE LabelFilho    Apontamentos
&GLOBAL-DEFINE ParentFields  usuario.nome
&GLOBAL-DEFINE KeyFields     usuario.nome
&GLOBAL-DEFINE CamposFilho   apontamento.data WIDTH 10 ~
                             apontamento.hora-ini WIDTH 6 ~
                             apontamento.hora-fim WIDTH 6 ~
                             fnDescItem(apontamento.nr-pedido, apontamento.sequencia) @ cDescItem ~
                             fnCliente(apontamento.nr-pedido) @ cCliente WIDTH 16 ~
                             apontamento.nr-pedido ~
                             fnProjeto(apontamento.nr-pedido) @ cPedido ~
                             apontamento.ds-apontamento WIDTH 47 ~
                             apontamento.sequencia ~
                             apontamento.qt-apontada ~
                             apontamento.codigo-fa

/* Local Variable Definitions ---                                       */

/* Buffers */

{func\definitions.i}

/* Campos Extrangeiros */

{func\data.i}

DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.

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
&Scoped-define INTERNAL-TABLES {&Filho}

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 {&CamposFilho}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define OPEN-QUERY-br-page1 DEFINE VARIABLE dtAux-ini AS DATE    NO-UNDO. DEFINE VARIABLE dtAux-fim AS DATE    NO-UNDO. DEFINE VARIABLE iDia-ini AS INTEGER     NO-UNDO. DEFINE VARIABLE iDia-fim AS INTEGER     NO-UNDO. DEFINE VARIABLE iMes-ini AS INTEGER     NO-UNDO. DEFINE VARIABLE iMes-fim AS INTEGER     NO-UNDO. DEFINE VARIABLE iAno-ini AS INTEGER     NO-UNDO. DEFINE VARIABLE iAno-fim AS INTEGER     NO-UNDO. DEFINE VARIABLE iPed-ini AS INTEGER     NO-UNDO. DEFINE VARIABLE iPed-fim AS INTEGER     NO-UNDO. DEFINE VARIABLE iSeq-ini AS INTEGER     NO-UNDO. DEFINE VARIABLE iSeq-fim AS INTEGER     NO-UNDO.  IF INPUT FRAME {&FRAME-NAME} iAno = 0 THEN     ASSIGN iAno-ini = 1            iAno-fim = 9999. ELSE     ASSIGN iAno-ini = INPUT FRAME {&FRAME-NAME} iAno            iAno-fim = INPUT FRAME {&FRAME-NAME} iAno.  IF INPUT FRAME {&FRAME-NAME} iMes = 0 OR INPUT FRAME {&FRAME-NAME} iAno = 0 THEN     ASSIGN iMes-ini = 1            iMes-fim = 12. ELSE     ASSIGN iMes-ini = INPUT FRAME {&FRAME-NAME} iMes            iMes-fim = INPUT FRAME {&FRAME-NAME} iMes.  IF INPUT FRAME {&FRAME-NAME} iDia = 0 OR INPUT FRAME {&FRAME-NAME} iMes = 0 OR INPUT FRAME {&FRAME-NAME} iAno = 0 THEN     ASSIGN iDia-ini = 1            iDia-fim = DAY(fnUltimoDia(iMes-fim, ~
       iAno-fim)). ELSE     ASSIGN iDia-ini = INPUT FRAME {&FRAME-NAME} iDia            iDia-fim = INPUT FRAME {&FRAME-NAME} iDia.  ASSIGN dtAux-ini = DATE(iMes-ini, ~
       iDia-ini, ~
       iAno-ini)        dtAux-fim = DATE(iMes-fim, ~
       iDia-fim, ~
       iAno-fim).  IF INPUT FRAME {&FRAME-NAME} iNr-pedido = 0 THEN     ASSIGN iPed-ini = 0            iPed-fim = 9999999. ELSE     ASSIGN iPed-ini = INPUT FRAME {&FRAME-NAME} iNr-pedido            iPed-fim = INPUT FRAME {&FRAME-NAME} iNr-pedido.  IF INPUT FRAME {&FRAME-NAME} iSequencia = 0 THEN     ASSIGN iSeq-ini = 0            iSeq-fim = 9999999. ELSE     ASSIGN iSeq-ini = INPUT FRAME {&FRAME-NAME} iSequencia            iSeq-fim = INPUT FRAME {&FRAME-NAME} iSequencia.  RUN calcTot (INPUT dtAux-ini, ~
                    INPUT dtAux-fim, ~
                    INPUT iPed-ini, ~
                    INPUT iPed-fim, ~
                    INPUT iSeq-ini, ~
                    INPUT iSeq-fim).  OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK     WHERE {&Filho}.data >= dtAux-ini     AND   {&Filho}.data <= dtAux-fim     AND   {&Filho}.nr-pedido >= iPed-ini     AND   {&Filho}.nr-pedido <= iPed-fim     AND   {&Filho}.sequencia >= iSeq-ini     AND   {&Filho}.sequencia <= iSeq-fim INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-page1 {&Filho}
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 {&Filho}


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS usuario.nome 
&Scoped-define ENABLED-TABLES usuario
&Scoped-define FIRST-ENABLED-TABLE usuario
&Scoped-Define ENABLED-OBJECTS RECT-5 RECT-6 iDia iMes iAno iNr-pedido ~
iSequencia btAdd-page1 br-page1 btDel-page1 btExit btFirst btLast btNext ~
btPrev btUpdate-page1 btGoTo btZoom 
&Scoped-Define DISPLAYED-FIELDS usuario.nome 
&Scoped-define DISPLAYED-TABLES usuario
&Scoped-define FIRST-DISPLAYED-TABLE usuario
&Scoped-Define DISPLAYED-OBJECTS iDia iMes iAno iNr-pedido iSequencia tot 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnCliente C-Win 
FUNCTION fnCliente RETURNS CHARACTER
  ( iProj AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnDescItem C-Win 
FUNCTION fnDescItem RETURNS CHARACTER
  ( iPed AS INT, iSeq AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnProjeto C-Win 
FUNCTION fnProjeto RETURNS CHARACTER
  ( iProj AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
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
     SIZE 6.14 BY 1.79 TOOLTIP "V  Para".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "éltimo".

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
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE iMes AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 13
     LIST-ITEM-PAIRS "Todos",0,
                     "Janeiro",1,
                     "Fevereiro",2,
                     "Mar‡o",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 9 BY 1 NO-UNDO.

DEFINE VARIABLE iAno AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.57 BY .79 NO-UNDO.

DEFINE VARIABLE iDia AS INTEGER FORMAT "99":U INITIAL 0 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 3 BY .79 NO-UNDO.

DEFINE VARIABLE iNr-pedido AS INTEGER FORMAT ">>>>,>>9" INITIAL 0 
     LABEL "Pedido" 
     VIEW-AS FILL-IN 
     SIZE 8 BY .79.

DEFINE VARIABLE iSequencia AS INTEGER FORMAT ">>>9" INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79.

DEFINE VARIABLE tot AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total (Hrs)" 
     VIEW-AS FILL-IN 
     SIZE 10.86 BY .79 NO-UNDO.

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
         TITLE "".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     usuario.nome AT ROW 4.5 COL 13 COLON-ALIGNED WIDGET-ID 16
          LABEL "Usu rio"
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     iDia AT ROW 4.5 COL 40 COLON-ALIGNED WIDGET-ID 18
     iMes AT ROW 4.5 COL 43 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     iAno AT ROW 4.5 COL 52 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     iNr-pedido AT ROW 4.5 COL 76 COLON-ALIGNED WIDGET-ID 24
     iSequencia AT ROW 4.5 COL 84 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     btAdd-page1 AT ROW 14.79 COL 2
     br-page1 AT ROW 6 COL 2
     tot AT ROW 15.25 COL 82 COLON-ALIGNED WIDGET-ID 28
     btDel-page1 AT ROW 14.79 COL 14.29
     btExit AT ROW 1.5 COL 88
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btUpdate-page1 AT ROW 14.79 COL 8.14
     btGoTo AT ROW 1.5 COL 29
     btZoom AT ROW 1.5 COL 35.14
     RECT-5 AT ROW 4 COL 2
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 95 BY 15.71
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
         TITLE              = "Template PadrÆo de Master-Detail"
         HEIGHT             = 15.71
         WIDTH              = 95
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 95
         VIRTUAL-HEIGHT     = 16
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
   FRAME-NAME                                                           */
/* BROWSE-TAB br-page1 btAdd-page1 DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN usuario.nome IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN tot IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
DEFINE VARIABLE dtAux-ini AS DATE    NO-UNDO.
DEFINE VARIABLE dtAux-fim AS DATE    NO-UNDO.
DEFINE VARIABLE iDia-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iDia-fim AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMes-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMes-fim AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAno-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAno-fim AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPed-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPed-fim AS INTEGER     NO-UNDO.
DEFINE VARIABLE iSeq-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iSeq-fim AS INTEGER     NO-UNDO.

IF INPUT FRAME {&FRAME-NAME} iAno = 0 THEN
    ASSIGN iAno-ini = 1
           iAno-fim = 9999.
ELSE
    ASSIGN iAno-ini = INPUT FRAME {&FRAME-NAME} iAno
           iAno-fim = INPUT FRAME {&FRAME-NAME} iAno.

IF INPUT FRAME {&FRAME-NAME} iMes = 0
OR INPUT FRAME {&FRAME-NAME} iAno = 0 THEN
    ASSIGN iMes-ini = 1
           iMes-fim = 12.
ELSE
    ASSIGN iMes-ini = INPUT FRAME {&FRAME-NAME} iMes
           iMes-fim = INPUT FRAME {&FRAME-NAME} iMes.

IF INPUT FRAME {&FRAME-NAME} iDia = 0
OR INPUT FRAME {&FRAME-NAME} iMes = 0
OR INPUT FRAME {&FRAME-NAME} iAno = 0 THEN
    ASSIGN iDia-ini = 1
           iDia-fim = DAY(fnUltimoDia(iMes-fim, iAno-fim)).
ELSE
    ASSIGN iDia-ini = INPUT FRAME {&FRAME-NAME} iDia
           iDia-fim = INPUT FRAME {&FRAME-NAME} iDia.

ASSIGN dtAux-ini = DATE(iMes-ini, iDia-ini, iAno-ini)
       dtAux-fim = DATE(iMes-fim, iDia-fim, iAno-fim).

IF INPUT FRAME {&FRAME-NAME} iNr-pedido = 0 THEN
    ASSIGN iPed-ini = 0
           iPed-fim = 9999999.
ELSE
    ASSIGN iPed-ini = INPUT FRAME {&FRAME-NAME} iNr-pedido
           iPed-fim = INPUT FRAME {&FRAME-NAME} iNr-pedido.

IF INPUT FRAME {&FRAME-NAME} iSequencia = 0 THEN
    ASSIGN iSeq-ini = 0
           iSeq-fim = 9999999.
ELSE
    ASSIGN iSeq-ini = INPUT FRAME {&FRAME-NAME} iSequencia
           iSeq-fim = INPUT FRAME {&FRAME-NAME} iSequencia.

RUN calcTot (INPUT dtAux-ini,
             INPUT dtAux-fim,
             INPUT iPed-ini,
             INPUT iPed-fim,
             INPUT iSeq-ini,
             INPUT iSeq-fim).

OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK
    WHERE {&Filho}.data >= dtAux-ini
    AND   {&Filho}.data <= dtAux-fim
    AND   {&Filho}.nr-pedido >= iPed-ini
    AND   {&Filho}.nr-pedido <= iPed-fim
    AND   {&Filho}.sequencia >= iSeq-ini
    AND   {&Filho}.sequencia <= iSeq-fim INDEXED-REPOSITION.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template PadrÆo de Master-Detail */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template PadrÆo de Master-Detail */
DO:
   ASSIGN giNr-pedido = 0
          giSequencia = 0.
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-page1
&Scoped-define SELF-NAME br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON DELETE-CHARACTER OF br-page1 IN FRAME DEFAULT-FRAME
DO:
    {func\br_del.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON MOUSE-SELECT-DBLCLICK OF br-page1 IN FRAME DEFAULT-FRAME
OR RETURN OF br-page1 DO:
    {func\br_dbclick.i}
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


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    DEFINE BUFFER bf-pedido-item FOR pedido-item.

    IF AVAIL apontamento THEN DO:
        FIND FIRST pedido-item OF apontamento EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL pedido-item THEN DO:

            /* Controla qt-atendida do item do pedido */
            ASSIGN pedido-item.qt-atendida = pedido-item.qt-atendida - apontamento.qt-apontada.

            /* Controla situa‡Æo do item do pedido */
            IF pedido-item.qt-atendida = 0 THEN
                ASSIGN pedido-item.situacao = 1 /* Pendente */.
            ELSE
                IF pedido-item.qt-atendida < pedido-item.qt-pedida THEN
                    ASSIGN pedido-item.situacao = 2 /* Iniciado */.
                ELSE
                    ASSIGN pedido-item.situacao = 3 /* Atendido */.

            /* Controla a situa‡Æo do pedido */
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

    {func\bt_del_page.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExit C-Win
ON CHOOSE OF btExit IN FRAME DEFAULT-FRAME /* Button 1 */
DO:
  
    ASSIGN giNr-pedido = 0
           giSequencia = 0.

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
    {func\bt_update_page.i}  
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


&Scoped-define SELF-NAME iAno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iAno C-Win
ON LEAVE OF iAno IN FRAME DEFAULT-FRAME
DO:
    {&OPEN-QUERY-br-page1}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iDia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iDia C-Win
ON LEAVE OF iDia IN FRAME DEFAULT-FRAME /* Data */
DO:
    {&OPEN-QUERY-br-page1}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iMes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iMes C-Win
ON VALUE-CHANGED OF iMes IN FRAME DEFAULT-FRAME
DO:
    {&OPEN-QUERY-br-page1}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iNr-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iNr-pedido C-Win
ON LEAVE OF iNr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
    {&OPEN-QUERY-br-page1}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iSequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iSequencia C-Win
ON LEAVE OF iSequencia IN FRAME DEFAULT-FRAME
DO:
    {&OPEN-QUERY-br-page1}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

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
  {version.i apont}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcTot C-Win 
PROCEDURE calcTot :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER dtAux-ini AS DATE    NO-UNDO.
DEFINE INPUT PARAMETER dtAux-fim AS DATE    NO-UNDO.
DEFINE INPUT PARAMETER iPed-ini AS INTEGER     NO-UNDO.
DEFINE INPUT PARAMETER iPed-fim AS INTEGER     NO-UNDO.
DEFINE INPUT PARAMETER iSeq-ini AS INTEGER     NO-UNDO.
DEFINE INPUT PARAMETER iSeq-fim AS INTEGER     NO-UNDO.

ASSIGN tot = 0.
FOR EACH {&Filho} OF {&Table} NO-LOCK
    WHERE {&Filho}.data >= dtAux-ini
    AND   {&Filho}.data <= dtAux-fim
    AND   {&Filho}.nr-pedido >= iPed-ini
    AND   {&Filho}.nr-pedido <= iPed-fim
    AND   {&Filho}.sequencia >= iSeq-ini
    AND   {&Filho}.sequencia <= iSeq-fim:
    FIND FIRST pedido-item OF {&Filho} NO-LOCK.
    FIND FIRST item OF pedido-item NO-LOCK.
    IF item.un MATCHES("*HR*") THEN
        ASSIGN tot = tot + {&Filho}.qt-apontada.
END.
DISPLAY tot
    WITH FRAME {&FRAME-NAME}.

RETURN "OK" .

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
{func\master_detail\control_buttons.i}

IF giNr-pedido <> 0 THEN DO:

    DISABLE iDia iMes iAno iNr-pedido iSequencia
        WITH FRAME {&FRAME-NAME}.

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

IF giNr-pedido = 0 THEN DO:
    ASSIGN iDia = DAY(TODAY)
           iMes = MONTH(TODAY)
           iAno = YEAR(TODAY).
    DISPLAY iDia
            iMes
            iAno
        WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ASSIGN iNr-pedido = giNr-pedido
           iSequencia = giSequencia.
    DISPLAY iNr-pedido
            iSequencia
        WITH FRAME {&FRAME-NAME}.
END.

{func\master_detail\display.i}

IF NOT AVAIL {&Table} THEN DO:
    ASSIGN usuario.nome:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?.
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
  DISPLAY iDia iMes iAno iNr-pedido iSequencia tot 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE usuario THEN 
    DISPLAY usuario.nome 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-5 RECT-6 usuario.nome iDia iMes iAno iNr-pedido iSequencia 
         btAdd-page1 br-page1 btDel-page1 btExit btFirst btLast btNext btPrev 
         btUpdate-page1 btGoTo btZoom 
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

FIND FIRST usuario NO-LOCK
    WHERE usuario.nome = gcUsuario NO-ERROR.
IF AVAIL usuario THEN
    ASSIGN r-usuario = ROWID(usuario).

{func\initialize.i}

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

RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnCliente C-Win 
FUNCTION fnCliente RETURNS CHARACTER
  ( iProj AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST pedido NO-LOCK
        WHERE pedido.nr-pedido = iProj NO-ERROR.
    IF AVAIL pedido THEN DO:
        FIND FIRST favorecido OF pedido NO-LOCK.
        RETURN favorecido.ds-favorecido.
    END.
    ELSE
        RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnDescItem C-Win 
FUNCTION fnDescItem RETURNS CHARACTER
  ( iPed AS INT, iSeq AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST pedido-item NO-LOCK
        WHERE pedido-item.nr-pedido = iPed
        AND   pedido-item.sequencia = iSeq NO-ERROR.
    IF AVAIL pedido-item THEN
        RETURN pedido-item.ds-pedido-item.
    ELSE
        RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnProjeto C-Win 
FUNCTION fnProjeto RETURNS CHARACTER
  ( iProj AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST pedido NO-LOCK
        WHERE pedido.nr-pedido = iProj NO-ERROR.
    IF AVAIL pedido THEN
        RETURN pedido.nom-projeto.
    ELSE
        RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

