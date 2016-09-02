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

DEFINE INPUT  PARAMETER iConta AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER iSeq AS INTEGER    NO-UNDO.

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cFav AS CHARACTER   COLUMN-LABEL "Favorecido"    FORMAT "X(22)" NO-UNDO.
DEFINE VARIABLE cTipo AS CHARACTER  COLUMN-LABEL "Tipo"          FORMAT "X(17)" NO-UNDO.
DEFINE VARIABLE cCat AS CHARACTER   COLUMN-LABEL "Categoria"     FORMAT "X(23)" NO-UNDO.
DEFINE VARIABLE cSub AS CHARACTER   COLUMN-LABEL "Sub-Categoria" FORMAT "X(23)" NO-UNDO.

FIND FIRST mov-conta EXCLUSIVE-LOCK
    WHERE mov-conta.cd-conta = iConta
    AND   mov-conta.cd-sequencia = iSeq NO-ERROR.
IF NOT AVAIL mov-conta THEN RETURN "NOK".

DEFINE BUFFER bfMov2 FOR mov-conta.
DEFINE BUFFER bfMov FOR mov-conta.

{seg.i}

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
&Scoped-define BROWSE-NAME br-page1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES bfMov

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 fnDesc("F",bfMov.cd-favorecido,0) @ cFav fnDesc("T",bfMov.id-tipo,0) @ cTipo fnDesc("C",bfMov.cod-categoria,0) @ cCat fnDesc("S",bfMov.cod-categoria,bfMov.cd-sub) @ cSub bfMov.de-valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define QUERY-STRING-br-page1 FOR EACH bfMov NO-LOCK         WHERE bfMov.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta         AND   bfMov.agrupado = INPUT FRAME default-frame mov-conta.cd-sequencia
&Scoped-define OPEN-QUERY-br-page1 OPEN QUERY {&SELF-NAME}     FOR EACH bfMov NO-LOCK         WHERE bfMov.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta         AND   bfMov.agrupado = INPUT FRAME default-frame mov-conta.cd-sequencia.
&Scoped-define TABLES-IN-QUERY-br-page1 bfMov
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 bfMov


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btAdd-page1 RECT-10 RECT-11 br-page1 ~
btDel-page1 btUpdate-page1 btExit 
&Scoped-Define DISPLAYED-FIELDS mov-conta.cd-conta mov-conta.cd-sequencia ~
mov-conta.de-valor 
&Scoped-define DISPLAYED-TABLES mov-conta
&Scoped-define FIRST-DISPLAYED-TABLE mov-conta
&Scoped-Define DISPLAYED-OBJECTS ds-conta 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnDesc C-Win 
FUNCTION fnDesc RETURNS CHARACTER
  ( cOp AS CHAR, iInt1 AS INT, iInt2 AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd-page1 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btDel-page1 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE VARIABLE ds-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.25.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-page1 FOR 
      bfMov SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-page1 C-Win _FREEFORM
  QUERY br-page1 NO-LOCK DISPLAY
      fnDesc("F",bfMov.cd-favorecido,0) @ cFav
      fnDesc("T",bfMov.id-tipo,0) @ cTipo
      fnDesc("C",bfMov.cod-categoria,0) @ cCat
      fnDesc("S",bfMov.cod-categoria,bfMov.cd-sub) @ cSub
      bfMov.de-valor FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 78 BY 7.29
         FONT 1
         TITLE "Movimentos Agrupados".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAdd-page1 AT ROW 12.88 COL 2
     mov-conta.cd-conta AT ROW 4 COL 8 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     ds-conta AT ROW 4 COL 12.29 COLON-ALIGNED NO-LABEL
     mov-conta.cd-sequencia AT ROW 4 COL 41.57 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     mov-conta.de-valor AT ROW 4 COL 54 COLON-ALIGNED
          LABEL "Total"
          VIEW-AS FILL-IN 
          SIZE 22.29 BY .79
          BGCOLOR 21 FGCOLOR 15 
     br-page1 AT ROW 5.5 COL 2
     btDel-page1 AT ROW 12.88 COL 14.29
     btUpdate-page1 AT ROW 12.88 COL 8.14
     btExit AT ROW 1.5 COL 73
     RECT-10 AT ROW 1.25 COL 2
     RECT-11 AT ROW 3.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 13.67
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
         TITLE              = "Movimentos Agrupados"
         HEIGHT             = 13.67
         WIDTH              = 80
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
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
/* BROWSE-TAB br-page1 de-valor DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN mov-conta.cd-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN mov-conta.de-valor IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME}
    FOR EACH bfMov NO-LOCK
        WHERE bfMov.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta
        AND   bfMov.agrupado = INPUT FRAME default-frame mov-conta.cd-sequencia.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Movimentos Agrupados */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Movimentos Agrupados */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-page1
&Scoped-define SELF-NAME br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON DELETE-CHARACTER OF br-page1 IN FRAME DEFAULT-FRAME /* Movimentos Agrupados */
DO:

    APPLY "CHOOSE" TO btDel-page1 IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON MOUSE-SELECT-DBLCLICK OF br-page1 IN FRAME DEFAULT-FRAME /* Movimentos Agrupados */
DO:

    APPLY "CHOOSE" TO btUpdate-page1 IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON RETURN OF br-page1 IN FRAME DEFAULT-FRAME /* Movimentos Agrupados */
DO:

    APPLY "CHOOSE" TO btUpdate-page1 IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON ROW-DISPLAY OF br-page1 IN FRAME DEFAULT-FRAME /* Movimentos Agrupados */
DO:
    IF bfMov.id-tipo = 0 THEN
        ASSIGN cFav:FGCOLOR IN BROWSE br-page1 = 5
               cTipo:FGCOLOR IN BROWSE br-page1 = 5
               cCat:FGCOLOR IN BROWSE br-page1 = 5
               cSub:FGCOLOR IN BROWSE br-page1 = 5
               bfMov.de-valor:FGCOLOR IN BROWSE br-page1 = 5.

    IF bfMov.id-tipo = 3 THEN
        ASSIGN cFav:FGCOLOR IN BROWSE br-page1 = 3
               cTipo:FGCOLOR IN BROWSE br-page1 = 3
               cCat:FGCOLOR IN BROWSE br-page1 = 3
               cSub:FGCOLOR IN BROWSE br-page1 = 3
               bfMov.de-valor:FGCOLOR IN BROWSE br-page1 = 3.

    IF bfMov.id-tipo = 1
    OR bfMov.id-tipo = 2 THEN
        ASSIGN cFav:FGCOLOR IN BROWSE br-page1 = 1
               cTipo:FGCOLOR IN BROWSE br-page1 = 1
               cCat:FGCOLOR IN BROWSE br-page1 = 1
               cSub:FGCOLOR IN BROWSE br-page1 = 1
               bfMov.de-valor:FGCOLOR IN BROWSE br-page1 = 1.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    RUN som.p(INPUT "music\click.wav").

    IF NOT SELF:SENSITIVE IN FRAME {&FRAME-NAME} THEN RETURN.

    DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO.

    FIND LAST bfMov2 NO-LOCK
        WHERE bfMov2.cd-conta = mov-conta.cd-conta NO-ERROR.
    IF AVAIL bfMov2 THEN
        ASSIGN iSeq = bfMov2.cd-sequencia + 1.
    ELSE
        ASSIGN iSeq = 1.

    CREATE bfMov2.
    ASSIGN bfMov2.cd-conta = mov-conta.cd-conta
           bfMov2.cd-sequencia = iSeq
           bfMov2.agrupado = mov-conta.cd-sequencia
           bfMov2.dt-mov = mov-conta.dt-mov
           bfMov2.dt-compensacao = mov-conta.dt-compensacao
           bfMov2.id-situacao = mov-conta.id-situacao
           bfMov2.nr-mov = mov-conta.nr-mov
           bfMov2.cd-favorecido = mov-conta.cd-favorecido.

    FIND FIRST conta OF mov-conta NO-LOCK NO-ERROR.

    CASE conta.id-tipo:
        WHEN 1 THEN DO:
            ASSIGN bfMov2.id-tipo = 5.
        END.
        WHEN 2 THEN DO:
            ASSIGN bfMov2.id-tipo = 1.
        END.
        WHEN 3 THEN DO:
            ASSIGN bfMov2.id-tipo = 7.
        END.
    END CASE.

    ASSIGN pcActionBT = "UPDATE"
           r-parent = ROWID(conta)
           r-mov-conta = ROWID(bfMov2).
    {func\run.i &Programa = "mov-conta_det.w"}
    IF RETURN-VALUE = "OK" THEN DO:
        {&OPEN-QUERY-br-page1}
        RUN recalcula.
    END.
    ELSE DO:
        DELETE bfMov2.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
   
    RUN som.p(INPUT "music\click.wav").

    IF NOT SELF:SENSITIVE IN FRAME {&FRAME-NAME} THEN RETURN.

    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Elimina‡Æo de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma elimina‡Æo do registro ?')"}
    IF RETURN-VALUE = "OK":U THEN DO:
        FIND CURRENT bfMov EXCLUSIVE-LOCK.
        IF AVAIL bfMov THEN DO:
            IF bfMov.id-tipo = 3 THEN DO:
                FIND FIRST bfMov2 WHERE bfMov2.cd-conta    = bfMov.conta-transf
                                 AND   bfMov2.conta-transf = bfMov.cd-conta
                                 AND   bfMov2.cd-sequencia = bfMov.seq-transf EXCLUSIVE-LOCK NO-ERROR.
                IF AVAIL bfMov2 THEN
                    DELETE bfMov2.
            END.
            IF bfMov.id-tipo = 0 THEN DO:
                FOR EACH bfMov2 EXCLUSIVE-LOCK
                    WHERE bfMov2.cd-conta = bfMov.cd-conta
                    AND   bfMov2.agrupado = bfMov.cd-sequencia:
                    DELETE bfMov2.
                END.
            END.
            DELETE bfMov.
        END.

        RUN recalcula.
        {&OPEN-QUERY-br-page1}
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


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:
  
    RUN som.p(INPUT "music\click.wav").

    IF SELF:SENSITIVE IN FRAME {&FRAME-NAME} THEN DO:
        FIND FIRST conta OF mov-conta NO-LOCK NO-ERROR.

        ASSIGN pcActionBT = "UPDATE"
               r-parent = ROWID(conta)
               r-mov-conta = ROWID(bfMov).
        {func\run.i &Programa = "mov-conta_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-br-page1}
            RUN recalcula.
        END.
    END.
    ELSE DO:
        FIND FIRST conta OF mov-conta NO-LOCK NO-ERROR.
        ASSIGN pcActionBT = "DETAIL"
               r-parent = ROWID(conta)
               r-mov-conta = ROWID(bfMov).
        {func\run.i &Programa = "mov-conta_det.w"}
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
  {version.i agrup}
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
  DISPLAY ds-conta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE mov-conta THEN 
    DISPLAY mov-conta.cd-conta mov-conta.cd-sequencia mov-conta.de-valor 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btAdd-page1 RECT-10 RECT-11 br-page1 btDel-page1 btUpdate-page1 btExit 
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

ASSIGN C-Win:TOP-ONLY = YES.
FIND FIRST conta NO-LOCK
    WHERE conta.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta NO-ERROR.
IF AVAIL conta THEN
    ASSIGN ds-conta:SCREEN-VALUE IN FRAME default-frame = conta.ds-conta.

IF mov-conta.id-situacao <> 1 THEN
    DISABLE btAdd-page1
            btUpdate-page1
            btDel-page1 WITH FRAME default-frame.

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
        ASSIGN mov-conta.de-valor = 0.
        FOR EACH bfMov2 NO-LOCK
            WHERE bfMov2.cd-conta = mov-conta.cd-conta
            AND   bfMov2.agrupado = mov-conta.cd-sequencia:
            ASSIGN mov-conta.de-valor = mov-conta.de-valor + bfMov2.de-valor.
        END.
        DISPLAY mov-conta.de-valor WITH FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnDesc C-Win 
FUNCTION fnDesc RETURNS CHARACTER
  ( cOp AS CHAR, iInt1 AS INT, iInt2 AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO INITIAL "".

    CASE cOp:
        WHEN "F" THEN DO:
            FIND FIRST favorecido NO-LOCK
                WHERE favorecido.cd-favorecido = iInt1 NO-ERROR.
            IF AVAIL favorecido THEN
                ASSIGN cReturn = favorecido.ds-favorecido.
        END.
        WHEN "C" THEN DO:
            FIND FIRST categoria NO-LOCK
                WHERE categoria.cod-categoria = iInt1 NO-ERROR.
            IF AVAIL categoria THEN
                ASSIGN cReturn = categoria.ds-categoria.
        END.
        WHEN "S" THEN DO:
            FIND FIRST sub-cat NO-LOCK
                WHERE sub-cat.cod-categoria = iInt1 
                AND   sub-cat.cd-sub = iInt2 NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN cReturn = sub-cat.ds-sub.
        END.
        WHEN "T" THEN DO:
            FIND FIRST conta NO-LOCK 
                WHERE conta.cd-conta = INPUT FRAME default-frame mov-conta.cd-conta NO-ERROR.
            CASE iInt1:
                WHEN 4 THEN RETURN "Cheque".
                WHEN 1 THEN RETURN "Dep¢sito".
                WHEN 5 THEN RETURN "Pagamento".
                WHEN 6 THEN RETURN "Saque em Dinheiro".
                WHEN 3 THEN RETURN "Transferˆncia".
                WHEN 7 THEN DO:
                    IF conta.dinheiro THEN
                        RETURN "Gasto".
                    ELSE
                        RETURN "D‚bito".
                END.
                WHEN 2 THEN DO:
                    IF conta.dinheiro THEN
                        RETURN "Recebimento".
                    ELSE
                        RETURN "Cr‚dito".
                END.
            END CASE.
        END.
    END CASE.

    RETURN cReturn.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

