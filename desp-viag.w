&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

{func\definitions.i}

DEFINE TEMP-TABLE tt-res
    FIELD seq AS INT
    FIELD des AS CHAR FORMAT "X(30)" COLUMN-LABEL "Despesa"
    FIELD qtd AS DEC FORMAT ">,>>9.99" COLUMN-LABEL "Qtde"
    FIELD val-nreemb AS DEC FORMAT ">>>,>>9.99" COLUMN-LABEL "Val. N Reemb."
    FIELD val AS DEC FORMAT ">>>,>>9.99" COLUMN-LABEL "Valor Reemb."
    FIELD dt AS DATE INITIAL ?
    FIELD obs AS CHAR
    INDEX idx-seq seq.

DEFINE BUFFER bf-res FOR tt-res.
DEFINE BUFFER bf-agrup FOR mov-conta.
DEFINE BUFFER bfMov FOR mov-conta.

DEFINE NEW GLOBAL SHARED VARIABLE giNr-pedido AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSeq-Viag  AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE giSequencia AS INTEGER     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-apontamento AS ROWID       NO-UNDO.

/* Parameters Definitions ---                                           */

DEFINE INPUT  PARAMETER pViagem AS INTEGER     NO-UNDO.

/* Local Variable Definitions ---                                       */

FIND FIRST visita NO-LOCK
    WHERE visita.sequencia = pViagem NO-ERROR.
IF NOT AVAIL visita THEN RETURN "NOK".

FIND FIRST usuario NO-LOCK
    WHERE usuario.nome = visita.nome.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-apont

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES apontamento pedido-item ITEM tt-res

/* Definitions for BROWSE br-apont                                      */
&Scoped-define FIELDS-IN-QUERY-br-apont apontamento.data apontamento.qt-apontada (apontamento.qt-apont * item.fator-reemb) apontamento.reembolsavel apontamento.ds-apontamento   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-apont   
&Scoped-define SELF-NAME br-apont
&Scoped-define QUERY-STRING-br-apont FOR EACH apontamento NO-LOCK       WHERE apontamento.nr-pedido = visita.nr-pedido       AND   apontamento.sequencia = tt-res.seq       AND   apontamento.nome = visita.nome, ~
             FIRST pedido-item OF apontamento NO-LOCK, ~
             FIRST ITEM OF pedido-item NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-apont OPEN QUERY {&SELF-NAME} FOR EACH apontamento NO-LOCK       WHERE apontamento.nr-pedido = visita.nr-pedido       AND   apontamento.sequencia = tt-res.seq       AND   apontamento.nome = visita.nome, ~
             FIRST pedido-item OF apontamento NO-LOCK, ~
             FIRST ITEM OF pedido-item NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-apont apontamento pedido-item ITEM
&Scoped-define FIRST-TABLE-IN-QUERY-br-apont apontamento
&Scoped-define SECOND-TABLE-IN-QUERY-br-apont pedido-item
&Scoped-define THIRD-TABLE-IN-QUERY-br-apont ITEM


/* Definitions for BROWSE br-res                                        */
&Scoped-define FIELDS-IN-QUERY-br-res tt-res.des tt-res.qtd tt-res.val tt-res.val-nreemb   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-res   
&Scoped-define SELF-NAME br-res
&Scoped-define QUERY-STRING-br-res FOR EACH tt-res
&Scoped-define OPEN-QUERY-br-res OPEN QUERY {&SELF-NAME} FOR EACH tt-res.
&Scoped-define TABLES-IN-QUERY-br-res tt-res
&Scoped-define FIRST-TABLE-IN-QUERY-br-res tt-res


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-apont}~
    ~{&OPEN-QUERY-br-res}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 br-res br-apont btGera btExit ~
btAdd-page1 btDel-page1 btUpdate-page1 
&Scoped-Define DISPLAYED-FIELDS visita.sequencia 
&Scoped-define DISPLAYED-TABLES visita
&Scoped-define FIRST-DISPLAYED-TABLE visita


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
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

DEFINE BUTTON btGera 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Gera" 
     SIZE 6.14 BY 1.79 TOOLTIP "Gerar os movimentos financeiros da viagem".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 114 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-apont FOR 
      apontamento, 
      pedido-item, 
      ITEM SCROLLING.

