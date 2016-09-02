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
&GLOBAL-DEFINE Table        mov-bens
&GLOBAL-DEFINE Parent       mov-conta
&GLOBAL-DEFINE ParentField  cd-conta
&GLOBAL-DEFINE KeyFields    mov-bens.cd-bens
&GLOBAL-DEFINE FrameFields  mov-bens.id-tipo mov-bens.val-consumo ~
                            mov-bens.val-medida
&GLOBAL-DEFINE FrameDisp    mov-conta.cd-sequencia

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
&Scoped-Define ENABLED-FIELDS mov-bens.cd-conta mov-bens.cd-bens ~
mov-bens.id-tipo mov-bens.val-consumo mov-bens.val-medida 
&Scoped-define ENABLED-TABLES mov-bens
&Scoped-define FIRST-ENABLED-TABLE mov-bens
&Scoped-Define ENABLED-OBJECTS desc-con des-bem desc-med desc-media RECT-14 ~
RECT-2 
&Scoped-Define DISPLAYED-FIELDS mov-bens.cd-conta mov-conta.cd-sequencia ~
mov-bens.cd-bens conta.ds-conta mov-bens.id-tipo mov-bens.val-consumo ~
mov-bens.val-medida 
&Scoped-define DISPLAYED-TABLES mov-bens mov-conta conta
&Scoped-define FIRST-DISPLAYED-TABLE mov-bens
&Scoped-define SECOND-DISPLAYED-TABLE mov-conta
&Scoped-define THIRD-DISPLAYED-TABLE conta
&Scoped-Define DISPLAYED-OBJECTS val-media desc-con des-bem desc-med ~
desc-media 

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

DEFINE VARIABLE des-bem AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY .79 NO-UNDO.

DEFINE VARIABLE desc-con AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17 BY .67 NO-UNDO.

DEFINE VARIABLE desc-med AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17 BY .67 NO-UNDO.

DEFINE VARIABLE desc-media AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17 BY .67 NO-UNDO.

DEFINE VARIABLE val-media AS DECIMAL FORMAT "->>>>,>>9.99":U INITIAL 0 
     LABEL "MÇdia" 
     VIEW-AS FILL-IN 
     SIZE 11.14 BY .79
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 48 BY 4.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     val-media AT ROW 8 COL 30 COLON-ALIGNED
     desc-con AT ROW 6 COL 42 COLON-ALIGNED NO-LABEL
     des-bem AT ROW 3.25 COL 20.29 COLON-ALIGNED NO-LABEL
     btCancel AT ROW 8 COL 74.14
     mov-bens.cd-conta AT ROW 1.5 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     btOK AT ROW 8 COL 68
     mov-conta.cd-sequencia AT ROW 1.5 COL 61.57 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     mov-bens.cd-bens AT ROW 3.25 COL 16 COLON-ALIGNED
          LABEL "Bem"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     conta.ds-conta AT ROW 1.5 COL 19.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .79
     mov-bens.id-tipo AT ROW 4.25 COL 16 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 6
          LIST-ITEM-PAIRS "Aquisiá∆o",1,
                     "Valor Agregado",2,
                     "Manutená∆o",3,
                     "Despesa",4,
                     "Consumo",5,
                     "Venda",6
          DROP-DOWN-LIST
          SIZE 23 BY 1
     mov-bens.val-consumo AT ROW 6 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     mov-bens.val-medida AT ROW 7 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     desc-med AT ROW 7 COL 42 COLON-ALIGNED NO-LABEL
     desc-media AT ROW 8 COL 42 COLON-ALIGNED NO-LABEL
     RECT-14 AT ROW 5.5 COL 18
     RECT-2 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 8.92
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
         HEIGHT             = 8.92
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
/* SETTINGS FOR FILL-IN mov-bens.cd-bens IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN conta.ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN val-media IN FRAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME mov-bens.cd-bens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.cd-bens C-Win
ON ENTRY OF mov-bens.cd-bens IN FRAME DEFAULT-FRAME /* Bem */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.cd-bens C-Win
ON LEAVE OF mov-bens.cd-bens IN FRAME DEFAULT-FRAME /* Bem */
DO:

    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.

    {func\leave.i &Tabela="bens"
                  &Campo="cd-bens"
                  &CampoProc = "ds-bens"
                  &Tela="des-bem"
                  &CampoProc2 = "un-medida"
                  &Tela2="desc-med"
                  &CampoProc3 = "un-consumo"
                  &Tela3="desc-con"}
                  
    IF desc-med:SCREEN-VALUE <> "" THEN
        ASSIGN cTemp = desc-med:SCREEN-VALUE.
    ELSE
        ASSIGN cTemp = "Medida".

    ASSIGN cTemp = cTemp + "/".

    IF desc-con:SCREEN-VALUE <> "" THEN
        ASSIGN cTemp = cTemp + desc-con:SCREEN-VALUE.
    ELSE
        ASSIGN cTemp = cTemp + "Consumo".

    ASSIGN desc-media:SCREEN-VALUE = cTemp.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.cd-bens C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-bens.cd-bens IN FRAME DEFAULT-FRAME /* Bem */
