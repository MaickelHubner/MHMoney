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

DEFINE TEMP-TABLE tt-fluxo
    FIELD dt-orig  AS DATE FORMAT "99/99/9999"    
    FIELD dt-fluxo AS DATE FORMAT "99/99/9999"
    FIELD vl-fluxo AS DECIMAL FORMAT "->>>,>>9.99"
    FIELD ds-fluxo AS CHARACTER FORMAT "X(57)"
    FIELD vl-saldo AS DECIMAL FORMAT "->>>,>>9.99"
    FIELD fixo AS LOGICAL FORMAT "F/ "
    FIELD fluxo-ok AS LOGICAL
    FIELD cd-agenda LIKE agenda.cd-agenda
    INDEX idx dt-fluxo vl-fluxo DESCENDING.

DEFINE TEMP-TABLE tt-mov-conta LIKE mov-conta.

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE deAnt AS DECIMAL    NO-UNDO INITIAL 0.

{func\relat\definitions.i}
{func\data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brFluxo

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-fluxo

/* Definitions for BROWSE brFluxo                                       */
&Scoped-define FIELDS-IN-QUERY-brFluxo tt-fluxo.fixo tt-fluxo.dt-fluxo tt-fluxo.ds-fluxo tt-fluxo.vl-fluxo tt-fluxo.vl-saldo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brFluxo   
&Scoped-define SELF-NAME brFluxo
&Scoped-define QUERY-STRING-brFluxo FOR EACH tt-fluxo
&Scoped-define OPEN-QUERY-brFluxo OPEN QUERY {&SELF-NAME} FOR EACH tt-fluxo.
&Scoped-define TABLES-IN-QUERY-brFluxo tt-fluxo
&Scoped-define FIRST-TABLE-IN-QUERY-brFluxo tt-fluxo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brFluxo}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btData RECT-5 iConta mes ano cons-mov ~
brFluxo btAcerta btExit 
&Scoped-Define DISPLAYED-OBJECTS iConta des-conta mes ano cons-mov 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAcerta 
     IMAGE-UP FILE "image/im-goto.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-goto.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Acertar Fluxo Automaticamente".

DEFINE BUTTON btData 
     IMAGE-UP FILE "image/im-calend.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-calend.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Alterar Data do Movimento".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE VARIABLE mes AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Mˆs" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Mar‡o",3,
                     "Abril",4,
                     "Maio",5,
                     "Junho",6,
                     "Julho",7,
                     "Agosto",8,
                     "Setembro",9,
                     "Outubro",10,
                     "Novembro",11,
                     "Dezembro",12
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE ano AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE des-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .79 NO-UNDO.

DEFINE VARIABLE iConta AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 72.43 BY 2.25.

DEFINE VARIABLE cons-mov AS LOGICAL INITIAL no 
     LABEL "Considera Movimentos" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brFluxo FOR 
      tt-fluxo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brFluxo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brFluxo C-Win _FREEFORM
  QUERY brFluxo DISPLAY
      tt-fluxo.fixo COLUMN-LABEL "F"
 tt-fluxo.dt-fluxo COLUMN-LABEL "Data"
 tt-fluxo.ds-fluxo COLUMN-LABEL "Descri‡Æo"
 tt-fluxo.vl-fluxo COLUMN-LABEL "Valor"
 tt-fluxo.vl-saldo COLUMN-LABEL "Saldo"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 72 BY 10.5
         FONT 1
         TITLE "Fluxo de Caixa".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btData AT ROW 16.75 COL 2
     iConta AT ROW 4 COL 16 COLON-ALIGNED
     des-conta AT ROW 4 COL 20.29 COLON-ALIGNED NO-LABEL
     mes AT ROW 5 COL 16 COLON-ALIGNED
     ano AT ROW 5 COL 32.29 COLON-ALIGNED NO-LABEL
     cons-mov AT ROW 5 COL 42
     brFluxo AT ROW 6.25 COL 2
     btAcerta AT ROW 1.5 COL 3
     btExit AT ROW 1.5 COL 67.43
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 74.14 BY 17.63
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
         HEIGHT             = 17.63
         WIDTH              = 74.14
         MAX-HEIGHT         = 18.04
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 18.04
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
/* BROWSE-TAB brFluxo cons-mov DEFAULT-FRAME */
ASSIGN 
       brFluxo:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       brFluxo:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN des-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brFluxo
/* Query rebuild information for BROWSE brFluxo
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-fluxo.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brFluxo */
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


