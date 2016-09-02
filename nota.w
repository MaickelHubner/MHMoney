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
&GLOBAL-DEFINE Table        nota-fiscal
&GLOBAL-DEFINE KeyFields    nota-fiscal.nr-controle
&GLOBAL-DEFINE FrameFields  nota-fiscal.tipo nota-fiscal.cd-favorecido ~
                            nota-fiscal.nr-nota nota-fiscal.serie ~
                            nota-fiscal.dt-emissao nota-fiscal.cod-verificacao ~
                            nota-fiscal.val-itens nota-fiscal.val-desconto ~
                            nota-fiscal.val-total nota-fiscal.val-impostos ~
                            nota-fiscal.val-liquido nota-fiscal.cod-categoria ~
                            nota-fiscal.cd-sub des-cli

/* Local Variable Definitions ---                                       */

/* Buffers */

{func\definitions.i}
{campos\situacao.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brImp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES nota-fiscal-imp imposto mov-conta

/* Definitions for BROWSE brImp                                         */
&Scoped-define FIELDS-IN-QUERY-brImp imposto.ds-imposto ~
fnSituacaoImp(nota-fiscal-imp.situacao) @ cSituacao ~
nota-fiscal-imp.val-imposto 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brImp 
&Scoped-define QUERY-STRING-brImp FOR EACH nota-fiscal-imp ~
      WHERE nota-fiscal-imp.nr-controle = nota-fiscal.nr-controle NO-LOCK, ~
      EACH imposto OF nota-fiscal-imp NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brImp OPEN QUERY brImp FOR EACH nota-fiscal-imp ~
      WHERE nota-fiscal-imp.nr-controle = nota-fiscal.nr-controle NO-LOCK, ~
      EACH imposto OF nota-fiscal-imp NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brImp nota-fiscal-imp imposto
&Scoped-define FIRST-TABLE-IN-QUERY-brImp nota-fiscal-imp
&Scoped-define SECOND-TABLE-IN-QUERY-brImp imposto


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brImp}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH mov-conta SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH mov-conta SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME mov-conta


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS nota-fiscal.nr-controle nota-fiscal.tipo ~
nota-fiscal.cd-favorecido nota-fiscal.nr-nota nota-fiscal.serie ~
nota-fiscal.dt-emissao nota-fiscal.cod-verificacao ~
nota-fiscal.cod-categoria nota-fiscal.cd-sub nota-fiscal.val-itens ~
nota-fiscal.val-desconto nota-fiscal.val-total nota-fiscal.val-impostos ~
nota-fiscal.val-liquido 
&Scoped-define ENABLED-TABLES nota-fiscal
&Scoped-define FIRST-ENABLED-TABLE nota-fiscal
&Scoped-Define ENABLED-OBJECTS RECT-4 btPag RECT-5 RECT-8 des-cli btItens ~
btPed btGoTo btFirst btLast btNext btPrev btAdd btDel btExit btUpdate ~
btZoom 
&Scoped-Define DISPLAYED-FIELDS nota-fiscal.nr-controle nota-fiscal.tipo ~
nota-fiscal.cd-favorecido nota-fiscal.nr-nota nota-fiscal.serie ~
nota-fiscal.dt-emissao nota-fiscal.cod-verificacao ~
nota-fiscal.cod-categoria nota-fiscal.cd-sub nota-fiscal.val-itens ~
nota-fiscal.val-desconto nota-fiscal.val-total nota-fiscal.val-impostos ~
nota-fiscal.val-liquido 
&Scoped-define DISPLAYED-TABLES nota-fiscal
&Scoped-define FIRST-DISPLAYED-TABLE nota-fiscal
&Scoped-Define DISPLAYED-OBJECTS des-cli cat subcat 

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

DEFINE BUTTON btItens 
     IMAGE-UP FILE "image/im-sub.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-sub.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Itens da Nota Fiscal".

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

DEFINE BUTTON btPag 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Parcelas da Nota Fiscal".

DEFINE BUTTON btPed 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pedidos da Nota Fiscal".

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

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE cat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .79 NO-UNDO.

DEFINE VARIABLE des-cli AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .79 NO-UNDO.

