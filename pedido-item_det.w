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
&GLOBAL-DEFINE Table        pedido-item
&GLOBAL-DEFINE Parent       pedido
&GLOBAL-DEFINE ParentField  nr-pedido
&GLOBAL-DEFINE KeyFields    pedido-item.sequencia
&GLOBAL-DEFINE FrameFields  pedido-item.cd-item pedido-item.cd-tabela-preco ~
                            pedido-item.val-tabela pedido-item.val-desconto ~
                            pedido-item.val-unitario pedido-item.qt-pedida ~
                            pedido-item.qt-atendida pedido-item.val-total ~
                            pedido-item.situacao pedido-item.qt-liberada ~
                            pedido-item.hora-fechada pedido-item.ds-pedido-item ~
                            pedido-item.ds-observacao pedido-item.perm-apont-s-tar
&GLOBAL-DEFINE FrameDisp    pedido.cd-favorecido favorecido.ds-favorecido

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS pedido-item.perm-apont-s-tar ~
pedido-item.nr-pedido pedido.cd-favorecido favorecido.ds-favorecido ~
pedido-item.sequencia pedido-item.situacao pedido-item.cd-item ~
pedido-item.ds-pedido-item pedido-item.cd-tabela-preco ~
pedido-item.val-tabela pedido-item.val-desconto pedido-item.val-unitario ~
pedido-item.qt-pedida pedido-item.qt-liberada pedido-item.hora-fechada ~
pedido-item.qt-atendida pedido-item.ds-observacao 
&Scoped-define ENABLED-TABLES pedido-item pedido favorecido
&Scoped-define FIRST-ENABLED-TABLE pedido-item
&Scoped-define SECOND-ENABLED-TABLE pedido
&Scoped-define THIRD-ENABLED-TABLE favorecido
&Scoped-Define ENABLED-OBJECTS desc-item desc-tab RECT-2 RECT-7 RECT-8 
&Scoped-Define DISPLAYED-FIELDS pedido-item.perm-apont-s-tar ~
pedido-item.nr-pedido pedido.cd-favorecido favorecido.ds-favorecido ~
pedido-item.sequencia pedido-item.situacao pedido-item.cd-item ~
pedido-item.ds-pedido-item pedido-item.cd-tabela-preco ~
pedido-item.val-tabela pedido-item.val-desconto pedido-item.val-unitario ~
pedido-item.val-total pedido-item.qt-pedida pedido-item.qt-liberada ~
pedido-item.hora-fechada pedido-item.qt-atendida pedido-item.ds-observacao 
&Scoped-define DISPLAYED-TABLES pedido-item pedido favorecido
&Scoped-define FIRST-DISPLAYED-TABLE pedido-item
&Scoped-define SECOND-DISPLAYED-TABLE pedido
&Scoped-define THIRD-DISPLAYED-TABLE favorecido
&Scoped-Define DISPLAYED-OBJECTS desc-item desc-tab qt-saldo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE VARIABLE desc-item AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY .79 NO-UNDO.

DEFINE VARIABLE desc-tab AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .79 NO-UNDO.

