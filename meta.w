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

/* Pr‚-processadores */
&GLOBAL-DEFINE Table        meta
&GLOBAL-DEFINE KeyFields    meta.cd-meta
&GLOBAL-DEFINE FrameFields  meta.ds-meta meta.ano ~
                            meta.frequencia meta.formula

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

/* Buffers */

{func\definitions.i}
{func\data.i}

DEFINE TEMP-TABLE tt-metas
    FIELD per AS INT
    FIELD ds-per AS CHAR COLUMN-LABEL "Per¡odo" FORMAT "X(20)"
    FIELD valor AS DEC COLUMN-LABEL "Meta" FORMAT "->>>>>,>>>,>>9.99"
    FIELD calc AS DEC COLUMN-LABEL "Valor Calculado" FORMAT "->>>>>,>>>,>>9.99"
    INDEX idx per.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-per

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-metas meta

/* Definitions for BROWSE br-per                                        */
&Scoped-define FIELDS-IN-QUERY-br-per tt-metas.ds-per tt-metas.valor tt-metas.calc   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-per tt-metas.valor   
&Scoped-define ENABLED-TABLES-IN-QUERY-br-per tt-metas
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br-per tt-metas
&Scoped-define SELF-NAME br-per
&Scoped-define QUERY-STRING-br-per FOR EACH tt-metas
&Scoped-define OPEN-QUERY-br-per OPEN QUERY {&SELF-NAME} FOR EACH tt-metas.
&Scoped-define TABLES-IN-QUERY-br-per tt-metas
&Scoped-define FIRST-TABLE-IN-QUERY-br-per tt-metas


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME meta.formula meta.frequencia ~
meta.cd-meta meta.ds-meta meta.ano 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME meta.formula ~
meta.frequencia meta.cd-meta meta.ds-meta meta.ano 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME meta
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME meta
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-per}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH meta SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH meta SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME meta
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME meta


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS meta.formula meta.frequencia meta.cd-meta ~
meta.ds-meta meta.ano 
&Scoped-define ENABLED-TABLES meta
&Scoped-define FIRST-ENABLED-TABLE meta
&Scoped-Define ENABLED-OBJECTS btGoTo btFirst btLast btNext btPrev btAdd ~
btDel btExit btUpdate btZoom RECT-4 RECT-5 
&Scoped-Define DISPLAYED-FIELDS meta.formula meta.frequencia meta.cd-meta ~
meta.ds-meta meta.ano 
&Scoped-define DISPLAYED-TABLES meta
&Scoped-define FIRST-DISPLAYED-TABLE meta


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnValor C-Win 
FUNCTION fnValor RETURNS CHARACTER
  ( cComp AS CHAR, iFreq AS INT, iMes AS INT, iAno AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD Solve C-Win 
FUNCTION Solve RETURNS DECIMAL
  ( cForm AS CHAR )  FORWARD.

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

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 4.25.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-per FOR 
      tt-metas SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      meta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-per
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-per C-Win _FREEFORM
  QUERY br-per DISPLAY
      tt-metas.ds-per
 tt-metas.valor
 tt-metas.calc
 ENABLE
 tt-metas.valor
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE NO-SCROLLBAR-VERTICAL NO-TAB-STOP SIZE 42.57 BY 10.08
         FONT 7
         TITLE "Metas".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-per AT ROW 8.5 COL 44 WIDGET-ID 100
     meta.formula AT ROW 8.5 COL 2 NO-LABEL WIDGET-ID 14
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 41 BY 10
     meta.frequencia AT ROW 4.5 COL 73 NO-LABEL WIDGET-ID 8
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Mensal", 1,
"Trimestral", 2,
"Semestral", 3,
"Anual", 4
          SIZE 12 BY 3
     btGoTo AT ROW 1.5 COL 48.43
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 18.75 COL 81.14
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 18.75 COL 75
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     meta.cd-meta AT ROW 4.75 COL 16 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     meta.ds-meta AT ROW 5.75 COL 16 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 44 BY .79
     meta.ano AT ROW 6.75 COL 16 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 19.63
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
         TITLE              = "Cadastro de moedas"
         HEIGHT             = 19.63
         WIDTH              = 86.72
         MAX-HEIGHT         = 23.54
         MAX-WIDTH          = 86.72
         VIRTUAL-HEIGHT     = 23.54
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
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br-per 1 DEFAULT-FRAME */
/* SETTINGS FOR BROWSE br-per IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       meta.formula:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-per
/* Query rebuild information for BROWSE br-per
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-metas.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-per */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.meta"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Cadastro de moedas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Cadastro de moedas */
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
    {func\bt_add.i "cd-meta"}
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


&Scoped-define SELF-NAME meta.frequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL meta.frequencia C-Win
ON VALUE-CHANGED OF meta.frequencia IN FRAME DEFAULT-FRAME /* Freq */
DO:
  
    RUN geraTT.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-per
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
  {version.i meta}
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

    FOR EACH tt-metas:
        ASSIGN meta.val-meta[tt-metas.per] = tt-metas.valor.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcValor C-Win 
PROCEDURE calcValor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cFormula AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE cComp AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i-aux AS INTEGER     NO-UNDO.

    SESSION:SET-WAIT-STATE("GENERAL").

    CASE INPUT FRAME {&FRAME-NAME} meta.frequencia:
        WHEN 1 /* Mensal */ THEN DO:
            REPEAT i-aux = 1 TO 12:
                FIND FIRST tt-metas
                    WHERE tt-metas.per = i-aux.
                ASSIGN cFormula = INPUT FRAME {&FRAME-NAME} meta.formula.
                REPEAT WHILE cFormula MATCHES("*[*"):
                    ASSIGN cComp = "[" + ENTRY(1,ENTRY(2, cFormula, "["), "]") + "]"
                           cFormula = REPLACE(cFormula, cComp, fnValor(cComp, INPUT FRAME {&FRAME-NAME} meta.frequencia, i-aux, INPUT FRAME {&FRAME-NAME} meta.ano)).
                END.
                ASSIGN tt-metas.calc = Solve(cFormula).
            END.
        END.
        WHEN 2 /* Trimestral */ THEN DO:
            REPEAT i-aux = 1 TO 4:
                FIND FIRST tt-metas
                    WHERE tt-metas.per = i-aux.
                ASSIGN cFormula = INPUT FRAME {&FRAME-NAME} meta.formula.
                REPEAT WHILE cFormula MATCHES("*[*"):
                    ASSIGN cComp = "[" + ENTRY(1,ENTRY(2, cFormula, "["), "]") + "]"
                           cFormula = REPLACE(cFormula, cComp, fnValor(cComp, INPUT FRAME {&FRAME-NAME} meta.frequencia, i-aux, INPUT FRAME {&FRAME-NAME} meta.ano)).
                END.
                ASSIGN tt-metas.calc = Solve(cFormula).
            END.
        END.
        WHEN 3 /* Semestral */ THEN DO:
            REPEAT i-aux = 1 TO 2:
                FIND FIRST tt-metas
                    WHERE tt-metas.per = i-aux.
                ASSIGN cFormula = INPUT FRAME {&FRAME-NAME} meta.formula.
                REPEAT WHILE cFormula MATCHES("*[*"):
                    ASSIGN cComp = "[" + ENTRY(1,ENTRY(2, cFormula, "["), "]") + "]"
                           cFormula = REPLACE(cFormula, cComp, fnValor(cComp, INPUT FRAME {&FRAME-NAME} meta.frequencia, i-aux, INPUT FRAME {&FRAME-NAME} meta.ano)).
                END.
                ASSIGN tt-metas.calc = Solve(cFormula).
            END.
        END.
        WHEN 4 /* Anual */ THEN DO:
            FIND FIRST tt-metas
                WHERE tt-metas.per = 1.
            ASSIGN cFormula = INPUT FRAME {&FRAME-NAME} meta.formula.
            REPEAT WHILE cFormula MATCHES("*[*"):
                ASSIGN cComp = "[" + ENTRY(1,ENTRY(2, cFormula, "["), "]") + "]"
                       cFormula = REPLACE(cFormula, cComp, fnValor(cComp, INPUT FRAME {&FRAME-NAME} meta.frequencia, i-aux, INPUT FRAME {&FRAME-NAME} meta.ano)).
            END.
            ASSIGN tt-metas.calc = Solve(cFormula).
        END.
    END.

    SESSION:SET-WAIT-STATE("").

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
        ENABLE br-per WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE br-per WITH FRAME {&FRAME-NAME}.
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

    RUN geraTT.

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
  IF AVAILABLE meta THEN 
    DISPLAY meta.formula meta.frequencia meta.cd-meta meta.ds-meta meta.ano 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE meta.formula meta.frequencia btGoTo btFirst btLast btNext btPrev btAdd 
         btDel btExit btUpdate btZoom meta.cd-meta meta.ds-meta meta.ano RECT-4 
         RECT-5 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraTT C-Win 
PROCEDURE geraTT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE i-aux AS INTEGER     NO-UNDO.

    EMPTY TEMP-TABLE tt-metas.

    CASE INPUT FRAME {&FRAME-NAME} meta.frequencia:
        WHEN 1 /* Mensal */ THEN DO:
            REPEAT i-aux = 1 TO 12:
                CREATE tt-metas.
                ASSIGN tt-metas.per = i-aux
                       tt-metas.valor = meta.val-meta[i-aux].
                CASE i-aux:
                    WHEN 1 THEN ASSIGN tt-metas.ds-per = "Janeiro/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 2 THEN ASSIGN tt-metas.ds-per = "Fevereiro/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 3 THEN ASSIGN tt-metas.ds-per = "Mar‡o/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 4 THEN ASSIGN tt-metas.ds-per = "Abril/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 5 THEN ASSIGN tt-metas.ds-per = "Maio/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 6 THEN ASSIGN tt-metas.ds-per = "Junho/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 7 THEN ASSIGN tt-metas.ds-per = "Julho/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 8 THEN ASSIGN tt-metas.ds-per = "Agosto/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 9 THEN ASSIGN tt-metas.ds-per = "Setembro/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 10 THEN ASSIGN tt-metas.ds-per = "Outubro/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 11 THEN ASSIGN tt-metas.ds-per = "Novembro/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                    WHEN 12 THEN ASSIGN tt-metas.ds-per = "Dezembro/" + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
                END CASE.
            END.
        END.
        WHEN 2 /* Trimestral */ THEN DO:
            REPEAT i-aux = 1 TO 4:
                CREATE tt-metas.
                ASSIGN tt-metas.per = i-aux
                       tt-metas.valor = meta.val-meta[i-aux]
                       tt-metas.ds-per = STRING(i-aux,"9") + "ø Trimestre de " + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
            END.
        END.
        WHEN 3 /* Semestral */ THEN DO:
            REPEAT i-aux = 1 TO 2:
                CREATE tt-metas.
                ASSIGN tt-metas.per = i-aux
                       tt-metas.valor = meta.val-meta[i-aux]
                       tt-metas.ds-per = STRING(i-aux,"9") + "ø Semestre de " + STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
            END.
        END.
        WHEN 4 /* Anual */ THEN DO:
            CREATE tt-metas.
            ASSIGN tt-metas.per = 1
                   tt-metas.valor = meta.val-meta[1]
                   tt-metas.ds-per = STRING(INPUT FRAME {&FRAME-NAME} meta.ano, "9999").
        END.
    END.

    RUN calcValor.

    {&OPEN-QUERY-{&BROWSE-NAME}}

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

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-meta NO-LOCK
        WHERE bf-meta.cd-meta = INPUT FRAME {&FRAME-NAME} meta.cd-meta
        AND   ROWID(bf-meta) <> ROWID(meta) NO-ERROR.
    IF AVAIL bf-meta THEN DO:
        {func\valida.i &Mensagem  = "Registro j  casdastrado!"
                       &Ajuda     = "Esse registro j  foi cadastrado anteriormente."}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnValor C-Win 
FUNCTION fnValor RETURNS CHARACTER
  ( cComp AS CHAR, iFreq AS INT, iMes AS INT, iAno AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE de-ret AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE i-nps-p AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-nps-d AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-nps-t AS INTEGER     NO-UNDO.
    DEFINE VARIABLE dtCont AS DATE    NO-UNDO.
    DEFINE VARIABLE de-aux AS DECIMAL     NO-UNDO.

    DEFINE VARIABLE dt-ini AS DATE    NO-UNDO.
    DEFINE VARIABLE dt-fim AS DATE    NO-UNDO.

    CASE iFreq:
        WHEN 1 /* Mensal */ THEN DO:
            ASSIGN dt-ini = DATE(iMes, 1, iAno)
                   dt-fim = fnUltimoDia(iMes, iAno).
        END.
        WHEN 2 /* Trimestral */ THEN DO:
            ASSIGN dt-ini = DATE(((3 * iMes) - 2), 1, iAno)
                   dt-fim = fnUltimoDia((3 * iMes), iAno).
        END.
        WHEN 3 /* Semestral */ THEN DO:
            ASSIGN dt-ini = DATE(((6 * iMes) - 5), 1, iAno)
                   dt-fim = fnUltimoDia((6 * iMes), iAno).
        END.
        WHEN 4 /* Anual */ THEN DO:
            ASSIGN dt-ini = DATE(1, 1, iAno)
                   dt-fim = fnUltimoDia(12, iAno).
        END.
    END CASE.

    CASE cComp:
        WHEN "[NPS]" THEN DO:
            FOR EACH pedido NO-LOCK
                WHERE pedido.dt-lib-homolog >= dt-ini
                AND   pedido.dt-lib-homolog <= dt-fim
                AND   pedido.nps > 0:
                IF pedido.nps >= 9 THEN
                    ASSIGN i-nps-p = i-nps-p + 1
                           i-nps-t = i-nps-t + 1.
                ELSE 
                    IF pedido.nps >= 7 THEN
                        ASSIGN i-nps-t = i-nps-t + 1.
                    ELSE
                        IF pedido.nps > 0 THEN
                            ASSIGN i-nps-d = i-nps-d + 1
                                   i-nps-t = i-nps-t + 1.
            END.
            ASSIGN de-ret = ((i-nps-p / i-nps-t) * 100) - ((i-nps-d / i-nps-t) * 100).
        END.
        WHEN "[RECEITA]" THEN DO:
            FOR EACH mov-conta NO-LOCK
                WHERE mov-conta.dt-mov >= dt-ini
                AND   mov-conta.dt-mov <= dt-fim
                AND   mov-conta.de-valor > 0
                AND   mov-conta.id-tipo <> 0
                AND   mov-conta.id-tipo <> 3:
                ASSIGN de-ret = de-ret + mov-conta.de-valor.
            END.
        END.
        WHEN "[DESPESA]" THEN DO:
            FOR EACH mov-conta NO-LOCK
                WHERE mov-conta.dt-mov >= dt-ini
                AND   mov-conta.dt-mov <= dt-fim
                AND   mov-conta.de-valor < 0
                AND   mov-conta.id-tipo <> 0
                AND   mov-conta.id-tipo <> 3:
                ASSIGN de-ret = de-ret - mov-conta.de-valor.
            END.
        END.
        WHEN "[VISITA_CLI]" THEN DO:
            FOR EACH visita NO-LOCK
                WHERE visita.dt-visita >= dt-ini
                AND   visita.dt-visita <= dt-fim
                AND   NOT visita.compromisso
                AND   visita.cd-favorecido <> 49
                AND   visita.situacao = 8 /* Realizada */
                AND   visita.tipo = 1 /* Cliente */:
                ASSIGN de-ret = de-ret + 1.
            END.
        END.
        WHEN "[VISITA_PRO]" THEN DO:
            FOR EACH visita NO-LOCK
                WHERE visita.dt-visita >= dt-ini
                AND   visita.dt-visita <= dt-fim
                AND   NOT visita.compromisso
                AND   visita.cd-favorecido <> 49
                AND   visita.situacao = 8 /* Realizada */
                AND   visita.tipo = 2 /* Prospect */:
                ASSIGN de-ret = de-ret + 1.
            END.
        END.
        WHEN "[PATRIMON]" THEN DO:
            ASSIGN dtCont = dt-fim.
            FOR EACH bens NO-LOCK
                WHERE (bens.dt-venda > dtCont OR bens.dt-venda = ?)
                AND   bens.bem-pai = 0:
                RUN valorbem.p(INPUT bens.cd-bens,INPUT dtCont, INPUT 0, OUTPUT de-aux).
                ASSIGN de-ret = de-ret + de-aux.
            END.
            RUN patrimon-tot.p (INPUT dtCont, INPUT 0, OUTPUT de-aux).
            ASSIGN de-ret = de-ret + de-aux.
        END.
        WHEN "[ATEND]" THEN DO:
            FOR EACH atendimento NO-LOCK
                WHERE atendimento.data >= dt-ini
                AND   atendimento.data <= dt-fim:
                ASSIGN de-ret = de-ret + 1.
            END.
        END.
    END CASE.
    
    IF de-ret = ? THEN ASSIGN de-ret = 0.

    RETURN STRING(de-ret).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION Solve C-Win 
FUNCTION Solve RETURNS DECIMAL
  ( cForm AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE de-ret AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE cAux1 AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE cAux2 AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE de-aux AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE i-aux AS INTEGER     NO-UNDO.

    REPEAT i-aux = 1 TO 10:
        IF cForm MATCHES("*(*") THEN DO:
            ASSIGN cAux1 = TRIM(ENTRY(1, cForm, ")"))
                   cAux1 = TRIM(ENTRY(NUM-ENTRIES(cAux1, "("), cAux1, "(")).
            ASSIGN de-aux = Solve(cAux1).
            ASSIGN cForm = REPLACE(cForm, "( " + cAux1 + " )", STRING(de-aux)).
        END.
        ELSE DO:
            IF cForm MATCHES("*/*") THEN DO:
                ASSIGN cAux1 = TRIM(ENTRY(1, cForm, "/"))
                       cAux2 = TRIM(ENTRY(2, cForm, "/")).
                ASSIGN de-aux = Solve(cAux1) / Solve(cAux2).
                ASSIGN cForm = REPLACE(cForm, cAux1 + " / " + cAux2, STRING(de-aux)).
            END.
            IF cForm MATCHES("*x*") THEN DO:
                ASSIGN cAux1 = TRIM(ENTRY(1, cForm, "x"))
                       cAux2 = TRIM(ENTRY(2, cForm, "x")).
                ASSIGN de-aux = Solve(cAux1) * Solve(cAux2).
                ASSIGN cForm = REPLACE(cForm, cAux1 + " x " + cAux2, STRING(de-aux)).
            END.
            IF cForm MATCHES("*+*") THEN DO:
                ASSIGN cAux1 = TRIM(ENTRY(1, cForm, "+"))
                       cAux2 = TRIM(ENTRY(2, cForm, "+")).
                ASSIGN de-aux = Solve(cAux1) + Solve(cAux2).
                ASSIGN cForm = REPLACE(cForm, cAux1 + " + " + cAux2, STRING(de-aux)).
            END.
            IF cForm MATCHES("*-*") THEN DO:
                ASSIGN cAux1 = TRIM(ENTRY(1, cForm, "-"))
                       cAux2 = TRIM(ENTRY(2, cForm, "-")).
                ASSIGN de-aux = Solve(cAux1) - Solve(cAux2).
                ASSIGN cForm = REPLACE(cForm, cAux1 + " - " + cAux2, STRING(de-aux)).
            END.
        END.

        IF NOT cForm MATCHES("*(*")
        AND NOT cForm MATCHES("*/*")
        AND NOT cForm MATCHES("*x*")
        AND NOT cForm MATCHES("*+*")
        AND NOT cForm MATCHES("*-*") THEN LEAVE.
    END.

    ASSIGN de-ret = DEC(cForm).

    RETURN de-ret.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

