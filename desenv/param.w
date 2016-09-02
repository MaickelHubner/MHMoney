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

&GLOBAL-DEFINE FrameFields param-mn.caminho-ie param-mn.sincroniza param-mn.maquina-local ~
                           param-mn.lote-imp param-mn.lote-exp param-mn.maquina-destino ~
                           param-mn.ofc-dir param-mn.prod-dir param-mn.pc-cpmf ~
                           param-mn.email-de param-mn.email-para ~
                           param-mn.serv-email param-mn.porta-email ~
                           param-mn.perfil param-mn.caminho-anexos ~
                           param-mn.conta-recibo param-mn.categoria-recibo ~
                           param-mn.sub-recibo param-mn.categoria-nf ~
                           param-mn.sub-nf param-mn.cidade param-mn.perc-impto-pad ~
                           param-mn.cd-favorecido param-mn.caminho-xml ~
                           param-mn.conta-desp-viag param-mn.fav-desp-viag ~
                           param-mn.imp-etiq param-mn.conta-desp-nreemb

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{func\definitions.i}

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS param-mn.sincroniza param-mn.maquina-local ~
param-mn.maquina-destino param-mn.lote-exp param-mn.lote-imp ~
param-mn.email-de param-mn.email-para param-mn.serv-email ~
param-mn.porta-email param-mn.caminho-ie param-mn.ofc-dir param-mn.prod-dir ~
param-mn.caminho-anexos param-mn.caminho-xml param-mn.imp-etiq ~
param-mn.conta-recibo param-mn.categoria-recibo param-mn.sub-recibo ~
param-mn.categoria-nf param-mn.sub-nf param-mn.cidade ~
param-mn.cd-favorecido param-mn.perc-impto-padrao param-mn.pc-cpmf ~
param-mn.conta-desp-viag param-mn.fav-desp-viag param-mn.conta-desp-nreemb 
&Scoped-define ENABLED-TABLES param-mn
&Scoped-define FIRST-ENABLED-TABLE param-mn
&Scoped-Define ENABLED-OBJECTS btCancel ds-conta cat subcat cat-nf ~
subcat-nf btSave ds-fav-prin ds-conta-desp ds-fav-desp ds-conta-DNR RECT-1 ~
RECT-8 RECT-11 RECT-13 RECT-14 
&Scoped-Define DISPLAYED-FIELDS param-mn.sincroniza param-mn.maquina-local ~
param-mn.maquina-destino param-mn.lote-exp param-mn.lote-imp ~
param-mn.email-de param-mn.email-para param-mn.serv-email ~
param-mn.porta-email param-mn.caminho-ie param-mn.ofc-dir param-mn.prod-dir ~
param-mn.caminho-anexos param-mn.caminho-xml param-mn.imp-etiq ~
param-mn.conta-recibo param-mn.categoria-recibo param-mn.sub-recibo ~
param-mn.categoria-nf param-mn.sub-nf param-mn.perfil param-mn.cidade ~
param-mn.cd-favorecido param-mn.perc-impto-padrao param-mn.pc-cpmf ~
param-mn.conta-desp-viag param-mn.fav-desp-viag param-mn.conta-desp-nreemb 
&Scoped-define DISPLAYED-TABLES param-mn
&Scoped-define FIRST-DISPLAYED-TABLE param-mn
&Scoped-Define DISPLAYED-OBJECTS ds-conta cat subcat cat-nf subcat-nf ~
ds-fav-prin ds-conta-desp ds-fav-desp ds-conta-DNR 

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

DEFINE BUTTON btSave 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Save" 
     SIZE 6.14 BY 1.79 TOOLTIP "Salvar".

DEFINE VARIABLE cat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE VARIABLE cat-nf AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE VARIABLE ds-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE VARIABLE ds-conta-desp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE VARIABLE ds-conta-DNR AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE VARIABLE ds-fav-desp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY .79 NO-UNDO.

DEFINE VARIABLE ds-fav-prin AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY .79 NO-UNDO.

