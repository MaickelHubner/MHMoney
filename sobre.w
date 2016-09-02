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

/* Local Variable Definitions ---                                       */

{seg.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-1 IMAGE-1 programas aviso versao ~
dt-reg atualiza 
&Scoped-Define DISPLAYED-OBJECTS programas aviso versao dt-reg atualiza 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnMes C-Win 
FUNCTION fnMes RETURNS CHARACTER
  ( cMes AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 AUTO-END-KEY 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "OK" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair"
     FONT 1.

DEFINE VARIABLE aviso AS CHARACTER 
     VIEW-AS EDITOR NO-BOX
     SIZE 61 BY 2
     FONT 11 NO-UNDO.

DEFINE VARIABLE programas AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 61 BY 5.25
     FONT 2 NO-UNDO.

DEFINE VARIABLE atualiza AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 18 BY .67
     FONT 1 NO-UNDO.

DEFINE VARIABLE dt-reg AS DATE FORMAT "99/99/9999":U 
     LABEL "Registrado at‚" 
      VIEW-AS TEXT 
     SIZE 9.86 BY .67 NO-UNDO.

DEFINE VARIABLE versao AS CHARACTER FORMAT "X(256)":U 
     LABEL "VersÆo" 
      VIEW-AS TEXT 
     SIZE 11.29 BY .67 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/mhmoney.bmp":U
     SIZE 19 BY 1.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     BUTTON-1 AT ROW 1.25 COL 56
     programas AT ROW 3.75 COL 2 NO-LABEL
     aviso AT ROW 10.75 COL 2 NO-LABEL
     versao AT ROW 3 COL 30.72 COLON-ALIGNED
     dt-reg AT ROW 9.25 COL 11 COLON-ALIGNED
     atualiza AT ROW 9.25 COL 43 COLON-ALIGNED NO-LABEL
     "Copyrigth ¸ 2002 by Maickel Hubner" VIEW-AS TEXT
          SIZE 27 BY .67 AT ROW 1.5 COL 27
          FONT 1
     "Todos os direitos reservados." VIEW-AS TEXT
          SIZE 20 BY .67 AT ROW 2.25 COL 27
          FONT 1
     "éltima Atualiza‡Æo:" VIEW-AS TEXT
          SIZE 13 BY .67 AT ROW 9.25 COL 31
          FONT 1
     IMAGE-1 AT ROW 1.5 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 63 BY 11.75
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
         TITLE              = "Sobre o MH Money 2002"
         HEIGHT             = 11.75
         WIDTH              = 63
         MAX-HEIGHT         = 15.75
         MAX-WIDTH          = 63
         VIRTUAL-HEIGHT     = 15.75
         VIRTUAL-WIDTH      = 63
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
ASSIGN 
       programas:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Sobre o MH Money 2002 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Sobre o MH Money 2002 */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 C-Win
ON CHOOSE OF BUTTON-1 IN FRAME DEFAULT-FRAME /* OK */
DO:
  
    {func\bt_fechar.i}

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
  {version.i sobre}
  RUN enable_UI.
  RUN initialize.
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
  DISPLAY programas aviso versao dt-reg atualiza 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE BUTTON-1 IMAGE-1 programas aviso versao dt-reg atualiza 
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

DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cAux AS CHARACTER  NO-UNDO.

ASSIGN programas = "PROGRAMA            VERSÇO    DATA" + CHR(13).

INPUT FROM value(search("version")) CONVERT TARGET "ibm850".

REPEAT:
    IMPORT UNFORMATTED cTemp.
    IF cTemp MATCHES("[PRODUTO]*") THEN DO:
        ASSIGN versao = ENTRY(2,cTemp," ").
        ASSIGN atualiza = fnMes(ENTRY(3,cTemp," ")).
    END.
    IF cTemp MATCHES("[PROGRAMA]*") THEN DO:
        ASSIGN programas = programas + CHR(13) + STRING(ENTRY(2,cTemp," "),"X(20)") + STRING(ENTRY(3,cTemp," "),"X(10)") + fnMes(ENTRY(4,cTemp," ")).
    END.
END.

INPUT CLOSE.

ASSIGN aviso = "Aviso: Programa protegido pelas leis e tratados de copyright brasileiros e internacionais sbre direitos autorais. A reprodu‡Æo ou distribui‡Æo sem autoriza‡Æo desse programa, ou parte do mesmo, poder  resultar em san‡äes c¡veis e criminais, de acordo com o m ximo rigor da legisla‡Æo.".

FIND FIRST param-mn NO-LOCK.
ASSIGN dt-reg = DATE(ValidaRegMoney(4, "", param-mn.num-reg)).

DISPLAY versao
        programas
        atualiza
        aviso
        dt-reg WITH FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnMes C-Win 
FUNCTION fnMes RETURNS CHARACTER
  ( cMes AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    
    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.

    ASSIGN cReturn = ENTRY(1,cMes,"/") + " de ".

    CASE ENTRY(2,cMes,"/"):
        WHEN "01" THEN ASSIGN cReturn = cReturn + "Janeiro de ".
        WHEN "02" THEN ASSIGN cReturn = cReturn + "Fevereiro de ".
        WHEN "03" THEN ASSIGN cReturn = cReturn + "Mar‡o de ".
        WHEN "04" THEN ASSIGN cReturn = cReturn + "Abril de ".
        WHEN "05" THEN ASSIGN cReturn = cReturn + "Maio de ".
        WHEN "06" THEN ASSIGN cReturn = cReturn + "Junho de ".
        WHEN "07" THEN ASSIGN cReturn = cReturn + "Julho de ".
        WHEN "08" THEN ASSIGN cReturn = cReturn + "Agosto de ".
        WHEN "09" THEN ASSIGN cReturn = cReturn + "Setembro de ".
        WHEN "10" THEN ASSIGN cReturn = cReturn + "Outubro de ".
        WHEN "11" THEN ASSIGN cReturn = cReturn + "Novembro de ".
        WHEN "12" THEN ASSIGN cReturn = cReturn + "Dezembro de ".
    END CASE.

    ASSIGN cReturn = cReturn + ENTRY(3,cMes,"/").

    RETURN cReturn.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

