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
&GLOBAL-DEFINE Table        item
&GLOBAL-DEFINE KeyFields    item.cd-item
&GLOBAL-DEFINE FrameFields  item.ds-item item.unidade ~
                            item.cod-categoria item.cd-sub ~
                            item.dt-ult-compra item.reposicao ~
                            item.permite-dec item.controlado ~
                            item.tipo item.desp-viag ~
                            item.fator-reemb

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS item.cd-item item.unidade item.permite-dec ~
item.ds-item item.tipo item.controlado item.cod-categoria item.cd-sub ~
item.dt-ult-compra item.reposicao item.desp-viag item.fator-reemb 
&Scoped-define ENABLED-TABLES item
&Scoped-define FIRST-ENABLED-TABLE item
&Scoped-Define ENABLED-OBJECTS btHist btGoTo btFirst btLast btNext btPrev ~
btAdd btDel btExit btUpdate btZoom RECT-4 RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS item.cd-item item.unidade item.permite-dec ~
item.ds-item item.tipo item.controlado item.cod-categoria item.cd-sub ~
item.dt-ult-compra item.reposicao item.desp-viag item.fator-reemb 
&Scoped-define DISPLAYED-TABLES item
&Scoped-define FIRST-DISPLAYED-TABLE item
&Scoped-Define DISPLAYED-OBJECTS desc-cat desc-sub 

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

DEFINE BUTTON btHist 
     IMAGE-UP FILE "image/im-det.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-det.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Hist¢rico".

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

DEFINE VARIABLE desc-cat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .79 NO-UNDO.

DEFINE VARIABLE desc-sub AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 9.25.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 80 BY 3.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     item.cd-item AT ROW 4.5 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     item.unidade AT ROW 4.5 COL 52 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     item.permite-dec AT ROW 4.5 COL 60
          VIEW-AS TOGGLE-BOX
          SIZE 14 BY .83
     item.ds-item AT ROW 5.5 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 45 BY .79
     btHist AT ROW 1.5 COL 63
     item.tipo AT ROW 6.5 COL 27.14 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Compra",1,
                     "Venda",2
          DROP-DOWN-LIST
          SIZE 16 BY 1
     item.controlado AT ROW 6.5 COL 64 WIDGET-ID 2
          VIEW-AS TOGGLE-BOX
          SIZE 10 BY .83
     item.cod-categoria AT ROW 9 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     desc-cat AT ROW 9 COL 31.29 COLON-ALIGNED NO-LABEL
     item.cd-sub AT ROW 10 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     desc-sub AT ROW 10 COL 31.29 COLON-ALIGNED NO-LABEL
     item.dt-ult-compra AT ROW 11.75 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btGoTo AT ROW 1.5 COL 48.43
     item.reposicao AT ROW 11.75 COL 63.5 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 8.72 BY .79
     item.desp-viag AT ROW 8 COL 29 WIDGET-ID 6
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .83
     btFirst AT ROW 1.5 COL 3
     item.fator-reemb AT ROW 8 COL 62 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 13.25 COL 81.14
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 13.25 COL 75
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-6 AT ROW 7.75 COL 5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.29 BY 14.13
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
         HEIGHT             = 14.13
         WIDTH              = 86.29
         MAX-HEIGHT         = 22.08
         MAX-WIDTH          = 100.72
         VIRTUAL-HEIGHT     = 22.08
         VIRTUAL-WIDTH      = 100.72
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
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN desc-cat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN desc-sub IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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
    {func\bt_add.i "cd-item"}
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


&Scoped-define SELF-NAME btHist
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btHist C-Win
ON CHOOSE OF btHist IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "hist-item.w"}
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


&Scoped-define SELF-NAME item.cd-item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cd-item C-Win
ON ENTRY OF item.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cd-item C-Win
ON LEAVE OF item.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cd-sub C-Win
ON ENTRY OF item.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cd-sub C-Win
ON LEAVE OF item.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} {&Table}.cod-categoria"
                  &CampoProc = "ds-sub"
                  &Tela="desc-sub"}      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cd-sub C-Win
