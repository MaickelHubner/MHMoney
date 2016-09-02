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
&GLOBAL-DEFINE Table        agenda
&GLOBAL-DEFINE KeyFields    agenda.cd-agenda
&GLOBAL-DEFINE FrameFields  agenda.cd-conta agenda.simulado ~
                            agenda.id-tipo agenda.calc-cpmf ~
                            agenda.conta-transf agenda.dt-ini ~
                            agenda.dt-fim agenda.dt-ultimo-pag ~
                            agenda.cd-favorecido agenda.cod-categoria ~
                            agenda.cd-sub agenda.prox-data-pag ~
                            agenda.usuar-resp ~
                            conta favor categoria sub conta-tran

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

/* Buffers */

DEFINE BUFFER bf-conta FOR conta.

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
&Scoped-Define ENABLED-FIELDS agenda.usuar-resp agenda.cd-agenda ~
agenda.simulado agenda.calc-cpmf agenda.cd-conta agenda.id-tipo ~
agenda.cd-favorecido agenda.cod-categoria agenda.cd-sub agenda.conta-transf ~
agenda.dt-ini agenda.dt-fim agenda.dt-ultimo-pag agenda.prox-data-pag 
&Scoped-define ENABLED-TABLES agenda
&Scoped-define FIRST-ENABLED-TABLE agenda
&Scoped-Define ENABLED-OBJECTS btMov btProg btVal btGoTo btFirst btLast ~
btNext btPrev btAdd btDel btExit btUpdate btZoom RECT-4 RECT-5 RECT-7 ~
RECT-8 
&Scoped-Define DISPLAYED-FIELDS agenda.usuar-resp agenda.cd-agenda ~
agenda.simulado agenda.calc-cpmf agenda.cd-conta agenda.id-tipo ~
agenda.cd-favorecido agenda.cod-categoria agenda.cd-sub agenda.conta-transf ~
agenda.dt-ini agenda.dt-fim agenda.dt-ultimo-pag agenda.prox-data-pag 
&Scoped-define DISPLAYED-TABLES agenda
&Scoped-define FIRST-DISPLAYED-TABLE agenda
&Scoped-Define DISPLAYED-OBJECTS conta favor categoria sub conta-tran 

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
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentaá∆o do Agendamento".

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

DEFINE BUTTON btProg 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Programaá∆o do Agendamento".

DEFINE BUTTON btUpdate 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btVal 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Valores do Agendamento".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE VARIABLE categoria AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .79 NO-UNDO.

DEFINE VARIABLE conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY .79 NO-UNDO.

DEFINE VARIABLE conta-tran AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY .79 NO-UNDO.

DEFINE VARIABLE favor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .79 NO-UNDO.

DEFINE VARIABLE sub AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 3.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 3.5.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 4.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     agenda.usuar-resp AT ROW 15 COL 28 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Item 1" 
          DROP-DOWN-LIST
          SIZE 19 BY 1
     btMov AT ROW 16.5 COL 14.14
     agenda.cd-agenda AT ROW 4.5 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btProg AT ROW 16.5 COL 8.14
     agenda.simulado AT ROW 4.5 COL 40
          VIEW-AS TOGGLE-BOX
          SIZE 10 BY .83
     btVal AT ROW 16.5 COL 2
     agenda.calc-cpmf AT ROW 4.5 COL 55
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY .83
     agenda.cd-conta AT ROW 5.5 COL 28 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btGoTo AT ROW 1.5 COL 48.43
     conta AT ROW 5.5 COL 32.29 COLON-ALIGNED NO-LABEL
     btFirst AT ROW 1.5 COL 3
     agenda.id-tipo AT ROW 6.5 COL 28 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 7
          LIST-ITEM-PAIRS "",0
          DROP-DOWN-LIST
          SIZE 38.29 BY 1
     agenda.cd-favorecido AT ROW 8.25 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     favor AT ROW 8.25 COL 33.29 COLON-ALIGNED NO-LABEL
     agenda.cod-categoria AT ROW 9.25 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     categoria AT ROW 9.25 COL 33.29 COLON-ALIGNED NO-LABEL
     btPrev AT ROW 1.5 COL 9.14
     agenda.cd-sub AT ROW 10.25 COL 28 COLON-ALIGNED
          LABEL "Sub-Categoria"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     sub AT ROW 10.25 COL 33.29 COLON-ALIGNED NO-LABEL
     agenda.conta-transf AT ROW 12 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     conta-tran AT ROW 12 COL 32.29 COLON-ALIGNED NO-LABEL
     btAdd AT ROW 1.5 COL 30
     agenda.dt-ini AT ROW 13 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btCancel AT ROW 16.5 COL 81.14
     agenda.dt-fim AT ROW 14 COL 28 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     agenda.dt-ultimo-pag AT ROW 13 COL 56.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     agenda.prox-data-pag AT ROW 14 COL 56.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 16.5 COL 75
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-7 AT ROW 8 COL 2
     RECT-8 AT ROW 11.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 17.29
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
         TITLE              = "Template Padr∆o de Cadastro"
         HEIGHT             = 17.29
         WIDTH              = 86.72
         MAX-HEIGHT         = 28.71
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 28.71
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
/* SETTINGS FOR FILL-IN categoria IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN agenda.cd-conta IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN agenda.cd-sub IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN conta-tran IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN favor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN sub IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Cadastro */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Cadastro */
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
    {func\bt_add.i "cd-agenda"}
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
ON CHOOSE OF btMov IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
  
    RUN som.p(INPUT "music\click.wav").

    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
  
    SESSION:SET-WAIT-STATE("GENERAL").
    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "consmov.txt").
    FOR EACH mov-conta 
        WHERE mov-conta.cd-agenda = agenda.cd-agenda NO-LOCK:
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