DEFINE VARIABLE qt-saldo AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Saldo" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 45 BY 5.5.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 32 BY 5.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     pedido-item.perm-apont-s-tar AT ROW 17.75 COL 2 WIDGET-ID 52
          VIEW-AS TOGGLE-BOX
          SIZE 22 BY .83
     pedido-item.nr-pedido AT ROW 1.5 COL 16 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 6.86 BY .79
     pedido.cd-favorecido AT ROW 1.5 COL 31 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     favorecido.ds-favorecido AT ROW 1.5 COL 36 COLON-ALIGNED NO-LABEL WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 33 BY .79
     btCancel AT ROW 17.75 COL 74.14
     pedido-item.sequencia AT ROW 3.25 COL 16 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     pedido-item.situacao AT ROW 3.25 COL 53 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Pendente",1,
                     "Iniciado",2,
                     "Atendido",3,
                     "Cancelado",9
          DROP-DOWN-LIST
          SIZE 16 BY 1
     btOK AT ROW 17.75 COL 68
     pedido-item.cd-item AT ROW 4.25 COL 16 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     pedido-item.ds-pedido-item AT ROW 5.25 COL 16 COLON-ALIGNED WIDGET-ID 48
          VIEW-AS FILL-IN 
          SIZE 53 BY .79
     pedido-item.cd-tabela-preco AT ROW 6.75 COL 14 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     pedido-item.val-tabela AT ROW 7.75 COL 14 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     desc-item AT ROW 4.25 COL 22 COLON-ALIGNED NO-LABEL WIDGET-ID 10 NO-TAB-STOP 
     pedido-item.val-desconto AT ROW 8.75 COL 14 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido-item.val-unitario AT ROW 9.75 COL 14 COLON-ALIGNED WIDGET-ID 30
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     pedido-item.val-total AT ROW 10.75 COL 14 COLON-ALIGNED WIDGET-ID 40
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
          BGCOLOR 21 FGCOLOR 15 
     pedido-item.qt-pedida AT ROW 6.75 COL 62 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     pedido-item.qt-liberada AT ROW 7.75 COL 62 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     pedido-item.hora-fechada AT ROW 8.75 COL 64 WIDGET-ID 46
          VIEW-AS TOGGLE-BOX
          SIZE 12 BY .83
     desc-tab AT ROW 6.75 COL 18 COLON-ALIGNED NO-LABEL WIDGET-ID 24 NO-TAB-STOP 
     pedido-item.qt-atendida AT ROW 9.75 COL 62 COLON-ALIGNED WIDGET-ID 36
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     qt-saldo AT ROW 10.75 COL 62 COLON-ALIGNED WIDGET-ID 42
     pedido-item.ds-observacao AT ROW 12.25 COL 2 NO-LABEL WIDGET-ID 50
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 78 BY 5.25
     RECT-2 AT ROW 1.25 COL 2
     RECT-7 AT ROW 6.5 COL 2 WIDGET-ID 32
     RECT-8 AT ROW 6.5 COL 48 WIDGET-ID 34
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 79.57 BY 18.67
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
         TITLE              = "Template Padr∆o de Detalhe"
         HEIGHT             = 18.67
         WIDTH              = 79.57
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 30.04
         VIRTUAL-WIDTH      = 146.29
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
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       desc-item:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       desc-tab:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       pedido-item.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

/* SETTINGS FOR FILL-IN qt-saldo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN pedido-item.val-total IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Detalhe */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Detalhe */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cad_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cad_ok.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.cd-item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.cd-item C-Win
ON ENTRY OF pedido-item.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.cd-item C-Win
ON LEAVE OF pedido-item.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\leave.i &Tabela="item"
                  &Campo="cd-item"
                  &CampoProc="ds-item"
                  &Tela="desc-item"}  
                  
    IF INPUT FRAME {&FRAME-NAME} pedido-item.ds-pedido-item = "" THEN DO:
        ASSIGN pedido-item.ds-pedido-item:SCREEN-VALUE = desc-item:SCREEN-VALUE.
    END.

    IF INPUT FRAME {&FRAME-NAME} pedido-item.cd-tabela-preco = 0 THEN DO:
        IF AVAIL bfl-item THEN DO:
            FIND FIRST tabela-preco NO-LOCK
                WHERE tabela-preco.cd-favorecido = pedido.cliente-fat
                AND   tabela-preco.dt-val-ini <= pedido.dt-pedido
                AND   tabela-preco.dt-val-fim >= pedido.dt-pedido NO-ERROR.
            IF NOT AVAIL tabela-preco THEN DO:
                FIND FIRST tabela-preco NO-LOCK
                    WHERE tabela-preco.cd-favorecido = ?
                    AND   tabela-preco.dt-val-ini <= pedido.dt-pedido
                    AND   tabela-preco.dt-val-fim >= pedido.dt-pedido NO-ERROR.
                IF NOT AVAIL tabela-preco THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Tabela de Preáo (049)', INPUT 'N∆o existe tabela de preáo v†lida.', INPUT 'N∆o existe nenhuma tabela de preáo dentro da validade cadastrada no sistema.')"}
                END.
            END.

            IF AVAIL tabela-preco THEN DO:

                ASSIGN pedido-item.cd-tabela-preco:SCREEN-VALUE = STRING(tabela-preco.cd-tabela-preco).
                APPLY "LEAVE" TO pedido-item.cd-tabela-preco.

                FIND FIRST tabela-preco-item OF tabela-preco NO-LOCK
                    WHERE tabela-preco-item.cd-item = bfl-item.cd-item NO-ERROR.
                IF NOT AVAIL tabela-preco-item THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Tabela de Preáo (050)', INPUT 'Item inv†lido.', INPUT 'N∆o existe preáo para o item na tabela de preáo do cliente.')"}
                END.
                ELSE DO:
                    ASSIGN pedido-item.val-tabela:SCREEN-VALUE = STRING(tabela-preco-item.val-unitario).
                    RUN recalc.
                END.

            END.

        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.cd-item C-Win
