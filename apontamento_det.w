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
&GLOBAL-DEFINE FrameFields  apontamento.hora-fim apontamento.qt-apontada ~
                            apontamento.nr-pedido apontamento.sequencia ~
                            apontamento.ds-apontamento apontamento.codigo-fa
&GLOBAL-DEFINE FrameDisp    

/* Local Variable Definitions ---                                       */


/* Buffers */
DEFINE BUFFER bf-apt FOR apontamento.
DEFINE BUFFER bf-tar FOR tarefa.

{func\definitions.i}

DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giNome      AS CHARACTER   NO-UNDO.
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
&Scoped-Define ENABLED-FIELDS apontamento.nome apontamento.data ~
apontamento.hora-ini apontamento.hora-fim apontamento.qt-apontada ~
apontamento.nr-pedido apontamento.sequencia apontamento.codigo-fa ~
apontamento.ds-apontamento 
&Scoped-define ENABLED-TABLES apontamento
&Scoped-define FIRST-ENABLED-TABLE apontamento
&Scoped-Define ENABLED-OBJECTS cb-tarefa de-pc-con RECT-2 
&Scoped-Define DISPLAYED-FIELDS apontamento.nome apontamento.data ~
apontamento.hora-ini apontamento.hora-fim apontamento.qt-apontada ~
apontamento.nr-pedido apontamento.sequencia apontamento.codigo-fa ~
apontamento.ds-apontamento 
&Scoped-define DISPLAYED-TABLES apontamento
&Scoped-define FIRST-DISPLAYED-TABLE apontamento
&Scoped-Define DISPLAYED-OBJECTS cb-tarefa de-pc-con 

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

DEFINE VARIABLE cb-tarefa AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Tarefa" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0","1"
     DROP-DOWN-LIST
     SIZE 46 BY 1 NO-UNDO.

DEFINE VARIABLE de-pc-con AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "% Conclus∆o" 
     VIEW-AS FILL-IN 
     SIZE 6.86 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     apontamento.nome AT ROW 1.5 COL 13 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     btCancel AT ROW 11.5 COL 73.86
     apontamento.data AT ROW 1.5 COL 68 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 9.29 BY .79
     apontamento.hora-ini AT ROW 3.25 COL 13 COLON-ALIGNED WIDGET-ID 48
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     btOK AT ROW 11.5 COL 67.72
     apontamento.hora-fim AT ROW 4.25 COL 13 COLON-ALIGNED WIDGET-ID 46
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     apontamento.qt-apontada AT ROW 5.25 COL 13 COLON-ALIGNED WIDGET-ID 54
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     apontamento.nr-pedido AT ROW 3.25 COL 52 COLON-ALIGNED WIDGET-ID 52
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     apontamento.sequencia AT ROW 3.25 COL 72 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     apontamento.codigo-fa AT ROW 4.25 COL 52 COLON-ALIGNED WIDGET-ID 64
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     cb-tarefa AT ROW 6.25 COL 13 COLON-ALIGNED WIDGET-ID 96
     de-pc-con AT ROW 6.25 COL 70 COLON-ALIGNED WIDGET-ID 98
     apontamento.ds-apontamento AT ROW 7.25 COL 15 NO-LABEL WIDGET-ID 60
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 63.72 BY 4
     "Descriá∆o:" VIEW-AS TEXT
          SIZE 7.57 BY .54 AT ROW 7.25 COL 7.29 WIDGET-ID 62
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 12.29
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
         HEIGHT             = 12.29
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


