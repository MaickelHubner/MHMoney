&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
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
DEFINE INPUT  PARAMETER rLote AS ROWID      NO-UNDO.

/* Local Variable Definitions ---                                       */

{seg.i}

def var chProgressBar       as com-handle no-undo.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-1 

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
DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE IMAGE IMAGE-1
     FILENAME "image/im-copia.bmp":U
     SIZE 6 BY 1.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btExit AT ROW 2.25 COL 53
     IMAGE-1 AT ROW 2.25 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 60.29 BY 4.38.


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
         HEIGHT             = 4.38
         WIDTH              = 60.29
         MAX-HEIGHT         = 29.67
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 29.67
         VIRTUAL-WIDTH      = 146.29
         SMALL-TITLE        = yes
         SHOW-IN-TASKBAR    = yes
         CONTROL-BOX        = no
         MIN-BUTTON         = no
         MAX-BUTTON         = no
         ALWAYS-ON-TOP      = yes
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
/* SETTINGS FOR BUTTON btExit IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 2.75
       COLUMN          = 11
       HEIGHT          = .75
       WIDTH           = 40
       HIDDEN          = no
       SENSITIVE       = yes.
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


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


&Scoped-define SELF-NAME btExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExit C-Win
ON CHOOSE OF btExit IN FRAME DEFAULT-FRAME /* Button 1 */
DO:
  
    {func\bt_fechar.i}

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
  {version.i implote}
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