ON MOUSE-SELECT-DBLCLICK OF pedido-item.cd-item IN FRAME DEFAULT-FRAME /* Item */
OR F5 OF {&Table}.cd-item DO:
    {func\zoom.i &Tabela="item"
                 &Campo1="cd-item"
                 &Tela1="pedido-item.cd-item"
                 &Campo2="ds-item"
                 &Tela2="desc-item"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.cd-tabela-preco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.cd-tabela-preco C-Win
ON ENTRY OF pedido-item.cd-tabela-preco IN FRAME DEFAULT-FRAME /* Tabela de Preáo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.cd-tabela-preco C-Win
ON LEAVE OF pedido-item.cd-tabela-preco IN FRAME DEFAULT-FRAME /* Tabela de Preáo */
DO:
    {func\leave.i &Tabela="tabela-preco"
                  &Campo="cd-tabela-preco"
                  &CampoProc="ds-tabela-preco"
                  &Tela="desc-tab"}    
                  
    IF AVAIL bfl-tabela-preco THEN DO:

        FIND FIRST tabela-preco-item OF bfl-tabela-preco NO-LOCK
            WHERE tabela-preco-item.cd-item = INPUT FRAME {&FRAME-NAME} pedido-item.cd-item NO-ERROR.
        IF NOT AVAIL tabela-preco-item THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Tabela de Preáo (050)', INPUT 'Item inv†lido.', INPUT 'N∆o existe preáo para o item na tabela de preáo do cliente.')"}
        END.
        ELSE DO:
            ASSIGN pedido-item.val-tabela:SCREEN-VALUE = STRING(tabela-preco-item.val-unitario).
            RUN recalc.
        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.cd-tabela-preco C-Win
ON MOUSE-SELECT-DBLCLICK OF pedido-item.cd-tabela-preco IN FRAME DEFAULT-FRAME /* Tabela de Preáo */
OR F5 OF {&Table}.cd-tabela-preco DO:
    {func\zoom.i &Tabela="tabela-preco"
                 &Campo1="cd-tabela-preco"
                 &Tela1="pedido-item.cd-tabela-preco"
                 &Campo2="ds-tabela-preco"
                 &Tela2="desc-tab"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.qt-atendida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.qt-atendida C-Win
ON ENTRY OF pedido-item.qt-atendida IN FRAME DEFAULT-FRAME /* Qtde Atendida */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.qt-atendida C-Win
ON LEAVE OF pedido-item.qt-atendida IN FRAME DEFAULT-FRAME /* Qtde Atendida */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.qt-pedida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.qt-pedida C-Win
ON ENTRY OF pedido-item.qt-pedida IN FRAME DEFAULT-FRAME /* Qtde Pedida */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.qt-pedida C-Win
ON LEAVE OF pedido-item.qt-pedida IN FRAME DEFAULT-FRAME /* Qtde Pedida */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.situacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.situacao C-Win
ON ENTRY OF pedido-item.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.situacao C-Win
ON LEAVE OF pedido-item.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.situacao C-Win
ON VALUE-CHANGED OF pedido-item.situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} pedido-item.situacao = 2 /* Iniciado */ THEN DO:
        ENABLE pedido-item.qt-atendida
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE pedido-item.qt-atendida
            WITH FRAME {&FRAME-NAME}.
        APPLY "LEAVE" TO pedido-item.qt-pedida.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.val-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-desconto C-Win
ON ENTRY OF pedido-item.val-desconto IN FRAME DEFAULT-FRAME /* Desconto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-desconto C-Win
ON LEAVE OF pedido-item.val-desconto IN FRAME DEFAULT-FRAME /* Desconto */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.val-tabela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-tabela C-Win
ON ENTRY OF pedido-item.val-tabela IN FRAME DEFAULT-FRAME /* Valor Tabela */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-tabela C-Win
ON LEAVE OF pedido-item.val-tabela IN FRAME DEFAULT-FRAME /* Valor Tabela */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.val-total
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-total C-Win
ON ENTRY OF pedido-item.val-total IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-total C-Win
ON LEAVE OF pedido-item.val-total IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pedido-item.val-unitario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-unitario C-Win
ON ENTRY OF pedido-item.val-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pedido-item.val-unitario C-Win
ON LEAVE OF pedido-item.val-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-item
                          &FOREACH = "item BY item.ds-item"
                          &CAMPO = item.ds-item
                          &ObjPai = pedido-item.cd-item}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-tab
                          &FOREACH = "tabela-preco BY tabela-preco.ds-tabela-preco"
                          &CAMPO = tabela-preco.ds-tabela-preco
                          &ObjPai = pedido-item.cd-tabela-preco}
                          
