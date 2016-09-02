&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

DEF NEW GLOBAL SHARED VAR gNomeUsuario LIKE usuario.nome.
DEF NEW GLOBAL SHARED VAR gPeriodo     LIKE custo.periodo.

{func\data.i}
{func\definitions.i}
{winalert.i}

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-usuario

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES custo

/* Definitions for BROWSE br-usuario                                    */
&Scoped-define FIELDS-IN-QUERY-br-usuario custo.periodo custo.nome custo.qt-horas custo.valor custo.val-custo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-usuario   
&Scoped-define SELF-NAME br-usuario
&Scoped-define OPEN-QUERY-br-usuario DEF VAR i-cont AS INT. ASSIGN de-media = 0        i-cont = 0. IF INPUT FRAME {&FRAME-NAME} cb-tipo-consulta = 1 /* Periodo */ THEN DO:     FOR EACH custo no-lock         WHERE custo.nome = INPUT FRAME {&FRAME-NAME} c-nome         AND custo.periodo >= INPUT FRAME {&FRAME-NAME} c-periodo-ini         AND custo.periodo <= INPUT FRAME {&FRAME-NAME} c-periodo-end:         ASSIGN de-media = de-media + custo.val-custo                i-cont = i-cont + 1.     END. END. ELSE DO:     FOR EACH custo no-lock         WHERE custo.periodo = INPUT FRAME {&FRAME-NAME} c-periodo:         ASSIGN de-media = de-media + custo.val-custo                i-cont = i-cont + 1.     END. END. ASSIGN de-media = de-media / i-cont. DISP de-media     WITH FRAME {&FRAME-NAME}.  OPEN QUERY {&SELF-NAME} FOR EACH custo       WHERE (IF INPUT FRAME {&FRAME-NAME} cb-tipo-consulta = 1 THEN           (custo.nome = INPUT FRAME {&FRAME-NAME} c-nome AND            custo.periodo >= INPUT FRAME {&FRAME-NAME} c-periodo-ini AND            custo.periodo <= INPUT FRAME {&FRAME-NAME} c-periodo-end) ELSE           (custo.periodo = INPUT FRAME {&FRAME-NAME} c-periodo)) NO-LOCK     BY custo.periodo DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-usuario custo
&Scoped-define FIRST-TABLE-IN-QUERY-br-usuario custo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-usuario}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btQtHr c-nome c-periodo-ini c-periodo-end ~
cb-tipo-consulta c-periodo btValor btExit IMAGE-1 RECT-20 IMAGE-7 IMAGE-2 ~
br-usuario RECT-21 
&Scoped-Define DISPLAYED-OBJECTS de-media c-nome c-ds-favorecido ~
c-periodo-ini c-periodo-end cb-tipo-consulta c-periodo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btQtHr 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Valor" 
     SIZE 6.14 BY 1.79 TOOLTIP "Alterar Qtd Horas do Per¡odo".

DEFINE BUTTON btValor 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Valor" 
     SIZE 6.14 BY 1.79 TOOLTIP "Calcular Custos".

DEFINE VARIABLE cb-tipo-consulta AS INTEGER FORMAT "9":U INITIAL 2 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Usu rio",1,
                     "Periodo",2
     DROP-DOWN-LIST
     SIZE 14 BY .88 NO-UNDO.

DEFINE VARIABLE c-ds-favorecido AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .88 NO-UNDO.

DEFINE VARIABLE c-nome AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .88 NO-UNDO.

DEFINE VARIABLE c-periodo AS CHARACTER FORMAT "X(6)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .88 NO-UNDO.

DEFINE VARIABLE c-periodo-end AS CHARACTER FORMAT "X(6)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .88 NO-UNDO.

DEFINE VARIABLE c-periodo-ini AS CHARACTER FORMAT "X(6)":U 
     LABEL "Periodo" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .88 NO-UNDO.

DEFINE VARIABLE de-media AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Custo M‚dio" 
     VIEW-AS FILL-IN 
     SIZE 13.86 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 21 BY 8.5.

DEFINE IMAGE IMAGE-2
     FILENAME "image/im-fled.bmp":U
     SIZE 6 BY 1.54.