ON MOUSE-SELECT-DBLCLICK OF item.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
OR F5 OF {&Table}.cd-sub DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="{&Table}.cd-sub"
                 &Campo2="ds-sub"
                 &Tela2="desc-sub"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} {&Table}.cod-categoria"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cod-categoria C-Win
ON ENTRY OF item.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cod-categoria C-Win
ON LEAVE OF item.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoProc = "ds-categoria"
                  &Tela="desc-cat"}      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.cod-categoria C-Win
ON MOUSE-SELECT-DBLCLICK OF item.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
OR F5 OF {&Table}.cod-categoria DO:
    DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO INITIAL 2.
    {func\zoom.i &Tabela="categoria"
                 &Campo1="cod-categoria"
                 &Tela1="{&Table}.cod-categoria"
                 &Campo2="ds-categoria"
                 &Tela2="desc-cat"
                 &CampoFiltro1="id-tipo"
                 &ValorFiltro1="iTipo"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME desc-cat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL desc-cat C-Win
ON ENTRY OF desc-cat IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL desc-cat C-Win
ON LEAVE OF desc-cat IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME desc-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL desc-sub C-Win
ON ENTRY OF desc-sub IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL desc-sub C-Win
ON LEAVE OF desc-sub IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.desp-viag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.desp-viag C-Win
ON VALUE-CHANGED OF item.desp-viag IN FRAME DEFAULT-FRAME /* Despesa de Viagem */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} item.tipo = 1 THEN DO:
        ENABLE item.cod-categoria
                item.cd-sub
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        IF item.desp-viag:CHECKED THEN DO:
            ENABLE item.fator-reemb
                WITH FRAME {&FRAME-NAME}.
            ENABLE item.cod-categoria
                    item.cd-sub
                WITH FRAME {&FRAME-NAME}.
        END.
        ELSE DO:
            ASSIGN item.fator-reemb:SCREEN-VALUE = "1,00".
            DISABLE item.fator-reemb
                WITH FRAME {&FRAME-NAME}.
            DISABLE item.cod-categoria
                    item.cd-sub
                WITH FRAME {&FRAME-NAME}.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.ds-item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.ds-item C-Win
ON ENTRY OF item.ds-item IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.ds-item C-Win
ON LEAVE OF item.ds-item IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.dt-ult-compra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.dt-ult-compra C-Win
ON ENTRY OF item.dt-ult-compra IN FRAME DEFAULT-FRAME /* Data Èltima Compra */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.dt-ult-compra C-Win
ON LEAVE OF item.dt-ult-compra IN FRAME DEFAULT-FRAME /* Data Èltima Compra */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.reposicao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.reposicao C-Win
ON ENTRY OF item.reposicao IN FRAME DEFAULT-FRAME /* Tempo de Reposiá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.reposicao C-Win
ON LEAVE OF item.reposicao IN FRAME DEFAULT-FRAME /* Tempo de Reposiá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.tipo C-Win
ON ENTRY OF item.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.tipo C-Win
ON LEAVE OF item.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.tipo C-Win
ON VALUE-CHANGED OF item.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} item.tipo = 2 /* Venda */ THEN DO:
        ENABLE item.desp-viag
               item.fator-reemb
            WITH FRAME {&FRAME-NAME}.
        ASSIGN item.controlado:CHECKED = FALSE.
        DISABLE item.controlado
            WITH FRAME {&FRAME-NAME}.
        IF NOT item.desp-viag:CHECKED THEN DO:
            ASSIGN item.cod-categoria:SCREEN-VALUE = "000"
                   item.cd-sub:SCREEN-VALUE = "000".
            DISABLE item.cod-categoria
                    item.cd-sub
                WITH FRAME {&FRAME-NAME}.
        END.
        APPLY "LEAVE" TO item.cod-categoria.
        APPLY "LEAVE" TO item.cd-sub.
        DISABLE item.controlado
                item.cod-categoria
                item.cd-sub
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ASSIGN item.desp-viag:CHECKED = FALSE
               item.fator-reemb:SCREEN-VALUE = "1,00".
        DISABLE item.desp-viag
               item.fator-reemb
            WITH FRAME {&FRAME-NAME}.
        ENABLE item.controlado
               item.cod-categoria
               item.cd-sub
            WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item.unidade
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.unidade C-Win
ON ENTRY OF item.unidade IN FRAME DEFAULT-FRAME /* Unidade */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item.unidade C-Win
ON LEAVE OF item.unidade IN FRAME DEFAULT-FRAME /* Unidade */
DO:
    {func\set_leave.i}    
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
  RUN enable_UI.
  {version.i item}
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
    DISABLE btHist WITH FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO item.desp-viag.