{func\calc.i pedido-item.val-tabela}
{func\calc.i pedido-item.val-desconto}
{func\calc.i pedido-item.val-unitario}
{func\calc.i pedido-item.qt-pedida}
{func\calc.i pedido-item.qt-atendida}

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
  {version.i pedido-item_det}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterAssignFields C-Win 
PROCEDURE afterAssignFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    /* Controla a situaá∆o do pedido */
    FIND FIRST pedido OF pedido-item EXCLUSIVE-LOCK.
    ASSIGN pedido.situacao = 1. /* Pendente */
    IF CAN-FIND(FIRST bf-pedido-item OF pedido
                WHERE bf-pedido-item.situacao = 2
                OR    bf-pedido-item.situacao = 3) THEN
        ASSIGN pedido.situacao = 2. /* Iniciado */
    IF NOT CAN-FIND(FIRST bf-pedido-item OF pedido
                    WHERE bf-pedido-item.situacao = 1
                    OR    bf-pedido-item.situacao = 2) THEN
        ASSIGN pedido.situacao = 3. /* Atendido */
    IF NOT CAN-FIND(FIRST bf-pedido-item OF pedido
                    WHERE bf-pedido-item.situacao = 1
                    OR    bf-pedido-item.situacao = 2
                    OR    bf-pedido-item.situacao = 3)
    AND CAN-FIND(FIRST bf-pedido-item OF pedido
                 WHERE bf-pedido-item.situacao = 9) THEN
        ASSIGN pedido.situacao = 9. /* Cancelado */

    /* Valor Total do Pedido */
    ASSIGN pedido.val-itens = 0
           pedido.val-impostos = 0
           pedido.val-total = 0.
    FOR EACH bf-pedido-item OF pedido
        WHERE bf-pedido-item.situacao <> 9 /* Cancelado */:
        ASSIGN pedido.val-itens = pedido.val-itens + bf-pedido-item.val-total.
    END.
    ASSIGN pedido.val-impostos = (pedido.val-itens * pedido.pc-impto) / 100
           pedido.val-total = pedido.val-itens - pedido.val-desconto + pedido.val-impostos.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE assignIniFields C-Win 
PROCEDURE assignIniFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND LAST bf-pedido-item OF pedido NO-LOCK NO-ERROR.
    IF AVAIL bf-pedido-item THEN
        ASSIGN pedido-item.sequencia = bf-pedido-item.sequencia + 1.
    ELSE
        ASSIGN pedido-item.sequencia = 1.

    RETURN "OK".

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

FIND FIRST favorecido OF pedido NO-LOCK NO-ERROR.

{func\detalhe\display.i}

APPLY "LEAVE" TO pedido-item.cd-item.
APPLY "LEAVE" TO pedido-item.cd-tabela-preco.