DEFINE IMAGE IMAGE-7
     FILENAME "image/im-flee.bmp":U
     SIZE 6 BY 1.54.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 92 BY 2.92.

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 92 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-usuario FOR 
      custo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-usuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-usuario C-Win _FREEFORM
  QUERY br-usuario NO-LOCK DISPLAY
      custo.periodo FORMAT "x(6)":U WIDTH 12
      custo.nome FORMAT "X(8)":U WIDTH 12
      custo.qt-horas COLUMN-LABEL "Hrs" FORMAT "->>,>>9.99":U WIDTH 15
      custo.valor COLUMN-LABEL "$" FORMAT "->>,>>9.99":U WIDTH 15
      custo.val-custo FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 68 BY 10.25
         FONT 4
         TITLE "Custos" TOOLTIP "Custos".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btQtHr AT ROW 1.5 COL 3 WIDGET-ID 58
     de-media AT ROW 16 COL 78 COLON-ALIGNED WIDGET-ID 60
     c-nome AT ROW 4.17 COL 17.29 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     c-ds-favorecido AT ROW 4.17 COL 27.29 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     c-periodo-ini AT ROW 5.38 COL 17.29 COLON-ALIGNED WIDGET-ID 24
     c-periodo-end AT ROW 5.38 COL 38.29 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     cb-tipo-consulta AT ROW 4.17 COL 3.29 NO-LABEL WIDGET-ID 8
     c-periodo AT ROW 4.17 COL 17.29 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     btValor AT ROW 4.25 COL 87 WIDGET-ID 48
     btExit AT ROW 1.5 COL 87 WIDGET-ID 42
     br-usuario AT ROW 7 COL 2 WIDGET-ID 200
     IMAGE-1 AT ROW 7 COL 72 WIDGET-ID 16
     RECT-20 AT ROW 3.75 COL 2 WIDGET-ID 56
     IMAGE-7 AT ROW 4.96 COL 30.29 WIDGET-ID 26
     IMAGE-2 AT ROW 4.96 COL 34.29 WIDGET-ID 28
     RECT-21 AT ROW 1.25 COL 2 WIDGET-ID 62
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 93.57 BY 16.67
         FONT 4 WIDGET-ID 100.


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
         TITLE              = "Custo"
         HEIGHT             = 16.67
         WIDTH              = 93.57
         MAX-HEIGHT         = 26.21
         MAX-WIDTH          = 163.86
         VIRTUAL-HEIGHT     = 26.21
         VIRTUAL-WIDTH      = 163.86
         RESIZE             = yes
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
/* BROWSE-TAB br-usuario IMAGE-2 DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN c-ds-favorecido IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cb-tipo-consulta IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN de-media IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-usuario
/* Query rebuild information for BROWSE br-usuario
     _START_FREEFORM
DEF VAR i-cont AS INT.
ASSIGN de-media = 0
       i-cont = 0.
IF INPUT FRAME {&FRAME-NAME} cb-tipo-consulta = 1 /* Periodo */ THEN DO:
    FOR EACH custo no-lock
        WHERE custo.nome = INPUT FRAME {&FRAME-NAME} c-nome
        AND custo.periodo >= INPUT FRAME {&FRAME-NAME} c-periodo-ini
        AND custo.periodo <= INPUT FRAME {&FRAME-NAME} c-periodo-end:
        ASSIGN de-media = de-media + custo.val-custo
               i-cont = i-cont + 1.
    END.
END.
ELSE DO:
    FOR EACH custo no-lock
        WHERE custo.periodo = INPUT FRAME {&FRAME-NAME} c-periodo:
        ASSIGN de-media = de-media + custo.val-custo
               i-cont = i-cont + 1.
    END.
END.
ASSIGN de-media = de-media / i-cont.
DISP de-media
    WITH FRAME {&FRAME-NAME}.

OPEN QUERY {&SELF-NAME} FOR EACH custo
      WHERE (IF INPUT FRAME {&FRAME-NAME} cb-tipo-consulta = 1 THEN
          (custo.nome = INPUT FRAME {&FRAME-NAME} c-nome AND
           custo.periodo >= INPUT FRAME {&FRAME-NAME} c-periodo-ini AND
           custo.periodo <= INPUT FRAME {&FRAME-NAME} c-periodo-end) ELSE
          (custo.periodo = INPUT FRAME {&FRAME-NAME} c-periodo)) NO-LOCK
    BY custo.periodo DESCENDING INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.custo.periodo|no"
     _Where[1]         = "(IF INPUT FRAME {&FRAME-NAME} cb-tipo-consulta = ""1"" THEN (custo.nome = c-nome:screen-value in frame {&frame-name}
 AND int(custo.periodo) >= int(c-periodo-ini:screen-value in frame {&frame-name})
 AND int(custo.periodo) <= int(c-periodo-end:screen-value in frame {&frame-name})) ELSE
