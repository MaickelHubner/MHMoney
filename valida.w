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

DEFINE shared VARIABLE gcUsuario AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE c-reg-1 AS CHARACTER   NO-UNDO.
{reg.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btConf IMAGE-1 RECT-6 EDITOR-1 chave reg-1 ~
reg-2 reg-3 reg-4 reg-5 reg-6 reg-7 reg-8 btExit 
&Scoped-Define DISPLAYED-OBJECTS EDITOR-1 chave reg-1 reg-2 reg-3 reg-4 ~
reg-5 reg-6 reg-7 reg-8 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btConf 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirma".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE chave AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 63 BY 3.25 NO-UNDO.

DEFINE VARIABLE EDITOR-1 AS CHARACTER INITIAL "Este programa efetua o registro do produto MH Money 2005." 
     VIEW-AS EDITOR NO-BOX
     SIZE 75 BY 4.5
     FGCOLOR 22  NO-UNDO.

DEFINE VARIABLE reg-1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "N£mero de Registro" 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-6 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-7 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE VARIABLE reg-8 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.29 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/mhmoney.bmp":U
     SIZE 18 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 2.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btConf AT ROW 13.75 COL 17
     EDITOR-1 AT ROW 4.25 COL 5 NO-LABEL NO-TAB-STOP 
     chave AT ROW 9 COL 17 NO-LABEL
     reg-1 AT ROW 12.75 COL 15 COLON-ALIGNED
     reg-2 AT ROW 12.75 COL 23 COLON-ALIGNED NO-LABEL
     reg-3 AT ROW 12.75 COL 31 COLON-ALIGNED NO-LABEL
     reg-4 AT ROW 12.75 COL 39 COLON-ALIGNED NO-LABEL
     reg-5 AT ROW 12.75 COL 47 COLON-ALIGNED NO-LABEL
     reg-6 AT ROW 12.75 COL 55 COLON-ALIGNED NO-LABEL
     reg-7 AT ROW 12.75 COL 63 COLON-ALIGNED NO-LABEL
     reg-8 AT ROW 12.75 COL 71 COLON-ALIGNED NO-LABEL
     btExit AT ROW 1.5 COL 74
     "Chave:" VIEW-AS TEXT
          SIZE 5 BY .54 AT ROW 9 COL 11.72
     IMAGE-1 AT ROW 13.75 COL 62
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.43 BY 14.79
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
         TITLE              = "<insert window title>"
         HEIGHT             = 14.79
         WIDTH              = 80.43
         MAX-HEIGHT         = 17.04
         MAX-WIDTH          = 98.57
         VIRTUAL-HEIGHT     = 17.04
         VIRTUAL-WIDTH      = 98.57
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
       EDITOR-1:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btConf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btConf C-Win
ON CHOOSE OF btConf IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE l-OK AS LOGICAL    NO-UNDO INITIAL NO.

    RUN som.p(INPUT "music\click.wav").
    ASSIGN INPUT FRAME {&FRAME-NAME} reg-1 reg-2 reg-3 reg-4 reg-5 reg-6 reg-7 reg-8.

    ASSIGN OVERLAY(param-mn.num-reg,1,4) = reg-1
           OVERLAY(param-mn.num-reg,5,4) = reg-2
           OVERLAY(param-mn.num-reg,9,4) = reg-3
           OVERLAY(param-mn.num-reg,13,4) = reg-4
           OVERLAY(param-mn.num-reg,17,4) = reg-5
           OVERLAY(param-mn.num-reg,21,4) = reg-6
           OVERLAY(param-mn.num-reg,25,4) = reg-7
           OVERLAY(param-mn.num-reg,29,4) = reg-8.

    FOR EACH usuario:
        IF ValidaRegMoney(1, usuario.nome, param-mn.num-reg) = "OK" THEN DO:
            ASSIGN l-OK = YES.
            LEAVE.
        END.
    END.

    IF l-OK THEN DO:
        ASSIGN l-OK = NO.
        FIND FIRST conta NO-LOCK.
        IF ValidaRegMoney(2, conta.ds-conta, param-mn.num-reg) = "OK" THEN DO:
            ASSIGN l-OK = YES.
        END.
        IF l-OK THEN DO:
            ASSIGN l-OK = NO.
            FIND FIRST favorecido.
            IF ValidaRegMoney(3, favorecido.ds-favorecido, param-mn.num-reg) = "OK" THEN DO:
                ASSIGN l-OK = YES.
            END.
            IF l-OK THEN DO:
                ASSIGN l-OK = NO.
                IF DATE(ValidaRegMoney(4, "", param-mn.num-reg)) >= TODAY THEN DO:
                    ASSIGN l-OK = YES.
                END.
            END.
        END.
    END.

    IF l-OK THEN DO:
        IF ValidaRegMoney(5, "", param-mn.num-reg) = "Empresarial" THEN
            ASSIGN param-mn.perfil = 2.
        ELSE
            ASSIGN param-mn.perfil = 1.
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Registro do Produto (031)', INPUT 'MH Money registrado com sucesso!', INPUT 'O MH Money 2005 foi registrado com sucesso.')"}
        APPLY "CLOSE":U TO THIS-PROCEDURE.
    END.
    ELSE DO:
        ASSIGN param-mn.num-reg = FILL(" ",32).
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Registro do Produto (031)', INPUT 'Registro inv†lido!', INPUT 'O MH Money 2005 n∆o foi registrado com sucesso. O N£mero de registro informado n∆o Ç v†lido ou a data expirou.')"}
    END.

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


&Scoped-define SELF-NAME reg-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-1 C-Win
ON ENTRY OF reg-1 IN FRAME DEFAULT-FRAME /* N£mero de Registro */
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-1 C-Win
ON LEAVE OF reg-1 IN FRAME DEFAULT-FRAME /* N£mero de Registro */
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-1 C-Win
ON VALUE-CHANGED OF reg-1 IN FRAME DEFAULT-FRAME /* N£mero de Registro */
DO:
    ASSIGN c-reg-1 = REPLACE(reg-1:SCREEN-VALUE," ","").

    IF LENGTH(c-reg-1) = 32 THEN DO:
        ASSIGN reg-1:SCREEN-VALUE = SUBSTRING(c-reg-1,1,4)
               reg-2:SCREEN-VALUE = SUBSTRING(c-reg-1,5,4)
               reg-3:SCREEN-VALUE = SUBSTRING(c-reg-1,9,4)
               reg-4:SCREEN-VALUE = SUBSTRING(c-reg-1,13,4)
               reg-5:SCREEN-VALUE = SUBSTRING(c-reg-1,17,4)
               reg-6:SCREEN-VALUE = SUBSTRING(c-reg-1,21,4)
               reg-7:SCREEN-VALUE = SUBSTRING(c-reg-1,25,4)
               reg-8:SCREEN-VALUE = SUBSTRING(c-reg-1,29,4).
    END.
    ELSE DO:
        ASSIGN reg-1:SCREEN-VALUE = SUBSTRING(CAPS(reg-1:SCREEN-VALUE),1,4).
        IF LENGTH(reg-1:SCREEN-VALUE) = 4 THEN
            APPLY "ENTRY" TO reg-2.
        ELSE
            reg-1:CURSOR-OFFSET = LENGTH(reg-1:SCREEN-VALUE) + 1.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-2 C-Win
ON ENTRY OF reg-2 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-2 C-Win
ON LEAVE OF reg-2 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-2 C-Win
ON VALUE-CHANGED OF reg-2 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-2:SCREEN-VALUE = SUBSTRING(CAPS(reg-2:SCREEN-VALUE),1,4).
    IF LENGTH(reg-2:SCREEN-VALUE) = 4 THEN
        APPLY "ENTRY" TO reg-3.
    ELSE
        reg-2:CURSOR-OFFSET = LENGTH(reg-2:SCREEN-VALUE) + 1.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-3 C-Win
ON ENTRY OF reg-3 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-3 C-Win
ON LEAVE OF reg-3 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-3 C-Win
ON VALUE-CHANGED OF reg-3 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-3:SCREEN-VALUE = SUBSTRING(CAPS(reg-3:SCREEN-VALUE),1,4).
    IF LENGTH(reg-3:SCREEN-VALUE) = 4 THEN
        APPLY "ENTRY" TO reg-4.
    ELSE
        reg-3:CURSOR-OFFSET = LENGTH(reg-3:SCREEN-VALUE) + 1.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-4 C-Win
ON ENTRY OF reg-4 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-4 C-Win
ON LEAVE OF reg-4 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-4 C-Win
ON VALUE-CHANGED OF reg-4 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-4:SCREEN-VALUE = SUBSTRING(CAPS(reg-4:SCREEN-VALUE),1,4).
    IF LENGTH(reg-4:SCREEN-VALUE) = 4 THEN
        APPLY "ENTRY" TO reg-5.
    ELSE
        reg-4:CURSOR-OFFSET = LENGTH(reg-4:SCREEN-VALUE) + 1.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-5 C-Win
ON ENTRY OF reg-5 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-5 C-Win
ON LEAVE OF reg-5 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-5 C-Win
ON VALUE-CHANGED OF reg-5 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-5:SCREEN-VALUE = SUBSTRING(CAPS(reg-5:SCREEN-VALUE),1,4).
    IF LENGTH(reg-5:SCREEN-VALUE) = 4 THEN
        APPLY "ENTRY" TO reg-6.
    ELSE
        reg-5:CURSOR-OFFSET = LENGTH(reg-5:SCREEN-VALUE) + 1.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-6 C-Win
ON ENTRY OF reg-6 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-6 C-Win
ON LEAVE OF reg-6 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-6 C-Win
ON VALUE-CHANGED OF reg-6 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-6:SCREEN-VALUE = SUBSTRING(CAPS(reg-6:SCREEN-VALUE),1,4).
    IF LENGTH(reg-6:SCREEN-VALUE) = 4 THEN
        APPLY "ENTRY" TO reg-7.
    ELSE
        reg-6:CURSOR-OFFSET = LENGTH(reg-6:SCREEN-VALUE) + 1.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-7 C-Win
ON ENTRY OF reg-7 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-7 C-Win
ON LEAVE OF reg-7 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-7 C-Win
ON VALUE-CHANGED OF reg-7 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-7:SCREEN-VALUE = SUBSTRING(CAPS(reg-7:SCREEN-VALUE),1,4).
    IF LENGTH(reg-7:SCREEN-VALUE) = 4 THEN
        APPLY "ENTRY" TO reg-8.
    ELSE
        reg-7:CURSOR-OFFSET = LENGTH(reg-7:SCREEN-VALUE) + 1.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME reg-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-8 C-Win
ON ENTRY OF reg-8 IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-8 C-Win
ON LEAVE OF reg-8 IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL reg-8 C-Win
ON VALUE-CHANGED OF reg-8 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN reg-8:SCREEN-VALUE = SUBSTRING(CAPS(reg-8:SCREEN-VALUE),1,4).
    reg-8:CURSOR-OFFSET = LENGTH(reg-8:SCREEN-VALUE) + 1.
  
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
  {version.i valida}
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
  DISPLAY EDITOR-1 chave reg-1 reg-2 reg-3 reg-4 reg-5 reg-6 reg-7 reg-8 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btConf IMAGE-1 RECT-6 EDITOR-1 chave reg-1 reg-2 reg-3 reg-4 reg-5 
         reg-6 reg-7 reg-8 btExit 
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

    FIND FIRST param-mn.

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iAsc AS INTEGER    NO-UNDO.

    ASSIGN editor-1:SCREEN-VALUE IN FRAME {&FRAME-NAME} = editor-1:SCREEN-VALUE IN FRAME {&FRAME-NAME} + CHR(13) +
           "Se vocà n∆o tiver um n£mero de registro, envie o conte£do do campo CHAVE abaixo para " +
           "maickel.hubner@gmail.com solicitando um. ê importante se certificar de ter copiado todo o conte£do do campo (algumas partes do conte£do podem n∆o ser mostradas em tela) para evitar problemas futuros. Posicione o cursor no in°cio do campo e pressione as teclas SHIFT + END para selecion†-lo inteiro." + CHR(13) +
           "Em alguns dias vocà receber† um e-mail contendo um n£mero de registro que deve ser informado abaixo. Ap¢s Ç necess†rio clicar no bot∆o confirma.".

    FIND FIRST usuario WHERE usuario.administrador NO-LOCK NO-ERROR.
    FIND FIRST conta NO-LOCK NO-ERROR.
    FIND FIRST favorecido NO-LOCK NO-ERROR.

    ASSIGN chave = Converte(usuario.nome).
    ASSIGN chave = chave + "300" + Converte(conta.ds-conta).
    ASSIGN chave = chave + "300" + Converte(favorecido.ds-favorecido).

    ASSIGN reg-1 = SUBSTRING(param-mn.num-reg,1,4)
           reg-2 = SUBSTRING(param-mn.num-reg,5,4)
           reg-3 = SUBSTRING(param-mn.num-reg,9,4)
           reg-4 = SUBSTRING(param-mn.num-reg,13,4)
           reg-5 = SUBSTRING(param-mn.num-reg,17,4)
           reg-6 = SUBSTRING(param-mn.num-reg,21,4)
           reg-7 = SUBSTRING(param-mn.num-reg,25,4)
           reg-8 = SUBSTRING(param-mn.num-reg,29,4).

    DISPLAY chave
            reg-1
            reg-2
            reg-3
            reg-4
            reg-5
            reg-6
            reg-7
            reg-8 WITH FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

