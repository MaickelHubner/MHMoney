&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-mov-conta NO-UNDO LIKE mov-conta
       field vl-saldo as decimal column-label "Saldo" format "->>,>>>,>>9.99"
       field r-rowid as rowid.



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

/* PrÇ-processadores */
&GLOBAL-DEFINE Table         conta
&GLOBAL-DEFINE Filho         tt-mov-conta
&GLOBAL-DEFINE LabelFilho    Movimentaá∆o
&GLOBAL-DEFINE ParentFields  conta.cd-conta conta.ds-conta ~
                             conta.vl-saldo conta.dt-saldo
&GLOBAL-DEFINE KeyFields     conta.cd-conta
&GLOBAL-DEFINE CamposFilho   tt-mov-conta.dt-mov WIDTH 11.5~
                             tt-mov-conta.nr-mov ~
                             fnTipo(tt-mov-conta.id-tipo) @ cTipo ~
                             fnCd-favorecido(tt-mov-conta.cd-favorecido) @ cCd-favorecido ~
                             fnSit(tt-mov-conta.id-situacao) @ cSit ~
                             tt-mov-conta.de-valor ~
                             tt-mov-conta.vl-saldo

/* Local Variable Definitions ---                                       */

{disp_movto.i}

/* Buffers */

{func\definitions.i}
DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE cCamposIniSaldo AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-favorecido AS ROWID      NO-UNDO.

/* Campos Extrangeiros */
{campos\cd-favorecido.i}

{func\ProgressGL\windows.i}
{func\maxim\var.i}

DEFINE BUFFER bf-mov FOR tt-mov-conta.
DEFINE BUFFER bf-mov2 FOR mov-conta.

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
&Scoped-define INTERNAL-TABLES {&Filho} conta

/* Definitions for BROWSE br-page1                                      */
&Scoped-define FIELDS-IN-QUERY-br-page1 {&CamposFilho}   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-page1   
&Scoped-define SELF-NAME br-page1
&Scoped-define QUERY-STRING-br-page1 FOR EACH {&Filho} NO-LOCK     WHERE {&Filho}.agrupado = 0     USE-INDEX valor. RUN controlButtons IN THIS-PROCEDURE
&Scoped-define OPEN-QUERY-br-page1 OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} NO-LOCK     WHERE {&Filho}.agrupado = 0     USE-INDEX valor. RUN controlButtons IN THIS-PROCEDURE.
&Scoped-define TABLES-IN-QUERY-br-page1 {&Filho}
&Scoped-define FIRST-TABLE-IN-QUERY-br-page1 {&Filho}


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME conta.cd-conta conta.ds-conta ~
conta.vl-saldo conta.dt-saldo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-DEFAULT-FRAME conta.cd-conta ~
conta.ds-conta conta.vl-saldo conta.dt-saldo 
&Scoped-define ENABLED-TABLES-IN-QUERY-DEFAULT-FRAME conta
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-DEFAULT-FRAME conta
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-page1}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH conta SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH conta SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME conta
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME conta


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS conta.cd-conta conta.ds-conta conta.vl-saldo ~
conta.dt-saldo 
&Scoped-define ENABLED-TABLES conta
&Scoped-define FIRST-ENABLED-TABLE conta
&Scoped-Define ENABLED-OBJECTS br-page1 btParc btAdd-page1 btCalc btSaldo ~
btImp btDel-page1 btExit btFirst btLast btNext btPrev btUpdate-page1 btGoTo ~
btZoom RECT-5 RECT-6 
&Scoped-Define DISPLAYED-FIELDS conta.cd-conta conta.ds-conta ~
conta.vl-saldo conta.dt-saldo 
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
DEFINE BUTTON btAdd-page1 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btCalc 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Sal" 
     SIZE 6.14 BY 1.79 TOOLTIP "Calculo de Valor L°quido".

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

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btGoTo 
     IMAGE-UP FILE "image/im-goto.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-goto.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "GoTo" 
     SIZE 6.14 BY 1.79 TOOLTIP "V† Para".

DEFINE BUTTON btImp 
     IMAGE-UP FILE "image/im-ofc.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-ofc.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Imp" 
     SIZE 6.14 BY 1.79 TOOLTIP "Importar Arquivo OFC".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btParc 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Parcelar Movto" 
     SIZE 6.14 BY 1.79 TOOLTIP "Parcelar Movto".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btSaldo 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Sal" 
     SIZE 6.14 BY 1.79 TOOLTIP "Atualizar Saldo da conta".

