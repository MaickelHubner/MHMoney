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

{seg.i}

DEFINE BUFFER bf-sub-cat FOR sub-cat.
DEFINE BUFFER bf-mov-conta FOR mov-conta.
DEFINE BUFFER bf-conta FOR conta.
DEFINE BUFFER bf-categoria FOR categoria.
DEFINE BUFFER bf-favorecido FOR favorecido.

DEFINE VARIABLE cMovCred AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cMovDeb AS CHARACTER  NO-UNDO.

DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE pcActionBT AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-Parent   AS ROWID      NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brCred

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES mov-conta conta categoria sub-cat favorecido ~
bf-mov-conta bf-favorecido bf-categoria bf-sub-cat bf-conta

/* Definitions for BROWSE brCred                                        */
&Scoped-define FIELDS-IN-QUERY-brCred mov-conta.dt-mov ~
favorecido.ds-favorecido categoria.ds-categoria sub-cat.ds-sub ~
conta.ds-conta mov-conta.de-valor 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brCred 
&Scoped-define QUERY-STRING-brCred FOR EACH mov-conta ~
      WHERE (LOOKUP(STRING(ROWID(mov-conta)),cMovCred) <> 0) NO-LOCK, ~
      EACH conta OF mov-conta NO-LOCK, ~
      EACH categoria OF mov-conta NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK, ~
      EACH favorecido OF mov-conta NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brCred OPEN QUERY brCred FOR EACH mov-conta ~
      WHERE (LOOKUP(STRING(ROWID(mov-conta)),cMovCred) <> 0) NO-LOCK, ~
      EACH conta OF mov-conta NO-LOCK, ~
      EACH categoria OF mov-conta NO-LOCK, ~
      EACH sub-cat OF mov-conta NO-LOCK, ~
      EACH favorecido OF mov-conta NO-LOCK ~
    BY mov-conta.dt-mov INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brCred mov-conta conta categoria sub-cat ~
favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-brCred mov-conta
&Scoped-define SECOND-TABLE-IN-QUERY-brCred conta
&Scoped-define THIRD-TABLE-IN-QUERY-brCred categoria
&Scoped-define FOURTH-TABLE-IN-QUERY-brCred sub-cat
&Scoped-define FIFTH-TABLE-IN-QUERY-brCred favorecido


/* Definitions for BROWSE brDeb                                         */
&Scoped-define FIELDS-IN-QUERY-brDeb bf-mov-conta.dt-mov bf-favorecido.ds-favorecido bf-categoria.ds-categoria bf-sub-cat.ds-sub bf-conta.ds-conta bf-mov-conta.de-valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brDeb   
&Scoped-define SELF-NAME brDeb
&Scoped-define QUERY-STRING-brDeb FOR EACH bf-mov-conta       WHERE (LOOKUP(STRING(ROWID(bf-mov-conta)), ~
      cMovDeb) <> 0) NO-LOCK, ~
             EACH bf-favorecido OF bf-mov-conta NO-LOCK, ~
             EACH bf-categoria OF bf-mov-conta NO-LOCK, ~
             EACH bf-sub-cat OF bf-mov-conta NO-LOCK, ~
             EACH bf-conta OF bf-mov-conta NO-LOCK     BY bf-mov-conta.dt-mov
&Scoped-define OPEN-QUERY-brDeb OPEN QUERY {&SELF-NAME} FOR EACH bf-mov-conta       WHERE (LOOKUP(STRING(ROWID(bf-mov-conta)), ~
      cMovDeb) <> 0) NO-LOCK, ~
             EACH bf-favorecido OF bf-mov-conta NO-LOCK, ~
             EACH bf-categoria OF bf-mov-conta NO-LOCK, ~
             EACH bf-sub-cat OF bf-mov-conta NO-LOCK, ~
             EACH bf-conta OF bf-mov-conta NO-LOCK     BY bf-mov-conta.dt-mov.
&Scoped-define TABLES-IN-QUERY-brDeb bf-mov-conta bf-favorecido ~
bf-categoria bf-sub-cat bf-conta
&Scoped-define FIRST-TABLE-IN-QUERY-brDeb bf-mov-conta
&Scoped-define SECOND-TABLE-IN-QUERY-brDeb bf-favorecido
&Scoped-define THIRD-TABLE-IN-QUERY-brDeb bf-categoria
&Scoped-define FOURTH-TABLE-IN-QUERY-brDeb bf-sub-cat
&Scoped-define FIFTH-TABLE-IN-QUERY-brDeb bf-conta


