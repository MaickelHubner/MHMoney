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

/* PrÇ-processadores */
&GLOBAL-DEFINE Table         categoria
&GLOBAL-DEFINE Filho         sub-cat
&GLOBAL-DEFINE LabelFilho    Sub-Categorias
&GLOBAL-DEFINE ParentFields  categoria.cod-categoria categoria.ds-categoria
&GLOBAL-DEFINE KeyFields     categoria.cod-categoria
&GLOBAL-DEFINE CamposFilho   sub-cat.cd-sub ~
                             sub-cat.ds-sub ~
                             fnId-tipo(sub-cat.id-tipo) @ cId-tipo ~
                             sub-cat.reembolso ~
                             sub-cat.l-ir WIDTH 3 ~
                             fnTp-ir(sub-cat.tp-ir) @ cTp-ir ~
                             sub-cat.inflacao

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE cId-tipo AS CHARACTER COLUMN-LABEL "Tipo" FORMAT "X(10)"  NO-UNDO.
DEFINE VARIABLE cTp-ir AS CHARACTER COLUMN-LABEL "Tipo IR" FORMAT "X(30)"  NO-UNDO.

/* Buffers */

{func\definitions.i}

/* Campos Extrangeiros */


DEFINE NEW GLOBAL SHARED VARIABLE cParamRelat AS CHAR NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-page1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES {&Filho} categoria

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 {&CamposFilho}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define QUERY-STRING-br-page1 FOR EACH {&Filho} OF {&Table} NO-LOCK INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE
&Scoped-define OPEN-QUERY-br-page1 OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK INDEXED-REPOSITION. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-page1 {&Filho}
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 {&Filho}


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME categoria.cod-categoria ~
categoria.ds-categoria 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME ~
categoria.cod-categoria categoria.ds-categoria 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME categoria
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME categoria
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH categoria SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH categoria SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME categoria
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME categoria


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS categoria.cod-categoria ~
categoria.ds-categoria 
&Scoped-define ENABLED-TABLES categoria
&Scoped-define FIRST-ENABLED-TABLE categoria
&Scoped-Define ENABLED-OBJECTS br-page1 btGraf btMov btAdd-page1 ~
btDel-page1 btExit btFirst btLast btNext btPrev btUpdate-page1 btGoTo ~
btZoom RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS categoria.cod-categoria ~
categoria.ds-categoria 
&Scoped-define DISPLAYED-TABLES categoria
&Scoped-define FIRST-DISPLAYED-TABLE categoria


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnId-tipo C-Win 
FUNCTION fnId-tipo RETURNS CHARACTER
  ( iCod AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnTp-ir C-Win 
FUNCTION fnTp-ir RETURNS CHARACTER
  ( iCod AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd-page1 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btDel-page1 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btGoTo 
     IMAGE-UP FILE "image/im-goto.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-goto.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "GoTo" 
     SIZE 6.14 BY 1.79 TOOLTIP "V† Para".

DEFINE BUTTON btGraf 
     IMAGE-UP FILE "image/im-graf.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-graf.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Gr†fico".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btMov 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentos da Categoria".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-page1 FOR 
      {&Filho} SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      categoria SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-page1 C-Win _FREEFORM
  QUERY br-page1 NO-LOCK DISPLAY
      {&CamposFilho}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 93 BY 8.71
         FONT 7
         TITLE "".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-page1 AT ROW 6 COL 2
     btGraf AT ROW 14.79 COL 82.86
     btMov AT ROW 14.79 COL 89
     btAdd-page1 AT ROW 14.79 COL 2
     btDel-page1 AT ROW 14.79 COL 14.29
     btExit AT ROW 1.5 COL 88
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btUpdate-page1 AT ROW 14.79 COL 8.14
     categoria.cod-categoria AT ROW 4.5 COL 21 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     categoria.ds-categoria AT ROW 4.5 COL 26.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 49 BY .79
     btGoTo AT ROW 1.5 COL 29
     btZoom AT ROW 1.5 COL 35.14
     RECT-5 AT ROW 4 COL 2
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 95 BY 15.71
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
         TITLE              = "Cadastro de Sub-Categorias"
         HEIGHT             = 15.71
         WIDTH              = 95
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 95
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 95
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
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br-page1 1 DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} OF {&Table} NO-LOCK INDEXED-REPOSITION.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.categoria"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Cadastro de Sub-Categorias */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Cadastro de Sub-Categorias */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-page1
&Scoped-define SELF-NAME br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON DELETE-CHARACTER OF br-page1 IN FRAME DEFAULT-FRAME
DO:
    {func\br_del.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON MOUSE-SELECT-DBLCLICK OF br-page1 IN FRAME DEFAULT-FRAME
OR RETURN OF br-page1 DO:
    {func\br_dbclick.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    {func\bt_add_page.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    {func\bt_del_page.i}
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


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_first.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btGoTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGoTo C-Win
ON CHOOSE OF btGoTo IN FRAME DEFAULT-FRAME /* GoTo */
DO:
    {func\bt_goto.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btGraf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGraf C-Win
ON CHOOSE OF btGraf IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").
    ASSIGN cParamRelat = "cat=" + STRING(categoria.cod-categoria) +
                         ",sub=" + STRING(sub-cat.cd-sub).
    {func\run.i &Programa = "graf\g019.w"}
    ASSIGN cParamRelat = "".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_last.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMov C-Win
ON CHOOSE OF btMov IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    RUN som.p(INPUT "music\click.wav").

    SESSION:SET-WAIT-STATE("GENERAL").
    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "consmov.txt").
    FOR EACH mov-conta 
        WHERE mov-conta.cod-categoria = categoria.cod-categoria
        AND   mov-conta.cd-sub = sub-cat.cd-sub NO-LOCK:
        PUT UNFORMATTED STRING(ROWID(mov-conta)) + ",".
    END.
    OUTPUT CLOSE.
    SESSION:SET-WAIT-STATE("").

    {func\run.i &Programa = "consmov.w"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:  
   {func\bt_next.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    {func\bt_update_page.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btZoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btZoom C-Win
ON CHOOSE OF btZoom IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_zoom.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

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
  {version.i subcat}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\master_detail\control_buttons.i}

IF l-habilita THEN DO:
    ENABLE btGraf
           btMov WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    DISABLE btGraf
            btMov WITH FRAME {&FRAME-NAME}.
END.

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

{func\master_detail\display.i}

IF NOT AVAIL {&Table} THEN DO:

    ASSIGN categoria.cod-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           categoria.ds-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

END.

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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  IF AVAILABLE categoria THEN 
    DISPLAY categoria.cod-categoria categoria.ds-categoria 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-page1 btGraf btMov btAdd-page1 btDel-page1 btExit btFirst btLast 
         btNext btPrev btUpdate-page1 categoria.cod-categoria 
         categoria.ds-categoria btGoTo btZoom RECT-5 RECT-6 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
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
DEFINE VARIABLE whColuna AS WIDGET-HANDLE     NO-UNDO.

{func\initialize.i}

ASSIGN whColuna = BROWSE br-page1:GET-BROWSE-COLUMN(4)
       whColuna:WIDTH = 6.

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

    /* Pesquisa Relacionamentos */
    IF CAN-FIND(FIRST alerta-exc OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria com Alertas Espec°ficos!"
                       &Ajuda     = "Existem usu†rios com alertas espec°ficos referenciando essa sub-categoria e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST nota-fiscal OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria com Notas Fiscais!"
                       &Ajuda     = "Existem notas fiscais referenciando essa sub-categoria e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST mov-conta OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria em Movimento!"
                       &Ajuda     = "Existem movimentos referenciando essa sub-categoria e por isso ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST item-orcamento OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria com Planejamento!"
                       &Ajuda     = "Existe um planejamento de oráamento para essa sub-categoria e por isso ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST item OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria com Itens!"
                       &Ajuda     = "Existem itens associados a essa sub-categoria e por isso ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST imposto OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria com Impostos!"
                       &Ajuda     = "Existem impostos associados a essa sub-categoria e por isso ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST agenda OF sub-cat) THEN DO:
        {func\valida.i &Mensagem  = "Sub-Categoria com Agendamentos!"
                       &Ajuda     = "Existem movimentos agendados referenciando essa sub-categoria e por isso ela n∆o pode ser eliminada."}
    END.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnId-tipo C-Win 
FUNCTION fnId-tipo RETURNS CHARACTER
  ( iCod AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    CASE iCod:
        WHEN 0 THEN RETURN "Receita".
        WHEN 1 THEN RETURN "Despesa".
        WHEN 2 THEN RETURN "Custo".
    END CASE.

    RETURN "".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnTp-ir C-Win 
FUNCTION fnTp-ir RETURNS CHARACTER
  ( iCod AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    IF categoria.id-tipo = 2 THEN
        IF NOT sub-cat.l-ir THEN RETURN "".

    IF categoria.id-tipo = 1 THEN
        IF NOT sub-cat.l-ir THEN 
            RETURN "".
        ELSE
            RETURN "Rendimento Tribut†vel".

    CASE iCod:
        WHEN 0 THEN RETURN "Abatimento Sem Limite".
        WHEN 1 THEN RETURN "Abatimento Educaá∆o".
        WHEN 2 THEN RETURN "Imposto Pago".
    END CASE.

    RETURN "".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