&Scoped-define SELF-NAME btProg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btProg C-Win
ON CHOOSE OF btProg IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "programa.w (input rowid(agenda))"}

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


&Scoped-define SELF-NAME btVal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btVal C-Win
ON CHOOSE OF btVal IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").
    ASSIGN r-agenda = ROWID(agenda).
    {func\run.i &Programa = "valagend.w"}


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


&Scoped-define SELF-NAME categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL categoria C-Win
ON ENTRY OF categoria IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.cd-agenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-agenda C-Win
ON ENTRY OF agenda.cd-agenda IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-agenda C-Win
ON LEAVE OF agenda.cd-agenda IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-conta C-Win
ON ENTRY OF agenda.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-conta C-Win
ON LEAVE OF agenda.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoProc = "ds-conta"
                  &Tela="conta"}
    FIND FIRST conta NO-LOCK
        WHERE conta.cd-conta = INPUT FRAME {&FRAME-NAME} agenda.cd-conta NO-ERROR.
    RUN listaTipo IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-conta C-Win
ON MOUSE-SELECT-DBLCLICK OF agenda.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF {&Table}.cd-conta DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="agenda.cd-conta"
                 &Campo2="ds-conta"
                 &Tela2="conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-favorecido C-Win
ON ENTRY OF agenda.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-favorecido C-Win
ON LEAVE OF agenda.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="favor"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF agenda.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="agenda.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="favor"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-sub C-Win
ON ENTRY OF agenda.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-sub C-Win
ON LEAVE OF agenda.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} agenda.cod-categoria"
                  &CampoProc = "ds-sub"
                  &Tela="sub"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cd-sub C-Win
ON MOUSE-SELECT-DBLCLICK OF agenda.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
OR F5 OF {&Table}.cd-sub DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="agenda.cd-sub"
                 &Campo2="ds-sub"
                 &Tela2="sub"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} agenda.cod-categoria"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cod-categoria C-Win
ON ENTRY OF agenda.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cod-categoria C-Win
ON LEAVE OF agenda.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoProc = "ds-categoria"
                  &Tela="categoria"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.cod-categoria C-Win
ON MOUSE-SELECT-DBLCLICK OF agenda.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
OR F5 OF {&Table}.cod-categoria DO:
    {func\zoom.i &Tabela="categoria"
                 &Campo1="cod-categoria"
                 &Tela1="agenda.cod-categoria"
                 &Campo2="ds-categoria"
                 &Tela2="categoria"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta C-Win
ON ENTRY OF conta IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta-tran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta-tran C-Win
ON ENTRY OF conta-tran IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.conta-transf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.conta-transf C-Win
ON ENTRY OF agenda.conta-transf IN FRAME DEFAULT-FRAME /* Conta Transferància */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.conta-transf C-Win
ON LEAVE OF agenda.conta-transf IN FRAME DEFAULT-FRAME /* Conta Transferància */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela="conta-transf"
                  &CampoProc = "ds-conta"
                  &Tela="conta-tran"}      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.conta-transf C-Win
