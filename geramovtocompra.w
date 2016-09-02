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
DEFINE INPUT PARAMETER rCompra AS ROWID       NO-UNDO.

/* Local Variable Definitions ---                                       */
{func\definitions.i}
{campos\cd-conta.i}

DEFINE TEMP-TABLE tt-conta NO-UNDO
    FIELD cd-conta      LIKE conta.cd-conta COLUMN-LABEL "Conta"
    FIELD ds-conta      LIKE conta.ds-conta
    FIELD vl-conta      LIKE conta.vl-saldo COLUMN-LABEL "Valor"
    INDEX codigo IS PRIMARY
        cd-conta.

DEFINE TEMP-TABLE tt-agrup
    FIELD cod-categoria LIKE categoria.cod-categoria
    FIELD cd-sub LIKE sub-cat.cd-sub
    FIELD cd-conta LIKE conta.cd-conta COLUMN-LABEL "Conta"
    FIELD valor AS DECIMAL
    FIELD itens AS CHAR
    INDEX idx cod-categoria cd-sub.

DEFINE BUFFER b-conta FOR tt-conta.

DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME FRAME-A
&Scoped-define BROWSE-NAME brConta

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-conta

/* Definitions for BROWSE brConta                                       */
&Scoped-define FIELDS-IN-QUERY-brConta tt-conta.cd-conta tt-conta.ds-conta tt-conta.vl-conta   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brConta   
&Scoped-define SELF-NAME brConta
&Scoped-define QUERY-STRING-brConta FOR EACH tt-conta
&Scoped-define OPEN-QUERY-brConta OPEN QUERY {&SELF-NAME} FOR EACH tt-conta.
&Scoped-define TABLES-IN-QUERY-brConta tt-conta
&Scoped-define FIRST-TABLE-IN-QUERY-brConta tt-conta


/* Definitions for FRAME FRAME-A                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-A ~
    ~{&OPEN-QUERY-brConta}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel RECT-15 RECT-16 i-conta vl-parcela ~
brConta btIncluir btOK btRemove 
&Scoped-Define DISPLAYED-OBJECTS i-conta c-ds-conta vl-parcela ~
vl-tot-compra vl-saldo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
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

DEFINE BUTTON btIncluir 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79.

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "OK" 
     SIZE 6.14 BY 1.79.

DEFINE BUTTON btRemove 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Remove" 
     SIZE 6.14 BY 1.79.

DEFINE VARIABLE c-ds-conta AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY .79 NO-UNDO.

DEFINE VARIABLE i-conta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE vl-parcela AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79 NO-UNDO.

DEFINE VARIABLE vl-saldo AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Saldo Restante" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79 NO-UNDO.

DEFINE VARIABLE vl-tot-compra AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Total Compra" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 1.75.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 1.75.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brConta FOR 
      tt-conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brConta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brConta C-Win _FREEFORM
  QUERY brConta DISPLAY
      tt-conta.cd-conta
tt-conta.ds-conta
tt-conta.vl-conta
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ROW-MARKERS NO-TAB-STOP SIZE 60 BY 5.25
         FONT 1
         TITLE "Contas de Pagamento" ROW-HEIGHT-CHARS .58.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME FRAME-A
     btCancel AT ROW 10.75 COL 62 WIDGET-ID 28
     i-conta AT ROW 1.75 COL 9 COLON-ALIGNED WIDGET-ID 22
     c-ds-conta AT ROW 1.75 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     vl-parcela AT ROW 1.75 COL 49 COLON-ALIGNED WIDGET-ID 20
     brConta AT ROW 3.25 COL 2 WIDGET-ID 200
     vl-tot-compra AT ROW 9.25 COL 17 COLON-ALIGNED WIDGET-ID 26
     vl-saldo AT ROW 9.25 COL 49 COLON-ALIGNED WIDGET-ID 30
     btIncluir AT ROW 3.25 COL 62 WIDGET-ID 32
     btOK AT ROW 10.75 COL 56 WIDGET-ID 18
     btRemove AT ROW 5 COL 62 WIDGET-ID 16
     RECT-15 AT ROW 1.25 COL 2 WIDGET-ID 14
     RECT-16 AT ROW 8.75 COL 2 WIDGET-ID 34
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 68.57 BY 19.29
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
         TITLE              = "Movimentos Compra"
         HEIGHT             = 11.63
         WIDTH              = 67.72
         MAX-HEIGHT         = 34.88
         MAX-WIDTH          = 205.72
         VIRTUAL-HEIGHT     = 34.88
         VIRTUAL-WIDTH      = 205.72
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
/* SETTINGS FOR FRAME FRAME-A
   FRAME-NAME                                                           */
