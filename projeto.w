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

DEFINE TEMP-TABLE tt-per LIKE proj-periodo
    FIELD vl-prev AS DECIMAL COLUMN-LABEL "Vl. Previsto" FORMAT "->>>>,>>9.99"
    FIELD pc-prev AS DECIMAL COLUMN-LABEL "% do Total" FORMAT "->>9.9999"
    FIELD vl-real AS DECIMAL COLUMN-LABEL "Vl. Realizado" FORMAT "->>>>,>>9.99"
    FIELD pc-real AS DECIMAL COLUMN-LABEL "% do Previsto" FORMAT "->>9.9999"
    FIELD movtos  AS CHARACTER
    FIELD r-rowid AS ROWID.

DEFINE BUFFER bfPer FOR tt-per.
DEFINE BUFFER bfVal FOR proj-periodo-nivel.
DEFINE BUFFER bfNivel FOR nivel-projeto.
DEFINE BUFFER bfNivel2 FOR nivel-projeto.

{cotacao.i}

/* Parameters Definitions ---                                           */

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        projeto
&GLOBAL-DEFINE KeyFields    projeto.cd-projeto
&GLOBAL-DEFINE FrameFields  projeto.ds-projeto
&GLOBAL-DEFINE Frame1Fields nivel-projeto.cd-nivel nivel-projeto.ds-nivel ~
                            nivel-projeto.nivel-pai nivel-projeto.val-estimado ~
                            nivel-projeto.val-real nivel-projeto.val-planejado ~
                            nivel-projeto.passivo

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE iNivel AS INTEGER    NO-UNDO.
DEFINE VARIABLE iNivelCalc AS INTEGER    NO-UNDO INITIAL 99999.
def var chTreeView       as com-handle no-undo.
def var h-Node           as char   no-undo.
DEFINE VARIABLE deValPlan AS DECIMAL    NO-UNDO.

/* Buffers */

