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

&GLOBAL-DEFINE FrameFields  mes ano moeda

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
&Scoped-Define ENABLED-OBJECTS btCancel RECT-10 mes ano moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS mes ano moeda 

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

DEFINE VARIABLE mes AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Mˆs" 
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
     SIZE 21.29 BY 1 NO-UNDO.

DEFINE VARIABLE ano AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 3.25 COL 73
     mes AT ROW 2 COL 26 COLON-ALIGNED
     ano AT ROW 2 COL 42.29 COLON-ALIGNED NO-LABEL
     moeda AT ROW 3 COL 26 COLON-ALIGNED
     btOK AT ROW 1.5 COL 73
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


&Scoped-define SELF-NAME ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON ENTRY OF ano IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON LEAVE OF ano IN FRAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON ENTRY OF mes IN FRAME DEFAULT-FRAME /* Mˆs */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON LEAVE OF mes IN FRAME DEFAULT-FRAME /* Mˆs */
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
  {version.i r007}
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

OCXFile = SEARCH( "r007.wrx":U ).
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
ELSE MESSAGE "r007.wrx":U SKIP(1)
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
  DISPLAY mes ano moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel RECT-10 mes ano moeda btOK 
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

/* Defini‡Æo das vari veis */
{func\relat\var.i}

DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
DEFINE VARIABLE lPrim AS LOGICAL    NO-UNDO.
DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.
DEFINE VARIABLE tTotal AS DECIMAL    NO-UNDO.
DEFINE VARIABLE Final AS DECIMAL    NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER FORMAT "X(60)" NO-UNDO.
DEFINE VARIABLE iMax AS INTEGER    NO-UNDO.
DEFINE VARIABLE deSaldo AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deDesc AS DECIMAL     NO-UNDO.

/* Acerto de datas */

/* Output padrÆo */
select count(*) into iMax from sub-cat.
{func\relat\ini.i iMax}

/* L¢gica do relat¢rio */

ASSIGN cTemp = "Mˆs: " + fnMes(mes) + "/" + STRING(ano,"9999").
{func\relat\capitulo.i cTemp 800}
{func\relat\end-capitulo.i}
ASSIGN cTemp = "Receitas".
{func\relat\capitulo.i cTemp 800}

ASSIGN tTotal = 0.
FOR EACH categoria NO-LOCK
    WHERE id-tipo = 1
    BY ds-categoria:

    ASSIGN deTotal = 0
           lPrim = YES.

    FOR EACH sub-cat OF categoria NO-LOCK BY ds-sub:

        {func\relat\control.i}
        ASSIGN deValor = 0.

        FOR EACH mov-conta NO-LOCK
            WHERE mov-conta.cod-categoria = categoria.cod-categoria
            AND   mov-conta.cd-sub = sub-cat.cd-sub
            AND   mov-conta.dt-mov >= DATE(mes,1,ano)
            AND   mov-conta.dt-mov <= fnUltimoDia(mes, ano):

            ASSIGN deValor = deValor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

        END.
        IF deValor <> 0 THEN DO:
            IF lPrim THEN DO:
                {func\relat\titulo.i &Coluna1=categoria.ds-categoria
                                     &Tamanho1=600
                                     &Coluna2='"Valor"'
                                     &Tamanho2=200}
                lPrim = NO.
            END.
            {func\relat\linha.i &Coluna1=sub-cat.ds-sub
                                &Align1="left"
                                &Coluna2=deValor
                                &Align2="right"}
        END.
        ASSIGN deTotal = deTotal + deValor.    
    END.
    ASSIGN tTotal = tTotal + deTotal.
    IF deTotal <> 0 THEN DO:
        ASSIGN cTemp = "Total de " + categoria.ds-categoria.
        {func\relat\total.i &Coluna1=cTemp
                            &Align1="left"
                            &Coluna2=deTotal
                            &Align2="right"}
    END.

END.

ASSIGN cTemp = "TOTAL DE RECEITAS:".
{func\relat\total.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=TTotal
                    &Align2="right"}

ASSIGN Final = tTotal.

{func\relat\end-capitulo.i}

