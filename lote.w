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

/* Local Variable Definitions ---                                       */

&GLOBAL-DEFINE FrameFields lote.numero lote.data lote.origem lote.destino lote.importado

DEFINE VARIABLE cAction AS CHARACTER  NO-UNDO.

DEFINE BUFFER bflote FOR lote.

DEFINE NEW GLOBAL SHARED VARIABLE ilote AS INTEGER    NO-UNDO.

DEFINE VARIABLE lFirstVez AS LOGICAL     NO-UNDO INITIAL YES.

{seg.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brMov

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES lote-mov

/* Definitions for BROWSE brMov                                         */
&Scoped-define FIELDS-IN-QUERY-brMov lote-mov.num-mov lote-mov.operacao ~
lote-mov.tabela lote-mov.data lote-mov.hora lote-mov.usuario ~
lote-mov.imp-ok 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brMov 
&Scoped-define QUERY-STRING-brMov FOR EACH lote-mov ~
      WHERE lote-mov.numero = integer(lote.numero:screen-value in frame default-frame) ~
 AND lote-mov.origem = integer(lote.origem:screen-value in frame default-frame)  NO-LOCK
&Scoped-define OPEN-QUERY-brMov OPEN QUERY brMov FOR EACH lote-mov ~
      WHERE lote-mov.numero = integer(lote.numero:screen-value in frame default-frame) ~
 AND lote-mov.origem = integer(lote.origem:screen-value in frame default-frame)  NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brMov lote-mov
&Scoped-define FIRST-TABLE-IN-QUERY-brMov lote-mov


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brMov}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS lote.numero lote.data lote.origem ~
lote.destino lote.importado 
&Scoped-define ENABLED-TABLES lote
&Scoped-define FIRST-ENABLED-TABLE lote
&Scoped-Define ENABLED-OBJECTS brMov btExporta btImporta btProcessa btFirst ~
btLast btNext btPrev btExit RECT-5 
&Scoped-Define DISPLAYED-FIELDS lote.numero lote.data lote.origem ~
lote.destino lote.importado 
&Scoped-define DISPLAYED-TABLES lote
&Scoped-define FIRST-DISPLAYED-TABLE lote


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

DEFINE BUTTON btExporta 
     IMAGE-UP FILE "image/im-save.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-save.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Exp" 
     SIZE 6 BY 1.79 TOOLTIP "Exportar Movimentos do Lote".

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "First" 
     SIZE 6 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btImporta 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Imp" 
     SIZE 6 BY 1.79 TOOLTIP "Ler Arquivo de Lote".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Last" 
     SIZE 6 BY 1.79 TOOLTIP "éltimo".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Next" 
     SIZE 6 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Prev" 
     SIZE 6 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btProcessa 
     IMAGE-UP FILE "image/im-copia.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-copia.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Pro" 
     SIZE 6 BY 1.79 TOOLTIP "Importar Lote".

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 86 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brMov FOR 
      lote-mov SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brMov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brMov C-Win _STRUCTURED
  QUERY brMov NO-LOCK DISPLAY
      lote-mov.num-mov FORMAT ">>>,>>>,>>9":U
      lote-mov.operacao FORMAT "X(3)":U WIDTH 4
      lote-mov.tabela FORMAT "X(30)":U
      lote-mov.data FORMAT "99/99/9999":U
      lote-mov.hora FORMAT "99:99":U WIDTH 6
      lote-mov.usuario FORMAT "X(8)":U WIDTH 12
      lote-mov.imp-ok COLUMN-LABEL "Importa‡Æo OK" FORMAT "Sim/NÆo":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 86 BY 9.5
         FONT 1
         TITLE "Movimentos do Lote" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     brMov AT ROW 6.5 COL 2
     btExporta AT ROW 1.5 COL 39
     btImporta AT ROW 1.5 COL 30
     btProcessa AT ROW 1.5 COL 45
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     lote.numero AT ROW 4.25 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     lote.data AT ROW 4.25 COL 37 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     lote.origem AT ROW 5.25 COL 20 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     lote.destino AT ROW 5.25 COL 43 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     lote.importado AT ROW 4.25 COL 63 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btExit AT ROW 1.5 COL 81
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88 BY 15.38
         FONT 1.


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
         TITLE              = "Lotes de Transferˆncia"
         HEIGHT             = 15.38
         WIDTH              = 88
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
/* BROWSE-TAB brMov 1 DEFAULT-FRAME */
ASSIGN 
       brMov:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brMov:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brMov
