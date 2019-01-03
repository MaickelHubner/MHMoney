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

&GLOBAL-DEFINE FrameFields orcamento.cd-orcamento orcamento.ds-orcamento ~
                           orcamento.ano

DEFINE VARIABLE cAction AS CHARACTER  NO-UNDO.

DEFINE BUFFER bforcamento FOR orcamento.

DEFINE NEW GLOBAL SHARED VARIABLE iorcamento AS INTEGER    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE cListaConsMov AS LONGCHAR   NO-UNDO.

{seg.i}

{orcamento.i}
{func\tt_graf.i}
{func\data.i}

DEFINE TEMP-TABLE tt-acomp-aux LIKE tt-acomp.

DEFINE VARIABLE cValueBrw AS CHARACTER   NO-UNDO.
DEFINE VARIABLE rRowidBrw AS ROWID       NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAcomp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-acomp

/* Definitions for BROWSE brAcomp                                       */
&Scoped-define FIELDS-IN-QUERY-brAcomp tt-acomp.descricao tt-acomp.vl-prev tt-acomp.vl-real tt-acomp.vl-dif   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcomp   
&Scoped-define SELF-NAME brAcomp
&Scoped-define QUERY-STRING-brAcomp FOR EACH tt-acomp. IF rRowidBrw <> ? THEN     REPOSITION brAcomp TO ROWID rRowidBrw
&Scoped-define OPEN-QUERY-brAcomp OPEN QUERY {&SELF-NAME} FOR EACH tt-acomp. IF rRowidBrw <> ? THEN     REPOSITION brAcomp TO ROWID rRowidBrw.
&Scoped-define TABLES-IN-QUERY-brAcomp tt-acomp
&Scoped-define FIRST-TABLE-IN-QUERY-brAcomp tt-acomp


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brAcomp}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS orcamento.cd-orcamento orcamento.ds-orcamento ~
orcamento.ano 
&Scoped-define ENABLED-TABLES orcamento
&Scoped-define FIRST-ENABLED-TABLE orcamento
&Scoped-Define ENABLED-OBJECTS brAcomp btFirst btLast btNext btPrev btRelat ~
dif dif-per mes-de mes-ate btExit RECT-1 RECT-7 
&Scoped-Define DISPLAYED-FIELDS orcamento.cd-orcamento ~
orcamento.ds-orcamento orcamento.ano 
&Scoped-define DISPLAYED-TABLES orcamento
&Scoped-define FIRST-DISPLAYED-TABLE orcamento
&Scoped-Define DISPLAYED-OBJECTS dif dif-per mes-de mes-ate 

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

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "First" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Last" 
     SIZE 6.14 BY 1.79 TOOLTIP "éltimo".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Next" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Prev" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btRelat 
     IMAGE-UP FILE "image/im-graf.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-graf.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Gr fico de Previsto X Realizado no per¡odo".

DEFINE VARIABLE mes-ate AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "At‚" 
     VIEW-AS COMBO-BOX INNER-LINES 15
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Mar‡o",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE mes-de AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "De" 
     VIEW-AS COMBO-BOX INNER-LINES 15
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Mar‡o",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE dif AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 10.14 BY .67
     FONT 6 NO-UNDO.

