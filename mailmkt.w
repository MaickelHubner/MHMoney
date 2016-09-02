&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

/* Local Variable Definitions ---                                       */

{seg.i}

DEFINE TEMP-TABLE tt-clientes LIKE favorecido
    FIELD enviar AS LOG INITIAL TRUE.

DEFINE TEMP-TABLE tt-contatos LIKE contato
    FIELD para AS LOG
    FIELD cc AS LOG INITIAL TRUE
    FIELD cco AS LOG.

DEFINE BUFFER bf-cli FOR tt-clientes.
DEFINE BUFFER bf-cont FOR tt-contatos.

DEFINE VARIABLE chProgressBar       AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE c-mail AS CHARACTER   NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-cli

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-clientes tt-contatos

/* Definitions for BROWSE br-cli                                        */
&Scoped-define FIELDS-IN-QUERY-br-cli tt-clientes.enviar tt-clientes.cd-favorecido tt-clientes.ds-favorecido tt-clientes.cidade tt-clientes.estado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-cli tt-clientes.enviar   
&Scoped-define ENABLED-TABLES-IN-QUERY-br-cli tt-clientes
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br-cli tt-clientes
&Scoped-define SELF-NAME br-cli
&Scoped-define QUERY-STRING-br-cli FOR EACH tt-clientes
&Scoped-define OPEN-QUERY-br-cli OPEN QUERY {&SELF-NAME} FOR EACH tt-clientes.
&Scoped-define TABLES-IN-QUERY-br-cli tt-clientes
&Scoped-define FIRST-TABLE-IN-QUERY-br-cli tt-clientes


/* Definitions for BROWSE br-cont                                       */
&Scoped-define FIELDS-IN-QUERY-br-cont tt-contatos.para tt-contatos.cc tt-contatos.cco tt-contatos.nome tt-contatos.email tt-contatos.cargo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-cont tt-contatos.para   tt-contatos.cc   tt-contatos.cco   
&Scoped-define ENABLED-TABLES-IN-QUERY-br-cont tt-contatos
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br-cont tt-contatos
&Scoped-define SELF-NAME br-cont
&Scoped-define QUERY-STRING-br-cont FOR EACH tt-contatos OF tt-clientes
&Scoped-define OPEN-QUERY-br-cont OPEN QUERY {&SELF-NAME} FOR EACH tt-contatos OF tt-clientes.
&Scoped-define TABLES-IN-QUERY-br-cont tt-contatos
&Scoped-define FIRST-TABLE-IN-QUERY-br-cont tt-contatos


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-cli}~
    ~{&OPEN-QUERY-br-cont}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-5 btAtu RECT-12 RECT-13 br-cli br-cont ~
bt-gerar i-de i-ate c-texto btExit c-nome c-email c-senha c-celular i-ramal ~
c-skype c-para c-cc c-cco c-assunto l-cliente-assunt bt-proc c-anexo ~
l-gera-atendimento 
&Scoped-Define DISPLAYED-OBJECTS i-de i-ate c-texto c-nome c-email c-senha ~
c-celular i-ramal c-skype c-para c-cc c-cco c-assunto l-cliente-assunt ~
c-anexo l-gera-atendimento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-gerar 
     LABEL "Gerar" 
     SIZE 10 BY 1.

DEFINE BUTTON bt-proc 
     LABEL "Procurar" 
     SIZE 10 BY 1.

DEFINE BUTTON btAtu 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Atu" 
     SIZE 6.14 BY 1.79 TOOLTIP "Atualizar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE c-texto AS CHARACTER INITIAL "Use [CONTATO:APELIDO] para referenciar o contato do cliente" 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 89 BY 11.75 NO-UNDO.

DEFINE VARIABLE c-anexo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Arquivo Anexo" 
     VIEW-AS FILL-IN 
     SIZE 38 BY .79 NO-UNDO.

DEFINE VARIABLE c-assunto AS CHARACTER FORMAT "X(256)":U 
     LABEL "Assunto" 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE c-cc AS CHARACTER FORMAT "X(256)":U 
     LABEL "C¢pia" 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE c-cco AS CHARACTER FORMAT "X(256)":U 
     LABEL "C¢pia Oculta" 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE c-celular AS CHARACTER FORMAT "X(256)":U 
     LABEL "Celular" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79 NO-UNDO.

