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

DEFINE TEMP-TABLE tt-mov
    FIELD categoria AS INTEGER
    FIELD sub-cat AS INTEGER
    FIELD valor AS DECIMAL FORMAT "->>>>,>>9.99"
    FIELD meses AS INTEGER
    FIELD ult-mes AS INTEGER
    FIELD ult-ano AS INTEGER
    FIELD vl-ult AS DECIMAL FORMAT "->>>>,>>9.99".

/* Parameters Definitions ---                                           */
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  data-ini data-fim moeda

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 btOK IMAGE-6 RECT-10 ~
data-ini data-fim moeda 
&Scoped-Define DISPLAYED-OBJECTS data-ini data-fim moeda 

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
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 28 BY 1 NO-UNDO.

DEFINE VARIABLE data-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 3.25 COL 73
     btOK AT ROW 1.5 COL 73
     data-ini AT ROW 2 COL 24 COLON-ALIGNED
     data-fim AT ROW 2 COL 42 COLON-ALIGNED NO-LABEL
     moeda AT ROW 3 COL 24 COLON-ALIGNED
     IMAGE-5 AT ROW 1.58 COL 35
     IMAGE-6 AT ROW 1.58 COL 39.43
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 5.25
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
         TITLE              = "Relat¢rio"
         HEIGHT             = 5.25
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
       ROW             = 5.5
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(moeda:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Relat¢rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Relat¢rio */
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

{func\calendar.i data-ini}
{func\calendar.i data-fim}

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
  {version.i r031}
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

OCXFile = SEARCH( "r031.wrx":U ).
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
ELSE MESSAGE "r031.wrx":U SKIP(1)
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
  DISPLAY data-ini data-fim moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 btOK IMAGE-6 RECT-10 data-ini data-fim moeda 
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

FOR EACH tt-mov:
    DELETE tt-mov.
END.

/*
DEFINE VARIABLE data-fim AS DATE       NO-UNDO.
DEFINE VARIABLE dePorMes AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
*/
DEFINE VARIABLE iMax AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER FORMAT "X(256)" NO-UNDO.
DEFINE VARIABLE lFirst AS LOGICAL    NO-UNDO INITIAL YES.
DEFINE VARIABLE iNumMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE deTPorMes AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE deTAbs AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE deTemp AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE deAbs AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE cUlt AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.

/* Acerto de datas */
FIND FIRST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-ini = mov-conta.dt-mov.
FIND LAST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov <= data-fim USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-fim = mov-conta.dt-mov.

/* Output padr∆o */
SELECT COUNT(*) INTO iMax FROM categoria.
ASSIGN iMax = iMax + 1.
{func\relat\ini.i iMax}

/* L¢gica do relat¢rio */

ASSIGN cTemp = "De: " + STRING(data-ini,"99/99/9999") + " AtÇ: " + STRING(data-fim,"99/99/9999").
{func\relat\capitulo.i cTemp 800}

{func\relat\control.i}
FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini
    AND   mov-conta.dt-mov <= data-fim
    AND   mov-conta.id-tipo <> 3
    BY mov-conta.dt-mov:

    IF lFirst THEN
        ASSIGN data-ini = mov-conta.dt-mov
               lFirst = NO.

    FIND FIRST tt-mov 
        WHERE tt-mov.categoria = mov-conta.cod-categoria
        AND   tt-mov.sub-cat   = mov-conta.cd-sub NO-ERROR.

    IF NOT AVAIL tt-mov THEN DO:
        CREATE tt-mov.
        ASSIGN tt-mov.categoria = mov-conta.cod-categoria
               tt-mov.sub-cat   = mov-conta.cd-sub.
    END.

    IF MONTH(mov-conta.dt-mov) <> tt-mov.ult-mes 
    OR YEAR(mov-conta.dt-mov) <> tt-mov.ult-ano THEN DO:
        ASSIGN tt-mov.ult-mes = MONTH(mov-conta.dt-mov)
               tt-mov.ult-ano = YEAR(mov-conta.dt-mov)
               tt-mov.meses = tt-mov.meses + 1
               tt-mov.vl-ult = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
    END.
    ELSE DO:
        ASSIGN tt-mov.vl-ult = tt-mov.vl-ult + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
    END.

    ASSIGN tt-mov.valor = tt-mov.valor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

END.

ASSIGN iNumMes = 0.
REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):
    REPEAT iMes = IF YEAR(data-ini) <> iAno THEN 1 ELSE MONTH(data-ini) TO IF YEAR(data-fim) <> iAno THEN 12 ELSE MONTH(data-fim):
        ASSIGN iNumMes = iNumMes + 1.
    END.
END.
IF (data-fim - data-ini) < (iNumMes * 30) THEN ASSIGN iNumMes = iNumMes - 1.

ASSIGN cTemp = "Total de Meses Considerados: " + STRING(iNumMes).
{func\relat\total.i &Coluna1=cTemp
                    &Align1="left"}
                            
{func\relat\end-capitulo.i}
{func\relat\capitulo.i '"Rendimentos"' 800}

ASSIGN deTPorMes = 0
       deTAbs = 0.

