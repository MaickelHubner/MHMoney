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
/* Pr�-processadores */

&GLOBAL-DEFINE FrameFields  mes-ini ano-ini mes-fim ano-fim moeda iPoup

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

DEFINE TEMP-TABLE tt-roi
    FIELD mes AS INTEGER
    FIELD ano AS INTEGER
    FIELD vl-ant AS DECIMAL
    FIELD vl-jur AS DECIMAL
    FIELD taxa AS DECIMAL FORMAT "->>>>9.9999".

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
                     "Mar�o",3,
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
     LABEL "Per�odo" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Mar�o",3,
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
     SIZE 36 BY .79 NO-UNDO.

DEFINE VARIABLE iPoup AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Poupan�a" 
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
     mes-ini AT ROW 3 COL 19 COLON-ALIGNED WIDGET-ID 8
     ano-ini AT ROW 3 COL 35.29 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     mes-fim AT ROW 3 COL 48 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ano-fim AT ROW 3 COL 64.29 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     moeda AT ROW 4 COL 19 COLON-ALIGNED
     btOK AT ROW 2 COL 73
     IMAGE-5 AT ROW 2.63 COL 41
     IMAGE-6 AT ROW 2.63 COL 45.43
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
         TITLE              = "Template Padr�o de Relat�rio"
         HEIGHT             = 5.75
         WIDTH              = 80
         MAX-HEIGHT         = 29.75
         MAX-WIDTH          = 145.57
         VIRTUAL-HEIGHT     = 29.75
         VIRTUAL-WIDTH      = 145.57
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
ON END-ERROR OF C-Win /* Template Padr�o de Relat�rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr�o de Relat�rio */
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
ON ENTRY OF iPoup IN FRAME DEFAULT-FRAME /* Poupan�a */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iPoup C-Win
ON LEAVE OF iPoup IN FRAME DEFAULT-FRAME /* Poupan�a */
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
ON MOUSE-SELECT-DBLCLICK OF iPoup IN FRAME DEFAULT-FRAME /* Poupan�a */
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
ON ENTRY OF mes-ini IN FRAME DEFAULT-FRAME /* Per�odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON LEAVE OF mes-ini IN FRAME DEFAULT-FRAME /* Per�odo */
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
  {version.i r034}
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

OCXFile = SEARCH( "r034.wrx":U ).
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
ELSE MESSAGE "r034.wrx":U SKIP(1)
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

/* Defini��o das vari�veis */
{func\relat\var.i}

FOR EACH tt-roi:
    DELETE tt-roi.
END.

FIND FIRST poupanca NO-LOCK
    WHERE poupanca.cd-poupanca = iPoup NO-ERROR.

DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE dtPrim AS DATE       NO-UNDO.
DEFINE VARIABLE deReal AS DECIMAL    NO-UNDO.
DEFINE VARIABLE cOque AS CHARACTER  NO-UNDO FORMAT "X(20)".
DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO FORMAT "->>>>9.9999".
DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE deAux AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deVarCamb AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deAnt AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deMes AS DECIMAL    NO-UNDO.
DEFINE VARIABLE lComeca AS LOGICAL     NO-UNDO.
DEFINE VARIABLE data-ini AS DATE    NO-UNDO.
DEFINE VARIABLE data-fim AS DATE    NO-UNDO.

ASSIGN data-ini = DATE(mes-ini,1,ano-ini)
       data-fim = fnUltimoDia(mes-fim,ano-fim).

/* Acerto de datas */
FIND FIRST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-ini = mov-conta.dt-mov.
FIND LAST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov <= data-fim USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-fim = mov-conta.dt-mov.

/* Output padr�o */
ASSIGN iAno = (INT((data-fim - data-ini) / 30) + 1) * 2.
{func\relat\ini.i iAno}

/* L�gica do relat�rio */

ASSIGN cTemp = "Poupan�a: " + STRING(iPoup,"999") + " - " + poupanca.ds-poupanca + "<br>" +
               "Per�odo: " + STRING(MONTH(data-ini),"99") + "/" + STRING(YEAR(data-ini),"9999") + " at� " + STRING(MONTH(data-fim),"99") + "/" + STRING(YEAR(data-fim),"9999").
{func\relat\capitulo.i cTemp 650}