ON MOUSE-SELECT-DBLCLICK OF agenda.conta-transf IN FRAME DEFAULT-FRAME /* Conta Transferància */
OR F5 OF {&Table}.conta-transf DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="agenda.conta-transf"
                 &Campo2="ds-conta"
                 &Tela2="conta-tran"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.dt-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.dt-fim C-Win
ON ENTRY OF agenda.dt-fim IN FRAME DEFAULT-FRAME /* Data Fim */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.dt-fim C-Win
ON LEAVE OF agenda.dt-fim IN FRAME DEFAULT-FRAME /* Data Fim */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.dt-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.dt-ini C-Win
ON ENTRY OF agenda.dt-ini IN FRAME DEFAULT-FRAME /* Data In°cio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.dt-ini C-Win
ON LEAVE OF agenda.dt-ini IN FRAME DEFAULT-FRAME /* Data In°cio */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.dt-ultimo-pag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.dt-ultimo-pag C-Win
ON ENTRY OF agenda.dt-ultimo-pag IN FRAME DEFAULT-FRAME /* Èltimo Pagamento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.dt-ultimo-pag C-Win
ON LEAVE OF agenda.dt-ultimo-pag IN FRAME DEFAULT-FRAME /* Èltimo Pagamento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favor C-Win
ON ENTRY OF favor IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.id-tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.id-tipo C-Win
ON ENTRY OF agenda.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.id-tipo C-Win
ON LEAVE OF agenda.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.id-tipo C-Win
ON VALUE-CHANGED OF agenda.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:

    IF INPUT FRAME {&FRAME-NAME} agenda.id-tipo = 3  THEN DO:
        ENABLE agenda.conta-transf
               conta-tran WITH FRAME {&FRAME-NAME}.
        DISABLE agenda.cod-categoria
                categoria
                agenda.cd-sub
                sub WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE agenda.conta-transf
                conta-tran WITH FRAME {&FRAME-NAME}.
        ENABLE agenda.cod-categoria
               categoria
               agenda.cd-sub
               sub WITH FRAME {&FRAME-NAME}.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME agenda.prox-data-pag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.prox-data-pag C-Win
ON ENTRY OF agenda.prox-data-pag IN FRAME DEFAULT-FRAME /* Pr¢ximo Pagamento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL agenda.prox-data-pag C-Win
ON LEAVE OF agenda.prox-data-pag IN FRAME DEFAULT-FRAME /* Pr¢ximo Pagamento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub C-Win
ON ENTRY OF sub IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

{func\calendar.i agenda.dt-ini}
{func\calendar.i agenda.dt-fim}
{func\calendar.i agenda.dt-ultimo-pag}

{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = favor
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = agenda.cd-favorecido}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = categoria
                          &FOREACH = "categoria BY categoria.ds-categoria"
                          &CAMPO = categoria.ds-categoria
                          &ObjPai = agenda.cod-categoria}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = sub
                          &FOREACH = "sub-cat WHERE (sub-cat.cod-categoria = INPUT FRAME {&Frame-name} agenda.cod-categoria) BY sub-cat.ds-sub"
                          &CAMPO = sub-cat.ds-sub
                          &ObjPai = agenda.cd-sub}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = conta
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = agenda.cd-conta}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = conta-tran
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = agenda.conta-transf}
                              
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
  {version.i agend}
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

    /* Guarda o campo respons†vel */
    ASSIGN agenda.usuar-resp = (IF INPUT FRAME {&FRAME-NAME} agenda.usuar-resp = "Todos" THEN "" ELSE INPUT FRAME {&FRAME-NAME} agenda.usuar-resp).

    RETURN "OK".

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
    APPLY "VALUE-CHANGED" TO agenda.id-tipo IN FRAME {&FRAME-NAME}.
    IF cAction = "ADD" THEN DO:
        DISABLE agenda.dt-ultimo-pag WITH FRAME {&FRAME-NAME}.
    END.
    DISABLE btVal
            btProg WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ENABLE btVal
           btProg WITH FRAME {&FRAME-NAME}.
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
FIND FIRST conta OF agenda NO-LOCK NO-ERROR.
RUN listaTipo IN THIS-PROCEDURE.

IF cAction = "ADD" THEN DO:
    ASSIGN agenda.dt-fim = DATE(12,31,9999).
    DISABLE agenda.dt-ultimo-pag.
END.

{func\cadastro\display.i}

