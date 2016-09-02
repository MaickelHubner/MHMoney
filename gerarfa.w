&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-apont NO-UNDO LIKE apontamento
       field marcado as log
       field r-rowid as rowid.



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

/* Local Variable Definitions ---                                       */

{func\definitions.i}
{func\data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brApont

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-apont

/* Definitions for BROWSE brApont                                       */
&Scoped-define FIELDS-IN-QUERY-brApont tt-apont.data tt-apont.hora-ini ~
tt-apont.hora-fim tt-apont.qt-apontada tt-apont.nr-pedido ~
tt-apont.sequencia tt-apont.ds-apontamento 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brApont 
&Scoped-define QUERY-STRING-brApont FOR EACH tt-apont NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brApont OPEN QUERY brApont FOR EACH tt-apont NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brApont tt-apont
&Scoped-define FIRST-TABLE-IN-QUERY-brApont tt-apont


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brApont}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-7 btExit IMAGE-5 IMAGE-6 dt-ini dt-fim ~
codigo brApont btMarc btTodos btNenhum btGerar 
&Scoped-Define DISPLAYED-OBJECTS dt-ini dt-fim codigo 

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

DEFINE BUTTON btGerar 
     LABEL "Gerar FA" 
     SIZE 10 BY 1.

DEFINE BUTTON btMarc 
     LABEL "Marcar" 
     SIZE 10 BY 1.

DEFINE BUTTON btNenhum 
     LABEL "Nenhum" 
     SIZE 10 BY 1.

DEFINE BUTTON btTodos 
     LABEL "Todos" 
     SIZE 10 BY 1.

DEFINE VARIABLE codigo AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "C¢digo FA" 
     VIEW-AS FILL-IN 
     SIZE 10.57 BY .79 NO-UNDO.

DEFINE VARIABLE dt-fim AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE VARIABLE dt-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Per°odo" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-5
     FILENAME "image\im-fir":U
     SIZE 6.14 BY 1.79.

DEFINE IMAGE IMAGE-6
     FILENAME "image\im-las":U
     SIZE 6.14 BY 1.79.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.75.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brApont FOR 
      tt-apont SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brApont C-Win _STRUCTURED
  QUERY brApont NO-LOCK DISPLAY
      tt-apont.data FORMAT "99/99/9999":U
      tt-apont.hora-ini FORMAT "x(5)":U
      tt-apont.hora-fim FORMAT "x(5)":U
      tt-apont.qt-apontada FORMAT "->>,>>9.99":U
      tt-apont.nr-pedido FORMAT ">>>>,>>9":U
      tt-apont.sequencia FORMAT ">>>9":U
      tt-apont.ds-apontamento FORMAT "x(2000)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 78 BY 20
         FONT 1
         TITLE "Apontamentos do Per°odo".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btExit AT ROW 1.75 COL 73 WIDGET-ID 44
     dt-ini AT ROW 1.75 COL 20 COLON-ALIGNED WIDGET-ID 22
     dt-fim AT ROW 1.75 COL 39 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     codigo AT ROW 2.75 COL 20 COLON-ALIGNED WIDGET-ID 46
     brApont AT ROW 4.25 COL 2 WIDGET-ID 200
     btMarc AT ROW 24.25 COL 2 WIDGET-ID 30
     btTodos AT ROW 24.25 COL 12 WIDGET-ID 32
     btNenhum AT ROW 24.25 COL 22 WIDGET-ID 34
     btGerar AT ROW 24.25 COL 70 WIDGET-ID 48
     RECT-7 AT ROW 1.25 COL 2 WIDGET-ID 20
     IMAGE-5 AT ROW 1.33 COL 31 WIDGET-ID 24
     IMAGE-6 AT ROW 1.33 COL 35.43 WIDGET-ID 26
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 24.54
         FONT 1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-apont T "?" NO-UNDO money apontamento
      ADDITIONAL-FIELDS:
          field marcado as log
          field r-rowid as rowid
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 24.54
         WIDTH              = 80
         MAX-HEIGHT         = 25.08
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 25.08
         VIRTUAL-WIDTH      = 80
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = yes
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
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
   FRAME-NAME                                                           */
/* BROWSE-TAB brApont codigo DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brApont
/* Query rebuild information for BROWSE brApont
     _TblList          = "Temp-Tables.tt-apont"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = Temp-Tables.tt-apont.data
     _FldNameList[2]   = Temp-Tables.tt-apont.hora-ini
     _FldNameList[3]   = Temp-Tables.tt-apont.hora-fim
     _FldNameList[4]   = Temp-Tables.tt-apont.qt-apontada
     _FldNameList[5]   = Temp-Tables.tt-apont.nr-pedido
     _FldNameList[6]   = Temp-Tables.tt-apont.sequencia
     _FldNameList[7]   = Temp-Tables.tt-apont.ds-apontamento
     _Query            is OPENED
*/  /* BROWSE brApont */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brApont
&Scoped-define SELF-NAME brApont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApont C-Win
ON MOUSE-SELECT-DBLCLICK OF brApont IN FRAME DEFAULT-FRAME /* Apontamentos do Per°odo */
DO:
  
    APPLY "CHOOSE" TO btMarc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApont C-Win
