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

DEFINE TEMP-TABLE tt-comp1
    FIELD cod-categoria LIKE categoria.cod-categoria
    FIELD cd-sub        LIKE sub-cat.cd-sub
    FIELD valor AS DECIMAL FORMAT "->>>>,>>9.99"
    INDEX pri valor ASCENDING.

DEFINE TEMP-TABLE tt-comp2 LIKE tt-comp1
    FIELD diferenca AS DECIMAL FORMAT "->>>>,>>9.99".

DEFINE BUFFER bfComp FOR tt-comp1.

/* Parameters Definitions ---                                           */
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  ano moeda

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

DEFINE VARIABLE deMAnt AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE deMAt AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE deDif AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE dePc AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO FORMAT "X(60)".
DEFINE VARIABLE deTemp1 AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE deTemp2 AS DECIMAL FORMAT "->>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE cCat1 AS CHARACTER  NO-UNDO FORMAT "X(60)".
DEFINE VARIABLE cCat2 AS CHARACTER  NO-UNDO FORMAT "X(60)".
DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE l1 AS LOGICAL    NO-UNDO.
DEFINE VARIABLE l2 AS LOGICAL    NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel RECT-10 ano moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS ano moeda 

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
     SIZE 21 BY 1 NO-UNDO.

DEFINE VARIABLE ano AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 3.25 COL 73
     ano AT ROW 2 COL 26 COLON-ALIGNED
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
ON ENTRY OF ano IN FRAME DEFAULT-FRAME /* Ano */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON LEAVE OF ano IN FRAME DEFAULT-FRAME /* Ano */
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
  {version.i r011}
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

OCXFile = SEARCH( "r011.wrx":U ).
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
ELSE MESSAGE "r011.wrx":U SKIP(1)
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
  DISPLAY ano moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel RECT-10 ano moeda btOK 
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

FOR EACH tt-comp1:
    DELETE tt-comp1.
END.
FOR EACH tt-comp2:
    DELETE tt-comp2.
END.

/* Acerto de datas */

/* Output padr∆o */
{func\relat\ini.i 17}

/* L¢gica do relat¢rio */

PUT "  <tr>" SKIP
    "    <td width=~"800~" colSpan=~"2~"><strong><font face=~"Arial~" color=~"#319B64~"><br>" SKIP
    "    Ano: " STRING(ano,"9999") "<br><br></font></strong>" SKIP
    "    </td>" SKIP
    "  </tr>".

{func\relat\control.i}
RUN _rel001 IN THIS-PROCEDURE (INPUT-OUTPUT iContReg).
{func\relat\control.i}
RUN _rel002 IN THIS-PROCEDURE (INPUT-OUTPUT iContReg).
{func\relat\control.i}
RUN _rel003 IN THIS-PROCEDURE (INPUT-OUTPUT iContReg).
{func\relat\control.i}
RUN _rel004 IN THIS-PROCEDURE (INPUT-OUTPUT iContReg).
{func\relat\control.i}
RUN _rel005 IN THIS-PROCEDURE (INPUT-OUTPUT iContReg).
{func\relat\control.i}
RUN _rel006 IN THIS-PROCEDURE (INPUT-OUTPUT iContReg).

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

ASSIGN ano = YEAR(TODAY).

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _rel001 C-Win 
PROCEDURE _rel001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iContReg AS INTEGER    NO-UNDO.

DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

{func\relat\capitulo.i '"Rendimentos X Despesas"' 800}

ASSIGN cParamRelat = "mes-ini=1" +
                     ",ano-ini=" + STRING(ano,"9999") +
                     ",mes-fim=12" +
                     ",ano-fim=" + STRING(ano,"9999") +
                     ",moeda=" + STRING(moeda).
RUN func\gera_graf.p (INPUT "graf\g005.w", INPUT "gr001.gif", INPUT 750, INPUT 400).
ASSIGN cParamRelat = "".
PUT "  <tr>" SKIP
    "    <td height=~"20~" colspan=~"5~" align=~"center~"><img src=~"gr001.gif~"></td>" SKIP
    "  </tr><br>" SKIP.
{func\relat\end-capitulo.i}
{func\relat\capitulo.i '' 800}

{func\relat\titulo.i &Coluna1=''
                     &Tamanho1=240
                     &Coluna2='"Ano Anterior"'
                     &Tamanho2=140
                     &Coluna3='"Ano Atual"'
                     &Tamanho3=140
                     &Coluna4='"Diferenáa"'
                     &Tamanho4=140
                     &Coluna5='"Percentual"'
                     &Tamanho5=140}
                         