FOR EACH categoria NO-LOCK
    WHERE categoria.id-tipo = 1
    BY ds-categoria:

    {func\relat\control.i}

    ASSIGN deTemp = 0
           deAbs = 0
           lFirst = YES.
    FOR EACH sub-cat WHERE sub-cat.cod-categoria = categoria.cod-categoria NO-LOCK
        BY ds-sub:

        FIND FIRST tt-mov 
            WHERE tt-mov.categoria = categoria.cod-categoria
            AND   tt-mov.sub-cat = sub-cat.cd-sub NO-ERROR.
        IF AVAIL tt-mov THEN DO:
            IF lFirst THEN DO:
                {func\relat\titulo.i &Coluna1=categoria.ds-categoria
                                     &Tamanho1=280
                                     &Coluna2='"Valor Total"'
                                     &Tamanho2=100
                                     &Coluna3='"Por Màs"'
                                     &Tamanho3=100
                                     &Coluna4='"Meses"'
                                     &Tamanho4=60
                                     &Coluna5='"Valor Abs."'
                                     &Tamanho5=100
                                     &Coluna6='"Ult.Mov"'
                                     &Tamanho6=60
                                     &Coluna7='"Valor"'
                                     &Tamanho7=100}
                ASSIGN lFirst = NO.
            END.
            CASE tt-mov.ult-mes:
                WHEN 1 THEN ASSIGN cUlt = "JAN".
                WHEN 2 THEN ASSIGN cUlt = "FEV".
                WHEN 3 THEN ASSIGN cUlt = "MAR".
                WHEN 4 THEN ASSIGN cUlt = "ABR".
                WHEN 5 THEN ASSIGN cUlt = "MAI".
                WHEN 6 THEN ASSIGN cUlt = "JUN".
                WHEN 7 THEN ASSIGN cUlt = "JUL".
                WHEN 8 THEN ASSIGN cUlt = "AGO".
                WHEN 9 THEN ASSIGN cUlt = "SET".
                WHEN 10 THEN ASSIGN cUlt = "OUT".
                WHEN 11 THEN ASSIGN cUlt = "NOV".
                WHEN 12 THEN ASSIGN cUlt = "DEZ".
            END CASE.
            ASSIGN cUlt = cUlt + "/" + STRING(tt-mov.ult-ano,"9999").
            {func\relat\linha.i &Coluna1=sub-cat.ds-sub
                                &Align1="left"
                                &Coluna2=tt-mov.valor
                                &Align2="right"
                                &Coluna3="(tt-mov.valor / iNumMes)"
                                &Align3="right"
                                &Coluna4=tt-mov.meses
                                &Align4="right"
                                &Coluna5="(tt-mov.valor / tt-mov.meses)"
                                &Align5="right"
                                &Coluna6=cUlt
                                &Align6="left"
                                &Coluna7=tt-mov.vl-ult
                                &Align7="right"}
            ASSIGN deTemp = deTemp + tt-mov.valor
                   deAbs = deAbs + (tt-mov.valor / tt-mov.meses).
        END.

    END.

    IF NOT lFirst THEN DO:
        {func\relat\total.i &Coluna1='"TOTAL"'
                            &Align1="left"
                            &Coluna2=deTemp
                            &Align2="right"
                            &Coluna3="(deTemp / iNumMes)"
                            &Align3="right"
                            &Coluna4=''
                            &Align4="right"
                            &Coluna5=deAbs
                            &Align5="right"
                            &Coluna6=''
                            &Align6="left"
                            &Coluna7=''
                            &Align7="right"}

        ASSIGN deTPorMes = deTPorMes + deTemp
               deTAbs = deTAbs + deAbs.
    END.

END.

{func\relat\total.i &Coluna1='"Total de Rendimentos"'
                    &Align1="left"
                    &Coluna2=deTPorMes
                    &Align2="right"
                    &Coluna3="(deTPorMes / iNumMes)"
                    &Align3="right"
                    &Coluna4=''
                    &Align4="right"
                    &Coluna5=deTAbs
                    &Align5="right"
                    &Coluna6=''
                    &Align6="left"
                    &Coluna7=''
                    &Align7="right"}
                    
{func\relat\end-capitulo.i}
{func\relat\capitulo.i '"Despesas"' 800}

ASSIGN deTPorMes = 0
       deTAbs = 0.

