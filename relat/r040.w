&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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
DEFINE TEMP-TABLE tt-item LIKE item-compra
    FIELD descricao AS CHAR FORMAT "X(40)" COLUMN-LABEL "Descriá∆o"
    FIELD unidade AS CHAR FORMAT "X(3)" COLUMN-LABEL "UN"
    FIELD local   AS CHAR FORMAT "X(40)" COLUMN-LABEL "Local"
    FIELD melhor-preco AS DEC FORMAT ">>,>>9.99" COLUMN-LABEL "Melhor Preáo"
    FIELD melhor-local AS CHAR FORMAT "X(40)" COLUMN-LABEL "Melhor Local"
    FIELD cod-categoria AS INT FORMAT "999"
    FIELD cd-sub        AS INT FORMAT "999"
    INDEX idx IS PRIMARY UNIQUE descricao.

/* Parameters Definitions ---                                           */
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  data-ini moeda previa

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}
{campos\cd-favorecido.i}
{campos\cd-sub.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brItem

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-item

/* Definitions for BROWSE brItem                                        */
&Scoped-define FIELDS-IN-QUERY-brItem tt-item.cd-item tt-item.descricao tt-item.quantidade tt-item.unidade tt-item.vl-unitario tt-item.vl-total   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brItem tt-item.cd-item   tt-item.descricao   tt-item.quantidade   tt-item.unidade   tt-item.vl-unitario   
&Scoped-define ENABLED-TABLES-IN-QUERY-brItem tt-item
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-brItem tt-item
&Scoped-define SELF-NAME brItem
&Scoped-define QUERY-STRING-brItem FOR EACH tt-item
&Scoped-define OPEN-QUERY-brItem OPEN QUERY {&SELF-NAME} FOR EACH tt-item.
&Scoped-define TABLES-IN-QUERY-brItem tt-item
&Scoped-define FIRST-TABLE-IN-QUERY-brItem tt-item


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brItem}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btAdd RECT-10 data-ini previa moeda brItem ~
btCancel btOK 
&Scoped-Define DISPLAYED-OBJECTS data-ini previa moeda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnAtribuiLocal C-Win 
FUNCTION fnAtribuiLocal RETURNS CHARACTER
  (  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btDel 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btMod 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

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

DEFINE VARIABLE data-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 14.5.

DEFINE VARIABLE previa AS LOGICAL INITIAL no 
     LABEL "Vizualizaá∆o PrÇvia" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brItem FOR 
      tt-item SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brItem C-Win _FREEFORM
  QUERY brItem DISPLAY
      tt-item.cd-item
 tt-item.descricao
 tt-item.quantidade
 tt-item.unidade FORMAT "X(5)"
 tt-item.vl-unitario
 tt-item.vl-total
     ENABLE
     tt-item.cd-item
     tt-item.descricao
     tt-item.quantidade
     tt-item.unidade
     tt-item.vl-unitario
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 70 BY 11.25
         FONT 7
         TITLE "Itens Adicionais".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAdd AT ROW 4 COL 74
     data-ini AT ROW 1.75 COL 24 COLON-ALIGNED
     previa AT ROW 1.75 COL 37
     moeda AT ROW 2.75 COL 24 COLON-ALIGNED
     brItem AT ROW 4 COL 3
     btDel AT ROW 7.5 COL 74
     btMod AT ROW 5.75 COL 74
     btCancel AT ROW 13.5 COL 74
     btOK AT ROW 11.75 COL 74
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.86 BY 15.75
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
         HEIGHT             = 15.75
         WIDTH              = 80.86
         MAX-HEIGHT         = 19.46
         MAX-WIDTH          = 93.72
         VIRTUAL-HEIGHT     = 19.46
         VIRTUAL-WIDTH      = 93.72
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
/* BROWSE-TAB brItem moeda DEFAULT-FRAME */
ASSIGN 
       brItem:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brItem:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR BUTTON btDel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btMod IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brItem
/* Query rebuild information for BROWSE brItem
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-item.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brItem */
&ANALYZE-RESUME

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
       ROW             = 16
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 79
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(brItem:HANDLE IN FRAME DEFAULT-FRAME).

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


&Scoped-define BROWSE-NAME brItem
&Scoped-define SELF-NAME brItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brItem C-Win
ON OFF-END OF brItem IN FRAME DEFAULT-FRAME /* Itens Adicionais */
DO:
    apply 'entry' to data-ini in frame {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brItem C-Win
ON ROW-LEAVE OF brItem IN FRAME DEFAULT-FRAME /* Itens Adicionais */
DO:

    if  brItem:new-row in frame {&FRAME-NAME} then do transaction on error undo, return no-apply:
       /* Validaá‰es de Inclus∆o */

        create tt-item.
        assign input browse brItem tt-item.cd-item
               input browse brItem tt-item.descricao
               input browse brItem tt-item.quantidade
               input browse brItem tt-item.unidade
               input browse brItem tt-item.vl-unitario
               tt-item.vl-total = tt-item.quantidade * tt-item.vl-unitario.

        FIND FIRST item NO-LOCK
            WHERE item.cd-item = tt-item.cd-item NO-ERROR.
        IF AVAIL item THEN DO:
            ASSIGN tt-item.cod-categoria = item.cod-categoria
                   tt-item.cd-sub = item.cd-sub.
        END.

        fnAtribuiLocal().
       
        brItem:CREATE-RESULT-LIST-ENTRY().       
    end.        
    else do transaction:
        /* Validaá‰es de Modificaá∆o */
        assign input browse brItem tt-item.cd-item
               input browse brItem tt-item.descricao
               input browse brItem tt-item.quantidade
               input browse brItem tt-item.unidade
               input browse brItem tt-item.vl-unitario
               tt-item.vl-total = tt-item.quantidade * tt-item.vl-unitario.

        DISPLAY tt-item.vl-unitario WITH BROWSE brItem.

    end.

    DISPLAY tt-item.vl-total WITH BROWSE brItem.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* Cancelar */
DO:

    RUN som.p(INPUT "music\click.wav").
    brItem:insert-row('after') in frame {&FRAME-NAME}.

    ENABLE btMod
           btDel WITH FRAME {&FRAME-NAME}.

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


&Scoped-define SELF-NAME btDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel C-Win
ON CHOOSE OF btDel IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    RUN som.p(INPUT "music\click.wav").
    if AVAIL tt-item then do on error undo, return no-apply:
        delete tt-item.
        {&OPEN-QUERY-brItem}
    end.
    IF NOT CAN-FIND(FIRST tt-item) THEN DO:
        DISABLE btMod
                btDel WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMod C-Win
ON CHOOSE OF btMod IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    RUN som.p(INPUT "music\click.wav").
   apply 'entry' to tt-item.cd-item in browse brItem. 
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


&Scoped-define SELF-NAME previa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL previa C-Win
ON VALUE-CHANGED OF previa IN FRAME DEFAULT-FRAME /* Vizualizaá∆o PrÇvia */
DO:
    ASSIGN INPUT FRAME {&FRAME-NAME} data-ini.
    RUN criaTT.

    IF CAN-FIND(FIRST tt-item) THEN DO:
        ENABLE btMod
               btDel WITH FRAME {&FRAME-NAME}.
    END.

    {&OPEN-QUERY-brItem}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\relat\main_block.i}

{campos\cd-moeda.i}                

{func\calendar.i data-ini}

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

ON TAB OF tt-item.vl-unitario IN BROWSE brItem
DO:
    APPLY "ROW-LEAVE" TO brItem IN FRAME {&FRAME-NAME}.
END.

ON F5 OF tt-item.cd-item IN BROWSE brItem
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    ASSIGN glImplantar = YES
           gcFiltro = "".
    {func\run.i &Programa = "zoom\zitem.w (OUTPUT rReturn)"}
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST ITEM NO-LOCK
            WHERE ROWID(ITEM) = rReturn.
        ASSIGN tt-item.cd-item:SCREEN-VALUE IN BROWSE brItem = STRING(ITEM.cd-item).
    END.
END.

ON TAB OF tt-item.cd-item IN BROWSE brItem
DO:
    FIND FIRST ITEM NO-LOCK
        WHERE ITEM.cd-item = INPUT BROWSE brItem tt-item.cd-item NO-ERROR.
    IF AVAIL ITEM THEN DO:
        ASSIGN tt-item.descricao:SCREEN-VALUE IN BROWSE brItem = ITEM.ds-item
               tt-item.unidade:SCREEN-VALUE IN BROWSE brItem = ITEM.un.
        FIND LAST compra NO-LOCK
            WHERE CAN-FIND(FIRST item-compra OF compra
                           WHERE item-compra.cd-item = ITEM.cd-item) NO-ERROR.
        IF AVAIL compra THEN DO:
            FIND FIRST item-compra OF compra NO-LOCK
                WHERE item-compra.cd-item = ITEM.cd-item NO-ERROR.
            ASSIGN tt-item.vl-unitario:SCREEN-VALUE IN BROWSE brItem = STRING(item-compra.vl-unitario).
        END.
    END.
    ELSE DO:
        ASSIGN tt-item.descricao:SCREEN-VALUE IN BROWSE brItem = "Item Desconhecido".
    END.
END.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i r040}
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

