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
&GLOBAL-DEFINE Table        atendimento
&GLOBAL-DEFINE Parent       favorecido
&GLOBAL-DEFINE ParentField  cd-favorecido
&GLOBAL-DEFINE KeyFields    atendimento.data atendimento.hora
&GLOBAL-DEFINE FrameFields  atendimento.contato atendimento.observacao ~
                            atendimento.usuario                                                        
&GLOBAL-DEFINE FrameDisp    atendimento.cd-favorecido favorecido.ds-favorecido 
                            
                             

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE giNome      AS CHARACTER   NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.

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
&Scoped-Define ENABLED-FIELDS atendimento.cd-favorecido ~
favorecido.ds-favorecido atendimento.data atendimento.hora ~
atendimento.contato atendimento.observacao 
&Scoped-define ENABLED-TABLES atendimento favorecido
&Scoped-define FIRST-ENABLED-TABLE atendimento
&Scoped-define SECOND-ENABLED-TABLE favorecido
&Scoped-Define ENABLED-OBJECTS cb-tarefa RECT-2 IMAGE-1 
&Scoped-Define DISPLAYED-FIELDS atendimento.usuario ~
atendimento.cd-favorecido favorecido.ds-favorecido atendimento.data ~
atendimento.hora atendimento.contato atendimento.observacao 
&Scoped-define DISPLAYED-TABLES atendimento favorecido
&Scoped-define FIRST-DISPLAYED-TABLE atendimento
&Scoped-define SECOND-DISPLAYED-TABLE favorecido
&Scoped-Define DISPLAYED-OBJECTS cb-tarefa 

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
     SIZE 63 BY 1 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 19 BY 5.75.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 12.58.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     atendimento.usuario AT ROW 1.5 COL 14 COLON-ALIGNED WIDGET-ID 94
          VIEW-AS FILL-IN 
          SIZE 15.43 BY .88
     btCancel AT ROW 13.75 COL 74.86
     atendimento.cd-favorecido AT ROW 2.5 COL 14 COLON-ALIGNED WIDGET-ID 68
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 5 BY .88
     favorecido.ds-favorecido AT ROW 2.5 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 66
          VIEW-AS FILL-IN 
          SIZE 37 BY .88
     atendimento.data AT ROW 3.5 COL 14 COLON-ALIGNED WIDGET-ID 72
          VIEW-AS FILL-IN 
          SIZE 11 BY .88
     atendimento.hora AT ROW 4.5 COL 14 COLON-ALIGNED WIDGET-ID 74
          VIEW-AS FILL-IN 
          SIZE 6 BY .88
     atendimento.contato AT ROW 6.25 COL 14 COLON-ALIGNED WIDGET-ID 70
          VIEW-AS FILL-IN 
          SIZE 42 BY .88
     btOK AT ROW 13.75 COL 69
     cb-tarefa AT ROW 7.75 COL 14 COLON-ALIGNED WIDGET-ID 96
     atendimento.observacao AT ROW 9 COL 3 NO-LABEL WIDGET-ID 76
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 76 BY 4.25
     RECT-2 AT ROW 1.17 COL 1.86
     IMAGE-1 AT ROW 1.5 COL 61 WIDGET-ID 98
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.57 BY 23.54
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
         HEIGHT             = 14.67
         WIDTH              = 80.43
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 195.14
         VIRTUAL-HEIGHT     = 30.04
         VIRTUAL-WIDTH      = 195.14
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
/* SETTINGS FOR FILL-IN atendimento.cd-favorecido IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN atendimento.usuario IN FRAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME DEFAULT-FRAME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL DEFAULT-FRAME C-Win
ON END-ERROR OF FRAME DEFAULT-FRAME
DO:    
  {func\bt_cad_cancel.i}
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


&Scoped-define SELF-NAME atendimento.contato
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL atendimento.contato C-Win
ON LEAVE OF atendimento.contato IN FRAME DEFAULT-FRAME /* Contato */
DO:
                 
    FIND FIRST contato NO-LOCK
        WHERE contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido
        AND   contato.nome = INPUT FRAME {&FRAME-NAME} atendimento.contato NO-ERROR.
    IF AVAIL contato THEN DO:
        IF contato.foto <> "" THEN
            image-1:LOAD-IMAGE(contato.foto) IN FRAME {&FRAME-NAME}.
        ELSE
            image-1:LOAD-IMAGE("image\im-naodisp.bmp") IN FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        image-1:LOAD-IMAGE("image\im-naodisp.bmp") IN FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL atendimento.contato C-Win
