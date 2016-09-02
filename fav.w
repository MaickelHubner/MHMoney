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

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        favorecido
&GLOBAL-DEFINE KeyFields    favorecido.cd-favorecido
&GLOBAL-DEFINE FrameFields  favorecido.ds-favorecido favorecido.rua ~
                            favorecido.numero favorecido.complemento ~
                            favorecido.bairro favorecido.cidade ~
                            favorecido.estado favorecido.telefone ~
                            favorecido.cgc favorecido.cep ~
                            favorecido.ds-observacao favorecido.tem-endereco ~
                            favorecido.tipo favorecido.data-nasc ~
                            favorecido.e-mail favorecido.contato ~
                            favorecido.banco favorecido.agencia ~
                            favorecido.ins-estadual favorecido.conta-bancaria ~
                            favorecido.ativo favorecido.razao-social favorecido.dia-pagto-padrao ~
                            favorecido.dias-uteis-pagto favorecido.dia-semana-pagto ~
                            favorecido.tipo-pagto favorecido.desconto-prim-parc



/* Local Variable Definitions ---                                       */

DEFINE VARIABLE cDiretorio AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cImagem AS CHARACTER  NO-UNDO.

/* Buffers */

{func\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS favorecido.cd-favorecido favorecido.ativo ~
favorecido.data-nasc favorecido.ds-favorecido favorecido.e-mail ~
favorecido.contato favorecido.tipo favorecido.tem-endereco ~
favorecido.razao-social favorecido.rua favorecido.numero ~
favorecido.complemento favorecido.bairro favorecido.cidade ~
favorecido.estado favorecido.telefone favorecido.cgc favorecido.cep ~
favorecido.ins-estadual favorecido.banco favorecido.agencia ~
favorecido.conta-bancaria favorecido.tipo-pagto ~
favorecido.desconto-prim-parc favorecido.dia-pagto-padrao ~
favorecido.dias-uteis-pagto favorecido.dia-semana-pagto ~
favorecido.ds-observacao 
&Scoped-define ENABLED-TABLES favorecido
&Scoped-define FIRST-ENABLED-TABLE favorecido
&Scoped-Define ENABLED-OBJECTS btDespesas btMov btGoTo btFirst btLast ~
btNext btPrev btAdd btDel btExit btUpdate btZoom RECT-4 RECT-5 RECT-7 ~
RECT-11 IMAGE-1 
&Scoped-Define DISPLAYED-FIELDS favorecido.cd-favorecido favorecido.ativo ~
favorecido.data-nasc favorecido.ds-favorecido favorecido.e-mail ~
favorecido.contato favorecido.tipo favorecido.tem-endereco ~
favorecido.razao-social favorecido.rua favorecido.numero ~
favorecido.complemento favorecido.bairro favorecido.cidade ~
favorecido.estado favorecido.telefone favorecido.cgc favorecido.cep ~
favorecido.ins-estadual favorecido.banco favorecido.agencia ~
favorecido.conta-bancaria favorecido.tipo-pagto ~
favorecido.desconto-prim-parc favorecido.dia-pagto-padrao ~
favorecido.dias-uteis-pagto favorecido.dia-semana-pagto ~
favorecido.ds-observacao 
&Scoped-define DISPLAYED-TABLES favorecido
&Scoped-define FIRST-DISPLAYED-TABLE favorecido


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btDel 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Eliminar".

DEFINE BUTTON btDespesas 
     IMAGE-UP FILE "image/im-valor.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-valor.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Reembolso de Despesas" 
     SIZE 6.14 BY 1.79 TOOLTIP "Atualizar Reembolso de Despesas".

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

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btMov 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentos do Favorecido".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btUpdate 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE BUTTON btZoom 
     IMAGE-UP FILE "image/im-zoom.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-zoom.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pesquisa".

DEFINE IMAGE IMAGE-1
     FILENAME "adeicon/blank":U
     STRETCH-TO-FIT RETAIN-SHAPE
     SIZE 25 BY 5.75.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 3.5.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 4.5.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 2.25.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 5.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     favorecido.cd-favorecido AT ROW 4 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     favorecido.ativo AT ROW 4 COL 27 WIDGET-ID 28
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .83
     btDespesas AT ROW 1.5 COL 69 WIDGET-ID 64
     favorecido.data-nasc AT ROW 4 COL 52 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     favorecido.ds-favorecido AT ROW 5 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 45 BY .79
     favorecido.e-mail AT ROW 6 COL 19 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 45 BY .79
     favorecido.contato AT ROW 7 COL 19 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 45 BY .79
     favorecido.tipo AT ROW 5 COL 73 NO-LABEL WIDGET-ID 6
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Cliente", 1,
"Fornecedor", 2,
"Ambos", 3
          SIZE 11 BY 2
     favorecido.tem-endereco AT ROW 8.25 COL 3
          LABEL "Endereáo"
          VIEW-AS TOGGLE-BOX
          SIZE 9.57 BY .83
     favorecido.razao-social AT ROW 9 COL 14.29 COLON-ALIGNED WIDGET-ID 30
          VIEW-AS FILL-IN 
          SIZE 71 BY .79
     favorecido.rua AT ROW 10 COL 14.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 56 BY .79
     favorecido.numero AT ROW 10 COL 77.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     btMov AT ROW 1.5 COL 63
     favorecido.complemento AT ROW 11 COL 14.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY .79
     favorecido.bairro AT ROW 11 COL 36 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY .79
     favorecido.cidade AT ROW 11 COL 58 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 23 BY .79
     favorecido.estado AT ROW 11 COL 81.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     favorecido.telefone AT ROW 12 COL 14.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY .79
     favorecido.cgc AT ROW 12 COL 39.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 31 BY .79
     favorecido.cep AT ROW 12 COL 75.29 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     favorecido.ins-estadual AT ROW 13 COL 14.29 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 16 BY .79
     btGoTo AT ROW 1.5 COL 48.43
     favorecido.banco AT ROW 14.75 COL 14 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 71 BY .79
     favorecido.agencia AT ROW 15.75 COL 14 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     favorecido.conta-bancaria AT ROW 15.75 COL 28 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 8.86 BY .79
     favorecido.tipo-pagto AT ROW 15.75 COL 47 COLON-ALIGNED WIDGET-ID 60
          VIEW-AS COMBO-BOX INNER-LINES 3
          LIST-ITEM-PAIRS "Boleto",1,
                     "Dep¢sito",2,
                     "Outros",9
          DROP-DOWN-LIST
          SIZE 12 BY 1
     favorecido.desconto-prim-parc AT ROW 15.75 COL 62 WIDGET-ID 48
          VIEW-AS TOGGLE-BOX
          SIZE 25 BY .88
     btFirst AT ROW 1.5 COL 3
     favorecido.dia-pagto-padrao AT ROW 16.75 COL 14 COLON-ALIGNED WIDGET-ID 32
          VIEW-AS FILL-IN 
          SIZE 4 BY .88
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 91.29 BY 24.54
         FONT 7.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     favorecido.dias-uteis-pagto AT ROW 16.75 COL 47 COLON-ALIGNED WIDGET-ID 62
          VIEW-AS FILL-IN 
          SIZE 5 BY .88
     favorecido.dia-semana-pagto AT ROW 16.75 COL 73 COLON-ALIGNED WIDGET-ID 58
          VIEW-AS COMBO-BOX INNER-LINES 8
          LIST-ITEM-PAIRS "Nenhum",0,
                     "Domingo",1,
                     "Segunda",2,
                     "Teráa",3,
                     "Quarta",4,
                     "Quinta",5,
                     "Sexta",6,
                     "S†bado",7
          DROP-DOWN-LIST
          SIZE 12 BY 1
     favorecido.ds-observacao AT ROW 18.29 COL 38 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 53 BY 4
     btLast AT ROW 1.5 COL 21.43
     btNext AT ROW 1.5 COL 15.29
     btPrev AT ROW 1.5 COL 9.14
     btAdd AT ROW 1.5 COL 30
     btCancel AT ROW 22.54 COL 84.29
     btDel AT ROW 1.5 COL 42.29
     btExit AT ROW 1.5 COL 84
     btOK AT ROW 22.54 COL 78.14
     btUpdate AT ROW 1.5 COL 36.14
     btZoom AT ROW 1.5 COL 54.57
     "Observaá∆o:" VIEW-AS TEXT
          SIZE 9 BY .54 AT ROW 18.25 COL 28
     RECT-4 AT ROW 3.75 COL 2
     RECT-5 AT ROW 1.25 COL 2
     RECT-7 AT ROW 8.58 COL 2
     RECT-11 AT ROW 14.5 COL 2 WIDGET-ID 10
     IMAGE-1 AT ROW 18.29 COL 2 WIDGET-ID 26
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 91.29 BY 24.54
         FONT 7.


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
         TITLE              = "Cadastro de favorecido"
         HEIGHT             = 23.63
         WIDTH              = 90.57
         MAX-HEIGHT         = 33.88
         MAX-WIDTH          = 205.72
         VIRTUAL-HEIGHT     = 33.88
         VIRTUAL-WIDTH      = 205.72
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
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       favorecido.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

/* SETTINGS FOR TOGGLE-BOX favorecido.tem-endereco IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Cadastro de favorecido */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Cadastro de favorecido */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.bairro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.bairro C-Win
ON ENTRY OF favorecido.bairro IN FRAME DEFAULT-FRAME /* Bairro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.bairro C-Win
ON LEAVE OF favorecido.bairro IN FRAME DEFAULT-FRAME /* Bairro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_add.i "cd-favorecido"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel C-Win
ON CHOOSE OF btDel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_del.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDespesas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDespesas C-Win
ON CHOOSE OF btDespesas IN FRAME DEFAULT-FRAME /* Reembolso de Despesas */
DO:
    RUN som.p(INPUT "music\click.wav").

    FIND FIRST param-mn NO-LOCK.

    /* Buscar usuario relacionado ao favorecido */
    FIND FIRST usuario
        WHERE usuario.cd-favorecido = favorecido.cd-favorecido NO-LOCK NO-ERROR.
    IF AVAIL usuario THEN DO:
        /* Atualiza agendamento */
        FIND FIRST agenda EXCLUSIVE-LOCK
            WHERE agenda.usuar-resp = usuario.nome
            AND   agenda.cd-favorecido = param-mn.fav-desp-viag  NO-ERROR.
        IF AVAIL agenda THEN DO:
            ASSIGN agenda.vl-atual = 0.
            FOR EACH mov-conta NO-LOCK
                WHERE mov-conta.cd-conta = param-mn.conta-desp-viag
                AND   mov-conta.id-tipo <> 0
                AND   mov-conta.id-situacao = 1
                AND   mov-conta.usuar-resp = agenda.usuar-resp
                AND   mov-conta.dt-mov < DATE(MONTH(agenda.prox-data-pag), 1, YEAR(agenda.prox-data-pag)):
                    ASSIGN agenda.vl-atual = agenda.vl-atual + mov-conta.de-valor.
             END.
             {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Reembolso de Despesas (061)', INPUT 'Reembolso de Despesa atualizado com sucesso!', INPUT 'O reembolso de despesa foi atualizado para R$ ' + TRIM(STRING(agenda.vl-atual, ~'->>>,>>9.99~')) + ' em ' + STRING(agenda.prox-data-pag, ~'99/99/9999~') + '.')"}
        END.
        ELSE DO:
            /* Dar mensagem dizendo: Favorecido n∆o possui agendamento de reembolso de despesa */
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Reembolso de Despesas (061)', INPUT 'Reembolso de Despesa n∆o foi atualizado.', INPUT 'Favorecido n∆o possui agendamento de reembolso de despesa.')"}
        END.
    END.
    ELSE DO:
        /* Se n∆o existir dar mensagem dizendo: Favorecido n∆o possui usu†rio relacionado */
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Reembolso de Despesas (061)', INPUT 'Reembolso de Despesa n∆o foi atualizado.', INPUT 'Favorecido n∆o possui usu†rio relacionado.')"}
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


&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_last.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btMov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMov C-Win
ON CHOOSE OF btMov IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE cRow AS CHARACTER  NO-UNDO INITIAL "".
  
    RUN som.p(INPUT "music\click.wav").

    SESSION:SET-WAIT-STATE("GENERAL").
    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "consmov.txt").
    FOR EACH mov-conta 
        WHERE mov-conta.cd-favorecido = INPUT FRAME default-frame favorecido.cd-favorecido NO-LOCK:
        PUT UNFORMATTED STRING(ROWID(mov-conta)) + ",".
    END.
    OUTPUT CLOSE.
    SESSION:SET-WAIT-STATE("").

    {func\run.i &Programa = "consmov.w"}

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


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_ok.i}
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