/* BROWSE-TAB brConta vl-parcela FRAME-A */
/* SETTINGS FOR FILL-IN c-ds-conta IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-saldo IN FRAME FRAME-A
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vl-tot-compra IN FRAME FRAME-A
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brConta
/* Query rebuild information for BROWSE brConta
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-conta.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brConta */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Movimentos Compra */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Movimentos Compra */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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


&Scoped-define SELF-NAME btIncluir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btIncluir C-Win
ON CHOOSE OF btIncluir IN FRAME FRAME-A /* Incluir */
DO:
    RUN geraMovto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME FRAME-A /* OK */
DO:
    DEFINE BUFFER btt-agrup    FOR tt-agrup.
    DEFINE BUFFER bf-mov-conta FOR mov-conta.
    DEFINE VARIABLE iSeq      AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iNumItens AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iTipo     AS INTEGER     NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    IF CAN-FIND(FIRST tt-conta) THEN DO:
        blk-trans:
        DO TRANSACTION:
            SESSION:SET-WAIT-STATE("image\calc.cur").

            EMPTY TEMP-TABLE tt-agrup.
            FOR EACH item-compra OF compra NO-LOCK
                BY item-compra.vl-total DESC:

                FIND FIRST item OF item-compra EXCLUSIVE-LOCK NO-ERROR.
    
                FIND FIRST tt-agrup
                    WHERE tt-agrup.cod-categoria = item.cod-categoria
                    AND   tt-agrup.cd-sub = item.cd-sub NO-ERROR.
                IF NOT AVAIL tt-agrup THEN DO:
                    CREATE tt-agrup.
                    ASSIGN tt-agrup.cod-categoria = item.cod-categoria
                           tt-agrup.cd-sub = item.cd-sub
                           tt-agrup.itens = "ITENS DA COMPRA:" + CHR(10) + 
                                            "================" + CHR(10) + CHR(10).
                END.
                ASSIGN tt-agrup.valor = tt-agrup.valor + item-compra.vl-total
                       tt-agrup.itens = tt-agrup.itens + STRING(item-compra.quantidade,">>>9.9999") + " " + item.unidade + " de " + item.ds-item + CHR(10).
    
                ASSIGN item.dt-ult-compra = compra.dt-compra.
                RUN calcRepItem.p (INPUT ROWID(item)).
            END.

            FOR EACH tt-conta
                BY tt-conta.vl-conta:

                blk_agrup:
                FOR EACH tt-agrup
                    WHERE tt-agrup.cd-conta = 0
                    BY tt-agrup.valor DESC:
                    
                    IF tt-agrup.valor > tt-conta.vl-conta THEN DO:
                        CREATE btt-agrup.
                        BUFFER-COPY tt-agrup TO btt-agrup.
                        ASSIGN btt-agrup.valor    = tt-conta.vl-conta
                               btt-agrup.cd-conta = tt-conta.cd-conta
                               tt-agrup.valor     = tt-agrup.valor - tt-conta.vl-conta.
                        LEAVE blk_agrup.
                    END.
                    ELSE DO:
                        ASSIGN tt-agrup.cd-conta = tt-conta.cd-conta
                               tt-conta.vl-conta = tt-conta.vl-conta - tt-agrup.valor.
                    END.
                END.
            END.

            FOR EACH tt-agrup
                BREAK BY tt-agrup.cd-conta:
                
                IF FIRST-OF(tt-agrup.cd-conta) THEN DO:

                    SESSION:SET-WAIT-STATE("image\calc.cur").

                    FIND FIRST conta NO-LOCK
                        WHERE conta.cd-conta = tt-agrup.cd-conta NO-ERROR.

                    FIND LAST bf-mov-conta OF conta NO-LOCK NO-ERROR.
                    IF AVAIL bf-mov-conta THEN
                        ASSIGN iSeq = bf-mov-conta.cd-sequencia + 1.
                    ELSE
                        ASSIGN iSeq = 1.

                    ASSIGN iNumItens = 0.
                    FOR EACH btt-agrup
                        WHERE btt-agrup.cd-conta = tt-agrup.cd-conta:
                        ASSIGN iNumItens = iNumItens + 1.
                    END.
    
                    IF iNumItens > 1 THEN DO:
                        CREATE mov-conta.
                        ASSIGN mov-conta.cd-conta = tt-agrup.cd-conta
                               mov-conta.cd-sequencia = iSeq
                               mov-conta.id-tipo = 0
                               mov-conta.id-situacao = 1
                               mov-conta.cd-favorecido = compra.cd-favorecido
                               mov-conta.dt-mov = compra.dt-compra
                               iSeq = iSeq + 1.
                    END.
    
    
                    FOR EACH btt-agrup
                        WHERE btt-agrup.cd-conta = tt-agrup.cd-conta:
    
                        CASE conta.id-tipo:
                            WHEN 1 THEN ASSIGN iTipo = 5.
                            WHEN 2 THEN ASSIGN iTipo = 6.
                            WHEN 3 THEN ASSIGN iTipo = 7.
                        END CASE.
        
                        CREATE bf-mov-conta.
                        ASSIGN bf-mov-conta.cd-conta      = tt-agrup.cd-conta
                               bf-mov-conta.cd-sequencia  = iSeq
                               bf-mov-conta.id-situacao   = 1
                               bf-mov-conta.id-tipo       = iTipo
                               bf-mov-conta.de-valor      = (-1) * btt-agrup.valor
                               bf-mov-conta.cd-favorecido = compra.cd-favorecido
                               bf-mov-conta.cod-categoria = btt-agrup.cod-categoria
                               bf-mov-conta.cd-sub        = btt-agrup.cd-sub
                               bf-mov-conta.ds-observacao = btt-agrup.itens
                               bf-mov-conta.dt-mov        = compra.dt-compra
                               iSeq                       = iSeq + 1.
        
                        IF iNumItens > 1 THEN DO:
                            ASSIGN bf-mov-conta.agrupado = mov-conta.cd-sequencia
                                   mov-conta.de-valor    = mov-conta.de-valor + bf-mov-conta.de-valor.
                        END.
                    END.

                    SESSION:SET-WAIT-STATE("").
                    ASSIGN r-mov-conta = IF iNumItens > 1 THEN ROWID(mov-conta) ELSE ROWID(bf-mov-conta)
                           r-parent = ROWID(conta)
                           pcActionBT = "UPDATE".
                    {func\run.i &Programa = "mov-conta_det.w"}
                    IF RETURN-VALUE <> "OK" THEN DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Gera‡Æo NOK (037)', INPUT 'Movimento cancelados!', INPUT 'O movimento de pagamento da compra atual foi cancelado pelo usu rio.')"}
                        UNDO blk-trans, LEAVE blk-trans.
                    END.

                END. /* FIRST-OF(tt-agrup.cd-conta) */

            END.

            FIND CURRENT compra EXCLUSIVE-LOCK.
            ASSIGN compra.gerada = YES.

            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Gera‡Æo OK (030)', INPUT 'Movimentos gerados com sucesso!', INPUT 'Foi gerado um movimento de pagamento para cada conta informada.')"}

        END. /*DO TRANSACTION*/

        APPLY "CLOSE" TO THIS-PROCEDURE.
        RETURN "OK".
    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Conta Inv lida (013)', INPUT 'NÆo foi informada conta v lida!', INPUT 'NÆo foi informada uma conta v lida no programa de Informa‡äes Adicionais para gerar o agrupamento.')"}
        RETURN "NOK".
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRemove
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRemove C-Win
ON CHOOSE OF btRemove IN FRAME FRAME-A /* Remove */
DO:
    RUN removeMovto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME i-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-conta C-Win
