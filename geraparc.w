&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-parcelas NO-UNDO LIKE parc-nota-fiscal
       field pc-parcela as decimal.



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

DEFINE INPUT PARAMETER rNota AS ROWID       NO-UNDO.

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE l-calc-ok AS LOGICAL     NO-UNDO.

{seg.i}
{func\data.i}

DEFINE BUFFER bf-parcelas FOR tt-parcelas.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brParc

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-parcelas

/* Definitions for BROWSE brParc                                        */
&Scoped-define FIELDS-IN-QUERY-brParc tt-parcelas.sequencia tt-parcelas.dt-parcela tt-parcelas.pc-parcela tt-parcelas.val-parcela   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brParc tt-parcelas.pc-parcela   
&Scoped-define ENABLED-TABLES-IN-QUERY-brParc tt-parcelas
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-brParc tt-parcelas
&Scoped-define SELF-NAME brParc
&Scoped-define QUERY-STRING-brParc FOR EACH tt-parcelas NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brParc OPEN QUERY {&SELF-NAME} FOR EACH tt-parcelas NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brParc tt-parcelas
&Scoped-define FIRST-TABLE-IN-QUERY-brParc tt-parcelas


/* Definitions for FRAME FRAME-A                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-A ~
    ~{&OPEN-QUERY-brParc}

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnCalcData C-Win 
FUNCTION fnCalcData RETURNS DATE
  (i-fav AS INTEGER, data AS DATE, l-acerta-data AS LOG, l-add-dias-ut AS LOG)  FORWARD.

/* _UIB-CODE-BLOCK-END */
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

DEFINE BUTTON btRec 
     LABEL "Recalcular" 
     SIZE 10 BY 1.

DEFINE VARIABLE data-pri AS DATE FORMAT "99/99/9999":U 
     LABEL "Data Primeira Parcela" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE VARIABLE qtd-parc AS INTEGER FORMAT ">>9":U INITIAL 1 
     LABEL "Quantidade de Parcelas" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 7.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brParc FOR 
      tt-parcelas SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brParc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brParc C-Win _FREEFORM
  QUERY brParc NO-LOCK DISPLAY
      tt-parcelas.sequencia FORMAT ">>>9":U
tt-parcelas.dt-parcela FORMAT "99/99/9999":U
tt-parcelas.pc-parcela FORMAT ">>9.99" COLUMN-LABEL "%"
tt-parcelas.val-parcela FORMAT "->>,>>9.99":U
ENABLE
tt-parcelas.pc-parcela
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 33 BY 7
         FONT 1
         TITLE "Parcelas".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16 WIDGET-ID 100.

DEFINE FRAME FRAME-A
     btRec AT ROW 8.25 COL 33 WIDGET-ID 26
     btCancel AT ROW 8.5 COL 60.14 WIDGET-ID 12
     nota-fiscal.nr-controle AT ROW 2 COL 19 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 6.14 BY .79
     nota-fiscal.val-liquido AT ROW 3 COL 19 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 8.29 BY .79
     data-pri AT ROW 4.75 COL 19 COLON-ALIGNED WIDGET-ID 22
     qtd-parc AT ROW 5.75 COL 19 COLON-ALIGNED WIDGET-ID 24
     brParc AT ROW 1.25 COL 33 WIDGET-ID 300
     btOK AT ROW 8.5 COL 54 WIDGET-ID 14
     RECT-12 AT ROW 1.25 COL 2 WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16
         FONT 1 WIDGET-ID 200.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-parcelas T "?" NO-UNDO money parc-nota-fiscal
      ADDITIONAL-FIELDS:
          field pc-parcela as decimal
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
         HEIGHT             = 9.58
         WIDTH              = 66.29
         MAX-HEIGHT         = 31.25
         MAX-WIDTH          = 182.86
         VIRTUAL-HEIGHT     = 31.25
         VIRTUAL-WIDTH      = 182.86
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
/* REPARENT FRAME */
ASSIGN FRAME FRAME-A:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME FRAME-A
   Custom                                                               */