DEFINE VARIABLE subcat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 6.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 25 BY 6.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brImp FOR 
      nota-fiscal-imp, 
      imposto SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      mov-conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brImp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brImp C-Win _STRUCTURED
  QUERY brImp NO-LOCK DISPLAY
      imposto.ds-imposto FORMAT "X(40)":U
      fnSituacaoImp(nota-fiscal-imp.situacao) @ cSituacao WIDTH 18
      nota-fiscal-imp.val-imposto FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS MULTIPLE SIZE 59 BY 6.5
         FONT 7
         TITLE "Impostos".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btPag AT ROW 1.5 COL 67 WIDGET-ID 34
     nota-fiscal.nr-controle AT ROW 4.5 COL 22 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     nota-fiscal.tipo AT ROW 4.5 COL 56 COLON-ALIGNED WIDGET-ID 32
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Nota Fiscal",1,
                     "Recibo",2
          DROP-DOWN-LIST
          SIZE 16 BY 1
     nota-fiscal.cd-favorecido AT ROW 5.5 COL 22 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     des-cli AT ROW 5.5 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     nota-fiscal.nr-nota AT ROW 6.5 COL 22 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     nota-fiscal.serie AT ROW 6.5 COL 41 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     nota-fiscal.dt-emissao AT ROW 6.5 COL 62 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     nota-fiscal.cod-verificacao AT ROW 7.5 COL 22 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 50 BY .79
     nota-fiscal.cod-categoria AT ROW 8.5 COL 22 COLON-ALIGNED WIDGET-ID 46
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     cat AT ROW 8.5 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 42 NO-TAB-STOP 
     nota-fiscal.cd-sub AT ROW 9.5 COL 22 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     subcat AT ROW 9.5 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 48 NO-TAB-STOP 
     brImp AT ROW 11 COL 2 WIDGET-ID 100
     nota-fiscal.val-itens AT ROW 11.75 COL 74 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     nota-fiscal.val-desconto AT ROW 12.75 COL 74 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     btItens AT ROW 1.5 COL 61
     nota-fiscal.val-total AT ROW 13.75 COL 74 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     btPed AT ROW 1.5 COL 73 WIDGET-ID 36
     nota-fiscal.val-impostos AT ROW 14.75 COL 74 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     nota-fiscal.val-liquido AT ROW 15.75 COL 74 COLON-ALIGNED WIDGET-ID 40
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     btGoTo AT ROW 1.5 COL 47.43
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 29
     btCancel AT ROW 17.75 COL 81
     btDel AT ROW 1.5 COL 41.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 17.75 COL 75
     btUpdate AT ROW 1.5 COL 35.14
     btZoom AT ROW 1.5 COL 53.57
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-8 AT ROW 11 COL 62 WIDGET-ID 30
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 18.54
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
         HEIGHT             = 18.54
         WIDTH              = 86.72
         MAX-HEIGHT         = 21.08
         MAX-WIDTH          = 86.72
         VIRTUAL-HEIGHT     = 21.08
         VIRTUAL-WIDTH      = 86.72
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
/* BROWSE-TAB brImp subcat DEFAULT-FRAME */
/* SETTINGS FOR BROWSE brImp IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN cat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       cat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       des-cli:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN subcat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       subcat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brImp
/* Query rebuild information for BROWSE brImp
     _TblList          = "money.nota-fiscal-imp,money.imposto OF money.nota-fiscal-imp"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "nota-fiscal-imp.nr-controle = nota-fiscal.nr-controle"
     _FldNameList[1]   = money.imposto.ds-imposto
     _FldNameList[2]   > "_<CALC>"
"fnSituacaoImp(nota-fiscal-imp.situacao) @ cSituacao" ? ? ? ? ? ? ? ? ? no ? no no "18" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.nota-fiscal-imp.val-imposto
     _Query            is OPENED
*/  /* BROWSE brImp */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.mov-conta"
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


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_add.i "nr-controle"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cancel.i}
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


&Scoped-define SELF-NAME btItens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btItens C-Win
ON CHOOSE OF btItens IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "item-nota.w"}
    RUN displayFields.
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


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_ok.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPag C-Win
ON CHOOSE OF btPag IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "parc-nota.w"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPed C-Win
ON CHOOSE OF btPed IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "ped-nota.w"}
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


&Scoped-define SELF-NAME btUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate C-Win
ON CHOOSE OF btUpdate IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_update.i}  
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