ON F5 OF i-conta IN FRAME FRAME-A /* Conta */
OR 'MOUSE-SELECT-DBLCLICK' OF i-conta IN FRAME FRAME-A /* Conta */ DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="i-conta"
                 &Campo2="ds-conta"
                 &Tela2="c-ds-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-conta C-Win
ON LEAVE OF i-conta IN FRAME FRAME-A /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                   &Campo="cd-conta"
                   &CampoTela="i-conta"
                   &CampoProc = "ds-conta"
                   &Tela="c-ds-conta"}
                
    ASSIGN INPUT FRAME {&FRAME-NAME} vl-saldo vl-parcela.

    ASSIGN vl-parcela = vl-saldo.

    DISPLAY vl-parcela WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vl-parcela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-parcela C-Win
ON RETURN OF vl-parcela IN FRAME FRAME-A /* Valor */
DO:
    APPLY 'CHOOSE' TO btIncluir.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brConta
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
  RUN enable_UI.
  {version.i geramovtocompra}
  RUN initialize.
  RUN displayFields.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculaTotal C-Win 
PROCEDURE calculaTotal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN vl-tot-compra = 0.
    FOR EACH item-compra OF compra NO-LOCK:
        ASSIGN vl-tot-compra = vl-tot-compra + item-compra.vl-total.
    END.

    ASSIGN vl-saldo = vl-tot-compra.

    DISPLAY vl-tot-compra vl-saldo WITH FRAME {&FRAME-NAME}.

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

    RUN calculaTotal.
   
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
  DISPLAY i-conta c-ds-conta vl-parcela vl-tot-compra vl-saldo 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  ENABLE btCancel RECT-15 RECT-16 i-conta vl-parcela brConta btIncluir btOK 
         btRemove 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraMovto C-Win 
