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
&GLOBAL-DEFINE Table        apontamento
&GLOBAL-DEFINE Parent       usuario
&GLOBAL-DEFINE ParentField  nome
&GLOBAL-DEFINE KeyFields    apontamento.data apontamento.hora-ini
&GLOBAL-DEFINE FrameFields  apontamento.qt-apontada apontamento.nr-pedido ~
                            apontamento.sequencia apontamento.ds-apontamento apontamento.nr-mov ~
                            apontamento.cd-favorecido apontamento.ds-fav-apont apontamento.reembolsavel ~
                            apontamento.tipo-despesa
&GLOBAL-DEFINE FrameDisp    

/* Local Variable Definitions ---                                       */


/* Buffers */

DEFINE BUFFER bf-apt FOR apontamento.

{func\definitions.i}

DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giNome      AS CHARACTER   NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSeq-Viag  AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSeqTar    AS INTEGER     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS apontamento.nome apontamento.nr-pedido ~
apontamento.sequencia apontamento.data apontamento.hora-ini ~
apontamento.qt-apontada apontamento.cd-favorecido apontamento.ds-fav-apont ~
apontamento.nr-mov apontamento.tipo-despesa apontamento.reembolsavel ~
apontamento.ds-apontamento 
&Scoped-define ENABLED-TABLES apontamento
&Scoped-define FIRST-ENABLED-TABLE apontamento
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-22 RECT-23 
&Scoped-Define DISPLAYED-FIELDS apontamento.nome apontamento.nr-pedido ~
apontamento.sequencia apontamento.data apontamento.hora-ini ~
apontamento.qt-apontada apontamento.cd-favorecido apontamento.ds-fav-apont ~
apontamento.nr-mov apontamento.tipo-despesa apontamento.reembolsavel ~
apontamento.ds-apontamento 
&Scoped-define DISPLAYED-TABLES apontamento
&Scoped-define FIRST-DISPLAYED-TABLE apontamento


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

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE RECTANGLE RECT-22
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.5.

DEFINE RECTANGLE RECT-23
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     apontamento.nome AT ROW 1.5 COL 13 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     apontamento.nr-pedido AT ROW 1.5 COL 50 COLON-ALIGNED WIDGET-ID 52
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     apontamento.sequencia AT ROW 1.5 COL 71 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btCancel AT ROW 11 COL 74.14
     apontamento.data AT ROW 3 COL 13 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 9.29 BY .79
     apontamento.hora-ini AT ROW 3 COL 28 COLON-ALIGNED WIDGET-ID 102
          LABEL "Hora"
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     apontamento.qt-apontada AT ROW 3 COL 66 COLON-ALIGNED WIDGET-ID 54
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     apontamento.cd-favorecido AT ROW 4.5 COL 13 COLON-ALIGNED WIDGET-ID 116
          VIEW-AS FILL-IN 
          SIZE 4.57 BY .79
     apontamento.ds-fav-apont AT ROW 4.5 COL 18 COLON-ALIGNED NO-LABEL WIDGET-ID 118
          VIEW-AS FILL-IN 
          SIZE 58 BY .79
     apontamento.nr-mov AT ROW 5.5 COL 13 COLON-ALIGNED WIDGET-ID 108
          VIEW-AS FILL-IN 
          SIZE 18 BY .79
     apontamento.tipo-despesa AT ROW 5.5 COL 42 COLON-ALIGNED WIDGET-ID 126
          VIEW-AS COMBO-BOX INNER-LINES 11
          LIST-ITEMS "","Quilometragem","Alimentaá∆o","Ped†gio","Taxi","Passagem","Hotel","Combust°vel","Aluguel Carro","Internet","Outras" 
          DROP-DOWN-LIST
          SIZE 20 BY 1
     apontamento.reembolsavel AT ROW 5.5 COL 66 WIDGET-ID 124
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY .83
     apontamento.ds-apontamento AT ROW 7 COL 15 NO-LABEL WIDGET-ID 60
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 63.72 BY 4
     btOK AT ROW 11 COL 68
     "Descriá∆o:" VIEW-AS TEXT
          SIZE 7.57 BY .54 AT ROW 8.25 COL 7 WIDGET-ID 62
     RECT-2 AT ROW 1.25 COL 2
     RECT-22 AT ROW 4.25 COL 2 WIDGET-ID 110
     RECT-23 AT ROW 2.75 COL 2 WIDGET-ID 112
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 12.13
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
         WIDTH              = 80
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
       apontamento.ds-apontamento:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

