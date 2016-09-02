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
&GLOBAL-DEFINE Table        conta
&GLOBAL-DEFINE KeyFields    conta.cd-conta
&GLOBAL-DEFINE FrameFields  conta.ds-conta conta.id-tipo conta.vl-saldo-ini ~
                            conta.vl-limite conta.id-encerrada conta.dinheiro ~
                            conta.dia-fat conta.cd-fav-padrao conta.cd-moeda ds-fav ~
                            conta.perc-ir

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

/* Buffers */

{func\definitions.i}
{func\tt_info.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS conta.perc-ir conta.cd-conta conta.ds-conta ~
conta.id-encerrada conta.id-tipo conta.dinheiro conta.dia-fat ~
conta.cd-fav-padrao conta.cd-moeda conta.vl-saldo-ini conta.vl-limite 
&Scoped-define ENABLED-TABLES conta
&Scoped-define FIRST-ENABLED-TABLE conta
&Scoped-Define ENABLED-OBJECTS btMov btGoTo btFirst btLast btNext btPrev ~
btAdd btDel btExit btUpdate btZoom RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS conta.perc-ir conta.cd-conta conta.ds-conta ~
conta.id-encerrada conta.id-tipo conta.dinheiro conta.dia-fat ~
conta.cd-fav-padrao conta.vl-saldo-ini conta.vl-limite 
&Scoped-define DISPLAYED-TABLES conta
&Scoped-define FIRST-DISPLAYED-TABLE conta
&Scoped-Define DISPLAYED-OBJECTS ds-fav 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btDel 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
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

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btMov 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Mov" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentaá∆o".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btUpdate 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE ds-fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 52 BY 6.25.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 47 BY 2.75.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 1.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 32 BY 4.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     conta.perc-ir AT ROW 9.25 COL 70 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     conta.cd-conta AT ROW 4.5 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     conta.ds-conta AT ROW 4.5 COL 17.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 50 BY .79
     btMov AT ROW 1.5 COL 64
     conta.id-encerrada AT ROW 4.5 COL 72
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY .83
     btGoTo AT ROW 1.5 COL 48.43
     conta.id-tipo AT ROW 6.5 COL 4 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Conta Corrente", 1,
"Conta de Investimentos", 2,
"Conta de CrÇdito", 3
          SIZE 19.57 BY 2.5
     ds-fav AT ROW 10.5 COL 22 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     conta.dinheiro AT ROW 9.25 COL 7
          VIEW-AS TOGGLE-BOX
          SIZE 20 BY .83
     conta.dia-fat AT ROW 9.25 COL 44 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     conta.cd-fav-padrao AT ROW 10.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5.72 BY .79
     btFirst AT ROW 1.5 COL 3
     conta.cd-moeda AT ROW 6.25 COL 62 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 9999
          LIST-ITEM-PAIRS "",0
          DROP-DOWN-LIST
          SIZE 21 BY 1
     conta.vl-saldo-ini AT ROW 7.25 COL 70 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     btLast AT ROW 1.5 COL 21.43
     conta.vl-limite AT ROW 8.25 COL 70 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 10.5 COL 81
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 10.5 COL 74.86
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     "Tipo" VIEW-AS TEXT
          SIZE 5 BY .67 AT ROW 5.75 COL 3
     "Valores" VIEW-AS TEXT
          SIZE 6 BY .54 AT ROW 5.75 COL 56
     RECT-2 AT ROW 6 COL 2
     RECT-3 AT ROW 9 COL 6
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-6 AT ROW 6 COL 55
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 11.29
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
         TITLE              = "Cadastro de contas"
         HEIGHT             = 11.29
         WIDTH              = 86.72
         MAX-HEIGHT         = 11.38
         MAX-WIDTH          = 86.72
         VIRTUAL-HEIGHT     = 11.38
         VIRTUAL-WIDTH      = 86.72
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
/* SETTINGS FOR COMBO-BOX conta.cd-moeda IN FRAME DEFAULT-FRAME
   NO-DISPLAY                                                           */
/* SETTINGS FOR FILL-IN ds-fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       ds-fav:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Cadastro de contas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Cadastro de contas */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_add.i "cd-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel C-Win
ON CHOOSE OF btDel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_del.i}
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
ON CHOOSE OF btMov IN FRAME DEFAULT-FRAME /* Mov */
DO:
    RUN som.p(INPUT "music\click.wav").
    ASSIGN r-conta = ROWID(conta).
    {func\run.i &Programa = "mov.w"}
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


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_ok.i}
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