DEFINE VARIABLE subcat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE VARIABLE subcat-nf AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 6.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 3.5.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 2.25.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 6.75.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 6.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 15 COL 150.14
     param-mn.sincroniza AT ROW 1.5 COL 5
          VIEW-AS TOGGLE-BOX
          SIZE 11 BY .83
     param-mn.maquina-local AT ROW 2.5 COL 24 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4.57 BY .79
     param-mn.maquina-destino AT ROW 2.5 COL 59 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4.57 BY .79
     param-mn.lote-exp AT ROW 3.5 COL 24 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9.14 BY .79
     param-mn.lote-imp AT ROW 3.5 COL 59 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9.14 BY .79
     param-mn.email-de AT ROW 4.5 COL 24 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 51 BY .79
     param-mn.email-para AT ROW 5.5 COL 24 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 51 BY .79
     ds-conta AT ROW 2 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 22 NO-TAB-STOP 
     param-mn.serv-email AT ROW 6.5 COL 24 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 38 BY .79
     param-mn.porta-email AT ROW 6.5 COL 68 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     param-mn.caminho-ie AT ROW 8.5 COL 7.14
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     param-mn.ofc-dir AT ROW 9.5 COL 6.86
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     param-mn.prod-dir AT ROW 10.5 COL 18 COLON-ALIGNED
          LABEL "Diret¢rio Produto"
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     cat AT ROW 3 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 18 NO-TAB-STOP 
     param-mn.caminho-anexos AT ROW 11.5 COL 5.43 WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     param-mn.caminho-xml AT ROW 12.5 COL 18 COLON-ALIGNED WIDGET-ID 54
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     param-mn.imp-etiq AT ROW 13.5 COL 9.14 WIDGET-ID 48
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     param-mn.conta-recibo AT ROW 2 COL 96 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     subcat AT ROW 4 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 20 NO-TAB-STOP 
     param-mn.categoria-recibo AT ROW 3 COL 96 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     param-mn.sub-recibo AT ROW 4 COL 96 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     param-mn.categoria-nf AT ROW 5.75 COL 96 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     cat-nf AT ROW 5.75 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 30 NO-TAB-STOP 
     param-mn.sub-nf AT ROW 6.75 COL 96 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     param-mn.perfil AT ROW 8.25 COL 96 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS COMBO-BOX INNER-LINES 2
          LIST-ITEM-PAIRS "Pessoal",1,
                     "Empresarial",2
          DROP-DOWN-LIST
          SIZE 16 BY 1
     param-mn.cidade AT ROW 8.25 COL 132.43 COLON-ALIGNED WIDGET-ID 34
          VIEW-AS FILL-IN 
          SIZE 20.57 BY .79
     param-mn.cd-favorecido AT ROW 9.25 COL 96 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     subcat-nf AT ROW 6.75 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 32 NO-TAB-STOP 
     param-mn.perc-impto-padrao AT ROW 10.25 COL 96 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 155.57 BY 15.88
         FONT 1.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     param-mn.pc-cpmf AT ROW 10.25 COL 144 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     param-mn.conta-desp-viag AT ROW 11.25 COL 96 COLON-ALIGNED WIDGET-ID 40
          LABEL "Conta Desp Viagem"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     param-mn.fav-desp-viag AT ROW 12.25 COL 96 COLON-ALIGNED WIDGET-ID 44
          LABEL "Fav Desp Viagem"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     param-mn.conta-desp-nreemb AT ROW 13.25 COL 96 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btSave AT ROW 15 COL 144
     ds-fav-prin AT ROW 9.25 COL 101 COLON-ALIGNED NO-LABEL WIDGET-ID 58 NO-TAB-STOP 
     ds-conta-desp AT ROW 11.25 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 42 NO-TAB-STOP 
     ds-fav-desp AT ROW 12.25 COL 101 COLON-ALIGNED NO-LABEL WIDGET-ID 46 NO-TAB-STOP 
     ds-conta-DNR AT ROW 13.25 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 52 NO-TAB-STOP 
     RECT-1 AT ROW 1.75 COL 3
     RECT-8 AT ROW 8 COL 3
     RECT-11 AT ROW 1.75 COL 80 WIDGET-ID 8
     RECT-13 AT ROW 5.5 COL 80 WIDGET-ID 24
     RECT-14 AT ROW 8 COL 80 WIDGET-ID 36
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 155.57 BY 15.88
         FONT 1.


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
         TITLE              = "ParÉmetros Locais"
         HEIGHT             = 15.88
         WIDTH              = 155.57
         MAX-HEIGHT         = 40.58
         MAX-WIDTH          = 182.86
         VIRTUAL-HEIGHT     = 40.58
         VIRTUAL-WIDTH      = 182.86
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
/* SETTINGS FOR FILL-IN param-mn.caminho-anexos IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN param-mn.caminho-ie IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
ASSIGN 
       cat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       cat-nf:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN param-mn.conta-desp-viag IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
ASSIGN 
       ds-conta:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ds-conta-desp:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ds-conta-DNR:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ds-fav-desp:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       ds-fav-prin:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN param-mn.fav-desp-viag IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN param-mn.imp-etiq IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN param-mn.ofc-dir IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR COMBO-BOX param-mn.perfil IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN param-mn.prod-dir IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
ASSIGN 
       param-mn.prod-dir:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       subcat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       subcat-nf:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _Query            is NOT OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* ParÉmetros Locais */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* ParÉmetros Locais */
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
    {func\bt_fechar.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSave C-Win
ON CHOOSE OF btSave IN FRAME DEFAULT-FRAME /* Save */
DO:
    DEFINE VARIABLE l-Erro AS LOGICAL    NO-UNDO INITIAL NO.

    RUN som.p(INPUT "music\click.wav").

    IF  INPUT FRAME default-frame param-mn.sincroniza AND
        INPUT FRAME default-frame param-mn.maquina-local = 0 THEN DO:
        {func\valida.i &Mensagem  = "M†quina Local Inv†lida!"
                       &Ajuda     = "M†quina local n∆o pode ser zero."
                       &Campo     = param-mn.maquina-local}
        ASSIGN l-Erro = YES.
    END.
    IF  INPUT FRAME default-frame param-mn.sincroniza AND
        (INPUT FRAME default-frame param-mn.maquina-local = INPUT FRAME default-frame param-mn.maquina-destino OR 
         INPUT FRAME default-frame param-mn.maquina-destino = 0) THEN DO:
        {func\valida.i &Mensagem  = "M†quina Destino Inv†lida!"
                       &Ajuda     = "M†quina destino n∆o pode ser zero nem igual Ö m†quina local."
                       &Campo     = param-mn.maquina-destino}
        ASSIGN l-Erro = YES.
    END.
    
    IF INPUT FRAME default-frame param-mn.categoria-recibo <> 0 THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = INPUT FRAME default-frame param-mn.categoria-recibo NO-ERROR.
        IF AVAIL categoria THEN DO:
            IF categoria.id-tipo <> 1 /* receita */ THEN DO:
                {func\valida.i &Mensagem  = "Categoria do Recibo inv†lida!"
                               &Ajuda     = "Vocà deve informar uma categoria do tipo Receita."
                               &Campo     = param-mn.categoria-recibo}
                ASSIGN l-Erro = YES.
            END.
        END.
    END.

    IF NOT l-Erro THEN DO:
        FIND CURRENT param-mn EXCLUSIVE-LOCK.
        ASSIGN INPUT FRAME default-frame {&FrameFields}.
        apply "CLOSE":U to this-procedure.
    END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.caminho-ie
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.caminho-ie C-Win
ON ENTRY OF param-mn.caminho-ie IN FRAME DEFAULT-FRAME /* Internet Explorer */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.caminho-ie C-Win
ON LEAVE OF param-mn.caminho-ie IN FRAME DEFAULT-FRAME /* Internet Explorer */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.categoria-nf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.categoria-nf C-Win
ON ENTRY OF param-mn.categoria-nf IN FRAME DEFAULT-FRAME /* Categoria Padr∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.categoria-nf C-Win
ON LEAVE OF param-mn.categoria-nf IN FRAME DEFAULT-FRAME /* Categoria Padr∆o */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoTela="categoria-nf"
                  &CampoProc = "ds-categoria"
                  &Tela="cat-nf"}    
                  
    APPLY "LEAVE" TO param-mn.sub-nf IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.categoria-nf C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.categoria-nf IN FRAME DEFAULT-FRAME /* Categoria Padr∆o */
