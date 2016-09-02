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
&GLOBAL-DEFINE Table        visita
&GLOBAL-DEFINE Parent       usuario
&GLOBAL-DEFINE ParentField  nome
&GLOBAL-DEFINE KeyFields    visita.sequencia
&GLOBAL-DEFINE FrameFields  visita.dt-visita visita.hora-ini ~
                            visita.hora-fim visita.nome ~
                            visita.cd-favorecido visita.ds-visita ~
                            visita.tipo visita.situacao ~
                            visita.ds-observacao visita.ocupado ~
                            visita.nr-pedido fav visita.vl-adiantado
&GLOBAL-DEFINE FrameDisp    

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE glCompromisso AS LOGICAL     NO-UNDO.


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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES visita

/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME visita.ocupado ~
visita.sequencia visita.nome visita.cd-favorecido visita.tipo ~
visita.ds-visita visita.situacao visita.dt-visita visita.hora-inicio ~
visita.hora-fim visita.ds-observacao visita.nr-pedido visita.vl-adiantado 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME visita.ocupado ~
visita.sequencia visita.nome visita.cd-favorecido visita.tipo ~
visita.ds-visita visita.situacao visita.dt-visita visita.hora-inicio ~
visita.hora-fim visita.ds-observacao visita.nr-pedido visita.vl-adiantado 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME visita
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME visita
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH visita SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH visita SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME visita
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME visita


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS visita.ocupado visita.sequencia visita.nome ~
visita.cd-favorecido visita.tipo visita.ds-visita visita.situacao ~
visita.dt-visita visita.hora-inicio visita.hora-fim visita.ds-observacao ~
visita.nr-pedido visita.vl-adiantado 
&Scoped-define ENABLED-TABLES visita
&Scoped-define FIRST-ENABLED-TABLE visita
&Scoped-Define ENABLED-OBJECTS RECT-2 
&Scoped-Define DISPLAYED-FIELDS visita.ocupado visita.sequencia visita.nome ~
visita.cd-favorecido visita.tipo visita.ds-visita visita.situacao ~
visita.dt-visita visita.hora-inicio visita.hora-fim visita.ds-observacao ~
visita.nr-pedido visita.vl-adiantado 
&Scoped-define DISPLAYED-TABLES visita
&Scoped-define FIRST-DISPLAYED-TABLE visita
&Scoped-Define DISPLAYED-OBJECTS fav 

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

DEFINE VARIABLE fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 72 BY 1.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY DEFAULT-FRAME FOR 
      visita SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     visita.ocupado AT ROW 6 COL 45 WIDGET-ID 78
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .83
     visita.sequencia AT ROW 1.5 COL 13 COLON-ALIGNED WIDGET-ID 70
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     visita.nome AT ROW 1.5 COL 59 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     visita.cd-favorecido AT ROW 3 COL 13 COLON-ALIGNED WIDGET-ID 66
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btCancel AT ROW 11.25 COL 68.14
     fav AT ROW 3 COL 18 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     visita.tipo AT ROW 3 COL 58 COLON-ALIGNED WIDGET-ID 74
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Cliente",1,
                     "Prospect",2,
                     "Parceiro",3,
                     "Fornecedor",4,
                     "Particular",5
          DROP-DOWN-LIST
          SIZE 12 BY 1
     visita.ds-visita AT ROW 4 COL 13 COLON-ALIGNED WIDGET-ID 68
          VIEW-AS FILL-IN 
          SIZE 57 BY .79
     visita.situacao AT ROW 5 COL 13 COLON-ALIGNED WIDGET-ID 76
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Planejada",1,
                     "Confirmada",2,
                     "Realizada",8,
                     "Cancelada",9
          DROP-DOWN-LIST
          SIZE 25 BY 1
     btOK AT ROW 11.25 COL 62
     visita.dt-visita AT ROW 5 COL 43 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     visita.hora-inicio AT ROW 5 COL 64 COLON-ALIGNED WIDGET-ID 48
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     visita.hora-fim AT ROW 6 COL 64 COLON-ALIGNED WIDGET-ID 46
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     visita.ds-observacao AT ROW 7 COL 15 NO-LABEL WIDGET-ID 60
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 57 BY 4
     visita.nr-pedido AT ROW 11.25 COL 13 COLON-ALIGNED WIDGET-ID 80
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     visita.vl-adiantado AT ROW 11.25 COL 50 COLON-ALIGNED WIDGET-ID 82
          VIEW-AS FILL-IN 
          SIZE 8.29 BY .79
     "Observaá∆o:" VIEW-AS TEXT
          SIZE 9 BY .54 AT ROW 6.25 COL 15 WIDGET-ID 62
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 73.57 BY 12.13
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
         HEIGHT             = 12.13
         WIDTH              = 73.57
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
       visita.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