&Scoped-define SELF-NAME btUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate C-Win
ON CHOOSE OF btUpdate IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_update.i}  
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


&Scoped-define SELF-NAME conta.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-conta C-Win
ON ENTRY OF conta.cd-conta IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-conta C-Win
ON LEAVE OF conta.cd-conta IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.cd-fav-padrao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-fav-padrao C-Win
ON ENTRY OF conta.cd-fav-padrao IN FRAME DEFAULT-FRAME /* Fav. Padr∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-fav-padrao C-Win
ON LEAVE OF conta.cd-fav-padrao IN FRAME DEFAULT-FRAME /* Fav. Padr∆o */
DO:
    {func\set_leave.i}  
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela = "cd-fav-padrao"
                  &CampoProc = "ds-favorecido"
                  &Tela="ds-fav"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-fav-padrao C-Win
ON MOUSE-SELECT-DBLCLICK OF conta.cd-fav-padrao IN FRAME DEFAULT-FRAME /* Fav. Padr∆o */
OR F5 OF {&Table}.cd-fav-padrao DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="conta.cd-fav-padrao"
                 &Campo2="ds-favorecido"
                 &Tela2="ds-fav"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.cd-moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-moeda C-Win
ON ENTRY OF conta.cd-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  

    IF INPUT FRAME default-frame conta.id-tipo = 2
    AND INPUT FRAME default-frame conta.cd-moeda <> 0 THEN DO:
        ENABLE conta.perc-ir WITH FRAME default-frame.
    END.
    ELSE DO:
        DISABLE conta.perc-ir WITH FRAME default-frame.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.cd-moeda C-Win
ON LEAVE OF conta.cd-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.dia-fat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.dia-fat C-Win
ON ENTRY OF conta.dia-fat IN FRAME DEFAULT-FRAME /* Dias Fatura */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.dia-fat C-Win
ON LEAVE OF conta.dia-fat IN FRAME DEFAULT-FRAME /* Dias Fatura */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.dinheiro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.dinheiro C-Win
ON VALUE-CHANGED OF conta.dinheiro IN FRAME DEFAULT-FRAME /* Conta de Dinheiro */
DO:
  
    IF INPUT FRAME default-frame conta.dinheiro THEN DO:
        DISABLE conta.dia-fat
                conta.cd-fav-padrao WITH FRAME default-frame.
    END.
    ELSE DO:
        ENABLE conta.dia-fat
               conta.cd-fav-padrao WITH FRAME default-frame.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.ds-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.ds-conta C-Win
ON ENTRY OF conta.ds-conta IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.ds-conta C-Win
ON LEAVE OF conta.ds-conta IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.id-tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.id-tipo C-Win
ON VALUE-CHANGED OF conta.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:

    IF INPUT FRAME default-frame conta.id-tipo = 2 THEN
        DISABLE conta.vl-limite WITH FRAME default-frame.
    ELSE
        ENABLE conta.vl-limite WITH FRAME default-frame.

    IF INPUT FRAME default-frame conta.id-tipo = 3 THEN DO:
        ENABLE conta.dinheiro WITH FRAME default-frame.
        APPLY "VALUE-CHANGED" TO conta.dinheiro IN FRAME default-frame.
    END.
    ELSE DO:
        DISABLE conta.dinheiro
                conta.dia-fat
                conta.cd-fav-padrao WITH FRAME default-frame.
    END.

    IF INPUT FRAME default-frame conta.id-tipo = 2
    AND INPUT FRAME default-frame conta.cd-moeda <> 0 THEN DO:
        ENABLE conta.perc-ir WITH FRAME default-frame.
    END.
    ELSE DO:
        DISABLE conta.perc-ir WITH FRAME default-frame.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.vl-limite
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.vl-limite C-Win
ON ENTRY OF conta.vl-limite IN FRAME DEFAULT-FRAME /* Limite */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.vl-limite C-Win
ON LEAVE OF conta.vl-limite IN FRAME DEFAULT-FRAME /* Limite */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.vl-saldo-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.vl-saldo-ini C-Win
ON ENTRY OF conta.vl-saldo-ini IN FRAME DEFAULT-FRAME /* Saldo Inicial */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.vl-saldo-ini C-Win
ON LEAVE OF conta.vl-saldo-ini IN FRAME DEFAULT-FRAME /* Saldo Inicial */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = ds-fav
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = conta.cd-fav-padrao}
{campos\cd-moeda.i}                

