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

&GLOBAL-DEFINE FrameFields  mes-de mes-ate moeda iOrc

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

{orcamento.i &Campo="FIELD vl-fut AS DECIMAL ~
                     FIELD pc-real AS DECIMAL ~
                     FIELD pc-fut AS DECIMAL"}

DEFINE TEMP-TABLE tt-acomp-fut LIKE tt-acomp.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel IMAGE-5 IMAGE-6 RECT-10 btOK iOrc ~
mes-de mes-ate moeda 
&Scoped-Define DISPLAYED-OBJECTS iOrc des-orc mes-de mes-ate moeda 

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

DEFINE VARIABLE mes-ate AS INTEGER FORMAT ">9":U INITIAL 0 
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

DEFINE VARIABLE mes-de AS INTEGER FORMAT ">9":U INITIAL 0 
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
     SIZE 40.29 BY 1 NO-UNDO.

DEFINE VARIABLE des-orc AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY .79 NO-UNDO.

DEFINE VARIABLE iOrc AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Oráamento" 
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
     SIZE 78 BY 4.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 4 COL 73
     btOK AT ROW 2.25 COL 73
     iOrc AT ROW 2 COL 21 COLON-ALIGNED
     des-orc AT ROW 2 COL 25.29 COLON-ALIGNED NO-LABEL
     mes-de AT ROW 3.08 COL 21 COLON-ALIGNED
     mes-ate AT ROW 3.08 COL 45.29 COLON-ALIGNED NO-LABEL
     moeda AT ROW 4.25 COL 21 COLON-ALIGNED
     IMAGE-5 AT ROW 2.75 COL 38
     IMAGE-6 AT ROW 2.75 COL 42.72
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 6
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
         HEIGHT             = 6
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
/* SETTINGS FOR FILL-IN des-orc IN FRAME DEFAULT-FRAME
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
       ROW             = 6.25
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


&Scoped-define SELF-NAME iOrc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iOrc C-Win
ON ENTRY OF iOrc IN FRAME DEFAULT-FRAME /* Oráamento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iOrc C-Win
ON LEAVE OF iOrc IN FRAME DEFAULT-FRAME /* Oráamento */
DO:
    {func\leave.i &Tabela="orcamento"
                  &Campo="cd-orcamento"
                  &CampoTela="iOrc"
                  &CampoProc = "ds-orcamento"
                  &Tela="des-orc"}                    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iOrc C-Win
ON MOUSE-SELECT-DBLCLICK OF iOrc IN FRAME DEFAULT-FRAME /* Oráamento */
OR F5 OF iOrc DO:
    {func\zoom.i &Tabela="orcamento"
                 &Campo1="cd-orcamento"
                 &Tela1="iOrc"
                 &Campo2="ds-orcamento"
                 &Tela2="des-orc"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-ate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ate C-Win
ON ENTRY OF mes-ate IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ate C-Win
ON LEAVE OF mes-ate IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-de
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-de C-Win
ON ENTRY OF mes-de IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-de C-Win
ON LEAVE OF mes-de IN FRAME DEFAULT-FRAME /* Per°odo */
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

{func\relat\main_block.i &Cotacao=NO}

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
  {version.i r033}
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

OCXFile = SEARCH( "r033.wrx":U ).
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
ELSE MESSAGE "r033.wrx":U SKIP(1)
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

APPLY "LEAVE" TO iOrc IN FRAME {&FRAME-NAME}.

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
  DISPLAY iOrc des-orc mes-de mes-ate moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel IMAGE-5 IMAGE-6 RECT-10 btOK iOrc mes-de mes-ate moeda 
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

FIND FIRST orcamento NO-LOCK
    WHERE orcamento.cd-orcamento = iOrc NO-ERROR.

DEFINE VARIABLE iNumMeses AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE l-prim AS LOGICAL    NO-UNDO.
DEFINE VARIABLE cDesc AS CHARACTER  FORMAT "X(45)" COLUMN-LABEL "Item" NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

RUN criaTTacomp (INPUT 1, INPUT 12, INPUT iOrc).
FOR EACH tt-acomp:
    CREATE tt-acomp-fut.
    BUFFER-COPY tt-acomp TO tt-acomp-fut.
    DELETE tt-acomp.
END.

RUN criaTTacomp (INPUT mes-de, INPUT mes-ate, INPUT iOrc).

ASSIGN iCont = 0.
FOR EACH tt-acomp:
    ASSIGN iCont = iCont + 1.
END.

/* Output padr∆o */
{func\relat\ini.i iCont}

/* L¢gica do relat¢rio */

ASSIGN iNumMeses = mes-ate - mes-de + 1.

FOR EACH tt-acomp:

    FIND FIRST tt-acomp-fut
        WHERE tt-acomp-fut.cod-cat = tt-acomp.cod-cat
        AND   tt-acomp-fut.cd-sub = tt-acomp.cd-sub.

    ASSIGN tt-acomp.vl-fut  = ((tt-acomp.vl-real / iNumMeses) * (12 - mes-ate)) + tt-acomp.vl-real
           tt-acomp.pc-real = (((tt-acomp.vl-real / tt-acomp.vl-prev) - 1) * 100)
           tt-acomp.pc-fut  = (((tt-acomp.vl-fut  / tt-acomp-fut.vl-prev) - 1) * 100).

    IF tt-acomp.vl-prev < 0 THEN DO:
        IF tt-acomp.pc-real < 0 THEN
            ASSIGN tt-acomp.pc-real = tt-acomp.pc-real * (-1).
        IF tt-acomp.pc-fut < 0 THEN
            ASSIGN tt-acomp.pc-fut = tt-acomp.pc-fut * (-1).
    END.
END.

ASSIGN cTemp = "Oráamento: " + STRING(iOrc,"999") +  " - " + orcamento.ds-orcamento + "<br>" +
               "Per°odo: " + STRING(mes-de,"99") + "/" + STRING(orcamento.ano,"9999") + " atÇ " + STRING(mes-ate,"99") + "/" + STRING(orcamento.ano,"9999").
{func\relat\capitulo.i cTemp 800}

ASSIGN cTemp = "".

ASSIGN l-prim= YES.
FOR EACH tt-acomp
    WHERE tt-acomp.vl-real > tt-acomp.vl-prev
    AND   tt-acomp.vl-prev > 0
    BY tt-acomp.pc-real DESCENDING:

    {func\relat\control.i}

    ASSIGN cDesc = TRIM(tt-acomp.descricao).

    IF NOT cDesc MATCHES("*GERAL*") THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria NO-LOCK
                WHERE sub-cat.cd-sub = tt-acomp.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN DO:
                ASSIGN cDesc = cDesc + ":" + sub-cat.ds-sub.
            END.
        END.
    END.
    ELSE DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria + ":GERAL".
        END.
    END.
    IF cDesc = "OUTROS" THEN DO:
        CASE tt-acomp.cod-cat:
            WHEN 999 THEN ASSIGN cDesc = "RECEITAS:" + cDesc.
            WHEN 998 THEN ASSIGN cDesc = "DESPESAS:" + cDesc.
        END CASE.
    END.

    IF l-prim THEN DO:
        {func\relat\titulo.i &Coluna1='"Acima do Previsto"'
                             &Tamanho1=150
                             &Coluna2='"Vl Previsto"'
                             &Tamanho2=100
                             &Coluna3='"Vl Realizado"'
                             &Tamanho3=100
                             &Coluna4='"Percentual"'
                             &Tamanho4=100
                             &Coluna5='"Diferenáa"'
                             &Tamanho5=100}
        ASSIGN l-prim = NO.
    END.

    {func\relat\linha.i &Coluna1=cDesc
                        &Align1="left"
                        &Coluna2=tt-acomp.vl-prev
                        &Align2="right"
                        &Coluna3=tt-acomp.vl-real
                        &Align3="right"
                        &Coluna4=tt-acomp.pc-real
                        &Align4="right"
                        &Coluna5=tt-acomp.vl-dif
                        &Align5="right"}

END.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i cTemp 800}

ASSIGN l-prim= YES.
FOR EACH tt-acomp
    WHERE tt-acomp.vl-real <= tt-acomp.vl-prev
    AND   tt-acomp.vl-fut > 0
    AND   tt-acomp.pc-real <> 0
    BY tt-acomp.pc-fut DESCENDING:

    IF tt-acomp.descricao = "" THEN NEXT.

    FIND FIRST tt-acomp-fut
        WHERE tt-acomp-fut.cod-cat = tt-acomp.cod-cat
        AND   tt-acomp-fut.cd-sub = tt-acomp.cd-sub.
    IF AVAIL tt-acomp-fut THEN DO:
        IF tt-acomp.vl-fut <= tt-acomp-fut.vl-prev THEN NEXT.
    END.

    {func\relat\control.i}

    ASSIGN cDesc = TRIM(tt-acomp.descricao).

    IF NOT cDesc MATCHES("*GERAL*") THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria NO-LOCK
                WHERE sub-cat.cd-sub = tt-acomp.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN DO:
                ASSIGN cDesc = cDesc + ":" + sub-cat.ds-sub.
            END.
        END.
    END.
    ELSE DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria + ":GERAL".
        END.
    END.
    IF cDesc = "OUTROS" THEN DO:
        CASE tt-acomp.cod-cat:
            WHEN 999 THEN ASSIGN cDesc = "RECEITAS:" + cDesc.
            WHEN 998 THEN ASSIGN cDesc = "DESPESAS:" + cDesc.
        END CASE.
    END.

    IF l-prim THEN DO:
        {func\relat\titulo.i &Coluna1='"Valor Futuro Acima do Previsto"'
                             &Tamanho1=250
                             &Coluna2='"Prev Fut"'
                             &Tamanho2=78
                             &Coluna3='"Vl Fut"'
                             &Tamanho3=78
                             &Coluna4='"% Fut"'
                             &Tamanho4=78
                             &Coluna5='"Vl Prev"'
                             &Tamanho5=78
                             &Coluna6='"Vl Real"'
                             &Tamanho6=78
                             &Coluna7='"Perc"'
                             &Tamanho7=78
                             &Coluna8='"Dif"'
                             &Tamanho8=78}
        ASSIGN l-prim = NO.
    END.

    {func\relat\linha.i &Coluna1=cDesc
                        &Align1="left"
                        &Coluna2=tt-acomp-fut.vl-prev
                        &Align2="right"
                        &Coluna3=tt-acomp.vl-fut
                        &Align3="right"
                        &Coluna4=tt-acomp.pc-fut
                        &Align4="right"
                        &Coluna5=tt-acomp.vl-prev
                        &Align5="right"
                        &Coluna6=tt-acomp.vl-real
                        &Align6="right"
                        &Coluna7=tt-acomp.pc-real
                        &Align7="right"
                        &Coluna8=tt-acomp.vl-dif
                        &Align8="right"}

END.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i cTemp 800}

