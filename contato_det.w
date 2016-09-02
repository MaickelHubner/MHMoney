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
&GLOBAL-DEFINE Table        contato
&GLOBAL-DEFINE Parent       favorecido
&GLOBAL-DEFINE ParentField  cd-favorecido
&GLOBAL-DEFINE KeyFields    contato.cd-contato
&GLOBAL-DEFINE FrameFields  contato.nome contato.cargo contato.data-nasc ~
                            contato.email contato.telefone contato.celular ~
                            contato.nome-apelido contato.ds-observacao ~
                            contato.ativo contato.mensageiro ~
                            contato.area-empresa
&GLOBAL-DEFINE FrameDisp    contato.cd-favorecido favorecido.ds-favorecido
                             

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.



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
&Scoped-Define ENABLED-FIELDS contato.ds-observacao contato.cd-favorecido ~
favorecido.ds-favorecido contato.cd-contato contato.nome contato.ativo ~
contato.cargo contato.data-nasc contato.email contato.telefone ~
contato.celular contato.nome-apelido contato.area-empresa ~
contato.mensageiro 
&Scoped-define ENABLED-TABLES contato favorecido
&Scoped-define FIRST-ENABLED-TABLE contato
&Scoped-define SECOND-ENABLED-TABLE favorecido
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 IMAGE-1 
&Scoped-Define DISPLAYED-FIELDS contato.ds-observacao contato.cd-favorecido ~
favorecido.ds-favorecido contato.cd-contato contato.nome contato.ativo ~
contato.cargo contato.data-nasc contato.email contato.telefone ~
contato.celular contato.nome-apelido contato.area-empresa ~
contato.mensageiro 
&Scoped-define DISPLAYED-TABLES contato favorecido
&Scoped-define FIRST-DISPLAYED-TABLE contato
&Scoped-define SECOND-DISPLAYED-TABLE favorecido


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

DEFINE IMAGE IMAGE-1
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 19 BY 5.75.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 2.5.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 10.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     contato.ds-observacao AT ROW 14.25 COL 2 NO-LABEL WIDGET-ID 76
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 79 BY 5.5
     contato.cd-favorecido AT ROW 1.5 COL 14 COLON-ALIGNED NO-LABEL WIDGET-ID 64
          VIEW-AS FILL-IN 
          SIZE 5 BY .88
     favorecido.ds-favorecido AT ROW 1.5 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 62
          VIEW-AS FILL-IN 
          SIZE 40 BY .88
     btCancel AT ROW 20 COL 75.14
     contato.cd-contato AT ROW 2.5 COL 14 COLON-ALIGNED NO-LABEL WIDGET-ID 46
          VIEW-AS FILL-IN 
          SIZE 8.29 BY .88
     contato.nome AT ROW 2.5 COL 22.29 COLON-ALIGNED NO-LABEL WIDGET-ID 54
          VIEW-AS FILL-IN 
          SIZE 44 BY .88
     contato.ativo AT ROW 1.5 COL 72 WIDGET-ID 86
          VIEW-AS TOGGLE-BOX
          SIZE 7 BY .83
     contato.cargo AT ROW 4.25 COL 14 COLON-ALIGNED WIDGET-ID 44
          VIEW-AS FILL-IN 
          SIZE 29.72 BY .88
     contato.data-nasc AT ROW 5.25 COL 14 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN 
          SIZE 11 BY .88
     btOK AT ROW 20 COL 69
     contato.email AT ROW 6.25 COL 14 COLON-ALIGNED WIDGET-ID 52
          VIEW-AS FILL-IN 
          SIZE 36 BY .88
     contato.telefone AT ROW 7.25 COL 14 COLON-ALIGNED WIDGET-ID 56
          VIEW-AS FILL-IN 
          SIZE 15.43 BY .88
     contato.celular AT ROW 8.25 COL 14 COLON-ALIGNED WIDGET-ID 70
          VIEW-AS FILL-IN 
          SIZE 15.43 BY .88
     contato.nome-apelido AT ROW 9.25 COL 14 COLON-ALIGNED WIDGET-ID 72
          VIEW-AS FILL-IN 
          SIZE 15.43 BY .88
     contato.area-empresa AT ROW 10.25 COL 14 COLON-ALIGNED WIDGET-ID 78
          VIEW-AS FILL-IN 
          SIZE 44 BY .88
     contato.mensageiro AT ROW 11.25 COL 16 NO-LABEL WIDGET-ID 82
          VIEW-AS EDITOR
          SIZE 63 BY 1.75
     "Cliente:" VIEW-AS TEXT
          SIZE 5 BY .54 AT ROW 1.67 COL 10.72 WIDGET-ID 66
     "Contato:" VIEW-AS TEXT
          SIZE 6 BY .54 AT ROW 2.67 COL 10 WIDGET-ID 68
     "Mensageiro:" VIEW-AS TEXT
          SIZE 8.72 BY .54 AT ROW 11.33 COL 7.29 WIDGET-ID 84
     RECT-2 AT ROW 1.25 COL 1.86
     RECT-3 AT ROW 3.5 COL 2 WIDGET-ID 58
     IMAGE-1 AT ROW 4.25 COL 60 WIDGET-ID 74
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.72 BY 20.92
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
         HEIGHT             = 20.92
         WIDTH              = 80.72
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
       contato.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

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


