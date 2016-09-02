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
DEFINE INPUT  PARAMETER rConta AS ROWID NO-UNDO.

/* Local Variable Definitions ---                                       */

{seg.i}

FIND FIRST conta NO-LOCK
    WHERE ROWID(conta) = rConta.

{cotacao.i}

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
&Scoped-Define ENABLED-OBJECTS btOK IMAGE-1 RECT-10 RECT-7 RECT-8 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS saldo moeda cotacao valor iof ir valor-inv ~
liq luc perc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&OK" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE cotacao AS DECIMAL FORMAT "->>>>,>>>,>>9.999999":U INITIAL 0 
     LABEL "Cota‡Æo" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE VARIABLE iof AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "IOF" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE VARIABLE ir AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "IR" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE VARIABLE liq AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor L¡quido" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79
     BGCOLOR 9 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE luc AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Lucro" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE moeda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moeda" 
     VIEW-AS FILL-IN 
     SIZE 25 BY .79 NO-UNDO.

DEFINE VARIABLE perc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 8 BY .67 NO-UNDO.

DEFINE VARIABLE saldo AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE VARIABLE valor AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE VARIABLE valor-inv AS DECIMAL FORMAT "->>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor Investido" 
     VIEW-AS FILL-IN 
     SIZE 16 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/mhmoney.bmp":U
     SIZE 18 BY 1.75.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 39 BY 3.75.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 39 BY 2.25.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 39 BY 3.75.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 39 BY 3.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btOK AT ROW 1.5 COL 34
     saldo AT ROW 4.25 COL 13 COLON-ALIGNED
     moeda AT ROW 5.25 COL 13 COLON-ALIGNED
     cotacao AT ROW 6.25 COL 13 COLON-ALIGNED
     valor AT ROW 8.25 COL 13 COLON-ALIGNED
     iof AT ROW 9.25 COL 13 COLON-ALIGNED
     ir AT ROW 10.25 COL 13 COLON-ALIGNED
     valor-inv AT ROW 12.25 COL 13 COLON-ALIGNED WIDGET-ID 6
     liq AT ROW 13.25 COL 13 COLON-ALIGNED
     luc AT ROW 14.25 COL 13 COLON-ALIGNED WIDGET-ID 2
     perc AT ROW 14.33 COL 30 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     IMAGE-1 AT ROW 1.5 COL 3
     RECT-10 AT ROW 11.75 COL 2
     RECT-7 AT ROW 1.25 COL 2
     RECT-8 AT ROW 3.75 COL 2
     RECT-9 AT ROW 7.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 40.72 BY 14.75
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
         TITLE              = ""
         COLUMN             = 19
         ROW                = 6.63
         HEIGHT             = 14.75
         WIDTH              = 40.72
         MAX-HEIGHT         = 14.96
         MAX-WIDTH          = 41.29
         VIRTUAL-HEIGHT     = 14.96
         VIRTUAL-WIDTH      = 41.29
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
/* SETTINGS FOR FILL-IN cotacao IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN iof IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ir IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN liq IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN luc IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN moeda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN perc IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN saldo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN valor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN valor-inv IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* OK */
DO:
  
    {func\bt_fechar.i}
    RETURN "OK".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cotacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao C-Win