&Scoped-define SELF-NAME btUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate C-Win
ON CHOOSE OF btUpdate IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_update.i}  
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


&Scoped-define SELF-NAME favorecido.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cd-favorecido C-Win
ON ENTRY OF favorecido.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cd-favorecido C-Win
ON LEAVE OF favorecido.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.cep
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cep C-Win
ON ENTRY OF favorecido.cep IN FRAME DEFAULT-FRAME /* CEP */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cep C-Win
ON LEAVE OF favorecido.cep IN FRAME DEFAULT-FRAME /* CEP */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.cgc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cgc C-Win
ON ENTRY OF favorecido.cgc IN FRAME DEFAULT-FRAME /* CGC\CPF */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cgc C-Win
ON LEAVE OF favorecido.cgc IN FRAME DEFAULT-FRAME /* CGC\CPF */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.cidade
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cidade C-Win
ON ENTRY OF favorecido.cidade IN FRAME DEFAULT-FRAME /* Cidade */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.cidade C-Win
ON LEAVE OF favorecido.cidade IN FRAME DEFAULT-FRAME /* Cidade */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.complemento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.complemento C-Win
ON ENTRY OF favorecido.complemento IN FRAME DEFAULT-FRAME /* Complemento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.complemento C-Win
ON LEAVE OF favorecido.complemento IN FRAME DEFAULT-FRAME /* Complemento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.ds-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.ds-favorecido C-Win
ON ENTRY OF favorecido.ds-favorecido IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.ds-favorecido C-Win
ON LEAVE OF favorecido.ds-favorecido IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.ds-observacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.ds-observacao C-Win
ON ENTRY OF favorecido.ds-observacao IN FRAME DEFAULT-FRAME /* Observacao */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.ds-observacao C-Win
ON LEAVE OF favorecido.ds-observacao IN FRAME DEFAULT-FRAME /* Observacao */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.estado C-Win
ON ENTRY OF favorecido.estado IN FRAME DEFAULT-FRAME /* Estado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.estado C-Win
ON LEAVE OF favorecido.estado IN FRAME DEFAULT-FRAME /* Estado */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME IMAGE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-1 C-Win
ON MOUSE-SELECT-DBLCLICK OF IMAGE-1 IN FRAME DEFAULT-FRAME
DO:
  
    IF cAction <> "" THEN DO:
        RUN pesqFoto.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.numero C-Win