{func\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brPeriodo

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-per nivel-projeto

/* Definitions for BROWSE brPeriodo                                     */
&Scoped-define FIELDS-IN-QUERY-brPeriodo tt-per.ds-periodo tt-per.vl-prev tt-per.vl-real tt-per.pc-real tt-per.pc-prev   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPeriodo   
&Scoped-define SELF-NAME brPeriodo
&Scoped-define OPEN-QUERY-brPeriodo SESSION:SET-WAIT-STATE("GENERAL":U). RUN criaAcomp. OPEN QUERY {&SELF-NAME} FOR EACH tt-per NO-LOCK. SESSION:SET-WAIT-STATE("":U).
&Scoped-define TABLES-IN-QUERY-brPeriodo tt-per
&Scoped-define FIRST-TABLE-IN-QUERY-brPeriodo tt-per


/* Definitions for FRAME fPage2                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage2 ~
    ~{&OPEN-QUERY-brPeriodo}
&Scoped-define QUERY-STRING-fPage2 FOR EACH nivel-projeto SHARE-LOCK
&Scoped-define OPEN-QUERY-fPage2 OPEN QUERY fPage2 FOR EACH nivel-projeto SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-fPage2 nivel-projeto
&Scoped-define FIRST-TABLE-IN-QUERY-fPage2 nivel-projeto


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS projeto.cd-projeto projeto.ds-projeto 
&Scoped-define ENABLED-TABLES projeto
&Scoped-define FIRST-ENABLED-TABLE projeto
&Scoped-Define ENABLED-OBJECTS RECT-4 RECT-5 btPer btDesemb btGoTo ~
btPeriodos btFirst btLast btNext btPrev btAdd btDel btExit btUpdate btZoom 
&Scoped-Define DISPLAYED-FIELDS projeto.cd-projeto projeto.ds-projeto 
&Scoped-define DISPLAYED-TABLES projeto
&Scoped-define FIRST-DISPLAYED-TABLE projeto


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnAtualizaValores C-Win 
FUNCTION fnAtualizaValores RETURNS CHARACTER
  ( iProj AS INTEGER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnBuscaMovNivel C-Win 
FUNCTION fnBuscaMovNivel RETURNS CHARACTER
  ( iNivelPai AS INTEGER, cLista AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnCriaNivel C-Win 
FUNCTION fnCriaNivel RETURNS CHARACTER
  ( iProj AS INTEGER, iPai AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnEliminaNivel C-Win 
FUNCTION fnEliminaNivel RETURNS CHARACTER
  ( iProj AS INTEGER, iPai AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnValFilho C-Win 
FUNCTION fnValFilho RETURNS DECIMAL
  ( iProj AS INT, iPer AS INT, iNiv AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnValFilhoReal C-Win 
FUNCTION fnValFilhoReal RETURNS DECIMAL
  ( iProj AS INT, iNiv AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnValor C-Win 
FUNCTION fnValor RETURNS DECIMAL
  ( iProj AS INT, iNiv AS INT, iPer AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame-2 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-2 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btAddNivel 
     IMAGE-UP FILE "image/im-sub.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-sub.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL ">>" 
     SIZE 6 BY 1.79 TOOLTIP "Adicionar Sub-N°vel".

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

DEFINE BUTTON btDelNivel 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "X" 
     SIZE 6 BY 1.79 TOOLTIP "Eliminar Sub-N°vel".

DEFINE BUTTON btDesemb 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Des" 
     SIZE 6 BY 1.79 TOOLTIP "Previs∆o de Desembolso".

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

DEFINE BUTTON btGeral  NO-CONVERT-3D-COLORS
     LABEL "Geral" 
     SIZE 10 BY 1.

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

DEFINE BUTTON btPer  NO-CONVERT-3D-COLORS
     LABEL "Per°odo" 
     SIZE 10 BY 1.

DEFINE BUTTON btPeriodos 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Per" 
     SIZE 6 BY 1.79 TOOLTIP "Per°odos do Projeto".

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

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 1.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 2.25.

DEFINE BUTTON btAtual 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Atualizar" 
     SIZE 6 BY 1.79 TOOLTIP "Atualizar valores".

DEFINE BUTTON btMov 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentos do N°vel do Projeto".

DEFINE VARIABLE diferenca AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Diferenáa" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .79
     BGCOLOR 2 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ds-pai AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY .79 NO-UNDO.

DEFINE VARIABLE sobra AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Sobra" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .79
     BGCOLOR 9 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 49 BY 5.25.

DEFINE BUTTON btValor 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Valor" 
     SIZE 6 BY 1.79 TOOLTIP "Valor no per°odo".

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brPeriodo FOR 
      tt-per SCROLLING.

DEFINE QUERY fPage2 FOR 
      nivel-projeto SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brPeriodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPeriodo C-Win _FREEFORM
  QUERY brPeriodo NO-LOCK DISPLAY
      tt-per.ds-periodo
      tt-per.vl-prev
      tt-per.vl-real
      tt-per.pc-real
      tt-per.pc-prev
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH SIZE 48 BY 10.25
         FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAddNivel AT ROW 18 COL 2
     projeto.cd-projeto AT ROW 4.5 COL 26 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     projeto.ds-projeto AT ROW 4.5 COL 30.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 45 BY .79
     btGeral AT ROW 6 COL 34
     btPer AT ROW 6 COL 44
     btDelNivel AT ROW 18 COL 8.14
     btDesemb AT ROW 1.5 COL 71.14
     btGoTo AT ROW 1.5 COL 48.43
     btPeriodos AT ROW 1.5 COL 65
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 18 COL 83
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 82
     btOK AT ROW 18 COL 76.86
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 89 BY 18.96
         FONT 7.

DEFINE FRAME fPage2
     brPeriodo AT ROW 1.25 COL 2
     btValor AT ROW 1.25 COL 50.57
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 34 ROW 7.25
         SIZE 56 BY 10.75
         FONT 1.

DEFINE FRAME fPage1
     btMov AT ROW 9.75 COL 3
     nivel-projeto.cd-nivel AT ROW 1.5 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     nivel-projeto.ds-nivel AT ROW 1.5 COL 16.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 34 BY .79
     nivel-projeto.nivel-pai AT ROW 2.5 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-pai AT ROW 2.5 COL 16.29 COLON-ALIGNED NO-LABEL
     nivel-projeto.passivo AT ROW 3.5 COL 14
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .83
     nivel-projeto.val-estimado AT ROW 4.75 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     nivel-projeto.val-planejado AT ROW 5.75 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     diferenca AT ROW 6.75 COL 28 COLON-ALIGNED
     nivel-projeto.val-real AT ROW 7.75 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     sobra AT ROW 8.75 COL 28 COLON-ALIGNED
     btAtual AT ROW 6.25 COL 44
     RECT-2 AT ROW 4.5 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 34 ROW 7.25
         SIZE 56 BY 10.75
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
         TITLE              = "Template Padr∆o de Cadastro"
         HEIGHT             = 18.96
         WIDTH              = 89
         MAX-HEIGHT         = 28.71
         MAX-WIDTH          = 145.57
         VIRTUAL-HEIGHT     = 28.71
         VIRTUAL-WIDTH      = 145.57
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = yes
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = yes
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
ASSIGN FRAME fPage1:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPage2:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   NOT-VISIBLE FRAME-NAME                                               */
/* SETTINGS FOR BUTTON btAddNivel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btDelNivel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btGeral IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fPage1
                                                                        */
ASSIGN 
       FRAME fPage1:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN nivel-projeto.cd-nivel IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN diferenca IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.ds-nivel IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-pai IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.nivel-pai IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN sobra IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.val-estimado IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.val-planejado IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nivel-projeto.val-real IN FRAME fPage1
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fPage2
                                                                        */
/* BROWSE-TAB brPeriodo 1 fPage2 */
ASSIGN 
       FRAME fPage2:HIDDEN           = TRUE.

ASSIGN 
       brPeriodo:COLUMN-RESIZABLE IN FRAME fPage2       = TRUE
       brPeriodo:COLUMN-MOVABLE IN FRAME fPage2         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPeriodo
/* Query rebuild information for BROWSE brPeriodo
     _START_FREEFORM
SESSION:SET-WAIT-STATE("GENERAL":U).
RUN criaAcomp.
OPEN QUERY {&SELF-NAME} FOR EACH tt-per NO-LOCK.
SESSION:SET-WAIT-STATE("":U).
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Query            is OPENED
*/  /* BROWSE brPeriodo */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fPage2
/* Query rebuild information for FRAME fPage2
     _TblList          = "money.nivel-projeto"
     _Query            is OPENED
*/  /* FRAME fPage2 */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 6
       COLUMN          = 2
       HEIGHT          = 11.75
       WIDTH           = 31
       WIDGET-ID       = 4
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {C74190B6-8589-11D1-B16A-00C0F0283628} type: TreeView */
      CtrlFrame-2:MOVE-AFTER(projeto.ds-projeto:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


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


&Scoped-define BROWSE-NAME brPeriodo
&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME brPeriodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPeriodo C-Win
ON MOUSE-SELECT-DBLCLICK OF brPeriodo IN FRAME fPage2
DO:

    IF tt-per.movtos <> "" THEN DO:
        {func\run.i &Programa = "consmov.w(INPUT tt-per.movtos)"}
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPeriodo C-Win
ON ROW-DISPLAY OF brPeriodo IN FRAME fPage2
DO:
  
    IF tt-per.dt-ini <= TODAY THEN DO:
        ASSIGN tt-per.ds-periodo:FGCOLOR IN BROWSE brPeriodo = 2
               tt-per.vl-prev:FGCOLOR IN BROWSE brPeriodo = 2
               tt-per.vl-real:FGCOLOR IN BROWSE brPeriodo = 2
               tt-per.pc-real:FGCOLOR IN BROWSE brPeriodo = 2
               tt-per.pc-prev:FGCOLOR IN BROWSE brPeriodo = 2.
    END.
    IF tt-per.pc-real > 75 THEN DO:
        ASSIGN tt-per.ds-periodo:FGCOLOR IN BROWSE brPeriodo = 6
               tt-per.vl-prev:FGCOLOR IN BROWSE brPeriodo = 6
               tt-per.vl-real:FGCOLOR IN BROWSE brPeriodo = 6
               tt-per.pc-real:FGCOLOR IN BROWSE brPeriodo = 6
               tt-per.pc-prev:FGCOLOR IN BROWSE brPeriodo = 6.
    END.
    IF tt-per.pc-real > 100 THEN DO:
        ASSIGN tt-per.ds-periodo:FGCOLOR IN BROWSE brPeriodo = 12
               tt-per.vl-prev:FGCOLOR IN BROWSE brPeriodo = 12
               tt-per.vl-real:FGCOLOR IN BROWSE brPeriodo = 12
               tt-per.pc-real:FGCOLOR IN BROWSE brPeriodo = 12
               tt-per.pc-prev:FGCOLOR IN BROWSE brPeriodo = 12.
    END.

    IF tt-per.pc-real = 0
        AND tt-per.vl-prev > 0
        AND tt-per.dt-ini <= TODAY
        AND tt-per.dt-end >= TODAY THEN DO:
        ASSIGN tt-per.ds-periodo:FGCOLOR IN BROWSE brPeriodo = 9
               tt-per.vl-prev:FGCOLOR IN BROWSE brPeriodo = 9
               tt-per.vl-real:FGCOLOR IN BROWSE brPeriodo = 9
               tt-per.pc-real:FGCOLOR IN BROWSE brPeriodo = 9
               tt-per.pc-prev:FGCOLOR IN BROWSE brPeriodo = 9.
    END.
    IF tt-per.dt-ini > TODAY THEN DO:
        ASSIGN tt-per.ds-periodo:FGCOLOR IN BROWSE brPeriodo = 8
               tt-per.vl-prev:FGCOLOR IN BROWSE brPeriodo = 8
               tt-per.vl-real:FGCOLOR IN BROWSE brPeriodo = 8
               tt-per.pc-real:FGCOLOR IN BROWSE brPeriodo = 8
               tt-per.pc-prev:FGCOLOR IN BROWSE brPeriodo = 8.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_add.i "cd-projeto"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAddNivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAddNivel C-Win
ON CHOOSE OF btAddNivel IN FRAME DEFAULT-FRAME /* >> */
DO:
  
    ASSIGN h-Node = chTreeView:SelectedItem:Key.
    RUN pi-ClickTreeView.
    
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "subniv.w (INPUT projeto.cd-projeto, INPUT nivel-projeto.cd-nivel)"}
    RUN pi-criaTreeView.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btAtual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAtual C-Win
ON CHOOSE OF btAtual IN FRAME fPage1 /* Atualizar */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND CURRENT nivel-projeto EXCLUSIVE-LOCK.
    ASSIGN INPUT FRAME fPage1 {&Frame1Fields}.
    fnAtualizaValores(nivel-projeto.cd-projeto).
    RUN displayFrameFields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME btDelNivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDelNivel C-Win
ON CHOOSE OF btDelNivel IN FRAME DEFAULT-FRAME /* X */
DO:
  
    DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.

    ASSIGN h-Node = chTreeView:SelectedItem:Key.
    RUN pi-ClickTreeView.
    
    RUN som.p(INPUT "music\click.wav").

    IF INPUT FRAME fPage1 nivel-projeto.cd-nivel <> 0 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
        IF RETURN-VALUE = "OK" THEN DO:
            ASSIGN rTemp = ROWID(nivel-projeto).
            fnEliminaNivel(INPUT FRAME default-frame projeto.cd-projeto,INPUT FRAME fPage1 nivel-projeto.cd-nivel).
            FIND FIRST nivel-projeto WHERE ROWID(nivel-projeto) = rTemp EXCLUSIVE-LOCK NO-ERROR.
            DELETE nivel-projeto.
            RUN pi-criaTreeView.
        END.
    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Aá∆o inv†lida (029)', INPUT 'Eliminaá∆o n∆o permitida!', INPUT 'N∆o Ç permitido eliminar o nivel principal do projeto.')"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDesemb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDesemb C-Win
ON CHOOSE OF btDesemb IN FRAME DEFAULT-FRAME /* Des */
DO:
    
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "projdes.w (INPUT projeto.cd-projeto)"}

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