/* SETTINGS FOR FILL-IN apontamento.ds-fav-apont IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN apontamento.hora-ini IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
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


&Scoped-define SELF-NAME apontamento.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.cd-favorecido C-Win
ON LEAVE OF apontamento.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc="ds-favorecido"
                  &Tela="ds-fav-apont"}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF apontamento.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
OR F5 OF apontamento.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="apontamento.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="ds-fav-apont"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.data C-Win
ON ENTRY OF apontamento.data IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.data C-Win
ON LEAVE OF apontamento.data IN FRAME DEFAULT-FRAME /* Data */
DO:
    DEFINE VARIABLE c-hora AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i-min AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-hora AS INTEGER     NO-UNDO.

    {func\set_leave.i}    

    FIND LAST bf-apontamento NO-LOCK
        WHERE bf-apontamento.nome = gcUsuario
        AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
        AND   ROWID(bf-apontamento) <> ROWID(apontamento) NO-ERROR.
    IF AVAIL bf-apontamento THEN DO:
        ASSIGN c-hora = bf-apontamento.hora-fim
               i-min = INT(SUBSTRING(c-hora, 4, 2))
               i-hora = INT(SUBSTRING(c-hora, 1, 2)).
        IF i-min = 59 THEN
            ASSIGN i-hora = i-hora + 1
                   i-min = 0.
        ELSE
            ASSIGN i-min = i-min + 1.
        ASSIGN apontamento.hora-ini:SCREEN-VALUE = STRING(i-hora, "99") + ":" + STRING(i-min, "99").
    END.
    ELSE
        ASSIGN apontamento.hora-ini:SCREEN-VALUE = "08:00".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.ds-apontamento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.ds-apontamento C-Win
ON ENTRY OF apontamento.ds-apontamento IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.ds-apontamento C-Win
ON LEAVE OF apontamento.ds-apontamento IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.ds-fav-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.ds-fav-apont C-Win
ON LEAVE OF apontamento.ds-fav-apont IN FRAME DEFAULT-FRAME /* Desc. Fav. Apont. */
DO:
    IF INPUT FRAME {&FRAME-NAME} apontamento.ds-fav-apont <> "" THEN DO:
        FIND FIRST favorecido NO-LOCK
            WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} apontamento.ds-fav-apont NO-ERROR.
    
        ASSIGN apontamento.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE favorecido THEN STRING(favorecido.cd-favorecido) ELSE "0".

        ASSIGN apontamento.ds-fav-apont:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF AVAILABLE favorecido THEN STRING(favorecido.ds-favorecido) ELSE apontamento.ds-fav-apont:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.hora-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.hora-ini C-Win