/* BROWSE-TAB brParc qtd-parc FRAME-A */
/* SETTINGS FOR FILL-IN nota-fiscal.nr-controle IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nota-fiscal.val-liquido IN FRAME FRAME-A
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brParc
/* Query rebuild information for BROWSE brParc
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-parcelas NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brParc */
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


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME FRAME-A /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN "NOK".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME FRAME-A /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").

    APPLY "CHOOSE" TO btRec.
    IF l-calc-ok THEN DO:
        FOR EACH tt-parcelas:
            CREATE parc-nota-fiscal.
            BUFFER-COPY tt-parcelas TO parc-nota-fiscal.
        END.

        APPLY "CLOSE" TO THIS-PROCEDURE.
        RETURN "OK".
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRec C-Win
ON CHOOSE OF btRec IN FRAME FRAME-A /* Recalcular */
DO:
    DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

    ASSIGN deAux = 0.
    FOR EACH bf-parcelas:
        ASSIGN deAux = deAux + bf-parcelas.pc-parcela.
    END.
    IF deAux <> 100.00 THEN DO:
        ASSIGN l-calc-ok = FALSE.
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Parcelas (053)', INPUT 'Percentuais inv lidos!', INPUT 'A somat¢ria dos percentuais das parcelas deve ser 100%')"}
    END.
    ELSE DO:
        RUN recalc.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data-pri
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data-pri C-Win
ON LEAVE OF data-pri IN FRAME FRAME-A /* Data Primeira Parcela */
DO:
    RUN geraParc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME qtd-parc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL qtd-parc C-Win
ON LEAVE OF qtd-parc IN FRAME FRAME-A /* Quantidade de Parcelas */
DO:
    RUN geraParc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brParc
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
  {version.i geraparc}
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

    RUN geraParc.    
    RUN recalc.

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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY data-pri qtd-parc 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  IF AVAILABLE nota-fiscal THEN 
    DISPLAY nota-fiscal.nr-controle nota-fiscal.val-liquido 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  ENABLE btRec btCancel data-pri qtd-parc brParc btOK RECT-12 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraParc C-Win 