&Scoped-define SELF-NAME btGeral
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGeral C-Win
ON CHOOSE OF btGeral IN FRAME DEFAULT-FRAME /* Geral */
DO:

    RUN som.p(INPUT "music\click.wav").
    RUN enableBut.
    DISABLE btGeral WITH FRAME default-frame.
    VIEW FRAME fPage1.
  
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


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btMov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMov C-Win
ON CHOOSE OF btMov IN FRAME fPage1 /* btexit 2 */
DO:
    DEFINE VARIABLE cRow AS CHARACTER  NO-UNDO INITIAL "".
  
    RUN som.p(INPUT "music\click.wav").

    SESSION:SET-WAIT-STATE("GENERAL").
    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "consmov.txt").
    FOR EACH mov-conta 
        WHERE mov-conta.cd-projeto = INPUT FRAME default-frame projeto.cd-projeto
        AND   mov-conta.cd-nivel   = INPUT FRAME fPage1 nivel-projeto.cd-nivel NO-LOCK:
        PUT UNFORMATTED STRING(ROWID(mov-conta)) + ",".
    END.
    OUTPUT CLOSE.
    SESSION:SET-WAIT-STATE("").

    {func\run.i &Programa = "consmov.w"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
    FIND CURRENT nivel-projeto EXCLUSIVE-LOCK.
    {func\bt_ok.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPer C-Win
ON CHOOSE OF btPer IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    RUN enableBut.
    DISABLE btPer WITH FRAME default-frame.
    VIEW FRAME fPage2.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPeriodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPeriodos C-Win
ON CHOOSE OF btPeriodos IN FRAME DEFAULT-FRAME /* Per */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "proj-periodo.w"}

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


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btValor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btValor C-Win
ON CHOOSE OF btValor IN FRAME fPage2 /* Valor */
DO:
    DEFINE VARIABLE deRet AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE rTemp AS ROWID      NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    ASSIGN deTotal = 0
           rTemp = tt-per.r-rowid.
    FOR EACH bfVal NO-LOCK
        WHERE bfVal.cd-projeto = projeto.cd-projeto
        AND   bfVal.cd-nivel = iNivel:
        ASSIGN deTotal = deTotal + bfVal.valor.
    END.

    FIND FIRST proj-periodo-nivel EXCLUSIVE-LOCK
        WHERE proj-periodo-nivel.cd-projeto = projeto.cd-projeto
        AND   proj-periodo-nivel.cd-nivel = iNivel
        AND   proj-periodo-nivel.cd-periodo = tt-per.cd-periodo NO-ERROR.
    IF AVAIL proj-periodo-nivel THEN DO:
        {func\run.i &Programa = "valor.w (INPUT 'Valor no Per°odo', INPUT proj-periodo-nivel.valor, OUTPUT deRet)"}
        IF ((deTotal - proj-periodo-nivel.valor + deRet) <= INPUT FRAME fPage1 nivel-projeto.val-planejado) THEN DO:
            ASSIGN proj-periodo-nivel.valor = deRet.
        END.
        ELSE DO:
            MESSAGE "Valor do per°odo ultrapassou o total planejado"
                VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        END.
    END.
    ELSE DO:
        CREATE proj-periodo-nivel.
        ASSIGN proj-periodo-nivel.cd-projeto = projeto.cd-projeto
               proj-periodo-nivel.cd-nivel = iNivel
               proj-periodo-nivel.cd-periodo = tt-per.cd-periodo.
        {func\run.i &Programa = "valor.w (INPUT 'Valor no Per°odo', INPUT 0, OUTPUT deRet)"}
        IF ((deTotal + deRet) <= INPUT FRAME fPage1 nivel-projeto.val-planejado) THEN DO:
            ASSIGN proj-periodo-nivel.valor = deRet.
        END.
        ELSE DO:
            MESSAGE "Valor do per°odo ultrapassou o total planejado"
                VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        END.
    END.

    ASSIGN iNivelCalc = 99999.

    {&OPEN-QUERY-brPeriodo}
    FIND FIRST bfPer WHERE bfPer.r-rowid = rTemp NO-ERROR.
    IF AVAIL bfPer THEN
        REPOSITION brPeriodo TO ROWID ROWID(bfPer).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btZoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btZoom C-Win
ON CHOOSE OF btZoom IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_zoom.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME nivel-projeto.cd-nivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.cd-nivel C-Win
ON ENTRY OF nivel-projeto.cd-nivel IN FRAME fPage1 /* C¢digo N°vel */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.cd-nivel C-Win
ON LEAVE OF nivel-projeto.cd-nivel IN FRAME fPage1 /* C¢digo N°vel */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME projeto.cd-projeto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.cd-projeto C-Win
ON ENTRY OF projeto.cd-projeto IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.cd-projeto C-Win
ON LEAVE OF projeto.cd-projeto IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win
ON LEAVE OF CtrlFrame-2 /* TreeView */
DO:

  ASSIGN h-Node = chTreeView:SelectedItem:Key.
RUN pi-ClickTreeView.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.Click
PROCEDURE CtrlFrame-2.TreeView.Click .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN h-Node = chTreeView:SelectedItem:Key.
RUN pi-ClickTreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.NodeClick
PROCEDURE CtrlFrame-2.TreeView.NodeClick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Required for OCX.
    Node
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER p-Node AS COM-HANDLE NO-UNDO.

ASSIGN h-Node = chTreeView:SelectedItem:Key.
RUN pi-ClickTreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME nivel-projeto.ds-nivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.ds-nivel C-Win
ON ENTRY OF nivel-projeto.ds-nivel IN FRAME fPage1 /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.ds-nivel C-Win
ON LEAVE OF nivel-projeto.ds-nivel IN FRAME fPage1 /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ds-pai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-pai C-Win
ON ENTRY OF ds-pai IN FRAME fPage1
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-pai C-Win
ON LEAVE OF ds-pai IN FRAME fPage1
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME projeto.ds-projeto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.ds-projeto C-Win
ON ENTRY OF projeto.ds-projeto IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.ds-projeto C-Win
ON LEAVE OF projeto.ds-projeto IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME nivel-projeto.nivel-pai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.nivel-pai C-Win
ON ENTRY OF nivel-projeto.nivel-pai IN FRAME fPage1 /* N°vel Pai */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.nivel-pai C-Win
ON LEAVE OF nivel-projeto.nivel-pai IN FRAME fPage1 /* N°vel Pai */
DO:
  
    {func\set_leave.i}  
    FIND FIRST bfNivel NO-LOCK
        WHERE bfNivel.cd-projeto = INPUT FRAME default-frame projeto.cd-projeto
        AND   bfNivel.cd-nivel = INPUT FRAME fPage1 nivel-projeto.nivel-pai NO-ERROR.
    IF AVAIL bfNivel THEN DO:
        ASSIGN ds-pai = bfNivel.ds-nivel.
    END.
    ELSE DO:
        ASSIGN ds-pai = "".
    END.
    DISPLAY ds-pai WITH FRAME fPage1.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nivel-projeto.val-estimado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.val-estimado C-Win
ON ENTRY OF nivel-projeto.val-estimado IN FRAME fPage1 /* Valor Estimado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.val-estimado C-Win
ON LEAVE OF nivel-projeto.val-estimado IN FRAME fPage1 /* Valor Estimado */
DO:
  
    {func\set_leave.i}  
    IF INPUT FRAME fPage1 nivel-projeto.val-planejado = 0 THEN DO:
        ASSIGN nivel-projeto.val-planejado:SCREEN-VALUE IN FRAME fPage1 = nivel-projeto.val-estimado:SCREEN-VALUE IN FRAME fPage1.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nivel-projeto.val-planejado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.val-planejado C-Win
ON ENTRY OF nivel-projeto.val-planejado IN FRAME fPage1 /* Valor Planejado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.val-planejado C-Win
ON LEAVE OF nivel-projeto.val-planejado IN FRAME fPage1 /* Valor Planejado */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nivel-projeto.val-real
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.val-real C-Win
ON ENTRY OF nivel-projeto.val-real IN FRAME fPage1 /* Valor Realizado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nivel-projeto.val-real C-Win
ON LEAVE OF nivel-projeto.val-real IN FRAME fPage1 /* Valor Realizado */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
  RUN enable_UI.
  {version.i projeto}
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculaValorReal C-Win 
PROCEDURE calculaValorReal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF AVAIL nivel-projeto THEN DO:
        FIND CURRENT nivel-projeto EXCLUSIVE-LOCK.
        ASSIGN nivel-projeto.val-real = 0.
        FOR EACH bfPer:
            ASSIGN nivel-projeto.val-real = nivel-projeto.val-real + bfPer.vl-real.
        END.
    END.

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
    DISABLE btPeriodos
            btDesemb WITH FRAME {&FRAME-NAME}.
    ENABLE btDelNivel
           btAddNivel WITH FRAME {&FRAME-NAME}.
    RUN displayFrameFields IN THIS-PROCEDURE.
    DISABLE nivel-projeto.cd-nivel
            nivel-projeto.nivel-pai
            nivel-projeto.ds-nivel
            nivel-projeto.val-real
            btMov WITH FRAME fPage1.
END.
ELSE DO:
    ENABLE btPeriodos
           btDesemb WITH FRAME {&FRAME-NAME}.
    DISABLE btDelNivel
            btAddNivel WITH FRAME {&FRAME-NAME}.
    ENABLE btMov WITH FRAME fPage1.
END.

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

OCXFile = SEARCH( "projeto.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame-2 = CtrlFrame-2:COM-HANDLE
    UIB_S = chCtrlFrame-2:LoadControls( OCXFile, "CtrlFrame-2":U)
    CtrlFrame-2:NAME = "CtrlFrame-2":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "projeto.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaAcomp C-Win 
PROCEDURE criaAcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF iNivel <> iNivelCalc THEN DO:
    
        FOR EACH tt-per:
            DELETE tt-per.
        END.
    
        FOR EACH proj-periodo OF projeto:
            CREATE tt-per.
            BUFFER-COPY proj-periodo TO tt-per.
            ASSIGN tt-per.vl-prev = fnValor(proj-periodo.cd-projeto, iNivel, proj-periodo.cd-periodo)
                   tt-per.pc-prev = IF deValPlan <> 0 THEN ((tt-per.vl-prev / deValPlan) * 100) ELSE 0
                   tt-per.r-rowid = ROWID(proj-periodo).
            IF iNivel = 0 THEN DO:
                FOR EACH mov-conta NO-LOCK
                    WHERE mov-conta.cd-projeto = proj-periodo.cd-projeto
                    AND   mov-conta.dt-mov >= proj-periodo.dt-ini
                    AND   mov-conta.dt-mov <= proj-periodo.dt-end:
                    ASSIGN tt-per.vl-real = tt-per.vl-real + (fnCotacao(mov-conta.de-valor,
                                         mov-conta.cd-moeda,
                                         0,
                                         mov-conta.dt-mov) * (-1))
                           tt-per.movtos = (IF tt-per.movtos <> "" THEN (tt-per.movtos + ",") ELSE "") + STRING(ROWID(mov-conta)).
                END.
                ASSIGN tt-per.pc-real = IF tt-per.vl-prev <> 0 THEN ((tt-per.vl-real / tt-per.vl-prev) * 100) ELSE 0.
            END.
            ELSE DO:
                FOR EACH mov-conta NO-LOCK
                    WHERE mov-conta.cd-projeto = proj-periodo.cd-projeto
                    AND   mov-conta.cd-nivel = iNivel
                    AND   mov-conta.dt-mov >= proj-periodo.dt-ini
                    AND   mov-conta.dt-mov <= proj-periodo.dt-end:
                    ASSIGN tt-per.vl-real = tt-per.vl-real + (fnCotacao(mov-conta.de-valor,
                                         mov-conta.cd-moeda,
                                         0,
                                         mov-conta.dt-mov) * (-1))
                           tt-per.movtos = (IF tt-per.movtos <> "" THEN (tt-per.movtos + ",") ELSE "") + STRING(ROWID(mov-conta)).
                END.
                ASSIGN tt-per.vl-real = tt-per.vl-real + fnValFilhoReal(proj-periodo.cd-projeto,iNivel)
                       tt-per.pc-real = IF tt-per.vl-prev <> 0 THEN ((tt-per.vl-real / tt-per.vl-prev) * 100) ELSE (IF tt-per.vl-real = 0 THEN 0 ELSE 999.9999).
            END.
        END.
    
        ASSIGN iNivelCalc = iNivel.
    
        RUN calculaValorReal.

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
RUN pi-criaTreeView.
APPLY "ENTRY" TO CtrlFrame-2.
ASSIGN h-Node = "P" + STRING(projeto.cd-projeto,"999").
RUN pi-ClickTreeView.

FIND FIRST nivel-projeto OF projeto NO-LOCK NO-ERROR.
IF NOT AVAIL nivel-projeto THEN DO:
    CREATE nivel-projeto.
    ASSIGN nivel-projeto.cd-projeto = projeto.cd-projeto
           nivel-projeto.ds-nivel = projeto.ds-projeto
           nivel-projeto.cd-nivel = 0
           nivel-projeto.nivel-pai = 0.
END.

{func\cadastro\display.i}

RUN displayFrameFields IN THIS-PROCEDURE.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFrameFields C-Win 
PROCEDURE displayFrameFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF AVAIL nivel-projeto THEN DO:
    DISPLAY {&Frame1Fields} WITH FRAME fPage1.
    ASSIGN sobra = nivel-projet.val-planejado - nivel-projeto.val-real
           diferenca = nivel-projet.val-planejado - nivel-projeto.val-estimado.
    DISPLAY sobra 
            diferenca WITH FRAME fPage1.
    APPLY "LEAVE":U TO nivel-projeto.nivel-pai IN FRAME fPage1.
    IF cAction = "UPDATE" 
    OR cAction = "ADD" THEN DO:
        IF NOT CAN-FIND(FIRST bfNivel
                        WHERE bfNivel.nivel-pai = nivel-projeto.cd-nivel
                        AND   bfNivel.cd-projeto = nivel-projeto.cd-projeto) THEN DO:
            IF nivel-projeto.val-planejado = 0 THEN
              ENABLE nivel-projeto.val-estimado WITH FRAME fPage1.
            ELSE
                DISABLE nivel-projeto.val-estimado WITH FRAME fPage1.
            ENABLE nivel-projeto.val-planejado WITH FRAME fPage1.
            ENABLE btAtual WITH FRAME fPage1.
            ENABLE btValor WITH FRAME fPage2.
        END.
        ELSE DO:
            DISABLE nivel-projeto.val-estimado WITH FRAME fPage1.
            DISABLE nivel-projeto.val-planejado WITH FRAME fPage1.
            DISABLE btAtual WITH FRAME fPage1.
            DISABLE btValor WITH FRAME fPage2.
        END.
    END.
    ELSE DO:
        DISABLE nivel-projeto.val-estimado WITH FRAME fPage1.
        DISABLE nivel-projeto.val-planejado WITH FRAME fPage1.
        DISABLE btAtual WITH FRAME fPage1.
        DISABLE btValor WITH FRAME fPage2.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enableBut C-Win 
PROCEDURE enableBut :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ENABLE btGeral
           btPer WITH FRAME default-frame.

    HIDE FRAME fPage1.
    HIDE FRAME fPage2.

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
  IF AVAILABLE projeto THEN 
    DISPLAY projeto.cd-projeto projeto.ds-projeto 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-4 RECT-5 projeto.cd-projeto projeto.ds-projeto btPer btDesemb 
         btGoTo btPeriodos btFirst btLast btNext btPrev btAdd btDel btExit 
         btUpdate btZoom 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY ds-pai diferenca sobra 
      WITH FRAME fPage1 IN WINDOW C-Win.
  IF AVAILABLE nivel-projeto THEN 
    DISPLAY nivel-projeto.cd-nivel nivel-projeto.ds-nivel nivel-projeto.nivel-pai 
          nivel-projeto.passivo nivel-projeto.val-estimado 
          nivel-projeto.val-planejado nivel-projeto.val-real 
      WITH FRAME fPage1 IN WINDOW C-Win.
  ENABLE btMov RECT-2 nivel-projeto.passivo btAtual 
      WITH FRAME fPage1 IN WINDOW C-Win.
  VIEW FRAME fPage1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage1}

  {&OPEN-QUERY-fPage2}
  GET FIRST fPage2.
  ENABLE brPeriodo btValor 
      WITH FRAME fPage2 IN WINDOW C-Win.
  VIEW FRAME fPage2 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage2}
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