DISABLE pedido-item.sequencia
        pedido-item.val-total
        pedido-item.val-tabela
        pedido-item.qt-atendida
    WITH FRAME {&FRAME-NAME}.

APPLY "VALUE-CHANGED" TO pedido-item.situacao.

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
  DISPLAY desc-item desc-tab qt-saldo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.ds-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE pedido THEN 
    DISPLAY pedido.cd-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE pedido-item THEN 
    DISPLAY pedido-item.perm-apont-s-tar pedido-item.nr-pedido 
          pedido-item.sequencia pedido-item.situacao pedido-item.cd-item 
          pedido-item.ds-pedido-item pedido-item.cd-tabela-preco 
          pedido-item.val-tabela pedido-item.val-desconto 
          pedido-item.val-unitario pedido-item.val-total pedido-item.qt-pedida 
          pedido-item.qt-liberada pedido-item.hora-fechada 
          pedido-item.qt-atendida pedido-item.ds-observacao 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE pedido-item.perm-apont-s-tar pedido-item.nr-pedido 
         pedido.cd-favorecido favorecido.ds-favorecido pedido-item.sequencia 
         pedido-item.situacao pedido-item.cd-item pedido-item.ds-pedido-item 
         pedido-item.cd-tabela-preco pedido-item.val-tabela desc-item 
         pedido-item.val-desconto pedido-item.val-unitario 
         pedido-item.qt-pedida pedido-item.qt-liberada pedido-item.hora-fechada 
         desc-tab pedido-item.qt-atendida pedido-item.ds-observacao RECT-2 
         RECT-7 RECT-8 
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

{func\detalhe\initialize.i}

{func\cursor.i pedido-item.cd-item}
{func\cursor.i pedido-item.cd-tabela-preco}

IF pcActionBT = "ADD" THEN DO:
    ASSIGN pedido-item.hora-fechada:CHECKED = FALSE.
END.

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

IF cObject = "desc-item" THEN DO:
    FIND FIRST item NO-LOCK
        WHERE item.ds-item = INPUT FRAME {&FRAME-NAME} desc-item NO-ERROR.
    IF AVAIL item THEN DO:
        ASSIGN pedido-item.cd-item:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(item.cd-item).
    END.
END.
IF cObject = "desc-tab" THEN DO:
    FIND FIRST tabela-preco NO-LOCK
        WHERE tabela-preco.ds-tabela-preco = INPUT FRAME {&FRAME-NAME} desc-tab NO-ERROR.
    IF AVAIL tabela-preco THEN DO:
        ASSIGN pedido-item.cd-tabela-preco:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(tabela-preco.cd-tabela-preco).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalc C-Win 