DEFINE QUERY br-res FOR 
      tt-res SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-apont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-apont C-Win _FREEFORM
  QUERY br-apont NO-LOCK DISPLAY
      apontamento.data FORMAT "99/99/9999":U
      apontamento.qt-apontada FORMAT "->>,>>9.99":U
      (apontamento.qt-apont * item.fator-reemb) COLUMN-LABEL "Valor" FORMAT ">>>,>>9.99"
      apontamento.reembolsavel FORMAT "Sim/N∆o" COLUMN-LABEL "Reembolso"
      apontamento.ds-apontamento FORMAT "x(2000)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 60 BY 11
         FONT 1
         TITLE "Apontamentos de Despesa".

DEFINE BROWSE br-res
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-res C-Win _FREEFORM
  QUERY br-res DISPLAY
      tt-res.des
 tt-res.qtd
 tt-res.val
tt-res.val-nreemb
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 53 BY 12.75
         FONT 1
         TITLE "Resumo de Despesas".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     visita.sequencia AT ROW 1.75 COL 44 COLON-ALIGNED WIDGET-ID 14
          LABEL "Viagem"
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     br-res AT ROW 3.75 COL 2 WIDGET-ID 300
     br-apont AT ROW 3.75 COL 56 WIDGET-ID 200
     btGera AT ROW 1.5 COL 3 WIDGET-ID 16
     btExit AT ROW 1.5 COL 109 WIDGET-ID 10
     btAdd-page1 AT ROW 14.75 COL 56 WIDGET-ID 2
     btDel-page1 AT ROW 14.75 COL 68.29 WIDGET-ID 4
     btUpdate-page1 AT ROW 14.75 COL 62.14 WIDGET-ID 6
     RECT-1 AT ROW 1.25 COL 2 WIDGET-ID 12
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 115.29 BY 15.71
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
         HEIGHT             = 15.71
         WIDTH              = 115.29
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 115.29
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 115.29
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* BROWSE-TAB br-res sequencia DEFAULT-FRAME */
/* BROWSE-TAB br-apont br-res DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN visita.sequencia IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-apont
/* Query rebuild information for BROWSE br-apont
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH apontamento NO-LOCK
      WHERE apontamento.nr-pedido = visita.nr-pedido
      AND   apontamento.sequencia = tt-res.seq
      AND   apontamento.nome = visita.nome,
      FIRST pedido-item OF apontamento NO-LOCK,
      FIRST ITEM OF pedido-item NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "apontamento.nr-pedido = visita.nr-pedido
 AND apontamento.sequencia = tt-res.seq
 AND apontamento.nome = visita.nome"
     _Query            is OPENED
*/  /* BROWSE br-apont */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-res
/* Query rebuild information for BROWSE br-res
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-res.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br-res */
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


&Scoped-define BROWSE-NAME br-res
&Scoped-define SELF-NAME br-res
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-res C-Win
ON ROW-DISPLAY OF br-res IN FRAME DEFAULT-FRAME /* Resumo de Despesas */
DO:
    IF tt-res.des = "" THEN
        ASSIGN tt-res.qtd:FGCOLOR IN BROWSE br-res = 15
               tt-res.val:FGCOLOR IN BROWSE br-res = 15
               tt-res.val-nreemb:FGCOLOR IN BROWSE br-res = 15.

    IF tt-res.seq = 999 THEN
        ASSIGN tt-res.des:FGCOLOR IN BROWSE br-res = 9
               tt-res.qtd:FGCOLOR IN BROWSE br-res = 15
               tt-res.val:FGCOLOR IN BROWSE br-res = 9
               tt-res.val-nreemb:FGCOLOR IN BROWSE br-res = 9.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-res C-Win
