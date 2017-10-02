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

DEFINE TEMP-TABLE tt-item LIKE ITEM
    FIELD dt-prox AS DATE FORMAT "99/99/9999" COLUMN-LABEL "Pr¢xima Compra"
    FIELD qt-ult AS DEC
    INDEX cod cd-item.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brProx

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-item

/* Definitions for BROWSE brProx                                        */
&Scoped-define FIELDS-IN-QUERY-brProx tt-item.ds-item tt-item.reposicao tt-item.dt-ult-compra tt-item.dt-prox   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brProx   
&Scoped-define SELF-NAME brProx
&Scoped-define QUERY-STRING-brProx FOR EACH tt-item NO-LOCK BY tt-item.ds-item
&Scoped-define OPEN-QUERY-brProx OPEN QUERY {&SELF-NAME} FOR EACH tt-item NO-LOCK BY tt-item.ds-item.
&Scoped-define TABLES-IN-QUERY-brProx tt-item
&Scoped-define FIRST-TABLE-IN-QUERY-brProx tt-item


/* Definitions for FRAME DEFAULT-FRAME                                  */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btAtu RECT-5 brProx btInv btExit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAtu 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Atu" 
     SIZE 6.14 BY 1.79 TOOLTIP "Atualizar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btInv 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Inv" 
     SIZE 6.14 BY 1.79 TOOLTIP "Definir data da pr¢xima compra".

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 64 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brProx FOR 
      tt-item SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brProx
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brProx C-Win _FREEFORM
  QUERY brProx NO-LOCK DISPLAY
      tt-item.ds-item FORMAT "X(80)":U WIDTH 27
      tt-item.reposicao FORMAT "->>,>>9.9999":U
      tt-item.dt-ult-compra FORMAT "99/99/9999":U
      tt-item.dt-prox
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 64 BY 10.75
         FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAtu AT ROW 1.5 COL 3
     brProx AT ROW 3.75 COL 2
     btInv AT ROW 14.5 COL 2
     btExit AT ROW 1.5 COL 59
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 66 BY 15.29
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
         HEIGHT             = 15.29
         WIDTH              = 66
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
/* BROWSE-TAB brProx RECT-5 DEFAULT-FRAME */
ASSIGN 
       brProx:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brProx:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brProx
/* Query rebuild information for BROWSE brProx
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-item NO-LOCK BY tt-item.ds-item.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ", LAST, FIRST"
     _Query            is NOT OPENED
*/  /* BROWSE brProx */
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


&Scoped-define BROWSE-NAME brProx
&Scoped-define SELF-NAME brProx
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brProx C-Win
ON MOUSE-SELECT-DBLCLICK OF brProx IN FRAME DEFAULT-FRAME
DO:
  
    APPLY "CHOOSE" TO btInv IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brProx C-Win
ON RETURN OF brProx IN FRAME DEFAULT-FRAME
DO:
  
    APPLY "CHOOSE" TO btInv IN FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAtu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAtu C-Win
ON CHOOSE OF btAtu IN FRAME DEFAULT-FRAME /* Atu */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Atualiza‡Æo de Item (045)', INPUT 'Confirma atualiza‡Æo ?', INPUT 'Confirma atualiza‡Æo dos itens ?')"}
    IF RETURN-VALUE = "OK":U THEN DO:
        SESSION:SET-WAIT-STATE("image\calc.cur").
        FOR EACH tt-item:

            FIND FIRST ITEM OF tt-item EXCLUSIVE-LOCK.
            IF tt-item.dt-prox <> ?
            AND tt-item.dt-prox > TODAY THEN DO:
                ASSIGN ITEM.reposicao = ((tt-item.dt-prox - ITEM.dt-ult-compra) / tt-item.qt-ult).
            END.
            DELETE tt-item.

        END.
        RUN criaTT.
        RUN displayFields.
        SESSION:SET-WAIT-STATE("").
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


&Scoped-define SELF-NAME btInv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btInv C-Win
ON CHOOSE OF btInv IN FRAME DEFAULT-FRAME /* Inv */
DO:
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").
    IF AVAIL tt-item THEN DO:

        {func\run.i &Programa = "data.w (INPUT 'Data do Movimento', INPUT tt-item.dt-prox, OUTPUT dtTemp)"}
        IF dtTemp <> ? AND dtTemp >= TODAY THEN DO:
            ASSIGN tt-item.dt-prox = dtTemp.
        END.
        DISPLAY tt-item.dt-prox WITH BROWSE brProx.

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
  {version.i invent}
  RUN initialize.
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaTT C-Win 
PROCEDURE criaTT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE rCompra AS ROWID      NO-UNDO.
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    SESSION:SET-WAIT-STATE("image\calc.cur").

    FOR EACH item NO-LOCK
        WHERE item.controlado:

        IF item.dt-ult-compra = ? THEN NEXT.
        IF item.reposicao = 0 THEN NEXT.

        FOR LAST compra NO-LOCK
            WHERE CAN-FIND(FIRST item-compra OF compra
                           WHERE item-compra.cd-item = item.cd-item)
            BY compra.dt-compra:
            ASSIGN rCompra = ROWID(compra).
        END.
        FIND FIRST compra NO-LOCK 
            WHERE ROWID(compra) = rCompra NO-ERROR.
        IF NOT AVAIL compra THEN NEXT.

        FIND FIRST item-compra OF compra
            WHERE item-compra.cd-item = item.cd-item NO-LOCK NO-ERROR.
        ASSIGN dtTemp = item.dt-ult-compra + INT(item.reposicao * item-compra.quantidade).

        IF INT(TODAY - item.dt-ult-compra) > (INT(dtTemp - item.dt-ult-compra) * 2) THEN NEXT.

        IF dtTemp > TODAY THEN NEXT.

        CREATE tt-item.
        BUFFER-COPY item TO tt-item.
        ASSIGN tt-item.dt-prox = item.dt-ult-compra + (item-compra.quantidade * item.reposicao)
               tt-item.qt-ult = item-compra.quantidade.

    END.    

    SESSION:SET-WAIT-STATE("").

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

    {&OPEN-QUERY-brProx}

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
  ENABLE btAtu RECT-5 brProx btInv btExit 
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

    RUN criaTT.
    RUN displayFields.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

