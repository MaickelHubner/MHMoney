&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-mov-conta NO-UNDO LIKE mov-conta
       field memo as char.



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

&GLOBAL-DEFINE Table         conta
&GLOBAL-DEFINE ParentFields  conta.cd-conta conta.ds-conta

/* Parameters Definitions ---                                           */



DEFINE NEW GLOBAL SHARED VARIABLE cCamposIniSaldo AS CHARACTER  NO-UNDO.

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE procname AS CHARACTER  NO-UNDO.
DEFINE VARIABLE dtIni AS DATE       NO-UNDO.
DEFINE VARIABLE dtEnd AS DATE       NO-UNDO.
DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO.

{disp_movto.i}

{func\definitions.i}
{winalert.i}

/* Campos Extrangeiros */
{campos\cd-favorecido.i}

IF cDiretorio = "" THEN DO:
    FIND FIRST param-mn NO-LOCK.
    IF param-mn.ofc-dir <> "" THEN
        ASSIGN cDiretorio = param-mn.ofc-dir.
    ELSE
        ASSIGN cDiretorio = SESSION:TEMP-DIRECTORY.
END.

DEFINE STREAM s-temp.

DEFINE BUFFER bf-mov-conta FOR mov-conta.
DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-movtos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES mov-conta tt-mov-conta

/* Definitions for BROWSE br-movtos                                     */
&Scoped-define FIELDS-IN-QUERY-br-movtos mov-conta.dt-mov mov-conta.nr-mov fnTipo(mov-conta.id-tipo) @ cTipo fnCd-favorecido(mov-conta.cd-favorecido) @ cCd-favorecido mov-conta.de-valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-movtos   
&Scoped-define SELF-NAME br-movtos
&Scoped-define QUERY-STRING-br-movtos FOR EACH mov-conta OF {&Table} NO-LOCK     WHERE mov-conta.id-situacao = 1     AND   mov-conta.agrupado = 0     BY    mov-conta.dt-mov INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-movtos OPEN QUERY {&SELF-NAME} FOR EACH mov-conta OF {&Table} NO-LOCK     WHERE mov-conta.id-situacao = 1     AND   mov-conta.agrupado = 0     BY    mov-conta.dt-mov INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-movtos mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-br-movtos mov-conta


/* Definitions for BROWSE br-ofc                                        */
&Scoped-define FIELDS-IN-QUERY-br-ofc tt-mov-conta.dt-mov tt-mov-conta.nr-mov tt-mov-conta.memo tt-mov-conta.de-valor   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-ofc   
&Scoped-define SELF-NAME br-ofc
&Scoped-define QUERY-STRING-br-ofc FOR EACH tt-mov-conta NO-LOCK     BY    tt-mov-conta.dt-mov INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-ofc OPEN QUERY {&SELF-NAME} FOR EACH tt-mov-conta NO-LOCK     BY    tt-mov-conta.dt-mov INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-ofc tt-mov-conta
&Scoped-define FIRST-TABLE-IN-QUERY-br-ofc tt-mov-conta


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-movtos}~
    ~{&OPEN-QUERY-br-ofc}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btComp RECT-6 RECT-7 br-movtos br-ofc btNovo ~
btSaltar btExit 
&Scoped-Define DISPLAYED-FIELDS conta.cd-conta conta.ds-conta 
&Scoped-define DISPLAYED-TABLES conta
&Scoped-define FIRST-DISPLAYED-TABLE conta


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btComp 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Compensar".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btNovo 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Novo Movimento".

DEFINE BUTTON btOFC 
     IMAGE-UP FILE "image/im-ofc.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-ofc.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Abrir OFC".

DEFINE BUTTON btSaltar 
     IMAGE-UP FILE "image/im-saltar.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saltar.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Saltar".

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 2.25.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 1.75.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-movtos FOR 
      mov-conta SCROLLING.

DEFINE QUERY br-ofc FOR 
      tt-mov-conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-movtos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-movtos C-Win _FREEFORM
  QUERY br-movtos NO-LOCK DISPLAY
      mov-conta.dt-mov