OR F5 OF param-mn.categoria-nf DO:
    {func\zoom.i &Tabela="categoria"
                 &Campo1="cod-categoria"
                 &Tela1="param-mn.categoria-nf"
                 &Campo2="ds-categoria"
                 &Tela2="cat-nf"
                 &CampoFiltro1="id-tipo"
                 &ValorFiltro1="1"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.categoria-recibo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.categoria-recibo C-Win
ON ENTRY OF param-mn.categoria-recibo IN FRAME DEFAULT-FRAME /* Categoria Recibo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.categoria-recibo C-Win
ON LEAVE OF param-mn.categoria-recibo IN FRAME DEFAULT-FRAME /* Categoria Recibo */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoTela="categoria-recibo"
                  &CampoProc = "ds-categoria"
                  &Tela="cat"}    
                  
    APPLY "LEAVE" TO param-mn.sub-recibo IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.categoria-recibo C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.categoria-recibo IN FRAME DEFAULT-FRAME /* Categoria Recibo */
OR F5 OF param-mn.categoria-recibo DO:
    {func\zoom.i &Tabela="categoria"
                 &Campo1="cod-categoria"
                 &Tela1="param-mn.categoria-recibo"
                 &Campo2="ds-categoria"
                 &Tela2="cat"
                 &CampoFiltro1="id-tipo"
                 &ValorFiltro1="1"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.cd-favorecido C-Win
ON ENTRY OF param-mn.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido Principal */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.cd-favorecido C-Win
ON LEAVE OF param-mn.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido Principal */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela = "param-mn.cd-favorecido"
                  &CampoProc ="ds-favorecido"
                  &Tela="ds-fav-prin"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido Principal */
OR F5 OF param-mn.fav-desp-viag DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="param-mn.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="ds-fav-prin"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.conta-desp-nreemb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-desp-nreemb C-Win
ON ENTRY OF param-mn.conta-desp-nreemb IN FRAME DEFAULT-FRAME /* Conta Desp. N Reemb. */
DO:
    {func\set_entry.i} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-desp-nreemb C-Win
ON LEAVE OF param-mn.conta-desp-nreemb IN FRAME DEFAULT-FRAME /* Conta Desp. N Reemb. */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela = "conta-desp-nreemb"
                  &CampoProc ="ds-conta"
                  &Tela="ds-conta-DNR"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-desp-nreemb C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.conta-desp-nreemb IN FRAME DEFAULT-FRAME /* Conta Desp. N Reemb. */
OR F5 OF param-mn.conta-recibo DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="param-mn.conta-desp-nreemb"
                 &Campo2="ds-conta"
                 &Tela2="ds-conta-DNR"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.conta-desp-viag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-desp-viag C-Win
ON ENTRY OF param-mn.conta-desp-viag IN FRAME DEFAULT-FRAME /* Conta Desp Viagem */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-desp-viag C-Win
ON LEAVE OF param-mn.conta-desp-viag IN FRAME DEFAULT-FRAME /* Conta Desp Viagem */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela = "conta-desp-viag"
                  &CampoProc ="ds-conta"
                  &Tela="ds-conta-desp"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-desp-viag C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.conta-desp-viag IN FRAME DEFAULT-FRAME /* Conta Desp Viagem */
OR F5 OF param-mn.conta-desp-viag DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="param-mn.conta-desp-viag"
                 &Campo2="ds-conta"
                 &Tela2="ds-conta-desp"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.conta-recibo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-recibo C-Win
ON ENTRY OF param-mn.conta-recibo IN FRAME DEFAULT-FRAME /* Conta Recibo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-recibo C-Win
ON LEAVE OF param-mn.conta-recibo IN FRAME DEFAULT-FRAME /* Conta Recibo */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela = "conta-recibo"
                  &CampoProc ="ds-conta"
                  &Tela="ds-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.conta-recibo C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.conta-recibo IN FRAME DEFAULT-FRAME /* Conta Recibo */
OR F5 OF param-mn.conta-recibo DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="param-mn.conta-recibo"
                 &Campo2="ds-conta"
                 &Tela2="ds-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.email-de
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.email-de C-Win
ON ENTRY OF param-mn.email-de IN FRAME DEFAULT-FRAME /* E-mail Local */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.email-de C-Win
ON LEAVE OF param-mn.email-de IN FRAME DEFAULT-FRAME /* E-mail Local */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.email-para
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.email-para C-Win
ON ENTRY OF param-mn.email-para IN FRAME DEFAULT-FRAME /* E-mail Para */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.email-para C-Win
ON LEAVE OF param-mn.email-para IN FRAME DEFAULT-FRAME /* E-mail Para */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.fav-desp-viag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.fav-desp-viag C-Win
ON ENTRY OF param-mn.fav-desp-viag IN FRAME DEFAULT-FRAME /* Fav Desp Viagem */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.fav-desp-viag C-Win
ON LEAVE OF param-mn.fav-desp-viag IN FRAME DEFAULT-FRAME /* Fav Desp Viagem */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela = "fav-desp-viag"
                  &CampoProc ="ds-favorecido"
                  &Tela="ds-fav-desp"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.fav-desp-viag C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.fav-desp-viag IN FRAME DEFAULT-FRAME /* Fav Desp Viagem */
OR F5 OF param-mn.fav-desp-viag DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="param-mn.fav-desp-viag"
                 &Campo2="ds-favorecido"
                 &Tela2="ds-fav-desp"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.lote-exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.lote-exp C-Win
ON ENTRY OF param-mn.lote-exp IN FRAME DEFAULT-FRAME /* Èltimo Lote Exportado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.lote-exp C-Win
ON LEAVE OF param-mn.lote-exp IN FRAME DEFAULT-FRAME /* Èltimo Lote Exportado */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.lote-imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.lote-imp C-Win
ON ENTRY OF param-mn.lote-imp IN FRAME DEFAULT-FRAME /* Èltimo Lote Importado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.lote-imp C-Win
ON LEAVE OF param-mn.lote-imp IN FRAME DEFAULT-FRAME /* Èltimo Lote Importado */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.maquina-destino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.maquina-destino C-Win
ON ENTRY OF param-mn.maquina-destino IN FRAME DEFAULT-FRAME /* M†quina Destino */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.maquina-destino C-Win
ON LEAVE OF param-mn.maquina-destino IN FRAME DEFAULT-FRAME /* M†quina Destino */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.maquina-local
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.maquina-local C-Win
ON ENTRY OF param-mn.maquina-local IN FRAME DEFAULT-FRAME /* M†quina Local */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.maquina-local C-Win
ON LEAVE OF param-mn.maquina-local IN FRAME DEFAULT-FRAME /* M†quina Local */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.ofc-dir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.ofc-dir C-Win
ON ENTRY OF param-mn.ofc-dir IN FRAME DEFAULT-FRAME /* Diret¢rio de OFCs */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.ofc-dir C-Win
ON LEAVE OF param-mn.ofc-dir IN FRAME DEFAULT-FRAME /* Diret¢rio de OFCs */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.pc-cpmf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.pc-cpmf C-Win
ON ENTRY OF param-mn.pc-cpmf IN FRAME DEFAULT-FRAME /* Percentual de CPMF */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.pc-cpmf C-Win
ON LEAVE OF param-mn.pc-cpmf IN FRAME DEFAULT-FRAME /* Percentual de CPMF */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.perc-impto-padrao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.perc-impto-padrao C-Win
ON ENTRY OF param-mn.perc-impto-padrao IN FRAME DEFAULT-FRAME /* % Imposto Padr∆o */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.perc-impto-padrao C-Win
ON LEAVE OF param-mn.perc-impto-padrao IN FRAME DEFAULT-FRAME /* % Imposto Padr∆o */
DO:
    {func\set_leave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.porta-email
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.porta-email C-Win
ON ENTRY OF param-mn.porta-email IN FRAME DEFAULT-FRAME /* Porta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.porta-email C-Win
ON LEAVE OF param-mn.porta-email IN FRAME DEFAULT-FRAME /* Porta */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.prod-dir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.prod-dir C-Win
ON ENTRY OF param-mn.prod-dir IN FRAME DEFAULT-FRAME /* Diret¢rio Produto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.prod-dir C-Win
ON LEAVE OF param-mn.prod-dir IN FRAME DEFAULT-FRAME /* Diret¢rio Produto */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.serv-email
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.serv-email C-Win
ON ENTRY OF param-mn.serv-email IN FRAME DEFAULT-FRAME /* Servidor E-mail */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.serv-email C-Win
ON LEAVE OF param-mn.serv-email IN FRAME DEFAULT-FRAME /* Servidor E-mail */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.sincroniza
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sincroniza C-Win
ON VALUE-CHANGED OF param-mn.sincroniza IN FRAME DEFAULT-FRAME /* Sincroniza */
DO:
  
    IF INPUT FRAME default-frame param-mn.sincroniza THEN DO:
        ENABLE param-mn.maquina-local
               param-mn.maquina-destino
               param-mn.lote-imp
               param-mn.lote-exp WITH FRAME default-frame.
    END.
    ELSE DO:
        DISABLE param-mn.maquina-local
                param-mn.maquina-destino
                param-mn.lote-imp
                param-mn.lote-exp WITH FRAME default-frame.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.sub-nf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sub-nf C-Win
ON ENTRY OF param-mn.sub-nf IN FRAME DEFAULT-FRAME /* Sub-Categoria Padr∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sub-nf C-Win
ON LEAVE OF param-mn.sub-nf IN FRAME DEFAULT-FRAME /* Sub-Categoria Padr∆o */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoTela="sub-nf"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} param-mn.categoria-nf"
                  &CampoProc = "ds-sub"
                  &Tela="subcat-nf"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sub-nf C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.sub-nf IN FRAME DEFAULT-FRAME /* Sub-Categoria Padr∆o */
OR F5 OF param-mn.sub-nf DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="param-mn.sub-nf"
                 &Campo2="ds-sub"
                 &Tela2="subcat-nf"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} param-mn.categoria-nf"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME param-mn.sub-recibo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sub-recibo C-Win