ON ENTRY OF cotacao IN FRAME DEFAULT-FRAME /* Cota‡Æo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao C-Win
ON LEAVE OF cotacao IN FRAME DEFAULT-FRAME /* Cota‡Æo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cotacao C-Win
ON RETURN OF cotacao IN FRAME DEFAULT-FRAME /* Cota‡Æo */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iof
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iof C-Win
ON ENTRY OF iof IN FRAME DEFAULT-FRAME /* IOF */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iof C-Win
ON LEAVE OF iof IN FRAME DEFAULT-FRAME /* IOF */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iof C-Win
ON RETURN OF iof IN FRAME DEFAULT-FRAME /* IOF */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ir C-Win
ON ENTRY OF ir IN FRAME DEFAULT-FRAME /* IR */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ir C-Win
ON LEAVE OF ir IN FRAME DEFAULT-FRAME /* IR */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ir C-Win
ON RETURN OF ir IN FRAME DEFAULT-FRAME /* IR */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME liq
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL liq C-Win
ON ENTRY OF liq IN FRAME DEFAULT-FRAME /* Valor L¡quido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL liq C-Win
ON LEAVE OF liq IN FRAME DEFAULT-FRAME /* Valor L¡quido */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL liq C-Win
ON RETURN OF liq IN FRAME DEFAULT-FRAME /* Valor L¡quido */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME luc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL luc C-Win
ON ENTRY OF luc IN FRAME DEFAULT-FRAME /* Lucro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL luc C-Win
ON LEAVE OF luc IN FRAME DEFAULT-FRAME /* Lucro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL luc C-Win
ON RETURN OF luc IN FRAME DEFAULT-FRAME /* Lucro */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON ENTRY OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON LEAVE OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME perc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL perc C-Win
ON ENTRY OF perc IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL perc C-Win
ON LEAVE OF perc IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL perc C-Win
ON RETURN OF perc IN FRAME DEFAULT-FRAME
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME saldo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL saldo C-Win
ON ENTRY OF saldo IN FRAME DEFAULT-FRAME /* Saldo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL saldo C-Win
ON LEAVE OF saldo IN FRAME DEFAULT-FRAME /* Saldo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL saldo C-Win
ON RETURN OF saldo IN FRAME DEFAULT-FRAME /* Saldo */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME valor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor C-Win
ON ENTRY OF valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor C-Win
ON LEAVE OF valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor C-Win
ON RETURN OF valor IN FRAME DEFAULT-FRAME /* Valor */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME valor-inv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor-inv C-Win
ON ENTRY OF valor-inv IN FRAME DEFAULT-FRAME /* Valor Investido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor-inv C-Win
ON LEAVE OF valor-inv IN FRAME DEFAULT-FRAME /* Valor Investido */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor-inv C-Win
ON RETURN OF valor-inv IN FRAME DEFAULT-FRAME /* Valor Investido */
DO:

    APPLY "CHOOSE" TO btOK IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

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
  {version.i valliq}
  RUN calcula.
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcula C-Win 
PROCEDURE calcula :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE deCotIni AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deRend AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deIOFMax AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deIOF AS DECIMAL    NO-UNDO.
DEFINE VARIABLE pcIOF AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deRendTot AS DECIMAL    NO-UNDO.
DEFINE VARIABLE pcIR AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deIR AS DECIMAL     NO-UNDO.

ASSIGN saldo = conta.vl-saldo.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.id-situacao <> 3
    AND   mov-conta.agrupado = 0:

    ASSIGN saldo = saldo + mov-conta.de-valor.

END.

FIND FIRST moeda OF conta NO-LOCK.
ASSIGN moeda = moeda.ds-moeda.

FIND FIRST cotacao OF moeda NO-LOCK
    WHERE cotacao.dt-ini <= TODAY
    AND   cotacao.dt-end >= TODAY.