IF NOT CAN-FIND(FIRST item-poupanca OF poupanca
                WHERE item-poupanca.ano >= YEAR(data-ini)) THEN DO:
    {func\relat\total.i &Coluna1='"N�o existe previs�o de poupan�a no per�odo selecionado."'
                         &Tamanho1=600}
    {func\relat\end-capitulo.i}
    {func\relat\end.i}
    RETURN "NOK":U.
END.

{func\relat\titulo.i &Coluna1=''
                     &Tamanho1=200
                     &Coluna2='"Vl Anterior"'
                     &Tamanho2=150
                     &Coluna3='"Juro"'
                     &Tamanho3=150
                     &Coluna4='"Taxa de Retorno"'
                     &Tamanho4=150}
                         
ASSIGN dtPrim = (DATE(MONTH(data-ini),1,YEAR(data-ini)) - 1).

FOR EACH poup-conta NO-LOCK
    WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca:

    ASSIGN deReal = 0.

    FIND FIRST conta WHERE conta.cd-conta = poup-conta.cd-conta NO-LOCK.

    FIND FIRST item-poupanca OF poupanca NO-LOCK NO-ERROR.
    IF NOT AVAIL item-poupanca THEN NEXT.

    ASSIGN lComeca = NO.

    FOR EACH mov-conta OF conta NO-LOCK USE-INDEX valor
        WHERE mov-conta.dt-mov >= DATE(1,1,item-poupanca.ano)
        AND   mov-conta.dt-mov <= dtPrim
        BREAK BY mov-conta.dt-mov:

        IF FIRST-OF(mov-conta.dt-mov) THEN DO:
            IF mov-conta.cd-favorecido = poupanca.cd-fav-padrao THEN
                ASSIGN lComeca = YES.
        END.

        IF lComeca THEN
            ASSIGN deReal = deReal + mov-conta.de-valor.

    END.

    ASSIGN deReal = fnCotacao(deReal,conta.cd-moeda,0,dtPrim).

    ASSIGN deAux = deAux + deReal.

END.

ASSIGN deReal = deAux.

REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):
    FIND FIRST item-poupanca OF poupanca
        WHERE item-poupanca.ano = iAno NO-LOCK NO-ERROR.
    IF NOT AVAIL item-poupanca THEN NEXT.
    REPEAT iMes = IF YEAR(data-ini) = iAno THEN MONTH(data-ini) ELSE 1 TO IF YEAR(data-fim) = iAno THEN MONTH(data-fim) ELSE 12:

        {func\relat\control.i}

        CREATE tt-roi.
        ASSIGN tt-roi.mes = iMes
               tt-roi.ano = iAno
               tt-roi.vl-ant = deReal.

        FOR EACH poup-conta NO-LOCK
            WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca:

            FIND FIRST conta WHERE conta.cd-conta = poup-conta.cd-conta NO-LOCK.

            FOR EACH mov-conta OF conta NO-LOCK
                WHERE MONTH(mov-conta.dt-mov) = iMes
                AND   YEAR(mov-conta.dt-mov) = iAno
                AND   mov-conta.id-tipo <> 0:

                IF mov-conta.id-tipo <> 3 THEN DO:

                    FIND FIRST categoria WHERE categoria.cod-categoria = mov-conta.cod-categoria NO-LOCK.
                    FIND FIRST sub-cat OF categoria WHERE sub-cat.cd-sub = mov-conta.cd-sub NO-LOCK.

                    IF categoria.ds-cat MATCHES("*JURO*")
                    OR sub-cat.ds-sub MATCHES("*JURO*") THEN DO:
                        ASSIGN tt-roi.vl-jur = tt-roi.vl-jur + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                    END.
                    ELSE DO:
                        ASSIGN deReal = deReal + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,fnUltimoDia(iMes,iAno)).
                    END.

                END.
                ELSE DO:
                    IF mov-conta.cd-favorecido = poupanca.cd-fav-padrao
                    OR deReal > 0 THEN DO:
                        IF NOT CAN-FIND(FIRST poup-conta NO-LOCK
                                        WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca
                                        AND   poup-conta.cd-conta = mov-conta.conta-transf) THEN DO:
                            ASSIGN deReal = deReal + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,0,mov-conta.dt-mov).
                        END.
                    END.
                END.

            END.

            IF conta.cd-moeda <> 0 THEN DO:
                ASSIGN deAnt = 0
                       deVarCamb = 0.
                FOR EACH mov-conta OF conta NO-LOCK
                    WHERE mov-conta.dt-mov < DATE(iMes,1,iAno):
                    ASSIGN deAnt = deAnt + mov-conta.de-valor.
                END.
                ASSIGN deMes = deAnt.
                FOR EACH mov-conta OF conta NO-LOCK
                    WHERE MONTH(mov-conta.dt-mov) = iMes
                    AND   YEAR(mov-conta.dt-mov) = iAno:
                    ASSIGN deMes = deMes + mov-conta.de-valor.
                    ASSIGN deVarCamb = deVarCamb +
                                       fnCotacao(mov-conta.de-valor,conta.cd-moeda,0,fnUltimoDia(iMes,iAno)) -
                                       fnCotacao(mov-conta.de-valor,conta.cd-moeda,0,mov-conta.dt-mov).
                END.
                IF deAnt = 0 THEN
                    ASSIGN deAnt = deMes.

                ASSIGN deVarCamb = deVarCamb +
                                   fnCotacao(deAnt,conta.cd-moeda,0,fnUltimoDia(iMes,iAno)) -
                                   fnCotacao(deAnt,conta.cd-moeda,0,(DATE(iMes,1,iAno) - 1)).

                ASSIGN tt-roi.vl-jur = tt-roi.vl-jur + deVarCamb.
        
            END.

        END.

        ASSIGN deReal = deReal + tt-roi.vl-jur
               tt-roi.taxa = IF tt-roi.vl-ant <> 0 THEN ((tt-roi.vl-jur / tt-roi.vl-ant) * 100) ELSE 0.

    END.
