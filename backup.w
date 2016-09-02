&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

{seg.i}

DEFINE TEMP-TABLE tt-back
    FIELD data AS DATE FORMAT "99/99/9999" COLUMN-LABEL "Data"
    FIELD diretorio AS CHAR
    FIELD tot-reg AS INTEGER COLUMN-LABEL "Registros".

DEFINE TEMP-TABLE tt-tab
    FIELD data AS DATE
    FIELD tabela AS CHAR COLUMN-LABEL "Tabela" FORMAT "X(40)"
    FIELD tot-reg AS INTEGER COLUMN-LABEL "Registros".

DEFINE STREAM str-exec.
DEFINE STREAM str-bin.

def var chProgressBar       as com-handle no-undo.

DEFINE BUFFER bfBack FOR tt-back.
DEFINE BUFFER bfTab FOR tt-tab.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brBack

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-back tt-tab

/* Definitions for BROWSE brBack                                        */
&Scoped-define FIELDS-IN-QUERY-brBack tt-back.data tt-back.tot-reg   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brBack   
&Scoped-define SELF-NAME brBack
&Scoped-define QUERY-STRING-brBack FOR EACH tt-back BY tt-back.data DESC
&Scoped-define OPEN-QUERY-brBack OPEN QUERY {&SELF-NAME} FOR EACH tt-back BY tt-back.data DESC.
&Scoped-define TABLES-IN-QUERY-brBack tt-back
&Scoped-define FIRST-TABLE-IN-QUERY-brBack tt-back


/* Definitions for BROWSE brTab                                         */
&Scoped-define FIELDS-IN-QUERY-brTab tt-tab.tabela tt-tab.tot-reg   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTab   
&Scoped-define SELF-NAME brTab
&Scoped-define QUERY-STRING-brTab FOR EACH tt-tab          WHERE tt-tab.data = tt-back.data
&Scoped-define OPEN-QUERY-brTab OPEN QUERY {&SELF-NAME} FOR EACH tt-tab          WHERE tt-tab.data = tt-back.data.
&Scoped-define TABLES-IN-QUERY-brTab tt-tab
&Scoped-define FIRST-TABLE-IN-QUERY-brTab tt-tab


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brBack}~
    ~{&OPEN-QUERY-brTab}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btBack RECT-5 brBack btRest btExit brTab ~
descr 
&Scoped-Define DISPLAYED-OBJECTS descr 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btBack 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Efetuar Backup" 
     SIZE 6 BY 1.79 TOOLTIP "Efetuar Backup"
     FONT 1.

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btRest 
     IMAGE-UP FILE "image/im-goto.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-goto.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Restaurar Backup" 
     SIZE 6 BY 1.79 TOOLTIP "Restaurar Backup"
     FONT 1.

DEFINE VARIABLE descr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .67
     FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 40 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brBack FOR 
      tt-back SCROLLING.

DEFINE QUERY brTab FOR 
      tt-tab SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brBack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brBack C-Win _FREEFORM
  QUERY brBack DISPLAY
      tt-back.data
 tt-back.tot-reg
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 40 BY 4.29
         FONT 1 FIT-LAST-COLUMN.

DEFINE BROWSE brTab
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTab C-Win _FREEFORM
  QUERY brTab DISPLAY
      tt-tab.tabela
 tt-tab.tot-reg
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 40 BY 7.21
         FONT 1 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btBack AT ROW 1.5 COL 3
     brBack AT ROW 3.75 COL 2
     btRest AT ROW 1.5 COL 9
     btExit AT ROW 1.5 COL 35
     brTab AT ROW 9.88 COL 2
     descr AT ROW 9 COL 2 NO-LABEL
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 41.86 BY 16.33
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
         TITLE              = "Backup"
         HEIGHT             = 16.33
         WIDTH              = 41.86
         MAX-HEIGHT         = 17.33
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 17.33
         VIRTUAL-WIDTH      = 80
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
   FRAME-NAME                                                           */
/* BROWSE-TAB brBack RECT-5 DEFAULT-FRAME */
/* BROWSE-TAB brTab btExit DEFAULT-FRAME */
ASSIGN 
       brBack:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brBack:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

ASSIGN 
       brTab:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brTab:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN descr IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brBack