DEFINE VARIABLE c-email AS CHARACTER FORMAT "X(256)":U 
     LABEL "E-mail" 
     VIEW-AS FILL-IN 
     SIZE 28 BY .79 NO-UNDO.

DEFINE VARIABLE c-nome AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nome" 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE c-para AS CHARACTER FORMAT "X(256)":U 
     LABEL "Para" 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE c-senha AS CHARACTER FORMAT "X(256)":U 
     LABEL "Senha" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .79 NO-UNDO.

DEFINE VARIABLE c-skype AS CHARACTER FORMAT "X(256)":U 
     LABEL "Skype" 
     VIEW-AS FILL-IN 
     SIZE 22 BY .79 NO-UNDO.

DEFINE VARIABLE i-ate AS INTEGER FORMAT ">>>9":U INITIAL 9999 
     LABEL "at‚ c¢digo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .79 NO-UNDO.

DEFINE VARIABLE i-de AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "De c¢digo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .79 NO-UNDO.

DEFINE VARIABLE i-ramal AS INTEGER FORMAT "99":U INITIAL 0 
     LABEL "Ramal" 
     VIEW-AS FILL-IN 
     SIZE 3 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 61 BY 7.75.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 61 BY 3.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 151 BY 2.25.

DEFINE VARIABLE l-cliente-assunt AS LOGICAL INITIAL yes 
     LABEL "Incluir Cliente no Assunto" 
     VIEW-AS TOGGLE-BOX
     SIZE 20 BY .83 NO-UNDO.

DEFINE VARIABLE l-gera-atendimento AS LOGICAL INITIAL yes 
     LABEL "Gerar Atendimento para o envio" 
     VIEW-AS TOGGLE-BOX
     SIZE 25 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-cli FOR 
      tt-clientes SCROLLING.

DEFINE QUERY br-cont FOR 
      tt-contatos SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-cli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-cli C-Win _FREEFORM
  QUERY br-cli DISPLAY
      tt-clientes.enviar COLUMN-LABEL "" VIEW-AS TOGGLE-BOX
 tt-clientes.cd-favorecido COLUMN-LABEL "C¢digo"
 tt-clientes.ds-favorecido COLUMN-LABEL "Cliente" WIDTH 20
 tt-clientes.cidade
 tt-clientes.estado
     ENABLE
     tt-clientes.enviar
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 61 BY 10.25
         FONT 1
         TITLE "Clientes".