ASSIGN cTemp = "Total de Rendimentos"
       deMAnt = 0
       deMAt = 0.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= DATE(1,1,(ano - 1))
    AND   mov-conta.dt-mov <= DATE(12,31,ano)
    AND   mov-conta.id-tipo <> 3
    AND   mov-conta.id-tipo <> 0
    AND   mov-conta.de-valor > 0:

    IF mov-conta.cd-moeda = moeda THEN DO:
        IF YEAR(mov-conta.dt-mov) = ano THEN
            ASSIGN deMAt = deMAt + mov-conta.de-valor.
        ELSE
            ASSIGN deMAnt = deMAnt + mov-conta.de-valor.
    END.
    ELSE DO:
        IF YEAR(mov-conta.dt-mov) = ano THEN
            ASSIGN deMAt = deMAt + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
        ELSE
            ASSIGN deMAnt = deMAnt + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
    END.

END.

ASSIGN deDif = (deMAt - deMAnt)
       dePc  = (deDif / deMAnt) * 100.

{func\relat\control.i}
{func\relat\linha.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=deMAnt
                    &Align2="right"
                    &Coluna3=deMAt
                    &Align3="right"
                    &Coluna4=deDif
                    &Align4="right"
                    &Coluna5=dePc
                    &Align5="right"}

IF CAN-FIND(FIRST conta
            WHERE conta.cd-moeda <> 0) THEN DO:

    ASSIGN deTemp1 = deTemp1 + deMAnt
           deTemp2 = deTemp2 + deMAt
           cTemp = "Total de Investimentos"
           deMAnt = 0
           deMAt = 0.

    REPEAT iAux = 1 TO 12:

        RUN var_camb.p (INPUT DATE(iAux, 1, (ano - 1)), 
                        INPUT moeda,
                        OUTPUT deAux).
        ASSIGN deMAnt = deMAnt + deAux.

        RUN var_camb.p (INPUT DATE(iAux, 1, ano), 
                        INPUT moeda,
                        OUTPUT deAux).
        ASSIGN deMAt = deMAt + deAux.

    END.

    ASSIGN deDif = (deMAt - deMAnt)
           dePc  = (deDif / deMAnt) * 100.
    IF deMAnt < 0 THEN
        ASSIGN dePc = (-1) * dePc.

    {func\relat\linha.i &Coluna1=cTemp
                        &Align1="left"
                        &Coluna2=deMAnt
                        &Align2="right"
                        &Coluna3=deMAt
                        &Align3="right"
                        &Coluna4=deDif
                        &Align4="right"
                        &Coluna5=dePc
                        &Align5="right"}

END.

ASSIGN deTemp1 = deTemp1 + deMAnt
       deTemp2 = deTemp2 + deMAt
       cTemp = "Total de Despesas"
       deMAnt = 0
       deMAt = 0.

FOR EACH mov-conta NO-LOCK
    WHERE mov-conta.dt-mov >= DATE(1,1,(ano - 1))
    AND   mov-conta.dt-mov <= DATE(12,31,ano)
    AND   mov-conta.id-tipo <> 3
    AND   mov-conta.id-tipo <> 0
    AND   mov-conta.de-valor < 0:

    IF YEAR(mov-conta.dt-mov) = ano THEN DO:
        ASSIGN deMAt = deMAt + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
        FIND FIRST tt-comp2
            WHERE tt-comp2.cod-categoria = mov-conta.cod-categoria
            AND   tt-comp2.cd-sub = mov-conta.cd-sub NO-ERROR.
        IF AVAIL tt-comp2 THEN
            ASSIGN tt-comp2.valor = tt-comp2.valor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
        ELSE DO:
            CREATE tt-comp2.
            ASSIGN tt-comp2.valor = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov)
                   tt-comp2.cod-categoria = mov-conta.cod-categoria
                   tt-comp2.cd-sub = mov-conta.cd-sub.
        END.
    END.
    ELSE DO:
        ASSIGN deMAnt = deMAnt + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
        FIND FIRST tt-comp1
            WHERE tt-comp1.cod-categoria = mov-conta.cod-categoria
            AND   tt-comp1.cd-sub = mov-conta.cd-sub NO-ERROR.
        IF AVAIL tt-comp1 THEN
            ASSIGN tt-comp1.valor = tt-comp1.valor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
        ELSE DO:
            CREATE tt-comp1.
            ASSIGN tt-comp1.valor = fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov)
                   tt-comp1.cod-categoria = mov-conta.cod-categoria
                   tt-comp1.cd-sub = mov-conta.cd-sub.
        END.
    END.