/* Definitions for FRAME DEFAULT-FRAME                                  */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btConf RECT-5 RECT-7 brCred brDeb btExit 
&Scoped-Define DISPLAYED-OBJECTS de-tot-cred de-tot-deb de-tot-dif 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnReemb C-Win 
FUNCTION fnReemb RETURNS LOGICAL
  ( rMov AS ROWID )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btConf 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Confirma" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirma Reembolso Selecionado".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE de-tot-cred AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total de Cr‚ditos Selecionados" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-deb AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total de D‚bitos Selecionados" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .79 NO-UNDO.

DEFINE VARIABLE de-tot-dif AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Diferen‡a" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .79
     BGCOLOR 9 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 105 BY 2.25.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 105 BY 4.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brCred FOR 
      mov-conta, 
      conta, 
      categoria, 
      sub-cat, 
      favorecido SCROLLING.

DEFINE QUERY brDeb FOR 
      bf-mov-conta, 
      bf-favorecido, 
      bf-categoria, 
      bf-sub-cat, 
      bf-conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brCred
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brCred C-Win _STRUCTURED
  QUERY brCred NO-LOCK DISPLAY
      mov-conta.dt-mov FORMAT "99/99/9999":U
      favorecido.ds-favorecido COLUMN-LABEL "Favorecido" FORMAT "X(40)":U
            WIDTH 20
      categoria.ds-categoria COLUMN-LABEL "Categoria" FORMAT "X(40)":U
            WIDTH 20
      sub-cat.ds-sub COLUMN-LABEL "Sub-Categoria" FORMAT "X(40)":U
            WIDTH 20
      conta.ds-conta COLUMN-LABEL "Conta" FORMAT "X(30)":U WIDTH 20
      mov-conta.de-valor FORMAT "->>>,>>>,>>9.99":U WIDTH 10
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 105 BY 5.79
         FONT 1
         TITLE "Cr‚ditos".

DEFINE BROWSE brDeb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brDeb C-Win _FREEFORM
  QUERY brDeb NO-LOCK DISPLAY
      bf-mov-conta.dt-mov FORMAT "99/99/9999":U
      bf-favorecido.ds-favorecido COLUMN-LABEL "Favorecido" FORMAT "X(40)":U
            WIDTH 20
      bf-categoria.ds-categoria COLUMN-LABEL "Categoria" FORMAT "X(40)":U
            WIDTH 20
      bf-sub-cat.ds-sub COLUMN-LABEL "Sub-Categoria" FORMAT "X(40)":U
            WIDTH 20
      bf-conta.ds-conta COLUMN-LABEL "Conta" FORMAT "X(30)":U WIDTH 20
      bf-mov-conta.de-valor FORMAT "->>>,>>>,>>9.99":U WIDTH 10
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 105 BY 5.79
         FONT 1
         TITLE "D‚bitos".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btConf AT ROW 17 COL 66
     brCred AT ROW 3.75 COL 2
     brDeb AT ROW 9.75 COL 2
     btExit AT ROW 1.5 COL 100
     de-tot-cred AT ROW 16.25 COL 46 COLON-ALIGNED
     de-tot-deb AT ROW 17.25 COL 46 COLON-ALIGNED
     de-tot-dif AT ROW 18.75 COL 46 COLON-ALIGNED
     RECT-5 AT ROW 1.25 COL 2
     RECT-7 AT ROW 15.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 107 BY 19.25
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
         HEIGHT             = 19.25
         WIDTH              = 107
         MAX-HEIGHT         = 19.25
         MAX-WIDTH          = 122.72
         VIRTUAL-HEIGHT     = 19.25
         VIRTUAL-WIDTH      = 122.72
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
/* BROWSE-TAB brCred RECT-7 DEFAULT-FRAME */
/* BROWSE-TAB brDeb brCred DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN de-tot-cred IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-deb IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN de-tot-dif IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brCred
/* Query rebuild information for BROWSE brCred
     _TblList          = "money.mov-conta,money.conta OF money.mov-conta,money.categoria OF money.mov-conta,money.sub-cat OF money.mov-conta,money.favorecido OF money.mov-conta"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.mov-conta.dt-mov|yes"
     _Where[1]         = "(LOOKUP(STRING(ROWID(mov-conta)),cMovCred) <> 0)"
     _FldNameList[1]   = money.mov-conta.dt-mov
     _FldNameList[2]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Favorecido" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[3]   > money.categoria.ds-categoria
"categoria.ds-categoria" "Categoria" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[4]   > money.sub-cat.ds-sub
"sub-cat.ds-sub" "Sub-Categoria" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[5]   > money.conta.ds-conta
"conta.ds-conta" "Conta" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[6]   > money.mov-conta.de-valor
"mov-conta.de-valor" ? ? "decimal" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brCred */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brDeb
/* Query rebuild information for BROWSE brDeb
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH bf-mov-conta
      WHERE (LOOKUP(STRING(ROWID(bf-mov-conta)),cMovDeb) <> 0) NO-LOCK,
      EACH bf-favorecido OF bf-mov-conta NO-LOCK,
      EACH bf-categoria OF bf-mov-conta NO-LOCK,
      EACH bf-sub-cat OF bf-mov-conta NO-LOCK,
      EACH bf-conta OF bf-mov-conta NO-LOCK
    BY bf-mov-conta.dt-mov.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.mov-conta.dt-mov|yes"
     _Where[1]         = "sub-cat.reembolso = TRUE"
     _JoinCode[2]      = "sub-cat.reembolso = TRUE
 AND "
     _Where[2]         = "mov-conta.de-valor < 0"
     _Query            is NOT OPENED
*/  /* BROWSE brDeb */
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