ASSIGN l-prim= YES.
FOR EACH tt-acomp
    WHERE tt-acomp.vl-real <= tt-acomp.vl-prev
    AND   tt-acomp.vl-prev <> 0
    AND   tt-acomp.pc-real > -25
    BY tt-acomp.pc-real DESCENDING:

    FIND FIRST tt-acomp-fut
        WHERE tt-acomp-fut.cod-cat = tt-acomp.cod-cat
        AND   tt-acomp-fut.cd-sub = tt-acomp.cd-sub.
    IF AVAIL tt-acomp-fut THEN DO:
        IF tt-acomp.vl-fut > tt-acomp-fut.vl-prev THEN NEXT.
    END.

    {func\relat\control.i}

    ASSIGN cDesc = TRIM(tt-acomp.descricao).

    IF NOT cDesc MATCHES("*GERAL*") THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria NO-LOCK
                WHERE sub-cat.cd-sub = tt-acomp.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN DO:
                ASSIGN cDesc = cDesc + ":" + sub-cat.ds-sub.
            END.
        END.
    END.
    ELSE DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria + ":GERAL".
        END.
    END.
    IF cDesc = "OUTROS" THEN DO:
        CASE tt-acomp.cod-cat:
            WHEN 999 THEN ASSIGN cDesc = "RECEITAS:" + cDesc.
            WHEN 998 THEN ASSIGN cDesc = "DESPESAS:" + cDesc.
        END CASE.
    END.

    IF l-prim THEN DO:
        {func\relat\titulo.i &Coluna1='"Dentro do Previsto (AtÇ 75%)"'
                             &Tamanho1=250
                             &Coluna2='"Vl Previsto"'
                             &Tamanho2=100
                             &Coluna3='"Vl Realizado"'
                             &Tamanho3=100
                             &Coluna4='"Percentual"'
                             &Tamanho4=100
                             &Coluna5='"Diferenáa"'
                             &Tamanho5=100}
        ASSIGN l-prim = NO.
    END.

    {func\relat\linha.i &Coluna1=cDesc
                        &Align1="left"
                        &Coluna2=tt-acomp.vl-prev
                        &Align2="right"
                        &Coluna3=tt-acomp.vl-real
                        &Align3="right"
                        &Coluna4=tt-acomp.pc-real
                        &Align4="right"
                        &Coluna5=tt-acomp.vl-dif
                        &Align5="right"}

