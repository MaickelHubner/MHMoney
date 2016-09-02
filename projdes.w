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

DEFINE INPUT  PARAMETER iProj LIKE projeto.cd-projeto NO-UNDO.

/* Local Variable Definitions ---                                       */

DEFINE TEMP-TABLE tt-desemb
    FIELD ds-nivel AS CHAR COLUMN-LABEL "N°vel" FORMAT "X(50)"
    FIELD dt-desemb AS DATE COLUMN-LABEL "Data" FORMAT "99/99/9999"
    FIELD vl-desemb AS DECIMAL COLUMN-LABEL "Valor" FORMAT "->>>>,>>9.99".

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta
    FIELD ds-desc AS CHAR FORMAT "X(256)".

DEFINE BUFFER bfNivel FOR nivel-projeto.
DEFINE BUFFER bfDes FOR tt-desemb.

FIND FIRST projeto NO-LOCK
    WHERE projeto.cd-projeto = iProj.

DEFINE VARIABLE iSeqQr AS INTEGER    NO-UNDO.
DEFINE VARIABLE iSeqQrIni AS INTEGER    NO-UNDO.
FIND FIRST conta NO-LOCK
    WHERE conta.id-tipo = 1
    AND   NOT conta.id-encerrada.
FIND LAST mov-conta OF conta NO-LOCK USE-INDEX codigo.
ASSIGN iSeqQr = mov-conta.cd-sequencia + 999
       iSeqQrIni = iSeqQr.

&GLOBAL-DEFINE FrameFields  data-ini data-fim iConta

{func\relat\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brDes

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-desemb tt-mov-conta

/* Definitions for BROWSE brDes                                         */
&Scoped-define FIELDS-IN-QUERY-brDes tt-desemb.dt-desemb tt-desemb.ds-nivel tt-desemb.vl-desemb   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brDes   
&Scoped-define SELF-NAME brDes
&Scoped-define QUERY-STRING-brDes FOR EACH tt-desemb NO-LOCK BY tt-desemb.dt-desemb
&Scoped-define OPEN-QUERY-brDes OPEN QUERY {&SELF-NAME} FOR EACH tt-desemb NO-LOCK BY tt-desemb.dt-desemb.
&Scoped-define TABLES-IN-QUERY-brDes tt-desemb
&Scoped-define FIRST-TABLE-IN-QUERY-brDes tt-desemb


/* Definitions for BROWSE brExtra                                       */
&Scoped-define FIELDS-IN-QUERY-brExtra tt-mov-conta.dt-mov tt-mov-conta.ds-desc tt-mov-conta.de-valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brExtra   
&Scoped-define SELF-NAME brExtra
&Scoped-define QUERY-STRING-brExtra FOR EACH tt-mov-conta NO-LOCK     WHERE tt-mov-conta.cd-sequencia > iSeqQr BY tt-mov-conta.dt-mov
&Scoped-define OPEN-QUERY-brExtra OPEN QUERY {&SELF-NAME} FOR EACH tt-mov-conta NO-LOCK     WHERE tt-mov-conta.cd-sequencia > iSeqQr BY tt-mov-conta.dt-mov.
&Scoped-define TABLES-IN-QUERY-brExtra tt-mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-brExtra tt-mov-conta


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brDes}~
    ~{&OPEN-QUERY-brExtra}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-5 btData IMAGE-6 RECT-3 data-ini ~
data-fim btData-2 iConta brDes rat brExtra descr btDel btElim btInc btRat ~
btVal btVal-2 btCancel btOK 
&Scoped-Define DISPLAYED-FIELDS projeto.cd-projeto projeto.ds-projeto 
&Scoped-define DISPLAYED-TABLES projeto
&Scoped-define FIRST-DISPLAYED-TABLE projeto
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim iConta des-conta rat ~
descr 

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
DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btData 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Data" 
     SIZE 6 BY 1.79 TOOLTIP "Data".

DEFINE BUTTON btData-2 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Data" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btDel 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btElim 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btInc 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Executar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar".

