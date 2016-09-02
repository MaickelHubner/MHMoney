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

&GLOBAL-DEFINE FrameFields  data-ini data-fim moeda iConta des-conta tx-juro simula

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 IMAGE-6 RECT-10 RECT-11 ~
data-ini data-fim iConta des-conta moeda tx-juro btOK simula 
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim iConta des-conta moeda ~
tx-juro simula 

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

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE data-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE des-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .79 NO-UNDO.

DEFINE VARIABLE iConta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE tx-juro AS DECIMAL FORMAT "->>9.9999":U INITIAL .65 
     LABEL "Taxa de Juros" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.

DEFINE VARIABLE simula AS LOGICAL INITIAL no 
     LABEL "Considera Simulaá‰es" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .83 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 5.5 COL 73
     data-ini AT ROW 1.92 COL 27 COLON-ALIGNED
     data-fim AT ROW 2 COL 45 COLON-ALIGNED NO-LABEL
     iConta AT ROW 4 COL 11 COLON-ALIGNED
     des-conta AT ROW 4 COL 15.29 COLON-ALIGNED NO-LABEL
     moeda AT ROW 5 COL 11 COLON-ALIGNED
     tx-juro AT ROW 5 COL 55.29 COLON-ALIGNED
     btOK AT ROW 3.75 COL 73
     simula AT ROW 6.25 COL 32
     IMAGE-5 AT ROW 1.5 COL 38
     IMAGE-6 AT ROW 1.5 COL 42.43
     RECT-10 AT ROW 1.25 COL 2
     RECT-11 AT ROW 3.5 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.5
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
         HEIGHT             = 7.5
         WIDTH              = 80
         MAX-HEIGHT         = 9.42
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 9.42
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
       ROW             = 7.75
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(simula:HANDLE IN FRAME DEFAULT-FRAME).

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
                  &CampoProc = "ds-conta"
                  &Tela="des-conta"}  
                  
    IF AVAIL bfl-conta THEN DO:
        ASSIGN moeda = bfl-conta.cd-moeda.
        DISP moeda WITH FRAME {&FRAME-NAME}.
        IF bfl-conta.id-tipo <> 2 THEN
            DISABLE tx-juro WITH FRAME {&FRAME-NAME}.
        ELSE
            ENABLE tx-juro WITH FRAME {&FRAME-NAME}.
    END.
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


&Scoped-define SELF-NAME tx-juro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tx-juro C-Win
ON ENTRY OF tx-juro IN FRAME DEFAULT-FRAME /* Taxa de Juros */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tx-juro C-Win
ON LEAVE OF tx-juro IN FRAME DEFAULT-FRAME /* Taxa de Juros */
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

{func\calendar.i data-ini}
{func\calendar.i data-fim}

{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-conta
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = iConta}
                              
{ttmovto.i data-ini data-fim simula}

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
  {version.i r005}
  RUN enable_UI.
  RUN initialize.
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

OCXFile = SEARCH( "r005.wrx":U ).
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
ELSE MESSAGE "r005.wrx":U SKIP(1)
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
  DISPLAY data-ini data-fim iConta des-conta moeda tx-juro simula 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 RECT-11 data-ini data-fim iConta 
         des-conta moeda tx-juro btOK simula 
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

/* Output padr∆o */
{func\relat\ini.i 1}

/* L¢gica do relat¢rio */

FOR EACH tt-mov-conta:
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

ASSIGN deSaldo = fnCotacao(deSaldo,
                           conta.cd-moeda,
                           moeda,
                           data-ini).

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.dt-mov <= TODAY
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

    ASSIGN deSaldo = deSaldo + fnCotacao(mov-conta.de-valor,
                                         mov-conta.cd-moeda,
                                         moeda,
                                         mov-conta.dt-mov).

    FIND FIRST favorecido OF mov-conta NO-LOCK.
    ASSIGN cTemp = STRING(fnCotacao(mov-conta.de-valor,
                                    mov-conta.cd-moeda,
                                    moeda,
                                    mov-conta.dt-mov),"->>>>,>>>,>>9.99")
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
RUN prevFatPed.
ASSIGN iTotReg = chProgressBar:MAX
       iContReg = chProgressBar:VALUE.

FOR EACH tt-mov-conta WHERE tt-mov-conta.de-valor = 0:
    DELETE tt-mov-conta.
END.