ON VALUE-CHANGED OF br-res IN FRAME DEFAULT-FRAME /* Resumo de Despesas */
DO:
  
    {&OPEN-QUERY-br-apont}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:

    FIND FIRST pedido-item NO-LOCK
        WHERE pedido-item.nr-pedido = visita.nr-pedido
        AND   pedido-item.sequencia = tt-res.seq NO-ERROR.
    IF AVAIL pedido-item THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN pcActionBT = "ADD"
               r-parent = ROWID(usuario)
               giNr-pedido = pedido-item.nr-pedido
               giSequencia = pedido-item.sequencia.
               giSeq-Viag  = INPUT FRAME {&FRAME-NAME} visita.sequencia.
        {func\run.i &Programa = "apont-desp_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN criaRes.
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    
    DEFINE BUFFER bf-pedido-item FOR pedido-item.

    DEFINE VARIABLE deAux AS DECIMAL     NO-UNDO.

    IF AVAIL apontamento THEN DO:

        RUN som.p(INPUT "music\click.wav").
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
        IF RETURN-VALUE = "OK" THEN DO:
            FIND CURRENT apontamento EXCLUSIVE-LOCK.
            ASSIGN deAux = apontamento.qt-apontada.
            DELETE apontamento.
        END.

        FIND CURRENT pedido-item EXCLUSIVE-LOCK NO-ERROR.
        IF AVAIL pedido-item THEN DO:

            /* Controla qt-atendida do item do pedido */
            ASSIGN pedido-item.qt-atendida = pedido-item.qt-atendida - deAux.

            /* Controla situaá∆o do item do pedido */
            IF pedido-item.qt-atendida = 0 THEN
                ASSIGN pedido-item.situacao = 1 /* Pendente */.
            ELSE
                IF pedido-item.qt-atendida < pedido-item.qt-pedida THEN
                    ASSIGN pedido-item.situacao = 2 /* Iniciado */.
                ELSE
                    ASSIGN pedido-item.situacao = 3 /* Atendido */.

            /* Controla a situaá∆o do pedido */
            FIND FIRST pedido OF pedido-item EXCLUSIVE-LOCK.
            ASSIGN pedido.situacao = 1. /* Pendente */
            IF CAN-FIND(FIRST bf-pedido-item OF pedido
                        WHERE bf-pedido-item.situacao = 2
                        OR    bf-pedido-item.situacao = 3) THEN
                ASSIGN pedido.situacao = 2. /* Iniciado */
            IF NOT CAN-FIND(FIRST bf-pedido-item OF pedido
                            WHERE bf-pedido-item.situacao = 1
                            OR    bf-pedido-item.situacao = 2) THEN
                ASSIGN pedido.situacao = 3. /* Atendido */
            IF NOT CAN-FIND(FIRST bf-pedido-item OF pedido
                            WHERE bf-pedido-item.situacao = 1
                            OR    bf-pedido-item.situacao = 2
                            OR    bf-pedido-item.situacao = 3)
            AND CAN-FIND(FIRST bf-pedido-item OF pedido
                         WHERE bf-pedido-item.situacao = 9) THEN
                ASSIGN pedido.situacao = 9. /* Cancelado */
        END.

        RUN criaRes.

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


&Scoped-define SELF-NAME btGera
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGera C-Win
ON CHOOSE OF btGera IN FRAME DEFAULT-FRAME /* Gera */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Geraá∆o de Movimentos (058)', INPUT 'Confirma geraá∆o ?', INPUT 'Confirma geraá∆o dos movimentos financeiros para as despesas de viagem informadas ?')"}
    IF RETURN-VALUE = "OK" THEN DO:
        RUN geraMov.
        RUN gera-desp-viag.p (INPUT INPUT FRAME {&FRAME-NAME} visita.sequencia, INPUT 1).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:

    IF AVAIL apontamento THEN DO:
        RUN som.p(INPUT "music\click.wav").
        ASSIGN r-parent = ROWID(usuario)
               r-apontamento = ROWID(apontamento)
               giNr-pedido = apontamento.nr-pedido
               giSequencia = apontamento.sequencia
               pcActionBT = "UPDATE"
               giSeq-Viag  = INPUT FRAME {&FRAME-NAME} visita.sequencia.
        {func\run.i &Programa = "apont-desp_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            RUN criaRes.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-apont
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
  {version.i desp-viag}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaRes C-Win 
PROCEDURE criaRes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE tt-res.

    FIND FIRST pedido OF visita NO-LOCK NO-ERROR.
    IF AVAIL pedido THEN DO:

        FIND FIRST favorecido OF pedido NO-LOCK NO-ERROR.

        FOR EACH pedido-item OF pedido NO-LOCK
            /*WHERE pedido-item.situacao < 3  Atendido */ :

            FIND FIRST item OF pedido-item NO-LOCK NO-ERROR.

            IF item.desp-viag THEN DO:

                IF pedido-item.situacao < 3 THEN DO:
    
                    CREATE tt-res.
                    ASSIGN tt-res.seq = pedido-item.sequencia
                           tt-res.des = CAPS(item.ds-item)
                           tt-res.obs = "Visita " + TRIM(favorecido.ds-favorecido) + CHR(13) + CHR(13).
    
                    FOR EACH apontamento OF pedido-item NO-LOCK
                        WHERE apontamento.nome = visita.nome:
                        ASSIGN tt-res.qtd = tt-res.qtd + apontamento.qt-apont
                               tt-res.obs = tt-res.obs + item.un + " " + TRIM(STRING(apontamento.qt-apont, ">,>>9.99")) + " - " + TRIM(apontamento.ds-apontamento) + CHR(13).

                        IF apontamento.reembolsavel THEN
                            ASSIGN tt-res.val = tt-res.val + (apontamento.qt-apont * item.fator-reemb).
                        ELSE
                            ASSIGN tt-res.val-nreemb = tt-res.val-nreemb + (apontamento.qt-apont * item.fator-reemb).

                        IF tt-res.dt = ? OR tt-res.dt < apontamento.data THEN
                            ASSIGN tt-res.dt = apontamento.data.
                    END.
    
                END.
                ELSE DO:
                    IF CAN-FIND(FIRST apontamento OF pedido-item NO-LOCK
                                WHERE apontamento.seq-visita = visita.sequencia) THEN DO:

                        CREATE tt-res.
                        ASSIGN tt-res.seq = pedido-item.sequencia
                               tt-res.des = CAPS(item.ds-item)
                               tt-res.obs = "Visita " + TRIM(favorecido.ds-favorecido) + CHR(13) + CHR(13).

                        FOR EACH apontamento OF pedido-item NO-LOCK
                            WHERE apontamento.nome = visita.nome:
                            ASSIGN tt-res.qtd = tt-res.qtd + apontamento.qt-apont
                                   tt-res.obs = tt-res.obs + item.un + " " + TRIM(STRING(apontamento.qt-apont, ">,>>9.99")) + " - " + TRIM(apontamento.ds-apontamento) + CHR(13).

                            IF apontamento.reembolsavel THEN
                                ASSIGN tt-res.val = tt-res.val + (apontamento.qt-apont * item.fator-reemb).
                            ELSE
                                ASSIGN tt-res.val-nreemb = tt-res.val-nreemb + (apontamento.qt-apont * item.fator-reemb).

                            IF tt-res.dt = ? OR tt-res.dt < apontamento.data THEN
                                ASSIGN tt-res.dt = apontamento.data.
                        END.

                    END.

                END.

            END.

        END.

    END.

    CREATE tt-res.
    ASSIGN tt-res.seq = 998.

    CREATE tt-res.
    ASSIGN tt-res.seq = 999
           tt-res.des = "TOTAL".

    FOR EACH bf-res
        WHERE bf-res.seq < 998:
        ASSIGN tt-res.val = tt-res.val + bf-res.val.
        ASSIGN tt-res.val-nreemb = tt-res.val-nreemb + bf-res.val-nreemb.
    END.

    {&OPEN-QUERY-br-res}
    APPLY "VALUE-CHANGED" TO br-res IN FRAME {&FRAME-NAME}.

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
  IF AVAILABLE visita THEN 
    DISPLAY visita.sequencia 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-1 br-res br-apont btGera btExit btAdd-page1 btDel-page1 
         btUpdate-page1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
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

    DEFINE VARIABLE dtPagto AS DATE    NO-UNDO INITIAL ?.
    DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO.

    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = visita.nome NO-ERROR.
    IF NOT AVAIL usuario THEN RETURN "NOK".
    FIND FIRST param-mn NO-LOCK NO-ERROR.

    blk-trans:
    DO TRANSACTION:

        FOR EACH mov-conta EXCLUSIVE-LOCK
            WHERE mov-conta.seq-visita = visita.sequencia:
            ASSIGN mov-conta.de-valor = 0
                   mov-conta.ds-observacao = "".
        END.
    
        FOR EACH apontamento NO-LOCK
            WHERE apontamento.seq-visita = visita.sequencia
            BREAK BY apontamento.reembolsavel
            BY apontamento.data
            BY apontamento.cd-favorecido:

            IF apontamento.reembolsavel THEN DO:
                FIND FIRST conta NO-LOCK
                    WHERE conta.cd-conta = param-mn.conta-desp-viag NO-ERROR.
                FIND FIRST favorecido OF usuario NO-LOCK NO-ERROR.
            END.
            ELSE DO:
                FIND FIRST conta NO-LOCK
                    WHERE conta.cd-conta = param-mn.conta-desp-nreemb NO-ERROR.
                FIND FIRST favorecido OF apontamento NO-LOCK NO-ERROR.
            END.

            IF FIRST-OF(apontamento.data) AND apontamento.reembolsavel THEN DO:

                FIND FIRST bf-agrup OF conta EXCLUSIVE-LOCK
                    WHERE bf-agrup.seq-visita    = apontamento.seq-visita
                    AND   bf-agrup.dt-mov        = apontamento.data
                    AND   bf-agrup.cd-favorecido = favorecido.cd-favorecido
                    AND   bf-agrup.id-tipo       = 0 /* Agrupamento */ NO-ERROR.
                IF NOT AVAIL bf-agrup THEN DO:

                    FIND LAST bfMov OF conta NO-LOCK NO-ERROR.
                    IF AVAIL bfMov THEN
                        ASSIGN iSeq = bfMov.cd-sequencia + 1.
                    ELSE
                        ASSIGN iSeq = 1.

                    CREATE bf-agrup.
                    ASSIGN bf-agrup.cd-conta      = conta.cd-conta
                           bf-agrup.cd-sequencia  = iSeq
                           bf-agrup.id-tipo       = 0
                           bf-agrup.dt-mov        = apontamento.data
                           bf-agrup.cd-favorecido = favorecido.cd-favorecido
                           bf-agrup.id-situacao   = 1
                           bf-agrup.nr-pedido     = visita.nr-pedido
                           bf-agrup.usuar-resp    = visita.nome
                           bf-agrup.seq-visita    = apontamento.seq-visita.
                END.
                ELSE DO:
                    IF bf-agrup.id-situacao <> 1 THEN DO:
                        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Geraá∆o de Movimentos (058)', INPUT 'Movimentos n∆o atualizados!', INPUT 'Os movimentos n∆o foram atualizados pois j† se encontram compensados. Entre em contato com o departamento financeiro para verificar o ocorrido.')"}
                        UNDO blk-trans, LEAVE blk-trans.
                        RETURN "NOK".
                    END.
                END.
            END.

            FIND FIRST pedido-item OF apontamento NO-LOCK NO-ERROR.
            FIND FIRST item OF pedido-item NO-LOCK
                WHERE item.desp-viag NO-ERROR.
            IF NOT AVAIL ITEM THEN NEXT.

            IF item.cod-categoria = 0
            OR item.cd-sub = 0 THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Geraá∆o NOK (058)', INPUT 'Movimentos n∆o foram gerados!', INPUT 'N∆o foram informadas a categoria e sub-categoria de despesa do item. Entre em contato com o departamento financeiro.')"}
                UNDO blk-trans, LEAVE blk-trans.
                RETURN "NOK".
            END.

            FIND FIRST mov-conta OF conta EXCLUSIVE-LOCK
                WHERE mov-conta.seq-visita    = apontamento.seq-visita
                AND   mov-conta.dt-mov        = apontamento.data
                AND   mov-conta.cd-favorecido = favorecido.cd-favorecido
                AND   mov-conta.nr-pedido     = visita.nr-pedido
                AND   mov-conta.usuar-resp    = visita.nome
                AND   mov-conta.cod-categoria = item.cod-categoria
                AND   mov-conta.cd-sub        = item.cd-sub NO-ERROR.
            IF NOT AVAIL mov-conta THEN DO:

                FIND LAST bfMov OF conta NO-LOCK NO-ERROR.
                IF AVAIL bfMov THEN
                    ASSIGN iSeq = bfMov.cd-sequencia + 1.
                ELSE
                    ASSIGN iSeq = 1.

                CREATE mov-conta.
                ASSIGN mov-conta.cd-conta      = conta.cd-conta
                       mov-conta.cd-sequencia  = iSeq
                       mov-conta.agrupado      = IF AVAILABLE bf-agrup THEN bf-agrup.cd-sequencia ELSE 0
                       mov-conta.cd-favorecido = favorecido.cd-favorecido
                       mov-conta.id-situacao   = 1
                       mov-conta.nr-pedido     = visita.nr-pedido
                       mov-conta.usuar-resp    = visita.nome
                       mov-conta.cod-categoria = item.cod-categoria
                       mov-conta.cd-sub        = item.cd-sub
                       mov-conta.seq-visita    = apontamento.seq-visita
                       mov-conta.dt-mov        = apontamento.data.                       

                IF apontamento.tipo-despesa = "Quilometragem" THEN DO:
                    ASSIGN mov-conta.ds-observacao = STRING(apontamento.qt-apont) + "KM * R$" + TRIM(STRING(ITEM.fator-reemb,">>9.99")) + CHR(10) + CHR(10) + mov-conta.ds-observacao.
                END.

                CASE conta.id-tipo:
                    WHEN 1 THEN ASSIGN mov-conta.id-tipo = 5.
                    WHEN 2 THEN ASSIGN mov-conta.id-tipo = 6.
                    WHEN 3 THEN ASSIGN mov-conta.id-tipo = 7.
                END CASE.

            END.
            ELSE DO:
                IF mov-conta.id-situacao <> 1 THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Geraá∆o de Movimentos (058)', INPUT 'Movimentos n∆o atualizados!', INPUT 'Os movimentos n∆o foram atualizados pois j† se encontram compensados. Entre em contato com o departamento financeiro para verificar o ocorrido.')"}
                    UNDO blk-trans, LEAVE blk-trans.
                    RETURN "NOK".
                END.
            END.

            ASSIGN mov-conta.de-valor = mov-conta.de-valor + ((apontamento.qt-apont * item.fator-reemb) * -1)
                   mov-conta.ds-observacao = mov-conta.ds-observacao + CHR(10) + apontamento.ds-apontamento.

            IF mov-conta.nr-mov = "" THEN
                ASSIGN mov-conta.nr-mov = apontamento.nr-mov.
            ELSE 
                ASSIGN mov-conta.nr-mov = mov-conta.nr-mov + "," + apontamento.nr-mov.

            IF AVAIL bf-agrup THEN
                ASSIGN bf-agrup.de-valor = bf-agrup.de-valor + ((apontamento.qt-apont * item.fator-reemb) * -1).
            
        END.

        FOR EACH mov-conta EXCLUSIVE-LOCK
            WHERE mov-conta.seq-visita = visita.sequencia
            AND   mov-conta.de-valor = 0:
            DELETE mov-conta.
        END.

        /* Atualiza agendamento */
        FIND FIRST agenda EXCLUSIVE-LOCK
            WHERE agenda.cd-favorecido = param-mn.fav-desp-viag
            AND   agenda.usuar-resp = visita.nome
            AND   (agenda.cd-conta = param-mn.conta-desp-viag
            OR     agenda.conta-transf = param-mn.conta-desp-viag) NO-ERROR.
        IF AVAIL agenda THEN DO:
            ASSIGN agenda.vl-atual = 0.
            FOR EACH mov-conta NO-LOCK
                WHERE mov-conta.cd-conta = param-mn.conta-desp-viag
                AND   mov-conta.id-tipo <> 0
                AND   mov-conta.id-situacao = 1
                AND   mov-conta.usuar-resp = visita.nome
                AND   mov-conta.dt-mov < DATE(MONTH(agenda.prox-data-pag), 1, YEAR(agenda.prox-data-pag)):
                ASSIGN agenda.vl-atual = agenda.vl-atual + mov-conta.de-valor.
            END.
        END.
        
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Geraá∆o OK (058', INPUT 'Movimentos gerados com sucesso!', INPUT 'Foram gerados os movimentos correspondentes as depesas informadas e atualizado o seu agendamento de reembolso de desepesas. Verifique na tela de apontamentos na seá∆o de pagamentos se os valores forma lanáados corretamente. Em caso de erros entre em contato com o departamento financeiro.')"}

    END.

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

    DISPLAY visita.sequencia
        WITH FRAME {&FRAME-NAME}.
    
    RUN criaRes.
    
    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