{func\calc.i conta.vl-saldo-ini}
{func\calc.i conta.vl-limite}

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
  RUN enable_UI.
  {version.i contas}
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
DEFINE VARIABLE iAgend AS INTEGER    NO-UNDO.

IF cAction = "ADD" THEN DO:
    ASSIGN conta.dt-saldo = TODAY - 1
           conta.vl-saldo = conta.vl-saldo-ini.
END.

IF conta.id-tipo = 3
AND NOT conta.dinheiro THEN DO:

    IF cAction = "ADD" THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Novo Cart∆o de CrÇdito (034)', INPUT 'Deseja agendar o pagamento da fatura ?', INPUT 'Se vocà confirmar ser† gerado um agendamento correspondente ao pagamento da fatura desse cart∆o de crÇdito.')"}
        IF RETURN-VALUE = "OK" THEN DO:
            FOR EACH tt-info:
                DELETE tt-info.
            END.
            CREATE tt-info.
            ASSIGN tt-info.campo = "Conta"
                   tt-info.tabela = "conta"
                   tt-info.campo-proc = "cd-conta"
                   tt-info.campo-desc = "ds-conta".
            CREATE tt-info.
            ASSIGN tt-info.campo = "Dia de Pagamento".
            CREATE tt-info.
            ASSIGN tt-info.campo = "Valor Aproximado".

            {func\run.i &Programa = "func\info.w (INPUT-OUTPUT TABLE tt-info)"}

            IF RETURN-VALUE = "OK" THEN DO:

                FIND FIRST tt-info
                    WHERE tt-info.campo = "Conta".
                IF tt-info.descricao = "" THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Conta Inv†lida (013)', INPUT 'N∆o foi informada conta v†lida!', INPUT 'N∆o foi informada uma conta v†lida no programa de Informaá‰es Adicionais para gerar o agrupamento.')"}
                    RETURN.
                END.
                ELSE DO:
                    FIND LAST agenda NO-LOCK NO-ERROR.
                    IF AVAIL agenda THEN
                        ASSIGN iAgend = agenda.cd-agenda + 1.
                    ELSE
                        ASSIGN iAgend = 1.

                    CREATE agenda.
                    ASSIGN agenda.cd-agenda     = iAgend
                           agenda.cd-conta      = INT(tt-info.valor)
                           agenda.id-tipo       = 3
                           agenda.cd-favorecido = conta.cd-fav-padrao
                           agenda.conta-transf  = conta.cd-conta
                           agenda.dt-fim        = DATE(12,31,9999).
                    FIND FIRST tt-info
                        WHERE tt-info.campo = "Dia de Pagamento".
                    CREATE prog-agenda.
                    ASSIGN prog-agenda.cd-agenda = iAgend
                           prog-agenda.id-tipo = 0
                           prog-agenda.valor = 1.
                    CREATE prog-agenda.
                    ASSIGN prog-agenda.cd-agenda = iAgend
                           prog-agenda.id-tipo = 1
                           prog-agenda.todos = YES.
                    CREATE prog-agenda.
                    ASSIGN prog-agenda.cd-agenda = iAgend
                           prog-agenda.id-tipo = 2
                           prog-agenda.valor = INT(tt-info.valor).
                    ASSIGN agenda.dt-ini = TODAY
                           agenda.dt-ultimo-pag = TODAY.

                    FIND FIRST tt-info
                        WHERE tt-info.campo = "Valor Aproximado".
                    CREATE agenda-valor.
                    ASSIGN agenda-valor.cd-agenda = agenda.cd-agenda
                           agenda-valor.dt-ini    = DATE(1,1,0001)
                           agenda-valor.dt-end    = DATE(12,31,9999)
                           agenda-valor.valor     = (-1) * DEC(tt-info.valor).
                END.

            END.
            ELSE DO:
                RETURN.
            END.

        END.
    END.

END.

IF conta.id-tipo = 2
AND conta.cd-moeda = 0 THEN DO:
    ASSIGN conta.perc-ir = 0.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\control_buttons.i}

IF lHabilita THEN DO:
    APPLY "VALUE-CHANGED" TO conta.id-tipo IN FRAME {&FRAME-NAME}.
    DISABLE btMov WITH FRAME {&FRAME-NAME}.
    IF CAN-FIND(FIRST mov-conta OF conta) THEN DO:
        DISABLE conta.cd-moeda WITH FRAME {&FRAME-NAME}.
    END.
END.
ELSE DO:
    ENABLE btMov WITH FRAME {&FRAME-NAME}.
    ASSIGN ds-fav:READ-ONLY = YES.
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
{func\cadastro\display.i}