&Scoped-define SELF-NAME IMAGE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF IMAGE-1 IN FRAME DEFAULT-FRAME
DO:
    RUN pesqFoto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

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
  {version.i contato_det}
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
    
    ASSIGN contato.foto = cImagem.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE dispFoto C-Win 
PROCEDURE dispFoto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF cImagem <> "" THEN
        image-1:LOAD-IMAGE(cImagem) IN FRAME {&FRAME-NAME}.
    ELSE
        image-1:LOAD-IMAGE("image\im-naodisp.bmp") IN FRAME {&FRAME-NAME}.

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

    FIND LAST bf-contato NO-LOCK
        WHERE bf-contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} contato.cd-favorecido NO-ERROR.
    IF AVAIL bf-contato THEN
        ASSIGN contato.cd-contato:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bf-contato.cd-contato + 1).
    ELSE
        ASSIGN contato.cd-contato:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(1).

    /*ASSIGN contato.ativo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Sim".*/
        
END.

ASSIGN cImagem = contato.foto.

RUN dispFoto IN THIS-PROCEDURE.

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
  IF AVAILABLE contato THEN 
    DISPLAY contato.ds-observacao contato.cd-favorecido contato.cd-contato 
          contato.nome contato.ativo contato.cargo contato.data-nasc 
          contato.email contato.telefone contato.celular contato.nome-apelido 
          contato.area-empresa contato.mensageiro 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.ds-favorecido 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE contato.ds-observacao contato.cd-favorecido favorecido.ds-favorecido 
         contato.cd-contato contato.nome contato.ativo contato.cargo 
         contato.data-nasc contato.email contato.telefone contato.celular 
         contato.nome-apelido contato.area-empresa contato.mensageiro RECT-2 
         RECT-3 IMAGE-1 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pesqFoto C-Win 
PROCEDURE pesqFoto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE procname AS CHARACTER   NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN procname = "".

    SYSTEM-DIALOG GET-FILE procname
          TITLE      "Imagens"
          FILTERS    "Imagens"   "*.bmp;*.gif;*.jpg;*.jpeg",
                     "Todos os Arquivos"      "*.*"
          INITIAL-DIR cDiretorio
          MUST-EXIST
          USE-FILENAME
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:
        ASSIGN cDiretorio = SUBSTRING(procname,1,INDEX(procname,ENTRY(NUM-ENTRIES(procname,"\"),procname,"\")))
               cImagem = procname.
    END.

    RUN dispFoto IN THIS-PROCEDURE.

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
    FIND FIRST bf-contato NO-LOCK
         WHERE bf-contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} contato.cd-favorecido 
           AND bf-contato.cd-contato    = INPUT FRAME {&FRAME-NAME} contato.cd-contato NO-ERROR.
    IF AVAIL bf-contato THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}

    END.
    
    FIND FIRST bf-contato NO-LOCK
         WHERE bf-contato.cd-favorecido = INPUT FRAME {&FRAME-NAME} contato.cd-favorecido 
           AND bf-contato.nome          = INPUT FRAME {&FRAME-NAME} contato.nome NO-ERROR.
    IF AVAIL bf-contato THEN DO:
        {func\valida.i &Mensagem  = "Contato j† casdastrado!"
                       &Ajuda     = "J† existe um contato com esse nome para o cliente. Verifique se o mesmo n∆o se encontra inativo."
                       &Campo     = contato.nome}

    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