FIND FIRST tt-mov-conta WHERE tt-mov-conta.dt-mov <= TODAY NO-ERROR.
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
    WHERE tt-mov-conta.dt-mov <= TODAY
    USE-INDEX data
    BREAK BY tt-mov-conta.dt-mov:

    ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,
                                         tt-mov-conta.cd-moeda,
                                         moeda,
                                         tt-mov-conta.dt-mov).

    FIND FIRST favorecido OF tt-mov-conta NO-LOCK.
    ASSIGN cTemp = STRING(fnCotacao(tt-mov-conta.de-valor,
                                    tt-mov-conta.cd-moeda,
                                    moeda,
                                    tt-mov-conta.dt-mov),"->>>>,>>>,>>9.99")
           cData = STRING(tt-mov-conta.dt-mov,"99/99/9999").
    IF FIRST-OF(tt-mov-conta.dt-mov) THEN DO:
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
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
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
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
FIND FIRST tt-mov-conta WHERE tt-mov-conta.dt-mov <= TODAY NO-ERROR.
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
    WHERE mov-conta.dt-mov >= TODAY
    AND   mov-conta.dt-mov <= data-fim
    AND   mov-conta.cd-conta = iConta
    AND   mov-conta.agrupado = 0
    AND   mov-conta.id-situacao <= 2
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
    WHERE tt-mov-conta.dt-mov > TODAY
    USE-INDEX data
    BREAK BY tt-mov-conta.dt-mov:

    IF MONTH(tt-mov-conta.dt-mov) <> iMes THEN DO:
        IF l-Imp THEN DO:
            FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK.
            IF conta.id-tipo = 2 THEN DO:
                ASSIGN cTemp = STRING(fnJuros(deSaldo,tx-juro),"->>>>,>>>,>>9.99")
                       deSaldo = deSaldo + fnJuros(deSaldo,tx-juro)
                       cData = STRING(fnUltimoDia(iMes,IF iMes <> 12 THEN YEAR(tt-mov-conta.dt-mov) ELSE (YEAR(tt-mov-conta.dt-mov) - 1)),"99/99/9999").
                {func\relat\linha.i &Coluna1=cData
                                    &Align1="left"
                                    &Coluna2='"Juros no Màs"'
                                    &Align2="left"
                                    &Coluna3=cTemp
                                    &Align3="right"
                                    &Coluna4=deSaldo
                                    &Align4="right"}
            END.
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

    ASSIGN deSaldo = deSaldo + fnCotacao(tt-mov-conta.de-valor,
                                         tt-mov-conta.cd-moeda,
                                         moeda,
                                         tt-mov-conta.dt-mov).
    
    FIND FIRST favorecido OF tt-mov-conta NO-LOCK.
    ASSIGN cTemp = STRING(fnCotacao(tt-mov-conta.de-valor,
                                    tt-mov-conta.cd-moeda,
                                    moeda,
                                    tt-mov-conta.dt-mov),"->>>>,>>>,>>9.99")
           cData = STRING(tt-mov-conta.dt-mov,"99/99/9999").
    IF FIRST-OF(tt-mov-conta.dt-mov) THEN DO:
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
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
        IF LAST-OF(tt-mov-conta.dt-mov) THEN DO:
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

FIND LAST tt-mov-conta USE-INDEX data NO-ERROR.
IF AVAIL tt-mov-conta THEN DO:
    FIND FIRST conta WHERE conta.cd-conta = iConta NO-LOCK.
    IF conta.id-tipo = 2 THEN DO:
        ASSIGN cTemp = STRING(fnJuros(deSaldo,tx-juro),"->>>>,>>>,>>9.99")
               deSaldo = deSaldo + fnJuros(deSaldo,tx-juro)
               cData = STRING(fnUltimoDia(iMes,IF iMes <> 12 THEN YEAR(tt-mov-conta.dt-mov) ELSE (YEAR(tt-mov-conta.dt-mov) - 1)),"99/99/9999").
        {func\relat\linha.i &Coluna1=cData
                            &Align1="left"
                            &Coluna2='"Juros no Màs"'
                            &Align2="left"
                            &Coluna3=cTemp
                            &Align3="right"
                            &Coluna4=deSaldo
                            &Align4="right"}
    END.
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
{func/cb-lista.i cd-moeda moeda}

FIND FIRST conta NO-LOCK
    WHERE conta.id-tipo = 1
    AND   NOT conta.id-encerrada.

ASSIGN data-ini = TODAY
       data-fim = TODAY + 90
       iConta = conta.cd-conta.

FOR EACH agenda NO-LOCK
    WHERE agenda.dt-fim >= TODAY
    AND   agenda.prox-data-pag < data-ini:

    IF NOT CAN-FIND(FIRST agenda-valor
                    WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                    AND   agenda-valor.dt-ini <= agenda.prox-data-pag
                    AND   agenda-valor.dt-end >= agenda.prox-data-pag) THEN NEXT.
    IF agenda.prox-data-pag < data-ini THEN
        ASSIGN data-ini = agenda.prox-data-pag.
END.

IF param-mn.perfil = 2 /* Empresarial */ THEN DO:
    FOR EACH parc-nota-fiscal NO-LOCK
        WHERE parc-nota-fiscal.situacao = 1 /* Pendente */:
        IF parc-nota-fiscal.dt-pagto-parc < data-ini THEN
            ASSIGN data-ini = parc-nota-fiscal.dt-parcela.
    END.
END.

{func\relat\initialize.i}

{func\cursor.i iConta}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE leaveObject C-Win 
PROCEDURE leaveObject :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER cObject AS CHARACTER  NO-UNDO.

IF cObject = "des-conta" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} des-conta NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN iConta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.

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
    FIND FIRST conta NO-LOCK
        WHERE conta.cd-conta = INPUT FRAME {&FRAME-NAME} iConta NO-ERROR.
    IF NOT AVAIL conta THEN DO:
        {func\valida.i &Mensagem  = "Conta inv†lida!"
                       &Ajuda     = "N∆o foi informada uma conta v†lida."
                       &Campo     = iConta}
    END.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

