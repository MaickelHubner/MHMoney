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

DEFINE INPUT  PARAMETER iConta AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER iSeq AS INTEGER    NO-UNDO.

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cFav AS CHARACTER   COLUMN-LABEL "Favorecido"    FORMAT "X(22)" NO-UNDO.
DEFINE VARIABLE cTipo AS CHARACTER  COLUMN-LABEL "Tipo"          FORMAT "X(17)" NO-UNDO.
DEFINE VARIABLE cCat AS CHARACTER   COLUMN-LABEL "Categoria"     FORMAT "X(23)" NO-UNDO.
DEFINE VARIABLE cSub AS CHARACTER   COLUMN-LABEL "Sub-Categoria" FORMAT "X(29)" NO-UNDO.

FIND FIRST mov-conta EXCLUSIVE-LOCK
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.cd-sequencia = iSeq NO-ERROR.
IF NOT AVAIL mov-conta THEN RETURN "NOK".

DEFINE BUFFER bfMov FOR mov-conta.

{seg.i}

DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE pcActionBT AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-Parent   AS ROWID      NO-UNDO.

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
&Scoped-define INTERNAL-TABLES reembolso bfMov conta

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 bfMov.dt-mov fnDesc("F",bfMov.cd-favorecido,0) @ cFav fnDesc("C",bfMov.cod-categoria,0) @ cCat fnDesc("S",bfMov.cod-categoria,bfMov.cd-sub) @ cSub conta.ds-conta bfMov.de-valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define OPEN-QUERY-br-page1 IF mov-conta.de-valor >= 0 THEN DO:     OPEN QUERY {&SELF-NAME}         FOR EACH reembolso NO-LOCK             WHERE reembolso.cd-conta-de     = INPUT FRAME default-frame mov-conta.cd-conta             AND   reembolso.cd-sequencia-de = INPUT FRAME default-frame mov-conta.cd-sequencia, ~
                   EACH bfMov NO-LOCK             WHERE bfMov.cd-conta     = reembolso.cd-conta-para             AND   bfMov.cd-sequencia = reembolso.cd-sequencia-para, ~
                   EACH conta OF bfMov NO-LOCK         BY bfMov.dt-mov. END. ELSE DO:     OPEN QUERY {&SELF-NAME}         FOR EACH reembolso NO-LOCK             WHERE reembolso.cd-conta-para     = INPUT FRAME default-frame mov-conta.cd-conta             AND   reembolso.cd-sequencia-para = INPUT FRAME default-frame mov-conta.cd-sequencia, ~
                   EACH bfMov NO-LOCK             WHERE bfMov.cd-conta     = reembolso.cd-conta-de             AND   bfMov.cd-sequencia = reembolso.cd-sequencia-de, ~
                   EACH conta OF bfMov NO-LOCK         BY bfMov.dt-mov. END.
