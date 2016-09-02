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

/* Pr‚-processadores */
&GLOBAL-DEFINE Table        sub-cat
&GLOBAL-DEFINE Parent       categoria
&GLOBAL-DEFINE ParentField  cod-categoria
&GLOBAL-DEFINE KeyFields    sub-cat.cd-sub
&GLOBAL-DEFINE FrameFields  sub-cat.ds-sub sub-cat.id-tipo ~
                            sub-cat.l-ir sub-cat.tp-ir ~
                            sub-cat.reembolso sub-cat.inflacao ~
                            sub-cat.obriga-num
&GLOBAL-DEFINE FrameDisp    categoria.ds-categoria

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
&Scoped-Define ENABLED-FIELDS sub-cat.obriga-num sub-cat.inflacao ~
sub-cat.reembolso sub-cat.tp-ir sub-cat.cod-categoria sub-cat.cd-sub ~
sub-cat.ds-sub sub-cat.id-tipo sub-cat.l-ir 
&Scoped-define ENABLED-TABLES sub-cat
&Scoped-define FIRST-ENABLED-TABLE sub-cat
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 
&Scoped-Define DISPLAYED-FIELDS sub-cat.obriga-num sub-cat.inflacao ~
sub-cat.reembolso sub-cat.tp-ir sub-cat.cod-categoria ~
categoria.ds-categoria sub-cat.cd-sub sub-cat.ds-sub sub-cat.id-tipo ~
sub-cat.l-ir 
&Scoped-define DISPLAYED-TABLES sub-cat categoria
&Scoped-define FIRST-DISPLAYED-TABLE sub-cat
&Scoped-define SECOND-DISPLAYED-TABLE categoria


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

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 2.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     sub-cat.obriga-num AT ROW 6.75 COL 53 WIDGET-ID 4
          VIEW-AS TOGGLE-BOX
          SIZE 27 BY .83
     sub-cat.inflacao AT ROW 6 COL 53 WIDGET-ID 2
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .83
     sub-cat.reembolso AT ROW 5.25 COL 53
          VIEW-AS TOGGLE-BOX
          SIZE 13 BY .83
     sub-cat.tp-ir AT ROW 7.5 COL 24 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 9999
          LIST-ITEM-PAIRS "Abatimento Sem Limite",0,
                     "Abatimento Educa‡Æo",1,
                     "Imposto Pago",2
          DROP-DOWN-LIST
          SIZE 20 BY 1
     btCancel AT ROW 7.75 COL 74.14
     sub-cat.cod-categoria AT ROW 1.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btOK AT ROW 7.75 COL 68
     categoria.ds-categoria AT ROW 1.5 COL 21.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     sub-cat.cd-sub AT ROW 3.25 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     sub-cat.ds-sub AT ROW 4.25 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     sub-cat.id-tipo AT ROW 5.25 COL 16 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 9999
          LIST-ITEM-PAIRS "Despesa",1,
                     "Custo",2
          DROP-DOWN-LIST
          SIZE 16 BY 1
     sub-cat.l-ir AT ROW 6.25 COL 19
          VIEW-AS TOGGLE-BOX
          SIZE 5 BY .83
     RECT-2 AT ROW 1.25 COL 2
     RECT-3 AT ROW 6.75 COL 18
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 8.79
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
         TITLE              = "Detalhes da Sub-Categoria"
         HEIGHT             = 8.79
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
/* SETTINGS FOR FILL-IN categoria.ds-categoria IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Detalhes da Sub-Categoria */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Detalhes da Sub-Categoria */
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


