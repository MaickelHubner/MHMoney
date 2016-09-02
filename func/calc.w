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

DEFINE INPUT  PARAMETER deInicial AS DECIMAL    NO-UNDO.
DEFINE OUTPUT PARAMETER deValorTotal AS DECIMAL    NO-UNDO.

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cOperacao AS CHARACTER  NO-UNDO.
DEFINE VARIABLE lNovoNum AS LOGICAL    NO-UNDO INITIAL YES.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-12 bt-1 bt-0 bt-pc bt-sub bt-som bt-ret ~
bt-m bt-d bt-c bt-back bt-2 bt-mom bt-pto bt-3 bt-4 bt-7 bt-5 bt-8 bt-6 ~
bt-9 
&Scoped-Define DISPLAYED-OBJECTS most 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-0  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-1  NO-FOCUS FLAT-BUTTON
     LABEL "1" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-2  NO-FOCUS FLAT-BUTTON
     LABEL "2" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-3  NO-FOCUS FLAT-BUTTON
     LABEL "3" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-4  NO-FOCUS FLAT-BUTTON
     LABEL "4" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-5  NO-FOCUS FLAT-BUTTON
     LABEL "5" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-6  NO-FOCUS FLAT-BUTTON
     LABEL "6" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-7  NO-FOCUS FLAT-BUTTON
     LABEL "7" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-8  NO-FOCUS FLAT-BUTTON
     LABEL "8" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-9  NO-FOCUS FLAT-BUTTON
     LABEL "9" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-back  NO-FOCUS FLAT-BUTTON
     LABEL "Back" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-c  NO-FOCUS FLAT-BUTTON
     LABEL "C" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-d  NO-FOCUS FLAT-BUTTON
     LABEL "/" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-m  NO-FOCUS FLAT-BUTTON
     LABEL "*" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-mom  NO-FOCUS FLAT-BUTTON
     LABEL "+/-" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-pc  NO-FOCUS FLAT-BUTTON
     LABEL "%" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-pto  NO-FOCUS FLAT-BUTTON
     LABEL "." 
     SIZE 5 BY 1.

DEFINE BUTTON bt-ret  NO-FOCUS FLAT-BUTTON
     LABEL "=" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-som  NO-FOCUS FLAT-BUTTON
     LABEL "+" 
     SIZE 5 BY 1.

DEFINE BUTTON bt-sub  NO-FOCUS FLAT-BUTTON
     LABEL "-" 
     SIZE 5 BY 1.

DEFINE VARIABLE most AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 22 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 22 BY 5.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bt-1 AT ROW 4.75 COL 3
     most AT ROW 1.5 COL 2 NO-LABEL
     bt-0 AT ROW 5.75 COL 3
     bt-pc AT ROW 6.75 COL 13
     bt-sub AT ROW 4.75 COL 18
     bt-som AT ROW 5.75 COL 18
     bt-ret AT ROW 6.75 COL 18
     bt-m AT ROW 3.75 COL 18
     bt-d AT ROW 2.75 COL 18
     bt-c AT ROW 6.75 COL 3
     bt-back AT ROW 6.75 COL 8
     bt-2 AT ROW 4.75 COL 8
     bt-mom AT ROW 5.75 COL 8
     bt-pto AT ROW 5.75 COL 13
     bt-3 AT ROW 4.75 COL 13
     bt-4 AT ROW 3.75 COL 3
     bt-7 AT ROW 2.75 COL 3
     bt-5 AT ROW 3.75 COL 8
     bt-8 AT ROW 2.75 COL 8
     bt-6 AT ROW 3.75 COL 13
     bt-9 AT ROW 2.75 COL 13
     RECT-12 AT ROW 2.5 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 23.72 BY 7.21
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
         TITLE              = "Calculadora"
         HEIGHT             = 7.21
         WIDTH              = 23.72
         MAX-HEIGHT         = 8.5
         MAX-WIDTH          = 23.72
         VIRTUAL-HEIGHT     = 8.5
         VIRTUAL-WIDTH      = 23.72
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
/* SETTINGS FOR FILL-IN most IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-L                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON % OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-pc IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON * OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-m IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON + OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-som IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON , OF C-Win /* Calculadora */
DO:
    
    APPLY "CHOOSE" TO bt-pto IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON - OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-sub IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON / OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-d IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 0 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-0 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 1 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-1 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 2 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-2 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 3 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-3 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 4 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-4 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 5 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-5 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 6 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-6 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 7 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-7 IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 8 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-8 IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON 9 OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-9 IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON BACKSPACE OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-back IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON c OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-c IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON DELETE-CHARACTER OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-back IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Calculadora */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON HOME OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-c IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON RETURN OF C-Win /* Calculadora */
DO:
  
    APPLY "CHOOSE" TO bt-ret IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Calculadora */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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

ASSIGN most = STRING(deInicial).
ASSIGN deValorTotal = deInicial.

ON "." OF C-Win DO:
  
    APPLY "CHOOSE" TO bt-pto IN FRAME {&FRAME-NAME}.

END.