IF NOT AVAIL conta THEN DO:

    ASSIGN conta.cd-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           conta.ds-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

END.

APPLY "LEAVE" TO conta.cd-fav-padrao IN FRAME {&FRAME-NAME}.

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
  DISPLAY ds-fav 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE conta THEN 
    DISPLAY conta.perc-ir conta.cd-conta conta.ds-conta conta.id-encerrada 
          conta.id-tipo conta.dinheiro conta.dia-fat conta.cd-fav-padrao 
          conta.vl-saldo-ini conta.vl-limite 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE conta.perc-ir conta.cd-conta conta.ds-conta btMov conta.id-encerrada 
         btGoTo conta.id-tipo conta.dinheiro conta.dia-fat conta.cd-fav-padrao 
         btFirst conta.cd-moeda conta.vl-saldo-ini btLast conta.vl-limite 
         btNext btPrev btAdd btDel btExit btUpdate btZoom RECT-2 RECT-3 RECT-4 
         RECT-5 RECT-6 
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
{func/cb-lista.i cd-moeda}

{func\initialize.i}

{func\cursor.i conta.cd-fav-padrao}

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

IF cObject = "ds-fav" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} ds-fav NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN conta.cd-fav-padrao:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
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

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-conta NO-LOCK
        WHERE bf-conta.cd-conta = INPUT FRAME {&FRAME-NAME} conta.cd-conta
        AND   ROWID(bf-conta) <> ROWID(conta) NO-ERROR.
    IF AVAIL bf-conta THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
    IF INPUT FRAME {&FRAME-NAME} conta.id-encerrada THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Deseja realmente criar a conta encerrada ?', INPUT 'A conta ser† criada mas n∆o poder† ser movimentada.')"}
        IF RETURN-VALUE <> "OK" THEN RETURN "NOK".
    END.
END.

IF cAction = "UPDATE" THEN DO:
    IF INPUT FRAME {&FRAME-NAME} conta.id-encerrada THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Deseja realmente encerrar a conta ?', INPUT 'N∆o ser† mais poss°vel movimentar a conta ap¢s o encerramento e ela n∆o ser† mais computada nos c†lculos patrimoniais.')"}
        IF RETURN-VALUE <> "OK" THEN RETURN "NOK".
    END.
END.

IF cAction = "ADD"
OR cAction = "UPDATE" THEN DO:

    /* Valida Chaves Extrangeiras */
    IF INPUT FRAME {&FRAME-NAME} conta.cd-fav-padrao <> 0 THEN DO:
        IF NOT CAN-FIND(FIRST favorecido
                    WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} conta.cd-fav-padrao) THEN DO:
            {func\valida.i &Mensagem  = "Favorecido n∆o encontrado!"
                           &Ajuda     = "N∆o foi encontrado o Favorecido Padr∆o informado."
                           &Campo     = conta.cd-fav-padrao}
        END.
    END.

END.

IF cAction = "DEL" THEN DO:

    /* Pesquisa Relacionamentos */
    IF CAN-FIND(FIRST alerta-exc OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Alertas Espec°ficos!"
                       &Ajuda     = "Existem usu†rios com alertas espec°ficos referenciando essa conta e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST poup-conta OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Planejamento de Poupanáa!"
                       &Ajuda     = "Existe um planejamento de poupanáa para essa conta e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST poupanca OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Planejamento!"
                       &Ajuda     = "Existe um planejamento de poupanáa para essa conta e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST parc-nota-fiscal OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Parcela de Nota Fiscal!"
                       &Ajuda     = "Existe uma parcela de nota fiscal associada a essa conta e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST nota-fiscal-imp OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Imposto de Nota Fiscal!"
                       &Ajuda     = "Existem impostos de nota fiscal associados a essa conta e ela n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST mov-conta OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Movimentaá∆o!"
                       &Ajuda     = "Essa conta possui movimentaá∆o e n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST mov-bens OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Movimentaá∆o de Bens!"
                       &Ajuda     = "Essa conta possui movimentaá∆o de bens e n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST forma-pagto OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta associada a Forma de Pagamento!"
                       &Ajuda     = "Essa conta est† associada a uma forma de pagamento e n∆o pode ser eliminada."}
    END.
    IF CAN-FIND(FIRST agenda OF conta) THEN DO:
        {func\valida.i &Mensagem  = "Conta com Agendamentos!"
                       &Ajuda     = "Essa conta possui movimentos agendados e n∆o pode ser eliminada."}
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