/* Query rebuild information for BROWSE brBack
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-back BY tt-back.data DESC.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brBack */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTab
/* Query rebuild information for BROWSE brTab
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-tab
         WHERE tt-tab.data = tt-back.data.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brTab */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 8.17
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 40
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(brBack:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Backup */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Backup */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brBack
&Scoped-define SELF-NAME brBack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brBack C-Win
ON VALUE-CHANGED OF brBack IN FRAME DEFAULT-FRAME
DO:
  
    {&OPEN-QUERY-brTab}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btBack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btBack C-Win
ON CHOOSE OF btBack IN FRAME DEFAULT-FRAME /* Efetuar Backup */
DO:

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iPrBar AS INTEGER    NO-UNDO INITIAL 1.
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    IF CAN-FIND(FIRST tt-back WHERE tt-back.data = TODAY) THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Backup (036)', INPUT 'Backup j  efetuado!', INPUT 'Backup para a data ' + STRING(TODAY,~'99/99/9999~') + ' j  efetuado!')"}
        LEAVE.
    END.

    SESSION:SET-WAIT-STATE("GENERAL":U).
  
    CREATE tt-back.
    ASSIGN tt-back.data = TODAY
           tt-back.diretorio = "backup\" + STRING(YEAR(TODAY),"9999") + "-" +
                               STRING(MONTH(TODAY),"99") + "-" +
                               STRING(DAY(TODAY),"99").

    OS-CREATE-DIR VALUE(tt-back.diretorio).

    SELECT COUNT(*) INTO iTemp FROM money._file WHERE money._file._hidden = NO.

    ASSIGN chProgressBar:Max = iTemp + 1 /* Controles da ProgressBar */.

    FOR EACH _file NO-LOCK
        WHERE _file._hidden = NO:

        ASSIGN chProgressBar:VALUE = iPrBar
               iPrBar = iPrBar + 1.

        OS-DELETE VALUE("temp\" + _file._dump-name + ".p").
        OUTPUT STREAM str-exec TO VALUE("temp\" + _file._dump-name + ".p").
        PUT STREAM str-exec UNFORMATTED "DEFINE OUTPUT PARAMETER iCont AS INTEGER." SKIP
                        "DEFINE STREAM str-back." SKIP
                        "OUTPUT STREAM str-back TO VALUE(~"" + tt-back.diretorio + "\" + _file._dump-name + ".d~")." SKIP
                        "FOR EACH " + _file._file-name + ":" SKIP
                        "    EXPORT STREAM str-back " + _file._file-name + "." SKIP
                        "    ASSIGN iCont = iCont + 1." SKIP
                        "END." SKIP
                        "OUTPUT STREAM str-back CLOSE.".
        OUTPUT STREAM str-exec CLOSE.
        RUN VALUE("temp\" + _file._dump-name + ".p") (OUTPUT iCont).
        CREATE tt-tab.
        ASSIGN tt-tab.data = tt-back.data
               tt-tab.tabela = _file._file-name
               tt-tab.tot-reg = iCont.

        ASSIGN tt-back.tot-reg = tt-back.tot-reg + iCont.

        OS-DELETE VALUE("temp\" + _file._dump-name + ".p").
        
    END.


    ASSIGN chProgressBar:VALUE = iPrBar.

    OUTPUT STREAM str-bin TO VALUE(tt-back.diretorio + "\info.bin").

    PUT STREAM str-bin UNFORMATTED "[TOT_REG]" STRING(tt-back.tot-reg) SKIP.

    FOR EACH tt-tab WHERE tt-tab.data = tt-back.data:
        PUT STREAM str-bin UNFORMATTED "[TABELA]" tt-tab.tabela "|" STRING(tt-tab.tot-reg) SKIP.
    END.

    OUTPUT STREAM str-bin CLOSE.

    {&OPEN-QUERY-brBack}
    APPLY "VALUE-CHANGED" TO brBack IN FRAME default-frame.

    ASSIGN chProgressBar:VALUE = 0.

    ENABLE btRest WITH FRAME default-frame.

    SESSION:SET-WAIT-STATE("":U).

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


&Scoped-define SELF-NAME btRest
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRest C-Win
ON CHOOSE OF btRest IN FRAME DEFAULT-FRAME /* Restaurar Backup */
DO:

    DEFINE VARIABLE lOK AS LOGICAL    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Backup (036)', INPUT 'Deseja continuar ?', INPUT 'Todo o sistema voltar  ao estado em que estava em ' + STRING(tt-back.data,~'99/99/9999~') + '.')"}
    IF RETURN-VALUE = "NOK" THEN LEAVE.

    DO ON ERROR UNDO, LEAVE:
    
        SESSION:SET-WAIT-STATE("GENERAL":U).
      
        ASSIGN chProgressBar:Max = tt-back.tot-reg /* Controles da ProgressBar */.
    
        FOR EACH _file NO-LOCK
            WHERE _file._hidden = NO:
    
            OS-DELETE VALUE("temp\" + _file._dump-name + ".p").
            OUTPUT STREAM str-exec TO VALUE("temp\" + _file._dump-name + ".p").
            PUT STREAM str-exec UNFORMATTED "DEFINE INPUT PARAMETER hPrBar AS COM-HANDLE." SKIP
                            "DEFINE INPUT PARAMETER hDesc AS HANDLE." SKIP
                            "DEFINE STREAM str-back." SKIP
                            "DEFINE VARIABLE iCont AS INTEGER INITIAL 1." SKIP
                            "FOR EACH " + _file._file-name + ":" SKIP
                            "    ASSIGN hDesc:SCREEN-VALUE = ~"Deletando " + _file._file-name + " ~" + STRING(iCont)" SKIP
                            "           iCont = iCont + 1." SKIP
                            "    DELETE " + _file._file-name + "." SKIP
                            "END." SKIP
                            "    ASSIGN hDesc:SCREEN-VALUE = ~"~"." SKIP
                            "INPUT STREAM str-back FROM VALUE(~"" + tt-back.diretorio + "\" + _file._dump-name + ".d~")." SKIP
                            "REPEAT:" SKIP
                            "    ASSIGN hPrBar:VALUE = hPrBar:VALUE + 1" SKIP
                            "           hDesc:SCREEN-VALUE = ~"Registro " + _file._file-name + " ~" + STRING(INT(hPrBar:VALUE))." SKIP
                            "    CREATE " + _file._file-name + "." SKIP
                            "    IMPORT STREAM str-back " + _file._file-name + "." SKIP
                            "END." SKIP
                            "INPUT STREAM str-back CLOSE.".
            OUTPUT STREAM str-exec CLOSE.
            RUN VALUE("temp\" + _file._dump-name + ".p") (INPUT chProgressBar, INPUT descr:HANDLE).
    
            OS-DELETE VALUE("temp\" + _file._dump-name + ".p").
            
        END.
    
        ASSIGN chProgressBar:VALUE = 0.
    
        SESSION:SET-WAIT-STATE("":U).
    
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Backup (036)', INPUT 'Backup restaurado com sucesso!', INPUT 'O Backup selecionado foi restaurado sem erros.')"}
    
    END.

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
  {version.i backup}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load C-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "backup.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "backup.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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
  RUN control_load.
  DISPLAY descr 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btBack RECT-5 brBack btRest btExit brTab descr 
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
DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cValor AS CHARACTER  NO-UNDO.

SESSION:SET-WAIT-STATE("GENERAL":U).
INPUT FROM OS-DIR("backup").

REPEAT:
    IMPORT UNFORMATTED cTemp.
    IF ENTRY(3,cTemp," ") = "D" THEN DO:
        IF ENTRY(1,cTemp," ") <> "~".~""
        AND ENTRY(1,cTemp," ") <> "~"..~""  THEN DO:

            ASSIGN cTemp = TRIM(REPLACE(ENTRY(1,cTemp," "),"~"","")).

            CREATE tt-back.
            ASSIGN tt-back.data = DATE(INT(ENTRY(2,cTemp,"-")),INT(ENTRY(3,cTemp,"-")),INT(ENTRY(1,cTemp,"-")))
                   tt-back.diretorio = "backup\" + cTemp.


        END.
    END.
END.

INPUT CLOSE.
SESSION:SET-WAIT-STATE("":U).

/*OS-DELETE VALUE(SESSION:TEMP-DIRECTORY + "tmp.tmp").
DOS SILENT VALUE("DIR backup /B /A:D >> " + SESSION:TEMP-DIRECTORY + "tmp.tmp").
SESSION:SET-WAIT-STATE("":U).

IF SEARCH(SESSION:TEMP-DIRECTORY + "tmp.tmp") = ? THEN LEAVE.
INPUT FROM VALUE(SEARCH(SESSION:TEMP-DIRECTORY + "tmp.tmp")).

REPEAT:

    IMPORT cTemp.
    ASSIGN cTemp = TRIM(cTemp).
    CREATE tt-back.
    ASSIGN tt-back.data = DATE(INT(ENTRY(2,cTemp,"-")),INT(ENTRY(3,cTemp,"-")),INT(ENTRY(1,cTemp,"-")))
           tt-back.diretorio = "backup\" + cTemp.

END.

INPUT CLOSE.

OS-DELETE "temp\tmp.tmp".*/

FOR EACH tt-back:

    IF SEARCH(tt-back.diretorio + "\info.bin") <> ? THEN DO:
        INPUT FROM VALUE(SEARCH(tt-back.diretorio + "\info.bin")).

        REPEAT:

            IMPORT cTemp.
            ASSIGN cValor = ENTRY(2,TRIM(cTemp),"]").
            CASE ENTRY(2,ENTRY(1,cTemp,"]"),"["):

                WHEN "TOT_REG" THEN DO:
                    ASSIGN tt-back.tot-reg = INT(cValor).
                END.
                WHEN "TABELA" THEN DO:
                    CREATE tt-tab.
                    ASSIGN tt-tab.data = tt-back.data
                           tt-tab.tabela = ENTRY(1,cValor,"|")
                           tt-tab.tot-reg = INT(ENTRY(2,cValor,"|")).
                END.

            END CASE.

        END.

        INPUT CLOSE.

    END.

END.

{&OPEN-QUERY-brBack}
APPLY "VALUE-CHANGED" TO brBack IN FRAME default-frame.

IF NOT CAN-FIND(FIRST tt-back) THEN
    DISABLE btRest WITH FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initialize-controls C-Win 
PROCEDURE initialize-controls :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 assign chProgressBar = chctrlframe:ProgressBar.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