IF agenda.usuar-resp = "" THEN
    ASSIGN agenda.usuar-resp:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Todos".
ELSE
    DISP agenda.usuar-resp WITH FRAME {&FRAME-NAME}.

APPLY "LEAVE" TO agenda.cd-conta IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO agenda.cd-favorecido IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO agenda.cod-categoria IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO agenda.cd-sub IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO agenda.conta-transf IN FRAME {&FRAME-NAME}.

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
  DISPLAY conta favor categoria sub conta-tran 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE agenda THEN 
    DISPLAY agenda.usuar-resp agenda.cd-agenda agenda.simulado agenda.calc-cpmf 
          agenda.cd-conta agenda.id-tipo agenda.cd-favorecido 
          agenda.cod-categoria agenda.cd-sub agenda.conta-transf agenda.dt-ini 
          agenda.dt-fim agenda.dt-ultimo-pag agenda.prox-data-pag 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE agenda.usuar-resp btMov agenda.cd-agenda btProg agenda.simulado btVal 
         agenda.calc-cpmf agenda.cd-conta btGoTo btFirst agenda.id-tipo 
         agenda.cd-favorecido agenda.cod-categoria btLast btNext btPrev 
         agenda.cd-sub agenda.conta-transf btAdd agenda.dt-ini agenda.dt-fim 
         agenda.dt-ultimo-pag agenda.prox-data-pag btDel btExit btUpdate btZoom 
         RECT-4 RECT-5 RECT-7 RECT-8 
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
ASSIGN agenda.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = "Todos".
FOR EACH usuario NO-LOCK:
    ASSIGN agenda.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = agenda.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} + "," + usuario.nome.
END.

{func\initialize.i}

{func\cursor.i agenda.cd-favorecido}
{func\cursor.i agenda.cod-categoria}
{func\cursor.i agenda.cd-sub}
{func\cursor.i agenda.cd-conta}
{func\cursor.i agenda.conta-transf}

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

IF cObject = "favor" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} favor NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN agenda.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.
IF cObject = "categoria" THEN DO:
    FIND FIRST categoria NO-LOCK
        WHERE categoria.ds-categoria = INPUT FRAME {&FRAME-NAME} categoria NO-ERROR.
    IF AVAIL categoria THEN DO:
        ASSIGN agenda.cod-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(categoria.cod-categoria).
    END.
END.
IF cObject = "sub" THEN DO:
    FIND FIRST sub-cat NO-LOCK
        WHERE sub-cat.ds-sub = INPUT FRAME {&FRAME-NAME} sub NO-ERROR.
    IF AVAIL sub-cat THEN DO:
        ASSIGN agenda.cd-sub:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(sub-cat.cd-sub).
    END.
END.
IF cObject = "conta" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} conta NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN agenda.cd-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.
IF cObject = "conta-tran" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} conta-tran NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN agenda.conta-transf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE listaTipo C-Win 
PROCEDURE listaTipo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF AVAIL conta THEN DO:
    IF conta.id-tipo = 1 THEN DO:
        ASSIGN agenda.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Cheque,4,Dep¢sito,1,Pagamento,5,Saque em Dinheiro,6,Transferància,3".
    END.
    IF conta.id-tipo = 2 THEN DO:
        ASSIGN agenda.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Dep¢sito,1,Saque em Dinheiro,6,Transferància,3".
    END.
    IF conta.id-tipo = 3 THEN DO:
        IF NOT conta.dinheiro THEN
            ASSIGN agenda.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Transferància,3,DÇbito,7,CrÇdito,2".
        ELSE
            ASSIGN agenda.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Transferància,3,Gasto,7,Recebimento,2".
    END.
END.
ELSE DO:
    ASSIGN agenda.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = ",0".
END.

IF AVAIL agenda THEN DO:
    IF LOOKUP(STRING(agenda.id-tipo),agenda.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME}) <> 0 THEN
        DISPLAY agenda.id-tipo WITH FRAME {&FRAME-NAME}.
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
    FIND FIRST bf-agenda NO-LOCK
        WHERE bf-agenda.cd-agenda = INPUT FRAME {&FRAME-NAME} agenda.cd-agenda
        AND   ROWID(bf-agenda) <> ROWID(agenda) NO-ERROR.
    IF AVAIL bf-agenda THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.

    IF NOT CAN-FIND(FIRST agenda-valor
                    WHERE agenda-valor.cd-agenda = INPUT FRAME {&FRAME-NAME} agenda.cd-agenda) THEN DO:

        CREATE agenda-valor.
        ASSIGN agenda-valor.cd-agenda = INPUT FRAME {&FRAME-NAME} agenda.cd-agenda
               agenda-valor.dt-ini = DATE(1,1,0001)
               agenda-valor.dt-end = DATE(12,31,9999)
               agenda-valor.valor = 0.               

    END.

    ASSIGN agenda.dt-ultimo-pag:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(TODAY,"99/99/9999").