DEFINE BUTTON btRat 
     IMAGE-UP FILE "image/im-sub.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-sub.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Ratear" 
     SIZE 6 BY 1.79 TOOLTIP "Ratear".

DEFINE BUTTON btVal 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Valor" 
     SIZE 6 BY 1.79 TOOLTIP "Valor".

DEFINE BUTTON btVal-2 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Valor" 
     SIZE 6 BY 1.79.

DEFINE VARIABLE data-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE des-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40.72 BY .79 NO-UNDO.

DEFINE VARIABLE descr AS CHARACTER FORMAT "X(256)":U INITIAL "Movimento Adicional" 
     VIEW-AS FILL-IN 
     SIZE 33 BY .79 NO-UNDO.

DEFINE VARIABLE iConta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE rat AS INTEGER FORMAT ">>9":U INITIAL 2 
     LABEL "Parcelas" 
     VIEW-AS FILL-IN 
     SIZE 4.57 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 4.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brDes FOR 
      tt-desemb SCROLLING.

DEFINE QUERY brExtra FOR 
      tt-mov-conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brDes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brDes C-Win _FREEFORM
  QUERY brDes DISPLAY
      tt-desemb.dt-desemb
 tt-desemb.ds-nivel
 tt-desemb.vl-desemb
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 58 BY 6
         FONT 1
         TITLE "Desembolsos Previstos".