END.

ASSIGN deDif = (-1) * (deMAt - deMAnt)
       dePc  = (-1) * (deDif / deMAnt) * 100.

{func\relat\control.i}
{func\relat\linha.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=deMAnt
                    &Align2="right"
                    &Coluna3=deMAt
                    &Align3="right"
                    &Coluna4=deDif
                    &Align4="right"
                    &Coluna5=dePc
                    &Align5="right"}

ASSIGN deTemp1 = deTemp1 + deMAnt
       deTemp2 = deTemp2 + deMAt
       cTemp = "Poupanáa Potencial"
       deDif = (deTemp2 - deTemp1)
       dePc  = (deDif / deTemp1) * 100.

IF deTemp1 < 0 THEN
    ASSIGN dePc = dePc * (-1).

{func\relat\control.i}
{func\relat\total.i &Coluna1=cTemp
                    &Align1="left"
                    &Coluna2=deTemp1
                    &Align2="right"
                    &Coluna3=deTemp2
                    &Align3="right"
                    &Coluna4=deDif
                    &Align4="right"
                    &Coluna5=dePc
                    &Align5="right"}
                    
{func\relat\end-capitulo.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _rel002 C-Win 
PROCEDURE _rel002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iContReg AS INTEGER    NO-UNDO.

{func\relat\capitulo.i '"20 Principais Despesas Anuais"' 800}

ASSIGN cParamRelat = "data-ini=" + STRING(DATE(1,1,(ano - 1)),"99/99/9999") +
                     ",data-fim=" + STRING(DATE(12,31,(ano - 1)),"99/99/9999") +
                     ",tipo=2,agrupa=25" +
                     ",moeda=" + STRING(moeda).
RUN func\gera_graf.p (INPUT "graf\g016.w", INPUT "gr002.gif", INPUT 380, INPUT 300).
ASSIGN cParamRelat = "".
ASSIGN cParamRelat = "data-ini=" + STRING(DATE(1, 1, ano),"99/99/9999") +
                     ",data-fim=" + STRING(DATE(12,31,ano),"99/99/9999") +
                     ",tipo=2,agrupa=25" +
                     ",moeda=" + STRING(moeda).
RUN func\gera_graf.p (INPUT "graf\g016.w", INPUT "gr003.gif", INPUT 380, INPUT 300).
ASSIGN cParamRelat = "".
PUT "  <tr>" SKIP
    "    <td height=~"20~" colspan=~"5~" align=~"center~"><img src=~"gr002.gif~"><img src=~"gr003.gif~"></td>" SKIP
    "  </tr><br>" SKIP.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i '' 800}
{func\relat\titulo.i &Coluna1='"Ano Anterior"'
                     &Tamanho1=270
                     &Coluna2='"Valor"'
                     &Tamanho2=80
                     &Coluna3=''
                     &Tamanho3=20
                     &Coluna4='"Ano Atual"'
                     &Tamanho4=270
                     &Coluna5='"Valor"'
                     &Tamanho5=80
                     &Coluna6='"Diferenáa"'
                     &Tamanho6=80
                     &Small=YES}
                     
FIND FIRST tt-comp1.
FIND FIRST tt-comp2.