/* SETTINGS FOR FILL-IN fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       fav:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.visita"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
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


&Scoped-define SELF-NAME visita.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.cd-favorecido C-Win
ON ENTRY OF visita.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.cd-favorecido C-Win
ON LEAVE OF visita.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="fav"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF visita.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="visita.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="fav"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.ds-observacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.ds-observacao C-Win
ON ENTRY OF visita.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.ds-observacao C-Win
ON LEAVE OF visita.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.ds-visita
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.ds-visita C-Win
ON ENTRY OF visita.ds-visita IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.ds-visita C-Win
ON LEAVE OF visita.ds-visita IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.dt-visita
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.dt-visita C-Win
ON ENTRY OF visita.dt-visita IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.dt-visita C-Win
ON LEAVE OF visita.dt-visita IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.hora-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.hora-fim C-Win
ON ENTRY OF visita.hora-fim IN FRAME DEFAULT-FRAME /* Hora Final */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.hora-fim C-Win
ON LEAVE OF visita.hora-fim IN FRAME DEFAULT-FRAME /* Hora Final */
DO:
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    {func\set_leave.i}
    IF NOT INPUT FRAME {&FRAME-NAME} visita.hora-fim MATCHES("*:*") THEN DO:
        ASSIGN cAux = SUBSTRING(visita.hora-fim:SCREEN-VALUE,1,2) + ":" + SUBSTRING(visita.hora-fim:SCREEN-VALUE,3,2)
               visita.hora-fim:SCREEN-VALUE = cAux.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.hora-inicio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.hora-inicio C-Win