END.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i cTemp 800}

ASSIGN l-prim= YES.
FOR EACH tt-acomp
    WHERE tt-acomp.vl-real <= tt-acomp.vl-prev
    AND   tt-acomp.vl-prev <> 0
    AND   tt-acomp.pc-real <= -25
    BY tt-acomp.pc-real DESCENDING:

    FIND FIRST tt-acomp-fut
        WHERE tt-acomp-fut.cod-cat = tt-acomp.cod-cat
        AND   tt-acomp-fut.cd-sub = tt-acomp.cd-sub.
    IF AVAIL tt-acomp-fut THEN DO:
        IF tt-acomp.vl-fut > tt-acomp-fut.vl-prev THEN NEXT.
    END.

    {func\relat\control.i}

    ASSIGN cDesc = TRIM(tt-acomp.descricao).

    IF NOT cDesc MATCHES("*GERAL*") THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria.
            FIND FIRST sub-cat OF categoria NO-LOCK
                WHERE sub-cat.cd-sub = tt-acomp.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN DO:
                ASSIGN cDesc = cDesc + ":" + sub-cat.ds-sub.
            END.
        END.
    END.
    ELSE DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-acomp.cod-cat NO-ERROR.
        IF AVAIL categoria THEN DO:
            ASSIGN cDesc = categoria.ds-categoria + ":GERAL".
        END.
    END.
    IF cDesc = "OUTROS" THEN DO:
        CASE tt-acomp.cod-cat:
            WHEN 999 THEN ASSIGN cDesc = "RECEITAS:" + cDesc.
            WHEN 998 THEN ASSIGN cDesc = "DESPESAS:" + cDesc.
        END CASE.
    END.

    IF l-prim THEN DO:
        {func\relat\titulo.i &Coluna1='"Abaixo do Previsto"'
                             &Tamanho1=250
                             &Coluna2='"Vl Previsto"'
                             &Tamanho2=100
                             &Coluna3='"Vl Realizado"'
                             &Tamanho3=100
                             &Coluna4='"Percentual"'
                             &Tamanho4=100
                             &Coluna5='"Diferenáa"'
                             &Tamanho5=100}
        ASSIGN l-prim = NO.
    END.

    {func\relat\linha.i &Coluna1=cDesc
                        &Align1="left"
                        &Coluna2=tt-acomp.vl-prev
                        &Align2="right"
                        &Coluna3=tt-acomp.vl-real
                        &Align3="right"
                        &Coluna4=tt-acomp.pc-real
                        &Align4="right"
                        &Coluna5=tt-acomp.vl-dif
                        &Align5="right"}

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

FIND LAST orcamento NO-LOCK
    WHERE orcamento.ano = YEAR(TODAY) NO-ERROR.
IF AVAIL orcamento THEN DO:
    ASSIGN iOrc = orcamento.cd-orcamento.
END.

ASSIGN mes-de = 1
       mes-ate = MONTH(TODAY).

{func\relat\initialize.i}

{func\cursor.i iOrc}

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

