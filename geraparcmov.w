&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

DEFINE INPUT PARAMETER rMovto AS ROWID       NO-UNDO.

/* Local Variable Definitions ---                                       */
DEFINE TEMP-TABLE tt-Parcelas NO-UNDO
    FIELD cd-conta      LIKE mov-conta.cd-conta
    FIELD cd-sequencia  LIKE mov-conta.cd-sequencia
    FIELD tipo          LIKE mov-conta.id-tipo
    FIELD cd-favorecido LIKE mov-conta.cd-favorecido
    FIELD seq-parcela   AS INT COLUMN-LABEL "Parcela"
    FIELD dt-parcela    AS DATE COLUMN-LABEL "Data" FORMAT "99/99/9999"
    FIELD pc-parcela    AS DEC FORMAT ">>,>>9.9999" COLUMN-LABEL "%"
    FIELD val-parcela   AS DEC COLUMN-LABEL "Valor"
    INDEX codigo IS PRIMARY
        cd-conta
        cd-sequencia.

DEFINE VARIABLE l-calc-ok AS LOGICAL     NO-UNDO.

DEFINE BUFFER bf-parcelas FOR tt-parcelas.
DEFINE BUFFER bf-mov      FOR mov-conta.
DEFINE BUFFER bf-mov-bens FOR mov-bens.