IF AVAIL projeto THEN DO:
  ASSIGN FRAME fPage1:HIDDEN = NO
         FRAME fPage2:HIDDEN = YES
         h-node = "P" + STRING(projeto.cd-projeto,"999").
END.

/*RUN pi-clickTreeView.

APPLY "ENTRY" TO CtrlFrame-2.*/

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

 assign chTreeView            = chctrlframe-2:TreeView.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pi-clickTreeView C-Win 
PROCEDURE pi-clickTreeView :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN iNivel = 0.

    IF LENGTH(h-node) = 4 THEN DO:

        FIND FIRST nivel-projeto OF projeto NO-LOCK
            WHERE nivel-projeto.cd-nivel = 0
            AND   nivel-projeto.nivel-pai = 0 NO-ERROR.
        IF AVAIL nivel-projeto THEN DO:

            RUN displayFrameFields IN THIS-PROCEDURE.
            ASSIGN iNivel = nivel-projeto.cd-nivel
                   iNivelCalc = 999999
                   deValPlan = nivel-projeto.val-planejado.

        END.
        ELSE DO:
            ASSIGN nivel-projeto.cd-nivel:SCREEN-VALUE IN FRAME fPage1 = ""
                   nivel-projeto.ds-nivel:SCREEN-VALUE IN FRAME fPage1 = ""
                   nivel-projeto.nivel-pai:SCREEN-VALUE IN FRAME fPage1 = ""
                   ds-pai:SCREEN-VALUE IN FRAME fPage1 = "".
        END.

    END.
    ELSE DO:

        FIND FIRST nivel-projeto OF projeto NO-LOCK
            WHERE nivel-projeto.cd-nivel = INTEGER(SUBSTRING(h-node,6,3)) NO-ERROR.
        IF AVAIL nivel-projeto THEN DO:

            RUN displayFrameFields IN THIS-PROCEDURE.
            ASSIGN iNivel = nivel-projeto.cd-nivel
                   deValPlan = nivel-projeto.val-planejado.


        END.
        ELSE DO:
            ASSIGN nivel-projeto.cd-nivel:SCREEN-VALUE IN FRAME fPage1 = ""
                   nivel-projeto.ds-nivel:SCREEN-VALUE IN FRAME fPage1 = ""
                   nivel-projeto.nivel-pai:SCREEN-VALUE IN FRAME fPage1 = ""
                   ds-pai:SCREEN-VALUE IN FRAME fPage1 = "".
        END.

    END.
    {&OPEN-QUERY-brPeriodo}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pi-criaTreeView C-Win 
