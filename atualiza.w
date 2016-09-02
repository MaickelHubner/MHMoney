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

DEFINE TEMP-TABLE tt-atu
    FIELD programa AS CHAR FORMAT "X(79)" COLUMN-LABEL "Programa"
    FIELD versao-prod AS CHAR FORMAT "X(12)" COLUMN-LABEL "Vrs Prod"
    FIELD versao-new AS CHAR FORMAT "X(12)" COLUMN-LABEL "Vrs Atu"
    INDEX idx-prog programa.

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAtu

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-atu

/* Definitions for BROWSE brAtu                                         */
&Scoped-define FIELDS-IN-QUERY-brAtu tt-atu.programa tt-atu.versao-prod tt-atu.versao-new   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAtu   
&Scoped-define SELF-NAME brAtu
&Scoped-define QUERY-STRING-brAtu FOR EACH tt-atu
&Scoped-define OPEN-QUERY-brAtu OPEN QUERY {&SELF-NAME} FOR EACH tt-atu.
&Scoped-define TABLES-IN-QUERY-brAtu tt-atu
&Scoped-define FIRST-TABLE-IN-QUERY-brAtu tt-atu


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brAtu}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-5 dir-prod dir-atu brAtu btVer ~
btExit c-info 
&Scoped-Define DISPLAYED-OBJECTS dir-prod dir-atu c-info 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAtu 
     IMAGE-UP FILE "image/im-copia.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-copia.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Atualizar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Atualizar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btVer 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Verifica Atualizaá‰es" 
     SIZE 6.14 BY 1.79 TOOLTIP "Verifica Atualizaá‰es".

DEFINE VARIABLE c-info AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 67 BY .67 NO-UNDO.

DEFINE VARIABLE dir-atu AS CHARACTER FORMAT "X(256)":U 
     LABEL "Diret¢rio de Atualizaá∆o" 
     VIEW-AS FILL-IN 
     SIZE 50 BY .79 NO-UNDO.

DEFINE VARIABLE dir-prod AS CHARACTER FORMAT "X(256)":U 
     LABEL "Diret¢rio do Produto" 
     VIEW-AS FILL-IN 
     SIZE 50 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAtu FOR 
      tt-atu SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAtu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAtu C-Win _FREEFORM
  QUERY brAtu DISPLAY
      tt-atu.programa
 tt-atu.versao-prod
 tt-atu.versao-new
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 78 BY 9.25
         FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAtu AT ROW 16.25 COL 74
     dir-prod AT ROW 4.25 COL 19 COLON-ALIGNED
     dir-atu AT ROW 5.25 COL 19 COLON-ALIGNED
     brAtu AT ROW 6.75 COL 2
     btVer AT ROW 4.25 COL 72
     btExit AT ROW 1.5 COL 73
     c-info AT ROW 16.75 COL 2 NO-LABEL
     RECT-1 AT ROW 3.75 COL 2
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 17.33
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
         TITLE              = "<insert window title>"
         HEIGHT             = 17.33
         WIDTH              = 80
         MAX-HEIGHT         = 29.75
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 29.75
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
   FRAME-NAME                                                           */
/* BROWSE-TAB brAtu dir-atu DEFAULT-FRAME */
ASSIGN 
       brAtu:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brAtu:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR BUTTON btAtu IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN c-info IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAtu
/* Query rebuild information for BROWSE brAtu
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-atu.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brAtu */
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


&Scoped-define BROWSE-NAME brAtu
&Scoped-define SELF-NAME brAtu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAtu C-Win
ON ROW-DISPLAY OF brAtu IN FRAME DEFAULT-FRAME
DO:
  
    IF tt-atu.versao-prod = tt-atu.versao-new THEN DO:
        ASSIGN tt-atu.programa:FGCOLOR IN BROWSE brAtu    = 7
               tt-atu.versao-prod:FGCOLOR IN BROWSE brAtu = 7
               tt-atu.versao-new:FGCOLOR IN BROWSE brAtu  = 7.
    END.
    IF tt-atu.versao-prod < tt-atu.versao-new THEN DO:
        ASSIGN tt-atu.programa:FGCOLOR IN BROWSE brAtu    = 9
               tt-atu.versao-prod:FGCOLOR IN BROWSE brAtu = 9
               tt-atu.versao-new:FGCOLOR IN BROWSE brAtu  = 9.
    END.
    IF tt-atu.versao-prod > tt-atu.versao-new THEN DO:
        ASSIGN tt-atu.programa:FGCOLOR IN BROWSE brAtu    = 5
               tt-atu.versao-prod:FGCOLOR IN BROWSE brAtu = 5
               tt-atu.versao-new:FGCOLOR IN BROWSE brAtu  = 5.
    END.
    IF tt-atu.versao-new = "" THEN DO:
        ASSIGN tt-atu.programa:FGCOLOR IN BROWSE brAtu    = 12
               tt-atu.versao-prod:FGCOLOR IN BROWSE brAtu = 12
               tt-atu.versao-new:FGCOLOR IN BROWSE brAtu  = 12.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAtu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAtu C-Win