(custo.periodo = c-periodo:screen-value in frame {&frame-name}))"
     _Query            is OPENED
*/  /* BROWSE br-usuario */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Custo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Custo */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-usuario
&Scoped-define SELF-NAME br-usuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-usuario C-Win
ON DELETE-CHARACTER OF br-usuario IN FRAME DEFAULT-FRAME /* Custos */
DO:
  
    IF AVAIL custo THEN DO:

        FIND CURRENT custo EXCLUSIVE-LOCK.
        DELETE custo.
        {&OPEN-QUERY-br-usuario}
        APPLY "VALUE-CHANGED" TO br-usuario.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-usuario C-Win
ON VALUE-CHANGED OF br-usuario IN FRAME DEFAULT-FRAME /* Custos */
DO:

    image-1:LOAD-IMAGE(SEARCH("image\im-naodisp.bmp")) IN FRAME {&FRAME-NAME}. 
    IF AVAIL custo THEN DO:
        FIND FIRST usuario NO-LOCK
             WHERE usuario.nome = custo.nome NO-ERROR.
        IF AVAIL usuario THEN DO:
            FIND FIRST favorecido NO-LOCK
                 WHERE favorecido.cd-favorecido = usuario.cd-favorecido NO-ERROR.
            IF AVAIL favorecido THEN DO:
                IF favorecido.foto <> "" AND SEARCH(favorecido.foto) <> ? THEN
                    image-1:LOAD-IMAGE(SEARCH(favorecido.foto)) IN FRAME {&FRAME-NAME}.
            END.
        END. 
    END.
  
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