PROCEDURE geraParc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iDia AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMes AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iAno AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dtAux AS DATE       NO-UNDO.
    DEFINE VARIABLE deAux AS DECIMAL    NO-UNDO.

    EMPTY TEMP-TABLE tt-parcelas.

    ASSIGN INPUT FRAME FRAME-A data-pri qtd-parc.

    ASSIGN iDia = DAY(data-pri)
           iMes = MONTH(data-pri)
           iAno = YEAR(data-pri).

    REPEAT iCont = 1 TO qtd-parc:

        CASE iDia:
            WHEN 29 OR WHEN 30 THEN DO:
                IF iMes = 2 THEN
                    ASSIGN dtAux = fnUltimoDia(iMes, iAno).
                ELSE
                    ASSIGN dtAux = DATE(iMes, iDia, iAno).
            END.
            WHEN 31 THEN DO:
                IF iMes = 2
                OR iMes = 4
                OR iMes = 6
                OR iMes = 9
                OR iMes = 11 THEN
                    ASSIGN dtAux = fnUltimoDia(iMes, iAno).
                ELSE
                    ASSIGN dtAux = DATE(iMes, iDia, iAno).
            END.
            OTHERWISE DO:
                ASSIGN dtAux = DATE(iMes, iDia, iAno).
            END.
        END CASE.

        CREATE bf-parcelas.
        ASSIGN bf-parcelas.nr-controle = nota-fiscal.nr-controle
               bf-parcelas.sequencia = iCont
               bf-parcelas.situacao = 1 /* Pendente */
               bf-parcelas.dt-parcela = fnProxDiaUtil(dtAux)
               bf-parcelas.dt-pagto-parc = fnCalcData(nota-fiscal.cd-favorecido, dtAux, FALSE, TRUE)
               bf-parcelas.pc-parcela = TRUNCATE((100 / qtd-parc), 2).

        ASSIGN iMes = iMes + 1.
        IF iMes > 12 THEN
            ASSIGN iMes = 1
                   iAno = iAno + 1.

    END.

    ASSIGN deAux = 100.00.
    FOR EACH bf-parcelas:
        ASSIGN deAux = deAux - bf-parcelas.pc-parcela.
    END.
    FIND FIRST bf-parcelas.
    ASSIGN bf-parcelas.pc-parcela = bf-parcelas.pc-parcela + deAux.

    RUN recalc.

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

    FIND FIRST nota-fiscal NO-LOCK
        WHERE ROWID(nota-fiscal) = rNota NO-ERROR.

    ASSIGN data-pri = fnCalcData(nota-fiscal.cd-favorecido,
                                 nota-fiscal.dt-emissao,
                                 TRUE,
                                 FALSE).

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

    DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = nota-fiscal.cd-favorecido NO-ERROR.
    IF favorecido.desconto-prim-parc THEN DO:
        FOR EACH bf-parcelas:
            ASSIGN bf-parcelas.val-parcela = TRUNCATE(((nota-fiscal.val-itens * bf-parcelas.pc-parcela) / 100), 2).
        END.
        FIND FIRST bf-parcelas.
        ASSIGN bf-parcelas.val-parcela = bf-parcelas.val-parcela - nota-fiscal.val-impostos.
    END.
    ELSE DO:
        FOR EACH bf-parcelas:
            ASSIGN bf-parcelas.val-parcela = TRUNCATE(((nota-fiscal.val-liquido * bf-parcelas.pc-parcela) / 100), 2).
        END.
    END.

    ASSIGN deAux = 0.
    FOR EACH bf-parcelas:
        ASSIGN deAux = deAux + bf-parcelas.val-parcela.
    END.
    ASSIGN deAux = deAux - nota-fiscal.val-liquido.
    FIND FIRST bf-parcelas.
    ASSIGN bf-parcelas.val-parcela = bf-parcelas.val-parcela - deAux.

    ASSIGN l-calc-ok = TRUE.

    {&OPEN-QUERY-brParc}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnCalcData C-Win 
FUNCTION fnCalcData RETURNS DATE
  (i-fav AS INTEGER, data AS DATE, l-acerta-data AS LOG, l-add-dias-ut AS LOG) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iAux      AS INTEGER NO-UNDO.
    DEFINE VARIABLE dt-return AS DATE    NO-UNDO.

    IF l-acerta-data THEN
        ASSIGN dt-return = DATE(MONTH(data), 1, YEAR(data)).
    ELSE
        ASSIGN dt-return = data.

    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.cd-favorecido = i-fav
        AND favorecido.dia-pagto-padrao <> 0 NO-ERROR.
    
    IF AVAIL favorecido THEN DO:

        IF l-acerta-data THEN DO:
            ASSIGN dt-return = DATE(MONTH(dt-return), favorecido.dia-pagto-padrao, YEAR(dt-return))
                   dt-return = fnProxDiaUtil(dt-return).
    
            IF favorecido.dia-semana-pagto <> 0 THEN DO:
                REPEAT iAux = 1 TO 2000:
                    IF WEEKDAY(dt-return) <> favorecido.dia-semana-pagto THEN DO:
                        ASSIGN dt-return = dt-return + 1
                               dt-return = fnProxDiaUtil(dt-return).
                    END.
                    ELSE
                        LEAVE.
                END.
            END.
        END.

        IF l-add-dias-ut THEN DO:
            REPEAT iAux = 1 TO favorecido.dias-uteis-pagto:
                ASSIGN dt-return = dt-return + 1
                       dt-return = fnProxDiaUtil(dt-return).
            END.
        END.

    END.

    RETURN dt-return.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