ON ENTRY OF param-mn.sub-recibo IN FRAME DEFAULT-FRAME /* Sub-Categoria Recibo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sub-recibo C-Win
ON LEAVE OF param-mn.sub-recibo IN FRAME DEFAULT-FRAME /* Sub-Categoria Recibo */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoTela="sub-recibo"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} param-mn.categoria-recibo"
                  &CampoProc = "ds-sub"
                  &Tela="subcat"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL param-mn.sub-recibo C-Win
ON MOUSE-SELECT-DBLCLICK OF param-mn.sub-recibo IN FRAME DEFAULT-FRAME /* Sub-Categoria Recibo */
OR F5 OF param-mn.sub-recibo DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="param-mn.sub-recibo"
                 &Campo2="ds-sub"
                 &Tela2="subcat"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} param-mn.categoria-recibo"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = cat
                          &FOREACH = "categoria BY categoria.ds-categoria"
                          &CAMPO = categoria.ds-categoria
                          &ObjPai = param-mn.categoria-recibo}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = subcat
                          &FOREACH = "sub-cat WHERE (sub-cat.cod-categoria = INPUT FRAME {&Frame-name} param-mn.categoria-recibo) BY sub-cat.ds-sub"
                          &CAMPO = sub-cat.ds-sub
                          &ObjPai = param-mn.sub-recibo}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = ds-conta
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = param-mn.conta-recibo}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = cat-nf
                          &FOREACH = "categoria BY categoria.ds-categoria"
                          &CAMPO = categoria.ds-categoria
                          &ObjPai = param-mn.categoria-nf}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = subcat-nf
                          &FOREACH = "sub-cat WHERE (sub-cat.cod-categoria = INPUT FRAME {&Frame-name} param-mn.categoria-nf) BY sub-cat.ds-sub"
                          &CAMPO = sub-cat.ds-sub
                          &ObjPai = param-mn.sub-nf}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = ds-conta-desp
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = param-mn.conta-desp-viag}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = ds-fav-desp
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = param-mn.fav-desp-viag}                          

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
  {version.i param}
  FIND FIRST param-mn NO-LOCK NO-ERROR.
  IF NOT AVAIL param-mn THEN
      CREATE param-mn.
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY ds-conta cat subcat cat-nf subcat-nf ds-fav-prin ds-conta-desp 
          ds-fav-desp ds-conta-DNR 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE param-mn THEN 
    DISPLAY param-mn.sincroniza param-mn.maquina-local param-mn.maquina-destino 
          param-mn.lote-exp param-mn.lote-imp param-mn.email-de 
          param-mn.email-para param-mn.serv-email param-mn.porta-email 
          param-mn.caminho-ie param-mn.ofc-dir param-mn.prod-dir 
          param-mn.caminho-anexos param-mn.caminho-xml param-mn.imp-etiq 
          param-mn.conta-recibo param-mn.categoria-recibo param-mn.sub-recibo 
          param-mn.categoria-nf param-mn.sub-nf param-mn.perfil param-mn.cidade 
          param-mn.cd-favorecido param-mn.perc-impto-padrao param-mn.pc-cpmf 
          param-mn.conta-desp-viag param-mn.fav-desp-viag 
          param-mn.conta-desp-nreemb 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel param-mn.sincroniza param-mn.maquina-local 
         param-mn.maquina-destino param-mn.lote-exp param-mn.lote-imp 
         param-mn.email-de param-mn.email-para ds-conta param-mn.serv-email 
         param-mn.porta-email param-mn.caminho-ie param-mn.ofc-dir 
         param-mn.prod-dir cat param-mn.caminho-anexos param-mn.caminho-xml 
         param-mn.imp-etiq param-mn.conta-recibo subcat 
         param-mn.categoria-recibo param-mn.sub-recibo param-mn.categoria-nf 
         cat-nf param-mn.sub-nf param-mn.cidade param-mn.cd-favorecido 
         subcat-nf param-mn.perc-impto-padrao param-mn.pc-cpmf 
         param-mn.conta-desp-viag param-mn.fav-desp-viag 
         param-mn.conta-desp-nreemb btSave ds-fav-prin ds-conta-desp 
         ds-fav-desp ds-conta-DNR RECT-1 RECT-8 RECT-11 RECT-13 RECT-14 
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

