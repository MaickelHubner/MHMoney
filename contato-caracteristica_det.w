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

DEF NEW GLOBAL SHARED VAR gCd-contato LIKE contato.cd-contato.

/* Parameters Definitions ---                                           */

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        contato-caracteristica
&GLOBAL-DEFINE Parent       contato
&GLOBAL-DEFINE ParentField  cd-favorecido
&GLOBAL-DEFINE KeyFields    contato-caracteristica.cd-contato contato-caracteristica.sequencia
&GLOBAL-DEFINE FrameFields  cb-caracteristica contato-caracteristica.descricao
&GLOBAL-DEFINE FrameDisp    contato-caracteristica.cd-favorecido c-ds-favorecido contato-caracteristica.cd-contato contato.nome
                             

/* Local Variable Definitions ---                                       */

DEF VAR c-lista-caracteristica AS CHAR FORMAT "x(300)".


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
&Scoped-Define ENABLED-FIELDS contato-caracteristica.cd-favorecido ~
contato-caracteristica.cd-contato contato.nome ~
contato-caracteristica.sequencia contato-caracteristica.descricao 
&Scoped-define ENABLED-TABLES contato-caracteristica contato
&Scoped-define FIRST-ENABLED-TABLE contato-caracteristica
&Scoped-define SECOND-ENABLED-TABLE contato
&Scoped-Define ENABLED-OBJECTS cb-caracteristica RECT-2 RECT-3 
&Scoped-Define DISPLAYED-FIELDS contato-caracteristica.cd-favorecido ~
contato-caracteristica.cd-contato contato.nome ~
contato-caracteristica.sequencia contato-caracteristica.descricao 
&Scoped-define DISPLAYED-TABLES contato-caracteristica contato
&Scoped-define FIRST-DISPLAYED-TABLE contato-caracteristica
&Scoped-define SECOND-DISPLAYED-TABLE contato
&Scoped-Define DISPLAYED-OBJECTS c-ds-favorecido cb-caracteristica 

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

DEFINE VARIABLE cb-caracteristica AS CHARACTER FORMAT "X(256)":U 
     LABEL "Caracter°stica" 
     VIEW-AS COMBO-BOX INNER-LINES 20
     LIST-ITEM-PAIRS "","0"
     DROP-DOWN-LIST
     SIZE 23 BY 1 NO-UNDO.

DEFINE VARIABLE c-ds-favorecido AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .88 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 3.25.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 79 BY 3.58.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     contato-caracteristica.cd-favorecido AT ROW 1.42 COL 14 COLON-ALIGNED NO-LABEL WIDGET-ID 86
          VIEW-AS FILL-IN 
          SIZE 5 BY .88
     c-ds-favorecido AT ROW 1.42 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     contato-caracteristica.cd-contato AT ROW 2.42 COL 14 COLON-ALIGNED NO-LABEL WIDGET-ID 88
          VIEW-AS FILL-IN 
          SIZE 8.29 BY .88
     btCancel AT ROW 8.63 COL 74.72
     contato.nome AT ROW 2.42 COL 22.29 COLON-ALIGNED NO-LABEL WIDGET-ID 54
          VIEW-AS FILL-IN 
          SIZE 44 BY .88
     contato-caracteristica.sequencia AT ROW 3.42 COL 14 COLON-ALIGNED WIDGET-ID 70
          VIEW-AS FILL-IN 
          SIZE 8.29 BY .88
     btOK AT ROW 8.63 COL 68.57
     cb-caracteristica AT ROW 5 COL 14 COLON-ALIGNED WIDGET-ID 94
     contato-caracteristica.descricao AT ROW 6.25 COL 14 COLON-ALIGNED WIDGET-ID 66
          VIEW-AS FILL-IN 
          SIZE 58.29 BY .88
     "Contato:" VIEW-AS TEXT
          SIZE 6 BY .54 AT ROW 2.58 COL 9.86 WIDGET-ID 90
     "Cliente:" VIEW-AS TEXT
          SIZE 5 BY .54 AT ROW 1.54 COL 10.57 WIDGET-ID 92
     RECT-2 AT ROW 1.25 COL 1.86
     RECT-3 AT ROW 4.67 COL 1.86 WIDGET-ID 58
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80.57 BY 9.58
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
         HEIGHT             = 9.67
         WIDTH              = 80.57
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
/* SETTINGS FOR FILL-IN c-ds-favorecido IN FRAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME cb-caracteristica
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb-caracteristica C-Win
ON ENTRY OF cb-caracteristica IN FRAME DEFAULT-FRAME /* Caracter°stica */
DO:
  {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb-caracteristica C-Win
ON LEAVE OF cb-caracteristica IN FRAME DEFAULT-FRAME /* Caracter°stica */
DO:
  {func\set_leave.i} 
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
  {version.i contato-caracteristica_det}
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

    /* grava a caracteristica selecionada */
    ASSIGN contato-caracteristica.cd-caracteristica = int(INPUT FRAME {&FRAME-NAME} cb-caracteristica).
    
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

ASSIGN contato-caracteristica.cd-contato:SENSITIVE IN FRAME {&FRAME-NAME} = NO
       contato-caracteristica.cd-contato:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string(gCd-contato).

FIND FIRST favorecido NO-LOCK
     WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} contato-caracteristica.cd-favorecido NO-ERROR.