&Scoped-define SELF-NAME ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON ENTRY OF ano IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON LEAVE OF ano IN FRAME DEFAULT-FRAME
DO:

    {func\set_leave.i}  
    IF ano <> INPUT FRAME {&FRAME-NAME} ano THEN DO:
        RUN criaFluxo.
        ASSIGN INPUT FRAME {&FRAME-NAME} ano.
    END.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brFluxo
&Scoped-define SELF-NAME brFluxo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFluxo C-Win
ON MOUSE-SELECT-DBLCLICK OF brFluxo IN FRAME DEFAULT-FRAME /* Fluxo de Caixa */
DO:
    DEFINE VARIABLE rFl AS ROWID      NO-UNDO.

    APPLY "FOCUS" TO brFluxo.
  
    IF AVAIL tt-fluxo THEN DO:
        ASSIGN rFl = ROWID(tt-fluxo)
               tt-fluxo.fixo = NOT tt-fluxo.fixo.
        IF tt-fluxo.cd-agenda = 0 THEN
            ASSIGN tt-fluxo.fixo = YES.
        FIND FIRST tt-fluxo WHERE tt-fluxo.ds-fluxo = "Saldo Inicial".
        ASSIGN tt-fluxo.fixo = YES.
        {&OPEN-QUERY-brFluxo}
        REPOSITION brFluxo TO ROWID rFl.
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brFluxo C-Win
ON ROW-DISPLAY OF brFluxo IN FRAME DEFAULT-FRAME /* Fluxo de Caixa */
DO:
  
    IF NOT tt-fluxo.fluxo-ok THEN DO:
        ASSIGN tt-fluxo.fixo:BGCOLOR IN BROWSE brFluxo = 12
               tt-fluxo.fixo:FGCOLOR IN BROWSE brFluxo = 15
               tt-fluxo.dt-fluxo:BGCOLOR IN BROWSE brFluxo = 12
               tt-fluxo.dt-fluxo:FGCOLOR IN BROWSE brFluxo = 15
               tt-fluxo.ds-fluxo:BGCOLOR IN BROWSE brFluxo = 12
               tt-fluxo.ds-fluxo:FGCOLOR IN BROWSE brFluxo = 15
               tt-fluxo.vl-fluxo:BGCOLOR IN BROWSE brFluxo = 12
               tt-fluxo.vl-fluxo:FGCOLOR IN BROWSE brFluxo = 15
               tt-fluxo.vl-saldo:BGCOLOR IN BROWSE brFluxo = 12
               tt-fluxo.vl-saldo:FGCOLOR IN BROWSE brFluxo = 15.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAcerta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAcerta C-Win