ON 'CHOOSE':U ANYWHERE
DO:
    DEFINE VARIABLE valor AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE lDec AS LOGICAL    NO-UNDO INITIAL NO.
    DEFINE VARIABLE iNumDec AS INTEGER    NO-UNDO.
    ASSIGN valor = DEC(INPUT FRAME {&FRAME-NAME} most).
    IF NUM-ENTRIES(INPUT FRAME {&FRAME-NAME} most) > 1 THEN DO:
        IF NOT lNovoNum THEN
            ASSIGN lDec = YES
                   iNumDec = LENGTH(ENTRY(2,INPUT FRAME {&FRAME-NAME} most)).
    END.
    CASE SELF:LABEL IN FRAME {&FRAME-NAME}:
        WHEN "=" THEN DO:
            IF NOT lNovoNum THEN
                RUN opera (INPUT valor).
            APPLY "CLOSE" TO THIS-PROCEDURE.
            RETURN "OK".
        END.
        WHEN "C" THEN DO:
            ASSIGN valor = 0.
        END.
        WHEN "Back" THEN DO:
        END.
        WHEN "." THEN DO:
            ASSIGN lDec = YES.
            IF valor = 0 THEN
                ASSIGN lNovoNum = NO.
        END.
        WHEN "+/-" THEN DO:
            ASSIGN valor = (-1) * valor.
        END.
        WHEN "+" THEN DO:
            RUN opera (INPUT valor).
            ASSIGN cOperacao = "+"
                   valor = deValorTotal
                   lNovoNum = YES
                   lDec = NO.
        END.
        WHEN "-" THEN DO:
            RUN opera (INPUT valor).
            ASSIGN cOperacao = "-"
                   valor = deValorTotal
                   lNovoNum = YES
                   lDec = NO.
        END.
        WHEN "*" THEN DO:
            RUN opera (INPUT valor).
            ASSIGN cOperacao = "*"
                   valor = deValorTotal
                   lNovoNum = YES
                   lDec = NO.
        END.
        WHEN "/" THEN DO:
            RUN opera (INPUT valor).
            ASSIGN cOperacao = "/"
                   valor = deValorTotal
                   lNovoNum = YES
                   lDec = NO.
        END.
        WHEN "%" THEN DO:
            ASSIGN cOperacao = "%".
            RUN opera (INPUT valor).
            ASSIGN cOperacao = ""
                   valor = deValorTotal
                   lNovoNum = YES
                   lDec = NO.
        END.
        OTHERWISE DO:
            IF lNovoNum THEN
                ASSIGN valor = 0
                       lNovoNum = NO.
            IF lDec THEN DO:
                IF valor >= 0 THEN
                    ASSIGN valor = valor + (INT(SELF:LABEL IN FRAME {&FRAME-NAME}) / EXP(10,(iNumDec + 1))).
                ELSE
                    ASSIGN valor = valor - (INT(SELF:LABEL IN FRAME {&FRAME-NAME}) / EXP(10,(iNumDec + 1))).
                IF INT(SELF:LABEL IN FRAME {&FRAME-NAME}) = 0 THEN
                    ASSIGN iNumDec = iNumDec + 1.
            END.
            ELSE
                IF valor >= 0 THEN
                    ASSIGN valor = (valor * 10) + INT(SELF:LABEL IN FRAME {&FRAME-NAME}).
                ELSE
                    ASSIGN valor = (valor * 10) - INT(SELF:LABEL IN FRAME {&FRAME-NAME}).
        END.
    END CASE.
    ASSIGN most = STRING(valor).
    IF NUM-ENTRIES(most) = 1
    AND lDec THEN
        ASSIGN most = most + ",".
    IF NUM-ENTRIES(most) = 2
    AND iNumDec > 0 THEN
        ASSIGN most = most + FILL("0",(iNumDec - LENGTH(ENTRY(2,most)))).
    CASE SELF:LABEL IN FRAME {&FRAME-NAME}:
        WHEN "Back" THEN DO:
            IF SUBSTRING(most,(LENGTH(most) - 1),1) <> "," THEN
                ASSIGN most = SUBSTRING(most,1,(LENGTH(most) - 1)).
            ELSE
                ASSIGN most = SUBSTRING(most,1,(LENGTH(most) - 2)).
            ASSIGN deValorTotal = DEC(most).
        END.
        WHEN "." THEN DO:
            IF lNovoNum THEN
                ASSIGN most = "0,"
                       lNovoNum = NO.
        END.
    END CASE.
    IF NUM-ENTRIES(most) > 1 THEN
        IF ENTRY(1,most) = "" THEN
            ASSIGN most = "0" + most.
    DISPLAY most WITH FRAME {&FRAME-NAME}.
END.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY most 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-12 bt-1 bt-0 bt-pc bt-sub bt-som bt-ret bt-m bt-d bt-c bt-back 
         bt-2 bt-mom bt-pto bt-3 bt-4 bt-7 bt-5 bt-8 bt-6 bt-9 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE opera C-Win 
PROCEDURE opera :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER valor AS DECIMAL    NO-UNDO.

IF NOT lNovoNum THEN DO:

    CASE cOperacao:
        WHEN "+" THEN DO:
            ASSIGN deValorTotal = deValorTotal + valor.
        END.
        WHEN "-" THEN DO:
            ASSIGN deValorTotal = deValorTotal - valor.
        END.
        WHEN "*" THEN DO:
            ASSIGN deValorTotal = deValorTotal * valor.
        END.
        WHEN "/" THEN DO:
            ASSIGN deValorTotal = deValorTotal / valor.
        END.
        WHEN "%" THEN DO:
            ASSIGN deValorTotal = (deValorTotal * valor / 100).
        END.
        OTHERWISE DO:
            ASSIGN deValorTotal = valor.
        END.
    END CASE.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