&Scoped-define SELF-NAME nota-fiscal.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cd-favorecido C-Win
ON ENTRY OF nota-fiscal.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cd-favorecido C-Win
ON LEAVE OF nota-fiscal.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-cli"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF nota-fiscal.cd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="nota-fiscal.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="des-cli"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cd-sub C-Win
ON ENTRY OF nota-fiscal.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cd-sub C-Win
ON LEAVE OF nota-fiscal.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} nota-fiscal.cod-categoria"
                  &CampoProc = "ds-sub"
                  &Tela="subcat"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cd-sub C-Win
ON MOUSE-SELECT-DBLCLICK OF nota-fiscal.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
OR F5 OF {&Table}.cd-sub DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="nota-fiscal.cd-sub"
                 &Campo2="ds-sub"
                 &Tela2="subcat"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} nota-fiscal.cod-categoria"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cod-categoria C-Win
ON ENTRY OF nota-fiscal.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cod-categoria C-Win
ON LEAVE OF nota-fiscal.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoProc = "ds-categoria"
                  &Tela="cat"}    
                  
    APPLY "LEAVE" TO nota-fiscal.cd-sub IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cod-categoria C-Win
ON MOUSE-SELECT-DBLCLICK OF nota-fiscal.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
OR F5 OF {&Table}.cod-categoria DO:
    {func\zoom.i &Tabela="categoria"
                 &Campo1="cod-categoria"
                 &Tela1="nota-fiscal.cod-categoria"
                 &Campo2="ds-categoria"
                 &Tela2="cat"
                 &CampoFiltro1="id-tipo"
                 &ValorFiltro1="1"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.cod-verificacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cod-verificacao C-Win
ON ENTRY OF nota-fiscal.cod-verificacao IN FRAME DEFAULT-FRAME /* C¢digo Verificaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.cod-verificacao C-Win
ON LEAVE OF nota-fiscal.cod-verificacao IN FRAME DEFAULT-FRAME /* C¢digo Verificaá∆o */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.dt-emissao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.dt-emissao C-Win
ON ENTRY OF nota-fiscal.dt-emissao IN FRAME DEFAULT-FRAME /* Data Emiss∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.dt-emissao C-Win
ON LEAVE OF nota-fiscal.dt-emissao IN FRAME DEFAULT-FRAME /* Data Emiss∆o */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.nr-controle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.nr-controle C-Win
ON ENTRY OF nota-fiscal.nr-controle IN FRAME DEFAULT-FRAME /* Controle */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.nr-controle C-Win
ON LEAVE OF nota-fiscal.nr-controle IN FRAME DEFAULT-FRAME /* Controle */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.nr-nota
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.nr-nota C-Win
ON ENTRY OF nota-fiscal.nr-nota IN FRAME DEFAULT-FRAME /* Nr Nota Fiscal */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.nr-nota C-Win
ON LEAVE OF nota-fiscal.nr-nota IN FRAME DEFAULT-FRAME /* Nr Nota Fiscal */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.serie
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.serie C-Win
ON ENTRY OF nota-fiscal.serie IN FRAME DEFAULT-FRAME /* SÇrie */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.serie C-Win
ON LEAVE OF nota-fiscal.serie IN FRAME DEFAULT-FRAME /* SÇrie */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.tipo C-Win
ON ENTRY OF nota-fiscal.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.tipo C-Win
ON LEAVE OF nota-fiscal.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.tipo C-Win
ON VALUE-CHANGED OF nota-fiscal.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} nota-fiscal.tipo = 1 /* Nota Fiscal */ THEN DO:
        ENABLE nota-fiscal.nr-nota
               nota-fiscal.serie
               nota-fiscal.cod-verificacao
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE nota-fiscal.nr-nota
                nota-fiscal.serie
                nota-fiscal.cod-verificacao
            WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.val-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.val-desconto C-Win