ON RETURN OF brApont IN FRAME DEFAULT-FRAME /* Apontamentos do Per°odo */
DO:
  
    APPLY "CHOOSE" TO btMarc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApont C-Win
ON ROW-DISPLAY OF brApont IN FRAME DEFAULT-FRAME /* Apontamentos do Per°odo */
DO:
  
    IF tt-apont.marcado THEN DO:

        ASSIGN tt-apont.data:FGCOLOR IN BROWSE brApont = 9
               tt-apont.hora-ini:FGCOLOR IN BROWSE brApont = 9
               tt-apont.hora-fim:FGCOLOR IN BROWSE brApont = 9
               tt-apont.qt-apontada:FGCOLOR IN BROWSE brApont = 9
               tt-apont.nr-pedido:FGCOLOR IN BROWSE brApont = 9
               tt-apont.sequencia:FGCOLOR IN BROWSE brApont = 9
               tt-apont.ds-apontamento:FGCOLOR IN BROWSE brApont = 9.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brApont C-Win
ON VALUE-CHANGED OF brApont IN FRAME DEFAULT-FRAME /* Apontamentos do Per°odo */
DO:
  
    IF AVAIL tt-apont THEN DO:
        IF tt-apont.marcado THEN
            ASSIGN btMarc:LABEL = "Desmarcar".
        ELSE
            ASSIGN btMarc:LABEL = "Marcar".
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


&Scoped-define SELF-NAME btGerar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGerar C-Win
ON CHOOSE OF btGerar IN FRAME DEFAULT-FRAME /* Gerar FA */
DO:

    ASSIGN INPUT FRAME {&FRAME-NAME} codigo.
  
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Geraá∆o de FA (052)', INPUT 'Confirma geraá∆o de FA ?', INPUT 'Os apontamentos marcados ser∆o associados Ö Folha de Apontamento informada.')"}
    IF RETURN-VALUE = "OK":U THEN DO:
        FOR EACH tt-apont
            WHERE tt-apont.marcado:

            FIND FIRST apontamento EXCLUSIVE-LOCK
                WHERE ROWID(apontamento) = tt-apont.r-rowid NO-ERROR.
            IF AVAIL apontamento THEN DO:
                ASSIGN apontamento.codigo-fa = codigo.
            END.

        END.
        RUN recalc.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMarc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMarc C-Win
ON CHOOSE OF btMarc IN FRAME DEFAULT-FRAME /* Marcar */
DO:
  
    IF AVAIL tt-apont THEN DO:
        ASSIGN tt-apont.marcado = NOT tt-apont.marcado.
    END.
    {&OPEN-QUERY-brApont}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNenhum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNenhum C-Win
ON CHOOSE OF btNenhum IN FRAME DEFAULT-FRAME /* Nenhum */
DO:
  
    FOR EACH tt-apont:
        ASSIGN tt-apont.marcado = FALSE.
    END.
    {&OPEN-QUERY-brApont}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btTodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btTodos C-Win
ON CHOOSE OF btTodos IN FRAME DEFAULT-FRAME /* Todos */
DO:
  
    FOR EACH tt-apont:
        ASSIGN tt-apont.marcado = TRUE.
    END.
    {&OPEN-QUERY-brApont}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dt-fim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-fim C-Win
ON ENTRY OF dt-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-fim C-Win
ON LEAVE OF dt-fim IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} dt-fim <> dt-fim THEN DO:
        RUN recalc.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dt-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-ini C-Win
ON ENTRY OF dt-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dt-ini C-Win
ON LEAVE OF dt-ini IN FRAME DEFAULT-FRAME /* Per°odo */
DO:
    {func\set_leave.i}  
    IF INPUT FRAME {&FRAME-NAME} dt-ini <> dt-ini THEN DO:
        RUN recalc.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\calendar.i dt-ini}
{func\calendar.i dt-fim}

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
  {version.i gerarfa}
  RUN initialize.
  RUN enable_UI.
  RUN displayFields.
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
    
    RUN recalc.
    
    RETURN "OK".

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
  DISPLAY dt-ini dt-fim codigo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-7 btExit IMAGE-5 IMAGE-6 dt-ini dt-fim codigo brApont btMarc 
         btTodos btNenhum btGerar 
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

    ASSIGN dt-ini = DATE(MONTH(TODAY), 1, YEAR(TODAY))
           dt-fim = fnUltimoDia(MONTH(TODAY), YEAR(TODAY)).

    SELECT MAX(codigo-fa) INTO codigo FROM apontamento.
    ASSIGN codigo = codigo + 1.

    RETURN "OK".

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
    
    ASSIGN INPUT FRAME {&FRAME-NAME} dt-ini dt-fim.

    EMPTY TEMP-TABLE tt-apont.

    FOR EACH apontamento NO-LOCK
        WHERE apontamento.data >= dt-ini
        AND   apontamento.data <= dt-fim
        AND   apontamento.codigo-fa = 0:

        CREATE tt-apont.
        BUFFER-COPY apontamento TO tt-apont.
        ASSIGN tt-apont.r-rowid = ROWID(apontamento)
               tt-apont.marcado = YES.

    END.

    {&OPEN-QUERY-brApont}
    
    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

