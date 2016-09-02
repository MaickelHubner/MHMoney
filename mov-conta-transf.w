&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

DEFINE INPUT PARAMETER iConta AS INTEGER     NO-UNDO INITIAL 3.
DEFINE INPUT PARAMETER rMovto AS ROWID       NO-UNDO.

/* Local Variable Definitions ---                                       */

{seg.i}
{cotacao.i}

DEFINE BUFFER bf-mov-conta FOR mov-conta.
DEFINE BUFFER bf-mov-conta-aux FOR mov-conta.
DEFINE BUFFER bf-ct-ori FOR conta.
DEFINE BUFFER bf-ct-dest FOR conta.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnTipo C-Win 
FUNCTION fnTipo RETURNS INTEGER
  ( iTipo-orig AS INT )  FORWARD.

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

DEFINE VARIABLE cb-dest AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Conta Destino" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 45 BY 1 NO-UNDO.

DEFINE VARIABLE cb-orig AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Conta Origem" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 45 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16 WIDGET-ID 100.

DEFINE FRAME FRAME-A
     btCancel AT ROW 4 COL 54.14 WIDGET-ID 12
     cb-orig AT ROW 1.75 COL 13 COLON-ALIGNED WIDGET-ID 6
     cb-dest AT ROW 2.75 COL 13 COLON-ALIGNED WIDGET-ID 8
     btOK AT ROW 4 COL 48 WIDGET-ID 14
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
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 5.42
         WIDTH              = 60.57
         MAX-HEIGHT         = 31.25
         MAX-WIDTH          = 182.86
         VIRTUAL-HEIGHT     = 31.25
         VIRTUAL-WIDTH      = 182.86
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
                                                                        */
/* SETTINGS FOR COMBO-BOX cb-orig IN FRAME FRAME-A
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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
    DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN INPUT FRAME frame-a cb-orig cb-dest.

    FIND FIRST bf-ct-ori NO-LOCK
        WHERE bf-ct-ori.cd-conta = cb-orig NO-ERROR.
    FIND FIRST bf-ct-dest NO-LOCK
        WHERE bf-ct-dest.cd-conta = cb-dest NO-ERROR.

    FIND LAST mov-conta NO-LOCK
        WHERE mov-conta.cd-conta = cb-dest NO-ERROR.
    IF AVAIL mov-conta THEN
        ASSIGN iSeq = mov-conta.cd-sequencia + 1.
    ELSE
        ASSIGN iSeq = 1.

    FIND FIRST mov-conta NO-LOCK
        WHERE ROWID(mov-conta) = rMovto NO-ERROR.
    IF AVAIL mov-conta THEN DO:
        RUN mudaMovto (INPUT rMovto,
                       INPUT cb-dest,
                       INPUT iSeq,
                       INPUT 0).
    END.

    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN "OK".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
  {version.i mov-conta-transf}
  RUN initialize.
  RUN enable_UI.
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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY cb-orig cb-dest 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  ENABLE btCancel cb-dest btOK 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
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

    DEFINE VARIABLE cLista AS CHARACTER   NO-UNDO INITIAL ",0".

    FOR EACH conta NO-LOCK
        WHERE NOT conta.id-encerrada:
        ASSIGN cLista = cLista + "," + conta.ds-conta + "," + STRING(conta.cd-conta).
    END.

    ASSIGN cb-orig:LIST-ITEM-PAIRS IN FRAME frame-a = cLista
           cb-dest:LIST-ITEM-PAIRS IN FRAME frame-a = cLista.

    ASSIGN cb-orig = iConta.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mudaMovto C-Win 
PROCEDURE mudaMovto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER prMovto AS ROWID       NO-UNDO.
    DEFINE INPUT  PARAMETER pConta  AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER pSeq    AS INTEGER     NO-UNDO.
    DEFINE INPUT  PARAMETER pSeqAg  AS INTEGER     NO-UNDO.

    DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO.

    FIND FIRST conta NO-LOCK
        WHERE conta.cd-conta = pConta NO-ERROR.
    IF NOT AVAIL conta THEN
        RETURN "NOK".

    FIND FIRST mov-conta EXCLUSIVE-LOCK
        WHERE ROWID(mov-conta) = prMovto NO-ERROR.
    IF NOT AVAIL mov-conta THEN
        RETURN "NOK".

    /* Se for um agrupamento */
    IF mov-conta.id-tipo = 0 THEN DO:
        /* Altera a conta tamb‚m dos movimentos agrupados */
        ASSIGN iSeq = pSeq + 1.
        FOR EACH bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
            AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
            RUN mudaMovto(INPUT ROWID(bf-mov-conta),
                          INPUT pConta,
                          INPUT iSeq,
                          INPUT pSeq).
            ASSIGN iSeq = iSeq + 1.
        END.
        FIND FIRST mov-conta EXCLUSIVE-LOCK
            WHERE ROWID(mov-conta) = prMovto NO-ERROR.
    END.

    /* Se estiver relacionado com bem */
    FOR EACH mov-bens OF mov-conta EXCLUSIVE-LOCK:
        ASSIGN mov-bens.cd-conta = pConta
               mov-bens.cd-sequencia = pSeq.
    END.

    /* Se for movimento reembolsado */
    IF mov-conta.de-valor >= 0 THEN DO:
        FOR EACH reembolso EXCLUSIVE-LOCK
            WHERE reembolso.cd-conta-de     = mov-conta.cd-conta
            AND   reembolso.cd-sequencia-de = mov-conta.cd-sequencia:
            ASSIGN reembolso.cd-conta-de = pConta
                   reembolso.cd-sequencia-de = pSeq.
        END.
    END.
    ELSE DO:
        FOR EACH reembolso EXCLUSIVE-LOCK
            WHERE reembolso.cd-conta-para     = mov-conta.cd-conta
            AND   reembolso.cd-sequencia-para = mov-conta.cd-sequencia:
            ASSIGN reembolso.cd-conta-para = pConta
                   reembolso.cd-sequencia-para = pSeq.
        END.
    END.

    /* Se estiver relacionado com imposto */
    FOR EACH nota-fiscal-imp EXCLUSIVE-LOCK
        WHERE nota-fiscal-imp.cd-conta = mov-conta.cd-conta
        AND   nota-fiscal-imp.cd-sequencia = mov-conta.cd-sequencia:
        ASSIGN nota-fiscal-imp.cd-conta = pConta
               nota-fiscal-imp.cd-sequencia = pSeq.
    END.

    /* Se for uma transferˆncia troca a conta do outro movimento tamb‚m */
    IF mov-conta.id-tipo = 3 THEN DO:
        FIND FIRST bf-mov-conta-aux 
            WHERE bf-mov-conta-aux.cd-conta     = mov-conta.conta-transf
            AND   bf-mov-conta-aux.cd-sequencia = mov-conta.seq-transf
            AND   bf-mov-conta-aux.conta-transf = mov-conta.cd-conta EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL bf-mov-conta-aux THEN DO:
            ASSIGN bf-mov-conta-aux.conta-transf = pConta
                   bf-mov-conta-aux.seq-transf = pSeq.
        END.
    END.

    ASSIGN mov-conta.cd-conta = pConta
           mov-conta.cd-sequencia = pSeq
           mov-conta.agrupado = pSeqAg
           mov-conta.id-tipo = fnTipo(mov-conta.id-tipo).

    IF mov-conta.cd-moeda <> conta.cd-moeda THEN DO:
        ASSIGN mov-conta.de-valor = fnCotacao(mov-conta.de-valor, mov-conta.cd-moeda, conta.cd-moeda, mov-conta.dt-mov).
               mov-conta.cd-moeda = conta.cd-moeda.
    END.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnTipo C-Win 