ON ENTRY OF nota-fiscal.val-desconto IN FRAME DEFAULT-FRAME /* Valor Desconto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.val-desconto C-Win
ON LEAVE OF nota-fiscal.val-desconto IN FRAME DEFAULT-FRAME /* Valor Desconto */
DO:
  
    {func\set_leave.i}

    DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

    ASSIGN deAux = INPUT FRAME {&FRAME-NAME} nota-fiscal.val-itens
           deAux = deAux - INPUT FRAME {&FRAME-NAME} nota-fiscal.val-desconto
           nota-fiscal.val-total:SCREEN-VALUE = STRING(deAux).
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.val-itens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.val-itens C-Win
ON ENTRY OF nota-fiscal.val-itens IN FRAME DEFAULT-FRAME /* Valor Itens */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.val-itens C-Win
ON LEAVE OF nota-fiscal.val-itens IN FRAME DEFAULT-FRAME /* Valor Itens */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nota-fiscal.val-total
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.val-total C-Win
ON ENTRY OF nota-fiscal.val-total IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nota-fiscal.val-total C-Win
ON LEAVE OF nota-fiscal.val-total IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brImp
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-cli
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = nota-fiscal.cd-favorecido}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = cat
                          &FOREACH = "categoria BY categoria.ds-categoria"
                          &CAMPO = categoria.ds-categoria
                          &ObjPai = nota-fiscal.cod-categoria}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = subcat
                          &FOREACH = "sub-cat WHERE (sub-cat.cod-categoria = INPUT FRAME {&Frame-name} nota-fiscal.cod-categoria) BY sub-cat.ds-sub"
                          &CAMPO = sub-cat.ds-sub
                          &ObjPai = nota-fiscal.cd-sub}
                          
{func\calendar.i nota-fiscal.dt-emissao}
{func\calc.i nota-fiscal.val-itens}
{func\calc.i nota-fiscal.val-desconto}
{func\calc.i nota-fiscal.val-total}

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
  {version.i nota}
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
{func\control_buttons.i}

IF lHabilita THEN DO:
    DISABLE btItens
            btpag
            btPed WITH FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO nota-fiscal.tipo.
END.
ELSE DO:
    ENABLE btItens
           btpag
           btPed WITH FRAME {&FRAME-NAME}.
END.

DISABLE nota-fiscal.val-itens
        nota-fiscal.val-total
        nota-fiscal.val-impostos
        nota-fiscal.val-liquido
    WITH FRAME {&FRAME-NAME}.

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
    ASSIGN nota-fiscal.dt-emissao = TODAY
           nota-fiscal.cod-categoria = param-mn.categoria-nf
           nota-fiscal.cd-sub = param-mn.sub-nf.
END.

{func\cadastro\display.i}

APPLY "LEAVE" TO nota-fiscal.cd-favorecido.
APPLY "LEAVE" TO nota-fiscal.cod-categoria.
APPLY "LEAVE" TO nota-fiscal.cd-sub.

{&OPEN-QUERY-brImp}

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
  DISPLAY des-cli cat subcat 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE nota-fiscal THEN 
    DISPLAY nota-fiscal.nr-controle nota-fiscal.tipo nota-fiscal.cd-favorecido 
          nota-fiscal.nr-nota nota-fiscal.serie nota-fiscal.dt-emissao 
          nota-fiscal.cod-verificacao nota-fiscal.cod-categoria 
          nota-fiscal.cd-sub nota-fiscal.val-itens nota-fiscal.val-desconto 
          nota-fiscal.val-total nota-fiscal.val-impostos nota-fiscal.val-liquido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-4 btPag RECT-5 RECT-8 nota-fiscal.nr-controle nota-fiscal.tipo 
         nota-fiscal.cd-favorecido des-cli nota-fiscal.nr-nota 
         nota-fiscal.serie nota-fiscal.dt-emissao nota-fiscal.cod-verificacao 
         nota-fiscal.cod-categoria nota-fiscal.cd-sub nota-fiscal.val-itens 
         nota-fiscal.val-desconto btItens nota-fiscal.val-total btPed 
         nota-fiscal.val-impostos nota-fiscal.val-liquido btGoTo btFirst btLast 
         btNext btPrev btAdd btDel btExit btUpdate btZoom 
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
{func\initialize.i YES}

{func\cursor.i nota-fiscal.cd-favorecido}
{func\cursor.i nota-fiscal.cod-categoria}
{func\cursor.i nota-fiscal.cd-sub}

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
        ASSIGN nota-fiscal.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.
IF cObject = "cat" THEN DO:
    FIND FIRST categoria NO-LOCK
        WHERE categoria.ds-categoria = INPUT FRAME {&FRAME-NAME} cat NO-ERROR.
    IF AVAIL categoria THEN DO:
        ASSIGN nota-fiscal.cod-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(categoria.cod-categoria).
    END.