ON CHOOSE OF btAcerta IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE BUFFER bfFluxo FOR tt-fluxo.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
  
    RUN som.p(INPUT "music\click.wav").

    SESSION:SET-WAIT-STATE("image\calc.cur").

    REPEAT iCont = 1 TO 100:
        FOR EACH tt-fluxo
            WHERE NOT tt-fluxo.fluxo-ok:

            IF NOT tt-fluxo.fixo THEN DO:

                IF tt-fluxo.vl-fluxo < 0 THEN DO:

                    FOR EACH bfFluxo
                        WHERE bfFluxo.vl-saldo > (tt-fluxo.vl-fluxo * (-1))
                        AND   bfFluxo.dt-fluxo >= DATE(mes,1,ano)
                        AND   bfFluxo.dt-fluxo <> tt-fluxo.dt-fluxo
                        AND   NOT CAN-FIND(FIRST tt-fluxo
                                           WHERE tt-fluxo.vl-saldo < bfFluxo.vl-saldo
                                           AND   tt-fluxo.dt-fluxo = bfFluxo.dt-fluxo)
                        BY bfFluxo.vl-saldo DESCENDING:
                        ASSIGN tt-fluxo.dt-fluxo = bfFluxo.dt-fluxo.
                    END.
                    FIND FIRST bfFluxo NO-LOCK
                        WHERE bfFluxo.vl-saldo = deAnt.
                    IF AVAIL bfFluxo THEN DO:
                        ASSIGN tt-fluxo.dt-fluxo = bfFluxo.dt-fluxo.
                    END.
                    ELSE DO:
                    END.

                END.
                ELSE DO:

                    ASSIGN tt-fluxo.dt-fluxo = (tt-fluxo.dt-fluxo - 1).

                END.

            END.
            ELSE DO:

                FIND FIRST bfFluxo
                    WHERE NOT bfFluxo.fixo
                    AND   bfFluxo.vl-fluxo > 0
                    AND   bfFluxo.dt-fluxo > tt-fluxo.dt-fluxo NO-ERROR.
                IF AVAIL bfFluxo THEN DO:

                    ASSIGN bfFluxo.dt-fluxo = tt-fluxo.dt-fluxo.

                END.
                ELSE DO:
                    FOR EACH bfFluxo
                        WHERE NOT bfFluxo.fixo
                        AND   bfFluxo.vl-fluxo < 0
                        AND   bfFluxo.dt-fluxo <= tt-fluxo.dt-fluxo
                        BY bfFluxo.vl-fluxo:

                        ASSIGN bfFluxo.dt-fluxo = (tt-fluxo.dt-fluxo + 1).

                    END.
                END.

            END.

        END.
        RUN calculaSaldo.

        IF NOT CAN-FIND(FIRST tt-fluxo
                        WHERE NOT tt-fluxo.fluxo-ok) THEN DO:
            LEAVE.
        END.

    END.

    SESSION:SET-WAIT-STATE("").

    IF NOT CAN-FIND(FIRST tt-fluxo
                    WHERE NOT tt-fluxo.fluxo-ok) THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Fluxo Autom tico (033)', INPUT 'Fluxo acertado com sucesso!', INPUT 'O seu fluxo de caixa foi acertado corretamente.')"}
    END.
    ELSE DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Fluxo Autom tico (033)', INPUT 'Erro ao acertar o fluxo!', INPUT 'O seu fluxo de caixa nÆo p“de ser acertado corretamente. Ainda existem inconsistˆncias que devem ser verificadas caso-a-caso.')"}
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btData
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btData C-Win
ON CHOOSE OF btData IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    IF AVAIL tt-fluxo THEN DO:
        IF tt-fluxo.ds-fluxo <> "Saldo Inicial" THEN DO:
            IF NOT tt-fluxo.fixo THEN DO:
                {func\run.i &Programa = "data.w (INPUT 'Data do Movimento', INPUT tt-fluxo.dt-fluxo, OUTPUT dtTemp)"}
                IF dtTemp <> ? THEN DO:
                    IF dtTemp < DATE(mes,1,ano) THEN
                        ASSIGN dtTemp = DATE(mes,1,ano).
                    IF dtTemp > fnUltimoDia(mes,ano) THEN
                        ASSIGN dtTemp = fnUltimoDia(mes,ano).
                    ASSIGN tt-fluxo.dt-fluxo = dtTemp.
                    RUN calculaSaldo.
                END.
            END.
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


&Scoped-define SELF-NAME cons-mov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cons-mov C-Win
ON VALUE-CHANGED OF cons-mov IN FRAME DEFAULT-FRAME /* Considera Movimentos */
DO:

    IF cons-mov <> INPUT FRAME {&FRAME-NAME} cons-mov THEN DO:
        RUN criaFluxo.
        ASSIGN INPUT FRAME {&FRAME-NAME} cons-mov.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iConta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON ENTRY OF iConta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON LEAVE OF iConta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela="iConta"
                  &CampoProc="ds-conta"
                  &Tela="des-conta"}  

    IF iConta <> INPUT FRAME {&FRAME-NAME} iConta THEN DO:
        RUN criaFluxo.
        ASSIGN INPUT FRAME {&FRAME-NAME} iConta.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iConta C-Win
ON MOUSE-SELECT-DBLCLICK OF iConta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF iConta DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="iConta"
                 &Campo2="ds-conta"
                 &Tela2="des-conta"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON ENTRY OF mes IN FRAME DEFAULT-FRAME /* Mˆs */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON LEAVE OF mes IN FRAME DEFAULT-FRAME /* Mˆs */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON VALUE-CHANGED OF mes IN FRAME DEFAULT-FRAME /* Mˆs */
DO:

    IF mes <> INPUT FRAME {&FRAME-NAME} mes THEN DO:
        RUN criaFluxo.
        ASSIGN INPUT FRAME {&FRAME-NAME} mes.
    END.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{ttmovto.i DATE(mes,1,ano) fnUltimoDia(mes,ano) NO}

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
  {version.i fluxo}
  RUN initialize.
  RUN enable_UI.
  RUN displayFields.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculaSaldo C-Win 
PROCEDURE calculaSaldo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO INITIAL 0.
DEFINE VARIABLE lPos AS LOGICAL    NO-UNDO.

FOR EACH tt-fluxo:

    ASSIGN deSaldo = deSaldo + tt-fluxo.vl-fluxo
           tt-fluxo.vl-saldo = deSaldo.

    IF tt-fluxo.vl-saldo >= 0 THEN
        ASSIGN tt-fluxo.fluxo-ok = YES.
    ELSE
        ASSIGN tt-fluxo.fluxo-ok = NO.