{func\relat\control.i}
REPEAT iCont = 1 TO 20:
    ASSIGN cCat1 = ""
           cCat2 = "".

    IF AVAIL tt-comp1 THEN DO:
        FIND FIRST categoria 
            WHERE categoria.cod-categoria = tt-comp1.cod-categoria NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cCat1 = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria
                WHERE sub-cat.cd-sub = tt-comp1.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN cCat1 = cCat1 + ":" + sub-cat.ds-sub.
        END.
    END.
    IF AVAIL tt-comp2 THEN DO:
        FIND FIRST categoria 
            WHERE categoria.cod-categoria = tt-comp2.cod-categoria NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cCat2 = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria
                WHERE sub-cat.cd-sub = tt-comp2.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN cCat2 = cCat2 + ":" + sub-cat.ds-sub.
        END.
        FIND FIRST bfComp
            WHERE bfComp.cod-categoria = tt-comp2.cod-categoria
            AND   bfComp.cd-sub = tt-comp2.cd-sub NO-ERROR.
        IF AVAIL bfComp THEN DO:
            ASSIGN tt-comp2.diferenca = bfComp.valor - tt-comp2.valor.
        END.
    END.
    IF AVAIL bfComp THEN DO:
        {func\relat\linha.i &Coluna1=cCat1
                            &Align1="left"
                            &Coluna2=tt-comp1.valor
                            &Align2="right"
                            &Coluna3=''
                            &Align3="right"
                            &Coluna4=cCat2
                            &Align4="left"
                            &Coluna5=tt-comp2.valor
                            &Align5="right"
                            &Coluna6=tt-comp2.diferenca
                            &Align6="right"
                            &Small=YES}
    END.
    ELSE DO:
        {func\relat\linha.i &Coluna1=cCat1
                            &Align1="left"
                            &Coluna2=tt-comp1.valor
                            &Align2="right"
                            &Coluna3=''
                            &Align3="right"
                            &Coluna4=cCat2
                            &Align4="left"
                            &Coluna5=tt-comp2.valor
                            &Align5="right"
                            &Coluna6='"NOVA"'
                            &Align6="right"
                            &Small=YES}
    END.

    FIND NEXT tt-comp1.
    FIND NEXT tt-comp2.

END.