IF AVAIL favorecido THEN
    ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = favorecido.ds-favorecido.
ELSE
    ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".


IF pcActionBT = "ADD" THEN DO:

    FIND LAST bf-contato-caracteristica NO-LOCK
        WHERE bf-contato-caracteristica.cd-favorecido = INPUT FRAME {&FRAME-NAME} contato-caracteristica.cd-favorecido 
          AND bf-contato-caracteristica.cd-contato    = INPUT FRAME {&FRAME-NAME} contato-caracteristica.cd-contato  NO-ERROR.
    IF AVAIL bf-contato-caracteristica THEN
        ASSIGN contato-caracteristica.sequencia:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bf-contato-caracteristica.sequencia + 1).
    ELSE
        ASSIGN contato-caracteristica.sequencia:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(1).
        
END.


/** carregar caracteristicas **/
FOR EACH caracteristica NO-LOCK:    
    ASSIGN c-lista-caracteristica = c-lista-caracteristica + caracteristica.ds-caracteristica + "," + string(caracteristica.cd-caracteristica) + ",".
END.
ASSIGN OVERLAY(c-lista-caracteristica,LENGTH(c-lista-caracteristica),1) = "".
       cb-caracteristica:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = c-lista-caracteristica.
IF pcActionBT = "UPDATE" THEN DO:
    ASSIGN cb-caracteristica:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string(contato-caracteristica.cd-caracteristica).
    
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
  DISPLAY c-ds-favorecido cb-caracteristica 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE contato THEN 
    DISPLAY contato.nome 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE contato-caracteristica THEN 
    DISPLAY contato-caracteristica.cd-favorecido contato-caracteristica.cd-contato 
          contato-caracteristica.sequencia contato-caracteristica.descricao 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE contato-caracteristica.cd-favorecido contato-caracteristica.cd-contato 
         contato.nome contato-caracteristica.sequencia cb-caracteristica 
         contato-caracteristica.descricao RECT-2 RECT-3 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validateRecord C-Win 
PROCEDURE validateRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */

    FIND FIRST bf-contato-caracteristica NO-LOCK
         WHERE bf-contato-caracteristica.cd-favorecido    = INPUT FRAME {&FRAME-NAME} contato-caracteristica.cd-favorecido
           AND bf-contato-caracteristica.cd-contato       = INPUT FRAME {&FRAME-NAME} contato-caracteristica.cd-contato
           AND bf-contato-caracteristica.sequencia        = INPUT FRAME {&FRAME-NAME} contato-caracteristica.sequencia NO-ERROR.
    IF AVAIL bf-contato-caracteristica THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}

    END.    
    
END.
IF pcActionBT = "ADD" OR 
   pcActionBT = "UPDATE" THEN DO:
    IF INPUT FRAME {&FRAME-NAME} cb-caracteristica = "" THEN DO:
        {func\valida.i &Mensagem  = "Caracter°stica n∆o informada!"
                       &Ajuda     = "Vocà deve informar a caracter°stica."
                       &Campo     = cb-caracteristica}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