END.
ELSE DO:
    ENABLE btHist WITH FRAME {&FRAME-NAME}.
END.

DISABLE item.dt-ult-compra
        item.reposicao WITH FRAME {&FRAME-NAME}.

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

APPLY "LEAVE" TO {&Table}.cod-categoria.
APPLY "LEAVE" TO {&Table}.cd-sub.

FIND FIRST param-mn NO-LOCK NO-ERROR.
IF param-mn.perfil = 1 /* Pessoal */ THEN
    ASSIGN item.desp-viag:HIDDEN = TRUE.

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
  DISPLAY desc-cat desc-sub 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE item THEN 
    DISPLAY item.cd-item item.unidade item.permite-dec item.ds-item item.tipo 
          item.controlado item.cod-categoria item.cd-sub item.dt-ult-compra 
          item.reposicao item.desp-viag item.fator-reemb 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE item.cd-item item.unidade item.permite-dec item.ds-item btHist 
         item.tipo item.controlado item.cod-categoria item.cd-sub 
         item.dt-ult-compra btGoTo item.reposicao item.desp-viag btFirst 
         item.fator-reemb btLast btNext btPrev btAdd btDel btExit btUpdate 
         btZoom RECT-4 RECT-5 RECT-6 
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

{func\cursor.i {&Table}.cod-categoria}
{func\cursor.i {&Table}.cd-sub}

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
    FIND FIRST bf-item NO-LOCK
        WHERE bf-item.cd-item = INPUT FRAME {&FRAME-NAME} item.cd-item
        AND   ROWID(bf-item) <> ROWID(item) NO-ERROR.
    IF AVAIL bf-item THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction <> "DEL" THEN DO:

    IF INPUT FRAME {&FRAME-NAME} item.unidade = "" THEN DO:
        {func\valida.i &Mensagem  = "Unidade inv†lida!"
                       &Ajuda     = "Deve ser informada uma unidade para o item."
                       &Campo     = item.unidade}
    END.
    IF INPUT FRAME {&FRAME-NAME} item.tipo = 1 /* Compra */
    OR INPUT FRAME {&FRAME-NAME} item.desp-viag THEN DO:
        IF NOT CAN-FIND(FIRST categoria 
                        WHERE categoria.cod-categoria = INPUT FRAME {&FRAME-NAME} item.cod-categoria) THEN DO:
            {func\valida.i &Mensagem  = "Categoria inv†lida!"
                           &Ajuda     = "Deve ser informada uma categoria v†lida para o item."
                           &Campo     = item.cod-categoria}
        END.
        IF NOT CAN-FIND(FIRST sub-cat 
                        WHERE sub-cat.cod-categoria = INPUT FRAME {&FRAME-NAME} item.cod-categoria
                        AND   sub-cat.cd-sub = INPUT FRAME {&FRAME-NAME} item.cd-sub) THEN DO:
            {func\valida.i &Mensagem  = "Sub-Categoria inv†lida!"
                           &Ajuda     = "Deve ser informada uma sub-categoria v†lida para o item."
                           &Campo     = item.cd-sub}
        END.
    END.

END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST pedido-item OF item) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Este item est† relacionado a um pedido."}
    END.
    IF CAN-FIND(FIRST tabela-preco-item OF item) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Este item est† relacionado a uma tabela de preáo."}
    END.
    IF CAN-FIND(FIRST nota-fiscal-item OF item) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Este item est† relacionado a uma nota fiscal."}
    END.
    IF CAN-FIND(FIRST item-compra OF item) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Este item est† relacionado a uma compra."}
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