PROCEDURE pi-criaTreeView :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE i-cont AS INTEGER    NO-UNDO.

    DO i-cont = chTreeView:Nodes:COUNT TO 1 BY -1:
        chTreeView:Nodes:Remove(i-cont).
    END.

    IF AVAIL projeto THEN DO:
        chTreeView:Nodes:Add(,,"P" + STRING(projeto.cd-projeto,"999") + "N000",
                             projeto.ds-projeto,0).
        fnCriaNivel(projeto.cd-projeto,0).
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

DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-projeto NO-LOCK
        WHERE bf-projeto.cd-projeto = INPUT FRAME {&FRAME-NAME} projeto.cd-projeto
        AND   ROWID(bf-projeto) <> ROWID(projeto) NO-ERROR.
    IF AVAIL bf-projeto THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "UPDATE" THEN DO:
END.

IF cAction <> "DEL" THEN DO:

    FOR EACH bfNivel2 NO-LOCK
        WHERE bfNivel2.cd-projeto = projeto.cd-projeto
        BY bfNivel2.cd-nivel DESCENDING:
    
        ASSIGN deTotal = 0.
        FOR EACH proj-periodo-nivel OF bfNivel2:
            ASSIGN deTotal = deTotal + proj-periodo-nivel.valor.
        END.
        FOR EACH proj-periodo
            OF projeto:
            ASSIGN deTotal = deTotal + fnValFilho(projeto.cd-projeto, proj-periodo.cd-periodo, bfNivel2.cd-nivel).
        END.

        IF bfNivel2.val-planejado <> deTotal THEN DO:
            {func\valida.i &Mensagem  = "Divis∆o Inv†lida!"
                           &Ajuda     = "Divis∆o de valores por per°odo incorreta para algum n°vel"}
        END.

    END.