OCXFile = SEARCH( "r040.wrx":U ).
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
ELSE MESSAGE "r040.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaTT C-Win 
PROCEDURE criaTT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE rCompra AS ROWID      NO-UNDO.
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE deMedia AS DECIMAL    NO-UNDO EXTENT 3.
    DEFINE VARIABLE iNumCompras AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deQtde AS DECIMAL    NO-UNDO.
  
    DISABLE previa WITH FRAME {&FRAME-NAME}.

    FOR EACH item NO-LOCK
        WHERE item.controlado:

        IF item.dt-ult-compra = ? THEN NEXT.
        IF item.reposicao = 0 THEN NEXT.

        FOR LAST compra NO-LOCK
            WHERE CAN-FIND(FIRST item-compra OF compra
                           WHERE item-compra.cd-item = item.cd-item)
            BY compra.dt-compra:
            ASSIGN rCompra = ROWID(compra).
        END.
        FIND FIRST compra NO-LOCK 
            WHERE ROWID(compra) = rCompra NO-ERROR.
        IF NOT AVAIL compra THEN NEXT.

        FIND FIRST item-compra OF compra
            WHERE item-compra.cd-item = item.cd-item NO-LOCK NO-ERROR.
        ASSIGN dtTemp = item.dt-ult-compra + INT(item.reposicao * item-compra.quantidade).

        IF INT(TODAY - item.dt-ult-compra) > (INT(dtTemp - item.dt-ult-compra) * 2) THEN NEXT.

        IF dtTemp > data-ini THEN NEXT.

        ASSIGN deMedia[1] = 0
               deMedia[2] = 0
               deMedia[3] = 0
               iNumCompras = 0.
        FOR EACH item-compra OF item NO-LOCK:
            ASSIGN deMedia[1] = deMedia[2]
                   deMedia[2] = deMedia[3]
                   deMedia[3] = item-compra.quantidade
                   iNumCompras = iNumCompras + 1.
        END.
        FIND FIRST item-compra OF compra
            WHERE item-compra.cd-item = item.cd-item NO-LOCK NO-ERROR.

        IF iNumCompras > 3 THEN
            ASSIGN iNumCompras = 3.

        ASSIGN deQtde = ((deMedia[1] + deMedia[2] + deMedia[3]) / iNumCompras).
        IF NOT item.permite-dec THEN
            ASSIGN deQtde = INT(deQtde).

        CREATE tt-item.
        BUFFER-COPY item-compra TO tt-item.
        ASSIGN tt-item.descricao        = ITEM.ds-item
               tt-item.un               = ITEM.unidade
               tt-item.quantidade       = deQtde
               tt-item.vl-total         = tt-item.quantidade * tt-item.vl-unitario
               tt-item.cod-categoria    = ITEM.cod-categoria
               tt-item.cd-sub           = ITEM.cd-sub.

        fnAtribuiLocal().

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
  DISPLAY data-ini previa moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btAdd RECT-10 data-ini previa moeda brItem btCancel btOK 
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