DEFINE VARIABLE dif-per AS CHARACTER FORMAT "X(256)":U INITIAL "Diferen‡a no Per¡odo" 
      VIEW-AS TEXT 
     SIZE 18 BY .67
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 132 BY 2.25.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 132 BY 1.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcomp FOR 
      tt-acomp SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcomp C-Win _FREEFORM
  QUERY brAcomp DISPLAY
      tt-acomp.descricao
        tt-acomp.vl-prev FORMAT "->>>>,>>>,>>9.99"
        tt-acomp.vl-real FORMAT "->>>>,>>>,>>9.99"
        tt-acomp.vl-dif  FORMAT "->>>>,>>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 132 BY 23.75
         FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     brAcomp AT ROW 6.75 COL 3
     btFirst AT ROW 1.5 COL 4
     btLast AT ROW 1.5 COL 22.43
     btNext AT ROW 1.5 COL 16.29
     btPrev AT ROW 1.5 COL 10.14
     btRelat AT ROW 1.5 COL 31
     dif AT ROW 2 COL 113 COLON-ALIGNED NO-LABEL
     dif-per AT ROW 2 COL 94 COLON-ALIGNED NO-LABEL
     mes-de AT ROW 5.5 COL 53 COLON-ALIGNED
     orcamento.cd-orcamento AT ROW 4 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     orcamento.ds-orcamento AT ROW 4 COL 34.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 68.72 BY .79
     orcamento.ano AT ROW 4 COL 112 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     mes-ate AT ROW 5.5 COL 74 COLON-ALIGNED
     btExit AT ROW 1.5 COL 128
     RECT-1 AT ROW 1.25 COL 3
     RECT-7 AT ROW 3.75 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134.86 BY 30.04
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
         TITLE              = "Acompanhamento de Or‡amento"
         HEIGHT             = 30.04
         WIDTH              = 134.86
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 134.86
         VIRTUAL-HEIGHT     = 30.04
         VIRTUAL-WIDTH      = 134.86
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
/* BROWSE-TAB brAcomp 1 DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcomp
/* Query rebuild information for BROWSE brAcomp
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-acomp.
IF rRowidBrw <> ? THEN
    REPOSITION brAcomp TO ROWID rRowidBrw.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brAcomp */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Acompanhamento de Or‡amento */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Acompanhamento de Or‡amento */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAcomp
&Scoped-define SELF-NAME brAcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcomp C-Win
ON MOUSE-SELECT-DBLCLICK OF brAcomp IN FRAME DEFAULT-FRAME
DO:
    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
  
    IF tt-acomp.registros[1] <> "" THEN DO:
        SESSION:SET-WAIT-STATE("GENERAL").
        OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "consmov.txt").
        REPEAT iAux = 1 TO tt-acomp.cont-reg:
            PUT UNFORMATTED tt-acomp.registros[iAux].
        END.
        OUTPUT CLOSE.
        SESSION:SET-WAIT-STATE("").
        {func\run.i &Programa = "consmov.w"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcomp C-Win
ON ROW-DISPLAY OF brAcomp IN FRAME DEFAULT-FRAME
DO:
  
    IF SUBSTRING(tt-acomp.descricao,6,1) <> "" THEN
        ASSIGN tt-acomp.vl-prev:FGCOLOR IN BROWSE brAcomp = 9
               tt-acomp.vl-real:FGCOLOR IN BROWSE brAcomp = 9
               tt-acomp.vl-dif:FGCOLOR IN BROWSE brAcomp = 9
               tt-acomp.descricao:FGCOLOR IN BROWSE brAcomp = 9.

    IF tt-acomp.descricao = "RECEITAS"
    OR tt-acomp.descricao = "CONTRIBUI€åES · POUPAN€A"
    OR tt-acomp.descricao = "DESPESAS" THEN
        ASSIGN tt-acomp.vl-prev:FGCOLOR IN BROWSE brAcomp = 12
               tt-acomp.vl-real:FGCOLOR IN BROWSE brAcomp = 12
               tt-acomp.vl-dif:FGCOLOR IN BROWSE brAcomp = 12
               tt-acomp.descricao:FGCOLOR IN BROWSE brAcomp = 12.

    IF tt-acomp.descricao = "" THEN
        ASSIGN tt-acomp.vl-prev:FGCOLOR IN BROWSE brAcomp = 15
               tt-acomp.vl-real:FGCOLOR IN BROWSE brAcomp = 15
               tt-acomp.vl-dif:FGCOLOR IN BROWSE brAcomp = 15
               tt-acomp.descricao:FGCOLOR IN BROWSE brAcomp = 15.

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


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* First */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND FIRST orcamento NO-LOCK NO-ERROR.
    RUN displayFields.
    ENABLE btNext
           btLast WITH FRAME default-frame.
    DISABLE btPrev
            btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* Last */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND LAST orcamento NO-LOCK NO-ERROR.
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
    FIND NEXT orcamento NO-LOCK NO-ERROR.
    IF NOT AVAIL orcamento THEN DO:
        FIND LAST orcamento NO-LOCK.
        DISABLE btNext
                btLast WITH FRAME default-frame.
    END.
    RUN displayFields.
    ENABLE btPrev
           btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* Prev */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND PREV orcamento NO-LOCK NO-ERROR.
    IF NOT AVAIL orcamento THEN DO:
        FIND FIRST orcamento NO-LOCK.
        DISABLE btPrev
                btFirst WITH FRAME default-frame.
    END.
    RUN displayFields.
    ENABLE btNext
           btLast WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRelat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRelat C-Win
ON CHOOSE OF btRelat IN FRAME DEFAULT-FRAME /* Button 1 */
DO:

    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
    DEFINE VARIABLE vl-total AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iMes AS INTEGER    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN INPUT FRAME {&FRAME-NAME} mes-de mes-ate.
    
    SESSION:SET-WAIT-STATE("image\calc.cur").

    FOR EACH tt-graf:
        DELETE tt-graf.
    END.
    FOR EACH tt-graf-par:
        DELETE tt-graf-par.
    END.

    CREATE tt-graf-par.
    ASSIGN tt-graf-par.titulo = "Previsto X Realizado (" + TRIM(tt-acomp.descricao) + ")"
           tt-graf-par.dado-label     = "Mˆs/Ano"
           tt-graf-par.valor-label[1] = "Previsto"
           tt-graf-par.valor-label[2] = "Realizado"
           tt-graf-par.valor-label[3] = "Acumulado".

    ASSIGN tt-graf-par.mostra-valores[3] = YES.

    ASSIGN vl-total = 0
           iTemp = 1.

    REPEAT iMes = mes-de TO mes-ate:

        CREATE tt-graf.
        ASSIGN tt-graf.dado        = fnMes(iMes) + "/" + SUBSTRING(STRING(orcamento.ano,"9999"),3,2)
               tt-graf.seq         = iTemp
               iTemp = iTemp + 1.

        RUN prevXreal.p (INPUT iMes, INPUT orcamento.cd-orcamento, OUTPUT TABLE tt-acomp-aux).

        IF TRIM(tt-acomp.descricao) = "" THEN DO:
            FIND FIRST tt-acomp-aux 
                WHERE tt-acomp-aux.cod-cat = tt-acomp.cod-cat
                AND   tt-acomp-aux.cd-sub = tt-acomp.cd-sub NO-LOCK NO-ERROR.
        END.
        ELSE DO:
            FIND FIRST tt-acomp-aux 
                WHERE tt-acomp-aux.cod-cat = tt-acomp.cod-cat
                AND   tt-acomp-aux.cd-sub = tt-acomp.cd-sub
                AND   TRIM(tt-acomp-aux.descricao) = TRIM(tt-acomp.descricao) NO-LOCK NO-ERROR.
            IF NOT AVAIL tt-acomp-aux THEN
                FIND FIRST tt-acomp-aux 
                    WHERE TRIM(tt-acomp-aux.descricao) = TRIM(tt-acomp.descricao) NO-LOCK NO-ERROR.
        END.

        IF AVAIL tt-acomp-aux THEN DO:

            ASSIGN vl-total = vl-total + tt-acomp-aux.vl-dif.

            ASSIGN tt-graf.valor[1] = tt-acomp-aux.vl-prev
                   tt-graf.valor[2] = tt-acomp-aux.vl-real
                   tt-graf.valor[3] = vl-total.

        END.

    END.

    SESSION:SET-WAIT-STATE("").
    {func\run.i &Programa = "grafview.w (INPUT TABLE tt-graf-par, INPUT TABLE tt-graf)"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-ate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ate C-Win
ON ENTRY OF mes-ate IN FRAME DEFAULT-FRAME /* At‚ */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ate C-Win
ON LEAVE OF mes-ate IN FRAME DEFAULT-FRAME /* At‚ */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-ate C-Win
ON VALUE-CHANGED OF mes-ate IN FRAME DEFAULT-FRAME /* At‚ */
DO:
  
    RUN recalcula.
    {&OPEN-QUERY-brAcomp}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-de
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-de C-Win
ON ENTRY OF mes-de IN FRAME DEFAULT-FRAME /* De */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-de C-Win
ON LEAVE OF mes-de IN FRAME DEFAULT-FRAME /* De */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-de C-Win
ON VALUE-CHANGED OF mes-de IN FRAME DEFAULT-FRAME /* De */
DO:
  
    RUN recalcula.
    {&OPEN-QUERY-brAcomp}

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
    {version.i orcacomp}
    RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButons C-Win 
PROCEDURE controlButons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER lHabilita AS LOGICAL    NO-UNDO.

IF NOT lHabilita THEN DO:
    DISABLE mes-de
            mes-ate WITH FRAME default-frame.
END.
ELSE DO:
    ENABLE mes-de
           mes-ate WITH FRAME default-frame.
END.

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

  IF AVAILABLE orcamento THEN DO:
    DISPLAY {&FrameFields} mes-de mes-ate dif-per
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
      RUN recalcula.
    {&OPEN-QUERY-brAcomp}
  END.
  ELSE DO:
      ASSIGN orcamento.cd-orcamento:SCREEN-VALUE = ""
             orcamento.ds-orcamento:SCREEN-VALUE = "".
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
  DISPLAY dif dif-per mes-de mes-ate 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE orcamento THEN 
    DISPLAY orcamento.cd-orcamento orcamento.ds-orcamento orcamento.ano 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE brAcomp btFirst btLast btNext btPrev btRelat dif dif-per mes-de 
         orcamento.cd-orcamento orcamento.ds-orcamento orcamento.ano mes-ate 
         btExit RECT-1 RECT-7 
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

  ASSIGN mes-de = 1
         mes-ate = MONTH(TODAY).

  FIND LAST orcamento WHERE orcamento.ano = YEAR(TODAY) NO-LOCK NO-ERROR.

  RUN displayFields.
  ENABLE btFirst btLast btNext btPrev RECT-1 mes-de mes-ate btRelat btExit brAcomp
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  VIEW C-Win.

  IF NOT AVAIL orcamento THEN
    APPLY "CHOOSE" TO btFirst.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalcula C-Win 
PROCEDURE recalcula :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

SESSION:SET-WAIT-STATE("GENERAL":U).

ASSIGN cValueBrw = TRIM(tt-acomp.descricao:SCREEN-VALUE IN BROWSE brAcomp).

RUN criaTTAcomp (INPUT INPUT FRAME default-frame mes-de,
                 INPUT INPUT FRAME default-frame mes-ate,
                 INPUT INPUT FRAME default-frame orcamento.cd-orcamento).

FIND FIRST tt-acomp WHERE tt-acomp.descricao = "RECEITAS".
ASSIGN dif = tt-acomp.vl-dif.
FIND FIRST tt-acomp WHERE tt-acomp.descricao = "DESPESAS".
ASSIGN dif = dif - tt-acomp.vl-dif.

FIND FIRST tt-acomp WHERE tt-acomp.descricao = "CONTRIBUI€åES · POUPAN€A".
ASSIGN dif = dif + tt-acomp.vl-dif.

DISPLAY dif WITH FRAME default-frame.

IF dif >= 0 THEN
    ASSIGN dif:FGCOLOR IN FRAME default-frame = 1
           dif:TOOLTIP = "O or‡amento est  sendo cumprido com sobras!".
ELSE
    IF (tt-acomp.vl-real + dif) > 0 THEN
        ASSIGN dif:FGCOLOR IN FRAME default-frame = 3
               dif:TOOLTIP = "O d‚ficit or‡ament rio pode ser coberto pelo valor em poupan‡a!".
    ELSE
        ASSIGN dif:FGCOLOR IN FRAME default-frame = 4
               dif:TOOLTIP = "O or‡amento nÆo est  sendo cumprido!".

FOR EACH tt-acomp
    WHERE tt-acomp.vl-prev = 0
    AND   tt-acomp.vl-real = 0
    AND tt-acomp.descricao <> "":
    DELETE tt-acomp.
END.

FIND FIRST bfAcomp
    WHERE TRIM(bfAcomp.descricao) = cValueBrw NO-ERROR.
IF AVAIL bfAcomp THEN DO:
    ASSIGN rRowidBrw = ROWID(bfAcomp).
END.
ELSE DO:
    ASSIGN rRowidBrw = ?.
END.

SESSION:SET-WAIT-STATE("":U).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setarDados C-Win 
PROCEDURE setarDados :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER cFav AS CHARACTER  NO-UNDO.

ASSIGN iorcamento = 0.

ASSIGN orcamento.ds-orcamento = cFav.
DISPLAY orcamento.ds-orcamento WITH FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