FOR EACH categoria NO-LOCK
    WHERE categoria.id-tipo = 2
    BY ds-categoria:

    {func\relat\control.i}

    ASSIGN deTemp = 0
           deAbs = 0
           lFirst = YES.
    FOR EACH sub-cat WHERE sub-cat.cod-categoria = categoria.cod-categoria NO-LOCK
        BY ds-sub:

        FIND FIRST tt-mov 
            WHERE tt-mov.categoria = categoria.cod-categoria
            AND   tt-mov.sub-cat = sub-cat.cd-sub NO-ERROR.
        IF AVAIL tt-mov THEN DO:
            IF lFirst THEN DO:
                {func\relat\titulo.i &Coluna1=categoria.ds-categoria
                                     &Tamanho1=280
                                     &Coluna2='"Valor Total"'
                                     &Tamanho2=100
                                     &Coluna3='"Por Màs"'
                                     &Tamanho3=100
                                     &Coluna4='"Meses"'
                                     &Tamanho4=60
                                     &Coluna5='"Valor Abs."'
                                     &Tamanho5=100
                                     &Coluna6='"Ult.Mov"'
                                     &Tamanho6=60
                                     &Coluna7='"Valor"'
                                     &Tamanho7=100}
                ASSIGN lFirst = NO.
            END.
            CASE tt-mov.ult-mes:
                WHEN 1 THEN ASSIGN cUlt = "JAN".
                WHEN 2 THEN ASSIGN cUlt = "FEV".
                WHEN 3 THEN ASSIGN cUlt = "MAR".
                WHEN 4 THEN ASSIGN cUlt = "ABR".
                WHEN 5 THEN ASSIGN cUlt = "MAI".
                WHEN 6 THEN ASSIGN cUlt = "JUN".
                WHEN 7 THEN ASSIGN cUlt = "JUL".
                WHEN 8 THEN ASSIGN cUlt = "AGO".
                WHEN 9 THEN ASSIGN cUlt = "SET".
                WHEN 10 THEN ASSIGN cUlt = "OUT".
                WHEN 11 THEN ASSIGN cUlt = "NOV".
                WHEN 12 THEN ASSIGN cUlt = "DEZ".
            END CASE.
            ASSIGN cUlt = cUlt + "/" + STRING(tt-mov.ult-ano,"9999").
            {func\relat\linha.i &Coluna1=sub-cat.ds-sub
                                &Align1="left"
                                &Coluna2=tt-mov.valor
                                &Align2="right"
                                &Coluna3="(tt-mov.valor / iNumMes)"
                                &Align3="right"
                                &Coluna4=tt-mov.meses
                                &Align4="right"
                                &Coluna5="(tt-mov.valor / tt-mov.meses)"
                                &Align5="right"
                                &Coluna6=cUlt
                                &Align6="left"
                                &Coluna7=tt-mov.vl-ult
                                &Align7="right"}
            ASSIGN deTemp = deTemp + tt-mov.valor
                   deAbs = deAbs + (tt-mov.valor / tt-mov.meses).
        END.

    END.

    IF NOT lFirst THEN DO:
        {func\relat\total.i &Coluna1='"TOTAL"'
                            &Align1="left"
                            &Coluna2=deTemp
                            &Align2="right"
                            &Coluna3="(deTemp / iNumMes)"
                            &Align3="right"
                            &Coluna4=''
                            &Align4="right"
                            &Coluna5=deAbs
                            &Align5="right"
                            &Coluna6=''
                            &Align6="left"
                            &Coluna7=''
                            &Align7="right"}

        ASSIGN deTPorMes = deTPorMes + deTemp
               deTAbs = deTAbs + deAbs.
    END.

END.

{func\relat\total.i &Coluna1='"Total de Despesas"'
                    &Align1="left"
                    &Coluna2=deTPorMes
                    &Align2="right"
                    &Coluna3="(deTPorMes / iNumMes)"
                    &Align3="right"
                    &Coluna4=''
                    &Align4="right"
                    &Coluna5=deTAbs
                    &Align5="right"
                    &Coluna6=''
                    &Align6="left"
                    &Coluna7=''
                    &Align7="right"}



/*

DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iAno AS INTEGER    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.
DEFINE VARIABLE vl-total AS DECIMAL FORMAT "->>>>,>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE cMes AS CHARACTER FORMAT "X(15)" NO-UNDO.

/* Acerto de datas */
FIND FIRST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= data-ini USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-ini = mov-conta.dt-mov.
FIND LAST mov-conta NO-LOCK
    WHERE mov-conta.dt-mov <= data-fim USE-INDEX proc-data NO-ERROR.
IF AVAIL mov-conta THEN
    ASSIGN data-fim = mov-conta.dt-mov.

/* Output padr∆o */
ASSIGN iAno = INT((data-fim - data-ini) / 30) + 1.
{func\relat\ini.i iAno}

/* L¢gica do relat¢rio */

REPEAT iAno = YEAR(data-ini) TO YEAR(data-fim):

    ASSIGN cTemp = "Ano " + STRING(iAno,"9999").
    {func\relat\capitulo.i cTemp 300}

    {func\relat\titulo.i &Coluna1='Màs'
                         &Tamanho1=150
                         &Coluna2='Total'}

    REPEAT iMes = IF YEAR(data-ini) <> iAno THEN 1 ELSE MONTH(data-ini) TO IF YEAR(data-fim) <> iAno THEN 12 ELSE MONTH(data-fim):

        {func\relat\control.i}
        RUN patrimon-tot.p (INPUT fnUltimoDia(iMes, iAno),
                            INPUT moeda,
                            OUTPUT vl-total).
        ASSIGN cMes = fnMes(iMes).
        {func\relat\linha.i &Coluna1=cMes
                            &Align1="left"
                            &Coluna2=vl-total
                            &Align2="right"}
    END.
END.

*/

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

ASSIGN data-ini = DATE(1,1,YEAR(TODAY))
       data-fim = TODAY.

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

