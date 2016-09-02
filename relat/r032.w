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
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  mes-ini ano-ini mes-fim ano-fim moeda iPoup

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}
{ir.i}

DEFINE TEMP-TABLE tt-prev
    FIELD mes AS INTEGER
    FIELD ano AS INTEGER
    FIELD vl-mes AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-esp AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-jur AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-ir  AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-acu AS DECIMAL  FORMAT "->>,>>>,>>9.99".

DEFINE TEMP-TABLE tt-real
    FIELD mes AS INTEGER
    FIELD ano AS INTEGER
    FIELD vl-mes AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-esp AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-jur AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-ir  AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-acu AS DECIMAL  FORMAT "->>,>>>,>>9.99".

DEFINE TEMP-TABLE tt-dif
    FIELD mes AS INTEGER
    FIELD ano AS INTEGER
    FIELD vl-mes AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-esp AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-jur AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-ir  AS DECIMAL  FORMAT "->>,>>>,>>9.99"
    FIELD vl-acu AS DECIMAL  FORMAT "->>,>>>,>>9.99".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 IMAGE-6 RECT-10 iPoup ~
mes-ini ano-ini mes-fim ano-fim moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS iPoup des-poup mes-ini ano-ini mes-fim ~
ano-fim moeda 

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

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Executar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar".