END.

IF moeda <> 0 THEN DO:
    FOR EACH tt-roi:
        ASSIGN tt-roi.vl-ant = fnCotacao(tt-roi.vl-ant,0,moeda,DATE(tt-roi.mes,10,tt-roi.ano))
               tt-roi.vl-jur = fnCotacao(tt-roi.vl-jur,0,moeda,DATE(tt-roi.mes,10,tt-roi.ano)).
    END.
END.

ASSIGN deTotal = 0.

REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):

    REPEAT iMes = IF YEAR(data-ini) = iAno THEN MONTH(data-ini) ELSE 1 TO IF YEAR(data-fim) = iAno THEN MONTH(data-fim) ELSE 12:

        {func\relat\control.i}

        FIND FIRST tt-roi
            WHERE tt-roi.mes = iMes
            AND   tt-roi.ano = iAno NO-ERROR.
        IF NOT AVAIL tt-roi THEN NEXT.

        ASSIGN cOque = fnMes(iMes) + "/" + STRING(iAno,"9999").

        
        {func\relat\linha.i &Coluna1=cOque
                            &Align1="left"
                            &Coluna2=tt-roi.vl-ant
                            &Align2="right"
                            &Coluna3=tt-roi.vl-jur
                            &Align3="right"
                            &Coluna4=tt-roi.taxa
                            &Align4="right"}

        ASSIGN deTotal = deTotal + tt-roi.taxa.

    END.

END.

{func\relat\total.i &Coluna1='"Retorno Total"'
                    &Align1="left"
                    &Coluna2=''
                    &Align2="right"
                    &Coluna3=''
                    &Align3="right"
                    &Coluna4=deTotal
                    &Align4="right"}

{func\relat\end-capitulo.i}

/* Fecha Output padr�o */
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

FIND FIRST poupanca NO-LOCK
    WHERE CAN-FIND(FIRST item-poupanca OF poupanca
                   WHERE item-poupanca.ano = YEAR(TODAY)) NO-ERROR.

ASSIGN mes-ini = 1
       ano-ini = YEAR(TODAY)
       mes-fim = MONTH(TODAY)
       ano-fim = YEAR(TODAY)
       iPoup    = poupanca.cd-poupanca.

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