ON MOUSE-SELECT-DBLCLICK OF atendimento.contato IN FRAME DEFAULT-FRAME /* Contato */
OR F5 OF {&Table}.contato DO:
    {func\zoom.i &Tabela="contato"
                 &Campo1="nome"
                 &Tela1="atendimento.contato"
                 &CampoFiltro1="cd-favorecido"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido"
                 &CampoFiltro2="ativo"
                 &ValorFiltro2="'Sim'"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME atendimento.hora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL atendimento.hora C-Win
ON LEAVE OF atendimento.hora IN FRAME DEFAULT-FRAME /* Hora */
DO:
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.
    IF NOT INPUT FRAME {&FRAME-NAME} atendimento.hora MATCHES("*:*") THEN DO:
        ASSIGN cAux = SUBSTRING(atendimento.hora:SCREEN-VALUE,1,2) + ":" + SUBSTRING(atendimento.hora:SCREEN-VALUE,3,2)
               atendimento.hora:SCREEN-VALUE = cAux.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME IMAGE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF IMAGE-1 IN FRAME DEFAULT-FRAME
DO:
    RUN pesqFoto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME atendimento.usuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL atendimento.usuario C-Win
ON LEAVE OF atendimento.usuario IN FRAME DEFAULT-FRAME /* Usu†rio */
DO:
    DEFINE VARIABLE cLista AS CHARACTER   NO-UNDO INITIAL ",0-".
  
    IF atendimento.sequencia <> 0 THEN DO:
        FIND FIRST tarefa NO-LOCK
            WHERE tarefa.sequencia = atendimento.sequencia
            AND   tarefa.nome = atendimento.nome NO-ERROR.
        IF AVAIL tarefa THEN
            ASSIGN cLista = cLista + "," + tarefa.ds-tarefa + "," + STRING(tarefa.sequencia) + "-" + tarefa.nome.
    END.

    FOR EACH tarefa NO-LOCK
        WHERE tarefa.cd-favorecido = INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido
        AND   tarefa.responsavel = INPUT FRAME {&FRAME-NAME} atendimento.usuario
        AND   tarefa.situacao <= 2 /* Em Andamento */:

        ASSIGN cLista = cLista + "," + tarefa.ds-tarefa + "," + STRING(tarefa.sequencia) + "-" + tarefa.nome.

    END.

    ASSIGN cb-tarefa:LIST-ITEM-PAIRS = cLista.

    IF atendimento.sequencia <> 0 THEN DO:
        ASSIGN cb-tarefa = STRING(atendimento.sequencia) + "-" + atendimento.nome.
        DISP cb-tarefa
            WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\calendar.i atendimento.data}

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
  {version.i atendimento_det}
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
    
    FIND FIRST contato NO-LOCK
        WHERE contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido
        AND contato.nome            = INPUT FRAME {&FRAME-NAME} atendimento.contato NO-ERROR.
    IF AVAIL contato THEN DO:
        ASSIGN atendimento.cd-contato = contato.cd-contato.
    END.

    ASSIGN atendimento.nome = ENTRY(2, cb-tarefa:SCREEN-VALUE, "-")
           atendimento.sequencia = INT(ENTRY(1, cb-tarefa:SCREEN-VALUE, "-"))
           giNome = ""
           giSequencia = 0.

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

IF pcActionBT = "ADD" THEN DO:
    ASSIGN atendimento.data:SCREEN-VALUE IN FRAME {&FRAME-NAME}    = STRING(TODAY)   
           atendimento.hora:SCREEN-VALUE IN FRAME {&FRAME-NAME}    = STRING(TIME,"hh:mm")
           atendimento.usuario:SCREEN-VALUE IN FRAME {&FRAME-NAME} = gcUsuario.
    IF giNome <> "" 
    AND giSequencia <> 0 THEN DO:
        ASSIGN atendimento.nome = giNome
               atendimento.sequencia = giSequencia.
        DISABLE cb-tarefa
            WITH FRAME {&FRAME-NAME}.
    END.