{func\cursor.i param-mn.categoria-recibo 1 "IN FRAME {&FRAME-NAME}"}
{func\cursor.i param-mn.sub-recibo}
{func\cursor.i param-mn.conta-recibo}
{func\cursor.i param-mn.categoria-nf}
{func\cursor.i param-mn.sub-nf}
{func\cursor.i param-mn.conta-desp-viag}
{func\cursor.i param-mn.cd-favorecido}
{func\cursor.i param-mn.fav-desp-viag}
{func\cursor.i param-mn.conta-desp-nreemb}

APPLY "VALUE-CHANGED" TO param-mn.sincroniza IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.categoria-recibo IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.sub-recibo IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.conta-recibo IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.categoria-nf IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.sub-nf IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.conta-desp-viag IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.cd-favorecido IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.fav-desp-viag IN FRAME default-frame.
APPLY "LEAVE" TO param-mn.conta-desp-nreemb IN FRAME default-frame.

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
        ASSIGN param-mn.categoria-recibo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(categoria.cod-categoria).
    END.
END.
IF cObject = "subcat" THEN DO:
    FIND FIRST sub-cat NO-LOCK
        WHERE sub-cat.ds-sub = INPUT FRAME {&FRAME-NAME} subcat NO-ERROR.
    IF AVAIL sub-cat THEN DO:
        ASSIGN param-mn.sub-recibo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(sub-cat.cd-sub).
    END.
END.
IF cObject = "ds-conta" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} ds-conta NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN param-mn.conta-recibo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.
IF cObject = "cat-nf" THEN DO:
    FIND FIRST categoria NO-LOCK
        WHERE categoria.ds-categoria = INPUT FRAME {&FRAME-NAME} cat-nf NO-ERROR.
    IF AVAIL categoria THEN DO:
        ASSIGN param-mn.categoria-nf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(categoria.cod-categoria).
    END.
END.
IF cObject = "subcat-nf" THEN DO:
    FIND FIRST sub-cat NO-LOCK
        WHERE sub-cat.ds-sub = INPUT FRAME {&FRAME-NAME} subcat-nf NO-ERROR.
    IF AVAIL sub-cat THEN DO:
        ASSIGN param-mn.sub-nf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(sub-cat.cd-sub).
    END.
END.
IF cObject = "ds-conta-desp" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} ds-conta-desp NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN param-mn.conta-desp-viag:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.
IF cObject = "ds-fav-desp" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} ds-fav-desp NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN param-mn.fav-desp-viag:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