&Scoped-define TABLES-IN-QUERY-br-page1 reembolso bfMov conta
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 reembolso
&Scoped-define SECOND-TABLE-IN-QUERY-br-page1 bfMov
&Scoped-define THIRD-TABLE-IN-QUERY-br-page1 conta


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-11 btExit br-page1 
&Scoped-Define DISPLAYED-FIELDS mov-conta.cd-conta mov-conta.de-valor ~
mov-conta.dt-mov mov-conta.cd-sequencia 
&Scoped-define DISPLAYED-TABLES mov-conta
&Scoped-define FIRST-DISPLAYED-TABLE mov-conta
&Scoped-Define DISPLAYED-OBJECTS ds-conta de-tot-reemb 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnDesc C-Win 
FUNCTION fnDesc RETURNS CHARACTER
  ( cOp AS CHAR, iInt1 AS INT, iInt2 AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE de-tot-reemb AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total Reembolsado" 
     VIEW-AS FILL-IN 
     SIZE 19 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ds-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 95 BY 2.25.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 95 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-page1 FOR 
      reembolso, 
      bfMov, 
      conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-page1 C-Win _FREEFORM
  QUERY br-page1 NO-LOCK DISPLAY
      bfMov.dt-mov
      fnDesc("F",bfMov.cd-favorecido,0) @ cFav
      fnDesc("C",bfMov.cod-categoria,0) @ cCat
      fnDesc("S",bfMov.cod-categoria,bfMov.cd-sub) @ cSub
      conta.ds-conta FORMAT "X(25)"
      bfMov.de-valor FORMAT "->>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 95 BY 7.29
         FONT 1
         TITLE "Movimentos Reembolsados".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     mov-conta.cd-conta AT ROW 4 COL 8 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-conta AT ROW 4 COL 12.29 COLON-ALIGNED NO-LABEL
     mov-conta.de-valor AT ROW 4 COL 73 COLON-ALIGNED
          LABEL "Valor Movimento"
          VIEW-AS FILL-IN 
          SIZE 19 BY .79
     btExit AT ROW 1.5 COL 90
     mov-conta.dt-mov AT ROW 5 COL 8 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     mov-conta.cd-sequencia AT ROW 5 COL 48.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     de-tot-reemb AT ROW 5 COL 73 COLON-ALIGNED
     br-page1 AT ROW 6.25 COL 2
     RECT-10 AT ROW 1.25 COL 2
     RECT-11 AT ROW 3.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 97.43 BY 12.88
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
         TITLE              = "Movimentos Agrupados"
         HEIGHT             = 12.88
         WIDTH              = 97.43
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 97.43
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 97.43
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
/* BROWSE-TAB br-page1 de-tot-reemb DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN mov-conta.cd-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-reemb IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN mov-conta.de-valor IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN mov-conta.dt-mov IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
IF mov-conta.de-valor >= 0 THEN DO:
    OPEN QUERY {&SELF-NAME}
        FOR EACH reembolso NO-LOCK
            WHERE reembolso.cd-conta-de     = INPUT FRAME default-frame mov-conta.cd-conta
            AND   reembolso.cd-sequencia-de = INPUT FRAME default-frame mov-conta.cd-sequencia,
            EACH bfMov NO-LOCK
            WHERE bfMov.cd-conta     = reembolso.cd-conta-para
            AND   bfMov.cd-sequencia = reembolso.cd-sequencia-para,
            EACH conta OF bfMov NO-LOCK
        BY bfMov.dt-mov.
END.
ELSE DO:
    OPEN QUERY {&SELF-NAME}
        FOR EACH reembolso NO-LOCK
            WHERE reembolso.cd-conta-para     = INPUT FRAME default-frame mov-conta.cd-conta
            AND   reembolso.cd-sequencia-para = INPUT FRAME default-frame mov-conta.cd-sequencia,
            EACH bfMov NO-LOCK
            WHERE bfMov.cd-conta     = reembolso.cd-conta-de
            AND   bfMov.cd-sequencia = reembolso.cd-sequencia-de,
            EACH conta OF bfMov NO-LOCK
        BY bfMov.dt-mov.
END.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Movimentos Agrupados */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Movimentos Agrupados */
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


&Scoped-define BROWSE-NAME br-page1
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
  {version.i movreemb}
  RUN enable_UI.
  RUN initialize.
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
ASSIGN de-tot-reemb = 0.
IF mov-conta.de-valor >= 0 THEN DO:
    FOR EACH reembolso NO-LOCK
        WHERE reembolso.cd-conta-de     = INPUT FRAME default-frame mov-conta.cd-conta
        AND   reembolso.cd-sequencia-de = INPUT FRAME default-frame mov-conta.cd-sequencia,
        EACH bfMov NO-LOCK
        WHERE bfMov.cd-conta     = reembolso.cd-conta-para
        AND   bfMov.cd-sequencia = reembolso.cd-sequencia-para:
        ASSIGN de-tot-reemb = de-tot-reemb + bfMov.de-valor.
    END.
END.
ELSE DO:
    FOR EACH reembolso NO-LOCK
        WHERE reembolso.cd-conta-para     = INPUT FRAME default-frame mov-conta.cd-conta
        AND   reembolso.cd-sequencia-para = INPUT FRAME default-frame mov-conta.cd-sequencia,
        EACH bfMov NO-LOCK
        WHERE bfMov.cd-conta     = reembolso.cd-conta-de
        AND   bfMov.cd-sequencia = reembolso.cd-sequencia-de:
        ASSIGN de-tot-reemb = de-tot-reemb + bfMov.de-valor.
    END.
END.

DISPLAY de-tot-reemb WITH FRAME {&FRAME-NAME}.

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
  DISPLAY ds-conta de-tot-reemb 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE mov-conta THEN 
    DISPLAY mov-conta.cd-conta mov-conta.de-valor mov-conta.dt-mov 
          mov-conta.cd-sequencia 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-10 RECT-11 btExit br-page1 
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

DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

ASSIGN C-Win:TOP-ONLY = YES.
FIND FIRST conta NO-LOCK
    WHERE conta.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta NO-ERROR.
IF AVAIL conta THEN
    ASSIGN ds-conta:SCREEN-VALUE IN FRAME default-frame = conta.ds-conta.

RUN calcula.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnDesc C-Win 
FUNCTION fnDesc RETURNS CHARACTER
  ( cOp AS CHAR, iInt1 AS INT, iInt2 AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO INITIAL "".

    CASE cOp:
        WHEN "F" THEN DO:
            FIND FIRST favorecido NO-LOCK
                WHERE favorecido.cd-favorecido = iInt1 NO-ERROR.
            IF AVAIL favorecido THEN
                ASSIGN cReturn = favorecido.ds-favorecido.
        END.
        WHEN "C" THEN DO:
            FIND FIRST categoria NO-LOCK
                WHERE categoria.cod-categoria = iInt1 NO-ERROR.
            IF AVAIL categoria THEN
                ASSIGN cReturn = categoria.ds-categoria.
        END.
        WHEN "S" THEN DO:
            FIND FIRST sub-cat NO-LOCK
                WHERE sub-cat.cod-categoria = iInt1 
                AND   sub-cat.cd-sub = iInt2 NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN cReturn = sub-cat.ds-sub.
        END.
        WHEN "T" THEN DO:
            FIND FIRST conta NO-LOCK 
                WHERE conta.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta NO-ERROR.
            CASE iInt1:
                WHEN 4 THEN RETURN "Cheque".
                WHEN 1 THEN RETURN "Dep¢sito".
                WHEN 5 THEN RETURN "Pagamento".
                WHEN 6 THEN RETURN "Saque em Dinheiro".
                WHEN 3 THEN RETURN "Transferˆncia".
                WHEN 7 THEN DO:
                    IF conta.dinheiro THEN
                        RETURN "Gasto".
                    ELSE
                        RETURN "D‚bito".
                END.
                WHEN 2 THEN DO:
                    IF conta.dinheiro THEN
                        RETURN "Recebimento".
                    ELSE
                        RETURN "Cr‚dito".
                END.
            END CASE.
        END.
    END CASE.

    RETURN cReturn.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