DEFINE BROWSE br-cont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-cont C-Win _FREEFORM
  QUERY br-cont DISPLAY
      tt-contatos.para COLUMN-LABEL "Para" WIDTH 6 VIEW-AS TOGGLE-BOX
     tt-contatos.cc COLUMN-LABEL "C¢pia" WIDTH 6 VIEW-AS TOGGLE-BOX
     tt-contatos.cco COLUMN-LABEL "COculta" WIDTH 6 VIEW-AS TOGGLE-BOX
     tt-contatos.nome WIDTH 20
     tt-contatos.email WIDTH 30
     tt-contatos.cargo WIDTH 15
     ENABLE
     tt-contatos.para
     tt-contatos.cc
     tt-contatos.cco
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 89 BY 10.25
         FONT 1
         TITLE "Contatos do Cliente".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAtu AT ROW 1.5 COL 3
     br-cli AT ROW 3.75 COL 2 WIDGET-ID 100
     br-cont AT ROW 3.75 COL 64 WIDGET-ID 200
     bt-gerar AT ROW 14 COL 2 WIDGET-ID 2
     i-de AT ROW 14.13 COL 20 COLON-ALIGNED WIDGET-ID 32
     i-ate AT ROW 14.13 COL 35 COLON-ALIGNED WIDGET-ID 30
     c-texto AT ROW 15.25 COL 64 NO-LABEL WIDGET-ID 16
     btExit AT ROW 1.5 COL 146
     c-nome AT ROW 15.75 COL 12 COLON-ALIGNED WIDGET-ID 36
     c-email AT ROW 16.75 COL 12 COLON-ALIGNED WIDGET-ID 38
     c-senha AT ROW 16.75 COL 46 COLON-ALIGNED WIDGET-ID 40
     c-celular AT ROW 17.75 COL 12 COLON-ALIGNED WIDGET-ID 42
     i-ramal AT ROW 17.75 COL 29 COLON-ALIGNED WIDGET-ID 44
     c-skype AT ROW 17.75 COL 38 COLON-ALIGNED WIDGET-ID 46
     c-para AT ROW 19.75 COL 12 COLON-ALIGNED WIDGET-ID 6
     c-cc AT ROW 20.75 COL 12 COLON-ALIGNED WIDGET-ID 8
     c-cco AT ROW 21.75 COL 12 COLON-ALIGNED WIDGET-ID 10
     c-assunto AT ROW 22.75 COL 12 COLON-ALIGNED WIDGET-ID 12
     l-cliente-assunt AT ROW 23.75 COL 14 WIDGET-ID 14
     bt-proc AT ROW 24.67 COL 52 WIDGET-ID 26
     c-anexo AT ROW 24.75 COL 12 COLON-ALIGNED WIDGET-ID 24
     l-gera-atendimento AT ROW 25.75 COL 14 WIDGET-ID 22
     "Texto do E-mail:" VIEW-AS TEXT
          SIZE 12 BY .54 AT ROW 14.5 COL 64 WIDGET-ID 18
     RECT-5 AT ROW 1.25 COL 2
     RECT-12 AT ROW 19.25 COL 2 WIDGET-ID 4
     RECT-13 AT ROW 15.25 COL 2 WIDGET-ID 34
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 153 BY 26.21
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
         HEIGHT             = 26.21
         WIDTH              = 153
         MAX-HEIGHT         = 26.21
         MAX-WIDTH          = 156.72
         VIRTUAL-HEIGHT     = 26.21
         VIRTUAL-WIDTH      = 156.72
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
/* BROWSE-TAB br-cli RECT-13 DEFAULT-FRAME */
/* BROWSE-TAB br-cont br-cli DEFAULT-FRAME */
ASSIGN 
       c-texto:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-cli
/* Query rebuild information for BROWSE br-cli
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-clientes.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-cli */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-cont
/* Query rebuild information for BROWSE br-cont
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-contatos OF tt-clientes.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-cont */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 1.75
       COLUMN          = 11
       HEIGHT          = 1.25
       WIDTH           = 133
       WIDGET-ID       = 28
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


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


&Scoped-define BROWSE-NAME br-cli
&Scoped-define SELF-NAME br-cli
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-cli C-Win
ON SHIFT-DEL OF br-cli IN FRAME DEFAULT-FRAME /* Clientes */
DO:
    DEFINE BUFFER bf-cli FOR tt-clientes.
  
    IF AVAIL tt-clientes THEN DO:
        FIND FIRST bf-cli OF tt-clientes.
        FIND NEXT bf-cli NO-ERROR.
        IF NOT AVAIL bf-cli THEN DO:
            FIND FIRST bf-cli OF tt-clientes.
            FIND PREV bf-cli NO-ERROR.
        END.
        FOR EACH tt-contatos OF tt-clientes:
            DELETE tt-contatos.
        END.
        DELETE tt-clientes.
        {&OPEN-QUERY-br-cli}
        IF AVAIL bf-cli THEN DO:
            REPOSITION br-cli TO ROWID ROWID(bf-cli).
        END.
        APPLY "VALUE-CHANGED" TO br-cli.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-cli C-Win
ON VALUE-CHANGED OF br-cli IN FRAME DEFAULT-FRAME /* Clientes */
DO:
    {&OPEN-QUERY-br-cont}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-cont