IF CAN-FIND(FIRST conta
            WHERE conta.cd-moeda <> 0) THEN DO:

    ASSIGN cTemp = "Investimentos".
    {func\relat\capitulo.i cTemp 800}

    ASSIGN tTotal = 0
           deTotal = 0
           lPrim = YES.

    FOR EACH conta NO-LOCK
        WHERE conta.cd-moeda <> 0
        BY conta.ds-conta:

        ASSIGN deSaldo = conta.vl-saldo-ini.
        FOR EACH mov-conta OF conta NO-LOCK
            WHERE mov-conta.dt-mov < DATE(mes,1,ano)
            AND   mov-conta.id-tipo <> 0:
            ASSIGN deSaldo = deSaldo + mov-conta.de-valor.
        END.

        ASSIGN deValor = (-1) * fnCotacao(deSaldo,conta.cd-moeda,moeda,(DATE(mes,1,ano) - 1))
               deDesc = 0.

        FOR EACH mov-conta OF conta NO-LOCK
            WHERE mov-conta.dt-mov >= DATE(mes,1,ano)
            AND   mov-conta.dt-mov <= fnUltimoDia(mes, ano)
            AND   mov-conta.id-tipo <> 0,
            FIRST sub-cat OF mov-conta:
            ASSIGN deSaldo = deSaldo + mov-conta.de-valor.
            IF NOT sub-cat.ds-sub MATCHES("*split*") THEN
                ASSIGN deDesc = deDesc + fnCotacao(mov-conta.de-valor,conta.cd-moeda,moeda,mov-conta.dt-mov).
        END.
        ASSIGN deValor = deValor + fnCotacao(deSaldo,conta.cd-moeda,moeda,fnUltimoDia(mes, ano)) - deDesc.

        IF deValor <> 0 THEN DO:
            IF lPrim THEN DO:
                {func\relat\titulo.i &Coluna1='"Contas"'
                                     &Tamanho1=600
                                     &Coluna2='"Valor"'
                                     &Tamanho2=200}
                lPrim = NO.
            END.
            {func\relat\linha.i &Coluna1=conta.ds-conta
                                &Align1="left"
                                &Coluna2=deValor
                                &Align2="right"}
        END.
        ASSIGN deTotal = deTotal + deValor.    

    END.

    ASSIGN tTotal = tTotal + deTotal.
    IF deTotal <> 0 THEN DO:
        {func\relat\total.i &Coluna1='"Total de Contas"'
                            &Align1="left"
                            &Coluna2=deTotal
                            &Align2="right"}
    END.

    {func\relat\total.i &Coluna1='"TOTAL DE INVESTIMENTOS:"'
                        &Align1="left"
                        &Coluna2=TTotal
                        &Align2="right"}

    ASSIGN Final = FINAL + tTotal.

    {func\relat\end-capitulo.i}

END.

ASSIGN cTemp = "Despesas".
{func\relat\capitulo.i cTemp 800}

ASSIGN tTotal = 0.
FOR EACH categoria NO-LOCK
    WHERE categoria.id-tipo = 2
    BY ds-categoria:

    ASSIGN deTotal = 0
           lPrim = YES.

    FOR EACH sub-cat OF categoria NO-LOCK BY ds-sub:

        {func\relat\control.i}
        ASSIGN deValor = 0.

        FOR EACH mov-conta NO-LOCK
            WHERE mov-conta.cod-categoria = categoria.cod-categoria
            AND   mov-conta.cd-sub = sub-cat.cd-sub
            AND   mov-conta.dt-mov >= DATE(mes,1,ano)
            AND   mov-conta.dt-mov <= fnUltimoDia(mes, ano):

            ASSIGN deValor = deValor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

        END.
        IF deValor <> 0 THEN DO:
            IF lPrim THEN DO:
                {func\relat\titulo.i &Coluna1=categoria.ds-categoria
                                     &Tamanho1=600
                                     &Coluna2='"Valor"'
                                     &Tamanho2=200}
                lPrim = NO.
            END.
            {func\relat\linha.i &Coluna1=sub-cat.ds-sub
                                &Align1="left"
                                &Coluna2=deValor
                                &Align2="right"}
        END.
        ASSIGN deTotal = deTotal + deValor.    
    END.
    ASSIGN tTotal = tTotal + deTotal.
    IF deTotal <> 0 THEN DO:
        ASSIGN cTemp = "Total de " + categoria.ds-categoria.
        {func\relat\total.i &Coluna1=cTemp
                            &Align1="left"
                            &Coluna2=deTotal
                            &Align2="right"}
    END.

END.

ASSIGN cTemp = "TOTAL DE DESPESAS:".
{func\relat\total.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=TTotal
                    &Align2="right"}

ASSIGN Final = Final + tTotal.

ASSIGN cTemp = "RECEITAS - DESPESAS:".
{func\relat\total.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=Final
                    &Align2="right"}
                    
{func\relat\end-capitulo.i}

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

ASSIGN mes = MONTH(TODAY)
       ano = YEAR(TODAY).

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