PROCEDURE recalc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    
    DEFINE VARIABLE deValUnit AS DECIMAL     NO-UNDO INITIAL 0.
    DEFINE VARIABLE deQtde    AS DECIMAL     NO-UNDO INITIAL 0.

    IF INPUT FRAME {&FRAME-NAME} pedido-item.val-tabela <> 0 THEN DO:
        ENABLE pedido-item.val-desconto
            WITH FRAME {&FRAME-NAME}.
        ASSIGN deValUnit = INPUT FRAME {&FRAME-NAME} pedido-item.val-tabela -
                           INPUT FRAME {&FRAME-NAME} pedido-item.val-desconto
               pedido-item.val-unitario:SCREEN-VALUE = STRING(deValUnit).        
        DISABLE pedido-item.val-unitario
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ENABLE pedido-item.val-unitario
            WITH FRAME {&FRAME-NAME}.
        ASSIGN pedido-item.val-desconto:SCREEN-VALUE = "0,00".
        DISABLE pedido-item.val-desconto
            WITH FRAME {&FRAME-NAME}.
        ASSIGN deValUnit = INPUT FRAME {&FRAME-NAME} pedido-item.val-unitario.
    END.

    ASSIGN deQtde = INPUT FRAME {&FRAME-NAME} pedido-item.qt-pedida.

    IF INPUT FRAME {&FRAME-NAME} pedido-item.situacao <> 2 /* Iniciado */ THEN DO:
        CASE INPUT FRAME {&FRAME-NAME} pedido-item.situacao:
            WHEN 1 /* Pendente */ THEN ASSIGN pedido-item.qt-atendida = 0.
            OTHERWISE ASSIGN pedido-item.qt-atendida = INPUT FRAME {&FRAME-NAME} pedido-item.qt-pedida.
        END CASE.
        DISPLAY pedido-item.qt-atendida
            WITH FRAME {&FRAME-NAME}.
    END.

    ASSIGN pedido-item.val-total = deValUnit * deQtde
           qt-saldo = deQtde - INPUT FRAME {&FRAME-NAME} pedido-item.qt-atendida.

    DISPLAY pedido-item.val-total
            qt-saldo
        WITH FRAME {&FRAME-NAME}.

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

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-pedido-item NO-LOCK
        WHERE bf-pedido-item.nr-pedido = INPUT FRAME {&FRAME-NAME} pedido-item.nr-pedido
        AND   bf-pedido-item.sequencia = INPUT FRAME {&FRAME-NAME} pedido-item.sequencia
        AND   ROWID(bf-pedido-item) <> ROWID(pedido-item) NO-ERROR.
    IF AVAIL bf-pedido-item THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:

    FIND FIRST item NO-LOCK
        WHERE item.cd-item = INPUT FRAME {&FRAME-NAME} pedido-item.cd-item NO-ERROR.
    IF NOT AVAIL item THEN DO:
        {func\valida.i &Mensagem  = "Item n∆o existente!"
                       &Ajuda     = "Vocà deve informar um item existente."
                       &Campo     = pedido-item.cd-item}
    END.
    ELSE DO:
        IF item.tipo = 1 /* Compra */ THEN DO:
            {func\valida.i &Mensagem  = "Item n∆o Ç de Venda!"
                           &Ajuda     = "Vocà deve informar um item do tipo Venda."
                           &Campo     = pedido-item.cd-item}
        END.
    END.

    FIND FIRST tabela-preco NO-LOCK
        WHERE tabela-preco.cd-tabela-preco = INPUT FRAME {&FRAME-NAME} pedido-item.cd-tabela-preco NO-ERROR.
    IF NOT AVAIL tabela-preco THEN DO:
        {func\valida.i &Mensagem  = "Tabela de Preáo n∆o existente!"
                       &Ajuda     = "Vocà deve informar uma Tabela de Preáo existente."
                       &Campo     = pedido-item.cd-tabela-preco}
    END.
    ELSE DO:
        IF tabela-preco.dt-val-ini > pedido.dt-pedido
        OR tabela-preco.dt-val-fim < pedido.dt-pedido THEN DO:
            {func\valida.i &Mensagem  = "Tabela de Preáo fora da validade!"
                           &Ajuda     = "Vocà deve informar uma Tabela de Preáo que esteja dentro do per°odo de validade."
                           &Campo     = pedido-item.cd-tabela-preco}
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} pedido-item.qt-pedida = 0 THEN DO:
        {func\valida.i &Mensagem  = "Quantidade Pedida n∆o informado!"
                       &Ajuda     = "Vocà deve informar a Quantidade Pedida do item."
                       &Campo     = pedido-item.qt-pedida}
    END.

    IF INPUT FRAME {&FRAME-NAME} pedido-item.qt-liberada = 0 THEN DO:
        IF INPUT FRAME {&FRAME-NAME} pedido-item.qt-atendida > INPUT FRAME {&FRAME-NAME} pedido-item.qt-pedida THEN DO:
            {func\valida.i &Mensagem  = "Quantidade Atendida inv†lida!"
                           &Ajuda     = "A Quantidade Atendida deve ser menor ou igual a Quantidade Pedida."
                           &Campo     = pedido-item.qt-atendida}
        END.
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} pedido-item.qt-atendida > INPUT FRAME {&FRAME-NAME} pedido-item.qt-liberada THEN DO:
            {func\valida.i &Mensagem  = "Quantidade Atendida inv†lida!"
                           &Ajuda     = "A Quantidade Atendida deve ser menor ou igual a Quantidade Liberada."
                           &Campo     = pedido-item.qt-atendida}
        END.
    END.

END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