PROCEDURE geraMovto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN INPUT FRAME {&FRAME-NAME} vl-parcela i-conta vl-saldo vl-tot-compra c-ds-conta.

    FIND FIRST conta NO-LOCK
        WHERE conta.cd-conta = i-conta NO-ERROR.
    
    IF AVAIL conta THEN DO:
        CREATE tt-conta.
        ASSIGN tt-conta.cd-conta      = conta.cd-conta
               tt-conta.ds-conta      = conta.ds-conta
               tt-conta.vl-conta      = vl-parcela.

        ASSIGN i-conta    = 0
               vl-parcela = 0
               c-ds-conta = ''.
    END.

    ASSIGN vl-saldo = vl-tot-compra.

    FOR EACH tt-conta:
        ASSIGN vl-saldo = vl-saldo - tt-conta.vl-conta.
    END.

    {&OPEN-QUERY-brConta}

    DISPLAY i-conta vl-saldo vl-parcela c-ds-conta WITH FRAME {&FRAME-NAME}.

    RETURN "OK".

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

/*     FIND FIRST conta NO-LOCK                */
/*         WHERE conta.cd-conta = 10 NO-ERROR. */
/*                                             */
/*     IF NOT AVAIL conta THEN                 */
/*        RETURN "NOK".                        */

    /*{func\cursor.i i-conta 1 FRAME-A}*/

    FIND FIRST compra NO-LOCK
        WHERE ROWID(compra) = rCompra NO-ERROR.

    IF NOT AVAIL compra THEN
       RETURN "NOK".   

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE removeMovto C-Win 
PROCEDURE removeMovto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    ASSIGN INPUT FRAME {&FRAME-NAME} vl-parcela i-conta vl-saldo vl-tot-compra c-ds-conta.

    FIND FIRST conta NO-LOCK
        WHERE conta.cd-conta = INPUT BROWSE brConta tt-conta.cd-conta NO-ERROR.
    
    IF AVAIL conta THEN DO:
        FOR FIRST tt-conta
            WHERE tt-conta.cd-conta = conta.cd-conta:
            DELETE tt-conta.
        END.
    END.

    ASSIGN vl-saldo = vl-tot-compra.

    FOR EACH tt-conta:
        ASSIGN vl-saldo = vl-saldo - tt-conta.vl-conta.
    END.

    DISPLAY i-conta vl-saldo vl-parcela c-ds-conta WITH FRAME {&FRAME-NAME}.

    {&OPEN-QUERY-brConta}

    RETURN "OK".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