&Scoped-define BROWSE-NAME brCred
&Scoped-define SELF-NAME brCred
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCred C-Win
ON MOUSE-SELECT-DBLCLICK OF brCred IN FRAME DEFAULT-FRAME /* Cr‚ditos */
OR RETURN OF brCred DO:

    IF AVAIL mov-conta THEN DO:
        ASSIGN r-mov-conta = ROWID(mov-conta)
               r-Parent = ROWID(conta)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "mov-conta_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN setaQuery IN THIS-PROCEDURE.
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCred C-Win
ON VALUE-CHANGED OF brCred IN FRAME DEFAULT-FRAME /* Cr‚ditos */
DO:
  
    RUN recalcula IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brDeb
&Scoped-define SELF-NAME brDeb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brDeb C-Win
ON MOUSE-SELECT-DBLCLICK OF brDeb IN FRAME DEFAULT-FRAME /* D‚bitos */
OR RETURN OF brCred DO:

    IF AVAIL bf-mov-conta THEN DO:
        ASSIGN r-mov-conta = ROWID(bf-mov-conta)
               r-Parent = ROWID(bf-conta)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "mov-conta_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN setaQuery IN THIS-PROCEDURE.
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brDeb C-Win
ON VALUE-CHANGED OF brDeb IN FRAME DEFAULT-FRAME /* D‚bitos */
DO:
  
    RUN recalcula IN THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btConf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btConf C-Win
ON CHOOSE OF btConf IN FRAME DEFAULT-FRAME /* Confirma */
DO:

    DEFINE VARIABLE l-ok AS LOGICAL    NO-UNDO INITIAL YES.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iCont2 AS INTEGER    NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").

    IF brCred:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} < 1 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Controle de Reembolsos (042)', INPUT 'Nenhum cr‚dito selecionado!', INPUT 'Vocˆ deve selecionhar no m¡nimo um cr‚dito para o reembolso.')"}
        ASSIGN l-ok = NO.
    END.

    IF l-ok THEN DO:
        IF brDeb:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} < 1 THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Controle de Reembolsos (042)', INPUT 'Nenhum d‚bito selecionado!', INPUT 'Vocˆ deve selecionhar no m¡nimo um d‚bito para o reembolso.')"}
            ASSIGN l-ok = NO.
        END.
    END.

    IF l-ok THEN DO:
        IF de-tot-dif <> 0 THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Controle de Reembolsos (042)', INPUT 'Valores nÆo exatos. Deseja continuar ?', INPUT 'Os cr‚ditos e d‚bitos selecionados tem valores diferentes. Deseja continuar efetuando o reembolso apesar disso ?')"}
            IF RETURN-VALUE = "NOK" THEN
                ASSIGN l-ok = NO.
        END.
    END.

    IF l-ok THEN DO:

        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Controle de Reembolsos (042)', INPUT 'Confirma reembolso ?', INPUT 'Ap¢s confirmado o reembolso nÆo poder  ser desfeito.')"}
        IF RETURN-VALUE = "OK" THEN DO:

            SESSION:SET-WAIT-STATE("image\importa.cur").

            /* Gera o Reembolso */
            REPEAT iCont = 1 TO brCred:NUM-SELECTED-ROWS:
                brCred:FETCH-SELECTED-ROW(iCont).

                REPEAT iCont2 = 1 TO brDeb:NUM-SELECTED-ROWS:
                    brDeb:FETCH-SELECTED-ROW(iCont2).

                    CREATE reembolso.
                    ASSIGN reembolso.cd-conta-de       = mov-conta.cd-conta
                           reembolso.cd-sequencia-de   = mov-conta.cd-sequencia
                           reembolso.cd-conta-para     = bf-mov-conta.cd-conta
                           reembolso.cd-sequencia-para = bf-mov-conta.cd-sequencia.

                END.

            END.
            RUN setaQuery IN THIS-PROCEDURE.

            SESSION:SET-WAIT-STATE("").

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