ON ENTRY OF visita.hora-inicio IN FRAME DEFAULT-FRAME /* Hora In°cio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.hora-inicio C-Win
ON LEAVE OF visita.hora-inicio IN FRAME DEFAULT-FRAME /* Hora In°cio */
DO:
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    {func\set_leave.i}
    IF NOT INPUT FRAME {&FRAME-NAME} visita.hora-ini MATCHES("*:*") THEN DO:
        ASSIGN cAux = SUBSTRING(visita.hora-ini:SCREEN-VALUE,1,2) + ":" + SUBSTRING(visita.hora-ini:SCREEN-VALUE,3,2)
               visita.hora-ini:SCREEN-VALUE = cAux.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.nome
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.nome C-Win
ON ENTRY OF visita.nome IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.nome C-Win
ON LEAVE OF visita.nome IN FRAME DEFAULT-FRAME /* Nome */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.nr-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.nr-pedido C-Win
ON MOUSE-SELECT-DBLCLICK OF visita.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
OR F5 OF {&Table}.nr-pedido DO:
    DEFINE VARIABLE i-favorecido AS INTEGER NO-UNDO.
    ASSIGN i-favorecido = INPUT FRAME {&FRAME-NAME} visita.cd-favorecido.
    {func\zoom.i &Tabela="pedido"
                 &Campo1="nr-pedido"
                 &Tela1="visita.nr-pedido"
                 &CampoFiltro1="cd-favorecido"
                 &ValorFiltro1=STRING(i-favorecido)
                 &CampoFiltroIniFim1="situacao"
                 &ValorFiltroIni1="1"
                 &ValorFiltroFim1="2"}
                 
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME visita.sequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.sequencia C-Win
ON ENTRY OF visita.sequencia IN FRAME DEFAULT-FRAME /* Sequància */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL visita.sequencia C-Win
ON LEAVE OF visita.sequencia IN FRAME DEFAULT-FRAME /* Sequància */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = fav
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = visita.cd-favorecido}
{func\calendar.i visita.dt-visita}

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
  {version.i visita_det}
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

    DEFINE VARIABLE iHr-ini AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iHr-fim AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMin-ini AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMin-fim AS INTEGER     NO-UNDO.
    DEFINE VARIABLE deQtd AS DECIMAL     NO-UNDO.

    ASSIGN visita.compromisso = glCompromisso.

    ASSIGN iHr-ini = INT(ENTRY(1,INPUT FRAME {&FRAME-NAME} visita.hora-inicio,":"))
           iMin-ini = INT(ENTRY(2,INPUT FRAME {&FRAME-NAME} visita.hora-inicio,":"))
           iHr-fim = INT(ENTRY(1,INPUT FRAME {&FRAME-NAME} visita.hora-fim,":"))
           iMin-fim = INT(ENTRY(2,INPUT FRAME {&FRAME-NAME} visita.hora-fim,":")).

    IF iMin-ini = 0 THEN 
        ASSIGN iMin-ini = 60.
    ELSE
        ASSIGN iHr-ini = iHr-ini + 1.

    ASSIGN deQtd = iHr-fim - iHr-ini
           deQtd = deQtd + ((60 - iMin-ini) / 60)
           deQtd = deQtd + (iMin-fim / 60).

    ASSIGN visita.qt-visita = deQtd.

    RUN calc_prioridade.p (INPUT gcUsuario,
                           INPUT TODAY).

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

    ASSIGN visita.dt-visita = TODAY.

    IF glCompromisso THEN DO:

        ASSIGN visita.tipo = 5
               visita.cd-favorecido = 440.

    END.

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

    {func\detalhe\display.i}
    
    DISABLE visita.sequencia WITH FRAME {&FRAME-NAME}.
    
    APPLY "LEAVE" TO visita.cd-favorecido.
    
    IF glCompromisso THEN DO:
        HIDE visita.cd-favorecido
             visita.tipo
             visita.nr-pedido
             visita.vl-adiantado
             fav
            IN FRAME {&FRAME-NAME}.

    END.
    ELSE DO:
        ASSIGN visita.ocupado = NO.

        DISPLAY visita.ocupado 
            WITH FRAME {&FRAME-NAME}.
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
  DISPLAY fav 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE visita THEN 
    DISPLAY visita.ocupado visita.sequencia visita.nome visita.cd-favorecido 
          visita.tipo visita.ds-visita visita.situacao visita.dt-visita 
          visita.hora-inicio visita.hora-fim visita.ds-observacao 
          visita.nr-pedido visita.vl-adiantado 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE visita.ocupado visita.sequencia visita.nome visita.cd-favorecido 
         visita.tipo visita.ds-visita visita.situacao visita.dt-visita 
         visita.hora-inicio visita.hora-fim visita.ds-observacao 
         visita.nr-pedido visita.vl-adiantado RECT-2 
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
    DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO.
    
    {func\detalhe\initialize.i}
        
    IF pcActionBT = "ADD" THEN DO:

        SELECT MAX(sequencia) INTO iSeq FROM visita.

        ASSIGN {&Table}.sequencia = iSeq + 1.

        DISPLAY {&Table}.sequencia 
            WITH FRAME {&FRAME-NAME}.
    END.
    
    {func\cursor.i visita.cd-favorecido}
    {func\cursor.i visita.nr-pedido}

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