ON ENTRY OF favorecido.numero IN FRAME DEFAULT-FRAME /* N£mero */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.numero C-Win
ON LEAVE OF favorecido.numero IN FRAME DEFAULT-FRAME /* N£mero */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.rua
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.rua C-Win
ON ENTRY OF favorecido.rua IN FRAME DEFAULT-FRAME /* Rua */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.rua C-Win
ON LEAVE OF favorecido.rua IN FRAME DEFAULT-FRAME /* Rua */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.telefone
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.telefone C-Win
ON ENTRY OF favorecido.telefone IN FRAME DEFAULT-FRAME /* Telefone */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.telefone C-Win
ON LEAVE OF favorecido.telefone IN FRAME DEFAULT-FRAME /* Telefone */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME favorecido.tem-endereco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL favorecido.tem-endereco C-Win
ON VALUE-CHANGED OF favorecido.tem-endereco IN FRAME DEFAULT-FRAME /* Endereáo */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} favorecido.tem-endereco THEN DO:
        ENABLE favorecido.rua
               favorecido.numero
               favorecido.complemento
               favorecido.bairro
               favorecido.cidade
               favorecido.estado
               favorecido.telefone
               favorecido.cgc
               favorecido.cep
               favorecido.razao-social
               favorecido.ins-estadual
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE favorecido.rua
                favorecido.numero
                favorecido.complemento
                favorecido.bairro
                favorecido.cidade
                favorecido.estado
                favorecido.telefone
                favorecido.cgc
                favorecido.cep
                favorecido.razao-social
                favorecido.ins-estadual
            WITH FRAME {&FRAME-NAME}.
    END.

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
  RUN enable_UI.
  {version.i fav}
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterAssignFields C-Win 
PROCEDURE afterAssignFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF cAction = "ADD" THEN DO:
        IF INPUT FRAME {&FRAME-NAME} favorecido.contato <> "" AND
          (INPUT FRAME {&FRAME-NAME} favorecido.tipo     = 1  OR 
           INPUT FRAME {&FRAME-NAME} favorecido.tipo     = 3) THEN DO:

            CREATE contato.
            ASSIGN contato.cd-favorecido      = INPUT FRAME {&FRAME-NAME} favorecido.cd-favorecido
                   contato.cd-contato         = 1
                   contato.nome               = INPUT FRAME {&FRAME-NAME} favorecido.contato
                   contato.telefone           = INPUT FRAME {&FRAME-NAME} favorecido.telefone
                   contato.data-nasc          = INPUT FRAME {&FRAME-NAME} favorecido.data-nasc 
                   contato.email              = INPUT FRAME {&FRAME-NAME} favorecido.e-mail.

        END.
    END.

    ASSIGN favorecido.foto = cImagem.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButtons C-Win 