{func\relat\end-capitulo.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _rel003 C-Win 
PROCEDURE _rel003 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iContReg AS INTEGER    NO-UNDO.

{func\relat\capitulo.i '"Reduá∆o de Despesas"' 600}

{func\relat\titulo.i &Coluna1='"Neste ano vocà n∆o gastou com:"'
                     &Tamanho1=400
                     &Coluna2=''
                     &Tamanho2=200}
                     
ASSIGN deTemp1 = 0.
{func\relat\control.i}
FOR EACH tt-comp1:
    FIND FIRST tt-comp2
        WHERE tt-comp2.cod-categoria = tt-comp1.cod-categoria
        AND   tt-comp2.cd-sub = tt-comp1.cd-sub NO-ERROR.
    IF NOT AVAIL tt-comp2 THEN DO:
        FIND FIRST categoria 
            WHERE categoria.cod-categoria = tt-comp1.cod-categoria NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cCat1 = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria
                WHERE sub-cat.cd-sub = tt-comp1.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN cCat1 = cCat1 + ":" + sub-cat.ds-sub.
        END.
        {func\relat\linha.i &Coluna1=cCat1
                            &Align1="left"
                            &Coluna2=tt-comp1.valor
                            &Align2="right"}
        ASSIGN deTemp1 = deTemp1 + tt-comp1.valor.
    END.
END.
{func\relat\control.i}
{func\relat\total.i &Coluna1='"Reduá∆o Total"'
                    &Align1="left"
                    &Coluna2=deTemp1
                    &Align2="right"}

{func\relat\end-capitulo.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _rel004 C-Win 
PROCEDURE _rel004 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iContReg AS INTEGER    NO-UNDO.

{func\relat\capitulo.i '"Patrimìnio"' 800}

ASSIGN cParamRelat = "mes-ini=1" +
                     ",ano-ini=" + STRING(ano,"9999") +
                     ",mes-fim=12" +
                     ",ano-fim=" + STRING(ano,"9999") +
                     ",moeda=" + STRING(moeda).
RUN func\gera_graf.p (INPUT "graf\g004.w", INPUT "gr004.gif", INPUT 750, INPUT 400).
ASSIGN cParamRelat = "".
PUT "  <tr>" SKIP
    "    <td height=~"20~" colspan=~"5~" align=~"center~"><img src=~"gr004.gif~"></td>" SKIP
    "  </tr><br>" SKIP.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i '' 600}

{func\relat\titulo.i &Coluna1=''
                     &Tamanho1=400
                     &Coluna2='"Valor"'
                     &Tamanho2=200}
                     
RUN patrimon-tot.p (INPUT DATE(12,31,(ano - 1)), INPUT moeda, OUTPUT deTemp1).
{func\relat\control.i}
{func\relat\linha.i &Coluna1='"Ano Anterior"'
                    &Align1="left"
                    &Coluna2=deTemp1
                    &Align2="right"}
RUN patrimon-tot.p (INPUT DATE(12,31,ano), INPUT moeda, OUTPUT deTemp2).
{func\relat\control.i}
{func\relat\linha.i &Coluna1='"Ano Atual"'
                  &Align1="left"
                  &Coluna2=deTemp2
                  &Align2="right"}
{func\relat\control.i}
{func\relat\linha.i &Coluna1='"Evoluá∆o"'
                    &Align1="left"
                    &Coluna2="(deTemp2 - deTemp1)"
                    &Align2="right"}
                         
ASSIGN dePc = (((deTemp2 - deTemp1) / deTemp1) * 100).
IF deTemp1 < 0 THEN
    ASSIGN dePc = (-1) * dePc.
{func\relat\control.i}
{func\relat\total.i &Coluna1='"Percentual de Evoluá∆o"'
                    &Align1="left"
                    &Coluna2=dePc
                    &Align2="right"}
                        
{func\relat\end-capitulo.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _rel005 C-Win 
PROCEDURE _rel005 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iContReg AS INTEGER    NO-UNDO.

{func\relat\capitulo.i '"Custos"' 800}

{func\relat\titulo.i &Coluna1='"Ano Anterior"'
                     &Tamanho1=270
                     &Coluna2='"Valor"'
                     &Tamanho2=80
                     &Coluna3=''
                     &Tamanho3=20
                     &Coluna4='"Ano Atual"'
                     &Tamanho4=270
                     &Coluna5='"Valor"'
                     &Tamanho5=80
                     &Coluna6='"Diferenáa"'
                     &Tamanho6=80
                     &Small=YES}

ASSIGN deTemp1 = 0
       deTemp2 = 0.

FIND FIRST tt-comp1.
FIND FIRST tt-comp2.

{func\relat\control.i}
REPEAT:
    REPEAT:
        IF AVAIL tt-comp1 THEN DO:
            FIND FIRST categoria 
                WHERE categoria.cod-categoria = tt-comp1.cod-categoria NO-ERROR.
            IF AVAIL categoria THEN DO:
                ASSIGN cCat1 = categoria.ds-categoria.
                FIND FIRST sub-cat OF categoria
                    WHERE sub-cat.cd-sub = tt-comp1.cd-sub 
                    AND   sub-cat.id-tipo = 2 NO-ERROR.
                IF AVAIL sub-cat THEN DO:
                    ASSIGN cCat1 = cCat1 + ":" + sub-cat.ds-sub.
                    ASSIGN l1 = YES
                           deTemp1 = deTemp1 + tt-comp1.valor.
                    LEAVE.
                END.
            END.
        END.
        ELSE 
            LEAVE.
        FIND NEXT tt-comp1 NO-ERROR.
    END.
    REPEAT:
        IF AVAIL tt-comp2 THEN DO:
            FIND FIRST categoria 
                WHERE categoria.cod-categoria = tt-comp2.cod-categoria NO-ERROR.
            IF AVAIL categoria THEN DO:
                ASSIGN cCat2 = categoria.ds-categoria.
                FIND FIRST sub-cat OF categoria
                    WHERE sub-cat.cd-sub = tt-comp2.cd-sub 
                    AND   sub-cat.id-tipo = 2 NO-ERROR.
                IF AVAIL sub-cat THEN DO:
                    ASSIGN cCat2 = cCat2 + ":" + sub-cat.ds-sub.
                    FIND FIRST bfComp
                        WHERE bfComp.cod-categoria = tt-comp2.cod-categoria
                        AND   bfComp.cd-sub = tt-comp2.cd-sub NO-ERROR.
                    IF AVAIL bfComp THEN DO:
                        ASSIGN tt-comp2.diferenca = bfComp.valor - tt-comp2.valor.
                    END.
                    ASSIGN l2 = YES
                           deTemp2 = deTemp2 + tt-comp2.valor.
                    LEAVE.
                END.
            END.
        END.
        ELSE 
            LEAVE.
        FIND NEXT tt-comp2 NO-ERROR.
    END.

    IF l1 = YES OR l2 = YES THEN DO:
        IF AVAIL bfComp THEN DO:
            IF AVAIL tt-comp1 THEN DO:
                IF AVAIL tt-comp2 THEN DO:
                    {func\relat\linha.i &Coluna1=cCat1
                                        &Align1="left"
                                        &Coluna2=tt-comp1.valor
                                        &Align2="right"
                                        &Coluna3=''
                                        &Align3="right"
                                        &Coluna4=cCat2
                                        &Align4="left"
                                        &Coluna5=tt-comp2.valor
                                        &Align5="right"
                                        &Coluna6=tt-comp2.diferenca
                                        &Align6="right"
                                        &Small=YES}
                END.
                ELSE DO:
                    {func\relat\linha.i &Coluna1=cCat1
                                        &Align1="left"
                                        &Coluna2=tt-comp1.valor
                                        &Align2="right"
                                        &Coluna3=''
                                        &Align3="right"
                                        &Coluna4=''
                                        &Align4="left"
                                        &Coluna5=''
                                        &Align5="right"
                                        &Coluna6=''
                                        &Align6="right"
                                        &Small=YES}
                END.
            END.
            ELSE DO:
                IF AVAIL tt-comp2 THEN DO:
                    {func\relat\linha.i &Coluna1=''
                                        &Align1="left"
                                        &Coluna2=''
                                        &Align2="right"
                                        &Coluna3=''
                                        &Align3="right"
                                        &Coluna4=cCat2
                                        &Align4="left"
                                        &Coluna5=tt-comp2.valor
                                        &Align5="right"
                                        &Coluna6=tt-comp2.diferenca
                                        &Align6="right"
                                        &Small=YES}
                END.
            END.
        END.
        ELSE DO:
            IF AVAIL tt-comp1 THEN DO:
                IF AVAIL tt-comp2 THEN DO:
                    {func\relat\linha.i &Coluna1=cCat1
                                        &Align1="left"
                                        &Coluna2=tt-comp1.valor
                                        &Align2="right"
                                        &Coluna3=''
                                        &Align3="right"
                                        &Coluna4=cCat2
                                        &Align4="left"
                                        &Coluna5=tt-comp2.valor
                                        &Align5="right"
                                        &Coluna6='"NOVA"'
                                        &Align6="right"
                                        &Small=YES}
                END.
                ELSE DO:
                    {func\relat\linha.i &Coluna1=cCat1
                                        &Align1="left"
                                        &Coluna2=tt-comp1.valor
                                        &Align2="right"
                                        &Coluna3=''
                                        &Align3="right"
                                        &Coluna4=''
                                        &Align4="left"
                                        &Coluna5=''
                                        &Align5="right"
                                        &Coluna6=''
                                        &Align6="right"
                                        &Small=YES}
                END.
            END.
            ELSE DO:
                {func\relat\linha.i &Coluna1=''
                                    &Align1="left"
                                    &Coluna2=''
                                    &Align2="right"
                                    &Coluna3=''
                                    &Align3="right"
                                    &Coluna4=cCat2
                                    &Align4="left"
                                    &Coluna5=tt-comp2.valor
                                    &Align5="right"
                                    &Coluna6='"NOVA"'
                                    &Align6="right"
                                    &Small=YES}
            END.
        END.
        ASSIGN l1 = NO
               l2 = NO.
    END.
    ELSE
        LEAVE.

    FIND NEXT tt-comp1 NO-ERROR.
    FIND NEXT tt-comp2 NO-ERROR.
END.

{func\relat\total.i &Coluna1='"Total"'
                    &Align1="left"
                    &Coluna2=deTemp1
                    &Align2="right"
                    &Coluna3=''
                    &Align3="right"
                    &Coluna4='"Total"'
                    &Align4="right"
                    &Coluna5=deTemp2
                    &Align5="right"
                    &Coluna6="(deTemp1 - deTemp2)"
                    &Align6="right"
                    &Small=YES}

{func\relat\end-capitulo.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE _rel006 C-Win 
PROCEDURE _rel006 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT-OUTPUT PARAMETER iContReg AS INTEGER    NO-UNDO.

{func\relat\capitulo.i '"Evoluá∆o de Saldo no Ano"' 800}

ASSIGN cParamRelat = "data-ini=" + STRING(DATE(1, 1, ano),"99/99/9999") +
                     ",data-fim=" + STRING(DATE(12,31,ano),"99/99/9999") +
                     ",moeda=" + STRING(moeda) +
                     ",iConta=000".
RUN func\gera_graf.p (INPUT "graf\g001.w", INPUT "gr005.gif", INPUT 750, INPUT 400).
ASSIGN cParamRelat = "".
PUT "  <tr>" SKIP
    "    <td height=~"20~" colspan=~"5~" align=~"center~"><img src=~"gr005.gif~"></td>" SKIP
    "  </tr><br>" SKIP.
{func\relat\end-capitulo.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

