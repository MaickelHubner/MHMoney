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
&GLOBAL-DEFINE Table         pedido
&GLOBAL-DEFINE Filho         pedido-item
&GLOBAL-DEFINE LabelFilho    Itens
&GLOBAL-DEFINE ParentFields  pedido.nr-pedido pedido.cd-favorecido ~
                             pedido.val-total pedido.val-itens
&GLOBAL-DEFINE KeyFields     pedido.nr-pedido
&GLOBAL-DEFINE CamposFilho   pedido-item.sequencia ~
                             pedido-item.ds-pedido-item ~
                             pedido-item.val-total ~
                             pedido-item.val-unitario ~
                             pedido-item.qt-pedida ~
                             pedido-item.qt-liberada ~
                             pedido-item.qt-atendida ~
                             fnSituacao(pedido-item.situacao) @ cSituacao ~
                             fnCd-item(pedido-item.cd-item) @ cCd-item

/* Local Variable Definitions ---                                       */

/* Buffers */

{func\definitions.i}

/* Campos Extrangeiros */
{campos\cd-item.i}
{campos\situacao.i}

DEFINE NEW GLOBAL SHARED VARIABLE r-pedido-item AS ROWID      NO-UNDO.
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
&Scoped-define INTERNAL-TABLES {&Filho} pedido favorecido

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 {&CamposFilho}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define QUERY-STRING-br-page1 FOR EACH {&Filho} OF {&Table} NO-LOCK INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE
&Scoped-define OPEN-QUERY-br-page1 OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-page1 {&Filho}
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 {&Filho}


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME pedido.nr-pedido ~
pedido.cd-favorecido favorecido.ds-favorecido pedido.val-total ~
pedido.val-itens 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME pedido.nr-pedido ~
pedido.cd-favorecido pedido.val-total pedido.val-itens 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH pedido SHARE-LOCK, ~
      EACH favorecido OF pedido SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH pedido SHARE-LOCK, ~
      EACH favorecido OF pedido SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME pedido favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME pedido
&Scoped-define SECOND-TABLE-IN-QUERY-DEFAULT-FRAME favorecido


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS pedido.nr-pedido pedido.cd-favorecido ~
pedido.val-total pedido.val-itens 
&Scoped-define ENABLED-TABLES pedido
&Scoped-define FIRST-ENABLED-TABLE pedido
&Scoped-Define ENABLED-OBJECTS br-page1 btAtend btApont btAnexos ~
btAdd-page1 btDel-page1 btExit btFirst btLast btNext btPrev btUpdate-page1 ~
btGoTo btZoom btUsu RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS pedido.nr-pedido pedido.cd-favorecido ~
favorecido.ds-favorecido pedido.val-total pedido.val-itens 
&Scoped-define DISPLAYED-TABLES pedido favorecido
&Scoped-define FIRST-DISPLAYED-TABLE pedido
&Scoped-define SECOND-DISPLAYED-TABLE favorecido


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

DEFINE BUTTON btAnexos 
     IMAGE-UP FILE "image/im-save.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-save.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Anexos" 
     SIZE 6.14 BY 1.79 TOOLTIP "Arquivos Anexos".

DEFINE BUTTON btApont 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Apont" 
     SIZE 6.14 BY 1.79 TOOLTIP "Apontamentos".

DEFINE BUTTON btAtend 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Atend" 
     SIZE 6.14 BY 1.79 TOOLTIP "Atender totalmente o Item do Pedido".

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
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btUsu 
     IMAGE-UP FILE "image/im-login.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-login.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Atend" 
     SIZE 6.14 BY 1.79 TOOLTIP "Usu†rios Relacionados ao Item do Pedido".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

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
      pedido, 
      favorecido SCROLLING.
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
     br-page1 AT ROW 6 COL 2
     btAtend AT ROW 14.75 COL 70.57 WIDGET-ID 18
     btApont AT ROW 14.79 COL 82.86 WIDGET-ID 16
     btAnexos AT ROW 14.79 COL 89 WIDGET-ID 14
     btAdd-page1 AT ROW 14.79 COL 2
     btDel-page1 AT ROW 14.79 COL 14.29
     btExit AT ROW 1.5 COL 88
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btUpdate-page1 AT ROW 14.79 COL 8.14
     btGoTo AT ROW 1.5 COL 29
     btZoom AT ROW 1.5 COL 35.14
     pedido.nr-pedido AT ROW 4.5 COL 8 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 6.86 BY .79
     pedido.cd-favorecido AT ROW 4.5 COL 21 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     favorecido.ds-favorecido AT ROW 4.5 COL 26 COLON-ALIGNED NO-LABEL WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 27 BY .79
     pedido.val-total AT ROW 4.5 COL 82 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
          BGCOLOR 22 FGCOLOR 15 
     btUsu AT ROW 14.79 COL 76.72 WIDGET-ID 20
     pedido.val-itens AT ROW 4.5 COL 63 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
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
         TITLE              = "Template Padr∆o de Master-Detail"
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
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br-page1 1 DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN favorecido.ds-favorecido IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK INDEXED-REPOSITION.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.pedido,money.favorecido OF money.pedido"
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON ROW-DISPLAY OF br-page1 IN FRAME DEFAULT-FRAME
DO:
  
    IF pedido-item.situacao = 3 /* Atendido */ THEN DO:
        ASSIGN pedido-item.sequencia:FGCOLOR IN BROWSE br-page1 = 9
               cCd-item:FGCOLOR IN BROWSE br-page1 = 9
               cSituacao:FGCOLOR IN BROWSE br-page1 = 9
               pedido-item.val-unitario:FGCOLOR IN BROWSE br-page1 = 9
               pedido-item.qt-pedida:FGCOLOR IN BROWSE br-page1 = 9
               pedido-item.qt-atendida:FGCOLOR IN BROWSE br-page1 = 9
               pedido-item.val-total:FGCOLOR IN BROWSE br-page1 = 9
               pedido-item.ds-pedido-item:FGCOLOR IN BROWSE br-page1 = 9
               pedido-item.qt-liberada:FGCOLOR IN BROWSE br-page1 = 9.
    END.
    ELSE DO:
        IF pedido-item.situacao = 9 /* Cancelado */ THEN DO:
            ASSIGN pedido-item.sequencia:FGCOLOR IN BROWSE br-page1 = 8
                   cCd-item:FGCOLOR IN BROWSE br-page1 = 8
                   cSituacao:FGCOLOR IN BROWSE br-page1 = 8
                   pedido-item.val-unitario:FGCOLOR IN BROWSE br-page1 = 8
                   pedido-item.qt-pedida:FGCOLOR IN BROWSE br-page1 = 8
                   pedido-item.qt-atendida:FGCOLOR IN BROWSE br-page1 = 8
                   pedido-item.val-total:FGCOLOR IN BROWSE br-page1 = 8
                   pedido-item.ds-pedido-item:FGCOLOR IN BROWSE br-page1 = 8
               pedido-item.qt-liberada:FGCOLOR IN BROWSE br-page1 = 8.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    {func\bt_add_page.i}
    
    ASSIGN pedido.val-total:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(pedido.val-total)
           pedido.val-itens:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(pedido.val-itens).

    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAnexos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAnexos C-Win