/* Query rebuild information for BROWSE brMov
     _TblList          = "money.lote-mov"
     _Options          = "NO-LOCK"
     _Where[1]         = "lote-mov.numero = integer(lote.numero:screen-value in frame default-frame)
 AND lote-mov.origem = integer(lote.origem:screen-value in frame default-frame) "
     _FldNameList[1]   = money.lote-mov.num-mov
     _FldNameList[2]   > money.lote-mov.operacao
"lote-mov.operacao" ? ? "character" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.lote-mov.tabela
     _FldNameList[4]   = money.lote-mov.data
     _FldNameList[5]   > money.lote-mov.hora
"lote-mov.hora" ? ? "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > money.lote-mov.usuario
"lote-mov.usuario" ? ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > money.lote-mov.imp-ok
"lote-mov.imp-ok" "Importa‡Æo OK" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brMov */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Lotes de Transferˆncia */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Lotes de Transferˆncia */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brMov
&Scoped-define SELF-NAME brMov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brMov C-Win
ON MOUSE-SELECT-DBLCLICK OF brMov IN FRAME DEFAULT-FRAME /* Movimentos do Lote */
DO:
    {func\run.i &Programa = "movlote.w (input rowid(lote-mov))"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brMov C-Win
ON ROW-DISPLAY OF brMov IN FRAME DEFAULT-FRAME /* Movimentos do Lote */
DO:
  
    IF INPUT FRAME default-frame lote.numero = 0 THEN DO:
        ASSIGN lote-mov.num-mov:FGCOLOR IN BROWSE brMov = 7
               lote-mov.operacao:FGCOLOR IN BROWSE brMov = 7
               lote-mov.tabela:FGCOLOR IN BROWSE brMov = 7
               lote-mov.data:FGCOLOR IN BROWSE brMov = 7
               lote-mov.hora:FGCOLOR IN BROWSE brMov = 7
               lote-mov.usuario:FGCOLOR IN BROWSE brMov = 7
               lote-mov.imp-ok:FGCOLOR IN BROWSE brMov = 7.
    END.
    ELSE DO:
        IF INPUT FRAME default-frame lote.importado THEN DO:
            IF NOT lote-mov.imp-ok THEN DO:
                ASSIGN lote-mov.num-mov:FGCOLOR IN BROWSE brMov = 12
                       lote-mov.operacao:FGCOLOR IN BROWSE brMov = 12
                       lote-mov.tabela:FGCOLOR IN BROWSE brMov = 12
                       lote-mov.data:FGCOLOR IN BROWSE brMov = 12
                       lote-mov.hora:FGCOLOR IN BROWSE brMov = 12
                       lote-mov.usuario:FGCOLOR IN BROWSE brMov = 12
                       lote-mov.imp-ok:FGCOLOR IN BROWSE brMov = 12.
            END.
            ELSE DO:
                ASSIGN lote-mov.num-mov:FGCOLOR IN BROWSE brMov = 9
                       lote-mov.operacao:FGCOLOR IN BROWSE brMov = 9
                       lote-mov.tabela:FGCOLOR IN BROWSE brMov = 9
                       lote-mov.data:FGCOLOR IN BROWSE brMov = 9
                       lote-mov.hora:FGCOLOR IN BROWSE brMov = 9
                       lote-mov.usuario:FGCOLOR IN BROWSE brMov = 9
                       lote-mov.imp-ok:FGCOLOR IN BROWSE brMov = 9.
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


&Scoped-define SELF-NAME btExporta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExporta C-Win
ON CHOOSE OF btExporta IN FRAME DEFAULT-FRAME /* Exp */
DO:

    RUN som.p(INPUT "music\click.wav").
    RUN exportalote.p.

    RUN displayFields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* First */
DO:
  
    IF NOT lFirstVez THEN DO:
        RUN som.p(INPUT "music\click.wav").
    END.
    ELSE DO:
        ASSIGN lFirstVez = NO.
    END.
    FIND FIRST lote NO-LOCK NO-ERROR.
    RUN displayFields.
    ENABLE btNext
           btLast WITH FRAME default-frame.
    DISABLE btPrev
            btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btImporta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btImporta C-Win
ON CHOOSE OF btImporta IN FRAME DEFAULT-FRAME /* Imp */
DO:
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE procname  AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cDados AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE rLote AS ROWID      NO-UNDO.

    DEFINE VARIABLE iLote AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iMov AS INTEGER    NO-UNDO.
    DEFINE VARIABLE cOper AS CHARACTER  NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    SYSTEM-DIALOG GET-FILE procname
          TITLE      "Abrir Lotes"
          FILTERS    "Arquivos de Lote"   "*.lot",
                     "Todos os Arquivos"      "*.*"
          INITIAL-DIR "lotes"
          MUST-EXIST
          USE-FILENAME
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:

        RUN abrelote.p (INPUT procname, OUTPUT rLote).

        FIND FIRST lote
            WHERE ROWID(lote) = rLote NO-LOCK NO-ERROR.

        RUN displayFields.

    END.  

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* Last */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND LAST lote NO-LOCK NO-ERROR.
    RUN displayFields.
    DISABLE btNext
            btLast WITH FRAME default-frame.
    ENABLE btPrev
           btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* Next */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND NEXT lote NO-LOCK NO-ERROR.
    IF NOT AVAIL lote THEN DO:
        FIND LAST lote NO-LOCK.
        DISABLE btNext
                btLast WITH FRAME default-frame.
    END.
    ENABLE btPrev
           btFirst WITH FRAME default-frame.
    RUN displayFields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* Prev */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND PREV lote NO-LOCK NO-ERROR.
    IF NOT AVAIL lote THEN DO:
        FIND FIRST lote NO-LOCK.
        DISABLE btPrev
                btFirst WITH FRAME default-frame.
    END.
    ENABLE btNext
           btLast WITH FRAME default-frame.
    RUN displayFields.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btProcessa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btProcessa C-Win
ON CHOOSE OF btProcessa IN FRAME DEFAULT-FRAME /* Pro */
DO:

    DEFINE VARIABLE rLote AS ROWID      NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    ASSIGN rLote = ROWID(lote).

    {func\run.i &Programa = "implote.w (INPUT rLote)"}

    FIND FIRST lote
        WHERE ROWID(lote) = rLote NO-LOCK NO-ERROR.

    RUN displayFields IN THIS-PROCEDURE.

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
  /*RUN enable_UI.*/
    {version.i lote}
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

  IF AVAILABLE lote THEN DO:
      DISPLAY {&FrameFields}
        WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
      DISABLE btExporta
              btProcessa WITH FRAME default-frame.
      IF lote.numero = 0 THEN DO:
            ENABLE btExporta WITH FRAME default-frame.
      END.
      ELSE DO:
          IF lote.destino = param-mn.maquina-local 
              AND NOT lote.importado THEN DO:
                ENABLE btProcessa WITH FRAME default-frame.
          END.
      END.
  END.
  ELSE DO:
      ASSIGN lote.numero:SCREEN-VALUE = ""
             lote.data:SCREEN-VALUE = "".
  END.

  {&OPEN-QUERY-brMov}
  IF NOT param-mn.sincroniza THEN DO:
      DISABLE btExporta
              btProcessa
              btImporta WITH FRAME default-frame.
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
  IF AVAILABLE lote THEN 
    DISPLAY lote.numero lote.data lote.origem lote.destino lote.importado 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE brMov btExporta btImporta btProcessa btFirst btLast btNext btPrev 
         lote.numero lote.data lote.origem lote.destino lote.importado btExit 
         RECT-5 
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

  find first param-mn NO-LOCK.

  for each lote where lote.numero = 0 EXCLUSIVE-LOCK:
      delete lote.
  end.
  create lote.
  assign lote.origem = param-mn.maquina-local.

  HIDE FRAME fProc.

  ENABLE btFirst btLast btNext btPrev RECT-5 brMov btImporta btExit
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  RUN displayFields.
  VIEW C-Win.

  APPLY "CHOOSE" TO btFirst.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

