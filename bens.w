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
&GLOBAL-DEFINE Table        bens
&GLOBAL-DEFINE KeyFields    bens.cd-bens
&GLOBAL-DEFINE FrameFields  bens.ds-bens ~
                            bens.cd-moeda bens.grupo ~
                            bens.dt-aquisicao bens.vl-aquisicao ~
                            bens.pc-depreciacao bens.dt-venda ~
                            bens.vl-venda bens.vl-depreciacao ~
                            bens.bem-pai bens.bem-venda
&GLOBAL-DEFINE Frame3Fields bens.controla-consumo bens.un-consumo ~
                            bens.un-medida
&GLOBAL-DEFINE UseIndex     grupo

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

/* Buffers */

{func\definitions.i}

DEFINE VARIABLE deValBem AS DECIMAL COLUMN-LABEL "Valor" NO-UNDO.

DEFINE BUFFER bf-filho FOR bens.
DEFINE BUFFER bf-bens-aux FOR bens.

DEFINE TEMP-TABLE tt-linha
            FIELD id AS INTEGER
            FIELD linha AS CHAR.

{cotacao.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brFilhos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES bf-filho bens

/* Definitions for BROWSE brFilhos                                      */
&Scoped-define FIELDS-IN-QUERY-brFilhos bf-filho.cd-bens bf-filho.ds-bens fnValor(bf-filho.cd-bens, bens.cd-moeda) @ deValBem   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brFilhos   
&Scoped-define SELF-NAME brFilhos
&Scoped-define QUERY-STRING-brFilhos FOR EACH bf-filho NO-LOCK       WHERE bf-filho.bem-pai = INPUT FRAME {&FRAME-NAME} bens.cd-bens
&Scoped-define OPEN-QUERY-brFilhos OPEN QUERY {&SELF-NAME} FOR EACH bf-filho NO-LOCK       WHERE bf-filho.bem-pai = INPUT FRAME {&FRAME-NAME} bens.cd-bens.
&Scoped-define TABLES-IN-QUERY-brFilhos bf-filho
&Scoped-define FIRST-TABLE-IN-QUERY-brFilhos bf-filho


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME bens.cd-bens bens.ds-bens ~
bens.grupo bens.dt-aquisicao bens.dt-venda bens.vl-aquisicao bens.vl-venda ~
bens.pc-depreciacao bens.vl-depreciacao bens.bem-pai bens.bem-venda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME bens.cd-bens ~
bens.ds-bens bens.grupo bens.cd-moeda bens.dt-aquisicao bens.dt-venda ~
bens.vl-aquisicao bens.vl-venda bens.pc-depreciacao bens.vl-depreciacao ~
bens.bem-pai bens.bem-venda 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME bens
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME bens
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH bens SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH bens SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME bens
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME bens


/* Definitions for FRAME fPage1                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage1 ~
    ~{&OPEN-QUERY-brFilhos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS bens.cd-bens bens.ds-bens bens.grupo ~
bens.cd-moeda bens.dt-aquisicao bens.dt-venda bens.vl-aquisicao ~
bens.vl-venda bens.pc-depreciacao bens.vl-depreciacao bens.bem-pai ~
bens.bem-venda 
&Scoped-define ENABLED-TABLES bens
&Scoped-define FIRST-ENABLED-TABLE bens
&Scoped-Define ENABLED-OBJECTS btPrint sl-frame btMovtos btGoTo btFirst ~
btLast btNext btPrev btAdd btDel btExit btUpdate btZoom IMAGE-1 RECT-11 ~
RECT-4 RECT-5 RECT-6 RECT-7 
&Scoped-Define DISPLAYED-FIELDS bens.cd-bens bens.ds-bens bens.grupo ~
bens.dt-aquisicao bens.dt-venda bens.vl-aquisicao bens.vl-venda ~
bens.pc-depreciacao bens.vl-depreciacao bens.bem-pai bens.bem-venda 
&Scoped-define DISPLAYED-TABLES bens
&Scoped-define FIRST-DISPLAYED-TABLE bens
&Scoped-Define DISPLAYED-OBJECTS sl-frame ds-venda ds-pai 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnValor C-Win 
FUNCTION fnValor RETURNS DECIMAL
  ( iBem AS INT, moeda AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
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

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btMovtos 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentos Relacionados".

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

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btPrint 
     IMAGE-UP FILE "image/im-print.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-print.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btprint" 
     SIZE 6.14 BY 1.79 TOOLTIP "Imprime Etiqueta de Patrimìnio".

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

DEFINE VARIABLE ds-pai AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .79 NO-UNDO.

DEFINE VARIABLE ds-venda AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/im-naodisp.bmp":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 27 BY 6.25.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 1.5.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 1.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 2.25.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 3.75.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 2.5.

DEFINE VARIABLE sl-frame AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     LIST-ITEMS "Geral","Bens Agregados","Valores","Consumo" 
     SIZE 27 BY 3.25 NO-UNDO.

DEFINE VARIABLE vl-agreg AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Vl. Agregado" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79 NO-UNDO.

DEFINE VARIABLE vl-aquis AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Vl. Compra" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79 NO-UNDO.

DEFINE VARIABLE vl-cons AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Vl. Consumo" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79
     BGCOLOR 3 FGCOLOR 15 .

DEFINE VARIABLE vl-dep AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Vl. Depreciado" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79 NO-UNDO.

DEFINE VARIABLE vl-desp AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Vl. Despesa" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79
     BGCOLOR 12 FGCOLOR 15 .

DEFINE VARIABLE vl-final AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Vl. Final" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79
     FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vl-man AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Vl. Manut." 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79
     BGCOLOR 2 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE vl-total AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor Total" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79
     BGCOLOR 9 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 40 BY 9.5.

DEFINE VARIABLE desc-med AS CHARACTER FORMAT "X(256)":U INITIAL "Medida/Consumo" 
      VIEW-AS TEXT 
     SIZE 15 BY .67 NO-UNDO.

DEFINE VARIABLE tot-cons AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Total Consumo" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE VARIABLE tot-med AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Total Medida" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE VARIABLE tot-media AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "MÇdia" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79
     BGCOLOR 2 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE valor-consumo AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Valor por Consumo" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE VARIABLE valor-medida AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "Valor por Medida" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 6.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brFilhos FOR 
      bf-filho SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      bens SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brFilhos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brFilhos C-Win _FREEFORM
  QUERY brFilhos NO-LOCK DISPLAY
      bf-filho.cd-bens FORMAT "999":U
      bf-filho.ds-bens FORMAT "X(40)":U
      fnValor(bf-filho.cd-bens, bens.cd-moeda) @ deValBem
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 57 BY 9.5
         FONT 1
         TITLE "Filhos" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btPrint AT ROW 1.5 COL 73 WIDGET-ID 2
     sl-frame AT ROW 5.75 COL 2 NO-LABEL
     btMovtos AT ROW 1.5 COL 64
     btGoTo AT ROW 1.5 COL 48.43
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 16 COL 83.14
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 82
     btOK AT ROW 16 COL 77
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     bens.cd-bens AT ROW 4 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     bens.ds-bens AT ROW 4 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 34 BY .79
     bens.grupo AT ROW 4 COL 75
          VIEW-AS TOGGLE-BOX
          SIZE 9 BY .83
     bens.cd-moeda AT ROW 6.5 COL 45.29 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "",0
          DROP-DOWN-LIST
          SIZE 21 BY 1
     bens.dt-aquisicao AT ROW 8.63 COL 45.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     bens.dt-venda AT ROW 8.63 COL 74.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     bens.vl-aquisicao AT ROW 9.63 COL 45.29 COLON-ALIGNED FORMAT "->>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     bens.vl-venda AT ROW 9.63 COL 70.29 COLON-ALIGNED FORMAT "->>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 14 BY .79
     bens.pc-depreciacao AT ROW 10.63 COL 45.29 COLON-ALIGNED
          LABEL "% Deprec"
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     bens.vl-depreciacao AT ROW 10.63 COL 70.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY .79
     bens.bem-pai AT ROW 12.5 COL 39 COLON-ALIGNED
          LABEL "Pai"
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     ds-venda AT ROW 13.5 COL 45.29 COLON-ALIGNED NO-LABEL
     bens.bem-venda AT ROW 13.5 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     ds-pai AT ROW 12.5 COL 45.29 COLON-ALIGNED NO-LABEL
     IMAGE-1 AT ROW 9.5 COL 2
     RECT-11 AT ROW 3.75 COL 2
     RECT-4 AT ROW 6 COL 31
     RECT-5 AT ROW 1.25 COL 2
     RECT-6 AT ROW 8 COL 31
     RECT-7 AT ROW 12.13 COL 31
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.86 BY 17.25
         FONT 7.

DEFINE FRAME fPage1
     brFilhos AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 30 ROW 5.75
         SIZE 59 BY 10
         FONT 1.

DEFINE FRAME fPage2
     vl-aquis AT ROW 1.75 COL 25 COLON-ALIGNED
     vl-dep AT ROW 2.75 COL 25 COLON-ALIGNED
     vl-agreg AT ROW 3.75 COL 25 COLON-ALIGNED
     vl-total AT ROW 5.25 COL 25 COLON-ALIGNED
     vl-man AT ROW 6.25 COL 25 COLON-ALIGNED
     vl-desp AT ROW 7.25 COL 25 COLON-ALIGNED
     vl-cons AT ROW 8.25 COL 25 COLON-ALIGNED
     vl-final AT ROW 9.5 COL 25 COLON-ALIGNED
     RECT-12 AT ROW 1.25 COL 10
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 30 ROW 5.75
         SIZE 59 BY 10
         FONT 1.

DEFINE FRAME fPage3
     bens.controla-consumo AT ROW 1.25 COL 24
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .83
     bens.un-consumo AT ROW 2.25 COL 22 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     bens.un-medida AT ROW 3.25 COL 22 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     tot-cons AT ROW 4.75 COL 22 COLON-ALIGNED
     tot-med AT ROW 5.75 COL 22 COLON-ALIGNED
     tot-media AT ROW 7.25 COL 22 COLON-ALIGNED
     valor-consumo AT ROW 8.5 COL 22 COLON-ALIGNED
     valor-medida AT ROW 9.5 COL 22 COLON-ALIGNED
     desc-med AT ROW 7.25 COL 40 COLON-ALIGNED NO-LABEL
     RECT-13 AT ROW 4.5 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 30 ROW 5.75
         SIZE 59 BY 10
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
         HEIGHT             = 17.25
         WIDTH              = 88.86
         MAX-HEIGHT         = 23.92
         MAX-WIDTH          = 143.29
         VIRTUAL-HEIGHT     = 23.92
         VIRTUAL-WIDTH      = 143.29
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
       FRAME fPage2:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPage3:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN bens.bem-pai IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX bens.cd-moeda IN FRAME DEFAULT-FRAME
   NO-DISPLAY                                                           */
/* SETTINGS FOR FILL-IN ds-pai IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-venda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN bens.pc-depreciacao IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN bens.vl-aquisicao IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN bens.vl-venda IN FRAME DEFAULT-FRAME
   EXP-FORMAT                                                           */
/* SETTINGS FOR FRAME fPage1
                                                                        */
/* BROWSE-TAB brFilhos 1 fPage1 */
ASSIGN 
       brFilhos:COLUMN-RESIZABLE IN FRAME fPage1       = TRUE
       brFilhos:COLUMN-MOVABLE IN FRAME fPage1         = TRUE.

/* SETTINGS FOR FRAME fPage2
                                                                        */
/* SETTINGS FOR FILL-IN vl-agreg IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-aquis IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-cons IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-dep IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-desp IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-final IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-man IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-total IN FRAME fPage2
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fPage3
                                                                        */
/* SETTINGS FOR TOGGLE-BOX bens.controla-consumo IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN desc-med IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN tot-cons IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN tot-med IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN tot-media IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN bens.un-consumo IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN bens.un-medida IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN valor-consumo IN FRAME fPage3
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN valor-medida IN FRAME fPage3
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brFilhos
/* Query rebuild information for BROWSE brFilhos
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH bf-filho NO-LOCK
      WHERE bf-filho.bem-pai = INPUT FRAME {&FRAME-NAME} bens.cd-bens.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Where[1]         = "bens.bem-pai = INPUT FRAME default-frame bens.cd-bens"
     _Query            is OPENED
*/  /* BROWSE brFilhos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.bens"
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


&Scoped-define SELF-NAME bens.bem-pai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.bem-pai C-Win
ON ENTRY OF bens.bem-pai IN FRAME DEFAULT-FRAME /* Pai */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.bem-pai C-Win
ON LEAVE OF bens.bem-pai IN FRAME DEFAULT-FRAME /* Pai */
DO:

    {func\leave.i &Tabela="bens"
                  &Campo="cd-bens"
                  &CampoTela="bem-pai"
                  &CampoProc="ds-bens"
                  &Tela="ds-pai"}
                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.bem-pai C-Win
ON MOUSE-SELECT-DBLCLICK OF bens.bem-pai IN FRAME DEFAULT-FRAME /* Pai */
OR F5 OF {&Table}.bem-pai DO:
    {func\zoom.i &Tabela="bens"
                 &Campo1="cd-bens"
                 &Tela1="bens.bem-pai"
                 &Campo2="ds-bens"
                 &Tela2="ds-pai"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.bem-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.bem-venda C-Win
ON ENTRY OF bens.bem-venda IN FRAME DEFAULT-FRAME /* Entrada de */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.bem-venda C-Win
ON LEAVE OF bens.bem-venda IN FRAME DEFAULT-FRAME /* Entrada de */
DO:

    {func\leave.i &Tabela="bens"
                  &Campo="cd-bens"
                  &CampoTela="bem-venda"
                  &CampoProc="ds-bens"
                  &Tela="ds-venda"}
                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.bem-venda C-Win
ON MOUSE-SELECT-DBLCLICK OF bens.bem-venda IN FRAME DEFAULT-FRAME /* Entrada de */
OR F5 OF {&Table}.bem-venda DO:
    {func\zoom.i &Tabela="bens"
                 &Campo1="cd-bens"
                 &Tela1="bens.bem-venda"
                 &Campo2="ds-bens"
                 &Tela2="ds-venda"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brFilhos
&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME brFilhos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFilhos C-Win
ON MOUSE-SELECT-DBLCLICK OF brFilhos IN FRAME fPage1 /* Filhos */
DO:
  
    FIND FIRST bens WHERE bens.cd-bens = bf-filho.cd-bens NO-LOCK NO-ERROR.
    IF AVAIL bens THEN
        RUN displayFields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFilhos C-Win
ON ROW-DISPLAY OF brFilhos IN FRAME fPage1 /* Filhos */
DO:
  
    IF bf-filho.dt-venda <> ? THEN
        ASSIGN bf-filho.cd-bens:FGCOLOR IN BROWSE brFilhos = 8
               bf-filho.ds-bens:FGCOLOR IN BROWSE brFilhos = 8
               deValBem:FGCOLOR IN BROWSE brFilhos = 8.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    ASSIGN cImagem = "image\im-naodisp.bmp".
    image-1:LOAD-IMAGE(cImagem).
    {func\bt_add.i "cd-bens"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    ASSIGN cImagem = "".
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
    {func\bt_first.i grupo}
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
    {func\bt_last.i grupo}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMovtos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMovtos C-Win
ON CHOOSE OF btMovtos IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "mov-bens.w"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_next.i grupo}
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


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i grupo}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrint C-Win
ON CHOOSE OF btPrint IN FRAME DEFAULT-FRAME /* btprint */
DO:

    RUN som.p(INPUT "music\click.wav").
    RUN piImprimeEtiqueta.

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


&Scoped-define SELF-NAME bens.cd-moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.cd-moeda C-Win
ON ENTRY OF bens.cd-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.cd-moeda C-Win
ON LEAVE OF bens.cd-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage3
&Scoped-define SELF-NAME bens.controla-consumo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.controla-consumo C-Win
ON VALUE-CHANGED OF bens.controla-consumo IN FRAME fPage3 /* Controla Consumo */
DO:
  
    IF INPUT FRAME fPage3 bens.controla-consumo THEN DO:
        ENABLE bens.un-consumo
               bens.un-medida WITH FRAME fPage3.
    END.
    ELSE DO:
        DISABLE bens.un-consumo
                bens.un-medida WITH FRAME fPage3.
    END.

    APPLY "LEAVE" TO bens.un-consumo IN FRAME fPage3.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME bens.ds-bens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.ds-bens C-Win
ON ENTRY OF bens.ds-bens IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.ds-bens C-Win
ON LEAVE OF bens.ds-bens IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ds-pai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-pai C-Win
ON ENTRY OF ds-pai IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-pai C-Win
ON LEAVE OF ds-pai IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ds-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-venda C-Win
ON ENTRY OF ds-venda IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ds-venda C-Win
ON LEAVE OF ds-venda IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.dt-aquisicao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.dt-aquisicao C-Win
ON ENTRY OF bens.dt-aquisicao IN FRAME DEFAULT-FRAME /* Data Aquisiá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.dt-aquisicao C-Win
ON LEAVE OF bens.dt-aquisicao IN FRAME DEFAULT-FRAME /* Data Aquisiá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.dt-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.dt-venda C-Win
ON ENTRY OF bens.dt-venda IN FRAME DEFAULT-FRAME /* Data Venda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.dt-venda C-Win
ON LEAVE OF bens.dt-venda IN FRAME DEFAULT-FRAME /* Data Venda */
DO:
  
    {func\set_leave.i}  

    RUN recalc.

    IF INPUT FRAME {&FRAME-NAME} bens.dt-venda <> ? THEN
        ENABLE bens.bem-venda WITH FRAME {&FRAME-NAME}.
    ELSE
        DISABLE bens.bem-venda WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME IMAGE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF IMAGE-1 IN FRAME DEFAULT-FRAME
DO:
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE procname  AS CHARACTER  NO-UNDO.
  
    IF cAction <> "" THEN DO:

        SYSTEM-DIALOG GET-FILE procname
              TITLE      "Imagem do Bem"
              FILTERS    "Arquivos BMP"   "*.bmp",
                         "Arquivos GIF"   "*.gif",
                         "Todos os Arquivos"      "*.*"
              INITIAL-DIR cDiretorio
              MUST-EXIST
              USE-FILENAME
              UPDATE OKpressed. 

        IF OKpressed  THEN  DO:
            ASSIGN cDiretorio = SUBSTRING(procname,1,INDEX(procname,ENTRY(NUM-ENTRIES(procname,"\"),procname,"\"))).
            ASSIGN cImagem = procname.
            RUN displayFields IN THIS-PROCEDURE.
        END.  
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.pc-depreciacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.pc-depreciacao C-Win
ON ENTRY OF bens.pc-depreciacao IN FRAME DEFAULT-FRAME /* % Deprec */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.pc-depreciacao C-Win
ON LEAVE OF bens.pc-depreciacao IN FRAME DEFAULT-FRAME /* % Deprec */
DO:

    {func\set_leave.i}  
    RUN recalc.    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sl-frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sl-frame C-Win
ON VALUE-CHANGED OF sl-frame IN FRAME DEFAULT-FRAME
DO:
  
    IF sl-frame <> "" THEN
        RUN som.p(INPUT "music\click.wav").

    HIDE FRAME fPage1.
    HIDE FRAME fPage2.
    HIDE FRAME fPage3.

    CASE INPUT FRAME {&FRAME-NAME} sl-frame:
        WHEN "Bens Agregados" THEN ASSIGN FRAME fPage1:HIDDEN = NO.
        WHEN "Valores" THEN ASSIGN FRAME fPage2:HIDDEN = NO.
        WHEN "Consumo" THEN ASSIGN FRAME fPage3:HIDDEN = NO.
    END CASE.

    ASSIGN INPUT FRAME {&FRAME-NAME} sl-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage3
&Scoped-define SELF-NAME bens.un-consumo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.un-consumo C-Win
ON ENTRY OF bens.un-consumo IN FRAME fPage3 /* Unidade Consumo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.un-consumo C-Win
ON LEAVE OF bens.un-consumo IN FRAME fPage3 /* Unidade Consumo */
DO:

    {func\set_leave.i}  
    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.

    IF INPUT FRAME fPage3 bens.un-medida <> "" THEN
        ASSIGN cTemp = INPUT FRAME fPage3 bens.un-medida
               valor-medida:LABEL IN FRAME fPage3 = "Valor por " + INPUT FRAME fPage3 bens.un-medida.
    ELSE
        ASSIGN cTemp = "Medida"
               valor-medida:LABEL IN FRAME fPage3 = "Valor por Medida".

    ASSIGN cTemp = cTemp + "/".

    IF INPUT FRAME fPage3 bens.un-consumo <> "" THEN
        ASSIGN cTemp = cTemp + INPUT FRAME fPage3 bens.un-consumo
               valor-consumo:LABEL IN FRAME fPage3 = "Valor por " + INPUT FRAME fPage3 bens.un-consumo.
    ELSE
        ASSIGN cTemp = cTemp + "Consumo"
               valor-consumo:LABEL IN FRAME fPage3 = "Valor por Consumo".

    ASSIGN desc-med:SCREEN-VALUE IN FRAME fPage3 = cTemp.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.un-medida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.un-medida C-Win
ON ENTRY OF bens.un-medida IN FRAME fPage3 /* Unidade Medida */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.un-medida C-Win
ON LEAVE OF bens.un-medida IN FRAME fPage3 /* Unidade Medida */
DO:

    {func\set_leave.i}  
    APPLY "LEAVE" TO bens.un-consumo IN FRAME fPage3.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME bens.vl-aquisicao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.vl-aquisicao C-Win
ON ENTRY OF bens.vl-aquisicao IN FRAME DEFAULT-FRAME /* Vl. Aquisiá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.vl-aquisicao C-Win
ON LEAVE OF bens.vl-aquisicao IN FRAME DEFAULT-FRAME /* Vl. Aquisiá∆o */
DO:
  
    {func\set_leave.i}  
    RUN recalc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.vl-depreciacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.vl-depreciacao C-Win
ON ENTRY OF bens.vl-depreciacao IN FRAME DEFAULT-FRAME /* Depreciaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.vl-depreciacao C-Win
ON LEAVE OF bens.vl-depreciacao IN FRAME DEFAULT-FRAME /* Depreciaá∆o */
DO:

    DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
    DEFINE VARIABLE vl-mes AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iTest AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deVal AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE deTaxa AS DECIMAL    NO-UNDO INITIAL 1.
    DEFINE VARIABLE dtBase AS DATE       NO-UNDO.

    {func\set_leave.i}  

    ASSIGN dtBase = TODAY.

    IF INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao <> bens.vl-depreciacao THEN DO:
    
        IF INPUT FRAME {&FRAME-NAME} bens.dt-venda <> ? THEN
            IF INPUT FRAME {&FRAME-NAME} bens.dt-venda < dtBase THEN ASSIGN dtBase = INPUT FRAME {&FRAME-NAME} bens.dt-venda.

        REPEAT iTest = 1 TO 999999:
            ASSIGN iMes = (dtBase - INPUT FRAME {&FRAME-NAME} bens.dt-aquisicao) / 30
                   vl-mes = INPUT FRAME fPage2 vl-aquis
                   deVal = 0.
            REPEAT iCont = 1 TO iMes:
                ASSIGN deVal = deVal + (deTaxa * vl-mes) / 100
                       vl-mes = INPUT FRAME fPage2 vl-aquis - deVal.
            END.

            IF (deVal - INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao < 0.001
                AND deVal - INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao > -0.001)
            OR (INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao - deVal < 0.001
                AND INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao - deVal > -0.001) THEN 
                LEAVE.
            ELSE DO:
                IF ((0.0001 * (deVal - INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao)) < 0.01
                     AND (0.0001 * (deVal - INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao)) > -0.01) THEN
                    ASSIGN deTaxa = deTaxa - (0.001 * (deVal - INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao)).
                ELSE
                    IF deVal < INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao THEN
                        ASSIGN deTaxa = deTaxa + 0.0001.
                    ELSE
                        ASSIGN deTaxa = deTaxa - 0.0001.
            END.

        END.

        IF deVal < INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao THEN
            ASSIGN deTaxa = deTaxa + 0.0001.
        ELSE
            ASSIGN deTaxa = deTaxa - 0.0001.

        ASSIGN bens.pc-depreciacao = deTaxa.   
        DISPLAY bens.pc-depreciacao WITH FRAME {&FRAME-NAME}.
        ASSIGN INPUT FRAME {&FRAME-NAME} bens.vl-depreciacao.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bens.vl-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.vl-venda C-Win
ON ENTRY OF bens.vl-venda IN FRAME DEFAULT-FRAME /* Vl. Venda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bens.vl-venda C-Win
ON LEAVE OF bens.vl-venda IN FRAME DEFAULT-FRAME /* Vl. Venda */
DO:
  
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} bens.vl-venda <> 0 THEN DO:
        DISABLE bens.vl-depreciacao
                bens.pc-depreciacao WITH FRAME default-frame.
    END.
    ELSE DO:
        ENABLE bens.vl-depreciacao
               bens.pc-depreciacao WITH FRAME default-frame.
    END.

    RUN recalc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{campos\cd-moeda.i}                

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
  {version.i bens}
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterassignFields C-Win 
PROCEDURE afterassignFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE cNovo AS CHARACTER  NO-UNDO.

IF cImagem <> "image\im-naodisp.bmp" THEN DO:
    ASSIGN cNovo = SEARCH("image\alerta.ico")
           cNovo = REPLACE(cNovo,ENTRY(NUM-ENTRIES(cNovo,"\"),cNovo,"\"),("bens\bem" + STRING(bens.cd-bens,"999") + "." + ENTRY(NUM-ENTRIES(cImagem,"."),cImagem,"."))).
    OS-COPY VALUE(SEARCH(cImagem)) VALUE(cNovo).
    ASSIGN bens.imagem = cNovo.
END.
ELSE DO:
    ASSIGN bens.imagem = "".
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
    DISABLE btMovtos WITH FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO bens.controla-consumo IN FRAME fPage3.
END.
ELSE DO:
    ENABLE btMovtos WITH FRAME {&FRAME-NAME}.
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
{func\cadastro\display.i}

{&OPEN-QUERY-brFilhos}

APPLY "LEAVE" TO bens.bem-pai IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO bens.bem-venda IN FRAME {&FRAME-NAME}.

IF cAction = "" THEN DO:
    IF bens.imagem <> "" THEN
        IF SEARCH(bens.imagem) <> ? THEN
            ASSIGN cImagem = bens.imagem.
        ELSE
            ASSIGN cImagem = "image\im-naodisp.bmp".
    ELSE
        ASSIGN cImagem = "image\im-naodisp.bmp".
END.

image-1:LOAD-IMAGE(cImagem).

RUN recalc.

APPLY "LEAVE" TO bens.un-consumo IN FRAME fPage3.  

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
  DISPLAY sl-frame ds-venda ds-pai 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE bens THEN 
    DISPLAY bens.cd-bens bens.ds-bens bens.grupo bens.dt-aquisicao bens.dt-venda 
          bens.vl-aquisicao bens.vl-venda bens.pc-depreciacao 
          bens.vl-depreciacao bens.bem-pai bens.bem-venda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btPrint sl-frame btMovtos btGoTo btFirst btLast btNext btPrev btAdd 
         btDel btExit btUpdate btZoom bens.cd-bens bens.ds-bens bens.grupo 
         bens.cd-moeda bens.dt-aquisicao bens.dt-venda bens.vl-aquisicao 
         bens.vl-venda bens.pc-depreciacao bens.vl-depreciacao bens.bem-pai 
         bens.bem-venda IMAGE-1 RECT-11 RECT-4 RECT-5 RECT-6 RECT-7 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  ENABLE brFilhos 
      WITH FRAME fPage1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage1}
  DISPLAY vl-aquis vl-dep vl-agreg vl-total vl-man vl-desp vl-cons vl-final 
      WITH FRAME fPage2 IN WINDOW C-Win.
  ENABLE RECT-12 
      WITH FRAME fPage2 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage2}
  DISPLAY tot-cons tot-med tot-media valor-consumo valor-medida desc-med 
      WITH FRAME fPage3 IN WINDOW C-Win.
  IF AVAILABLE bens THEN 
    DISPLAY bens.controla-consumo bens.un-consumo bens.un-medida 
      WITH FRAME fPage3 IN WINDOW C-Win.
  ENABLE RECT-13 
      WITH FRAME fPage3 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage3}
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
{func/cb-lista.i cd-moeda}
    
{func\initialize.i}

ASSIGN sl-frame:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Geral".
APPLY "VALUE-CHANGED" TO sl-frame.

{func\cursor.i bens.bem-pai}
{func\cursor.i bens.bem-venda}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE piImprimeEtiqueta C-Win 
PROCEDURE piImprimeEtiqueta :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    EMPTY TEMP-TABLE tt-linha.
    
    DEFINE VARIABLE ilinha AS INTEGER    NO-UNDO.
    DEFINE VARIABLE linha  AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE c-prn  AS CHARACTER  NO-UNDO.

    DEFINE VARIABLE c-descricao AS CHARACTER LABEL "Descriá∆o" FORMAT "x(40)" NO-UNDO.
    DEFINE VARIABLE i-numero    AS INTEGER  FORMAT "9999" LABEL "Patrimìnio"  NO-UNDO.
    DEFINE VARIABLE da-data     AS DATE LABEL "Aquisiá∆o" INITIAL TODAY FORMAT "99/99/9999" NO-UNDO.

    ASSIGN i-numero    = INPUT FRAME DEFAULT-FRAME bens.cd-bens
           da-data     = INPUT FRAME DEFAULT-FRAME bens.dt-aquisicao
           c-descricao = INPUT FRAME DEFAULT-FRAME bens.ds-bens.

    ASSIGN c-prn = session:TEMP-DIRECTORY + "Patrimonio" + STRING(i-numero) + ".prn".

    INPUT FROM VALUE(SEARCH("etiqueta-bem.prn")).
        REPEAT:
            IMPORT UNFORMATTED linha.

            IF linha BEGINS "A48" THEN DO:
                ASSIGN linha = REPLACE(linha,"#desc",c-descricao).
            END.

            IF linha BEGINS "A463" THEN DO:
                ASSIGN linha = REPLACE(linha,"####",STRING(i-numero,"9999")).
            END.

            IF linha BEGINS "A447" THEN DO:
                ASSIGN linha = REPLACE(linha,"##/##/####",STRING(da-data,"99/99/9999")).
            END.

            IF linha BEGINS "B8" THEN DO:
                ASSIGN linha = REPLACE(linha,"#BC",STRING(i-numero,"9999")).
            END.

            ASSIGN ilinha = ilinha + 1.

            CREATE tt-linha.
            ASSIGN tt-linha.id    = ilinha
                   tt-linha.linha = linha.
        END.
    INPUT CLOSE.

    OUTPUT TO VALUE (c-prn).
        FOR EACH tt-linha
           WHERE NOT (tt-linha.linha BEGINS "A" 
                   OR tt-linha.linha BEGINS "B" 
                   OR tt-linha.linha BEGINS "P")
              BY tt-linha.id:
            PUT UNFORMATTED tt-linha.linha SKIP.

            DELETE tt-linha.
        END.
    OUTPUT CLOSE.

    OUTPUT TO VALUE (c-prn) CONVERT TARGET "iso8859-1" APPEND.
        FOR EACH tt-linha
              BY tt-linha.id:
            PUT UNFORMATTED tt-linha.linha SKIP.

            DELETE tt-linha.
        END.
    OUTPUT CLOSE.

    IF NOT AVAILABLE param-mn THEN
        FIND FIRST param-mn NO-LOCK NO-ERROR.

    OS-COMMAND SILENT VALUE("print /D:" + param-mn.imp-etiq + " " + c-prn).
    /*OS-COMMAND SILENT VALUE("print /D:\\lilith\Zebra " + c-prn).*/
    
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

    DEFINE VARIABLE vl-temp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
    DEFINE VARIABLE vl-mes AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dtBase AS DATE       NO-UNDO.
    DEFINE VARIABLE deDepre AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE vl-aquis-hoje AS DECIMAL     NO-UNDO.

      ASSIGN /*vl-aquis = fnCotacao(INPUT FRAME {&FRAME-NAME} bens.vl-aquis,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,0,INPUT FRAME {&FRAME-NAME} bens.dt-aquisicao)*/
             vl-aquis = INPUT FRAME {&FRAME-NAME} bens.vl-aquis
             vl-aquis-hoje = 0
             vl-agreg = 0
             vl-man = 0
             vl-desp = 0
             vl-cons = 0
             vl-final = fnCotacao(INPUT FRAME {&FRAME-NAME} bens.vl-venda,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,0,INPUT FRAME {&FRAME-NAME} bens.dt-venda)
             tot-cons = 0
             tot-med = 0
             tot-media = 0
             valor-medida = 0
             valor-consumo = 0
             dtBase = TODAY.

      FOR EACH mov-bens OF bens
          WHERE mov-bens.id-tipo = 1 NO-LOCK:
          FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
          IF AVAIL mov-conta THEN DO:
              ASSIGN vl-aquis = vl-aquis + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,mov-conta.dt-mov)).
              /*ASSIGN vl-aquis = vl-aquis + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)).*/
          END.
      END.

      FOR EACH bf-bens
          WHERE bf-bens.bem-venda = bens.cd-bens NO-LOCK:

          RUN vendabem.p (INPUT bf-bens.cd-bens, INPUT INPUT FRAME {&FRAME-NAME} bens.cd-moeda, INPUT bf-bens.dt-venda, OUTPUT vl-temp).
          /*RUN vendabem.p (INPUT bf-bens.cd-bens, INPUT 0, INPUT bf-bens.dt-venda, OUTPUT vl-temp).*/
          ASSIGN vl-aquis = vl-aquis + vl-temp.

      END.
      
      ASSIGN vl-aquis-hoje = fnCotacao(vl-aquis,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,0,TODAY)
             vl-aquis = fnCotacao(vl-aquis,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,0,bens.dt-aquis).

      FOR EACH mov-bens OF bens
          WHERE mov-bens.id-tipo = 2 NO-LOCK:
          FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
          IF AVAIL mov-conta THEN DO:
              /* Depreciaá∆o do Valor Agregado */
              ASSIGN deDepre = 0
                     vl-mes = ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)).
              REPEAT iCont = 1 TO ((dtBase - mov-conta.dt-mov) / 30):
                  ASSIGN deDepre = (INPUT FRAME {&FRAME-NAME} bens.pc-depreciacao * vl-mes) / 100
                         vl-mes = vl-mes - deDepre.
              END.
              ASSIGN vl-agreg = vl-agreg + vl-mes.
          END.
      END.

      FOR EACH bf-bens
          WHERE bf-bens.bem-pai = bens.cd-bens NO-LOCK:

          IF bf-bens.dt-venda <> ? AND bens.dt-venda = ? THEN NEXT.

          RUN valorbem.p (INPUT bf-bens.cd-bens, INPUT TODAY, INPUT 0, OUTPUT vl-temp).
          ASSIGN vl-agreg = vl-agreg + vl-temp.

      END.

      FOR EACH mov-bens OF bens
          WHERE mov-bens.id-tipo = 3 NO-LOCK:
          FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
          IF AVAIL mov-conta THEN
            ASSIGN vl-man = vl-man + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)).
      END.
      FOR EACH mov-bens OF bens
          WHERE mov-bens.id-tipo = 4 NO-LOCK:
          FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
          IF AVAIL mov-conta THEN
            ASSIGN vl-desp = vl-desp + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)).
      END.
      FOR EACH mov-bens OF bens
          WHERE mov-bens.id-tipo = 5 NO-LOCK:
          FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
          IF AVAIL mov-conta THEN
            ASSIGN vl-cons = vl-cons + ((-1) * fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)).

          ASSIGN tot-cons = tot-cons + mov-bens.val-consumo
                 tot-med = tot-med + mov-bens.val-medida.

      END.

      FOR FIRST mov-bens OF bens NO-LOCK
          WHERE mov-bens.id-tipo = 5,
          LAST mov-conta OF mov-bens NO-LOCK
          BY mov-conta.dt-mov:
          IF AVAIL mov-conta THEN DO:
              IF tot-cons <> 0 THEN DO:
                  ASSIGN tot-media = tot-med / (tot-cons - mov-bens.val-consumo)
                         valor-consumo = vl-cons / tot-cons.
              END.
              ELSE DO:
                  ASSIGN tot-media = 0.
              END.
              IF tot-med <> 0 THEN DO:
                  ASSIGN valor-medida = (vl-cons + mov-conta.de-valor) / tot-med.
              END.
          END.
      END.

      FOR EACH mov-bens OF bens
          WHERE mov-bens.id-tipo = 6 NO-LOCK:
          FIND FIRST mov-conta OF mov-bens NO-LOCK NO-ERROR.
          IF AVAIL mov-conta THEN
            ASSIGN vl-final = vl-final + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
      END.

      IF vl-final > 0 THEN DO:
          DISABLE bens.vl-depreciacao
                  bens.pc-depreciacao WITH FRAME {&FRAME-NAME}.
      END.

      DISPLAY vl-aquis
              vl-dep
              vl-agreg
              vl-final
              vl-man
              vl-cons
              vl-desp WITH FRAME fPage2.

      DISPLAY tot-cons
              tot-med
              tot-media
              valor-consumo
              valor-medida WITH FRAME fPage3.

      IF INPUT FRAME {&FRAME-NAME} bens.dt-venda <> ? THEN
          IF INPUT FRAME {&FRAME-NAME} bens.dt-venda < dtBase THEN ASSIGN dtBase = INPUT FRAME {&FRAME-NAME} bens.dt-venda.

      FIND CURRENT bens EXCLUSIVE-LOCK.

      ASSIGN iMes = (dtBase - INPUT FRAME {&FRAME-NAME} bens.dt-aquisicao) / 30
             vl-mes = fnCotacao(INPUT FRAME fPage2 vl-aquis,0,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,INPUT FRAME {&FRAME-NAME} bens.dt-aquisicao)
             bens.vl-depreciacao = 0.
      REPEAT iCont = 1 TO iMes:
          ASSIGN bens.vl-depreciacao = bens.vl-depreciacao + (INPUT FRAME {&FRAME-NAME} bens.pc-depreciacao * vl-mes) / 100
                 vl-mes = fnCotacao(INPUT FRAME fPage2 vl-aquis,0,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,INPUT FRAME {&FRAME-NAME} bens.dt-aquisicao) - bens.vl-depreciacao.
      END.

      ASSIGN vl-dep = vl-aquis-hoje - fnCotacao(bens.vl-depreciacao,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,0,TODAY)
             vl-total = vl-aquis-hoje + vl-agreg - fnCotacao(bens.vl-depreciacao,INPUT FRAME {&FRAME-NAME} bens.cd-moeda,0,TODAY).

      DISPLAY bens.vl-depreciacao WITH FRAME {&FRAME-NAME}.
      DISPLAY vl-dep
              vl-total WITH FRAME fPage2.

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
    FIND FIRST bf-bens NO-LOCK
        WHERE bf-bens.cd-bens = INPUT FRAME {&FRAME-NAME} bens.cd-bens
        AND   ROWID(bf-bens) <> ROWID(bens) NO-ERROR.
    IF AVAIL bf-bens THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "UPDATE" THEN DO:
END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST mov-bens OF bens) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse bem possui movimentos associados e por este motivo n∆o pode ser eliminado."}
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnValor C-Win 
FUNCTION fnValor RETURNS DECIMAL
  ( iBem AS INT, moeda AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.

    FIND FIRST bf-bens WHERE bf-bens.cd-bens = iBem NO-LOCK NO-ERROR.
    IF AVAIL bf-bens THEN DO:

        IF bf-bens.dt-venda = ? THEN
            RUN valorbem.p (INPUT iBem, INPUT TODAY, INPUT moeda, OUTPUT deValor).
        ELSE DO:

            RUN vendabem.p (INPUT iBem, INPUT moeda, INPUT bf-bens.dt-venda, OUTPUT deValor).
            IF deValor = 0 THEN DO:
                FIND FIRST bf-bens-aux WHERE bf-bens-aux.cd-bens = bf-bens.bem-pai NO-LOCK NO-ERROR.
                IF AVAIL bf-bens-aux THEN DO:
                    IF bf-bens-aux.dt-venda <> ? THEN
                        RUN valorbem.p (INPUT iBem, INPUT bf-bens-aux.dt-venda, INPUT moeda, OUTPUT deValor).
                END.
            END.
        END.

    END.

    RETURN deValor.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