END.

IF cAction = "DEL" THEN DO:
    IF CAN-FIND(FIRST mov-conta OF projeto) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse projeto j† possui movimentaá∆o financeira associada e por este motivo n∆o pode ser eliminado."}
    END.

    FOR EACH proj-periodo OF projeto EXCLUSIVE-LOCK:
        DELETE proj-periodo.
    END.
    FOR EACH proj-periodo-nivel OF projeto EXCLUSIVE-LOCK:
        DELETE proj-periodo-nivel.
    END.
    FOR EACH nivel-projeto OF projeto EXCLUSIVE-LOCK:
        DELETE nivel-projeto.
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnAtualizaValores C-Win 
FUNCTION fnAtualizaValores RETURNS CHARACTER
  ( iProj AS INTEGER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FOR EACH bfNivel EXCLUSIVE-LOCK
        WHERE bfNivel.cd-projeto = iProj:

        RUN projval.p (INPUT iProj,
                       INPUT bfNivel.cd-nivel,
                       OUTPUT bfNivel.val-planejado,
                       OUTPUT bfNivel.val-estimado).

    END.

    RETURN "OK".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnBuscaMovNivel C-Win 
FUNCTION fnBuscaMovNivel RETURNS CHARACTER
  ( iNivelPai AS INTEGER, cLista AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FOR EACH nivel-projeto NO-LOCK
        WHERE nivel-projeto.cd-projeto = INPUT FRAME default-frame projeto.cd-projeto
        AND   nivel-projeto.nivel-pai = iNivelPai:

        IF iNivelPai = 0 AND nivel-projeto.cd-nivel = 0 THEN NEXT.

        FOR EACH mov-conta 
            WHERE mov-conta.cd-projeto = INPUT FRAME default-frame projeto.cd-projeto
            AND   mov-conta.cd-nivel   = nivel-projeto.cd-nivel NO-LOCK:

            ASSIGN cLista = cLista + STRING(ROWID(mov-conta)) + ",".

        END.
        cLista = fnBuscaMovNivel(nivel-projeto.cd-nivel, cLista).
    END.

    RETURN cLista.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnCriaNivel C-Win 
FUNCTION fnCriaNivel RETURNS CHARACTER
  ( iProj AS INTEGER, iPai AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/


    FOR EACH nivel-projeto NO-LOCK
        WHERE nivel-projeto.cd-projeto = iProj
        AND   nivel-projeto.nivel-pai = iPai:

        IF nivel-projeto.cd-nivel = 0 THEN NEXT.

        chTreeView:Nodes:Add("P" + STRING(nivel-projeto.cd-projeto,"999") +
                             "N" + STRING(nivel-projeto.nivel-pai,"999"),4,
                             "P" + STRING(nivel-projeto.cd-projeto,"999") +
                             "N" + STRING(nivel-projeto.cd-nivel,"999"),
                             nivel-projeto.ds-nivel,0).

        fnCriaNivel(iProj,nivel-projeto.cd-nivel).

    END.

    RETURN "OK".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnEliminaNivel C-Win 
FUNCTION fnEliminaNivel RETURNS CHARACTER
  ( iProj AS INTEGER, iPai AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/


    FOR EACH nivel-projeto NO-LOCK
        WHERE nivel-projeto.cd-projeto = iProj
        AND   nivel-projeto.nivel-pai = iPai:

        fnEliminaNivel(iProj,nivel-projeto.cd-nivel).

    END.
    FOR EACH nivel-projeto EXCLUSIVE-LOCK
        WHERE nivel-projeto.cd-projeto = iProj
        AND   nivel-projeto.nivel-pai = iPai:

        DELETE nivel-projeto.

    END.

    RETURN "OK".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnValFilho C-Win 
FUNCTION fnValFilho RETURNS DECIMAL
  ( iProj AS INT, iPer AS INT, iNiv AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE deVal AS DECIMAL    NO-UNDO INITIAL 0.

    FOR EACH bfNivel NO-LOCK
        WHERE bfNivel.cd-projeto = iProj
        AND   bfNivel.nivel-pai = iNiv
        AND   bfNivel.cd-nivel <> iNiv:

        FIND FIRST proj-periodo-nivel NO-LOCK
            WHERE proj-periodo-nivel.cd-projeto = iProj
            AND   proj-periodo-nivel.cd-nivel = bfNivel.cd-nivel
            AND   proj-periodo-nivel.cd-periodo = iPer NO-ERROR.
        IF AVAIL proj-periodo-nivel THEN
            ASSIGN deVal = deVal + proj-periodo-nivel.valor.
        ELSE
            ASSIGN deVal = deVal + fnValFilho(iProj,iPer,bfNivel.cd-nivel).

    END.

    RETURN deVal.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnValFilhoReal C-Win 
FUNCTION fnValFilhoReal RETURNS DECIMAL
  ( iProj AS INT, iNiv AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE deVal AS DECIMAL    NO-UNDO INITIAL 0.

    FOR EACH bfNivel NO-LOCK
        WHERE bfNivel.cd-projeto = iProj
        AND   bfNivel.nivel-pai = iNiv
        AND   bfNivel.cd-nivel <> iNiv:

        FOR EACH mov-conta NO-LOCK
            WHERE mov-conta.cd-projeto = iproj
            AND   mov-conta.cd-nivel = bfNivel.cd-nivel
            AND   mov-conta.dt-mov >= proj-periodo.dt-ini
            AND   mov-conta.dt-mov <= proj-periodo.dt-end:

            ASSIGN deVal = deVal + (fnCotacao(mov-conta.de-valor,
                                         mov-conta.cd-moeda,
                                         0,
                                         mov-conta.dt-mov) * (-1))
                   tt-per.movtos = (IF tt-per.movtos <> "" THEN (tt-per.movtos + ",") ELSE "") + STRING(ROWID(mov-conta)).

        END.
        ASSIGN deVal = deVal + fnValFilhoReal(iProj,bfNivel.cd-nivel).

    END.

    RETURN deVal.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnValor C-Win 
FUNCTION fnValor RETURNS DECIMAL
  ( iProj AS INT, iNiv AS INT, iPer AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE deVal AS DECIMAL    NO-UNDO INITIAL 0.

    FIND FIRST proj-periodo-nivel NO-LOCK
        WHERE proj-periodo-nivel.cd-projeto = iproj
        AND   proj-periodo-nivel.cd-nivel = iNiv
        AND   proj-periodo-nivel.cd-periodo = iPer NO-ERROR.
    IF AVAIL proj-periodo-nivel THEN
        ASSIGN deVal = proj-periodo-nivel.valor.

    ASSIGN deVal = deVal + fnValFilho(iProj,iPer,iNiv).

    RETURN deVal.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