DEFINE BUTTON btUpdate-page1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 105 BY 1.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 105 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-page1 FOR 
      {&Filho} SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      conta SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-page1 C-Win _FREEFORM
  QUERY br-page1 NO-LOCK DISPLAY
      {&CamposFilho}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 105 BY 13
         FONT 7
         TITLE "".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     br-page1 AT ROW 5.75 COL 2
     btParc AT ROW 19 COL 101 WIDGET-ID 4
     btAdd-page1 AT ROW 19 COL 2
     btCalc AT ROW 1.5 COL 60.29
     btSaldo AT ROW 1.5 COL 54.14
     btImp AT ROW 1.5 COL 48
     btDel-page1 AT ROW 19 COL 14.29
     btExit AT ROW 1.5 COL 100
     btFirst AT ROW 1.5 COL 3
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btUpdate-page1 AT ROW 19 COL 8.14
     conta.cd-conta AT ROW 4.25 COL 9 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     conta.ds-conta AT ROW 4.25 COL 14.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 35 BY .79
     btGoTo AT ROW 1.5 COL 29
     btZoom AT ROW 1.5 COL 35.14
     conta.vl-saldo AT ROW 4.25 COL 57 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY .79
          BGCOLOR 21 FGCOLOR 15 
     conta.dt-saldo AT ROW 4.25 COL 83 COLON-ALIGNED
          LABEL "Atualizado em"
           VIEW-AS TEXT 
          SIZE 9 BY .67
     RECT-5 AT ROW 3.75 COL 2
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 106.86 BY 19.79
         FONT 7.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-mov-conta T "?" NO-UNDO money mov-conta
      ADDITIONAL-FIELDS:
          field vl-saldo as decimal column-label "Saldo" format "->>,>>>,>>9.99"
          field r-rowid as rowid
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Template Padr∆o de Master-Detail"
         HEIGHT             = 19.79
         WIDTH              = 106.86
         MAX-HEIGHT         = 34.92
         MAX-WIDTH          = 205.72
         VIRTUAL-HEIGHT     = 34.92
         VIRTUAL-WIDTH      = 205.72
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("image/mhmoney.ico":U) THEN
    MESSAGE "Unable to load icon: image/mhmoney.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br-page1 1 DEFAULT-FRAME */
ASSIGN 
       br-page1:COLUMN-RESIZABLE IN FRAME DEFAULT-FRAME       = TRUE
       br-page1:COLUMN-MOVABLE IN FRAME DEFAULT-FRAME         = TRUE.

/* SETTINGS FOR FILL-IN conta.cd-conta IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN conta.dt-saldo IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-page1
/* Query rebuild information for BROWSE br-page1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH {&Filho} NO-LOCK
    WHERE {&Filho}.agrupado = 0
    USE-INDEX valor.
RUN controlButtons IN THIS-PROCEDURE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br-page1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "money.conta"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Master-Detail */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Master-Detail */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESIZED OF C-Win /* Template Padr∆o de Master-Detail */
DO:
   {func\maxim\padrao.i &Frame=default-frame
                        &RetanguloSup="RECT-6"
                        &RetanguloChave="RECT-5"
                        &BotaoSair="btExit"
                        &Pagina="page1"}
                         
   {func\maxim\objeto.i &Objeto=btParc
                        &Frame=DEFAULT-FRAME
                        &LayoutH="Alinhado Direita Com"
                        &ObjAlin="br-page1"
                        &MudaTamanho="N∆o"
                        &LayoutV="Baixo"
                        &MudaAltura="N∆o"}

   {func\maxim\ini.i &Window=C-Win
                     &Frame=default-frame}
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-page1
&Scoped-define SELF-NAME br-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON CTRL-F OF br-page1 IN FRAME DEFAULT-FRAME
DO:
  
    IF AVAIL tt-mov-conta THEN DO:
        FIND FIRST favorecido OF tt-mov-conta NO-LOCK NO-ERROR.
        IF AVAIL favorecido THEN DO:
            ASSIGN r-favorecido = ROWID(favorecido).
            {func\run.i &Programa = "fav.w"}
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON CTRL-P OF br-page1 IN FRAME DEFAULT-FRAME
DO:
  
    IF AVAIL tt-mov-conta THEN DO:
        FIND FIRST bf-mov2 OF tt-mov-conta NO-LOCK NO-ERROR.
        IF AVAIL bf-mov2 THEN
            RUN gera-comp.p (INPUT ROWID(bf-mov2), INPUT 1).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON DELETE-CHARACTER OF br-page1 IN FRAME DEFAULT-FRAME