IF cObject = "fav" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} fav NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN visita.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
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
DEFINE VARIABLE iHr-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iHr-fim AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMin-ini AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMin-fim AS INTEGER     NO-UNDO.
DEFINE VARIABLE deQtd AS DECIMAL      NO-UNDO.

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-visita NO-LOCK
        WHERE bf-visita.sequencia = INPUT FRAME {&FRAME-NAME} visita.sequencia
        AND   ROWID(bf-visita) <> ROWID(visita) NO-ERROR.
    IF AVAIL bf-visita THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = INPUT FRAME {&FRAME-NAME} visita.nome NO-ERROR.
    IF NOT AVAIL usuario THEN DO:
        {func\valida.i &Mensagem  = "Usu†rio inv†lido!"
                       &Ajuda     = "O usu†rio da visita deve ser um usu†rio existente."
                       &Campo     = visita.nome}
    END.

    IF INPUT FRAME {&FRAME-NAME} visita.cd-favorecido = 0 THEN DO:
        {func\valida.i &Mensagem  = "Favorecido inv†lido!"
                       &Ajuda     = "Vocà deve informar o favorecido da visita."
                       &Campo     = visita.cd-favorecido}
    END.
    ELSE DO:
        IF NOT glCompromisso
        AND INPUT FRAME {&FRAME-NAME} visita.tipo = 5 /* Particular */
        AND INPUT FRAME {&FRAME-NAME} visita.cd-favorecido = 440 THEN DO:
            {func\valida.i &Mensagem  = "Favorecido inv†lido!"
                           &Ajuda     = "Vocà n∆o pode informar a ‡tima como favorecido de uma visita. Nesse caso vocà provavelmente deve criar um Compromisso."
                           &Campo     = visita.cd-favorecido}
        END.

    END.

    IF INPUT FRAME {&FRAME-NAME} visita.hora-ini = "" THEN DO:
        {func\valida.i &Mensagem  = "Hora Inicial inv†lida!"
                       &Ajuda     = "Vocà deve informar a hora inicial da visita."
                       &Campo     = visita.hora-ini}
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} visita.hora-ini > "23:59"
        OR INPUT FRAME {&FRAME-NAME} visita.hora-ini < "00:00" THEN DO:
            {func\valida.i &Mensagem  = "Hora Inicial inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora inicial da visita entre 00:00 e 23:59."
                           &Campo     = visita.hora-ini}
        END.
        ELSE DO:
            IF ENTRY(2,INPUT FRAME {&FRAME-NAME} visita.hora-ini,":") < "00"
            OR ENTRY(2,INPUT FRAME {&FRAME-NAME} visita.hora-ini,":") > "59" THEN DO:
                {func\valida.i &Mensagem  = "Hora Inicial inv†lida!"
                               &Ajuda     = "Vocà deve informar os minutos da hora inicial entre 00 e 59."
                               &Campo     = visita.hora-ini}
            END.
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} visita.hora-fim = "" THEN DO:
        {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                       &Ajuda     = "Vocà deve informar a hora final da visita."
                       &Campo     = visita.hora-fim}
    END.
    ELSE DO:

        IF INPUT FRAME {&FRAME-NAME} visita.hora-ini = INPUT FRAME {&FRAME-NAME} visita.hora-fim THEN DO:
            {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora final da visita maior que a hora inicial."
                           &Campo     = visita.hora-fim}
        END.

        IF INPUT FRAME {&FRAME-NAME} visita.hora-fim > "24:00"
        OR INPUT FRAME {&FRAME-NAME} visita.hora-fim < "00:01" THEN DO:
            {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora final da visita entre 00:01 e 24:00."
                           &Campo     = visita.hora-fim}
        END.
        ELSE DO:
            IF ENTRY(2,INPUT FRAME {&FRAME-NAME} visita.hora-fim,":") < "00"
            OR ENTRY(2,INPUT FRAME {&FRAME-NAME} visita.hora-fim,":") > "59" THEN DO:
                {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                               &Ajuda     = "Vocà deve informar os minutos da hora final entre 00 e 59."
                               &Campo     = visita.hora-fim}
            END.
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} visita.dt-visita = ? THEN DO:
        {func\valida.i &Mensagem  = "dt-visita inv†lida!"
                       &Ajuda     = "Vocà deve informar a data da visita."
                       &Campo     = visita.dt-visita}
    END.

    IF INPUT FRAME {&FRAME-NAME} visita.hora-ini > INPUT FRAME {&FRAME-NAME} visita.hora-fim THEN DO:
        {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                       &Ajuda     = "A hora final da visita deve ser maior que a hora inicial."
                       &Campo     = visita.hora-fim}
    END.

END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