mov-conta.nr-mov
fnTipo(mov-conta.id-tipo) @ cTipo
fnCd-favorecido(mov-conta.cd-favorecido) @ cCd-favorecido
mov-conta.de-valor
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE SIZE 85 BY 5.96
         FONT 7
         TITLE "Movimentos N∆o Compensados" FIT-LAST-COLUMN.

DEFINE BROWSE br-ofc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-ofc C-Win _FREEFORM
  QUERY br-ofc NO-LOCK DISPLAY
      tt-mov-conta.dt-mov
tt-mov-conta.nr-mov
tt-mov-conta.memo FORMAT "X(65)"
tt-mov-conta.de-valor
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS MULTIPLE SIZE 85 BY 5.96
         FONT 7
         TITLE "Movimentos no OFC" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btComp AT ROW 11.75 COL 2
     conta.cd-conta AT ROW 4.25 COL 20 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     conta.ds-conta AT ROW 4.25 COL 24.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 51 BY .79
     br-movtos AT ROW 5.75 COL 2
     br-ofc AT ROW 13.75 COL 2
     btNovo AT ROW 19.75 COL 2
     btOFC AT ROW 1.5 COL 3
     btSaltar AT ROW 19.75 COL 8.14
     btExit AT ROW 1.5 COL 80
     RECT-6 AT ROW 1.25 COL 2
     RECT-7 AT ROW 3.75 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.72 BY 20.54
         FONT 1.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-mov-conta T "?" NO-UNDO money mov-conta
      ADDITIONAL-FIELDS:
          field memo as char
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
         HEIGHT             = 20.54
         WIDTH              = 86.72
         MAX-HEIGHT         = 29.75
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 29.75
         VIRTUAL-WIDTH      = 146.29
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
/* BROWSE-TAB br-movtos ds-conta DEFAULT-FRAME */
/* BROWSE-TAB br-ofc br-movtos DEFAULT-FRAME */
ASSIGN 
       br-movtos:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-movtos:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

ASSIGN 
       br-ofc:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-ofc:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR BUTTON btOFC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN conta.cd-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN conta.ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-movtos
/* Query rebuild information for BROWSE br-movtos
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH mov-conta OF {&Table} NO-LOCK
    WHERE mov-conta.id-situacao = 1
    AND   mov-conta.agrupado = 0
    BY    mov-conta.dt-mov INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-movtos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-ofc
/* Query rebuild information for BROWSE br-ofc
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-mov-conta NO-LOCK
    BY    tt-mov-conta.dt-mov INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-ofc */
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


&Scoped-define BROWSE-NAME br-movtos
&Scoped-define SELF-NAME br-movtos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-movtos C-Win
ON ROW-DISPLAY OF br-movtos IN FRAME DEFAULT-FRAME /* Movimentos N∆o Compensados */
DO:
    IF mov-conta.id-tipo = 0 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-movtos = 5
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-movtos = 5
               cCd-Favorecido:FGCOLOR IN BROWSE br-movtos = 5
               cTipo:FGCOLOR IN BROWSE br-movtos = 5
               mov-conta.de-valor:FGCOLOR IN BROWSE br-movtos = 5.

    IF mov-conta.id-tipo = 3 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-movtos = 3
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-movtos = 3
               cCd-Favorecido:FGCOLOR IN BROWSE br-movtos = 3
               cTipo:FGCOLOR IN BROWSE br-movtos = 3
               mov-conta.de-valor:FGCOLOR IN BROWSE br-movtos = 3.

    IF mov-conta.id-tipo = 1
    OR mov-conta.id-tipo = 2 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-movtos = 1
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-movtos = 1
               cCd-Favorecido:FGCOLOR IN BROWSE br-movtos = 1
               cTipo:FGCOLOR IN BROWSE br-movtos = 1
               mov-conta.de-valor:FGCOLOR IN BROWSE br-movtos = 1.

    IF mov-conta.id-situacao <> 1 THEN
        ASSIGN mov-conta.nr-mov:FGCOLOR IN BROWSE br-movtos = 8
               mov-conta.dt-mov:FGCOLOR IN BROWSE br-movtos = 8
               cCd-Favorecido:FGCOLOR IN BROWSE br-movtos = 8
               cTipo:FGCOLOR IN BROWSE br-movtos = 8
               mov-conta.de-valor:FGCOLOR IN BROWSE br-movtos = 8.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btComp C-Win