DO:
    {func\br_del.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON MOUSE-SELECT-DBLCLICK OF br-page1 IN FRAME DEFAULT-FRAME
OR RETURN OF br-page1 DO:
    {func\br_dbclick.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-page1 C-Win
ON ROW-DISPLAY OF br-page1 IN FRAME DEFAULT-FRAME
DO:
  
    IF tt-mov-conta.id-tipo = 0 THEN
        ASSIGN tt-mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 5
               tt-mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 5
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 5
               cSit:FGCOLOR IN BROWSE br-page1 = 5
               cTipo:FGCOLOR IN BROWSE br-page1 = 5
               tt-mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 5.

    IF tt-mov-conta.id-tipo = 3 THEN
        ASSIGN tt-mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 3
               tt-mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 3
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 3
               cSit:FGCOLOR IN BROWSE br-page1 = 3
               cTipo:FGCOLOR IN BROWSE br-page1 = 3
               tt-mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 3.

    IF tt-mov-conta.id-tipo = 1
    OR tt-mov-conta.id-tipo = 2 THEN
        ASSIGN tt-mov-conta.nr-mov:FGCOLOR IN BROWSE br-page1 = 1
               tt-mov-conta.dt-mov:FGCOLOR IN BROWSE br-page1 = 1
               cCd-Favorecido:FGCOLOR IN BROWSE br-page1 = 1
               cSit:FGCOLOR IN BROWSE br-page1 = 1
               cTipo:FGCOLOR IN BROWSE br-page1 = 1
               tt-mov-conta.de-valor:FGCOLOR IN BROWSE br-page1 = 1.

    IF tt-mov-conta.dt-mov > TODAY THEN
        ASSIGN tt-mov-conta.nr-mov:FONT IN BROWSE br-page1 = 0
               tt-mov-conta.dt-mov:FONT IN BROWSE br-page1 = 0
               cCd-Favorecido:FONT IN BROWSE br-page1 = 0
               cSit:FONT IN BROWSE br-page1 = 0
               cTipo:FONT IN BROWSE br-page1 = 0
               tt-mov-conta.de-valor:FONT IN BROWSE br-page1 = 0
               tt-mov-conta.vl-saldo:FONT IN BROWSE br-page1 = 0.

    IF tt-mov-conta.vl-saldo < 0 THEN
        ASSIGN tt-mov-conta.vl-saldo:FGCOLOR IN BROWSE br-page1 = 12.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd-page1 C-Win
ON CHOOSE OF btAdd-page1 IN FRAME DEFAULT-FRAME /* Incluir */
DO:
    {func\bt_add_page.i mov-conta}
    RUN geraTT IN THIS-PROCEDURE.
    {&OPEN-QUERY-{&BROWSE-NAME}}
    
    FOR FIRST bf-mov NO-LOCK
        WHERE bf-mov.agrupado = 0
        AND   bf-mov.dt-mov <= (TODAY + 30)
        USE-INDEX valor:
        REPOSITION br-page1 TO ROWID ROWID(bf-mov).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCalc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCalc C-Win
ON CHOOSE OF btCalc IN FRAME DEFAULT-FRAME /* Sal */
DO: 
   
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "valliq.w (INPUT ROWID(conta))"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel-page1 C-Win
ON CHOOSE OF btDel-page1 IN FRAME DEFAULT-FRAME /* Eliminar */
DO:
    DEFINE BUFFER bf-mov-conta FOR mov-conta.

    RUN som.p(INPUT "music\click.wav").

    RUN validateRecord IN THIS-PROCEDURE NO-ERROR.
    IF RETURN-VALUE <> "NOK" THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
        IF RETURN-VALUE = "OK":U THEN DO:
            FIND FIRST mov-conta EXCLUSIVE-LOCK
                WHERE ROWID(mov-conta) = {&Filho}.r-rowid.
            FOR EACH bf-mov-conta EXCLUSIVE-LOCK
                WHERE bf-mov-conta.agrupado = mov-conta.cd-sequencia
                AND   bf-mov-conta.cd-conta = mov-conta.cd-conta:

                DELETE bf-mov-conta.

            END.
            IF mov-conta.id-tipo = 3 THEN DO:
                FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
                    WHERE bf-mov-conta.cd-conta = mov-conta.conta-transf
                    AND   bf-mov-conta.cd-sequencia = mov-conta.seq-transf.
                DELETE bf-mov-conta.
            END.
            DELETE mov-conta.
            DELETE {&Filho}.
            RUN displayFields IN THIS-PROCEDURE.
            RUN som.p(INPUT "music\woosh.wav").
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


&Scoped-define SELF-NAME btFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btFirst C-Win
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_first.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btGoTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btGoTo C-Win
ON CHOOSE OF btGoTo IN FRAME DEFAULT-FRAME /* GoTo */
DO:
    {func\bt_goto.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btImp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btImp C-Win
ON CHOOSE OF btImp IN FRAME DEFAULT-FRAME /* Imp */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "compofc.w"}
    {func\run.i &Programa = "saldo.w"}
    RUN displayFields IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_last.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:  
   {func\bt_next.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btParc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btParc C-Win
ON CHOOSE OF btParc IN FRAME DEFAULT-FRAME /* Parcelar Movto */
DO:

    DEFINE BUFFER bfTT FOR tt-mov-conta.
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    IF tt-mov-conta.id-tipo <> 0 THEN DO:    /*agrupado*/
        {func\run.i &Programa = "geraparcmov.w (INPUT {&Filho}.r-rowid)"}
    END.

    RUN som.p(INPUT "music\click.wav").

    IF RETURN-VALUE = "OK" THEN DO:
        RUN geraTT IN THIS-PROCEDURE.
        FIND FIRST bfTT WHERE bfTT.r-rowid = r-mov-conta NO-ERROR.
        IF NOT AVAIL bfTT THEN DO:
            FIND LAST bfTT WHERE bfTT.dt-mov <= dtTemp NO-ERROR.
        END.
        {&OPEN-QUERY-{&BROWSE-NAME}}
        REPOSITION br-page1 TO ROWID ROWID(bfTT).
    END.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_prev.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSaldo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSaldo C-Win
ON CHOOSE OF btSaldo IN FRAME DEFAULT-FRAME /* Sal */
DO: 
   
    RUN som.p(INPUT "music\click.wav").
    ASSIGN cCamposIniSaldo = "".
    {func\run.i &Programa = "saldo.w"}
    RUN displayFields IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate-page1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate-page1 C-Win
ON CHOOSE OF btUpdate-page1 IN FRAME DEFAULT-FRAME /* Modificar */
DO:
    DEFINE BUFFER bfTT FOR tt-mov-conta.
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN pcActionBT = "UPDATE"
           r-parent = ROWID({&Table})
           r-mov-conta = {&Filho}.r-rowid
           dtTemp = tt-mov-conta.dt-mov.
    {func\run.i &Programa = "mov-conta_det.w"}
    IF RETURN-VALUE = "OK" 
    OR tt-mov-conta.id-tipo = 0 THEN DO:
        RUN geraTT IN THIS-PROCEDURE.
        FIND FIRST bfTT WHERE bfTT.r-rowid = r-mov-conta NO-ERROR.
        IF NOT AVAIL bfTT THEN DO:
            FIND LAST bfTT WHERE bfTT.dt-mov <= dtTemp NO-ERROR.
        END.
        {&OPEN-QUERY-{&BROWSE-NAME}}
        REPOSITION br-page1 TO ROWID ROWID(bfTT).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btZoom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btZoom C-Win
ON CHOOSE OF btZoom IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_zoom.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\main_block.i}

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
  {version.i mov}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\master_detail\control_buttons.i}

IF conta.id-tipo = 2
AND conta.cd-moeda <> 0 THEN
    ASSIGN btCalc:HIDDEN IN FRAME {&FRAME-NAME} = NO.
ELSE
    ASSIGN btCalc:HIDDEN IN FRAME {&FRAME-NAME} = YES.

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

RUN geraTT IN THIS-PROCEDURE.

{func\master_detail\display.i}

FOR FIRST bf-mov NO-LOCK
    WHERE bf-mov.agrupado = 0
    AND   bf-mov.dt-mov <= (TODAY + 30)
    USE-INDEX valor:
    REPOSITION br-page1 TO ROWID ROWID(bf-mov).
END.

IF NOT AVAIL {&Table} THEN DO:

    ASSIGN conta.cd-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ?
           conta.ds-conta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  IF AVAILABLE conta THEN 
    DISPLAY conta.cd-conta conta.ds-conta conta.vl-saldo conta.dt-saldo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE br-page1 btParc btAdd-page1 btCalc btSaldo btImp btDel-page1 btExit 
         btFirst btLast btNext btPrev btUpdate-page1 conta.cd-conta 
         conta.ds-conta btGoTo btZoom conta.vl-saldo conta.dt-saldo RECT-5 
         RECT-6 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geraTT C-Win 
PROCEDURE geraTT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO INITIAL 0.

FOR EACH tt-mov-conta:
    DELETE tt-mov-conta.
END.

ASSIGN deSaldo = conta.vl-saldo-ini.

FOR EACH mov-conta OF conta NO-LOCK
    WHERE mov-conta.agrupado = 0
    USE-INDEX extrato:
    CREATE tt-mov-conta.
    BUFFER-COPY mov-conta TO tt-mov-conta.
    ASSIGN tt-mov-conta.r-rowid = ROWID(mov-conta)
           deSaldo = deSaldo + mov-conta.de-valor
           tt-mov-conta.vl-saldo = deSaldo.

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
{func\initialize.i}

  DEFINE VARIABLE hSysMenu   AS  INTEGER NO-UNDO.
  DEFINE VARIABLE hParent    AS  INTEGER NO-UNDO.
  DEFINE VARIABLE hInstance  AS  INTEGER NO-UNDO.
  DEFINE VARIABLE iRetCode   AS  INTEGER NO-UNDO.
  DEFINE VARIABLE iCnt       AS  INTEGER NO-UNDO.

  RUN GetParent IN hpApi(INPUT {&window-NAME}:HWND,
                         OUTPUT hParent).
 
  /* Get handle to the window's system menu
     (Restore, Maximize, Move, close etc.) */
  RUN GetSystemMenu IN hpApi(INPUT  hParent, 
                             INPUT  0,
                             OUTPUT hSysMenu).
 
  IF hSysMenu NE 0 THEN
  DO:
    /* Get System menu's menu count */
    RUN GetMenuItemCount IN hpApi(INPUT hSysMenu,
                                  OUTPUT iCnt).
 
    IF iCnt NE 0 THEN
    DO:
      /* Menu count is based on 0 (0, 1, 2, 3...) */
 
      /* remove the "close option" */
      RUN RemoveMenu IN hpApi(INPUT hSysMenu, 
                              INPUT iCnt - 1, 
                              INPUT {&MF_BYPOSITION} + {&MF_REMOVE},
                              OUTPUT iRetCode).
 
      /* remove the seperator */
      RUN RemoveMenu IN hpApi(INPUT hSysMenu, 
                              INPUT iCnt - 2, 
                              INPUT {&MF_BYPOSITION} + {&MF_REMOVE},
                              OUTPUT iRetCode).
 
      /* Force caption bar's refresh which 
         will disable the window close ("X") button */
      RUN DrawMenuBar IN hpApi(INPUT  hParent,
                               OUTPUT iRetCode).
    END. /* if iCnt NE 0... */
  END. /* if hSysMenu NE 0... */
    
FOR FIRST bf-mov NO-LOCK
    WHERE bf-mov.agrupado = 0
    AND   bf-mov.dt-mov <= (TODAY + 30)
    USE-INDEX valor:
    REPOSITION br-page1 TO ROWID ROWID(bf-mov).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validateRecord C-Win 
PROCEDURE validateRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF CAN-FIND(FIRST parc-nota-fiscal
                WHERE parc-nota-fiscal.cd-conta = mov-conta.cd-conta
                AND   parc-nota-fiscal.cd-sequencia = mov-conta.cd-sequencia) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "J† existe parcela de nota fiscal relacionada a essa movimentaá∆o."}
    END.    
    IF CAN-FIND(FIRST nota-fiscal-imp
                WHERE nota-fiscal-imp.cd-conta = mov-conta.cd-conta
                AND   nota-fiscal-imp.cd-sequencia = mov-conta.cd-sequencia) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "J† existe imposto de nota fiscal relacionado a essa movimentaá∆o."}
    END.    
    IF CAN-FIND(FIRST mov-bens OF mov-conta) THEN DO:
        {func\valida.i &Mensagem  = "Eliminaá∆o n∆o permitida!"
                       &Ajuda     = "J† existe um bem relacionado a essa movimentaá∆o."}
    END.    

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