&Scoped-define SELF-NAME cb-tarefa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb-tarefa C-Win
ON VALUE-CHANGED OF cb-tarefa IN FRAME DEFAULT-FRAME /* Tarefa */
DO:
  
    FIND FIRST tarefa NO-LOCK
        WHERE tarefa.nome = ENTRY(2, cb-tarefa:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
        AND   tarefa.sequencia = INT(ENTRY(1, cb-tarefa:SCREEN-VALUE, "-")) NO-ERROR.
    IF AVAIL tarefa THEN DO:
        ASSIGN de-pc-con:SCREEN-VALUE = STRING(tarefa.perc-con).
    END.

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
    {func\set_leave.i}    

    FIND LAST bf-apontamento NO-LOCK
        WHERE bf-apontamento.nome = gcUsuario
        AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
        AND   ROWID(bf-apontamento) <> ROWID(apontamento) NO-ERROR.
    IF AVAIL bf-apontamento THEN
        ASSIGN apontamento.hora-ini:SCREEN-VALUE = bf-apontamento.hora-fim.
    ELSE
        ASSIGN apontamento.hora-ini:SCREEN-VALUE = "08:00".

    IF apontamento.hora-fim:SCREEN-VALUE = "" THEN
        ASSIGN apontamento.hora-fim:SCREEN-VALUE = "18:00".

    RUN recalc.

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


&Scoped-define SELF-NAME apontamento.hora-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.hora-fim C-Win
ON ENTRY OF apontamento.hora-fim IN FRAME DEFAULT-FRAME /* Hora Final */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.hora-fim C-Win
ON LEAVE OF apontamento.hora-fim IN FRAME DEFAULT-FRAME /* Hora Final */
DO:
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    {func\set_leave.i}
    IF NOT INPUT FRAME {&FRAME-NAME} apontamento.hora-fim MATCHES("*:*") THEN DO:
        ASSIGN cAux = SUBSTRING(apontamento.hora-fim:SCREEN-VALUE,1,2) + ":" + SUBSTRING(apontamento.hora-fim:SCREEN-VALUE,3,2)
               apontamento.hora-fim:SCREEN-VALUE = cAux.
    END.
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME apontamento.hora-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.hora-ini C-Win
ON ENTRY OF apontamento.hora-ini IN FRAME DEFAULT-FRAME /* Hora Inicial */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL apontamento.hora-ini C-Win
ON LEAVE OF apontamento.hora-ini IN FRAME DEFAULT-FRAME /* Hora Inicial */
DO:
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    {func\set_leave.i}
    IF NOT INPUT FRAME {&FRAME-NAME} apontamento.hora-ini MATCHES("*:*") THEN DO:
        ASSIGN cAux = SUBSTRING(apontamento.hora-ini:SCREEN-VALUE,1,2) + ":" + SUBSTRING(apontamento.hora-ini:SCREEN-VALUE,3,2)
               apontamento.hora-ini:SCREEN-VALUE = cAux.
    END.
    RUN recalc.
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

    DEFINE VARIABLE cLista AS CHARACTER   NO-UNDO INITIAL ",0-".

    IF apontamento.seq-tarefa <> 0 THEN DO:
        FIND FIRST tarefa NO-LOCK
            WHERE tarefa.sequencia = apontamento.seq-tarefa
            AND   tarefa.nome = apontamento.nome-tarefa NO-ERROR.
        IF AVAIL tarefa THEN
            ASSIGN cLista = cLista + "," + tarefa.ds-tarefa + "," + STRING(tarefa.sequencia) + "-" + tarefa.nome.
    END.

    FIND FIRST ordem-serv NO-LOCK
        WHERE ordem-serv.nr-pedido = INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido NO-ERROR.
    IF AVAIL ordem-serv THEN DO:
        FOR EACH tarefa NO-LOCK
            WHERE tarefa.num-os = ordem-serv.num-os
            AND   tarefa.seq-pedido-item = INPUT FRAME {&FRAME-NAME} apontamento.sequencia
            AND   tarefa.situacao <= 2 /* Em Andamento */
            AND   tarefa.responsavel = INPUT FRAME {&FRAME-NAME} apontamento.nome:

            ASSIGN cLista = cLista + "," + tarefa.ds-tarefa + "," + STRING(tarefa.sequencia) + "-" + tarefa.nome.

        END.
    END.

    ASSIGN cb-tarefa:LIST-ITEM-PAIRS = cLista.

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

IF giNr-pedido <> 0 THEN DO:
    FIND FIRST pedido-item NO-LOCK
        WHERE pedido-item.nr-pedido = giNr-pedido
        AND   pedido-item.sequencia = giSequencia NO-ERROR.
    IF AVAIL pedido-item THEN DO:
        FIND FIRST item OF pedido-item NO-LOCK NO-ERROR.
        IF AVAIL item AND item.desp-viag THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Utilizaá∆o incorreta (057)', INPUT 'Apontamento inv†lido!', INPUT 'Vocà deve usar o programa de apontamento de Despesas de Viagem para apontar nesse item do pedido.')"}
            RETURN "NOK".
        END.
    END.
END.

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
  {version.i apontamento_det}
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
        IF pedido.situacao <> 5 /* Em Homologaá∆o */
        AND pedido.situacao <> 6 /* Em Garantia */ THEN DO:
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
    END.

    ASSIGN apontamento.nome-tarefa = ENTRY(2, cb-tarefa:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
           apontamento.seq-tarefa = INT(ENTRY(1, cb-tarefa:SCREEN-VALUE, "-"))
           giNome = ""
           giSeqTar = 0.

    /* Controla % Conclus∆o da Tarefa */
    FIND FIRST tarefa EXCLUSIVE-LOCK
        WHERE tarefa.nome = apontamento.nome-tarefa
        AND   tarefa.sequencia = apontamento.seq-tarefa NO-ERROR.
    IF AVAIL tarefa THEN DO:
        ASSIGN tarefa.perc-con = INPUT FRAME {&FRAME-NAME} de-pc-con.
        IF tarefa.perc-con = 100 THEN DO:
            ASSIGN tarefa.situacao = 8 /* Conclu°da */.
            IF tarefa.dt-real-ini = ? THEN
                ASSIGN tarefa.dt-real-ini = apontamento.data.
            IF tarefa.dt-real-fim = ? THEN
                ASSIGN tarefa.dt-real-fim = TODAY.
        END.
        ELSE DO:
            ASSIGN tarefa.situacao = 2 /* Em Andamento */.
            IF tarefa.dt-real-ini = ? THEN
                ASSIGN tarefa.dt-real-ini = apontamento.data.
        END.

        IF tarefa.num-os <> 0 THEN DO:
            RUN calc_prioridade.p (INPUT tarefa.responsavel,
                                   INPUT TODAY).

            IF tarefa.situacao >= 2 /* Em Andamento */ THEN DO:
                IF tarefa.dt-plan-ini = ? THEN DO:
                    ASSIGN tarefa.dt-plan-ini = tarefa.data-prev-ini.
                    IF tarefa.dt-real-ini < tarefa.dt-plan-ini THEN
                        ASSIGN tarefa.dt-plan-ini = tarefa.dt-real-ini.
                END.
                IF tarefa.dt-plan-fim = ? THEN DO:
                    ASSIGN tarefa.dt-plan-fim = tarefa.data-prev-fim.
                END.
            END.

            FIND FIRST ordem-serv OF tarefa EXCLUSIVE-LOCK NO-ERROR.
            IF AVAIL ordem-serv THEN DO:
                ASSIGN ordem-serv.situacao = 2 /* Atribuida */.
                IF CAN-FIND(FIRST tarefa OF ordem-serv
                            WHERE tarefa.situacao >= 2 /* Em Andamento */) THEN
                    ASSIGN ordem-serv.situacao = 3 /* Iniciada */.
                IF NOT CAN-FIND(FIRST tarefa OF ordem-serv
                                WHERE tarefa.situacao < 8 /* Conclu°da */) THEN
                    ASSIGN ordem-serv.situacao = 8 /* Conclu°da */.
            END.

        END.

    END.

    IF AVAILABLE ordem-serv THEN
        RELEASE ordem-serv NO-ERROR.

    IF AVAILABLE pedido-item THEN
        RELEASE pedido-item NO-ERROR.

    IF AVAILABLE pedido THEN
        RELEASE pedido NO-ERROR.

    IF AVAILABLE tarefa THEN
        RELEASE tarefa NO-ERROR.

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

    FIND LAST bf-apontamento NO-LOCK
        WHERE bf-apontamento.nome = apontamento.nome /*ocorria erro, alterado: gcUsuario Bruno*/
        AND   bf-apontamento.data = TODAY
        AND   bf-apontamento.hora-ini <> bf-apontamento.hora-fim NO-ERROR.
    IF AVAIL bf-apontamento THEN
        ASSIGN apontamento.hora-ini = bf-apontamento.hora-fim.
    ELSE
        ASSIGN apontamento.hora-ini = "08:00".

    ASSIGN apontamento.hora-fim = "18:00".

    IF giNr-pedido <> 0 THEN DO:
        ASSIGN apontamento.nr-pedido = giNr-pedido
               apontamento.sequencia = giSequencia.
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

RUN recalc.

IF giNr-pedido <> 0 THEN DO:
    DISABLE apontamento.nr-pedido
            apontamento.sequencia
        WITH FRAME {&FRAME-NAME}.
END.

DISABLE apontamento.codigo-fa
    WITH FRAME {&FRAME-NAME}.

IF pcActionBT = "ADD" THEN DO:
    IF giNome <> "" 
    AND giSeqTar <> 0 THEN DO:
        ASSIGN apontamento.nome-tarefa = giNome
               apontamento.seq-tarefa = giSeqTar.
        DISABLE cb-tarefa
            WITH FRAME {&FRAME-NAME}.
    END.
END.

APPLY "LEAVE" TO apontamento.nr-pedido.

IF apontamento.seq-tarefa <> 0 THEN DO:
    ASSIGN cb-tarefa = STRING(apontamento.seq-tarefa) + "-" + apontamento.nome-tarefa.
    FIND FIRST tarefa NO-LOCK
        WHERE tarefa.nome = apontamento.nome-tarefa
        AND   tarefa.sequencia = apontamento.seq-tarefa NO-ERROR.
    IF AVAIL tarefa THEN
        ASSIGN de-pc-con = tarefa.perc-con.
    DISP cb-tarefa
         de-pc-con
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
  DISPLAY cb-tarefa de-pc-con 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE apontamento THEN 
    DISPLAY apontamento.nome apontamento.data apontamento.hora-ini 
          apontamento.hora-fim apontamento.qt-apontada apontamento.nr-pedido 
          apontamento.sequencia apontamento.codigo-fa apontamento.ds-apontamento 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE apontamento.nome apontamento.data apontamento.hora-ini 
         apontamento.hora-fim apontamento.qt-apontada apontamento.nr-pedido 
         apontamento.sequencia apontamento.codigo-fa cb-tarefa de-pc-con 
         apontamento.ds-apontamento RECT-2 
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

    DEFINE VARIABLE iHr-ini AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iHr-fim AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMin-ini AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMin-fim AS INTEGER     NO-UNDO.
    DEFINE VARIABLE deQtd AS DECIMAL     NO-UNDO.

    IF INPUT FRAME {&FRAME-NAME} apontamento.hora-ini <> ""
    AND INPUT FRAME {&FRAME-NAME} apontamento.hora-fim <> "" THEN DO:

        ASSIGN iHr-ini = INT(ENTRY(1,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":"))
               iMin-ini = INT(ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":"))
               iHr-fim = INT(ENTRY(1,INPUT FRAME {&FRAME-NAME} apontamento.hora-fim,":"))
               iMin-fim = INT(ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-fim,":")).

        IF iMin-ini = 0 THEN 
            ASSIGN iMin-ini = 60.
        ELSE
            ASSIGN iHr-ini = iHr-ini + 1.

        ASSIGN deQtd = iHr-fim - iHr-ini
               deQtd = deQtd + ((60 - iMin-ini) / 60)
               deQtd = deQtd + (iMin-fim / 60).

    END.

    ASSIGN apontamento.qt-apontada:SCREEN-VALUE = STRING(deQtd).

    RETURN "OK".

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
                        {func\valida.i &Mensagem  = "Quantidade apontada maior que a liberada no pedido!"
                                       &Ajuda     = "O somat¢rio das horas apontadas Ç maior que a quantidade de horas liberadas no item do pedido. Solicite ao respons†vel a liberaá∆o de mais horas para este item do pedido."
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
        {func\valida.i &Mensagem  = "Hora Inicial inv†lida!"
                       &Ajuda     = "Vocà deve informar a hora inicial do apontamento."
                       &Campo     = apontamento.hora-ini}
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} apontamento.hora-ini > "23:59"
        OR INPUT FRAME {&FRAME-NAME} apontamento.hora-ini < "00:00" THEN DO:
            {func\valida.i &Mensagem  = "Hora Inicial inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora inicial do apontamento entre 00:00 e 23:59."
                           &Campo     = apontamento.hora-ini}
        END.
        ELSE DO:
            IF ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":") < "00"
            OR ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":") > "59" THEN DO:
                {func\valida.i &Mensagem  = "Hora Inicial inv†lida!"
                               &Ajuda     = "Vocà deve informar os minutos da hora inicial entre 00 e 59."
                               &Campo     = apontamento.hora-ini}
            END.
        END.
    END.

    IF INPUT FRAME {&FRAME-NAME} apontamento.hora-fim = "" THEN DO:
        {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                       &Ajuda     = "Vocà deve informar a hora final do apontamento."
                       &Campo     = apontamento.hora-fim}
    END.
    ELSE DO:

        IF INPUT FRAME {&FRAME-NAME} apontamento.hora-ini = INPUT FRAME {&FRAME-NAME} apontamento.hora-fim THEN DO:
            {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora final do apontamento maior que a hora inicial."
                           &Campo     = apontamento.hora-fim}
        END.

        IF INPUT FRAME {&FRAME-NAME} apontamento.hora-fim > "24:00"
        OR INPUT FRAME {&FRAME-NAME} apontamento.hora-fim < "00:01" THEN DO:
            {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                           &Ajuda     = "Vocà deve informar a hora final do apontamento entre 00:01 e 24:00."
                           &Campo     = apontamento.hora-fim}
        END.
        ELSE DO:
            IF ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-fim,":") < "00"
            OR ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-fim,":") > "59" THEN DO:
                {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                               &Ajuda     = "Vocà deve informar os minutos da hora final entre 00 e 59."
                               &Campo     = apontamento.hora-fim}
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

    IF INPUT FRAME {&FRAME-NAME} apontamento.hora-ini > INPUT FRAME {&FRAME-NAME} apontamento.hora-fim THEN DO:
        {func\valida.i &Mensagem  = "Hora Final inv†lida!"
                       &Ajuda     = "A hora final do apontamento deve ser maior que a hora inicial."
                       &Campo     = apontamento.hora-fim}
    END.

    IF CAN-FIND(FIRST bf-apontamento
                WHERE bf-apontamento.nome = INPUT FRAME {&FRAME-NAME} apontamento.nome
                AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
                AND   bf-apontamento.hora-ini > INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
                AND   bf-apontamento.hora-ini < INPUT FRAME {&FRAME-NAME} apontamento.hora-fim
                AND   ROWID(bf-apontamento) <> ROWID(apontamento)) THEN DO:
        {func\valida.i &Mensagem  = "Apontamento inv†lido!"
                       &Ajuda     = "J† existe apontamento para o per°odo informado."
                       &Campo     = apontamento.hora-ini}
    END.

    IF CAN-FIND(FIRST bf-apontamento
                WHERE bf-apontamento.nome = INPUT FRAME {&FRAME-NAME} apontamento.nome
                AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
                AND   bf-apontamento.hora-fim > INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
                AND   bf-apontamento.hora-fim < INPUT FRAME {&FRAME-NAME} apontamento.hora-fim
                AND   ROWID(bf-apontamento) <> ROWID(apontamento)) THEN DO:
        {func\valida.i &Mensagem  = "Apontamento inv†lido!"
                       &Ajuda     = "J† existe apontamento para o per°odo informado."
                       &Campo     = apontamento.hora-ini}
    END.

    IF CAN-FIND(FIRST bf-apontamento
                WHERE bf-apontamento.nome = INPUT FRAME {&FRAME-NAME} apontamento.nome
                AND   bf-apontamento.data = INPUT FRAME {&FRAME-NAME} apontamento.data
                AND   bf-apontamento.hora-ini < INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
                AND   bf-apontamento.hora-fim > INPUT FRAME {&FRAME-NAME} apontamento.hora-ini
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

    ASSIGN iHr-ini = INT(ENTRY(1,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":"))
           iMin-ini = INT(ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-ini,":"))
           iHr-fim = INT(ENTRY(1,INPUT FRAME {&FRAME-NAME} apontamento.hora-fim,":"))
           iMin-fim = INT(ENTRY(2,INPUT FRAME {&FRAME-NAME} apontamento.hora-fim,":")).

    IF iMin-ini = 0 THEN 
        ASSIGN iMin-ini = 60.
    ELSE
        ASSIGN iHr-ini = iHr-ini + 1.

    ASSIGN deQtd = iHr-fim - iHr-ini
           deQtd = deQtd + ((60 - iMin-ini) / 60)
           deQtd = deQtd + (iMin-fim / 60).

    IF AVAIL pedido-item THEN DO:
        FIND FIRST item OF pedido-item NO-LOCK NO-ERROR.
        IF AVAIL item AND item.un MATCHES("*hr*") THEN DO:
            IF INPUT FRAME {&FRAME-NAME} apontamento.qt-apontada > ROUND(deQtd, 2) THEN DO:
                {func\valida.i &Mensagem  = "Quantidade inv†lida!"
                               &Ajuda     = "Quantidade informada Ç maior que o per°odo informado."
                               &Campo     = apontamento.qt-apontada}
            END.
        END.
    END.

    /* Apontamento sem Tarefa */
    IF INPUT FRAME {&FRAME-NAME} cb-tarefa = "0-" THEN DO:
        IF NOT CAN-FIND(FIRST usuario NO-LOCK /*Validaá∆o do parÉmetro Aponta Sem Tarefa*/
                        WHERE usuario.nome = INPUT FRAME {&FRAME-NAME} apontamento.nome
                        AND   usuario.aponta-sem-tarefa) THEN DO:
            FIND FIRST pedido-item NO-LOCK
                WHERE pedido-item.nr-pedido = INPUT FRAME {&FRAME-NAME} apontamento.nr-pedido
                AND   pedido-item.sequencia = INPUT FRAME {&FRAME-NAME} apontamento.sequencia NO-ERROR.
            IF AVAIL pedido-item THEN DO:
                IF NOT pedido-item.perm-apont-s-tar THEN DO:
                    {func\valida.i &Mensagem  = "Tarefa inv†lida!"
                                   &Ajuda     = "Vocà deve informar a tarefa a qual se refere o apontamento para esse item do pedido."
                                   &Campo     = cb-tarefa}
                END.
            END.
        END.
    END.
    ELSE DO:
        /* Controla quantidade de horas liberadas na tarefa */
        FIND FIRST tarefa NO-LOCK
            WHERE tarefa.nome = ENTRY(2, cb-tarefa:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
            AND   tarefa.sequencia = INT(ENTRY(1, cb-tarefa:SCREEN-VALUE, "-")) NO-ERROR.
        IF AVAIL tarefa THEN DO:

            IF tarefa.dt-plan-ini > INPUT FRAME {&FRAME-NAME} apontamento.data THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Alerta!', INPUT 'Data do apontamento Ç menor que a data de in°cio da tarefa. A data de in°cio da tarefa ser† atualizada', INPUT 'A opá∆o "Sim" prosseguir† e atualizar† a data de in°cio da tarefa.')"}
                IF RETURN-VALUE = "OK":U THEN DO:
                    FIND FIRST tarefa EXCLUSIVE-LOCK
                        WHERE tarefa.nome      = ENTRY(2, cb-tarefa:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
                        AND   tarefa.sequencia = INT(ENTRY(1, cb-tarefa:SCREEN-VALUE, "-")) NO-ERROR.
                    IF AVAILABLE tarefa THEN DO:
                        ASSIGN tarefa.dt-real-ini = apontamento.data.
                    END.

                    RELEASE tarefa NO-ERROR.

                    FIND FIRST tarefa NO-LOCK
                        WHERE tarefa.nome = ENTRY(2, cb-tarefa:SCREEN-VALUE IN FRAME {&FRAME-NAME}, "-")
                        AND   tarefa.sequencia = INT(ENTRY(1, cb-tarefa:SCREEN-VALUE, "-")) NO-ERROR.
                END.
                ELSE
                    RETURN "NOK".
            END.

            IF tarefa.situacao = 1 /* Pendente */
            AND tarefa.num-os <> 0 THEN DO:
                FIND FIRST bf-tar NO-LOCK
                    WHERE bf-tar.responsavel = tarefa.responsavel
                    AND   bf-tar.prioridade < tarefa.prioridade
                    AND   bf-tar.situacao = 1 /* Pendente */
                    AND   bf-tar.num-os <> 0
                    AND   ROWID(bf-tar) <> ROWID(tarefa) NO-ERROR.
                IF AVAIL bf-tar THEN DO:
                    {func\valida.i &Mensagem  = "Apontamento n∆o permitido!"
                                   &Ajuda     = "Existem tarefas mais priorit†rias na sua lista para serem iniciadas. Realize repriorizaá∆o se for o caso."
                                   &Campo     = cb-tarefa}
                END.
            END.
            
            IF tarefa.situacao >= 8 THEN DO:
                {func\valida.i &Mensagem  = "Apontamento n∆o permitido!"
                               &Ajuda     = "A situaá∆o da tarefa n∆o permite a realizaá∆o de apontamentos."
                               &Campo     = cb-tarefa}
            END.

            IF INPUT FRAME {&FRAME-NAME} de-pc-con <= 0 THEN DO:
                {func\valida.i &Mensagem  = "% Conclus∆o incorreto!"
                               &Ajuda     = "Vocà deve informar o percentual de conclus∆o da tarefa."
                               &Campo     = de-pc-con}
            END.
            ELSE DO:
                IF INPUT FRAME {&FRAME-NAME} de-pc-con = tarefa.perc-con THEN DO:
                    {func\valida.i &Mensagem  = "% Conclus∆o invalido!"
                                   &Ajuda     = "Vocà deve informar um percentual de conclus∆o da tarefa diferente que o anterior."
                                   &Campo     = de-pc-con}
                END.
            END.
            
            ASSIGN deQtd = 0.
            FOR EACH bf-apt NO-LOCK
                WHERE bf-apt.nome-tarefa = tarefa.nome
                AND   bf-apt.seq-tarefa = tarefa.sequencia
                AND   ROWID(bf-apt) <> ROWID(apontamento):
                ASSIGN deQtd = deQtd + bf-apt.qt-apontada.
            END.
            IF INPUT FRAME {&FRAME-NAME} apontamento.qt-apontada > (tarefa.qtd-lib - deQtd) THEN DO:
                {func\valida.i &Mensagem  = "Quantidade maior que saldo da tarefa!"
                               &Ajuda     = "Quantidade informada Ç maior que a quantidade de horas restantes da tarefa. Solicite liberaá∆o de mais horas ou abertura de nova tarefa."
                               &Campo     = apontamento.qt-apontada}
            END.
        END.
    END.


END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