FUNCTION fnTipo RETURNS INTEGER
  ( iTipo-orig AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iTipo AS INTEGER     NO-UNDO.

    ASSIGN iTipo = iTipo-orig.

    IF bf-ct-ori.id-tipo <> bf-ct-dest.id-tipo THEN DO:
        IF iTipo-orig <> 0
        AND iTipo-orig <> 3 THEN DO:
            CASE bf-ct-ori.id-tipo:
                WHEN 1 THEN DO:
                    CASE bf-ct-dest.id-tipo:
                        WHEN 2 THEN DO:
                            CASE iTipo-orig:
                                WHEN 1 THEN ASSIGN iTipo = 1.
                                WHEN 4 THEN ASSIGN iTipo = 6.
                                WHEN 5 THEN ASSIGN iTipo = 6.
                                WHEN 6 THEN ASSIGN iTipo = 6.
                            END CASE.
                        END.
                        WHEN 3 THEN DO:
                            CASE iTipo-orig:
                                WHEN 1 THEN ASSIGN iTipo = 2.
                                WHEN 4 THEN ASSIGN iTipo = 7.
                                WHEN 5 THEN ASSIGN iTipo = 7.
                                WHEN 6 THEN ASSIGN iTipo = 7.
                            END CASE.
                        END.
                    END CASE.
                END.
                WHEN 2 THEN DO:
                    CASE bf-ct-dest.id-tipo:
                        WHEN 1 THEN DO:
                            CASE iTipo-orig:
                                WHEN 1 THEN ASSIGN iTipo = 1.
                                WHEN 6 THEN ASSIGN iTipo = 6.
                            END CASE.
                        END.
                        WHEN 3 THEN DO:
                            CASE iTipo-orig:
                                WHEN 1 THEN ASSIGN iTipo = 2.
                                WHEN 6 THEN ASSIGN iTipo = 7.
                            END CASE.
                        END.
                    END CASE.
                END.
                WHEN 3 THEN DO:
                    CASE bf-ct-dest.id-tipo:
                        WHEN 1 THEN DO:
                            CASE iTipo-orig:
                                WHEN 2 THEN ASSIGN iTipo = 1.
                                WHEN 7 THEN ASSIGN iTipo = 5.
                            END CASE.
                        END.
                        WHEN 2 THEN DO:
                            CASE iTipo-orig:
                                WHEN 2 THEN ASSIGN iTipo = 1.
                                WHEN 7 THEN ASSIGN iTipo = 6.
                            END CASE.
                        END.
                    END CASE.
                END.
            END CASE.
        END.
    END.

    RETURN iTipo.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