DEFINE VARIABLE iMax AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTemp AS CHARACTER FORMAT "x(40)"  NO-UNDO.
DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deMedia AS DECIMAL    NO-UNDO EXTENT 3.
DEFINE VARIABLE iNumCompras AS INTEGER    NO-UNDO.
DEFINE VARIABLE dtTemp AS DATE FORMAT "99/99/9999"      NO-UNDO.
DEFINE VARIABLE deQtde AS DECIMAL  FORMAT ">>9.9999"  NO-UNDO.
DEFINE VARIABLE rCompra AS ROWID      NO-UNDO.
DEFINE VARIABLE dtData AS DATE FORMAT "99/99/9999"      NO-UNDO.
DEFINE VARIABLE cLocal   AS CHARACTER FORMAT "x(40)"   NO-UNDO.
DEFINE VARIABLE c-melhor AS CHARACTER FORMAT "x(40)"   NO-UNDO.

/* Output padr∆o */
SELECT COUNT(*) INTO iMax FROM ITEM WHERE ITEM.controlado.
{func\relat\ini.i iMax}

ASSIGN cTemp = "Data: " + STRING(data-ini,"99/99/9999").
{func\relat\capitulo.i cTemp 800}
                     
IF NOT previa THEN DO:

    RUN criaTT.

END.