END.

IF cAction = "ADD"
OR cAction = "UPDATE" THEN DO:
    /* Valida Chaves Extrangeiras */
    IF NOT CAN-FIND(FIRST favorecido
                WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} agenda.cd-favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido n∆o encontrado!"
                       &Ajuda     = "N∆o foi encontrado o Favorecido informado."
                       &Campo     = agenda.cd-favorecido}
    END.

    IF INPUT FRAME {&FRAME-NAME} agenda.id-tipo <> 3
    AND INPUT FRAME {&FRAME-NAME} agenda.id-tipo <> 0 THEN DO:

        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = INPUT FRAME {&FRAME-NAME} agenda.cod-categoria NO-ERROR.
        IF NOT AVAIL categoria THEN DO:
            {func\valida.i &Mensagem  = "Categoria n∆o encontrada!"
                           &Ajuda     = "N∆o foi encontrada a categoria informada."
                           &Campo     = agenda.cod-categoria}
        END.
        IF NOT CAN-FIND(FIRST sub-cat
                    WHERE sub-cat.cd-sub = INPUT FRAME {&FRAME-NAME} agenda.cd-sub
                    AND   sub-cat.cod-categoria = INPUT FRAME {&FRAME-NAME} agenda.cod-categoria) THEN DO:
            {func\valida.i &Mensagem  = "Sub-Categoria n∆o encontrada!"
                           &Ajuda     = "N∆o foi encontrada a sub-categoria informada."
                           &Campo     = agenda.cd-sub}
        END.

    END.

    CASE INPUT FRAME {&FRAME-NAME} agenda.id-tipo:
        WHEN 4 OR 
        WHEN 5 OR
        WHEN 6 OR
        WHEN 7 THEN DO:
            IF categoria.id-tipo = 1 THEN DO:
                {func\valida.i &Mensagem  = "Categoria inv†lida!"
                               &Ajuda     = "Foi informada uma categoria de receita para um tipo de movimento de despesa."
                               &Campo     = agenda.cod-categoria}
            END.
        END.
        WHEN 1 OR 
        WHEN 2 THEN DO:
            IF categoria.id-tipo = 2 THEN DO:
                {func\valida.i &Mensagem  = "Categoria inv†lida!"
                               &Ajuda     = "Foi informada uma categoria de despesa para um tipo de movimento de receita."
                               &Campo     = agenda.cod-categoria}
            END.
        END.
    END CASE.

    IF INPUT FRAME {&FRAME-NAME} agenda.id-tipo = 3 THEN DO:
        FIND FIRST bf-conta NO-LOCK
            WHERE bf-conta.cd-conta = INPUT FRAME {&FRAME-NAME} agenda.conta-transf NO-ERROR.
        IF NOT AVAIL bf-conta THEN DO:
            {func\valida.i &Mensagem  = "Conta inv†lida!"
                           &Ajuda     = "A conta de transferància informada n∆o existe."
                           &Campo     = agenda.conta-transf}
        END.
    END.

END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST nota-fiscal-imp OF agenda) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse agendamento est† associado a impostos em notas fiscais e por este motivo n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST mov-conta OF agenda) THEN DO:
        {func\valida.i &Mensagem  = "Existem movimentos relacionados a este agendamento!"
                       &Ajuda     = "Esse agendamento j† possui pagamentos e por este motivo n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST imposto OF agenda) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "Esse agendamento est† associado a impostos e por este motivo n∆o pode ser eliminado."}
    END.

    FOR EACH agenda-valor EXCLUSIVE-LOCK
        WHERE agenda-valor.cd-agenda = INPUT FRAME {&FRAME-NAME} agenda.cd-agenda:
        DELETE agenda-valor.
    END.
    FOR EACH prog-agenda EXCLUSIVE-LOCK
        WHERE prog-agenda.cd-agenda = INPUT FRAME {&FRAME-NAME} agenda.cd-agenda:
        DELETE prog-agenda.
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

