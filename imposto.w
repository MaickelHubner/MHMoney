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
&GLOBAL-DEFINE Table        imposto
&GLOBAL-DEFINE KeyFields    imposto.cod-imposto
&GLOBAL-DEFINE FrameFields  imposto.ds-imposto imposto.tipo ~
                            imposto.dt-val-ini imposto.dt-val-fim ~
                            imposto.val-nf-min imposto.val-nf-max ~
                            imposto.cd-agenda imposto.pc-imposto ~
                            imposto.cod-categoria imposto.cd-sub ~
                            imposto.tipo-retencao

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
&Scoped-Define ENABLED-FIELDS imposto.cod-imposto imposto.pc-imposto ~
imposto.ds-imposto imposto.dt-val-ini imposto.dt-val-fim imposto.val-nf-min ~
imposto.val-nf-max imposto.tipo imposto.cd-agenda imposto.tipo-retencao ~
imposto.cod-categoria imposto.cd-sub 
&Scoped-define ENABLED-TABLES imposto
&Scoped-define FIRST-ENABLED-TABLE imposto
&Scoped-Define ENABLED-OBJECTS RECT-4 btGoTo RECT-5 btFirst btLast btNext ~
btPrev btAdd btDel btExit btUpdate btZoom 
&Scoped-Define DISPLAYED-FIELDS imposto.cod-imposto imposto.pc-imposto ~
imposto.ds-imposto imposto.dt-val-ini imposto.dt-val-fim imposto.val-nf-min ~
imposto.val-nf-max imposto.tipo imposto.cd-agenda imposto.tipo-retencao ~
imposto.cod-categoria imposto.cd-sub 
&Scoped-define DISPLAYED-TABLES imposto
&Scoped-define FIRST-DISPLAYED-TABLE imposto
&Scoped-Define DISPLAYED-OBJECTS cat subcat 

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

DEFINE VARIABLE cat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .79 NO-UNDO.

DEFINE VARIABLE subcat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 9.25.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btGoTo AT ROW 1.5 COL 48.43
     imposto.cod-imposto AT ROW 5 COL 24 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     imposto.pc-imposto AT ROW 5 COL 64 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     imposto.ds-imposto AT ROW 6 COL 24 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 50 BY .79
     imposto.dt-val-ini AT ROW 7 COL 24 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     imposto.dt-val-fim AT ROW 7 COL 64 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     imposto.val-nf-min AT ROW 8 COL 24 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     imposto.val-nf-max AT ROW 8 COL 64 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     imposto.tipo AT ROW 9 COL 24 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Retido",1,
                     "Pagamento Futuro",2
          DROP-DOWN-LIST
          SIZE 18 BY 1
     imposto.cd-agenda AT ROW 9 COL 64 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btFirst AT ROW 1.5 COL 3
     imposto.tipo-retencao AT ROW 10 COL 24 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Geral",0,
                     "Municipal",1,
                     "Fora do Munic°pio",2
          DROP-DOWN-LIST
          SIZE 50 BY 1
     imposto.cod-categoria AT ROW 11 COL 24 COLON-ALIGNED WIDGET-ID 46
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     cat AT ROW 11 COL 29 COLON-ALIGNED NO-LABEL WIDGET-ID 42 NO-TAB-STOP 
     imposto.cd-sub AT ROW 12 COL 24 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btLast AT ROW 1.5 COL 21.43
     subcat AT ROW 12 COL 29 COLON-ALIGNED NO-LABEL WIDGET-ID 48 NO-TAB-STOP 
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 13.5 COL 81.14
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 80
     btOK AT ROW 13.5 COL 75
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     RECT-4 AT ROW 4 COL 2
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 14.29
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
         HEIGHT             = 14.29
         WIDTH              = 86.72
         MAX-HEIGHT         = 20.13
         MAX-WIDTH          = 86.72
         VIRTUAL-HEIGHT     = 20.13
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
   FRAME-NAME                                                           */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN cat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       cat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN subcat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       subcat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

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
    {func\bt_add.i "cod-imposto"}
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