DEFINE BROWSE brExtra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brExtra C-Win _FREEFORM
  QUERY brExtra DISPLAY
      tt-mov-conta.dt-mov FORMAT "99/99/9999"
      tt-mov-conta.ds-desc COLUMN-LABEL "Descriá∆o" FORMAT "X(50)"
      tt-mov-conta.de-valor FORMAT "->>>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 58 BY 6
         FONT 1
         TITLE "Movimentos Adicionais".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btData AT ROW 11.5 COL 41.72
     data-ini AT ROW 1.92 COL 15 COLON-ALIGNED
     data-fim AT ROW 2 COL 33 COLON-ALIGNED NO-LABEL
     btData-2 AT ROW 19.5 COL 42
     projeto.cd-projeto AT ROW 3 COL 9 COLON-ALIGNED
          LABEL "Projeto"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     projeto.ds-projeto AT ROW 3 COL 13.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 40.72 BY .79
     iConta AT ROW 4 COL 9 COLON-ALIGNED
     des-conta AT ROW 4 COL 13.29 COLON-ALIGNED NO-LABEL
     brDes AT ROW 5.5 COL 2
     rat AT ROW 11.75 COL 28 COLON-ALIGNED
     brExtra AT ROW 13.5 COL 2
     descr AT ROW 19.75 COL 2 NO-LABEL
     btDel AT ROW 19.5 COL 54
     btElim AT ROW 11.5 COL 54
     btInc AT ROW 19.5 COL 36
     btRat AT ROW 11.5 COL 35.57
     btVal AT ROW 11.5 COL 47.86
     btVal-2 AT ROW 19.5 COL 48
     btCancel AT ROW 21.5 COL 54
     btOK AT ROW 21.5 COL 47.86
     IMAGE-5 AT ROW 1.5 COL 26
     IMAGE-6 AT ROW 1.5 COL 30.43
     RECT-3 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 59.72 BY 22.46
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
         TITLE              = "Previs∆o de Desembolso"
         HEIGHT             = 22.46
         WIDTH              = 59.72
         MAX-HEIGHT         = 23.04
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 23.04
         VIRTUAL-WIDTH      = 80
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
/* BROWSE-TAB brDes des-conta DEFAULT-FRAME */
/* BROWSE-TAB brExtra rat DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN projeto.cd-projeto IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN des-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN descr IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN projeto.ds-projeto IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brDes
/* Query rebuild information for BROWSE brDes
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-desemb NO-LOCK BY tt-desemb.dt-desemb.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brDes */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brExtra
/* Query rebuild information for BROWSE brExtra
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-mov-conta NO-LOCK
    WHERE tt-mov-conta.cd-sequencia > iSeqQr BY tt-mov-conta.dt-mov.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brExtra */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 22
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 45
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(descr:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Previs∆o de Desembolso */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Previs∆o de Desembolso */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brDes
&Scoped-define SELF-NAME brDes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brDes C-Win
ON ROW-DISPLAY OF brDes IN FRAME DEFAULT-FRAME /* Desembolsos Previstos */
DO:
  
    IF CAN-FIND(FIRST agenda
                WHERE agenda.dt-ini = agenda.dt-fim 
                AND   MONTH(agenda.dt-ini) = MONTH(tt-desemb.dt-desemb)
                AND   YEAR(agenda.dt-ini) = YEAR(tt-desemb.dt-desemb)
                AND   agenda.valor = ((-1) * tt-desemb.vl-desemb)) THEN DO:

        ASSIGN tt-desemb.dt-desemb:FGCOLOR IN BROWSE brDes = 12
               tt-desemb.ds-nivel:FGCOLOR IN BROWSE brDes = 12
               tt-desemb.vl-desemb:FGCOLOR IN BROWSE brDes = 12.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    {func\relat\bt_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btData
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btData C-Win
ON CHOOSE OF btData IN FRAME DEFAULT-FRAME /* Data */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-desemb THEN DO:
        {func\run.i &Programa = "data.w (INPUT 'Data de Desembolso', INPUT tt-desemb.dt-desemb, OUTPUT tt-desemb.dt-desemb)"}
        {&OPEN-QUERY-brDes}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btData-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btData-2 C-Win
ON CHOOSE OF btData-2 IN FRAME DEFAULT-FRAME /* Data */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-mov-conta THEN DO:
        {func\run.i &Programa = "data.w (INPUT 'Data do Movimento', INPUT tt-mov-conta.dt-mov, OUTPUT tt-mov-conta.dt-mov)"}
        {&OPEN-QUERY-brExtra}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel C-Win
ON CHOOSE OF btDel IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-mov-conta THEN DO:
        DELETE tt-mov-conta.
        {&OPEN-QUERY-brExtra}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btElim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btElim C-Win
ON CHOOSE OF btElim IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-desemb THEN DO:
        DELETE tt-desemb.
        {&OPEN-QUERY-brDes}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btInc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btInc C-Win
ON CHOOSE OF btInc IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    FIND LAST tt-mov-conta 
        WHERE tt-mov-conta.cd-sequencia > iSeqQr NO-ERROR.
    IF NOT AVAIL tt-mov-conta THEN DO:
        ASSIGN iSeq = iSeqQr + 1.
    END.
    ELSE DO:
        ASSIGN iSeq = tt-mov-conta.cd-sequencia + 1.
    END.

  
    CREATE tt-mov-conta.
    ASSIGN tt-mov-conta.dt-mov = TODAY
           tt-mov-conta.ds-desc = INPUT FRAME {&FRAME-NAME} descr
           tt-mov-conta.cd-sequencia = iSeq.
    {&OPEN-QUERY-brExtra}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* Executar */
DO:
    {func\relat\bt_executar.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRat C-Win
ON CHOOSE OF btRat IN FRAME DEFAULT-FRAME /* Ratear */
DO:

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-desemb THEN DO:
        REPEAT iCont = 1 TO INPUT FRAME {&FRAME-NAME} rat.
    
            IF iCont = INPUT FRAME {&FRAME-NAME} rat THEN DO:
                ASSIGN tt-desemb.vl-desemb = (tt-desemb.vl-desemb / INPUT FRAME {&FRAME-NAME} rat).
            END.
            ELSE DO:
                CREATE bfDes.
                BUFFER-COPY tt-desemb TO bfDes.
                ASSIGN bfDes.vl-desemb = (tt-desemb.vl-desemb / INPUT FRAME {&FRAME-NAME} rat).
            END.
    
        END.
        {&OPEN-QUERY-brDes}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btVal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btVal C-Win
ON CHOOSE OF btVal IN FRAME DEFAULT-FRAME /* Valor */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-desemb THEN DO:
        {func\run.i &Programa = "valor.w (INPUT 'Valor do Desembolso', INPUT tt-desemb.vl-desemb, OUTPUT tt-desemb.vl-desemb)"}
        {&OPEN-QUERY-brDes}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btVal-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btVal-2 C-Win
ON CHOOSE OF btVal-2 IN FRAME DEFAULT-FRAME /* Valor */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-mov-conta THEN DO:
        {func\run.i &Programa = "valor.w (INPUT 'Valor do Movimento', INPUT tt-mov-conta.de-valor, OUTPUT tt-mov-conta.de-valor)"}
        {&OPEN-QUERY-brExtra}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME projeto.cd-projeto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.cd-projeto C-Win
ON ENTRY OF projeto.cd-projeto IN FRAME DEFAULT-FRAME /* Projeto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.cd-projeto C-Win
ON LEAVE OF projeto.cd-projeto IN FRAME DEFAULT-FRAME /* Projeto */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-fim C-Win
ON ENTRY OF data-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-fim C-Win
ON LEAVE OF data-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-ini C-Win
ON ENTRY OF data-ini IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-ini C-Win
ON LEAVE OF data-ini IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des-conta C-Win
ON ENTRY OF des-conta IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des-conta C-Win
ON LEAVE OF des-conta IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME descr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL descr C-Win
ON ENTRY OF descr IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL descr C-Win
ON LEAVE OF descr IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME projeto.ds-projeto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.ds-projeto C-Win
ON ENTRY OF projeto.ds-projeto IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL projeto.ds-projeto C-Win
ON LEAVE OF projeto.ds-projeto IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iConta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON ENTRY OF iConta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON LEAVE OF iConta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela="iConta"
                  &CampoProc="ds-conta"
                  &Tela="des-conta"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON MOUSE-SELECT-DBLCLICK OF iConta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF iConta DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="iConta"
                 &Campo2="ds-conta"
                 &Tela2="des-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rat C-Win
ON ENTRY OF rat IN FRAME DEFAULT-FRAME /* Parcelas */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rat C-Win
ON LEAVE OF rat IN FRAME DEFAULT-FRAME /* Parcelas */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\relat\main_block.i}

{ttmovto.i data-ini data-fim YES}

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

ASSIGN C-Win:TOP-ONLY = TRUE.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i projdes}
  RUN initialize.
  RUN enable_UI.
  RUN displayFields.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlaExecucao C-Win 
PROCEDURE controlaExecucao :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER pMax AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER pAtual AS INTEGER     NO-UNDO.

    ASSIGN chProgressBar:MAX = pMax.

    ASSIGN chProgressBar:VALUE = pAtual.

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

OCXFile = SEARCH( "projdes.wrx":U ).
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
ELSE MESSAGE "projdes.wrx":U SKIP(1)
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
    APPLY "LEAVE" TO iConta IN FRAME {&FRAME-NAME}.

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
  DISPLAY data-ini data-fim iConta des-conta rat descr 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE projeto THEN 
    DISPLAY projeto.cd-projeto projeto.ds-projeto 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE IMAGE-5 btData IMAGE-6 RECT-3 data-ini data-fim btData-2 iConta brDes 
         rat brExtra descr btDel btElim btInc btRat btVal btVal-2 btCancel btOK 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE executaRelatorio C-Win 
PROCEDURE executaRelatorio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* Definiá∆o das vari†veis */
{func\relat\var.i}

DEFINE VARIABLE cTemp AS CHARACTER FORMAT "X(40)"  NO-UNDO.
DEFINE VARIABLE l-Imp AS LOGICAL    NO-UNDO INITIAL NO.
DEFINE VARIABLE cData AS CHARACTER FORMAT "X(20)"  NO-UNDO.
DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO INITIAL 0.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.
DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO.
DEFINE VARIABLE cFav AS CHARACTER FORMAT "X(256)" NO-UNDO.

/* Output padr∆o */
{func\relat\ini.i 1}

/* L¢gica do relat¢rio */

FOR EACH tt-mov-conta
    WHERE tt-mov-conta.cd-sequencia < iSeqQrIni:
    DELETE tt-mov-conta.
END.

ASSIGN cTemp = "Conta: " + STRING(iConta,"999") + " - " + conta.ds-conta + "<br>" +
               "Per°odo: " + STRING(data-ini,"99/99/9999") + " a " + STRING(data-fim,"99/99/9999").
{func\relat\capitulo.i cTemp 800}

FIND FIRST mov-conta OF conta USE-INDEX data.

ASSIGN deSaldo = conta.vl-saldo-ini
       iMes = MONTH(data-ini).

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.id-situacao = 3
    AND   mov-conta.agrupado = 0
    USE-INDEX data:

    ASSIGN deSaldo = deSaldo + mov-conta.de-valor.

END.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.dt-mov <= data-ini
    AND   mov-conta.id-situacao <> 3
    AND   mov-conta.agrupado = 0
    USE-INDEX data
    BREAK BY mov-conta.dt-mov :

    IF NOT l-Imp THEN DO:
        {func\relat\total.i &Coluna1=''
                            &Align1="left"
                            &Coluna2='"Saldo Inicial"'
                            &Align2="left"
                            &Coluna3=''
                            &Align3="right"
                            &Coluna4=deSaldo
                            &Align4="right"}
        {func\relat\titulo.i &Coluna1=''
                             &Tamanho1=70
                             &Coluna2='"N∆o Reconciliadas"'
                             &Tamanho2=430
                             &Coluna3=''
                             &Tamanho3=150
                             &Coluna4=''
                             &Tamanho4=150}
    END.

    ASSIGN deSaldo = deSaldo + mov-conta.de-valor.

    FIND FIRST favorecido OF mov-conta NO-LOCK.
    ASSIGN cTemp = STRING(mov-conta.de-valor,"->>>>,>>>,>>9.99")
           cData = STRING(mov-conta.dt-mov,"99/99/9999").
    IF FIRST-OF(mov-conta.dt-mov) THEN DO:
        IF LAST-OF(mov-conta.dt-mov) THEN DO:
            {func\relat\linha.i &Coluna1=cData
                                &Align1="left"
                                &Coluna2=favorecido.ds-favorecido
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ELSE DO:
            {func\relat\linha.i &Coluna1=cData
                                &Align1="left"
                                &Coluna2=favorecido.ds-favorecido
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"}
        END.
    END.
    ELSE DO:
        IF LAST-OF(mov-conta.dt-mov) THEN DO:
            {func\relat\linha.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=favorecido.ds-favorecido
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ELSE DO:
            {func\relat\linha.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=favorecido.ds-favorecido
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"}
        END.
    END.

    ASSIGN l-Imp = YES.

END.

IF l-Imp THEN DO:
    {func\relat\total.i &Coluna1=''
                        &Align1="left"
                        &Coluna2='"Saldo Anterior"'
                        &Align2="left"
                        &Coluna3=''
                        &Align3="right"
                        &Coluna4=deSaldo
                        &Align4="right"}
    ASSIGN l-Imp = NO.
END.
ELSE DO:
    {func\relat\total.i &Coluna1=''
                        &Align1="left"
                        &Coluna2='"Saldo Inicial"'
                        &Align2="left"
                        &Coluna3=''
                        &Align3="right"
                        &Coluna4=deSaldo
                        &Align4="right"}
END.
                            
RUN criaTT.

FIND LAST tt-mov-conta NO-LOCK NO-ERROR.
IF AVAIL tt-mov-conta THEN DO:
    ASSIGN iSeq = tt-mov-conta.cd-sequencia + 1.
END.
ELSE DO:
    FIND LAST mov-conta NO-LOCK NO-ERROR.        
    IF AVAIL tt-mov-conta THEN DO:
        ASSIGN iSeq = mov-conta.cd-sequencia + 1.
    END.
    ELSE DO:
        ASSIGN iSeq = 1.
    END.
END.

FOR EACH tt-desemb:

    CREATE tt-mov-conta.
    ASSIGN tt-mov-conta.dt-mov = tt-desemb.dt-desemb
           tt-mov-conta.de-valor = (-1) * tt-desemb.vl-desemb
           tt-mov-conta.ds-desc = "Desembolso para " + tt-desemb.ds-nivel + " - Proj: " + projeto.ds-projeto
           tt-mov-conta.cd-sequencia  = iSeq
           tt-mov-conta.cd-conta = conta.cd-conta
           iSeq = iSeq + 1.

END.

FOR EACH tt-mov-conta WHERE tt-mov-conta.de-valor = 0:
    DELETE tt-mov-conta.
END.

FIND FIRST tt-mov-conta WHERE tt-mov-conta.dt-mov <= data-ini NO-ERROR.
IF AVAIL tt-mov-conta THEN DO:
    {func\relat\titulo.i &Coluna1=''
                         &Tamanho1=70
                         &Coluna2='"Vencidas"'
                         &Tamanho2=430
                         &Coluna3=''
                         &Tamanho3=150
                         &Coluna4=''
                         &Tamanho4=150}
END.

FOR EACH tt-mov-conta
    WHERE tt-mov-conta.dt-mov <= data-ini
    USE-INDEX data
    BREAK BY tt-mov-conta.dt-mov:

    ASSIGN deSaldo = deSaldo + tt-mov-conta.de-valor.

    FIND FIRST favorecido OF tt-mov-conta NO-LOCK NO-ERROR.
    IF AVAIL favorecido THEN
        ASSIGN cFav = favorecido.ds-favorecido.
    ELSE
        ASSIGN cFav = tt-mov-conta.ds-desc.
    ASSIGN cTemp = STRING(tt-mov-conta.de-valor,"->>>>,>>>,>>9.99")
           cData = STRING(tt-mov-conta.dt-mov,"99/99/9999").
    IF FIRST-OF(tt-mov-conta.dt-mov) THEN DO:
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
            {func\relat\linha.i &Coluna1=cData
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ELSE DO:
            {func\relat\linha.i &Coluna1=cData
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"}
        END.
    END.
    ELSE DO:
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
            {func\relat\linha.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ELSE DO:
            {func\relat\linha.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"}
        END.
    END.

    ASSIGN l-Imp = YES.
END.
FIND FIRST tt-mov-conta WHERE tt-mov-conta.dt-mov <= data-ini NO-ERROR.
IF AVAIL tt-mov-conta THEN DO:
    {func\relat\total.i &Coluna1=''
                        &Align1="left"
                        &Coluna2='"Saldo Ap¢s"'
                        &Align2="left"
                        &Coluna3=''
                        &Align3="right"
                        &Coluna4=deSaldo
                        &Align4="right"}
    ASSIGN l-Imp = NO.
END.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini
    AND   mov-conta.dt-mov <= data-fim
    AND   mov-conta.cd-conta = iConta
    AND   mov-conta.agrupado = 0
    USE-INDEX data:

     CREATE tt-mov-conta.
     BUFFER-COPY mov-conta TO tt-mov-conta.

END.

{func\relat\titulo.i &Coluna1=''
                     &Tamanho1=70
                     &Coluna2='"Lanáamentos Futuros"'
                     &Tamanho2=430
                     &Coluna3=''
                     &Tamanho3=150
                     &Coluna4=''
                     &Tamanho4=150}
/*ASSIGN iAux = 0.
FOR EACH tt-mov-conta:
    ASSIGN iAux = iAux + 1.
END.
{func\relat\ini-prg-bar.i iAux}*/

FOR EACH tt-mov-conta
    WHERE tt-mov-conta.dt-mov > data-ini
    USE-INDEX data
    BREAK BY tt-mov-conta.dt-mov:

    /*{func\relat\control.i}*/

    IF MONTH(tt-mov-conta.dt-mov) <> iMes THEN DO:
        IF l-Imp THEN DO:
            FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK.
            ASSIGN cTemp = "Saldo ao final de " + fnMes(iMes) + " / " + STRING(YEAR(IF iMes <> 12 THEN tt-mov-conta.dt-mov ELSE (tt-mov-conta.dt-mov - 40))).
            {func\relat\total.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=cTemp
                                &Align2="left"
                                &Coluna3=''
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ASSIGN iMes = MONTH(tt-mov-conta.dt-mov).
    END.

    ASSIGN deSaldo = deSaldo + tt-mov-conta.de-valor.
    
    FIND FIRST favorecido OF tt-mov-conta NO-LOCK NO-ERROR.
    IF AVAIL favorecido THEN
        ASSIGN cFav = favorecido.ds-favorecido.
    ELSE
        ASSIGN cFav = tt-mov-conta.ds-desc.
    ASSIGN cTemp = STRING(tt-mov-conta.de-valor,"->>>>,>>>,>>9.99")
           cData = STRING(tt-mov-conta.dt-mov,"99/99/9999").
    IF FIRST-OF(tt-mov-conta.dt-mov) THEN DO:
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
            {func\relat\linha.i &Coluna1=cData
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ELSE DO:
            {func\relat\linha.i &Coluna1=cData
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"}
        END.
    END.
    ELSE DO:
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
            {func\relat\linha.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=deSaldo
                                &Align4="right"}
        END.
        ELSE DO:
            {func\relat\linha.i &Coluna1=''
                                &Align1="left"
                                &Coluna2=cFav
                                &Align2="left"
                                &Coluna3=cTemp
                                &Align3="right"
                                &Coluna4=''
                                &Align4="right"}
        END.
    END.

    ASSIGN l-Imp = YES.

END.

{func\relat\total.i &Coluna1=''
                    &Align1="left"
                    &Coluna2='"Saldo ao Final do Per°odo"'
                    &Align2="left"
                    &Coluna3=''
                    &Align3="right"
                    &Coluna4=deSaldo
                    &Align4="right"}

{func\relat\end-capitulo.i}

/* Fecha Output padr∆o */
{func\relat\end.i}


RETURN "OK":U.

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

    {func\cursor.i iConta 1 "IN FRAME {&FRAME-NAME}"}

    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE deAnt AS DECIMAL    NO-UNDO.

    FOR EACH nivel-projeto OF projeto NO-LOCK
        WHERE nivel-projeto.val-real < nivel-projeto.val-planejado:

        IF CAN-FIND(FIRST bfNivel
                    WHERE bfNivel.nivel-pai = nivel-projeto.cd-nivel) THEN NEXT.

        ASSIGN deTemp = 0.

        FOR EACH proj-periodo OF projeto
            WHERE proj-periodo.dt-end >= TODAY
            BY proj-periodo.dt-ini DESCENDING:

            FOR EACH proj-periodo-nivel OF proj-periodo
                WHERE proj-periodo-nivel.cd-nivel = nivel-projeto.cd-nivel
                AND   proj-periodo-nivel.valor > 0:

                IF deTemp >= (nivel-projeto.val-planejado - nivel-projeto.val-real) THEN NEXT.

                ASSIGN deAnt = 0.
                FOR EACH mov-conta OF nivel-projeto
                    WHERE mov-conta.dt-mov >= proj-periodo.dt-ini
                    AND   mov-conta.dt-mov <= proj-periodo.dt-end:

                    ASSIGN deAnt = deAnt + mov-conta.de-valor.

                END.

                CREATE tt-desemb.
                ASSIGN tt-desemb.dt-desemb = proj-periodo.dt-ini
                       tt-desemb.vl-desemb = (proj-periodo-nivel.valor + deAnt)
                       tt-desemb.ds-nivel = nivel-projeto.ds-nivel
                       deTemp = deTemp + tt-desemb.vl-desemb.

            END.

        END.

    END.

    FIND FIRST conta NO-LOCK
        WHERE conta.id-tipo = 1
        AND   NOT conta.id-encerrada NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN iConta = conta.cd-conta.
    END.

    ASSIGN data-ini = TODAY.

    FOR EACH bfDes BY bfDes.dt-desemb:
        ASSIGN data-fim = bfDes.dt-desemb + 30.
    END.
    IF data-fim = ? THEN
        ASSIGN data-fim = data-ini + 30.

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

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