END.
IF cObject = "subcat" THEN DO:
    FIND FIRST sub-cat NO-LOCK
        WHERE sub-cat.ds-sub = INPUT FRAME {&FRAME-NAME} subcat NO-ERROR.
    IF AVAIL sub-cat THEN DO:
        ASSIGN nota-fiscal.cd-sub:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(sub-cat.cd-sub).
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

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-nota-fiscal NO-LOCK
        WHERE bf-nota-fiscal.nr-controle = INPUT FRAME {&FRAME-NAME} nota-fiscal.nr-controle
        AND   ROWID(bf-nota-fiscal) <> ROWID(nota-fiscal) NO-ERROR.
    IF AVAIL bf-nota-fiscal THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "UPDATE" THEN DO:
END.

IF cAction = "ADD" OR cAction = "UPDATE" THEN DO:

    IF INPUT FRAME {&FRAME-NAME} nota-fiscal.cd-favorecido <> ? THEN DO:
        FIND FIRST favorecido NO-LOCK
            WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} nota-fiscal.cd-favorecido NO-ERROR.
        IF NOT AVAIL favorecido THEN DO:
            {func\valida.i &Mensagem  = "Cliente inv†lido!"
                           &Ajuda     = "Vocà deve informar o cliente da Nota Fiscal."
                           &Campo     = nota-fiscal.cd-favorecido}
        END.
        ELSE DO:
            IF favorecido.tipo = 2 /* Fornecedor */ THEN DO:
                {func\valida.i &Mensagem  = "Cliente inv†lido!"
                               &Ajuda     = "O cliente informado Ç um fornecedor. No cadastro vocà deve alterar o tipo para Cliente ou Ambos."
                               &Campo     = nota-fiscal.cd-favorecido}
            END.
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} nota-fiscal.tipo = 1 /* Nota Fiscal */ THEN DO:

        IF INPUT FRAME {&FRAME-NAME} nota-fiscal.nr-nota = "" THEN DO:
            {func\valida.i &Mensagem  = "N£mero inv†lido!"
                           &Ajuda     = "Vocà deve informar o n£mero da Nota Fiscal."
                           &Campo     = nota-fiscal.nr-nota}
        END.
        IF INPUT FRAME {&FRAME-NAME} nota-fiscal.serie = "" THEN DO:
            {func\valida.i &Mensagem  = "SÇrie inv†lida!"
                           &Ajuda     = "Vocà deve informar a sÇrie da Nota Fiscal."
                           &Campo     = nota-fiscal.serie}
        END.

    END.

    IF INPUT FRAME {&FRAME-NAME} nota-fiscal.dt-emissao = ? THEN DO:
        {func\valida.i &Mensagem  = "Data inv†lida!"
                       &Ajuda     = "Vocà deve informar a data de emiss∆o."
                       &Campo     = nota-fiscal.dt-emissao}
    END.

    IF INPUT FRAME {&FRAME-NAME} nota-fiscal.cod-categoria = 0 THEN DO:
        {func\valida.i &Mensagem  = "Categoria inv†lida!"
                       &Ajuda     = "Vocà deve informar a Categoria de Receita da Nota Fiscal."
                       &Campo     = nota-fiscal.cod-categoria}
    END.

    IF INPUT FRAME {&FRAME-NAME} nota-fiscal.cd-sub = 0 THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria inv†lida!"
                       &Ajuda     = "Vocà deve informar a Sub-Categoria de Receita da Nota Fiscal."
                       &Campo     = nota-fiscal.cd-sub}
    END.

END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST parc-nota-fiscal OF nota-fiscal) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "A Nota Fiscal possui parcelas."}
    END.
    IF CAN-FIND(FIRST pedido OF nota-fiscal) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "A Nota Fiscal est† relacionada a Pedidos."}
    END.
    IF CAN-FIND(FIRST nota-fiscal-item OF nota-fiscal) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "A Nota Fiscal possui itens."}
    END.
    IF CAN-FIND(FIRST mov-conta OF nota-fiscal) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "A Nota Fiscal j† possui movimentaá∆o financeira associada."}
    END.

    FOR EACH nota-fiscal-imp OF nota-fiscal EXCLUSIVE-LOCK:
        DELETE nota-fiscal-imp.
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