&Scoped-define SELF-NAME br-cont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-cont C-Win
ON SHIFT-DEL OF br-cont IN FRAME DEFAULT-FRAME /* Contatos do Cliente */
DO:
    DEFINE BUFFER bf-cont FOR tt-contatos.
  
    IF AVAIL tt-contatos THEN DO:
        FIND FIRST bf-cont OF tt-contatos.
        FIND NEXT bf-cont NO-ERROR.
        IF NOT AVAIL bf-cont THEN DO:
            FIND FIRST bf-cont OF tt-contatos.
            FIND PREV bf-cont NO-ERROR.
        END.
        DELETE tt-contatos.
        {&OPEN-QUERY-br-cont}
        IF AVAIL bf-cont THEN DO:
            REPOSITION br-cont TO ROWID ROWID(bf-cont).
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-gerar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-gerar C-Win
ON CHOOSE OF bt-gerar IN FRAME DEFAULT-FRAME /* Gerar */
DO:
    ASSIGN INPUT FRAME {&FRAME-NAME} i-de i-ate.

    EMPTY TEMP-TABLE tt-clientes.
    EMPTY TEMP-TABLE tt-contatos.
  
    FOR EACH favorecido NO-LOCK
        WHERE favorecido.ativo
        AND   favorecido.tipo <> 2
        AND   favorecido.cd-favorecido >= i-de
        AND   favorecido.cd-favorecido <= i-ate:
        FIND LAST atendimento OF favorecido NO-LOCK
            WHERE atendimento.contato <> "" NO-ERROR.
        FOR EACH contato OF favorecido NO-LOCK
            WHERE contato.ativo
            AND   contato.email <> "":
            CREATE tt-contatos.
            BUFFER-COPY contato TO tt-contatos.
            IF AVAIL atendimento AND atendimento.contato = contato.nome THEN DO:
                ASSIGN tt-contatos.para = TRUE
                       tt-contatos.cc = FALSE.
            END.
        END.
        IF AVAIL tt-contatos AND tt-contatos.cd-favorecido = favorecido.cd-favorecido THEN DO:
            CREATE tt-clientes.
            BUFFER-COPY favorecido TO tt-clientes.
        END.
    END.
    {&OPEN-QUERY-br-cli}
    {&OPEN-QUERY-br-cont}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt-proc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-proc C-Win
ON CHOOSE OF bt-proc IN FRAME DEFAULT-FRAME /* Procurar */
DO:
    DEF VAR cFile AS CHAR NO-UNDO.
    DEF VAR l-ok  AS LOGICAL NO-UNDO.

    ASSIGN c-anexo = INPUT FRAME {&FRAME-NAME} c-anexo.
    SYSTEM-DIALOG GET-FILE cFile
       FILTERS "Todos os Arquivos" "*.*"
       MUST-EXIST
       USE-FILENAME
       UPDATE l-ok.
    IF  l-ok then
        ASSIGN c-anexo:SCREEN-VALUE IN FRAME {&FRAME-NAME}  = cFile. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAtu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAtu C-Win
ON CHOOSE OF btAtu IN FRAME DEFAULT-FRAME /* Atu */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Envio de Campanha (063)', INPUT 'Confirma envio de e-mail?', INPUT 'Confirme o envio imediato dos e-mails conforme parƒmetros informados em tela.')"}
    IF RETURN-VALUE = "OK":U THEN DO:
        RUN enviaEmail.
        IF RETURN-VALUE <> "NOK" THEN DO:
            {&OPEN-QUERY-br-cli}
            {&OPEN-QUERY-br-cont}
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Envio de Campanha (063)', INPUT 'E-mails enviados com sucesso!', INPUT 'Os e-mails com a campanha configurada foram enviados para os clientes e contatos marcados.')"}
        END.
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


&Scoped-define BROWSE-NAME br-cli
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
  {version.i mailmkt}
  RUN initialize.
  RUN enable_UI.
  RUN displayFields.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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