ON CHOOSE OF btComp IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
  
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE cNum AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cMemo AS CHARACTER  NO-UNDO.
    
    RUN som.p(INPUT "music\click.wav").

    IF br-movtos:NUM-SELECTED-ROWS = 0
    OR br-ofc:NUM-SELECTED-ROWS = 0 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (021)', INPUT 'Seleá∆o inv†lida!', INPUT 'Vocà deve selecionar no m°nimo um registro em cada browser.')"}
        RETURN "NOK".
    END.

    IF br-movtos:NUM-SELECTED-ROWS > 1
    AND br-ofc:NUM-SELECTED-ROWS > 1 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (020)', INPUT 'Seleá∆o inv†lida!', INPUT 'Existe mais de um movimento selecionado em ambos os browsers. Para compensar ao menos um deles deve ter somente um registro selecionado.')"}
        RETURN "NOK".
    END.

    ASSIGN deTemp = 0
           dtTemp = ?
           cNum = ""
           cMemo = "".

    IF br-movtos:NUM-SELECTED-ROWS = 1 THEN DO:

        /* Compensa s¢ um movimento com mais de um do OFC */

        br-movtos:FETCH-SELECTED-ROW(1).
        FIND CURRENT mov-conta EXCLUSIVE-LOCK NO-ERROR.

        REPEAT iCont = 1 TO br-ofc:NUM-SELECTED-ROWS:

            br-ofc:FETCH-SELECTED-ROW(iCont).
            ASSIGN deTemp = deTemp + tt-mov-conta.de-valor
                   cNum   = tt-mov-conta.nr-mov
                   cMemo  = cMemo + CHR(10) + tt-mov-conta.memo.

            IF dtTemp = ? THEN
                ASSIGN dtTemp = tt-mov-conta.dt-mov.
            ELSE DO:
                IF tt-mov-conta.dt-mov <> dtTemp THEN DO:
                    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (022)', INPUT 'Seleá∆o inv†lida!', INPUT 'As datas dom movimentos do OFC selecionados s∆o diferentes e n∆o podem compensar o mesmo movimento.')"}
                    RETURN "NOK".
                END.
            END.

        END.

        IF deTemp <> mov-conta.de-valor THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (023)', INPUT 'Seleá∆o inv†lida!', INPUT 'O valor dos movimentos do OFC selecionados Ç diferente do valor do movimento a ser compensado.')"}
            RETURN "NOK".
        END.

        IF dtTemp < mov-conta.dt-mov THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (024)', INPUT 'Data inv†lida!', INPUT 'A data de compensaá∆o n∆o pode ser menor que a data do movimento.')"}
            RETURN "NOK".
        END.

        ASSIGN mov-conta.id-situacao = 2
               mov-conta.dt-compensacao = dtTemp
               mov-conta.ds-observacao = mov-conta.ds-observacao + cMemo.
        IF cNum <> "0" THEN
            IF mov-conta.nr-mov = "" THEN
                ASSIGN mov-conta.nr-mov = cNum.

        IF mov-conta.id-tipo = 0 THEN DO:
            FOR EACH bf-mov-conta EXCLUSIVE-LOCK
                WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
                AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
                ASSIGN bf-mov-conta.dt-compensacao = mov-conta.dt-compensacao
                       bf-mov-conta.id-situacao = mov-conta.id-situacao
                       bf-mov-conta.nr-mov = mov-conta.nr-mov.
            END.
        END.

        REPEAT iCont = 1 TO br-ofc:NUM-SELECTED-ROWS:
            br-ofc:FETCH-SELECTED-ROW(iCont).
            DELETE tt-mov-conta.
        END.

    END.
    ELSE DO:

        /* Compensa mais de um movimento com um do OFC */

        br-ofc:FETCH-SELECTED-ROW(1).

        REPEAT iCont = 1 TO br-movtos:NUM-SELECTED-ROWS:
            br-movtos:FETCH-SELECTED-ROW(iCont).
            ASSIGN deTemp = deTemp + mov-conta.de-valor.

            IF tt-mov-conta.dt-mov < mov-conta.dt-mov THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (024)', INPUT 'Data inv†lida!', INPUT 'A data de compensaá∆o n∆o pode ser menor que a data do movimento.')"}
                RETURN "NOK".
            END.

        END.        

        IF deTemp <> tt-mov-conta.de-valor THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Compensar Movimento (023)', INPUT 'Seleá∆o inv†lida!', INPUT 'O valor dos movimentos selecionados Ç diferente do valor do movimento no OFC.')"}
            RETURN "NOK".
        END.

        REPEAT iCont = 1 TO br-movtos:NUM-SELECTED-ROWS:

            br-movtos:FETCH-SELECTED-ROW(iCont).
            FIND CURRENT mov-conta EXCLUSIVE-LOCK NO-ERROR.

            ASSIGN mov-conta.id-situacao = 2
                   mov-conta.dt-compensacao = tt-mov-conta.dt-mov
                   mov-conta.ds-observacao = mov-conta.ds-observacao + CHR(10) + tt-mov-conta.memo.
            IF tt-mov-conta.nr-mov <> "0" THEN
                IF mov-conta.nr-mov = "" THEN
                    ASSIGN mov-conta.nr-mov = tt-mov-conta.nr-mov.

            IF mov-conta.id-tipo = 0 THEN DO:
                FOR EACH bf-mov-conta EXCLUSIVE-LOCK
                    WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
                    AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
                    ASSIGN bf-mov-conta.dt-compensacao = mov-conta.dt-compensacao
                           bf-mov-conta.id-situacao = mov-conta.id-situacao
                           bf-mov-conta.nr-mov = mov-conta.nr-mov.
                END.
            END.


        END.

        DELETE tt-mov-conta.

    END.

    RUN som.p(INPUT "music\ok.wav").
    RUN displayFields IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btExit C-Win