&Scoped-define BROWSE-NAME brCred
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
  {version.i reembolsa}
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
  DISPLAY de-tot-cred de-tot-deb de-tot-dif 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btConf RECT-5 RECT-7 brCred brDeb btExit 
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

    SESSION:SET-WAIT-STATE("GENERAL").
    RUN setaQuery IN THIS-PROCEDURE.
    SESSION:SET-WAIT-STATE("").

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

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

    ASSIGN de-tot-cred = 0.
    IF brCred:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} > 0 THEN DO:
        REPEAT iCont = 1 TO brCred:NUM-SELECTED-ROWS:
            brCred:FETCH-SELECTED-ROW(iCont).
            ASSIGN de-tot-cred = de-tot-cred + mov-conta.de-valor.
        END.
    END.

    ASSIGN de-tot-deb = 0.
    IF brDeb:NUM-SELECTED-ROWS IN FRAME {&FRAME-NAME} > 0 THEN DO:
        REPEAT iCont = 1 TO brDeb:NUM-SELECTED-ROWS:
            brDeb:FETCH-SELECTED-ROW(iCont).
            ASSIGN de-tot-deb = de-tot-deb + bf-mov-conta.de-valor.
        END.
    END.

    ASSIGN de-tot-dif = de-tot-cred + de-tot-deb.

    DISPLAY de-tot-cred
            de-tot-deb
            de-tot-dif
            WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setaQuery C-Win 
PROCEDURE setaQuery :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN cMovCred = ""
           cMovDeb = "".
    FOR EACH sub-cat
      WHERE sub-cat.reembolso NO-LOCK,
      EACH mov-conta OF sub-cat NO-LOCK:

        IF CAN-FIND(FIRST reembolso
                    WHERE reembolso.cd-conta-de     = mov-conta.cd-conta
                    AND   reembolso.cd-sequencia-de = mov-conta.cd-sequencia) THEN NEXT.
        IF CAN-FIND(FIRST reembolso
                    WHERE reembolso.cd-conta-para     = mov-conta.cd-conta
                    AND   reembolso.cd-sequencia-para = mov-conta.cd-sequencia) THEN NEXT.

        IF mov-conta.de-valor >= 0 THEN DO:
            ASSIGN cMovCred = cMovCred + "," + STRING(ROWID(mov-conta)).
        END.
        ELSE DO:
            ASSIGN cMovDeb = cMovDeb + "," + STRING(ROWID(mov-conta)).
        END.

    END.

    {&OPEN-QUERY-brCred}
    {&OPEN-QUERY-brDeb}
    RUN recalcula IN THIS-PROCEDURE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnReemb C-Win 
FUNCTION fnReemb RETURNS LOGICAL
  ( rMov AS ROWID ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE BUFFER bf-mov FOR mov-conta.

    FIND FIRST bf-mov NO-LOCK
        WHERE ROWID(bf-mov) = rMov NO-ERROR.
    IF AVAIL bf-mov THEN DO:
        IF CAN-FIND(FIRST reembolso NO-LOCK
                    WHERE reembolso.cd-conta-de     = bf-mov.cd-conta
                    AND   reembolso.cd-sequencia-de = bf-mov-conta.cd-sequencia) THEN DO:
            RETURN TRUE.
        END.
        IF CAN-FIND(FIRST reembolso NO-LOCK
                    WHERE reembolso.cd-conta-para     = bf-mov.cd-conta
                    AND   reembolso.cd-sequencia-para = bf-mov-conta.cd-sequencia) THEN DO:
            RETURN TRUE.
        END.
    END.

    RETURN FALSE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