&Scoped-define SELF-NAME sub-cat.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.cd-sub C-Win
ON ENTRY OF sub-cat.cd-sub IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.cd-sub C-Win
ON LEAVE OF sub-cat.cd-sub IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sub-cat.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.cod-categoria C-Win
ON ENTRY OF sub-cat.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.cod-categoria C-Win
ON LEAVE OF sub-cat.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME categoria.ds-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL categoria.ds-categoria C-Win
ON ENTRY OF categoria.ds-categoria IN FRAME DEFAULT-FRAME /* Descri‡Æo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL categoria.ds-categoria C-Win
ON LEAVE OF categoria.ds-categoria IN FRAME DEFAULT-FRAME /* Descri‡Æo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sub-cat.ds-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.ds-sub C-Win
ON ENTRY OF sub-cat.ds-sub IN FRAME DEFAULT-FRAME /* Descri‡Æo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.ds-sub C-Win
ON LEAVE OF sub-cat.ds-sub IN FRAME DEFAULT-FRAME /* Descri‡Æo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sub-cat.id-tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.id-tipo C-Win
ON ENTRY OF sub-cat.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.id-tipo C-Win
ON LEAVE OF sub-cat.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sub-cat.l-ir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.l-ir C-Win
ON VALUE-CHANGED OF sub-cat.l-ir IN FRAME DEFAULT-FRAME /* IR */
DO:
  
    IF categoria.id-tipo = 2 THEN DO:
        IF INPUT FRAME {&FRAME-NAME} sub-cat.l-ir THEN DO:
            ENABLE sub-cat.tp-ir WITH FRAME {&FRAME-NAME}.
        END.
        ELSE DO:
            DISABLE sub-cat.tp-ir WITH FRAME {&FRAME-NAME}.
        END.
    END.
    ELSE DO:
        DISABLE sub-cat.tp-ir WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sub-cat.tp-ir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.tp-ir C-Win
ON ENTRY OF sub-cat.tp-ir IN FRAME DEFAULT-FRAME /* Tipo IR */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub-cat.tp-ir C-Win
ON LEAVE OF sub-cat.tp-ir IN FRAME DEFAULT-FRAME /* Tipo IR */
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
  {version.i sub-cat_det}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF categoria.id-tipo = 1 THEN DO:
    ASSIGN sub-cat.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = ",0"
           sub-cat.tp-ir:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = ",0".
END.
ELSE DO:
    ASSIGN sub-cat.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Despesa,1,Custo,2"
           sub-cat.tp-ir:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Abatimento Sem Limite,0,Abatimento Educa‡Æo,1,Imposto Pago,2".
    IF pcActionBT = "ADD" THEN DO:
        ASSIGN sub-cat.id-tipo = 1.
    END.
END.

{func\detalhe\display.i}

IF categoria.id-tipo = 1 THEN DO:
    DISABLE sub-cat.id-tipo
            sub-cat.inflacao WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ENABLE sub-cat.id-tipo
           sub-cat.inflacao WITH FRAME {&FRAME-NAME}.
END.

APPLY "VALUE-CHANGED" TO sub-cat.l-ir IN FRAME {&FRAME-NAME}.

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
  IF AVAILABLE categoria THEN 
    DISPLAY categoria.ds-categoria 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE sub-cat THEN 
    DISPLAY sub-cat.obriga-num sub-cat.inflacao sub-cat.reembolso sub-cat.tp-ir 
          sub-cat.cod-categoria sub-cat.cd-sub sub-cat.ds-sub sub-cat.id-tipo 
          sub-cat.l-ir 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE sub-cat.obriga-num sub-cat.inflacao sub-cat.reembolso sub-cat.tp-ir 
         sub-cat.cod-categoria sub-cat.cd-sub sub-cat.ds-sub sub-cat.id-tipo 
         sub-cat.l-ir RECT-2 RECT-3 
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

{func\sugere_cod.i cd-sub}

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
    FIND FIRST bf-sub-cat NO-LOCK
        WHERE bf-sub-cat.cod-categoria        = INPUT FRAME {&FRAME-NAME} sub-cat.cod-categoria
        AND   bf-sub-cat.cd-sub  = INPUT FRAME {&FRAME-NAME} sub-cat.cd-sub
        AND   ROWID(bf-sub-cat) <> ROWID(sub-cat) NO-ERROR.
    IF AVAIL bf-sub-cat THEN DO:
        {func\valida.i &Mensagem  = "Registro j  casdastrado!"
                       &Ajuda     = "Esse registro j  foi cadastrado anteriormente."}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