PROCEDURE controlButtons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{func\control_buttons.i}

IF lHabilita THEN DO:
    APPLY "VALUE-CHANGED" TO favorecido.tem-endereco.
    DISABLE btMov WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    ENABLE btMov WITH FRAME {&FRAME-NAME}.
END.

IF param-mn.perfil = 1 /* Pessoal */ THEN
    ASSIGN favorecido.tipo:HIDDEN = TRUE.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE dispFoto C-Win 
PROCEDURE dispFoto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    IF cImagem <> "" THEN
        image-1:LOAD-IMAGE(cImagem) IN FRAME {&FRAME-NAME}.
    ELSE
        image-1:LOAD-IMAGE("image\im-naodisp.bmp") IN FRAME {&FRAME-NAME}.

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
{func\cadastro\display.i}

ASSIGN cImagem = favorecido.foto.

RUN dispFoto IN THIS-PROCEDURE.

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
  IF AVAILABLE favorecido THEN 
    DISPLAY favorecido.cd-favorecido favorecido.ativo favorecido.data-nasc 
          favorecido.ds-favorecido favorecido.e-mail favorecido.contato 
          favorecido.tipo favorecido.tem-endereco favorecido.razao-social 
          favorecido.rua favorecido.numero favorecido.complemento 
          favorecido.bairro favorecido.cidade favorecido.estado 
          favorecido.telefone favorecido.cgc favorecido.cep 
          favorecido.ins-estadual favorecido.banco favorecido.agencia 
          favorecido.conta-bancaria favorecido.tipo-pagto 
          favorecido.desconto-prim-parc favorecido.dia-pagto-padrao 
          favorecido.dias-uteis-pagto favorecido.dia-semana-pagto 
          favorecido.ds-observacao 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE favorecido.cd-favorecido favorecido.ativo btDespesas 
         favorecido.data-nasc favorecido.ds-favorecido favorecido.e-mail 
         favorecido.contato favorecido.tipo favorecido.tem-endereco 
         favorecido.razao-social favorecido.rua favorecido.numero btMov 
         favorecido.complemento favorecido.bairro favorecido.cidade 
         favorecido.estado favorecido.telefone favorecido.cgc favorecido.cep 
         favorecido.ins-estadual btGoTo favorecido.banco favorecido.agencia 
         favorecido.conta-bancaria favorecido.tipo-pagto 
         favorecido.desconto-prim-parc btFirst favorecido.dia-pagto-padrao 
         favorecido.dias-uteis-pagto favorecido.dia-semana-pagto 
         favorecido.ds-observacao btLast btNext btPrev btAdd btDel btExit 
         btUpdate btZoom RECT-4 RECT-5 RECT-7 RECT-11 IMAGE-1 
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
{func\initialize.i}

