&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
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

{func\tt_graf.i}

DEFINE INPUT  PARAMETER TABLE FOR tt-graf-par.
DEFINE INPUT  PARAMETER TABLE FOR tt-graf.
    
/* Local Variable Definitions ---                                       */

{seg.i}

DEFINE VARIABLE chGrafico AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chTitulo AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chConstantes AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chDesenho AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia1 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia2 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia3 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chSequencia4 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chPlanilha AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chLabels1 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chLabels2 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chLabels3 AS COM-HANDLE  NO-UNDO.
DEFINE VARIABLE chLabels4 AS COM-HANDLE  NO-UNDO.

DEFINE NEW GLOBAL SHARED VARIABLE cArquivo AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btSave RECT-11 TpGrafico btTab btExit 
&Scoped-Define DISPLAYED-OBJECTS TpGrafico 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnGravaDado C-Win 
FUNCTION fnGravaDado RETURNS CHARACTER
  ( i-linha as int, i-coluna as int, c-valor as char, c-formato as CHAR ) FORWARD.

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
DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btSave 
     IMAGE-UP FILE "image/im-save.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-save.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Salvar como...".

DEFINE BUTTON btTab 
     IMAGE-UP FILE "image/im-det.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-det.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Tabela de Dados".

DEFINE VARIABLE TpGrafico AS INTEGER FORMAT "->9":U INITIAL 0 
     LABEL "Tipo Gr fico" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Area",29,
                     "AreaStacked",30,
                     "AreaStacked100",31,
                     "BarClustered",3,
                     "BarStacked",4,
                     "BarStacked100",5,
                     "Buble",27,
                     "BubleLine",28,
                     "ColumnClustered",0,
                     "ColumnStacked",1,
                     "ColumnStacked100",2,
                     "Doughnut",32,
                     "DoughnutExploded",33,
                     "TypeLine",6,
                     "TypeLineMarkers",7,
                     "LineStacked",8,
                     "LineStacked100",10,
                     "LineStacked100Markers",11,
                     "LineStackedMarkers",9,
                     "Pie",18,
                     "PieExploded",19,
                     "PieStacked",20,
                     "PolarLine",42,
                     "PolarLineMarkers",43,
                     "PolarMarkers",41,
                     "PolarSmoothLine",44,
                     "PolarSmoothLineMarkers",45,
                     "RadarLine",34,
                     "RadarLineFilled",36,
                     "RadarLineMarkers",35,
                     "RadarSmoothLine",37,
                     "RadarSmoothLineMarkers",38,
                     "ScatterLine",25,
                     "ScatterLineFilled",26,
                     "ScatterLineMarkers",24,
                     "ScatterMarkers",21,
                     "ScatterSmoothLine",23,
                     "ScatterSmoothLineMarkers",22,
                     "SmoothLine",12,
                     "SmoothLineMarkers",13,
                     "SmoothLineStacked",14,
                     "SmoothLineStacked100",16,
                     "SmoothLineStacked100Markers",17,
                     "SmoothLineStackedMarkers",15,
                     "StockHLC",39,
                     "StockOHLC",40
     DROP-DOWN-LIST
     SIZE 38 BY 1 NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 119 BY 2.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btSave AT ROW 1.5 COL 9.14
     TpGrafico AT ROW 1.75 COL 43 COLON-ALIGNED
     btTab AT ROW 1.5 COL 3
     btExit AT ROW 1.5 COL 114
     RECT-11 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 121.14 BY 26.63
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
         TITLE              = "Visualizador URL"
         HEIGHT             = 26.63
         WIDTH              = 121.14
         MAX-HEIGHT         = 26.63
         MAX-WIDTH          = 121.14
         VIRTUAL-HEIGHT     = 26.63
         VIRTUAL-WIDTH      = 121.14
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 1.5
       COLUMN          = 66
       HEIGHT          = 1.75
       WIDTH           = 48
       HIDDEN          = no
       SENSITIVE       = yes.

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 4
       COLUMN          = 2
       HEIGHT          = 23.5
       WIDTH           = 119
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {0002E510-0000-0000-C000-000000000046} type: Spreadsheet */
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0002E500-0000-0000-C000-000000000046} type: ChartSpace */
      CtrlFrame:MOVE-AFTER(TpGrafico:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Visualizador URL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Visualizador URL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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


&Scoped-define SELF-NAME btSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSave C-Win
ON CHOOSE OF btSave IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE procname  AS CHARACTER  NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    SYSTEM-DIALOG GET-FILE procname
          ASK-OVERWRITE
          DEFAULT-EXTENSION "htm"
          TITLE      "Salvar relat¢rio..."
          FILTERS    "Arquivos GIF"   "*.gif",
                     "Todos os Arquivos"      "*.*"
          INITIAL-DIR cArquivo
          USE-FILENAME
          SAVE-AS
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:

        SESSION:SET-WAIT-STATE("GENERAL":U).

        chGrafico:ExportPicture(procname,"gif", 800, 600). 

        SESSION:SET-WAIT-STATE("":U).

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btTab
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btTab C-Win
ON CHOOSE OF btTab IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "graftab.w (INPUT TABLE tt-graf-par, INPUT TABLE tt-graf)"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TpGrafico
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TpGrafico C-Win
ON ENTRY OF TpGrafico IN FRAME DEFAULT-FRAME /* Tipo Gr fico */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TpGrafico C-Win
ON LEAVE OF TpGrafico IN FRAME DEFAULT-FRAME /* Tipo Gr fico */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TpGrafico C-Win
ON VALUE-CHANGED OF TpGrafico IN FRAME DEFAULT-FRAME /* Tipo Gr fico */
DO:

    chDesenho:Type = INPUT FRAME {&FRAME-NAME} TpGrafico.
  
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
  IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
      {version.i grafview}
      ASSIGN C-Win:HIDDEN = NO.
      RUN enable_UI.
      RUN initialize.
      IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE closeProg C-Win 
PROCEDURE closeProg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    APPLY "CHOOSE" TO btExit IN FRAME {&FRAME-NAME}.

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

OCXFile = SEARCH( "grafview.wrx":U ).
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
ELSE MESSAGE "grafview.wrx":U SKIP(1)
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
  DISPLAY TpGrafico 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btSave RECT-11 TpGrafico btTab btExit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraGraf C-Win 
PROCEDURE geraGraf :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER cArq AS CHARACTER  NO-UNDO.
    DEFINE INPUT  PARAMETER iX AS INTEGER    NO-UNDO.
    DEFINE INPUT  PARAMETER iY AS INTEGER    NO-UNDO.
    
    chGrafico:ExportPicture(cArq,"gif", iX, iY). 

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

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO INITIAL 2.

    SESSION:SET-WAIT-STATE("image\calc.cur").

    FIND FIRST tt-graf-par.

    ASSIGN TpGrafico = tt-graf-par.tipo.
    DISP TpGrafico WITH FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO TpGrafico IN FRAME {&FRAME-NAME}.
    
    chSequencia1 = chDesenho:SeriesCollection:Add(-1).

    ASSIGN chTitulo:Caption = tt-graf-par.titulo.

    fnGravaDado(1, 1, tt-graf-par.dado-label, "").
    fnGravaDado(1, 2, tt-graf-par.valor-label[1], "").
    IF tt-graf-par.valor-label[2] <> "" THEN DO:
        fnGravaDado(1, 3, tt-graf-par.valor-label[2], "").
        chGrafico:HasChartSpaceLegend = TRUE.
        chGrafico:ChartSpaceLegend:POSITION = chConstantes:chLegendPositionBottom.
    END.
    IF tt-graf-par.valor-label[3] <> "" THEN DO:
        fnGravaDado(1, 4, tt-graf-par.valor-label[3], "").
    END.
    IF tt-graf-par.valor-label[4] <> "" THEN DO:
        fnGravaDado(1, 5, tt-graf-par.valor-label[4], "").
    END.

    /* Dados na Planilha */

    FOR EACH tt-graf:

        fnGravaDado(iCont, 1, tt-graf.dado, "").
        fnGravaDado(iCont, 2, STRING(tt-graf.valor[1]), "").
        fnGravaDado(iCont, 3, STRING(tt-graf.valor[2]), "").
        fnGravaDado(iCont, 4, STRING(tt-graf.valor[3]), "").
        fnGravaDado(iCont, 5, STRING(tt-graf.valor[4]), "").

        ASSIGN iCont = iCont + 1.

    END.

    chSequencia1:SetData(chConstantes:chDimSeriesNames, 0, "B1").
    chSequencia1:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
    chSequencia1:SetData(chConstantes:chDimValues, 0, ("B2:B" + STRING(iCont - 1))).
    IF tt-graf-par.mostra-valores[1] THEN DO:
        chLabels1 = chSequencia1:DataLabelsCollection:ADD().
        chLabels1:HasValue = TRUE.
    END.
    IF tt-graf-par.valor-label[2] <> "" THEN DO:
        chSequencia2 = chDesenho:SeriesCollection:Add(-1).
        chSequencia2:SetData(chConstantes:chDimSeriesNames, 0, "C1").
        chSequencia2:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
        chSequencia2:SetData(chConstantes:chDimValues, 0, ("C2:C" + STRING(iCont - 1))).
        chSequencia2:Interior:COLOR = RGB-VALUE(107,220,169).
        chSequencia2:Line:COLOR = RGB-VALUE(107,220,169).
        IF tt-graf-par.mostra-valores[2] THEN DO:
            chLabels2 = chSequencia2:DataLabelsCollection:ADD().
            chLabels2:HasValue = TRUE.
        END.
    END.
    IF tt-graf-par.valor-label[3] <> "" THEN DO:
        chSequencia3 = chDesenho:SeriesCollection:Add(-1).
        chSequencia3:SetData(chConstantes:chDimSeriesNames, 0, "D1").
        chSequencia3:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
        chSequencia3:SetData(chConstantes:chDimValues, 0, ("D2:D" + STRING(iCont - 1))).
        chSequencia3:Interior:COLOR = RGB-VALUE(29,104,68).
        chSequencia3:LINE:COLOR = RGB-VALUE(29,104,68).
        IF tt-graf-par.mostra-valores[3] THEN DO:
            chLabels3 = chSequencia3:DataLabelsCollection:ADD().
            chLabels3:HasValue = TRUE.
        END.
    END.

    IF tt-graf-par.valor-label[4] <> "" THEN DO:
        chSequencia4 = chDesenho:SeriesCollection:Add(-1).
        chSequencia4:SetData(chConstantes:chDimSeriesNames, 0, "E1").
        chSequencia4:SetData(chConstantes:chDimCategories, 0, ("A2:A" + STRING(iCont - 1))).
        chSequencia4:SetData(chConstantes:chDimValues, 0, ("E2:E" + STRING(iCont - 1))).
        chSequencia4:Interior:COLOR = RGB-VALUE(34,177,76).
        chSequencia4:LINE:COLOR = RGB-VALUE(34,177,76).
        IF tt-graf-par.mostra-valores[4] THEN DO:
            chLabels4 = chSequencia4:DataLabelsCollection:ADD().
            chLabels4:HasValue = TRUE.
        END.
    END.

    IF tt-graf-par.tipo <> 3 THEN DO:
        IF tt-graf-par.tipo < 18
        OR tt-graf-par.tipo > 20 THEN DO:
            chDesenho:Axes:ITEM(1):TickLabelSpacing = IF INT(iCont / 10) > 0 THEN INT(iCont / 10) ELSE 1.
            chSequencia1:Interior:COLOR = RGB-VALUE(49,155,100).
            chSequencia1:Line:Color = RGB-VALUE(49,155,100).
        END.
        ELSE DO:
            chGrafico:HasChartSpaceLegend = TRUE.
        END.
    END.

    SESSION:SET-WAIT-STATE("").

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

ASSIGN CtrlFrame-2:HIDDEN = YES.

ASSIGN chGrafico    = chCtrlFrame:ChartSpace
       chPlanilha   = chCtrlFrame-2:SpreadSheet
       chConstantes = chGrafico:Constants
       chGrafico:HasChartSpaceTitle = TRUE
       chGrafico:HasChartSpaceLegend = FALSE
       chTitulo = chGrafico:ChartSpaceTitle.

       chDesenho = chGrafico:Charts:Add(-1).

       chDesenho:Type = chConstantes:chChartTypeColumnClustered.

       chGrafico:DataSource = chPlanilha.
       chTitulo:Caption = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setPersistent C-Win 
PROCEDURE setPersistent :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN C-Win:HIDDEN = YES.
    RUN control_load.
    RUN initialize.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnGravaDado C-Win 
FUNCTION fnGravaDado RETURNS CHARACTER
  ( i-linha as int, i-coluna as int, c-valor as char, c-formato as CHAR ):

define var c-conversao  as char    no-undo init ?.
define var de-conversao as decimal no-undo init ?.
define var da-conversao as date    no-undo init ?.
define var i-conversao  as integer no-undo init ?.
def var l-ok as logi init no.

if length(c-valor) = 0 or c-formato = "@" then
    assign c-conversao = c-valor.
else do:
    assign de-conversao = decimal(c-valor) no-error.
    assign da-conversao = date(c-valor) no-error.
    assign i-conversao  = integer(c-valor) no-error.
    assign c-conversao  = c-valor no-error.
end.
if c-formato <> "" then
    chPlanilha:Cells(i-linha, i-coluna ):NumberFormat = c-formato.

if da-conversao <> ? then do:    
    if num-entries(c-valor,'/') > 1 then do:
        /* data */
        assign
            chPlanilha:Cells(i-linha, i-coluna ):Value = da-conversao            
            l-ok = yes.
    end.
end.
if de-conversao <> ? and l-ok = no then do:
      /*if decimal(c-valor) = integer(c-valor) then*/ 
      if de-conversao = i-conversao then
          /* inteiro */
          assign
            chPlanilha:Cells(i-linha, i-coluna ):Value = trim(string(i-conversao,"->>>>>>>>>>>>>>9"))
            l-ok = yes.

      else
          /* decimal */
          assign
            chPlanilha:Cells(i-linha, i-coluna ):Value = replace(trim(string(de-conversao,"->>>>>>>>>>>>>>9.99")),",",".")            
            l-ok = yes.

end.
if l-ok = no then do:
    /* caracter */
    assign
        chPlanilha:Cells(i-linha, i-coluna ):Value = c-conversao
        l-ok = yes.
end.

RETURN "".


END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