ON CHOOSE OF btExit IN FRAME DEFAULT-FRAME /* Button 1 */
DO:
  
    {func\bt_fechar.i}
    ASSIGN cCamposIniSaldo = "data=" + STRING(dtEnd,"99/99/9999") + ",saldo-ofc=" + REPLACE(STRING(deSaldo),",",".").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNovo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNovo C-Win
ON CHOOSE OF btNovo IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iAux  AS INTEGER     NO-UNDO.
    DEFINE VARIABLE l-alterou AS LOGICAL     NO-UNDO INITIAL NO.

    RUN som.p(INPUT "music\click.wav").

    blk-trans:
    DO TRANSACTION:

        REPEAT iCont = 1 TO br-ofc:NUM-SELECTED-ROWS:
            br-ofc:FETCH-SELECTED-ROW(iCont).

            CREATE mov-conta.
            ASSIGN mov-conta.cd-conta = conta.cd-conta.
            FIND LAST bf-mov-conta NO-LOCK
                WHERE bf-mov-conta.cd-conta = conta.cd-conta NO-ERROR.
            IF AVAIL bf-mov-conta THEN
                ASSIGN mov-conta.cd-sequencia = bf-mov-conta.cd-sequencia + 1.
            ELSE
                ASSIGN mov-conta.cd-sequencia = 1.
            BUFFER-COPY tt-mov-conta EXCEPT cd-conta cd-sequencia TO mov-conta.
            ASSIGN mov-conta.ds-observacao = tt-mov-conta.memo
                   mov-conta.id-situacao = 2
                   mov-conta.dt-compensacao = tt-mov-conta.dt-mov.
            CASE conta.id-tipo:
                WHEN 1 THEN DO:
                    IF mov-conta.de-valor > 0 THEN
                        ASSIGN mov-conta.id-tipo = 1.
                    ELSE
                        ASSIGN mov-conta.id-tipo = 5.
                END.
                WHEN 2 THEN DO:
                    IF mov-conta.de-valor > 0 THEN
                        ASSIGN mov-conta.id-tipo = 1.
                    ELSE
                        ASSIGN mov-conta.id-tipo = 6.
                END.
                WHEN 3 THEN DO:
                    IF mov-conta.de-valor > 0 THEN
                        ASSIGN mov-conta.id-tipo = 2.
                    ELSE
                        ASSIGN mov-conta.id-tipo = 7.
                END.
            END CASE.
            IF NOT l-alterou THEN DO:
                ASSIGN r-mov-conta = ROWID(mov-conta)
                       r-parent = ROWID(conta)
                       pcActionBT = "UPDATE".
                {func\run.i &Programa = "mov-conta_det.w"}
                IF RETURN-VALUE <> "OK" THEN DO:
                    UNDO blk-trans, LEAVE blk-trans.
                END.
            END.

            IF iCont = 1 
            AND br-ofc:NUM-SELECTED-ROWS > 1 THEN DO:
                /* Duplica Favorecido e Categoria para os demais */
                {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Utiliza Informaá‰es (048)', INPUT 'Utiliza informaá‰es para os demais ?', INPUT 'Deseja utilizar o mesmo Favorecido, Categoria e Sub-Categoria para os demais movimentos selecionados ?')"}
                IF RETURN-VALUE = "OK" THEN DO:
                    ASSIGN l-alterou = YES.
                    REPEAT iAux = 2 TO br-ofc:NUM-SELECTED-ROWS:
                        br-ofc:FETCH-SELECTED-ROW(iAux).
                        ASSIGN tt-mov-conta.cd-favorecido = mov-conta.cd-favorecido
                               tt-mov-conta.cod-categoria = mov-conta.cod-categoria
                               tt-mov-conta.cd-sub = mov-conta.cd-sub.
                    END.
                END.
            END.

            br-ofc:FETCH-SELECTED-ROW(iCont).
            DELETE tt-mov-conta.

        END.
                               
        IF l-alterou THEN
            /* Roda o programa de alertas do usu†rio */
            {func\run.i &Programa = "winalert.w (INPUT 2, INPUT ROWID(mov-conta), INPUT YES, OUTPUT TABLE tt-alerta)"}

        RUN displayFields.

    END. /* blk-trans */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOFC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOFC C-Win
ON CHOOSE OF btOFC IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
  
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN procname = "".

    SYSTEM-DIALOG GET-FILE procname
          TITLE      "Arquivo de Movimentos"
          FILTERS    "Arquivos OFC"   "*.ofc",
                     "Todos os Arquivos"      "*.*"
          INITIAL-DIR cDiretorio
          MUST-EXIST
          USE-FILENAME
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:
        ASSIGN cDiretorio = SUBSTRING(procname,1,INDEX(procname,ENTRY(NUM-ENTRIES(procname,"\"),procname,"\"))).
        RUN criaTT IN THIS-PROCEDURE.
    END.
    ELSE DO:
        ENABLE btOFC WITH FRAME {&FRAME-NAME}.
    END.

    RUN displayFields IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSaltar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSaltar C-Win
ON CHOOSE OF btSaltar IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
  
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    REPEAT iCont = 1 TO br-ofc:NUM-SELECTED-ROWS:
        br-ofc:FETCH-SELECTED-ROW(iCont).
        DELETE tt-mov-conta.
    END.
    RUN som.p(INPUT "music\ok.wav").
    RUN displayFields IN THIS-PROCEDURE.

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
  {version.i compofc}
  RUN enable_UI.
  RUN initialize.
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

SESSION:SET-WAIT-STATE("image\importa.cur").

DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.

DEFINE VARIABLE dtMov AS DATE       NO-UNDO.
DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
DEFINE VARIABLE cNum AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cMemo AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cAux AS CHARACTER  NO-UNDO.

DEFINE VARIABLE iSeq AS INTEGER    NO-UNDO INITIAL 1.

INPUT STREAM s-temp FROM VALUE(procname) CONVERT TARGET "ibm850".

REPEAT:
    IMPORT STREAM s-temp UNFORMATTED cTemp.
    ASSIGN cTemp = TRIM(cTemp).
    IF cTemp MATCHES("*DTSTART*") THEN DO:
        ASSIGN cTemp = ENTRY(2,cTemp,">").
        IF cTemp MATCHES("*</*") THEN
            ASSIGN cTemp = ENTRY(1,cTemp,"</").
        ASSIGN dtIni = DATE(INTEGER(SUBSTRING(cTemp,5,2)),
                            INTEGER(SUBSTRING(cTemp,7,2)),
                            INTEGER(SUBSTRING(cTemp,1,4))).
    END.
    IF cTemp MATCHES("*DTEND*") THEN DO:
        ASSIGN cTemp = ENTRY(2,cTemp,">").
        IF cTemp MATCHES("*</*") THEN
            ASSIGN cTemp = ENTRY(1,cTemp,"</").
        ASSIGN dtEnd = DATE(INTEGER(SUBSTRING(cTemp,5,2)),
                            INTEGER(SUBSTRING(cTemp,7,2)),
                            INTEGER(SUBSTRING(cTemp,1,4))).
    END.
    IF cTemp MATCHES("*LEDGER*") THEN DO:
        ASSIGN cTemp = REPLACE(REPLACE(ENTRY(2,cTemp,">"),",",""),".",",").
        IF cTemp MATCHES("*</*") THEN
            ASSIGN cTemp = ENTRY(1,cTemp,"</").
        ASSIGN deSaldo = DECIMAL(cTemp).
    END.
    IF cTemp MATCHES("*<STMTTRN>*") THEN DO:
        DO WHILE NOT cTemp MATCHES("*</STMTTRN>*"):
            IMPORT STREAM s-temp UNFORMATTED cTemp.
            IF cTemp MATCHES("*DTPOSTED*") THEN DO:
                ASSIGN cTemp = ENTRY(2,cTemp,">").
                IF cTemp MATCHES("*</*") THEN
                    ASSIGN cTemp = ENTRY(1,cTemp,"</").
                ASSIGN dtMov = DATE(INTEGER(SUBSTRING(cTemp,5,2)),
                                    INTEGER(SUBSTRING(cTemp,7,2)),
                                    INTEGER(SUBSTRING(cTemp,1,4))).
            END.
            IF cTemp MATCHES("*TRNAMT*") THEN DO:
                ASSIGN cAux = SESSION:NUMERIC-FORMAT.
                SESSION:NUMERIC-FORMAT = "EUROPEAN".
                ASSIGN cTemp = REPLACE(REPLACE(ENTRY(2,cTemp,">"),",",""),".",",").
                IF cTemp MATCHES("*</*") THEN
                    ASSIGN cTemp = ENTRY(1,cTemp,"</").
                ASSIGN deValor = DECIMAL(cTemp).
                SESSION:NUMERIC-FORMAT = cAux.
            END.
            IF cTemp MATCHES("*CHKNUM*") THEN DO:
                ASSIGN cNum = ENTRY(2,cTemp,">").
                IF cNum MATCHES("*</*") THEN
                    ASSIGN cNum = ENTRY(1,cNum,"</").
            END.
            IF cTemp MATCHES("*MEMO*") THEN DO:
                ASSIGN cMemo = ENTRY(2,cTemp,">").
                IF cMemo MATCHES("*</*") THEN
                    ASSIGN cMemo = ENTRY(1,cMemo,"</").
            END.
        END.
        IF dtMov >= conta.dt-saldo OR conta.dt-saldo = ? THEN DO:
            find first mov-conta 
                where mov-conta.cd-conta       = INPUT FRAME {&FRAME-NAME} conta.cd-conta
                AND   mov-conta.dt-compensacao = dtMov
                and   mov-conta.de-valor       = deValor
                and   mov-conta.nr-mov         = cNum
                and   mov-conta.id-situacao    <> 1
                and   mov-conta.ds-observacao matches("*" + cMemo + "*") NO-LOCK no-error.
            if not avail mov-conta then do:
                CREATE tt-mov-conta.
                ASSIGN tt-mov-conta.cd-sequencia = iSeq
                       tt-mov-conta.dt-mov = dtMov
                       tt-mov-conta.de-valor = deValor
                       tt-mov-conta.nr-mov = cNum
                       tt-mov-conta.memo = cMemo
                       iSeq = iSeq + 1.
            end.
        END.
    END.
END.

INPUT STREAM s-temp CLOSE.

SESSION:SET-WAIT-STATE("").

IF NOT CAN-FIND(FIRST tt-mov-conta) THEN DO:

    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Importaá∆o de OFC (018)', INPUT 'Arquivo OFC sem movimentos v†lidos!', INPUT 'O arquivo OFC selecionado n∆o possui nenhum movimento que j† n∆o tenha sido lanáado no sistema.')"}
    ENABLE btOFC WITH FRAME {&FRAME-NAME}.

END.
ELSE DO:

    DISABLE btOFC WITH FRAME {&FRAME-NAME}.

END.

RETURN "OK".


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
DEFINE VARIABLE hQrMov AS HANDLE     NO-UNDO.
DEFINE VARIABLE hQrOfc AS HANDLE     NO-UNDO.

IF AVAIL {&Table} THEN DO:

    DISPLAY {&ParentFields} WITH FRAME {&FRAME-NAME}.

    ASSIGN r-{&Table} = ROWID({&Table}).

    {&OPEN-QUERY-br-movtos}
    {&OPEN-QUERY-br-ofc}

    ASSIGN hQrMov = br-movtos:QUERY IN FRAME {&FRAME-NAME}
           hQrOfc = br-ofc:QUERY IN FRAME {&FRAME-NAME}.
    IF hQrMov:NUM-RESULTS = 0
    OR hQrOfc:NUM-RESULTS = 0 THEN DO:
        DISABLE btComp WITH FRAME {&FRAME-NAME}.
        IF hQrOfc:NUM-RESULTS = 0 THEN DO:
            DISABLE btNovo
                    btSaltar WITH FRAME {&FRAME-NAME}.
        END.
        ELSE DO:
            ENABLE btNovo
                   btSaltar WITH FRAME {&FRAME-NAME}.
        END.
    END.
    ELSE DO:
        ENABLE btComp WITH FRAME {&FRAME-NAME}.
        IF hQrOfc:NUM-RESULTS = 0 THEN DO:
            DISABLE btNovo
                    btSaltar WITH FRAME {&FRAME-NAME}.
        END.
        ELSE DO:
            ENABLE btNovo
                   btSaltar WITH FRAME {&FRAME-NAME}.
        END.
    END.

END.

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
  IF AVAILABLE conta THEN 
    DISPLAY conta.cd-conta conta.ds-conta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btComp RECT-6 RECT-7 br-movtos br-ofc btNovo btSaltar btExit 
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

IF r-{&Table} <> ? THEN DO:
    FIND FIRST {&Table} NO-LOCK
        WHERE ROWID({&Table}) = r-{&Table} NO-ERROR.

    DISABLE {&ParentFields} WITH FRAME {&FRAME-NAME}.
    APPLY "ENTRY" TO C-Win.

    RUN displayFields IN THIS-PROCEDURE.

    APPLY "CHOOSE" TO btOFC IN FRAME {&FRAME-NAME}.

END.
ELSE DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

