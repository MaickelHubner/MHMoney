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
/* Pr‚-processadores */

&GLOBAL-DEFINE FrameFields  mes-ini ano-ini mes-fim ano-fim moeda cat sub anual simula

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}
{func\tt_graf.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 IMAGE-6 RECT-10 mes-ini ~
ano-ini mes-fim ano-fim cat sub moeda anual simula btOK 
&Scoped-Define DISPLAYED-OBJECTS mes-ini ano-ini mes-fim ano-fim cat sub ~
moeda anual simula 

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

DEFINE VARIABLE cat AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE mes-fim AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Mar‡o",3,
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
     LABEL "Per¡odo" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Mar‡o",3,
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
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE sub AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Sub-Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Todas",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE ano-fim AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE ano-ini AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 6.5.

DEFINE VARIABLE anual AS LOGICAL INITIAL no 
     LABEL "Resumo Anual" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE simula AS LOGICAL INITIAL no 
     LABEL "Simula Valor at‚ Final do Ano" 
     VIEW-AS TOGGLE-BOX
     SIZE 23 BY .83 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 5.75 COL 73
     mes-ini AT ROW 2 COL 16 COLON-ALIGNED WIDGET-ID 8
     ano-ini AT ROW 2 COL 32.29 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     mes-fim AT ROW 2 COL 45 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ano-fim AT ROW 2 COL 61.29 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     cat AT ROW 3 COL 27 COLON-ALIGNED
     sub AT ROW 4 COL 27 COLON-ALIGNED
     moeda AT ROW 5 COL 27 COLON-ALIGNED
     anual AT ROW 6 COL 29 WIDGET-ID 10
     simula AT ROW 6.75 COL 29 WIDGET-ID 12
     btOK AT ROW 4 COL 73
     IMAGE-5 AT ROW 1.63 COL 38.14
     IMAGE-6 AT ROW 1.63 COL 42.57
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.92
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
         TITLE              = "Gr fico"
         HEIGHT             = 7.92
         WIDTH              = 80
         MAX-HEIGHT         = 10.71
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 10.71
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
THEN C-Win:HIDDEN = yes.

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
       ROW             = 8
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(simula:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Gr fico */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Gr fico */
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


&Scoped-define SELF-NAME anual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL anual C-Win
ON VALUE-CHANGED OF anual IN FRAME DEFAULT-FRAME /* Resumo Anual */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} anual THEN DO:
        ENABLE simula
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE simula
            WITH FRAME {&FRAME-NAME}.
        ASSIGN simula:CHECKED IN FRAME {&FRAME-NAME} = FALSE.
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


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* Executar */
DO:
    {func\graf\bt_executar.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cat C-Win
ON ENTRY OF cat IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cat C-Win
ON LEAVE OF cat IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cat C-Win
ON VALUE-CHANGED OF cat IN FRAME DEFAULT-FRAME /* Categoria */
DO:
  
    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    ASSIGN cLista = "Todos,0".
    FOR EACH sub-cat NO-LOCK
        WHERE sub-cat.cod-categoria = INPUT FRAME {&FRAME-NAME} cat
        BY sub-cat.ds-sub:

        ASSIGN cLista = cLista + "," + REPLACE(sub-cat.ds-sub,",",";") + "," + STRING(sub-cat.cd-sub).

    END.
    ASSIGN sub:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = cLista.

    IF LOOKUP(STRING(sub),cLista) = 0 THEN
        ASSIGN sub = 0.

    DISPLAY sub WITH FRAME {&FRAME-NAME}.

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
ON ENTRY OF mes-ini IN FRAME DEFAULT-FRAME /* Per¡odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ini C-Win
ON LEAVE OF mes-ini IN FRAME DEFAULT-FRAME /* Per¡odo */
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


&Scoped-define SELF-NAME sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub C-Win
ON ENTRY OF sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub C-Win
ON LEAVE OF sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\graf\main_block.i}

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
  {version.i g019}
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

OCXFile = SEARCH( "g019.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "g019.wrx":U SKIP(1)
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

DISPLAY cat WITH FRAME {&FRAME-NAME}.
APPLY "VALUE-CHANGED" TO cat.

{func\relat\display.i}

APPLY "VALUE-CHANGED" TO anual.

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
  DISPLAY mes-ini ano-ini mes-fim ano-fim cat sub moeda anual simula 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 mes-ini ano-ini mes-fim ano-fim cat 
         sub moeda anual simula btOK 
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
/* Defini‡Æo de vari veis */
{func\graf\var.i}

DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
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

/* Controle da ProgressBar */
IF NOT anual THEN
    ASSIGN iAno = INT((data-fim - data-ini) / 30) + 1.
ELSE
    ASSIGN iAno = YEAR(data-fim) - YEAR(data-ini) + 1.
{func\relat\ini-prg-bar.i iAno}

/* L¢gica do relat¢rio */
ASSIGN tt-graf-par.valor-label[1] = "Valor".

FIND FIRST categoria NO-LOCK
    WHERE categoria.cod-categoria = cat.

ASSIGN tt-graf-par.dado-label = "Per¡odo".
IF sub = 0 THEN DO:
    ASSIGN tt-graf-par.titulo = "Movimenta‡Æo da Categoria " + categoria.ds-categoria.
END.
ELSE DO:
    FIND FIRST sub-cat OF categoria NO-LOCK
        WHERE sub-cat.cd-sub = sub.
    ASSIGN tt-graf-par.titulo = "Movimenta‡Æo da Sub-Categoria " + categoria.ds-categoria + ":" + sub-cat.ds-sub.
END.

IF iAno > 12 THEN
    ASSIGN tt-graf-par.mostra-valores[1] = NO.
ELSE
    ASSIGN tt-graf-par.mostra-valores[1] = YES.

IF NOT anual THEN DO:
    ASSIGN iTemp = 1.
    REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):
        REPEAT iMes = IF YEAR(data-ini) <> iAno THEN 1 ELSE MONTH(data-ini) TO IF YEAR(data-fim) <> iAno THEN 12 ELSE MONTH(data-fim):

            {func\relat\control.i}

            CREATE tt-graf.
            ASSIGN tt-graf.dado = fnMes(iMes) + "/" + SUBSTRING(STRING(iAno,"9999"),3,2)
                   tt-graf.seq  = iTemp
                   iTemp = iTemp + 1.

            ASSIGN dtTemp = fnUltimoDia(iMes,iAno).

            FOR EACH mov-conta NO-LOCK
                WHERE mov-conta.dt-mov >= DATE(iMes,1,iAno)
                AND   mov-conta.dt-mov <= dtTemp
                AND   mov-conta.id-tipo <> 3
                AND   mov-conta.id-tipo <> 0
                AND   mov-conta.cod-categoria = cat
                AND   (IF sub <> 0 THEN mov-conta.cd-sub = sub ELSE TRUE):

                ASSIGN tt-graf.valor[1] = tt-graf.valor[1] + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

            END.

        END.
    END.
END.
ELSE DO:
    ASSIGN iTemp = 1.
    REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):

        {func\relat\control.i}

        CREATE tt-graf.
        ASSIGN tt-graf.dado = STRING(iAno,"9999")
               tt-graf.seq  = iTemp
               iTemp = iTemp + 1.

        FOR EACH mov-conta NO-LOCK
            WHERE mov-conta.dt-mov >= DATE(1,1,iAno)
            AND   mov-conta.dt-mov <= DATE(12,31,iAno)
            AND   mov-conta.id-tipo <> 3
            AND   mov-conta.id-tipo <> 0
            AND   mov-conta.cod-categoria = cat
            AND   (IF sub <> 0 THEN mov-conta.cd-sub = sub ELSE TRUE):

            ASSIGN tt-graf.valor[1] = tt-graf.valor[1] + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

        END.

        IF simula THEN DO:
            IF iAno = YEAR(TODAY) THEN DO:
                ASSIGN tt-graf.valor[1] = ((tt-graf.valor[1] / mes-fim) * 12).
            END.
        END.

    END.
END.

IF categoria.id-tipo = 2 THEN DO:
    FOR EACH tt-graf:
        ASSIGN tt-graf.valor[1] = (-1) * tt-graf.valor[1].
    END.
END.

/* Exibe o Gr fico */
{func\graf\end.i}

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

DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

{func/cb-lista.i cd-moeda moeda}

ASSIGN mes-ini = 1
       ano-ini = YEAR(TODAY)
       mes-fim = MONTH(TODAY)
       ano-fim = YEAR(TODAY).

ASSIGN cLista = "".
FOR EACH categoria NO-LOCK
    BY categoria.ds-categoria:

    IF cLista = "" THEN
        ASSIGN cLista = categoria.ds-categoria + "," + STRING(categoria.cod-categoria).
    ELSE
        ASSIGN cLista = cLista + "," + categoria.ds-categoria + "," + STRING(categoria.cod-categoria).

END.
ASSIGN cat:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = cLista
       cat = INT(ENTRY(2,cLista)).

{func\relat\initialize.i}

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