DEFINE VARIABLE mes-fim AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Maráo",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE mes-ini AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Per°odo" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Maráo",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE ano-fim AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE ano-ini AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE des-poup AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE iPoup AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Poupanáa" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 3.75 COL 73
     iPoup AT ROW 2 COL 19 COLON-ALIGNED
     des-poup AT ROW 2 COL 23.29 COLON-ALIGNED NO-LABEL
     mes-ini AT ROW 2.92 COL 19 COLON-ALIGNED
     ano-ini AT ROW 2.92 COL 35.29 COLON-ALIGNED NO-LABEL
     mes-fim AT ROW 2.92 COL 48 COLON-ALIGNED NO-LABEL
     ano-fim AT ROW 2.92 COL 64.29 COLON-ALIGNED NO-LABEL
     moeda AT ROW 4 COL 19 COLON-ALIGNED
     btOK AT ROW 2 COL 73
     IMAGE-5 AT ROW 2.5 COL 41
     IMAGE-6 AT ROW 2.5 COL 45.72
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 5.75
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
         TITLE              = "Template Padr∆o de Relat¢rio"
         HEIGHT             = 5.75
         WIDTH              = 80
         MAX-HEIGHT         = 7.63
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 7.63
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
/* SETTINGS FOR FILL-IN des-poup IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 6
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(moeda:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Relat¢rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Relat¢rio */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ano-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-fim C-Win
ON ENTRY OF ano-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-fim C-Win
ON LEAVE OF ano-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ano-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-ini C-Win
ON ENTRY OF ano-ini IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-ini C-Win
ON LEAVE OF ano-ini IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
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


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* Executar */
DO:
    {func\relat\bt_executar.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iPoup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON ENTRY OF iPoup IN FRAME DEFAULT-FRAME /* Poupanáa */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON LEAVE OF iPoup IN FRAME DEFAULT-FRAME /* Poupanáa */
DO:
    {func\leave.i &Tabela="poupanca"
                  &Campo="cd-poupanca"
                  &CampoTela="iPoup"
                  &CampoProc = "ds-poupanca"
                  &Tela="des-poup"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON MOUSE-SELECT-DBLCLICK OF iPoup IN FRAME DEFAULT-FRAME /* Poupanáa */
OR F5 OF iPoup DO:
    {func\zoom.i &Tabela="poupanca"
                 &Campo1="cd-poupanca"
                 &Tela1="iPoup"
                 &Campo2="ds-poupanca"
                 &Tela2="des-poup"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-fim C-Win
ON ENTRY OF mes-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-fim C-Win
ON LEAVE OF mes-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON ENTRY OF mes-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON LEAVE OF mes-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_leave.i}    
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


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\relat\main_block.i}

{campos\cd-moeda.i}                

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
  {version.i r032}
  RUN enable_UI.
  RUN initialize.
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

OCXFile = SEARCH( "r032.wrx":U ).
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
ELSE MESSAGE "r032.wrx":U SKIP(1)
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

{func\relat\display.i}

APPLY "LEAVE" TO iPoup IN FRAME {&FRAME-NAME}.

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
  DISPLAY iPoup des-poup mes-ini ano-ini mes-fim ano-fim moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 iPoup mes-ini ano-ini mes-fim ano-fim 
         moeda btOK 
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

FOR EACH tt-prev:
    DELETE tt-prev.
END.
FOR EACH tt-real:
    DELETE tt-real.
END.
FOR EACH tt-dif:
    DELETE tt-dif.
END.

DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE dtPrim AS DATE       NO-UNDO.
DEFINE VARIABLE dePrev AS DECIMAL  FORMAT "->>,>>>,>>9.99"  NO-UNDO.
DEFINE VARIABLE deReal AS DECIMAL  FORMAT "->>,>>>,>>9.99"    NO-UNDO.
DEFINE VARIABLE deDif AS DECIMAL  FORMAT "->>,>>>,>>9.99"    NO-UNDO.
DEFINE VARIABLE cOque AS CHARACTER  NO-UNDO.
DEFINE VARIABLE dePrev-aux AS DECIMAL  FORMAT "->>,>>>,>>9.99"    NO-UNDO.
DEFINE VARIABLE deReal-aux AS DECIMAL  FORMAT "->>,>>>,>>9.99"    NO-UNDO.
DEFINE VARIABLE deDif-aux AS DECIMAL  FORMAT "->>,>>>,>>9.99"    NO-UNDO.
DEFINE VARIABLE deVarCamb AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deAnt AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deMes AS DECIMAL    NO-UNDO.
DEFINE VARIABLE lComeca AS LOGICAL     NO-UNDO.
DEFINE VARIABLE dtComeca AS DATE    NO-UNDO.

DEFINE VARIABLE deIRtemp AS DECIMAL    NO-UNDO.

DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

/* Output padr∆o */
ASSIGN iAno = INT((DATE(mes-fim,15,ano-fim) - DATE(mes-ini,15,ano-ini)) / 30) + 1.
{func\relat\ini.i iAno}

/* L¢gica do relat¢rio */

FIND FIRST poupanca NO-LOCK
    WHERE poupanca.cd-poupanca = iPoup NO-ERROR.

ASSIGN cTemp = "Poupanáa: " + STRING(iPoup,"999") + " - " + poupanca.ds-poupanca + "<br>" +
               "Per°odo: " + STRING(mes-ini,"99") + "/" + STRING(ano-ini,"9999") + " atÇ " + STRING(mes-fim,"99") + "/" + STRING(ano-ini,"9999").
{func\relat\capitulo.i cTemp 600}

IF NOT CAN-FIND(FIRST item-poupanca OF poupanca
                WHERE item-poupanca.ano >= ano-ini) THEN DO:
    {func\relat\total.i &Coluna1='"N∆o existe previs∆o de poupanáa no per°odo selecionado."'
                         &Tamanho1=600}
    {func\relat\end-capitulo.i}
    {func\relat\end.i}
    RETURN "NOK":U.
END.

ASSIGN dtPrim = (DATE(mes-ini,1,ano-ini) - 1).

{func\relat\titulo.i &Coluna1='"Acumulado Anterior"'
                     &Tamanho1=300
                     &Coluna2='"Previsto"'
                     &Tamanho2=100
                     &Coluna3='"Realizado"'
                     &Tamanho3=100
                     &Coluna4='"Diferenáa"'
                     &Tamanho4=100}
                     
FOR EACH poup-conta NO-LOCK
    WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca:

    ASSIGN deReal = 0
           deDif = 0.

    FIND FIRST conta WHERE conta.cd-conta = poup-conta.cd-conta NO-LOCK.

    ASSIGN dePrev = conta.vl-saldo-ini.

    FIND FIRST item-poupanca OF poupanca NO-LOCK NO-ERROR.
    IF NOT AVAIL item-poupanca THEN LEAVE.

    IF item-poupanca.ano > ano-ini THEN LEAVE.

    ASSIGN lComeca = NO.

    FOR EACH mov-conta OF conta NO-LOCK
        WHERE mov-conta.dt-mov < DATE(1,1,item-poupanca.ano)
        AND mov-conta.id-tipo <> 0
        BREAK BY mov-conta.dt-mov:

        IF FIRST-OF(mov-conta.dt-mov) THEN DO:
            IF poupanca.cd-conta = conta.cd-conta THEN DO:
                IF mov-conta.cd-favorecido = poupanca.cd-fav-padrao THEN
                    ASSIGN lComeca = YES.
            END.
            ELSE
                ASSIGN lComeca = YES.
        END.

        IF lComeca THEN
            ASSIGN dePrev = dePrev + mov-conta.de-valor
                   dtComeca = mov-conta.dt-mov + 1.

    END.

    ASSIGN deReal = dePrev.
    ASSIGN dePrev = fnCotacao(dePrev,conta.cd-moeda,0,dtPrim).       

    IF dtComeca = ? THEN
        ASSIGN dtComeca = DATE(1,1,item-poupanca.ano).

    ASSIGN lComeca = NO.

    FOR EACH mov-conta OF conta NO-LOCK USE-INDEX valor
        WHERE mov-conta.dt-mov <= dtPrim
        AND   mov-conta.dt-mov >= dtComeca
        AND mov-conta.id-tipo <> 0
        BREAK BY mov-conta.dt-mov:

        IF FIRST-OF(mov-conta.dt-mov) THEN DO:
            IF poupanca.cd-conta = conta.cd-conta THEN DO:
                IF mov-conta.cd-favorecido = poupanca.cd-fav-padrao THEN
                    ASSIGN lComeca = YES.
            END.
            ELSE
                ASSIGN lComeca = YES.
        END.

        IF lComeca THEN
            ASSIGN deReal = deReal + mov-conta.de-valor.

    END.

    ASSIGN deReal = fnCotacao(deReal,conta.cd-moeda,0,dtPrim).

    IF conta.cd-conta = poupanca.cd-conta THEN DO:
        FOR EACH item-poupanca OF poupanca
            WHERE item-poupanca.ano < ano-ini NO-LOCK:

            REPEAT iCont = 1 TO 12:
                IF poupanca.calc-ir THEN
                    ASSIGN deIRtemp = dePrev * (item-poupanca.pc-juros / 100).
                ASSIGN dePrev = (dePrev * (1 + (item-poupanca.pc-juros / 100))) + item-poupanca.vl-deposito + item-poupanca.vl-espontaneo[iCont].
                IF poupanca.calc-ir THEN DO:
                    /* Calcula IR retido na fonte */
                    ASSIGN deIRtemp = fnIR(deIRtemp,DATE(iCont,15,item-poupanca.ano)).
                    ASSIGN dePrev = dePrev - deIRtemp.
                END.
            END.

        END.

        FIND FIRST item-poupanca OF poupanca
            WHERE item-poupanca.ano = ano-ini NO-LOCK NO-ERROR.

        IF NOT AVAIL item-poupanca THEN NEXT.

        REPEAT iCont = 1 TO (mes-ini - 1):
            IF poupanca.calc-ir THEN
                ASSIGN deIRtemp = dePrev * (item-poupanca.pc-juros / 100).
            ASSIGN dePrev = (dePrev * (1 + (item-poupanca.pc-juros / 100))) + item-poupanca.vl-deposito + item-poupanca.vl-espontaneo[iCont].
            IF poupanca.calc-ir THEN DO:
                /* Calcula IR retido na fonte */
                ASSIGN deIRtemp = fnIR(deIRtemp,DATE(iCont,15,item-poupanca.ano)).
                ASSIGN dePrev = dePrev - deIRtemp.
            END.
        END.

    END.

    ASSIGN dePrev-aux = dePrev-aux + dePrev
           deReal-aux = deReal-aux + deReal.

END.

ASSIGN dePrev = dePrev-aux
       deReal = deReal-aux
       deDif = deReal - dePrev.

/* Controle de moeda */
IF moeda <> 0 THEN DO:
    ASSIGN dePrev = fnCotacao(dePrev,0,moeda,dtPrim)
           deReal = fnCotacao(deReal,0,moeda,dtPrim)
           deDif  = fnCotacao(deDif,0,moeda,dtPrim).
END.

{func\relat\total.i &Coluna1='"Montante Inicial"'
                    &Align1="left"
                    &Coluna2=dePrev
                    &Align2="right"
                    &Coluna3=deReal
                    &Align3="right"
                    &Coluna4=deDif
                    &Align4="right"}
                    
REPEAT iAno = ano-ini TO ano-fim:
    FIND FIRST item-poupanca OF poupanca
        WHERE item-poupanca.ano = iAno NO-LOCK NO-ERROR.
    IF NOT AVAIL item-poupanca THEN NEXT.
    REPEAT iMes = IF ano-ini = iAno THEN mes-ini ELSE 1 TO IF ano-fim = iAno THEN mes-fim ELSE 12:

       {func\relat\control.i}

        CREATE tt-prev.
        ASSIGN tt-prev.mes = iMes
               tt-prev.ano = iAno
               tt-prev.vl-mes = item-poupanca.vl-deposito
               tt-prev.vl-esp = item-poupanca.vl-espontaneo[iMes]
               tt-prev.vl-jur = (dePrev * (item-poupanca.pc-juros / 100)).

        IF poupanca.calc-ir THEN DO:
            /* Calcula IR retido na fonte */
            ASSIGN tt-prev.vl-ir = fnIR(tt-prev.vl-jur,DATE(iMes,15,iAno)).
        END.

        ASSIGN tt-prev.vl-acu = dePrev + tt-prev.vl-mes + tt-prev.vl-esp + tt-prev.vl-jur - tt-prev.vl-ir
               dePrev = tt-prev.vl-acu.

        CREATE tt-real.
        ASSIGN tt-real.mes = iMes
               tt-real.ano = iAno.
        IF tt-prev.vl-acu > 0 THEN DO:

            FOR EACH poup-conta NO-LOCK
                WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca:
    
                FIND FIRST conta WHERE conta.cd-conta = poup-conta.cd-conta NO-LOCK.
    
                FOR EACH mov-conta OF conta NO-LOCK
                    WHERE MONTH(mov-conta.dt-mov) = iMes
                    AND   YEAR(mov-conta.dt-mov) = iAno
                    AND mov-conta.id-tipo <> 0:
    
                    IF mov-conta.id-tipo <> 3 THEN DO:
    
                        FIND FIRST categoria WHERE categoria.cod-categoria = mov-conta.cod-categoria NO-LOCK.
                        FIND FIRST sub-cat OF categoria WHERE sub-cat.cd-sub = mov-conta.cd-sub NO-LOCK.
    
                        IF categoria.ds-cat MATCHES("*JURO*")
                        OR categoria.ds-cat MATCHES("*RENDIMENTO*")
                        OR sub-cat.ds-sub MATCHES("*JURO*")
                        OR sub-cat.ds-sub MATCHES("*RENDIMENTO*") THEN DO:
                            ASSIGN tt-real.vl-jur = tt-real.vl-jur + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                        END.
                        ELSE DO:
                            if mov-conta.de-valor > 0 THEN DO:
                                ASSIGN tt-real.vl-mes = tt-real.vl-mes + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0, mov-conta.dt-mov).
                                IF iMes = 3 THEN
                                    MESSAGE mov-conta.de-valor SKIP mov-conta.cd-conta SKIP mov-conta.dt-mov
                                        VIEW-AS ALERT-BOX INFO BUTTONS OK.
                            END.
                            else
                                ASSIGN tt-real.vl-esp = tt-real.vl-esp + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0, mov-conta.dt-mov).
                        END.
    
                    END.
                    ELSE DO:
                        IF mov-conta.cd-favorecido = poupanca.cd-fav-padrao THEN DO:
                            ASSIGN tt-real.vl-mes = tt-real.vl-mes + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                        END.
                        ELSE DO:
                            IF deReal > 0 THEN DO:
                                IF NOT CAN-FIND(FIRST poup-conta NO-LOCK
                                                WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca
                                                AND   poup-conta.cd-conta = mov-conta.conta-transf) THEN DO:
                                    ASSIGN tt-real.vl-esp = tt-real.vl-esp + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                                END.
                            END.
                        END.
                    END.
    
                END.
    
                IF conta.cd-moeda <> 0 THEN DO:
                    ASSIGN deAnt = 0
                           deVarCamb = 0.
                    FOR EACH mov-conta OF conta NO-LOCK
                        WHERE mov-conta.dt-mov < DATE(iMes,1,iAno)
                        AND mov-conta.id-tipo <> 0:
                        ASSIGN deAnt = deAnt + mov-conta.de-valor.
                    END.
                    ASSIGN deMes = deAnt.
                    FOR EACH mov-conta OF conta NO-LOCK
                        WHERE MONTH(mov-conta.dt-mov) = iMes
                        AND   YEAR(mov-conta.dt-mov) = iAno
                        AND mov-conta.id-tipo <> 0:
                        ASSIGN deMes = deMes + mov-conta.de-valor.
                        ASSIGN deVarCamb = deVarCamb +
                                           fnCotacao(mov-conta.de-valor,conta.cd-moeda,0,fnUltimoDia(iMes,iAno)) -
                                           fnCotacao(mov-conta.de-valor,conta.cd-moeda,0,mov-conta.dt-mov).
                    END.
    
                    IF deAnt = 0 THEN
                        ASSIGN deAnt = deMes
                               deVarCamb = 0.
    
                    ASSIGN deVarCamb = deVarCamb +
                                       fnCotacao(deAnt,conta.cd-moeda,0,fnUltimoDia(iMes,iAno)) -
                                       fnCotacao(deAnt,conta.cd-moeda,0,(DATE(iMes,1,iAno) - 1)).
    
                    ASSIGN tt-real.vl-jur = tt-real.vl-jur + deVarCamb.

                END.

            END.

        END.        

        IF tt-prev.vl-mes > 0
        AND tt-real.vl-mes > tt-prev.vl-mes THEN
            ASSIGN tt-real.vl-esp = tt-real.vl-esp + (tt-real.vl-mes - tt-prev.vl-mes)
                   tt-real.vl-mes = tt-prev.vl-mes.

        IF poupanca.calc-ir THEN DO:
            /* Calcula IR retido na fonte */
            ASSIGN tt-real.vl-ir = fnIR(tt-real.vl-jur,DATE(iMes,15,iAno)).
        END.

        ASSIGN tt-real.vl-acu = deReal + tt-real.vl-mes + tt-real.vl-esp + tt-real.vl-jur
               deReal = tt-real.vl-acu.

        CREATE tt-dif.
        ASSIGN tt-dif.mes = iMes
               tt-dif.ano = iAno
               tt-dif.vl-mes = tt-real.vl-mes - tt-prev.vl-mes
               tt-dif.vl-esp = tt-real.vl-esp - tt-prev.vl-esp
               tt-dif.vl-jur = tt-real.vl-jur - tt-prev.vl-jur
               tt-dif.vl-ir  = tt-prev.vl-ir  - tt-real.vl-ir
               tt-dif.vl-acu = tt-real.vl-acu - tt-prev.vl-acu.
    END.