ON CHOOSE OF btAtu IN FRAME DEFAULT-FRAME /* Atualizar */
DO:

    DEFINE VARIABLE cCaminho AS CHARACTER  NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    SESSION:SET-WAIT-STATE("GENERAL").

    OS-DELETE VALUE(dir-prod + "\atualiza.dat").
    OUTPUT TO VALUE(dir-prod + "\atualiza.dat").
    PUT UNFORMATTED dir-atu SKIP(2).
    OUTPUT CLOSE.

    OS-CREATE-DIR VALUE(dir-prod + "\graf").
    OS-CREATE-DIR VALUE(dir-prod + "\relat").
    OS-CREATE-DIR VALUE(dir-prod + "\zoom").

    FOR EACH tt-atu 
        WHERE tt-atu.versao-prod <> tt-atu.versao-new:

        ASSIGN c-info:SCREEN-VALUE = "Atualizando " + tt-atu.programa + " ...".

        ASSIGN cCaminho = dir-prod + "\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
        IF SEARCH(REPLACE(cCaminho,dir-prod,dir-atu)) = ?
        AND SEARCH(cCaminho) = ? THEN DO:
            ASSIGN cCaminho = dir-prod + "\graf\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
            IF SEARCH(REPLACE(cCaminho,dir-prod,dir-atu)) = ?
            AND SEARCH(cCaminho) = ? THEN DO:
                ASSIGN cCaminho = dir-prod + "\relat\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
                IF SEARCH(REPLACE(cCaminho,dir-prod,dir-atu)) = ?
                AND SEARCH(cCaminho) = ? THEN DO:
                    ASSIGN cCaminho = dir-prod + "\zoom\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
                    IF SEARCH(REPLACE(cCaminho,dir-prod,dir-atu)) = ?
                    AND SEARCH(cCaminho) = ? THEN DO:
                        NEXT.
                    END.
                END.
            END.
        END.

        IF tt-atu.versao-new = "" THEN DO:
            OS-DELETE VALUE(cCaminho).
        END.
        ELSE DO:
            OS-COPY VALUE(REPLACE(cCaminho,dir-prod,dir-atu)) VALUE(cCaminho).
            ASSIGN cCaminho = REPLACE(cCaminho,"." + ENTRY(2,cCaminho,"."),".wrx").
            IF SEARCH(REPLACE(cCaminho,dir-prod,dir-atu)) <> ? THEN DO:
                OS-COPY VALUE(REPLACE(cCaminho,dir-prod,dir-atu)) VALUE(cCaminho).
            END.
        END.

    END.

    RUN copyExtra.
    RUN copyDir (INPUT dir-atu + "\database").
    RUN copyDir (INPUT dir-atu + "\func").
    RUN copyDir (INPUT dir-atu + "\image").
    RUN copyDir (INPUT dir-atu + "\manual").
    RUN copyDir (INPUT dir-atu + "\util").

    ASSIGN c-info:SCREEN-VALUE = "Atualizando arquivo de vers∆o...".
    OS-COPY VALUE(dir-atu + "\version") VALUE(dir-prod + "\version").
    ASSIGN c-info:SCREEN-VALUE = "".

    SESSION:SET-WAIT-STATE("").

    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Atualizaá∆o Autom†tica (044)', INPUT 'Atualizaá∆o OK.', INPUT 'O MHMoney 2005 foi atualizado com sucesso.')"}

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


&Scoped-define SELF-NAME btVer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btVer C-Win
ON CHOOSE OF btVer IN FRAME DEFAULT-FRAME /* Verifica Atualizaá‰es */
DO:

    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cCaminho AS CHARACTER  NO-UNDO.

    RUN som.p(INPUT "music\click.wav").
    FOR EACH tt-atu:
        DELETE tt-atu.
    END.

    ASSIGN INPUT FRAME {&FRAME-NAME} dir-prod dir-atu.
  
    IF SEARCH(dir-prod + "\version") = ? THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Erro na Atualizaá∆o (044)', INPUT 'Diret¢rio inv†lido!', INPUT 'O diret¢rio de produto informado n∆o existe.')"}
        RETURN "NOK".
    END.
    IF SEARCH(dir-atu + "\version") = ? THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Erro na Atualizaá∆o (044)', INPUT 'Diret¢rio inv†lido!', INPUT 'O diret¢rio de atualizaá∆o informado n∆o existe.')"}
        RETURN "NOK".
    END.

    INPUT FROM VALUE(dir-prod + "\version").

    REPEAT:
        IMPORT UNFORMATTED cTemp.
        IF cTemp MATCHES("[PROGRAMA]*")
        OR cTemp MATCHES("[FUNÄ«O]*") THEN DO:
            CREATE tt-atu.
            ASSIGN tt-atu.programa = ENTRY(2,cTemp," ")
                   tt-atu.versao-prod = ENTRY(3,cTemp," ").
            ASSIGN cCaminho = dir-prod + "\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
            IF SEARCH(cCaminho) = ? THEN DO:
                ASSIGN cCaminho = dir-prod + "\graf\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
                IF SEARCH(cCaminho) = ? THEN DO:
                    ASSIGN cCaminho = dir-prod + "\relat\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
                    IF SEARCH(cCaminho) = ? THEN DO:
                        ASSIGN cCaminho = dir-prod + "\zoom\" + REPLACE(REPLACE(tt-atu.programa,".w",".r"),".p",".r").
                        IF SEARCH(cCaminho) = ? THEN DO:
                            ASSIGN tt-atu.versao-prod = "0.0.000".
                        END.
                    END.
                END.
            END.
        END.
    END.

    INPUT CLOSE.

    INPUT FROM VALUE(dir-atu + "\version").

    REPEAT:
        IMPORT UNFORMATTED cTemp.
        IF cTemp MATCHES("[PROGRAMA]*")
        OR cTemp MATCHES("[FUNÄ«O]*") THEN DO:
            FIND FIRST tt-atu
                WHERE tt-atu.programa = ENTRY(2,cTemp," ") NO-ERROR.
            IF NOT AVAIL tt-atu THEN DO:
                CREATE tt-atu.
                ASSIGN tt-atu.programa = ENTRY(2,cTemp," ").
            END.
            ASSIGN tt-atu.versao-new = ENTRY(3,cTemp," ").
        END.
    END.

    INPUT CLOSE.

    IF CAN-FIND(FIRST tt-atu) THEN DO:
        ENABLE btAtu WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE btAtu WITH FRAME {&FRAME-NAME}.
    END.

    {&OPEN-QUERY-brAtu}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dir-atu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dir-atu C-Win