FIND FIRST param-mn NO-LOCK NO-ERROR.

IF param-mn.perfil = 1 /* Pessoal */ THEN DO:
    ASSIGN favorecido.tipo:HIDDEN = TRUE
           favorecido.cd-favorecido:LABEL = "Favorecido"
           C-Win:TITLE = REPLACE(C-Win:TITLE, ENTRY(1,C-Win:TITLE,"-"), "Cadastro de Favorecidos ").
END.
ELSE DO:
    ASSIGN favorecido.tipo:HIDDEN = FALSE
           favorecido.cd-favorecido:LABEL = "Cliente\Fornecedor"
           C-Win:TITLE = REPLACE(C-Win:TITLE, ENTRY(1,C-Win:TITLE,"-"), "Cadastro de Cliente\Fornecedor ").
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pesqFoto C-Win 
PROCEDURE pesqFoto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
    DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.
    DEFINE VARIABLE procname AS CHARACTER   NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN procname = "".

    SYSTEM-DIALOG GET-FILE procname
          TITLE      "Imagens"
          FILTERS    "Imagens"   "*.bmp;*.gif;*.jpg;*.jpeg",
                     "Todos os Arquivos"      "*.*"
          INITIAL-DIR cDiretorio
          MUST-EXIST
          USE-FILENAME
          UPDATE OKpressed. 

    IF OKpressed  THEN  DO:
        ASSIGN cDiretorio = SUBSTRING(procname,1,INDEX(procname,ENTRY(NUM-ENTRIES(procname,"\"),procname,"\")))
               cImagem = procname.
    END.

    RUN dispFoto IN THIS-PROCEDURE.

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

IF cAction = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-favorecido NO-LOCK
        WHERE bf-favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} favorecido.cd-favorecido
        AND   ROWID(bf-favorecido) <> ROWID(favorecido) NO-ERROR.
    IF AVAIL bf-favorecido THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF cAction = "DEL" THEN DO:
    /* Pesquisa Relacionamentos */
    IF CAN-FIND(FIRST alerta-exc OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Alertas Espec°ficos!"
                       &Ajuda     = "Existem usu†rios com alertas espec°ficos referenciando esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST apontamento OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Apontamentos!"
                       &Ajuda     = "Existem apontamentos referenciando esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST usuario OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido associado a Usu†rio!"
                       &Ajuda     = "Existem usu†rios associados com esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST pedido OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Pedidos!"
                       &Ajuda     = "Existem pedidos desse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST tabela-preco OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Tabelas de Preáo!"
                       &Ajuda     = "Existem tabelas de preáo referenciando esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST nota-fiscal OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido j† possui faturamento!"
                       &Ajuda     = "Existem notas fiscais desse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST mov-conta OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Movimentaá∆o!"
                       &Ajuda     = "Essa favorecido possui movimentaá∆o e n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST imposto OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido de Imposto!"
                       &Ajuda     = "Existem impostos associados a esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST compra OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido possui compra!"
                       &Ajuda     = "Existem compras realizadas nesse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST agenda OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Agendamentos!"
                       &Ajuda     = "Essa favorecido possui movimentos agendados e n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST atendimento OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido j† possui atendimentos!"
                       &Ajuda     = "Existem atendimentos realizados para esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST contato OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido possui Contatos!"
                       &Ajuda     = "Existem contatos atribu°dos a esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST contato-caracteristica OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido com Contatos!"
                       &Ajuda     = "Existem caracter°sticas de contatos desse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST tarefa OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido j† possui Tarefas!"
                       &Ajuda     = "Existem tarefas atribu°das a esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST ordem-serv OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido possui OS!"
                       &Ajuda     = "Existem ordens de serviáo associadas a esse favorecido e ele n∆o pode ser eliminado."}
    END.
    IF CAN-FIND(FIRST visita OF favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido j† visitado!"
                       &Ajuda     = "Existem visitas referenciando esse favorecido e ele n∆o pode ser eliminado."}
    END.

END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