&Scoped-define SELF-NAME imposto.cd-agenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cd-agenda C-Win
ON ENTRY OF imposto.cd-agenda IN FRAME DEFAULT-FRAME /* Agendamento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cd-agenda C-Win
ON LEAVE OF imposto.cd-agenda IN FRAME DEFAULT-FRAME /* Agendamento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cd-sub C-Win
ON ENTRY OF imposto.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cd-sub C-Win
ON LEAVE OF imposto.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} imposto.cod-categoria"
                  &CampoProc = "ds-sub"
                  &Tela="subcat"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cd-sub C-Win
ON MOUSE-SELECT-DBLCLICK OF imposto.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
OR F5 OF {&Table}.cd-sub DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="imposto.cd-sub"
                 &Campo2="ds-sub"
                 &Tela2="subcat"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} imposto.cod-categoria"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cod-categoria C-Win
ON ENTRY OF imposto.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cod-categoria C-Win
ON LEAVE OF imposto.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoProc = "ds-categoria"
                  &Tela="cat"}    
                  
    APPLY "LEAVE" TO imposto.cd-sub IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cod-categoria C-Win
ON MOUSE-SELECT-DBLCLICK OF imposto.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
OR F5 OF {&Table}.cod-categoria DO:
    {func\zoom.i &Tabela="categoria"
                 &Campo1="cod-categoria"
                 &Tela1="imposto.cod-categoria"
                 &Campo2="ds-categoria"
                 &Tela2="cat"
                 &CampoFiltro1="id-tipo"
                 &ValorFiltro1="2"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.cod-imposto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cod-imposto C-Win
ON ENTRY OF imposto.cod-imposto IN FRAME DEFAULT-FRAME /* Imposto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.cod-imposto C-Win
ON LEAVE OF imposto.cod-imposto IN FRAME DEFAULT-FRAME /* Imposto */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.ds-imposto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.ds-imposto C-Win
ON ENTRY OF imposto.ds-imposto IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.ds-imposto C-Win
ON LEAVE OF imposto.ds-imposto IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.dt-val-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.dt-val-fim C-Win
ON ENTRY OF imposto.dt-val-fim IN FRAME DEFAULT-FRAME /* Validade Final */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.dt-val-fim C-Win
ON LEAVE OF imposto.dt-val-fim IN FRAME DEFAULT-FRAME /* Validade Final */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.dt-val-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.dt-val-ini C-Win
ON ENTRY OF imposto.dt-val-ini IN FRAME DEFAULT-FRAME /* Validade Inicial */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.dt-val-ini C-Win
ON LEAVE OF imposto.dt-val-ini IN FRAME DEFAULT-FRAME /* Validade Inicial */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.tipo C-Win
ON ENTRY OF imposto.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.tipo C-Win
ON LEAVE OF imposto.tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.val-nf-max
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.val-nf-max C-Win
ON ENTRY OF imposto.val-nf-max IN FRAME DEFAULT-FRAME /* Valor M†ximo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.val-nf-max C-Win
ON LEAVE OF imposto.val-nf-max IN FRAME DEFAULT-FRAME /* Valor M†ximo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME imposto.val-nf-min
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.val-nf-min C-Win
ON ENTRY OF imposto.val-nf-min IN FRAME DEFAULT-FRAME /* Valor M°nimo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL imposto.val-nf-min C-Win
ON LEAVE OF imposto.val-nf-min IN FRAME DEFAULT-FRAME /* Valor M°nimo */
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
                          &OBJETO = cat
                          &FOREACH = "categoria BY categoria.ds-categoria"
                          &CAMPO = categoria.ds-categoria
                          &ObjPai = imposto.cod-categoria}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = subcat
                          &FOREACH = "sub-cat WHERE (sub-cat.cod-categoria = INPUT FRAME {&Frame-name} imposto.cod-categoria) BY sub-cat.ds-sub"
                          &CAMPO = sub-cat.ds-sub
                          &ObjPai = imposto.cd-sub}
                              
{func\calendar.i imposto.dt-val-ini}
{func\calendar.i imposto.dt-val-fim}
{func\calc.i imposto.val-nf-min}
{func\calc.i imposto.val-nf-max}

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
  {version.i imposto}
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
{func\control_buttons.i}

IF lHabilita THEN DO:
END.
ELSE DO:
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

IF cAction = "ADD" THEN DO:
    ASSIGN imposto.dt-val-ini = TODAY
           imposto.dt-val-fim = DATE(12,31,9999)
           imposto.val-nf-max = 999999.99.