ON ENTRY OF apontamento.hora-ini IN FRAME DEFAULT-FRAME /* Hora */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.hora-ini C-Win
ON LEAVE OF apontamento.hora-ini IN FRAME DEFAULT-FRAME /* Hora */
DO:
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    {func\set_leave.i}
    IF NOT INPUT FRAME {&FRAME-NAME} apontamento.hora-ini MATCHES("*:*") THEN DO:
        ASSIGN cAux = SUBSTRING(apontamento.hora-ini:SCREEN-VALUE,1,2) + ":" + SUBSTRING(apontamento.hora-ini:SCREEN-VALUE,3,2)
               apontamento.hora-ini:SCREEN-VALUE = cAux.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.nome
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.nome C-Win
ON ENTRY OF apontamento.nome IN FRAME DEFAULT-FRAME /* Usu†rio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.nome C-Win
ON LEAVE OF apontamento.nome IN FRAME DEFAULT-FRAME /* Usu†rio */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.nr-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.nr-pedido C-Win
ON ENTRY OF apontamento.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.nr-pedido C-Win
ON LEAVE OF apontamento.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.qt-apontada
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.qt-apontada C-Win
ON ENTRY OF apontamento.qt-apontada IN FRAME DEFAULT-FRAME /* Qtde Apontada */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.qt-apontada C-Win
ON LEAVE OF apontamento.qt-apontada IN FRAME DEFAULT-FRAME /* Qtde Apontada */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.sequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.sequencia C-Win
ON ENTRY OF apontamento.sequencia IN FRAME DEFAULT-FRAME /* Sequància */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.sequencia C-Win
ON LEAVE OF apontamento.sequencia IN FRAME DEFAULT-FRAME /* Sequància */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\calc.i apontamento.qt-apontada}
{func\calendar.i apontamento.data}

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
  {version.i apont-desp_det}
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

    ASSIGN apontamento.hora-fim = apontamento.hora-ini
           apontamento.seq-visita = giSeq-Viag.

    DEFINE BUFFER bf-pedido-item FOR pedido-item.

    FIND FIRST pedido-item OF apontamento EXCLUSIVE-LOCK NO-ERROR.
    IF AVAIL pedido-item THEN DO:

        /* Controla qt-atendida do item do pedido */
        ASSIGN pedido-item.qt-atendida = 0.
        FOR EACH bf-apontamento OF pedido-item NO-LOCK:
            ASSIGN pedido-item.qt-atendida = pedido-item.qt-atendida + bf-apontamento.qt-apontada.
        END.

        /* Controla situaá∆o do item do pedido */
        IF pedido-item.qt-atendida >= pedido-item.qt-pedida THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Situaá∆o Pedido (056)', INPUT 'Deseja atender o Item do Pedido?', INPUT 'A quantidade atendida do item do pedido Ç maior que a quantidade pedida. Deseja alterar a situaá∆o do Item do Pedido para Atendido?')"}
            IF RETURN-VALUE = "OK":U THEN
                ASSIGN pedido-item.situacao = 3 /* Atendido */.
            ELSE
                ASSIGN pedido-item.situacao = 2 /* Iniciado */.
        END.
        ELSE
            ASSIGN pedido-item.situacao = 2 /* Iniciado */.

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
    END.

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

    ASSIGN apontamento.data = TODAY.

    IF giNr-pedido <> 0 THEN DO:
        ASSIGN apontamento.nr-pedido  = giNr-pedido
               apontamento.sequencia  = giSequencia.
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

IF giNr-pedido <> 0 THEN DO:
    DISABLE apontamento.nr-pedido
            apontamento.sequencia
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
  IF AVAILABLE apontamento THEN 
    DISPLAY apontamento.nome apontamento.nr-pedido apontamento.sequencia 
          apontamento.data apontamento.hora-ini apontamento.qt-apontada 
          apontamento.cd-favorecido apontamento.ds-fav-apont apontamento.nr-mov 
          apontamento.tipo-despesa apontamento.reembolsavel 
          apontamento.ds-apontamento 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE apontamento.nome apontamento.nr-pedido apontamento.sequencia 
         apontamento.data apontamento.hora-ini apontamento.qt-apontada 
         apontamento.cd-favorecido apontamento.ds-fav-apont apontamento.nr-mov 
         apontamento.tipo-despesa apontamento.reembolsavel 
         apontamento.ds-apontamento RECT-2 RECT-22 RECT-23 
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

{func\cursor.i apontamento.cd-favorecido}

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
    FIND FIRST bf-apontamento NO-LOCK
        WHERE bf-apontamento.nome = INPUT FRAME {&FRAME-NAME} apontamento.nome
        AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
        AND   bf-apontamento.hora-ini = INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
        AND   ROWID(bf-apontamento) <> ROWID(apontamento) NO-ERROR.
    IF AVAIL bf-apontamento THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.
IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:

    IF INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido <> 0 THEN DO:

        FIND FIRST pedido-item NO-LOCK
            WHERE pedido-item.nr-pedido = INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido
            AND   pedido-item.sequencia = INPUT FRAME {&FRAME-NAME} apontamento.sequencia NO-ERROR.
        IF AVAIL pedido-item THEN DO:
            IF pedido-item.qt-liberada <> 0 THEN DO:
                IF (pedido-item.qt-atendida - apontamento.qt-apontada + INPUT FRAME {&FRAME-NAME} apontamento.qt-apontada) > pedido-item.qt-liberada THEN DO:
                    IF pedido-item.hora-fechada THEN DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Quantidade apontada maior que a fechada!', INPUT 'O somat¢rio das horas apontadas Ç maior que a quantidade de horas combinadas. As horas adicionais n∆o ser∆o pagas. Confirma apontamento ?')"}
                        IF RETURN-VALUE <> "OK":U THEN RETURN "NOK".
                    END.
                    ELSE DO:
                        {func\valida.i &Mensagem  = "Quantidade apontada maior que a liberada!"
                                       &Ajuda     = "O somat¢rio das horas apontadas Ç maior que a quantidade de horas liberadas. Solicite ao respons†vel a liberaá∆o de mais horas para este pedido."
                                       &Campo     = apontamento.qt-apontada}
                    END.
                END.
            END.
            ELSE DO:
                IF (pedido-item.qt-atendida - apontamento.qt-apontada + INPUT FRAME {&FRAME-NAME} apontamento.qt-apontada) > pedido-item.qt-pedida THEN DO:
                    IF pedido-item.hora-fechada THEN DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Quantidade apontada maior que a fechada!', INPUT 'O somat¢rio das horas apontadas Ç maior que a quantidade de horas combinadas. As horas adicionais n∆o ser∆o pagas. Confirma apontamento ?')"}
                        IF RETURN-VALUE <> "OK":U THEN RETURN "NOK".
                    END.
                    ELSE DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Quantidade apontada maior que a pedida!', INPUT 'O somat¢rio das horas apontadas Ç maior que a quantidade de horas pedidas. Confirma apontamento ?')"}
                        IF RETURN-VALUE <> "OK":U THEN RETURN "NOK".
                    END.
                END.
            END.
        END.

    END.

    IF INPUT FRAME {&FRAME-NAME} apontamento.hora-ini = "" THEN DO:
        {func\valida.i &Mensagem  = "Hora inv†lida!"
                       &Ajuda     = "Vocà deve informar a hora do apontamento."
                       &Campo     = apontamento.hora-ini}
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} apontamento.hora-ini > "23:59"
        OR INPUT FRAME {&FRAME-NAME} apontamento.hora-ini < "00:00" THEN DO:
            {func\valida.i &Mensagem  = "Hora inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora do apontamento entre 00:00 e 23:59."
                           &Campo     = apontamento.hora-ini}
        END.
        ELSE DO:
            IF ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":") < "00"
            OR ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":") > "59" THEN DO:
                {func\valida.i &Mensagem  = "Hora inv†lida!"
                               &Ajuda     = "Vocà deve informar os minutos da hora entre 00 e 59."
                               &Campo     = apontamento.hora-ini}
            END.
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} apontamento.data = ? THEN DO:
        {func\valida.i &Mensagem  = "Data inv†lida!"
                       &Ajuda     = "Vocà deve informar a data do apontamento."
                       &Campo     = apontamento.data}
    END.

    IF DAY(TODAY) > 1
    AND MONTH(INPUT FRAME {&FRAME-NAME} apontamento.data) <> MONTH(TODAY) THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Atená∆o com a data!', INPUT 'Vocà est† realizando apontamentos em um per°odo anterior. As horas apontadas podem n∆o ser pagas corretamente. Entre em contato com o financeiro da empresa. Confirma esse apontamento?')"}
        IF RETURN-VALUE = "NOK" THEN DO:
            APPLY "ENTRY":U TO apontamento.data IN FRAME {&FRAME-NAME}.
            RETURN "NOK".
        END.
    END.

    IF CAN-FIND(FIRST bf-apontamento
                WHERE bf-apontamento.nome = INPUT FRAME {&FRAME-NAME} apontamento.nome
                AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
                AND   bf-apontamento.hora-ini <= INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
                AND   bf-apontamento.hora-fim >= INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
                AND   ROWID(bf-apontamento) <> ROWID(apontamento)) THEN DO:
        {func\valida.i &Mensagem  = "Apontamento inv†lido!"
                       &Ajuda     = "J† existe apontamento para o per°odo informado."
                       &Campo     = apontamento.hora-ini}
    END.

    IF INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido <> 0 THEN DO:

        IF NOT AVAIL pedido-item THEN DO:
            {func\valida.i &Mensagem  = "Pedido inexistente!"
                           &Ajuda     = "N∆o existe o pedido\sequància informados."
                           &Campo     = apontamento.nr-pedido}
        END.
        ELSE DO:
            IF pedido-item.situacao = 9 /* Cancelado */ THEN DO:
                {func\valida.i &Mensagem  = "Item do Pedido Cancelado!"
                               &Ajuda     = "O item do pedido informado est† cancelado. Para realizar apontamentos vocà deve mudar a situaá∆o do item do pedido para Iniciado."
                               &Campo     = apontamento.sequencia}
            END.
        END.

        IF CAN-FIND(FIRST pedido
                    WHERE pedido.nr-pedido = INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido
                    AND   pedido.situacao = 4 /* Faturado */)  THEN DO:
            {func\valida.i &Mensagem  = "Pedido j† Faturado!"
                           &Ajuda     = "O pedido informado j† foi faturado. N∆o Ç permitida a realizaá∆o de apontamentos em pedidos j† Faturados."
                           &Campo     = apontamento.nr-pedido}
        END.

    END.

    IF NOT CAN-FIND(FIRST pedido-item-usu OF apontamento) THEN DO:
        {func\valida.i &Mensagem  = "Apontamento inv†lido!"
                       &Ajuda     = "Usu†rio n∆o tem permiss∆o de apontar horas nesse pedido e item."
                       &Campo     = apontamento.nr-pedido}
    END.

    FIND FIRST pedido-item NO-LOCK
        WHERE pedido-item.nr-pedido = INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido
        AND   pedido-item.sequencia = INPUT FRAME {&FRAME-NAME} apontamento.sequencia NO-ERROR.
    IF AVAIL pedido-item THEN DO:
        /* Apontamento sem Tarefa */
        IF NOT pedido-item.perm-apont-s-tar THEN DO:
            {func\valida.i &Mensagem  = "Tarefa requerida!"
                           &Ajuda     = "Solicite revis∆o ao gestor pois apontamentos de despesa de viagem n∆o devem ser associados a tarefa."}
        END.

        /*Documento obrigat¢rio*/
        FOR FIRST item NO-LOCK OF pedido-item,
            FIRST sub-cat NO-LOCK OF ITEM
            WHERE sub-cat.obriga-num:
            IF INPUT FRAME {&FRAME-NAME} apontamento.nr-mov = "" THEN DO:
                {func\valida.i &Mensagem  = "Documento Obrigat¢rio!"
                               &Ajuda     = "Para esta despesa Ç obrigat¢rio o preenchimento do n£mero do documento."
                               &Campo     = apontamento.nr-mov}
            END.

            IF INPUT FRAME {&FRAME-NAME} apontamento.ds-fav-apont = "" THEN DO:
                {func\valida.i &Mensagem  = "Descriá∆o do Favorecido Obrigat¢ria!"
                               &Ajuda     = "Para esta despesa Ç obrigat¢rio informar a descriá∆o do favorecido."
                               &Campo     = apontamento.ds-fav-apont}
            END.
        END.
    END.

    IF NOT INPUT FRAME {&FRAME-NAME} apontamento.reembolsavel 
        AND INPUT FRAME {&FRAME-NAME} apontamento.cd-favorecido = 0 THEN DO:
        {func\valida.i &Mensagem  = "Favorecido Obrigat¢rio!"
                       &Ajuda     = "Para despesas n∆o reembols†veis Ç obrigat¢rio informar um favorecido cadastrado."
                       &Campo     = apontamento.cd-favorecido}
    END.

    IF INPUT FRAME {&FRAME-NAME} apontamento.tipo-despesa = "" THEN DO:
        {func\valida.i &Mensagem  = "Tipo Despesa Obrigat¢rio!"
                       &Ajuda     = "Vocà deve informar o tipo de depesa do apontamento."
                       &Campo     = apontamento.tipo-despesa}
    END.
END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