ON ENTRY OF dir-atu IN FRAME DEFAULT-FRAME /* Diret¢rio de Atualizaá∆o */
DO:
    {func\set_entry.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dir-atu C-Win
ON LEAVE OF dir-atu IN FRAME DEFAULT-FRAME /* Diret¢rio de Atualizaá∆o */
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dir-prod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dir-prod C-Win
ON ENTRY OF dir-prod IN FRAME DEFAULT-FRAME /* Diret¢rio do Produto */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dir-prod C-Win
ON LEAVE OF dir-prod IN FRAME DEFAULT-FRAME /* Diret¢rio do Produto */
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
  {version.i atualiza}
  RUN initialize.
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copyDir C-Win 
PROCEDURE copyDir :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER cDir AS CHARACTER  NO-UNDO.

    ASSIGN c-info:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Copiando diret¢rio " + cDir + " ...".

    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cArq AS CHARACTER  NO-UNDO.

    OS-CREATE-DIR VALUE(REPLACE(cDir,dir-atu,dir-prod)).

    INPUT FROM OS-DIR(cDir).
    REPEAT:
        IMPORT UNFORMATTED cTemp.
        ASSIGN cArq = TRIM(ENTRY(2,cTemp,"~"")).
        /* Se for diret¢rio */
        IF SUBSTRING(cTemp,LENGTH(cTemp),1) = "D" THEN DO:
            IF cArq <> "."
            AND cArq <> ".." THEN DO:
                RUN copyDir (INPUT cDir + "\" + cArq).
            END.
        END.
        /* Se for arquivo */
        IF SUBSTRING(cTemp,LENGTH(cTemp),1) = "F" THEN DO:
            OS-COPY VALUE(cDir + "\" + cArq) VALUE(REPLACE(cDir,dir-atu,dir-prod) + "\" + cArq).
        END.
    END.
    INPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copyExtra C-Win 
PROCEDURE copyExtra :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN c-info:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Copiando extras ...".

    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cArq AS CHARACTER  NO-UNDO.

    INPUT FROM OS-DIR(dir-atu).
    REPEAT:
        IMPORT UNFORMATTED cTemp.
        ASSIGN cArq = TRIM(ENTRY(2,cTemp,"~"")).
        /* Se for arquivo */
        IF SUBSTRING(cTemp,LENGTH(cTemp),1) = "F" THEN DO:
            /* Se tiver extens∆o */
            IF NUM-ENTRIES(cArq,".") >= 2 THEN DO:
                /* Se n∆o for .r, .wrx, .lnk, .pf, .ini */
                IF  ENTRY(2,cArq,".") <> "r"
                AND ENTRY(2,cArq,".") <> "wrx"
                AND ENTRY(2,cArq,".") <> "lnk"
                AND ENTRY(2,cArq,".") <> "pf"
                AND ENTRY(2,cArq,".") <> "ini" THEN DO:
                    OS-COPY VALUE(dir-atu + "\" + cArq) VALUE(dir-prod + "\" + cArq).
                END.
            END.
        END.
    END.
    INPUT CLOSE.

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
  DISPLAY dir-prod dir-atu c-info 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 RECT-5 dir-prod dir-atu brAtu btVer btExit c-info 
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

    FIND FIRST param-mn NO-LOCK.
    ASSIGN dir-prod = param-mn.prod-dir.

    IF SEARCH(dir-prod + "\atualiza.dat") <> ? THEN DO:
        INPUT FROM VALUE(dir-prod + "\atualiza.dat").
        IMPORT UNFORMATTED dir-atu.
        INPUT CLOSE.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