END.

APPLY "LEAVE" TO atendimento.usuario.

APPLY "LEAVE" TO atendimento.contato.

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
  DISPLAY cb-tarefa 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE atendimento THEN 
    DISPLAY atendimento.usuario atendimento.cd-favorecido atendimento.data 
          atendimento.hora atendimento.contato atendimento.observacao 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.ds-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE atendimento.cd-favorecido favorecido.ds-favorecido atendimento.data 
         atendimento.hora atendimento.contato cb-tarefa atendimento.observacao 
         RECT-2 IMAGE-1 
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
    
{func\cursor.i atendimento.contato}

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
    FIND FIRST bf-atendimento NO-LOCK
         WHERE bf-atendimento.cd-favorecido = INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido 
           AND bf-atendimento.data          = INPUT FRAME {&FRAME-NAME} atendimento.data
           AND bf-atendimento.hora          = INPUT FRAME {&FRAME-NAME} atendimento.hora NO-ERROR.
    IF AVAIL bf-atendimento THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}

    END.

    IF INPUT FRAME {&FRAME-NAME} atendimento.data = "" OR 
       INPUT FRAME {&FRAME-NAME} atendimento.data = ? THEN DO:
        {func\valida.i &Mensagem  = "Data de atendimento n∆o informada!"
                       &Ajuda     = "Vocà deve informar a data de atendimento."
                       &Campo     = atendimento.data}
    END.
    /* comentado por AndrÇ. solicitado por Vitor em 26/09/2012
    IF INPUT FRAME {&FRAME-NAME} atendimento.data > TODAY THEN DO:
        {func\valida.i &Mensagem  = "Data de atendimento incorreta!"
                       &Ajuda     = "Data de atendimento maior que a data de hoje."
                       &Campo     = atendimento.data}
    END.
    */
                  
    IF INPUT FRAME {&FRAME-NAME} atendimento.hora = "" THEN DO:
        {func\valida.i &Mensagem  = "Hora de atendimento n∆o informada!"
                       &Ajuda     = "Vocà deve informar a hora de atendimento."
                       &Campo     = atendimento.hora}
    END.

    IF INPUT FRAME {&FRAME-NAME} atendimento.contato <> "" THEN DO:
        IF NOT CAN-FIND(FIRST contato NO-LOCK
                        WHERE contato.nome          = INPUT FRAME {&FRAME-NAME} atendimento.contato) THEN DO: 
            {func\valida.i &Mensagem  = "Contato incorreto!"
                           &Ajuda     = "Contato informado n∆o existente."
                           &Campo     = atendimento.contato}
        END.
        IF NOT CAN-FIND(FIRST contato NO-LOCK
                        WHERE contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido
                          AND contato.nome          = INPUT FRAME {&FRAME-NAME} atendimento.contato) THEN DO:    
            {func\valida.i &Mensagem  = "Contato incorreto!"
                           &Ajuda     = "Contato informado n∆o cadastrado para o favorecido."
                           &Campo     = atendimento.contato}
        END.
    END.
    

END.
IF pcActionBT = "UPDATE" THEN DO:

    IF INPUT FRAME {&FRAME-NAME} atendimento.contato <> "" AND atendimento.cd-contato = 0 THEN DO:
        IF NOT CAN-FIND(FIRST contato NO-LOCK
                        WHERE contato.nome          = INPUT FRAME {&FRAME-NAME} atendimento.contato) THEN DO: 
            {func\valida.i &Mensagem  = "Contato incorreto!"
                           &Ajuda     = "Contato informado n∆o existente."
                           &Campo     = atendimento.contato}
        END.
        IF NOT CAN-FIND(FIRST contato NO-LOCK
                        WHERE contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} atendimento.cd-favorecido
                          AND contato.nome          = INPUT FRAME {&FRAME-NAME} atendimento.contato) THEN DO:    
            {func\valida.i &Mensagem  = "Contato incorreto!"
                           &Ajuda     = "Contato informado n∆o cadastrado para o favorecido."
                           &Campo     = atendimento.contato}
        END.
    END.
    
END.


RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