ON CHOOSE OF btAnexos IN FRAME DEFAULT-FRAME /* Anexos */
DO:

    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-pedido-item = ROWID(pedido-item).
        {func\run.i &Programa = "anexo.w"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btApont C-Win
ON CHOOSE OF btApont IN FRAME DEFAULT-FRAME /* Apont */
DO:

    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN giNr-pedido = pedido-item.nr-pedido
               giSequencia = pedido-item.sequencia.
        {func\run.i &Programa = "apont.w"}
        RUN displayFields.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAtend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAtend C-Win
ON CHOOSE OF btAtend IN FRAME DEFAULT-FRAME /* Atend */
DO:

    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        FIND CURRENT pedido-item EXCLUSIVE-LOCK.
        ASSIGN pedido-item.situacao = 3 /* Atendido */
               pedido-item.qt-atendida = pedido-item.qt-pedida.
        DEFINE BUFFER bf-pedido-item FOR pedido-item.

        /* Controla a situaá∆o do pedido */
        FIND CURRENT pedido EXCLUSIVE-LOCK.
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

        RUN displayFields.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    {func\bt_del_page.i}

    DEFINE BUFFER bf-pedido-item FOR pedido-item.

    /* Controla a situaá∆o do pedido */
    FIND CURRENT pedido EXCLUSIVE-LOCK.
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

    /* Valor Total do Pedido */
    ASSIGN pedido.val-itens = 0
           pedido.val-impostos = 0
           pedido.val-total = 0.
    FOR EACH bf-pedido-item OF pedido
        WHERE bf-pedido-item.situacao <> 9 /* Cancelado */:
        ASSIGN pedido.val-itens = pedido.val-itens + bf-pedido-item.val-total.
    END.
    ASSIGN pedido.val-impostos = (pedido.val-itens * pedido.pc-impto) / 100
           pedido.val-total = pedido.val-itens - pedido.val-desconto + pedido.val-impostos.

    ASSIGN pedido.val-total:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(pedido.val-total)
           pedido.val-itens:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(pedido.val-itens).    

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
    {func\bt_update_page.i} 
    ASSIGN pedido.val-total:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(pedido.val-total)
           pedido.val-itens:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(pedido.val-itens).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUsu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUsu C-Win
ON CHOOSE OF btUsu IN FRAME DEFAULT-FRAME /* Atend */
DO:

    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        {func\run.i &Programa = "usuarped.w (INPUT ROWID(pedido-item))"}
        RUN displayFields.
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
  {version.i ped-item}
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

IF NOT AVAIL {&Table} THEN DO:

    ASSIGN pedido.nr-pedido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           pedido.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?.

END.
ELSE DO:

    FIND FIRST favorecido OF pedido NO-LOCK NO-ERROR.
    IF AVAIL favorecido THEN
        DISPLAY favorecido.ds-favorecido
            WITH FRAME {&FRAME-NAME}.

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
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.ds-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE pedido THEN 
    DISPLAY pedido.nr-pedido pedido.cd-favorecido pedido.val-total 
          pedido.val-itens 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-page1 btAtend btApont btAnexos btAdd-page1 btDel-page1 btExit 
         btFirst btLast btNext btPrev btUpdate-page1 btGoTo btZoom 
         pedido.nr-pedido pedido.cd-favorecido pedido.val-total btUsu 
         pedido.val-itens RECT-5 RECT-6 
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

IF CAN-FIND(FIRST pedido-item-anexo OF pedido-item) THEN DO:
    {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                   &Ajuda     = "Esse item do pedido possui anexos."}
END.

IF CAN-FIND(FIRST apontamento OF pedido-item) THEN DO:
    {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                   &Ajuda     = "Esse item do pedido possui apontamentos."}
END.

RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