OCXFile = SEARCH( "implote.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "implote.wrx":U SKIP(1)
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
  ENABLE IMAGE-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imp-lote C-Win 
PROCEDURE imp-lote :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE lFirst AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE lParam AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE qh   AS WIDGET-HANDLE.
    DEFINE VARIABLE cQuery AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE lPrim AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE lImpOK AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE bh AS WIDGET-HANDLE.
    DEFINE VARIABLE fh AS WIDGET-HANDLE.
    DEFINE VARIABLE cMess AS CHARACTER  NO-UNDO.

    IF lote.numero <> (param-mn.lote-imp + 1) THEN DO:
        ASSIGN cMess = "Pr¢ximo Lote a ser importado deve ser o de n£mero " + STRING(param-mn.lote-imp + 1).
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Importaá∆o de Movimentos (040)', INPUT 'Lote inv†lido!', INPUT cMess)"}
        APPLY "CLOSE" TO THIS-PROCEDURE.
        RETURN NO-APPLY.
    END.

    FIND CURRENT param-mn EXCLUSIVE-LOCK.
    ASSIGN lParam = param-mn.sincroniza
           param-mn.sincroniza = NO.

    FIND LAST lote-mov 
        WHERE lote-mov.numero = lote.numero
        AND   lote-mov.origem = lote.origem NO-LOCK NO-ERROR.
    IF AVAIL lote-mov THEN
        ASSIGN chProgressBar:Max = lote-mov.num-mov.

    FOR EACH lote-mov 
        WHERE lote-mov.numero = lote.numero
        AND   lote-mov.origem = lote.origem EXCLUSIVE-LOCK:
        ASSIGN chProgressBar:VALUE = lote-mov.num-mov
               lImpOK = NO.

        FIND FIRST money._file NO-LOCK
            WHERE money._file._file-name = lote-mov.tabela.
        CREATE BUFFER bh FOR TABLE lote-mov.tabela.

        CASE lote-mov.operacao:
            WHEN "DEL" THEN DO:

                CREATE QUERY qh.
                qh:SET-BUFFERS(bh).
                ASSIGN cQuery = "FOR EACH " + lote-mov.tabela + " EXCLUSIVE-LOCK"
                       lPrim = YES.
                FOR EACH lote-mov-campo OF lote-mov NO-LOCK
                    WHERE lote-mov-campo.chave:
                    IF lPrim THEN DO:
                        ASSIGN cQuery = cQuery + " WHERE "
                               lPrim = NO.
                    END.
                    ELSE DO:
                        ASSIGN cQuery = cQuery + " AND ".
                    END.
                    FIND FIRST money._field NO-LOCK
                        WHERE  money._field._file-recid = RECID(money._file)
                        AND    money._field._field-name = lote-mov-campo.campo.
                    ASSIGN cQuery = cQuery + lote-mov.tabela + "." + lote-mov-campo.campo + " = " + CAPS(money._field._data-type) + "(" + lote-mov-campo.antes + ")".
                END.
                qh:QUERY-PREPARE(cQuery).
                qh:QUERY-OPEN.
                qh:GET-FIRST.
                bh:BUFFER-DELETE().
                qh:QUERY-CLOSE().
                DELETE OBJECT qh.

                ASSIGN lImpOK = YES.

            END.
            WHEN "CRE" THEN DO:

                bh:BUFFER-CREATE.
                FOR EACH lote-mov-campo OF lote-mov NO-LOCK:
                    fh = bh:BUFFER-FIELD(lote-mov-campo.campo).
                    FIND FIRST money._field NO-LOCK
                        WHERE  money._field._file-recid = RECID(money._file)
                        AND    money._field._field-name = lote-mov-campo.campo.
                    CASE money._field._data-type:
                        WHEN "CHARACTER" THEN DO:
                            fh:BUFFER-VALUE = lote-mov-campo.antes.
                        END.
                        WHEN "DATE" THEN DO:
                            fh:BUFFER-VALUE = DATE(lote-mov-campo.antes).
                        END.
                        WHEN "DECIMAL" THEN DO:
                            fh:BUFFER-VALUE = DECIMAL(lote-mov-campo.antes).
                        END.
                        WHEN "INTEGER" THEN DO:
                            fh:BUFFER-VALUE = INTEGER(lote-mov-campo.antes).
                        END.
                        WHEN "LOGICAL" THEN DO:
                            IF lote-mov-campo.antes = "SIM" THEN
                                fh:BUFFER-VALUE = YES.
                            ELSE
                                fh:BUFFER-VALUE = NO.
                        END.
                    END CASE.                    
                END.
                DELETE WIDGET fh.
                
                ASSIGN lImpOK = YES.

            END.
            WHEN "UPD" THEN DO:

                CREATE QUERY qh.
                qh:SET-BUFFERS(bh).
                ASSIGN cQuery = "FOR EACH " + lote-mov.tabela + " EXCLUSIVE-LOCK"
                       lPrim = YES.
                FOR EACH lote-mov-campo OF lote-mov NO-LOCK
                    WHERE lote-mov-campo.chave:
                    IF lPrim THEN DO:
                        ASSIGN cQuery = cQuery + " WHERE "
                               lPrim = NO.
                    END.
                    ELSE DO:
                        ASSIGN cQuery = cQuery + " AND ".
                    END.
                    FIND FIRST money._field NO-LOCK
                        WHERE  money._field._file-recid = RECID(money._file)
                        AND    money._field._field-name = lote-mov-campo.campo.
                    ASSIGN cQuery = cQuery + lote-mov.tabela + "." + lote-mov-campo.campo + " = " + CAPS(money._field._data-type) + "(" + lote-mov-campo.antes + ")".
                END.
                qh:QUERY-PREPARE(cQuery).
                qh:QUERY-OPEN.
                qh:GET-FIRST.
                FOR EACH lote-mov-campo OF lote-mov NO-LOCK:
                    fh = bh:BUFFER-FIELD(lote-mov-campo.campo).
                    FIND FIRST money._field NO-LOCK
                        WHERE  money._field._file-recid = RECID(money._file)
                        AND    money._field._field-name = lote-mov-campo.campo.
                    CASE money._field._data-type:
                        WHEN "CHARACTER" THEN DO:
                            fh:BUFFER-VALUE = lote-mov-campo.depois.
                        END.
                        WHEN "DATE" THEN DO:
                            fh:BUFFER-VALUE = DATE(lote-mov-campo.depois).
                        END.
                        WHEN "DECIMAL" THEN DO:
                            fh:BUFFER-VALUE = DECIMAL(lote-mov-campo.depois).
                        END.
                        WHEN "INTEGER" THEN DO:
                            fh:BUFFER-VALUE = INTEGER(lote-mov-campo.depois).
                        END.
                        WHEN "LOGICAL" THEN DO:
                            fh:BUFFER-VALUE = LOGICAL(lote-mov-campo.depois).
                        END.
                    END CASE.                    
                END.
                qh:QUERY-CLOSE().
                DELETE OBJECT qh.
                DELETE WIDGET fh.

                ASSIGN lImpOK = YES.

            END.
        END CASE.
        DELETE WIDGET bh.
        IF lImpOK THEN DO:
            ASSIGN lote-mov.imp-ok = YES.
        END.
    END.

    ENABLE btExit WITH FRAME {&FRAME-NAME}.

    ASSIGN param-mn.sincroniza = lParam
           param-mn.lote-imp = lote.numero.

    FIND CURRENT lote EXCLUSIVE-LOCK.
    ASSIGN lote.importado = YES.

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

FIND FIRST lote NO-LOCK
    WHERE ROWID(lote) = rLote NO-ERROR.
IF NOT AVAIL lote THEN DO:
    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Importaá∆o de Movimentos (040)', INPUT 'Lote inv†lido!', INPUT 'O Lote informado n∆o se encontra cadastrado.')"}
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN "NOK":U.
END.

RUN imp-lote IN THIS-PROCEDURE.

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