{seg.i}
{func\data.i}
{campos\cd-favorecido.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME FRAME-A
&Scoped-define BROWSE-NAME brParc

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-parcelas

/* Definitions for BROWSE brParc                                        */
&Scoped-define FIELDS-IN-QUERY-brParc tt-parcelas.seq-parcela tt-parcelas.dt-parcela tt-parcelas.pc-parcela tt-parcelas.val-parcela   
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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel RECT-1 RECT-13 qtd-parc brParc ~
bt-recalc btOK 
&Scoped-Define DISPLAYED-OBJECTS c-favorecido i-seq dt-data d-valor ~
qtd-parc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-recalc 
     LABEL "Recalcular" 
     SIZE 10 BY 1
     FONT 1.

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

DEFINE VARIABLE c-favorecido AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Favorecido" 
     VIEW-AS FILL-IN 
     SIZE 30.72 BY .79 NO-UNDO.

DEFINE VARIABLE d-valor AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 10.57 BY .79
     BGCOLOR 21 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE dt-data AS DATE FORMAT "99/99/99":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 10.57 BY .79 NO-UNDO.

DEFINE VARIABLE i-seq AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Seq" 
     VIEW-AS FILL-IN 
     SIZE 10.57 BY .79 NO-UNDO.

DEFINE VARIABLE qtd-parc AS INTEGER FORMAT ">>9":U INITIAL 1 
     LABEL "Qde Parcelas" 
     VIEW-AS FILL-IN 
     SIZE 7.72 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 56.43 BY 2.5.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 56.43 BY 1.38.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brParc FOR 
      tt-parcelas SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brParc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brParc C-Win _FREEFORM
  QUERY brParc DISPLAY
      tt-parcelas.seq-parcela
tt-parcelas.dt-parcela
tt-parcelas.pc-parcela
tt-parcelas.val-parcela
ENABLE
tt-parcelas.pc-parcela
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 56 BY 8.25
         FONT 1 ROW-HEIGHT-CHARS .58 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME FRAME-A
     btCancel AT ROW 14 COL 52.14 WIDGET-ID 18
     c-favorecido AT ROW 1.5 COL 9.29 COLON-ALIGNED WIDGET-ID 60
     i-seq AT ROW 1.5 COL 44.43 COLON-ALIGNED WIDGET-ID 62
     dt-data AT ROW 2.5 COL 9.29 COLON-ALIGNED WIDGET-ID 68
     d-valor AT ROW 2.5 COL 44.43 COLON-ALIGNED WIDGET-ID 70
     qtd-parc AT ROW 4.13 COL 10.29 COLON-ALIGNED WIDGET-ID 14
     brParc AT ROW 5.33 COL 1.86 WIDGET-ID 200
     bt-recalc AT ROW 13.71 COL 2 WIDGET-ID 22
     btOK AT ROW 14 COL 46 WIDGET-ID 20
     RECT-1 AT ROW 1.25 COL 1.57 WIDGET-ID 2
     RECT-13 AT ROW 3.88 COL 1.57 WIDGET-ID 12
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 58.14 BY 14.88
         FONT 1 WIDGET-ID 100.


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
         HEIGHT             = 14.92
         WIDTH              = 58.14
         MAX-HEIGHT         = 16.13
         MAX-WIDTH          = 83.29
         VIRTUAL-HEIGHT     = 16.13
         VIRTUAL-WIDTH      = 83.29
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
/* SETTINGS FOR FRAME FRAME-A
   FRAME-NAME                                                           */
/* BROWSE-TAB brParc qtd-parc FRAME-A */
/* SETTINGS FOR FILL-IN c-favorecido IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN d-valor IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN dt-data IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN i-seq IN FRAME FRAME-A
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


&Scoped-define SELF-NAME bt-recalc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt-recalc C-Win
ON CHOOSE OF bt-recalc IN FRAME FRAME-A /* Recalcular */
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

    APPLY "CHOOSE" TO bt-Recalc.
    IF l-calc-ok THEN DO:
        
        RUN geraMov.
        
        APPLY "CLOSE" TO THIS-PROCEDURE.
        RETURN "OK".
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME qtd-parc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL qtd-parc C-Win
ON LEAVE OF qtd-parc IN FRAME FRAME-A /* Qde Parcelas */
DO:
  RUN geraParc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
    {version.i geraparcmov}
    RUN enable_UI.
    RUN initialize.
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

    FIND FIRST favorecido OF mov-conta NO-LOCK NO-ERROR.
    ASSIGN c-favorecido = favorecido.ds-favorecido
           dt-data      = mov-conta.dt-mov
           i-seq        = mov-conta.cd-sequencia
           d-valor      = mov-conta.de-valor.

    DISPLAY c-favorecido
            dt-data
            i-seq
            d-valor
        WITH FRAME {&FRAME-NAME}.

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
  DISPLAY c-favorecido i-seq dt-data d-valor qtd-parc 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  ENABLE btCancel RECT-1 RECT-13 qtd-parc brParc bt-recalc btOK 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraMov C-Win 
PROCEDURE geraMov :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE i-seq-mov  AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-seq-bens AS INTEGER     NO-UNDO.
    ASSIGN INPUT FRAME FRAME-A qtd-parc.

    FIND LAST bf-mov 
        WHERE bf-mov.cd-conta = mov-conta.cd-conta NO-ERROR.
    IF AVAIL bf-mov THEN
        ASSIGN i-seq-mov = bf-mov.cd-sequencia + 1.
    ELSE
        ASSIGN i-seq-mov = 1.

    FOR EACH tt-parcelas
        WHERE tt-parcelas.seq > 1:
    
        CREATE bf-mov.
        BUFFER-COPY mov-conta EXCEPT mov-conta.cd-sequencia TO bf-mov.
        ASSIGN  bf-mov.cd-sequencia  = i-seq-mov
                bf-mov.de-valor      = tt-parcelas.val-parcela        
                bf-mov.dt-mov        = tt-parcelas.dt-parcela
                bf-mov.ds-observacao = "Parcela " + STRING(tt-parcelas.seq) + " de " + STRING(qtd-parc) +  CHR(10) + CHR(10) + bf-mov.ds-observacao
                i-seq-mov            = i-seq-mov + 1.

        FOR EACH mov-bens OF mov-conta NO-LOCK:

            CREATE bf-mov-bens.
            BUFFER-COPY mov-bens EXCEPT mov-bens.cd-sequencia TO bf-mov-bens.
            ASSIGN  bf-mov-bens.cd-sequencia = bf-mov.cd-sequencia.

        END.

    END.

    FIND FIRST tt-parcelas.

    IF AVAIL mov-conta THEN DO:
        ASSIGN mov-conta.de-valor = tt-parcelas.val-parcela
               mov-conta.ds-observacao = "Parcela " + STRING(tt-parcelas.seq) + " de " + STRING(qtd-parc) +  CHR(10) + CHR(10) + mov-conta.ds-observacao.
    END.
    
    RETURN "OK".

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

    DEFINE VARIABLE iCont AS INTEGER      NO-UNDO.
    DEFINE VARIABLE iDia AS INTEGER       NO-UNDO.
    DEFINE VARIABLE iMes AS INTEGER       NO-UNDO.
    DEFINE VARIABLE iAno AS INTEGER       NO-UNDO.
    DEFINE VARIABLE dtAux AS DATETIME     NO-UNDO.
    DEFINE VARIABLE deAux AS DECIMAL FORMAT ">>,>>9.9999"     NO-UNDO.

    ASSIGN INPUT FRAME {&FRAME-NAME} qtd-parc.

    EMPTY TEMP-TABLE bf-parcelas.

    ASSIGN iDia = DAY(mov-conta.dt-mov)
           iMes = MONTH(mov-conta.dt-mov)
           iAno = YEAR(mov-conta.dt-mov).

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
        ASSIGN bf-parcelas.cd-conta      = mov-conta.cd-conta
               bf-parcelas.cd-sequencia  = mov-conta.cd-sequencia
               bf-parcelas.seq-parcela   = iCont
               bf-parcelas.dt-parcela    = dtAux
               bf-parcelas.cd-favorecido = mov-conta.cd-favorecido
               bf-parcelas.tipo          = mov-conta.id-tipo
               bf-parcelas.pc-parcela    = TRUNCATE((100 / qtd-parc),4).

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

   FIND FIRST mov-conta EXCLUSIVE-LOCK
        WHERE ROWID(mov-conta) = rMovto NO-ERROR.

   IF NOT AVAIL mov-conta THEN
       RETURN "NOK".

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
    
    FOR EACH bf-parcelas:
        ASSIGN bf-parcelas.val-parcela = TRUNCATE(((mov-conta.de-valor * bf-parcelas.pc-parcela) / 100), 2).
    END.

    ASSIGN deAux = 0.
    FOR EACH bf-parcelas:
        ASSIGN deAux = deAux + bf-parcelas.val-parcela.
    END.
    ASSIGN deAux = deAux - mov-conta.de-valor.

    FIND FIRST bf-parcelas.
    ASSIGN bf-parcelas.val-parcela = bf-parcelas.val-parcela - deAux.

    ASSIGN l-calc-ok = TRUE.
    
    {&OPEN-QUERY-brParc}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