END.

REPEAT iAno = ano-ini TO ano-fim:

    REPEAT iMes = IF ano-ini = iAno THEN mes-ini ELSE 1 TO IF ano-fim = iAno THEN mes-fim ELSE 12:

        FIND FIRST tt-prev
            WHERE tt-prev.mes = iMes
            AND   tt-prev.ano = iAno NO-ERROR.
        IF NOT AVAIL tt-prev THEN NEXT.
        FIND FIRST tt-real
            WHERE tt-real.mes = iMes
            AND   tt-real.ano = iAno.
        FIND FIRST tt-dif
            WHERE tt-dif.mes = iMes
            AND   tt-dif.ano = iAno.

        /* Controle de moeda */
        IF moeda <> 0 THEN DO:
            ASSIGN tt-prev.vl-mes = fnCotacao(tt-prev.vl-mes,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-prev.vl-esp = fnCotacao(tt-prev.vl-esp,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-prev.vl-jur = fnCotacao(tt-prev.vl-jur,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-prev.vl-ir = fnCotacao(tt-prev.vl-ir,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-prev.vl-acu = fnCotacao(tt-prev.vl-acu,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-real.vl-mes = fnCotacao(tt-real.vl-mes,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-real.vl-esp = fnCotacao(tt-real.vl-esp,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-real.vl-jur = fnCotacao(tt-real.vl-jur,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-real.vl-ir = fnCotacao(tt-real.vl-ir,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-real.vl-acu = fnCotacao(tt-real.vl-acu,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-dif.vl-mes = fnCotacao(tt-dif.vl-mes,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-dif.vl-esp = fnCotacao(tt-dif.vl-esp,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-dif.vl-jur = fnCotacao(tt-dif.vl-jur,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-dif.vl-ir = fnCotacao(tt-dif.vl-ir,0,moeda,DATE(mes-ini,15,ano-ini))
                   tt-dif.vl-acu = fnCotacao(tt-dif.vl-acu,0,moeda,DATE(mes-ini,15,ano-ini)).
        END.

        ASSIGN cTemp = fnMes(iMes) + "/" + STRING(iAno,"9999").
        {func\relat\titulo.i &Coluna1=cTemp
                             &Tamanho1=300
                             &Coluna2='"Previsto"'
                             &Tamanho2=100
                             &Coluna3='"Realizado"'
                             &Tamanho3=100
                             &Coluna4='"Diferenáa"'
                             &Tamanho4=100}
                             
        {func\relat\linha.i &Coluna1='"Contribuiá∆o Mensal"'
                            &Align1="left"
                            &Coluna2=tt-prev.vl-mes
                            &Align2="right"
                            &Coluna3=tt-real.vl-mes
                            &Align3="right"
                            &Coluna4=tt-dif.vl-mes
                            &Align4="right"}
                            
        {func\relat\linha.i &Coluna1='"Contribuiá∆o EspontÉnea"'
                            &Align1="left"
                            &Coluna2=tt-prev.vl-esp
                            &Align2="right"
                            &Coluna3=tt-real.vl-esp
                            &Align3="right"
                            &Coluna4=tt-dif.vl-esp
                            &Align4="right"}
                            
        {func\relat\linha.i &Coluna1='"Juros no Màs"'
                            &Align1="left"
                            &Coluna2=tt-prev.vl-jur
                            &Align2="right"
                            &Coluna3=tt-real.vl-jur
                            &Align3="right"
                            &Coluna4=tt-dif.vl-jur
                            &Align4="right"}
                                
        IF tt-prev.vl-ir <> 0 OR
           tt-real.vl-ir <> 0 THEN DO:
            {func\relat\linha.i &Coluna1='"IR"'
                                &Align1="left"
                                &Coluna2=tt-prev.vl-ir
                                &Align2="right"
                                &Coluna3=tt-real.vl-ir
                                &Align3="right"
                                &Coluna4=tt-dif.vl-ir
                                &Align4="right"}
        END.
        {func\relat\total.i &Coluna1='"Montante Acumulado"'
                            &Align1="left"
                            &Coluna2=tt-prev.vl-acu
                            &Align2="right"
                            &Coluna3=tt-real.vl-acu
                            &Align3="right"
                            &Coluna4=tt-dif.vl-acu
                            &Align4="right"}

    END.

END.

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
{func/cb-lista.i cd-moeda moeda}

FIND LAST poupanca NO-LOCK NO-ERROR.

ASSIGN mes-ini = 1
       ano-ini = YEAR(TODAY)
       mes-fim = MONTH(TODAY)
       ano-fim = YEAR(TODAY)
       iPoup   = poupanca.cd-poupanca.

{func\relat\initialize.i}

{func\cursor.i iPoup}

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