FOR EACH tt-item
    BREAK BY tt-item.cod-categoria
          BY tt-item.cd-sub: 


    IF FIRST-OF(tt-item.cd-sub) THEN DO:

        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = tt-item.cod-categoria NO-ERROR.

        {func\relat\end-capitulo.i}
        ASSIGN cTemp = categoria.ds-categoria + ": " + fnCd-sub(tt-item.cd-sub,tt-item.cod-categoria).
        {func\relat\capitulo.i cTemp 800}

        {func\relat\titulo.i &Coluna1='"Qtde"'
                             &Tamanho1=40
                             &Coluna2='"Un"'
                             &Tamanho2=30
                             &Coluna3='"Item"'
                             &Tamanho3=150
                             &Coluna4='"Valor"'
                             &Tamanho4=60
                             &Coluna5='"Total"'
                             &Tamanho5=60
                             &Coluna6='"Data Prevista"'
                             &Tamanho6=85
                             &Coluna7='"Èlt.Compra"'
                             &Tamanho7=85
                             &Coluna8='"Local"'
                             &Tamanho8=120
                             &Coluna9='"Melhor Compra - 180 Dias"'
                             &Tamanho9=200
                             &Small=YES}
        
    END.

       

    FIND LAST item NO-LOCK
        WHERE item.cd-item = tt-item.cd-item NO-ERROR.

    IF AVAIL item THEN DO:
        ASSIGN dtData = item.dt-ult-compra.
        IF item.reposicao <> 0 THEN DO:
            FOR LAST compra NO-LOCK
                WHERE CAN-FIND(FIRST item-compra OF compra
                               WHERE item-compra.cd-item = item.cd-item)
                BY compra.dt-compra:
                ASSIGN rCompra = ROWID(compra).
            END.
            FIND FIRST compra NO-LOCK 
                WHERE ROWID(compra) = rCompra NO-ERROR.
            IF NOT AVAIL compra THEN NEXT.

            FIND FIRST item-compra OF compra
                WHERE item-compra.cd-item = item.cd-item NO-LOCK NO-ERROR.
            ASSIGN dtTemp = item.dt-ult-compra + INT(item.reposicao * item-compra.quantidade).
        END.
        ELSE
            ASSIGN dtTemp = ?.

    END.
    ELSE
        ASSIGN dtData = ?
               dtTemp = ?.


    IF tt-item.melhor-local <> "" THEN
        ASSIGN c-melhor = tt-item.melhor-local + " (" + string(tt-item.melhor-preco,">>>>9.99") + ")".
    ELSE 
        ASSIGN c-melhor = "".
    

    {func\relat\linha.i &Coluna1=tt-item.quantidade
                        &Align1="right"
                        &Coluna2=tt-item.unidade
                        &Align2="center"
                        &Coluna3=tt-item.descricao
                        &Align3="left"
                        &Coluna4=tt-item.vl-unitario
                        &Align4="right"
                        &Coluna5=tt-item.vl-total
                        &Align5="right"
                        &Coluna6=dtTemp
                        &Align6="center" 
                        &Coluna7=dtData
                        &Align7="center"
                        &Coluna8=tt-item.local 
                        &Align8="left"
                        &Coluna9=c-melhor
                        &Align9="right"
                        &Small=YES}
                        
    ASSIGN deTotal = deTotal + tt-item.vl-total.
                    
END.
{func\relat\linha.i &Coluna1=''
                    &Align1="left"}

{func\relat\total.i &Coluna1=''
                    &Align1="right"
                    &Coluna2=''
                    &Align2="center"
                    &Coluna3='"TOTAL DA COMPRA"'
                    &Align3="left"
                    &Coluna4=''
                    &Align4="right"
                    &Coluna5=deTotal
                    &Align5="right"
                    &Coluna6=''
                    &Align6="right"
                    &Coluna7=''
                    &Align7="right"
                    &Coluna8=''
                    &Align8="right"
                    &Coluna9=''
                    &Align9="right"
                    &Small=YES}
     
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

ASSIGN data-ini = TODAY.

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnAtribuiLocal C-Win 
FUNCTION fnAtribuiLocal RETURNS CHARACTER
  (  ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FOR EACH item-compra NO-LOCK
        WHERE item-compra.cd-item = item.cd-item,
        FIRST compra OF item-compra NO-LOCK
            WHERE compra.dt-compra > (TODAY - 180)
            BREAK BY item-compra.vl-unitario:
        
        ASSIGN tt-item.melhor-preco = item-compra.vl-unitario.
               tt-item.melhor-local = fnCd-favorecido(compra.cd-favorecido).
        
        LEAVE.
    END.
    FOR LAST compra NO-LOCK
        WHERE CAN-FIND(FIRST item-compra OF compra
                       WHERE item-compra.cd-item = item.cd-item)
        BY compra.dt-compra:
        ASSIGN tt-item.local = fnCd-favorecido(compra.cd-favorecido).
    END.

    RETURN "OK".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