&Scoped-define SELF-NAME btQtHr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btQtHr C-Win
ON CHOOSE OF btQtHr IN FRAME DEFAULT-FRAME /* Valor */
DO:
    DEF VAR deTemp AS DEC.
  
    RUN som.p(INPUT "music\click.wav").

    {func\run.i &Programa = "valor.w (INPUT 'Atualizar Qtd Horas', INPUT custo.qt-horas, OUTPUT deTemp)"}
    FIND CURRENT custo EXCLUSIVE-LOCK.
    ASSIGN custo.qt-horas = deTemp
           custo.val-custo = custo.valor / custo.qt-horas.
    {&OPEN-QUERY-br-usuario}
    APPLY "VALUE-CHANGED" TO br-usuario.
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btValor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btValor C-Win
ON CHOOSE OF btValor IN FRAME DEFAULT-FRAME /* Valor */
DO:   
    {func\run.i &Programa = "custo-hora-calc.w"} 

    IF cb-tipo-consulta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1" THEN DO:
        ASSIGN c-nome:SCREEN-VALUE IN FRAME {&FRAME-NAME} = gNomeUsuario
               c-periodo-ini:SCREEN-VALUE IN FRAME {&FRAME-NAME} = gPeriodo.
        APPLY "leave" TO c-nome IN FRAME {&FRAME-NAME}.    
    END.
    ELSE DO:
        ASSIGN c-periodo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = gPeriodo.
        APPLY "leave" TO c-periodo IN FRAME {&FRAME-NAME}.  
    END.
                      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c-nome
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON ENTRY OF c-nome IN FRAME DEFAULT-FRAME
DO:
  {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON LEAVE OF c-nome IN FRAME DEFAULT-FRAME
DO:
    image-1:LOAD-IMAGE(SEARCH("image\im-naodisp.bmp")) IN FRAME {&FRAME-NAME}. 
    ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    FIND FIRST usuario NO-LOCK
         WHERE usuario.nome = INPUT FRAME {&FRAME-NAME} c-nome NO-ERROR.
    IF AVAIL usuario THEN DO:
        FIND FIRST favorecido NO-LOCK
             WHERE favorecido.cd-favorecido = usuario.cd-favorecido NO-ERROR.
        IF AVAIL favorecido THEN DO:
            ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = favorecido.ds-favorecido.                
            IF favorecido.foto <> "" AND SEARCH(favorecido.foto) <> ? THEN
                image-1:LOAD-IMAGE(SEARCH(favorecido.foto)) IN FRAME {&FRAME-NAME}.            
        END.
    END. 

    {&OPEN-QUERY-br-usuario}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON MOUSE-SELECT-DBLCLICK OF c-nome IN FRAME DEFAULT-FRAME
OR F5 OF c-nome DO:
    {func\zoom.i &Tabela="usuario"
                 &Campo1="nome"
                 &Tela1="c-nome"}
                 
    APPLY "leave" TO c-nome IN FRAME {&FRAME-NAME}.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON RETURN OF c-nome IN FRAME DEFAULT-FRAME
DO:
  APPLY "leave" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c-periodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo C-Win
ON ENTRY OF c-periodo IN FRAME DEFAULT-FRAME
DO:
  {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo C-Win
ON LEAVE OF c-periodo IN FRAME DEFAULT-FRAME
DO:
  {&OPEN-QUERY-br-usuario}
  APPLY "VALUE-CHANGED" TO br-usuario.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo C-Win
ON RETURN OF c-periodo IN FRAME DEFAULT-FRAME
DO:
  APPLY "leave" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c-periodo-end
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo-end C-Win
ON ENTRY OF c-periodo-end IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo-end C-Win
ON LEAVE OF c-periodo-end IN FRAME DEFAULT-FRAME
DO:
  {&OPEN-QUERY-br-usuario}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c-periodo-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo-ini C-Win
ON ENTRY OF c-periodo-ini IN FRAME DEFAULT-FRAME /* Periodo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo-ini C-Win
ON LEAVE OF c-periodo-ini IN FRAME DEFAULT-FRAME /* Periodo */
DO:
  {&OPEN-QUERY-br-usuario}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb-tipo-consulta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb-tipo-consulta C-Win
ON VALUE-CHANGED OF cb-tipo-consulta IN FRAME DEFAULT-FRAME
DO:
  IF INPUT FRAME {&FRAME-NAME} cb-tipo-consulta = "1" THEN DO:
      ASSIGN c-periodo:HIDDEN IN FRAME {&FRAME-NAME}       = YES 
             c-nome:HIDDEN IN FRAME {&FRAME-NAME}          = NO
             c-ds-favorecido:HIDDEN IN FRAME {&FRAME-NAME} = NO
             c-periodo-ini:HIDDEN IN FRAME {&FRAME-NAME}   = NO
             c-periodo-end:HIDDEN IN FRAME {&FRAME-NAME}   = NO
             image-7:HIDDEN IN FRAME {&FRAME-NAME}         = NO
             image-2:HIDDEN IN FRAME {&FRAME-NAME}         = NO.
      ASSIGN c-periodo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
      APPLY 'entry' TO c-nome IN FRAME {&FRAME-NAME}.
  END.
  ELSE DO:
      ASSIGN c-periodo:HIDDEN IN FRAME {&FRAME-NAME}       = NO 
             c-nome:HIDDEN IN FRAME {&FRAME-NAME}          = YES
             c-periodo-ini:HIDDEN IN FRAME {&FRAME-NAME}   = YES
             c-periodo-end:HIDDEN IN FRAME {&FRAME-NAME}   = YES
             image-7:HIDDEN IN FRAME {&FRAME-NAME}         = YES
             image-2:HIDDEN IN FRAME {&FRAME-NAME}         = YES
             c-ds-favorecido:HIDDEN IN FRAME {&FRAME-NAME} = YES.             
      ASSIGN c-nome:SCREEN-VALUE IN FRAME {&FRAME-NAME}    = ""
             c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".     
      APPLY 'entry' TO c-periodo IN FRAME {&FRAME-NAME}.      
  END.
  {&OPEN-QUERY-br-usuario}
      
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
    {version.i custo-hora}
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
  DISPLAY de-media c-nome c-ds-favorecido c-periodo-ini c-periodo-end 
          cb-tipo-consulta c-periodo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btQtHr c-nome c-periodo-ini c-periodo-end cb-tipo-consulta c-periodo 
         btValor btExit IMAGE-1 RECT-20 IMAGE-7 IMAGE-2 br-usuario RECT-21 
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

APPLY "VALUE-CHANGED" TO cb-tipo-consulta IN FRAME {&FRAME-NAME}.

ASSIGN c-periodo-ini:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(YEAR(TODAY),"9999") + "01"
       c-periodo-end:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99").

{func\cursor.i c-nome}

APPLY "VALUE-CHANGED" TO br-usuario IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