OR F5 OF {&Table}.cd-bens DO:
    {func\zoom.i &Tabela="bens"
                 &Campo1="cd-bens"
                 &Tela1="mov-bens.cd-bens"
                 &Campo2="ds-bens"
                 &Tela2="des-bem"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des-bem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des-bem C-Win
ON ENTRY OF des-bem IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des-bem C-Win
ON LEAVE OF des-bem IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-bens.id-tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.id-tipo C-Win
ON ENTRY OF mov-bens.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.id-tipo C-Win
ON LEAVE OF mov-bens.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.id-tipo C-Win
ON VALUE-CHANGED OF mov-bens.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} mov-bens.id-tipo = 5 THEN DO:
        ENABLE mov-bens.val-consumo
               mov-bens.val-medida WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE mov-bens.val-consumo
                mov-bens.val-medida WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-bens.val-consumo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.val-consumo C-Win
ON ENTRY OF mov-bens.val-consumo IN FRAME DEFAULT-FRAME /* Consumo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.val-consumo C-Win
ON LEAVE OF mov-bens.val-consumo IN FRAME DEFAULT-FRAME /* Consumo */
DO:
  
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} mov-bens.val-consumo <> 0 THEN DO:
        ASSIGN val-media = INPUT FRAME {&FRAME-NAME} mov-bens.val-medida /
                           INPUT FRAME {&FRAME-NAME} mov-bens.val-consumo.
    END.
    ELSE DO:
        ASSIGN val-media = 0.
    END.

    DISPLAY val-media WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME val-media
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL val-media C-Win
ON ENTRY OF val-media IN FRAME DEFAULT-FRAME /* MÇdia */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL val-media C-Win
ON LEAVE OF val-media IN FRAME DEFAULT-FRAME /* MÇdia */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-bens.val-medida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.val-medida C-Win
ON ENTRY OF mov-bens.val-medida IN FRAME DEFAULT-FRAME /* Medida */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-bens.val-medida C-Win
ON LEAVE OF mov-bens.val-medida IN FRAME DEFAULT-FRAME /* Medida */
DO:
  
    {func\set_leave.i}  
    APPLY "LEAVE" TO mov-bens.val-consumo IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-bem
                          &FOREACH = "bens WHERE bens.dt-venda = ? BY bens.ds-bens"
                          &CAMPO = bens.ds-bens
                          &ObjPai = mov-bens.cd-bens}

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
  {version.i mov-bens_det}
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

ASSIGN mov-bens.cd-sequencia = mov-conta.cd-sequencia.

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
FIND FIRST conta OF mov-bens NO-LOCK NO-ERROR.
IF AVAIL conta THEN DO:
    DISPLAY conta.ds-conta WITH FRAME {&FRAME-NAME}.
END.

IF pcActionBT = "ADD" THEN DO:
    ASSIGN mov-bens.id-tipo = 1.
END.

{func\detalhe\display.i}

APPLY "LEAVE" TO mov-bens.cd-bens IN FRAME {&FRAME-NAME}.
APPLY "VALUE-CHANGED" TO mov-bens.id-tipo IN FRAME {&FRAME-NAME}.
APPLY "LEAVE" TO mov-bens.val-consumo IN FRAME {&FRAME-NAME}.

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
  DISPLAY val-media desc-con des-bem desc-med desc-media 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE conta THEN 
    DISPLAY conta.ds-conta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE mov-bens THEN 
    DISPLAY mov-bens.cd-conta mov-bens.cd-bens mov-bens.id-tipo 
          mov-bens.val-consumo mov-bens.val-medida 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE mov-conta THEN 
    DISPLAY mov-conta.cd-sequencia 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE desc-con des-bem mov-bens.cd-conta mov-bens.cd-bens mov-bens.id-tipo 
         mov-bens.val-consumo mov-bens.val-medida desc-med desc-media RECT-14 
         RECT-2 
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

{func\cursor.i mov-bens.cd-bens}

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

IF cObject = "des-bem" THEN DO:
    FIND FIRST bens NO-LOCK
        WHERE bens.ds-bens = INPUT FRAME {&FRAME-NAME} des-bem NO-ERROR.
    IF AVAIL bens THEN DO:
        ASSIGN mov-bens.cd-bens:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bens.cd-bens).
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

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-mov-bens NO-LOCK
        WHERE bf-mov-bens.cd-conta = INPUT FRAME {&FRAME-NAME} mov-bens.cd-conta
        AND   bf-mov-bens.cd-sequencia  = INPUT FRAME {&FRAME-NAME} mov-conta.cd-sequencia
        AND   bf-mov-bens.cd-bens  = INPUT FRAME {&FRAME-NAME} mov-bens.cd-bens
        AND   ROWID(bf-mov-bens) <> ROWID(mov-bens) NO-ERROR.
    IF AVAIL bf-mov-bens THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

FIND FIRST bens NO-LOCK
    WHERE bens.cd-bens = INPUT FRAME {&FRAME-NAME} mov-bens.cd-bens NO-ERROR.
IF NOT AVAIL bens THEN DO:
    {func\valida.i &Mensagem  = "Bem inexistente!"
                   &Ajuda     = "O bem informado n∆o est† cadastrado."
                   &Campo     = mov-bens.cd-bens}
END.

IF INPUT FRAME {&FRAME-NAME} mov-bens.id-tipo = 5 /* Consumo */
AND NOT bens.controla-consumo THEN DO:

    {func\valida.i &Mensagem  = "Tipo inv†lido!"
                   &Ajuda     = "O bem informado n∆o tem controle de consumo."
                   &Campo     = mov-bens.id-tipo}

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