OCXFile = SEARCH( "mailmkt.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "mailmkt.wrx":U SKIP(1)
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN chProgressBar = chctrlframe:ProgressBar.
    chProgressBar:VISIBLE = FALSE.

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
  DISPLAY i-de i-ate c-texto c-nome c-email c-senha c-celular i-ramal c-skype 
          c-para c-cc c-cco c-assunto l-cliente-assunt c-anexo 
          l-gera-atendimento 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-5 btAtu RECT-12 RECT-13 br-cli br-cont bt-gerar i-de i-ate 
         c-texto btExit c-nome c-email c-senha c-celular i-ramal c-skype c-para 
         c-cc c-cco c-assunto l-cliente-assunt bt-proc c-anexo 
         l-gera-atendimento 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enviaEmail C-Win 
PROCEDURE enviaEmail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE c-linha AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i-cont AS INTEGER     NO-UNDO.

    FOR EACH bf-cli
        WHERE bf-cli.enviar:
        IF NOT CAN-FIND(FIRST bf-cont OF bf-cli
                        WHERE bf-cont.para) THEN DO:
            REPOSITION br-cli TO ROWID ROWID(bf-cli).
            APPLY "VALUE-CHANGED" TO br-cli IN FRAME {&FRAME-NAME}.
            {func\valida.i &Mensagem  = "Cliente sem contato de envio em Para!"
                           &Ajuda     = "Vocˆ deve marcar ao menos um contato do cliente para ser enviado como destinat rio da mensagem (campo Para)."
                           &Campo     = br-cli}
            RETURN "NOK".
        END.
        ASSIGN i-cont = i-cont + 1.
    END.

    IF i-cont <= 0 THEN DO:
        {func\valida.i &Mensagem  = "Nenhum cliente marcado!"
                       &Ajuda     = "Vocˆ deve marcar ao menos um cliente antes de disparar o envio de e-mails."
                       &Campo     = br-cli}
        RETURN "NOK".
    END.

    SESSION:SET-WAIT-STATE("image\calc.cur").

    ASSIGN chProgressBar:VISIBLE = TRUE
           chProgressBar:MAX = i-cont
           chProgressBar:VALUE = 0.

    ASSIGN INPUT FRAME {&FRAME-NAME} c-nome c-email c-senha c-celular i-ramal c-skype c-para c-cc c-cco c-assunto l-cliente-assunt c-anexo l-gera-atendimento c-texto.

    ASSIGN c-texto = REPLACE(c-texto, CHR(10), "<br>").
    ASSIGN c-texto = REPLACE(c-texto, CHR(13), "<br>").

    FOR EACH bf-cli
        WHERE bf-cli.enviar:

        ASSIGN chProgressBar:VALUE = chProgressBar:VALUE + 1.

        ASSIGN c-mail = c-texto.

        FIND FIRST bf-cont OF bf-cli
            WHERE bf-cont.para NO-ERROR.
        IF NOT AVAIL bf-cont THEN NEXT.

        ASSIGN c-mail = REPLACE(c-mail, "[CONTATO:APELIDO]", bf-cont.nome-apelido).

        OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "mailmkt.txt") CONVERT TARGET "iso8859-1".
        INPUT FROM VALUE(SEARCH("mailmkt.htm")).
        REPEAT:
            IMPORT UNFORMATTED c-linha.
            IF c-linha MATCHES("*[TEXTO]*") THEN DO:
                ASSIGN c-linha = REPLACE(c-linha, "[TEXTO]", c-mail).
            END.
            IF c-linha MATCHES("*[NOME]*") THEN DO:
                ASSIGN c-linha = REPLACE(c-linha, "[NOME]", c-nome).
            END.
            IF c-linha MATCHES("*[E-MAIL]*") THEN DO:
                ASSIGN c-linha = REPLACE(c-linha, "[E-MAIL]", c-email).
            END.
            IF c-linha MATCHES("*[CELULAR]*") THEN DO:
                ASSIGN c-linha = REPLACE(c-linha, "[CELULAR]", c-celular).
            END.
            IF c-linha MATCHES("*[RAMAL]*") THEN DO:
                ASSIGN c-linha = REPLACE(c-linha, "[RAMAL]", STRING(i-ramal, "99")).
            END.
            IF c-linha MATCHES("*[SKYPE]*") THEN DO:
                ASSIGN c-linha = REPLACE(c-linha, "[SKYPE]", c-skype).
            END.
            PUT UNFORMATTED c-linha.
        END.
        INPUT CLOSE.
        OUTPUT CLOSE.

        RUN pi-blat.

    END.

    chProgressBar:VISIBLE = FALSE.

    SESSION:SET-WAIT-STATE("").

    RETURN "OK".

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

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pi-blat C-Win 
PROCEDURE pi-blat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-cod-lin-comando AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE c-ass-aux AS CHARACTER   NO-UNDO.

    IF NOT AVAIL bf-cli OR NOT CAN-FIND(FIRST bf-cont OF bf-cli) THEN 
        RETURN "NOK".

    ASSIGN INPUT FRAME {&FRAME-NAME} c-para c-cc c-cco.

    FOR EACH bf-cont OF bf-cli
        WHERE bf-cont.para:
        IF c-para = "" THEN
            ASSIGN c-para = bf-cont.email.
        ELSE
            ASSIGN c-para = c-para + "," + bf-cont.email.
    END.

    FOR EACH bf-cont OF bf-cli
        WHERE bf-cont.cc:
        IF c-cc = "" THEN
            ASSIGN c-cc = bf-cont.email.
        ELSE
            ASSIGN c-cc = c-cc + "," + bf-cont.email.
    END.

    FOR EACH bf-cont OF bf-cli
        WHERE bf-cont.cco:
        IF c-cco = "" THEN
            ASSIGN c-cco = bf-cont.email.
        ELSE
            ASSIGN c-cco = c-cco + "," + bf-cont.email.
    END.

    ASSIGN c-para = TRIM(REPLACE(REPLACE(c-para, ";", ","), " ", ""))
           c-cc = TRIM(REPLACE(REPLACE(c-cc, ";", ","), " ", ""))
           c-cco = TRIM(REPLACE(REPLACE(c-cco, ";", ","), " ", "")).

    /*ASSIGN c-para = "maickel@otimasis.com"
           c-cc = ""
           c-cco = "".*/

    ASSIGN c-ass-aux = c-assunto.
    IF l-cliente-assunt THEN 
        ASSIGN c-ass-aux = c-ass-aux + " - " + TRIM(bf-cli.ds-favorecido).

    ASSIGN v-cod-lin-comando = "blat.exe"
                               + " "
                               + "~"" + SESSION:TEMP-DIRECTORY + "mailmkt.txt" + "~""
                               + " -s" 
                               + ' "' 
                               + c-ass-aux
                               + '"' 
                               + " -t " 
                               + c-para.

    IF c-cc <> "" THEN
        ASSIGN v-cod-lin-comando = v-cod-lin-comando 
                                   + " -cc " 
                                   + c-cc.

    IF c-cco <> "" THEN
        ASSIGN v-cod-lin-comando = v-cod-lin-comando 
                                   + " -bcc " 
                                   + c-cco.

    ASSIGN v-cod-lin-comando = v-cod-lin-comando
                               + " -server " 
                               + "~"127.0.0.1:1099~""
                               + " -f "
                               + c-email
                               + " -u " 
                               + c-email
                               + " -pw " 
                               + c-senha
                               + " -mime"
                               + " -q"
                               + " -noh"
                               + " -noh2".

    ASSIGN v-cod-lin-comando = v-cod-lin-comando + " -html ".

    IF c-anexo <> "" THEN DO:
        FILE-INFO:FILE-NAME = SEARCH(c-anexo).
        ASSIGN v-cod-lin-comando = v-cod-lin-comando + " -attach ~"" + FILE-INFO:FULL-PATHNAME + "~"".
    END.

    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "dtsemail.bat") CONVERT TARGET "IBM850".
    PUT UNFORMATTED "CD C:\Compartilhadas\Sistema\MHMoney" CHR(10) v-cod-lin-comando " -debug".
    OUTPUT CLOSE.

    OS-COMMAND NO-CONSOLE VALUE("~"" + SESSION:TEMP-DIRECTORY + "dtsemail.bat" + "~"").

    IF l-gera-atendimento THEN DO:
        FIND FIRST bf-cont OF bf-cli
            WHERE bf-cont.para NO-ERROR.
        IF AVAIL bf-cont THEN DO:
            CREATE atendimento.
            ASSIGN atendimento.cd-favorecido = bf-cli.cd-favorecido
                   atendimento.usuario = gcUsuario
                   atendimento.data = TODAY
                   atendimento.hora = STRING(TIME, "HH:MM")
                   atendimento.contato = bf-cont.nome
                   atendimento.cd-contato = bf-cont.cd-contato
                   atendimento.observacao = "De: " + c-nome + " <" + c-email + ">" + CHR(10) +
                                            "Data: " + STRING(TODAY, "99/99/9999") + " as " + STRING(TIME, "HH:MM:SS") + CHR(10) +
                                            "Para: " + c-para + CHR(10).

            IF c-cc <> "" THEN
                ASSIGN atendimento.observacao = atendimento.observacao +
                                            "CC: " + c-cc + CHR(10).

            ASSIGN atendimento.observacao = atendimento.observacao +
                                            "Assunto: " + c-ass-aux + CHR(10) + CHR(10) + 
                                            REPLACE(c-mail, "<br>", CHR(10)) + CHR(10) + CHR(10) + CHR(10) +
                                            c-nome.
        END.
    END.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