ASSIGN cotacao = cotacao.valor
       valor = saldo * cotacao
       iof = 0
       ir = 0
       valor-inv = 0.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.de-valor > 0:

    ASSIGN deCotIni = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)
           valor-inv = valor-inv + deCotIni.
    CASE (TODAY - mov-conta.dt-mov):
        WHEN 1 THEN ASSIGN pcIOF = 96.    
        WHEN 2 THEN ASSIGN pcIOF = 93.    
        WHEN 3 THEN ASSIGN pcIOF = 90.    
        WHEN 4 THEN ASSIGN pcIOF = 86.    
        WHEN 5 THEN ASSIGN pcIOF = 83.    
        WHEN 6 THEN ASSIGN pcIOF = 80.    
        WHEN 7 THEN ASSIGN pcIOF = 76.    
        WHEN 8 THEN ASSIGN pcIOF = 73.    
        WHEN 9 THEN ASSIGN pcIOF = 70.    
        WHEN 10 THEN ASSIGN pcIOF = 66.    
        WHEN 11 THEN ASSIGN pcIOF = 63.    
        WHEN 12 THEN ASSIGN pcIOF = 60.    
        WHEN 13 THEN ASSIGN pcIOF = 56.    
        WHEN 14 THEN ASSIGN pcIOF = 53.    
        WHEN 15 THEN ASSIGN pcIOF = 50.    
        WHEN 16 THEN ASSIGN pcIOF = 46.    
        WHEN 17 THEN ASSIGN pcIOF = 43.    
        WHEN 18 THEN ASSIGN pcIOF = 40.    
        WHEN 19 THEN ASSIGN pcIOF = 36.    
        WHEN 20 THEN ASSIGN pcIOF = 33.    
        WHEN 21 THEN ASSIGN pcIOF = 30.    
        WHEN 22 THEN ASSIGN pcIOF = 26.    
        WHEN 23 THEN ASSIGN pcIOF = 23.    
        WHEN 24 THEN ASSIGN pcIOF = 20.    
        WHEN 25 THEN ASSIGN pcIOF = 16.    
        WHEN 26 THEN ASSIGN pcIOF = 13.    
        WHEN 27 THEN ASSIGN pcIOF = 10.    
        WHEN 28 THEN ASSIGN pcIOF = 6.    
        WHEN 29 THEN ASSIGN pcIOF = 3.    
        OTHERWISE ASSIGN pcIOF = 0.
    END CASE.

    IF conta.perc-ir = 0 THEN DO:
        IF (TODAY - mov-conta.dt-mov) <= 180 THEN 
            ASSIGN pcIR = 22.5.
        ELSE
            IF (TODAY - mov-conta.dt-mov) <= 366 THEN 
                ASSIGN pcIR = 20.
            ELSE
                IF (TODAY - mov-conta.dt-mov) <= 730 THEN 
                    ASSIGN pcIR = 17.5.
                ELSE
                    ASSIGN pcIR = 15.
    END.
    ELSE DO:
        ASSIGN pcIR = conta.perc-ir.
    END.

    ASSIGN deRend = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,TODAY) - deCotIni
           deIOFMax = ((deRend * pcIOF) / 100)
           deIOF = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,TODAY) * (0.01 * (TODAY - mov-conta.dt-mov)).

    IF deIOFMax < 0 THEN
        ASSIGN deIOFMax = 0.
    IF deIOF < 0 THEN
        ASSIGN deIOF = 0.

    IF deIOF > deIOFMax THEN
        ASSIGN deIOF = deIOFMax.

    ASSIGN iof = iof + deIOF
           deRendTot = deRendTot + deRend
           deIR = (((deRend - deIOF) * pcIR) / 100).

    IF deIR > 0 THEN
        ASSIGN ir = ir + deIR.

END.

FOR EACH sub-cat NO-LOCK 
    WHERE sub-cat.l-ir
    AND   sub-cat.tp-ir = 2:
    FOR EACH mov-conta OF conta NO-LOCK
        WHERE mov-conta.cd-sub = sub-cat.cd-sub:
        ASSIGN ir = ir + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
    END.
END.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.id-tipo = 3 /* Transferˆncia */
    AND   mov-conta.de-valor < 0:

    ASSIGN deCotIni = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov)
           valor-inv = valor-inv + deCotIni.

END.

ASSIGN liq = valor - iof - ir
       luc = liq - valor-inv
       perc = TRIM(STRING(((luc / valor-inv) * 100),"->>>9.99")) + " %".

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
  DISPLAY saldo moeda cotacao valor iof ir valor-inv liq luc perc 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btOK IMAGE-1 RECT-10 RECT-7 RECT-8 RECT-9 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