END.

ASSIGN deAnt = 999999999.
FOR EACH tt-fluxo
    BREAK BY (tt-fluxo.dt-fluxo):

    IF FIRST-OF(tt-fluxo.dt-fluxo) THEN DO:
        ASSIGN lPos = NO.
    END.

    IF tt-fluxo.vl-fluxo > 0 THEN
        ASSIGN lPos = YES.

    IF LAST-OF(tt-fluxo.dt-fluxo) THEN DO:
        IF NOT lPos THEN
            ASSIGN deAnt = tt-fluxo.vl-saldo.
    END.

END.
FOR EACH tt-fluxo:
    IF tt-fluxo.vl-saldo < deAnt THEN
        ASSIGN tt-fluxo.fluxo-ok = NO.
END.

{&OPEN-QUERY-brFluxo}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaFluxo C-Win 
PROCEDURE criaFluxo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE deSoma AS DECIMAL    NO-UNDO.

SESSION:SET-WAIT-STATE("image\calc.cur").

ASSIGN INPUT FRAME {&FRAME-NAME} mes ano cons-mov iConta.

FOR EACH tt-fluxo:
    DELETE tt-fluxo.
END.
FOR EACH tt-mov-conta:
    DELETE tt-mov-conta.
END.

RUN criaTT.

FOR EACH tt-mov-conta
    WHERE tt-mov-conta.dt-mov >= DATE(mes,1,ano)
    AND   tt-mov-conta.dt-mov <= fnUltimoDia(mes, ano)
    AND   tt-mov-conta.de-valor <> 0:

    FIND FIRST favorecido OF tt-mov-conta NO-LOCK NO-ERROR.

    CREATE tt-fluxo.
    ASSIGN tt-fluxo.dt-fluxo = tt-mov-conta.dt-mov
           tt-fluxo.dt-orig  = tt-mov-conta.dt-mov
           tt-fluxo.vl-fluxo = tt-mov-conta.de-valor
           tt-fluxo.ds-fluxo = favorecido.ds-favorecido
           tt-fluxo.fixo = YES
           tt-fluxo.cd-agenda = tt-mov-conta.cd-agenda.
END.

IF cons-mov THEN DO:

    FIND FIRST conta NO-LOCK
        WHERE conta.cd-conta = iConta NO-ERROR.
    FOR EACH mov-conta OF conta NO-LOCK
        WHERE mov-conta.dt-mov >= DATE(mes,1,ano)
        AND   mov-conta.dt-mov <= fnUltimoDia(mes, ano)
        AND   mov-conta.id-situacao = 1
        AND mov-conta.agrupado = 0:

        FIND FIRST favorecido OF mov-conta NO-LOCK NO-ERROR.

        CREATE tt-fluxo.
        ASSIGN tt-fluxo.dt-fluxo = mov-conta.dt-mov
               tt-fluxo.dt-orig  = mov-conta.dt-mov
               tt-fluxo.vl-fluxo = mov-conta.de-valor
               tt-fluxo.ds-fluxo = favorecido.ds-favorecido
               tt-fluxo.fixo = YES.

    END.

END.

ASSIGN deSoma = 0.
FOR EACH tt-fluxo:
    ASSIGN deSoma = deSoma + tt-fluxo.vl-fluxo.
END.

CREATE tt-fluxo.
ASSIGN tt-fluxo.dt-fluxo = (DATE(mes,1,ano) - 1)
       tt-fluxo.dt-orig  = (DATE(mes,1,ano) - 1)
       tt-fluxo.ds-fluxo = "Saldo Inicial"
       tt-fluxo.vl-fluxo = deSoma
       tt-fluxo.fixo = YES.

RUN calculaSaldo.

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

APPLY "LEAVE" TO iConta IN FRAME {&FRAME-NAME}.

RUN criaFluxo.

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
  DISPLAY iConta des-conta mes ano cons-mov 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btData RECT-5 iConta mes ano cons-mov brFluxo btAcerta btExit 
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

FIND FIRST conta NO-LOCK
    WHERE conta.id-tipo = 1
    AND   NOT conta.id-encerrada NO-ERROR.
IF AVAIL conta THEN
    ASSIGN iConta = conta.cd-conta.

ASSIGN mes = MONTH(TODAY)
       ano = YEAR(TODAY).

{func\cursor.i iConta 1 "IN FRAME {&FRAME-NAME}"}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