END.

{func\cadastro\display.i}

APPLY "LEAVE" TO imposto.cod-categoria.
APPLY "LEAVE" TO imposto.cd-sub.

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
  DISPLAY cat subcat 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE imposto THEN 
    DISPLAY imposto.cod-imposto imposto.pc-imposto imposto.ds-imposto 
          imposto.dt-val-ini imposto.dt-val-fim imposto.val-nf-min 
          imposto.val-nf-max imposto.tipo imposto.cd-agenda 
          imposto.tipo-retencao imposto.cod-categoria imposto.cd-sub 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-4 btGoTo RECT-5 imposto.cod-imposto imposto.pc-imposto 
         imposto.ds-imposto imposto.dt-val-ini imposto.dt-val-fim 
         imposto.val-nf-min imposto.val-nf-max imposto.tipo imposto.cd-agenda 
         btFirst imposto.tipo-retencao imposto.cod-categoria imposto.cd-sub 
         btLast btNext btPrev btAdd btDel btExit btUpdate btZoom 
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
{func\initialize.i}

{func\cursor.i imposto.cod-categoria}
{func\cursor.i imposto.cd-sub}

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

IF cObject = "cat" THEN DO:
    FIND FIRST categoria NO-LOCK
        WHERE categoria.ds-categoria = INPUT FRAME {&FRAME-NAME} cat NO-ERROR.
    IF AVAIL categoria THEN DO:
        ASSIGN imposto.cod-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(categoria.cod-categoria).
    END.
END.
IF cObject = "subcat" THEN DO:
    FIND FIRST sub-cat NO-LOCK
        WHERE sub-cat.ds-sub = INPUT FRAME {&FRAME-NAME} subcat NO-ERROR.
    IF AVAIL sub-cat THEN DO:
        ASSIGN imposto.cd-sub:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(sub-cat.cd-sub).
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
    FIND FIRST bf-imposto NO-LOCK
        WHERE bf-imposto.cod-imposto = INPUT FRAME {&FRAME-NAME} imposto.cod-imposto
        AND   ROWID(bf-imposto) <> ROWID(imposto) NO-ERROR.
    IF AVAIL bf-imposto THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "UPDATE" THEN DO:
END.

IF cAction = "ADD" OR cAction = "UPDATE" THEN DO:

    IF INPUT FRAME {&FRAME-NAME} imposto.dt-val-fim < INPUT FRAME {&FRAME-NAME} imposto.dt-val-ini THEN DO:
        {func\valida.i &Mensagem  = "Validade incorreta!"
                       &Ajuda     = "Data de validade final deve ser maior que a inicial."
                       &Campo     = imposto.dt-val-fim}
    END.

    IF INPUT FRAME {&FRAME-NAME} imposto.val-nf-max < INPUT FRAME {&FRAME-NAME} imposto.val-nf-min THEN DO:
        {func\valida.i &Mensagem  = "Valor incorreto!"
                       &Ajuda     = "Faixa final de valor deve ser maior que a inicial."
                       &Campo     = imposto.val-nf-max}
    END.

    IF INPUT FRAME {&FRAME-NAME} imposto.tipo = 1 /* Retido */ THEN DO:
        IF INPUT FRAME {&FRAME-NAME} imposto.cod-categoria = 0 THEN DO:
            {func\valida.i &Mensagem  = "Categoria inv†lida!"
                           &Ajuda     = "Vocà deve informar a Categoria de Despesa do Imposto."
                           &Campo     = imposto.cod-categoria}
        END.

        IF INPUT FRAME {&FRAME-NAME} imposto.cd-sub = 0 THEN DO:
            {func\valida.i &Mensagem  = "Sub-Categoria inv†lida!"
                           &Ajuda     = "Vocà deve informar a Sub-Categoria de Despesa do Imposto."
                           &Campo     = imposto.cd-sub}
        END.
    END.

END.

IF cAction = "DEL" THEN DO:

    IF CAN-FIND(FIRST nota-fiscal-imp OF imposto) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "O imposto j† foi utilizado em alguma Nota Fiscal."}
    END.
    IF CAN-FIND(FIRST mov-conta OF imposto) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "J† foi registrada movimentaá∆o para o imposto."}
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

