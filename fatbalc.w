&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          money            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt-forma-pagto NO-UNDO LIKE forma-pagto
       field valor as decimal
       field recebido as decimal.
DEFINE TEMP-TABLE tt-item NO-UNDO LIKE nota-fiscal-item.



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

{func\definitions.i}
{func\data.i}
{campos\cd-item.i}
{campos\cd-forma-pagto.i}

DEFINE VARIABLE iSeq AS INTEGER     NO-UNDO INITIAL 1.

DEFINE NEW GLOBAL SHARED VARIABLE r-mov-conta AS ROWID      NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brItens

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-item tt-forma-pagto

/* Definitions for BROWSE brItens                                       */
&Scoped-define FIELDS-IN-QUERY-brItens tt-item.sequencia tt-item.cd-item ~
fnCd-item(tt-item.cd-item) @ cCd-item tt-item.val-unitario ~
tt-item.quantidade tt-item.val-total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brItens 
&Scoped-define QUERY-STRING-brItens FOR EACH tt-item NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brItens OPEN QUERY brItens FOR EACH tt-item NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brItens tt-item
&Scoped-define FIRST-TABLE-IN-QUERY-brItens tt-item


/* Definitions for BROWSE brPag                                         */
&Scoped-define FIELDS-IN-QUERY-brPag fnCd-forma-pagto(tt-forma-pagto.cd-forma-pagto) @ cCd-forma-pagto tt-forma-pagto.valor tt-forma-pagto.recebido   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPag tt-forma-pagto.recebido   
&Scoped-define ENABLED-TABLES-IN-QUERY-brPag tt-forma-pagto
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-brPag tt-forma-pagto
&Scoped-define SELF-NAME brPag
&Scoped-define QUERY-STRING-brPag FOR EACH tt-forma-pagto NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brPag OPEN QUERY {&SELF-NAME} FOR EACH tt-forma-pagto NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brPag tt-forma-pagto
&Scoped-define FIRST-TABLE-IN-QUERY-brPag tt-forma-pagto


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brItens}~
    ~{&OPEN-QUERY-brPag}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btAdd btNovo iCd-favorecido des-cli ~
iCd-tabela-preco iCd-item deQt-pedida deVal-desconto brItens btRem ~
deVal-desc-venda desc-tab iCd-forma-pagto deVal-forma btInc brPag btRem-pag ~
btConf desc-item RECT-7 btExit RECT-9 RECT-10 RECT-11 RECT-12 
&Scoped-Define DISPLAYED-OBJECTS data iCd-favorecido des-cli ~
iCd-tabela-preco iCd-item deQt-pedida deVal-tabela deVal-desconto ~
deVal-unitario deVal-total deVal-liq-venda deVal-desc-venda deVal-tot-venda ~
desc-tab iCd-forma-pagto deVal-forma deVal-tot-pag deVal-rec-pag ~
deVal-pag-troco desc-item 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAdd 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Inc" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btConf 
     LABEL "Confirmar Faturamento" 
     SIZE 46 BY 1.

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btInc 
     LABEL "Incluir" 
     SIZE 10 BY 1.

DEFINE BUTTON btNovo 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Novo" 
     SIZE 6.14 BY 1.79 TOOLTIP "Novo Recibo".

DEFINE BUTTON btRem 
     LABEL "Remover" 
     SIZE 10 BY 1.

DEFINE BUTTON btRem-pag 
     LABEL "Remover" 
     SIZE 10 BY 1.

DEFINE VARIABLE iCd-forma-pagto AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Forma de Pagamento" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",0001
     DROP-DOWN-LIST
     SIZE 27 BY 1 NO-UNDO.

DEFINE VARIABLE data AS DATE FORMAT "99/99/9999":U 
     LABEL "Data" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79 NO-UNDO.

DEFINE VARIABLE deQt-pedida AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Qtde Pedida" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .79.

DEFINE VARIABLE des-cli AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY .79 NO-UNDO.

DEFINE VARIABLE desc-item AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY .79 NO-UNDO.

DEFINE VARIABLE desc-tab AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY .79 NO-UNDO.

DEFINE VARIABLE deVal-desc-venda AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Desconto" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE deVal-desconto AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Desconto" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE deVal-forma AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE deVal-liq-venda AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor Venda" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE deVal-pag-troco AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Troco" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 24 FGCOLOR 15 .

DEFINE VARIABLE deVal-rec-pag AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor Recebido" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE deVal-tabela AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor Tabela" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE deVal-tot-pag AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Total" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 21 FGCOLOR 15 .

DEFINE VARIABLE deVal-tot-venda AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor Total" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 21 FGCOLOR 15 .

DEFINE VARIABLE deVal-total AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor Total" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79
     BGCOLOR 21 FGCOLOR 15 .

DEFINE VARIABLE deVal-unitario AS DECIMAL FORMAT "->>,>>9.99" INITIAL 0 
     LABEL "Valor Unit†rio" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .79.

DEFINE VARIABLE iCd-favorecido AS INTEGER FORMAT "9999" INITIAL 0 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79.

DEFINE VARIABLE iCd-item AS INTEGER FORMAT "99999" INITIAL 0 
     LABEL "Item" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .79.

DEFINE VARIABLE iCd-tabela-preco AS INTEGER FORMAT "999" INITIAL 0 
     LABEL "Tabela de Preáo" 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 125 BY 2.25.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 46 BY 3.75.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 46 BY 3.5.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 3.75.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 3.5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brItens FOR 
      tt-item SCROLLING.

DEFINE QUERY brPag FOR 
      tt-forma-pagto SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brItens
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brItens C-Win _STRUCTURED
  QUERY brItens NO-LOCK DISPLAY
      tt-item.sequencia FORMAT ">>>9":U
      tt-item.cd-item FORMAT "99999":U
      fnCd-item(tt-item.cd-item) @ cCd-item
      tt-item.val-unitario FORMAT "->>,>>9.99":U
      tt-item.quantidade FORMAT "->>,>>9.99":U
      tt-item.val-total FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 78 BY 9
         FONT 1
         TITLE "Itens" FIT-LAST-COLUMN.

DEFINE BROWSE brPag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPag C-Win _FREEFORM
  QUERY brPag NO-LOCK DISPLAY
      fnCd-forma-pagto(tt-forma-pagto.cd-forma-pagto) @ cCd-forma-pagto WIDTH 25
tt-forma-pagto.valor COLUMN-LABEL "Valor"
tt-forma-pagto.recebido COLUMN-LABEL "Recebido"
ENABLE
tt-forma-pagto.recebido
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 46 BY 5.75
         FONT 1
         TITLE "Formas de Pagamento".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btAdd AT ROW 8.5 COL 72 WIDGET-ID 60
     btNovo AT ROW 1.5 COL 3 WIDGET-ID 92
     data AT ROW 4.25 COL 20 COLON-ALIGNED WIDGET-ID 22
     iCd-favorecido AT ROW 5.25 COL 20 COLON-ALIGNED WIDGET-ID 16
     des-cli AT ROW 5.25 COL 25 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     iCd-tabela-preco AT ROW 6.25 COL 20 COLON-ALIGNED WIDGET-ID 46
     iCd-item AT ROW 8 COL 15 COLON-ALIGNED WIDGET-ID 2
     deQt-pedida AT ROW 9 COL 15 COLON-ALIGNED WIDGET-ID 56
     deVal-tabela AT ROW 9 COL 36 COLON-ALIGNED WIDGET-ID 52
     deVal-desconto AT ROW 10 COL 36 COLON-ALIGNED WIDGET-ID 50
     deVal-unitario AT ROW 9 COL 58 COLON-ALIGNED WIDGET-ID 54
     deVal-total AT ROW 10 COL 58 COLON-ALIGNED WIDGET-ID 40
     brItens AT ROW 11.5 COL 2 WIDGET-ID 200
     btRem AT ROW 20.5 COL 2 WIDGET-ID 64
     deVal-liq-venda AT ROW 4.25 COL 102 COLON-ALIGNED WIDGET-ID 72
     deVal-desc-venda AT ROW 5.25 COL 102 COLON-ALIGNED WIDGET-ID 68
     deVal-tot-venda AT ROW 6.25 COL 102 COLON-ALIGNED WIDGET-ID 70
     desc-tab AT ROW 6.25 COL 24 COLON-ALIGNED NO-LABEL WIDGET-ID 48 NO-TAB-STOP 
     iCd-forma-pagto AT ROW 8 COL 97 COLON-ALIGNED WIDGET-ID 74
     deVal-forma AT ROW 9 COL 114 COLON-ALIGNED WIDGET-ID 78
     btInc AT ROW 10 COL 116 WIDGET-ID 80
     brPag AT ROW 11.5 COL 81 WIDGET-ID 300
     btRem-pag AT ROW 17.25 COL 81 WIDGET-ID 82
     deVal-tot-pag AT ROW 17.5 COL 115 COLON-ALIGNED WIDGET-ID 84
     deVal-rec-pag AT ROW 18.5 COL 115 COLON-ALIGNED WIDGET-ID 86
     deVal-pag-troco AT ROW 19.5 COL 115 COLON-ALIGNED WIDGET-ID 88
     btConf AT ROW 20.5 COL 81 WIDGET-ID 90
     desc-item AT ROW 8 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 10 NO-TAB-STOP 
     btExit AT ROW 1.5 COL 120 WIDGET-ID 44
     RECT-7 AT ROW 3.75 COL 2 WIDGET-ID 20
     RECT-9 AT ROW 7.75 COL 2 WIDGET-ID 58
     RECT-10 AT ROW 1.25 COL 2 WIDGET-ID 62
     RECT-11 AT ROW 3.75 COL 81 WIDGET-ID 66
     RECT-12 AT ROW 7.75 COL 81 WIDGET-ID 76
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.14 BY 20.79
         FONT 1 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: tt-forma-pagto T "?" NO-UNDO money forma-pagto
      ADDITIONAL-FIELDS:
          field valor as decimal
          field recebido as decimal
      END-FIELDS.
      TABLE: tt-item T "?" NO-UNDO money nota-fiscal-item
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 20.79
         WIDTH              = 127.14
         MAX-HEIGHT         = 25.63
         MAX-WIDTH          = 127.14
         VIRTUAL-HEIGHT     = 25.63
         VIRTUAL-WIDTH      = 127.14
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB brItens deVal-total DEFAULT-FRAME */
/* BROWSE-TAB brPag btInc DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN data IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       des-cli:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       desc-item:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       desc-tab:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN deVal-liq-venda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-pag-troco IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-rec-pag IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-tabela IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-tot-pag IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-tot-venda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-total IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN deVal-unitario IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brItens
/* Query rebuild information for BROWSE brItens
     _TblList          = "Temp-Tables.tt-item"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = Temp-Tables.tt-item.sequencia
     _FldNameList[2]   = Temp-Tables.tt-item.cd-item
     _FldNameList[3]   > "_<CALC>"
"fnCd-item(tt-item.cd-item) @ cCd-item" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = Temp-Tables.tt-item.val-unitario
     _FldNameList[5]   = Temp-Tables.tt-item.quantidade
     _FldNameList[6]   = Temp-Tables.tt-item.val-total
     _Query            is OPENED
*/  /* BROWSE brItens */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPag
/* Query rebuild information for BROWSE brPag
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-forma-pagto NO-LOCK INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brPag */
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


&Scoped-define BROWSE-NAME brPag
&Scoped-define SELF-NAME brPag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPag C-Win
ON ROW-ENTRY OF brPag IN FRAME DEFAULT-FRAME /* Formas de Pagamento */
DO:
  
    /*IF AVAIL tt-forma-pagto THEN DO:
        FIND FIRST forma-pagto OF tt-forma-pagto NO-LOCK NO-ERROR.
        FIND FIRST conta OF forma-pagto NO-LOCK NO-ERROR.
        IF NOT conta.dinheiro THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Balc∆o (054)', INPUT 'Alteraá∆o n∆o permitida!', INPUT 'S¢ Ç permitido alterar o valor recebido de Formas de Pagamento em Dinheiro.')"}
            RETURN NO-APPLY.
        END.
    END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brPag C-Win
ON ROW-LEAVE OF brPag IN FRAME DEFAULT-FRAME /* Formas de Pagamento */
DO:
  
    IF INPUT BROWSE brPag tt-forma-pagto.recebido < INPUT BROWSE brPag tt-forma-pagto.valor THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Balc∆o (054)', INPUT 'Valor Recebido inv†lido!', INPUT 'Valor Recebido deve ser maior ou igual ao Valor Total da Forma de Pagamento.')"}
        RETURN.
    END.

    ASSIGN INPUT BROWSE brPag tt-forma-pagto.recebido.
    RUN pagto.
    RETURN NO-APPLY.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* Inc */
DO:

    RUN som.p(INPUT "music\click.wav").
    CREATE tt-item.
    ASSIGN tt-item.sequencia = iSeq
           tt-item.cd-item = INPUT FRAME {&FRAME-NAME} iCd-item
           tt-item.val-unitario = INPUT FRAME {&FRAME-NAME} deVal-unitario
           tt-item.quantidade = INPUT FRAME {&FRAME-NAME} deQt-pedida
           tt-item.val-total = INPUT FRAME {&FRAME-NAME} deVal-total
           iSeq = iSeq + 1.

    ASSIGN iCd-item = 0
           deVal-desconto = 0
           deQt-pedida = 0
           deVal-tabela = 0
           deVal-unitario = 0.

    DISPLAY iCd-item
           deVal-desconto
           deQt-pedida
           deVal-tabela
           deVal-unitario
        WITH FRAME {&FRAME-NAME}.

    APPLY "LEAVE" TO iCd-item.

    RUN recalc.

    RUN pagto.

    APPLY "ENTRY" TO iCd-item.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btConf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btConf C-Win
ON CHOOSE OF btConf IN FRAME DEFAULT-FRAME /* Confirmar Faturamento */
DO:

    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iMov AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cAux AS CHARACTER   NO-UNDO.

    IF INPUT FRAME {&FRAME-NAME} deVal-pag-troco < 0 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Balc∆o (054)', INPUT 'Valor Recebido menor que Valor Total.', INPUT 'Confira o valor recebido e informe corretamente. O valor recebido deve ser maior ou igual ao valor total da venda.')"}
        RETURN.
    END.

    FIND FIRST param-mn NO-LOCK NO-ERROR.
    IF param-mn.conta-recibo = 0 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Pedidos (051)', INPUT 'Parametrizaá∆o incorreta.', INPUT 'Vocà deve informar os parÉmetros para geraá∆o de Recibo.')"}
        RETURN "NOK".
    END.

    FIND LAST nota-fiscal NO-LOCK NO-ERROR.
    IF AVAIL nota-fiscal THEN
        ASSIGN iAux = nota-fiscal.nr-controle + 1.
    ELSE
        ASSIGN iAux = 1.

    CREATE nota-fiscal.
    ASSIGN nota-fiscal.nr-controle = iAux
           nota-fiscal.tipo = 2
           nota-fiscal.cd-favorecido = INPUT FRAME {&FRAME-NAME} iCd-favorecido
           nota-fiscal.dt-emissao = TODAY
           nota-fiscal.val-itens = INPUT FRAME {&FRAME-NAME} deVal-liq-venda
           nota-fiscal.val-desconto = INPUT FRAME {&FRAME-NAME} deVal-desc-venda
           nota-fiscal.val-total = INPUT FRAME {&FRAME-NAME} deVal-tot-venda
           nota-fiscal.cod-categoria = param-mn.categoria-recibo
           nota-fiscal.cd-sub = param-mn.sub-recibo.

    ASSIGN iAux = 1.
    FOR EACH tt-item:
        CREATE nota-fiscal-item.
        ASSIGN nota-fiscal-item.nr-controle = nota-fiscal.nr-controle
               nota-fiscal-item.sequencia = iAux
               nota-fiscal-item.cd-item = tt-item.cd-item
               nota-fiscal-item.val-unitario = tt-item.val-unitario
               nota-fiscal-item.quantidade = tt-item.quantidade
               nota-fiscal-item.val-total = tt-item.val-total
               iAux = iAux + 1.
    END.

    ASSIGN iAux = 1.
    FOR EACH tt-forma-pagto:

        FIND FIRST forma-pagto OF tt-forma-pagto NO-LOCK NO-ERROR.

        FIND FIRST conta OF forma-pagto NO-LOCK NO-ERROR.
        IF AVAIL conta THEN DO:
            FIND LAST mov-conta OF conta NO-LOCK NO-ERROR.
            IF AVAIL mov-conta THEN
                ASSIGN iMov = mov-conta.cd-sequencia + 1.
            ELSE
                ASSIGN iMov = 1.
        END.

        CREATE parc-nota-fiscal.
        ASSIGN parc-nota-fiscal.nr-controle = nota-fiscal.nr-controle
               parc-nota-fiscal.sequencia = iAux
               parc-nota-fiscal.situacao = 2 /* Liquidada */
               parc-nota-fiscal.dt-parcela = TODAY
               parc-nota-fiscal.val-parcela = tt-forma-pagto.valor
               parc-nota-fiscal.cd-conta = conta.cd-conta
               parc-nota-fiscal.cd-sequencia = iMov
               iAux = iAux + 1.

        CREATE mov-conta.
        ASSIGN mov-conta.cd-conta = parc-nota-fiscal.cd-conta
               mov-conta.cd-sequencia = parc-nota-fiscal.cd-sequencia
               mov-conta.id-tipo = (IF conta.id-tipo <> 3 THEN 1 ELSE 2)
               mov-conta.id-situacao = 1 /* N∆o Compensado */
               mov-conta.dt-mov = TODAY
               mov-conta.de-valor = parc-nota-fiscal.val-parcela
               mov-conta.cd-favorecido = nota-fiscal.cd-favorecido
               mov-conta.cod-categoria = param-mn.categoria-recibo
               mov-conta.cd-sub = param-mn.sub-recibo.
        ASSIGN pcActionBT = "UPDATE"
               r-parent = ROWID(conta)
               r-mov-conta = ROWID(mov-conta).
        {func\run.i &Programa = "mov-conta_det.w"}

    END.

    ASSIGN cAux = "Foi gerado o Recibo com o n£mero de controle " + STRING(nota-fiscal.nr-controle) + ".".
    {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Faturamento de Balc∆o (054)', INPUT 'Recibo gerado com sucesso.', INPUT cAux)"}

    APPLY "CHOOSE" TO btNovo.

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


&Scoped-define SELF-NAME btInc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btInc C-Win
ON CHOOSE OF btInc IN FRAME DEFAULT-FRAME /* Incluir */
DO:
  
    FIND FIRST tt-forma-pagto
        WHERE tt-forma-pagto.cd-forma-pagto = INPUT FRAME {&FRAME-NAME} iCd-forma-pagto NO-ERROR.
    IF NOT AVAIL tt-forma-pagto THEN DO:
        CREATE tt-forma-pagto.
        ASSIGN tt-forma-pagto.cd-forma-pagto = INPUT FRAME {&FRAME-NAME} iCd-forma-pagto.
    END.
    
    ASSIGN tt-forma-pagto.valor = tt-forma-pagto.valor + INPUT FRAME {&FRAME-NAME} deVal-forma
           tt-forma-pagto.recebido = tt-forma-pagto.valor.

    RUN pagto.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNovo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNovo C-Win
ON CHOOSE OF btNovo IN FRAME DEFAULT-FRAME /* Novo */
DO:

    RUN som.p(INPUT "music\click.wav").

    EMPTY TEMP-TABLE tt-item.
    EMPTY TEMP-TABLE tt-forma-pagto.

    ASSIGN iSeq = 1
           iCd-item = 0
           deQt-pedida = 0
           deVal-desconto = 0
           deVal-desc-venda = 0.

    DISPLAY iCd-item
            deQt-pedida
            deVal-desconto
            deVal-desc-venda
        WITH FRAME {&FRAME-NAME}.
           
    APPLY "LEAVE" TO iCd-item.

    RUN recalc.
    RUN pagto.

    APPLY "ENTRY" TO iCd-item.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRem C-Win
ON CHOOSE OF btRem IN FRAME DEFAULT-FRAME /* Remover */
DO:
  
    IF AVAIL tt-item THEN DO:
        DELETE tt-item.
        RUN pagto.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRem-pag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRem-pag C-Win
ON CHOOSE OF btRem-pag IN FRAME DEFAULT-FRAME /* Remover */
DO:
  
    IF AVAIL tt-forma-pagto THEN DO:
        DELETE tt-forma-pagto.
        RUN pagto.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data C-Win
ON ENTRY OF data IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL data C-Win
ON LEAVE OF data IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deQt-pedida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deQt-pedida C-Win
ON ENTRY OF deQt-pedida IN FRAME DEFAULT-FRAME /* Qtde Pedida */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deQt-pedida C-Win
ON LEAVE OF deQt-pedida IN FRAME DEFAULT-FRAME /* Qtde Pedida */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-desc-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-desc-venda C-Win
ON ENTRY OF deVal-desc-venda IN FRAME DEFAULT-FRAME /* Desconto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-desc-venda C-Win
ON LEAVE OF deVal-desc-venda IN FRAME DEFAULT-FRAME /* Desconto */
DO:
    {func\set_leave.i}  
    RUN pagto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-desconto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-desconto C-Win
ON ENTRY OF deVal-desconto IN FRAME DEFAULT-FRAME /* Desconto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-desconto C-Win
ON LEAVE OF deVal-desconto IN FRAME DEFAULT-FRAME /* Desconto */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-forma
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-forma C-Win
ON ENTRY OF deVal-forma IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-forma C-Win
ON LEAVE OF deVal-forma IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-liq-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-liq-venda C-Win
ON ENTRY OF deVal-liq-venda IN FRAME DEFAULT-FRAME /* Valor Venda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-liq-venda C-Win
ON LEAVE OF deVal-liq-venda IN FRAME DEFAULT-FRAME /* Valor Venda */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-pag-troco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-pag-troco C-Win
ON ENTRY OF deVal-pag-troco IN FRAME DEFAULT-FRAME /* Troco */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-pag-troco C-Win
ON LEAVE OF deVal-pag-troco IN FRAME DEFAULT-FRAME /* Troco */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-rec-pag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-rec-pag C-Win
ON ENTRY OF deVal-rec-pag IN FRAME DEFAULT-FRAME /* Valor Recebido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-rec-pag C-Win
ON LEAVE OF deVal-rec-pag IN FRAME DEFAULT-FRAME /* Valor Recebido */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-tabela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-tabela C-Win
ON ENTRY OF deVal-tabela IN FRAME DEFAULT-FRAME /* Valor Tabela */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-tabela C-Win
ON LEAVE OF deVal-tabela IN FRAME DEFAULT-FRAME /* Valor Tabela */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-tot-pag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-tot-pag C-Win
ON ENTRY OF deVal-tot-pag IN FRAME DEFAULT-FRAME /* Total */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-tot-pag C-Win
ON LEAVE OF deVal-tot-pag IN FRAME DEFAULT-FRAME /* Total */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-tot-venda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-tot-venda C-Win
ON ENTRY OF deVal-tot-venda IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-tot-venda C-Win
ON LEAVE OF deVal-tot-venda IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-total
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-total C-Win
ON ENTRY OF deVal-total IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-total C-Win
ON LEAVE OF deVal-total IN FRAME DEFAULT-FRAME /* Valor Total */
DO:
    {func\set_leave.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME deVal-unitario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-unitario C-Win
ON ENTRY OF deVal-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL deVal-unitario C-Win
ON LEAVE OF deVal-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
    {func\set_leave.i}  
    RUN recalc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iCd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-favorecido C-Win
ON ENTRY OF iCd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-favorecido C-Win
ON LEAVE OF iCd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoTela="iCd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="des-cli"}
                  
    IF AVAIL bfl-favorecido THEN DO:
        FIND FIRST tabela-preco NO-LOCK
            WHERE tabela-preco.cd-favorecido = INPUT FRAME {&FRAME-NAME} iCd-favorecido
            AND   tabela-preco.dt-val-ini <= TODAY
            AND   tabela-preco.dt-val-fim >= TODAY NO-ERROR.
        IF NOT AVAIL tabela-preco THEN DO:
            FIND FIRST tabela-preco NO-LOCK
                WHERE tabela-preco.cd-favorecido = ?
                AND   tabela-preco.dt-val-ini <= TODAY
                AND   tabela-preco.dt-val-fim >= TODAY NO-ERROR.
            IF NOT AVAIL tabela-preco THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Tabela de Preáo (049)', INPUT 'N∆o existe tabela de preáo v†lida.', INPUT 'N∆o existe nenhuma tabela de preáo dentro da validade cadastrada no sistema.')"}
            END.
        END.

        IF AVAIL tabela-preco THEN DO:
            ASSIGN iCd-tabela-preco:SCREEN-VALUE = STRING(tabela-preco.cd-tabela-preco).
        END.

    END.
    ELSE
        ASSIGN iCd-tabela-preco:SCREEN-VALUE = STRING(0).

    APPLY "LEAVE" TO iCd-tabela-preco.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF iCd-favorecido IN FRAME DEFAULT-FRAME /* Cliente */
OR F5 OF iCd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="iCd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="des-cli"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iCd-item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-item C-Win
ON ENTRY OF iCd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-item C-Win
ON LEAVE OF iCd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\leave.i &Tabela="item"
                  &Campo="cd-item"
                  &CampoTela="iCd-item"
                  &CampoProc="ds-item"
                  &Tela="desc-item"}  
                  
    IF AVAIL bfl-item THEN DO:

        FIND FIRST tabela-preco NO-LOCK
            WHERE tabela-preco.cd-tabela-preco = INPUT FRAME {&FRAME-NAME} iCd-tabela-preco NO-ERROR.
        IF AVAIL tabela-preco THEN DO:
            FIND FIRST tabela-preco-item OF tabela-preco NO-LOCK
                WHERE tabela-preco-item.cd-item = bfl-item.cd-item NO-ERROR.
            IF NOT AVAIL tabela-preco-item THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Tabela de Preáo (050)', INPUT 'Item inv†lido.', INPUT 'N∆o existe preáo para o item na tabela de preáo do cliente.')"}
                ASSIGN deVal-tabela:SCREEN-VALUE = STRING(0).
                RUN recalc.
            END.
            ELSE DO:
                ASSIGN deVal-tabela:SCREEN-VALUE = STRING(tabela-preco-item.val-unitario).
                RUN recalc.
            END.

        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-item C-Win
ON MOUSE-SELECT-DBLCLICK OF iCd-item IN FRAME DEFAULT-FRAME /* Item */
OR F5 OF iCd-item DO:
    {func\zoom.i &Tabela="item"
                 &Campo1="cd-item"
                 &Tela1="iCd-item"
                 &Campo2="ds-item"
                 &Tela2="desc-item"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME iCd-tabela-preco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-tabela-preco C-Win
ON ENTRY OF iCd-tabela-preco IN FRAME DEFAULT-FRAME /* Tabela de Preáo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-tabela-preco C-Win
ON LEAVE OF iCd-tabela-preco IN FRAME DEFAULT-FRAME /* Tabela de Preáo */
DO:
    {func\leave.i &Tabela="tabela-preco"
                  &Campo="cd-tabela-preco"
                  &CampoTela="iCd-tabela-preco"
                  &CampoProc = "ds-tabela-preco"
                  &Tela="desc-tab"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL iCd-tabela-preco C-Win
ON MOUSE-SELECT-DBLCLICK OF iCd-tabela-preco IN FRAME DEFAULT-FRAME /* Tabela de Preáo */
OR F5 OF iCd-tabela-preco DO:
    {func\zoom.i &Tabela="tabela-preco"
                 &Campo1="cd-tabela-preco"
                 &Tela1="iCd-tabela-preco"
                 &Campo2="ds-tabela-preco"
                 &Tela2="desc-tab"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brItens
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = des-cli
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = iCd-favorecido}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-tab
                          &FOREACH = "tabela-preco BY tabela-preco.ds-tabela-preco"
                          &CAMPO = tabela-preco.ds-tabela-preco
                          &ObjPai = iCd-tabela-preco}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-item
                          &FOREACH = "item BY item.ds-item"
                          &CAMPO = item.ds-item
                          &ObjPai = iCd-item}
                          
{func\calendar.i data}

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
  {version.i fatbalc}
  RUN initialize.
  RUN enable_UI.
  RUN displayFields.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    APPLY "LEAVE" TO iCd-favorecido IN FRAME {&FRAME-NAME}.

    RETURN "OK".

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
  DISPLAY data iCd-favorecido des-cli iCd-tabela-preco iCd-item deQt-pedida 
          deVal-tabela deVal-desconto deVal-unitario deVal-total deVal-liq-venda 
          deVal-desc-venda deVal-tot-venda desc-tab iCd-forma-pagto deVal-forma 
          deVal-tot-pag deVal-rec-pag deVal-pag-troco desc-item 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btAdd btNovo iCd-favorecido des-cli iCd-tabela-preco iCd-item 
         deQt-pedida deVal-desconto brItens btRem deVal-desc-venda desc-tab 
         iCd-forma-pagto deVal-forma btInc brPag btRem-pag btConf desc-item 
         RECT-7 btExit RECT-9 RECT-10 RECT-11 RECT-12 
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

    DEFINE VARIABLE cLista AS CHARACTER   NO-UNDO.

    ASSIGN data = TODAY.

    FOR EACH forma-pagto NO-LOCK:
        IF cLista = "" THEN
            ASSIGN cLista = forma-pagto.ds-forma-pagto + "," + STRING(forma-pagto.cd-forma-pagto).
        ELSE
            ASSIGN cLista = cLista + "," + forma-pagto.ds-forma-pagto + "," + STRING(forma-pagto.cd-forma-pagto).
        IF iCd-forma-pagto = 0 THEN
            ASSIGN iCd-forma-pagto = forma-pagto.cd-forma-pagto.
    END.

    ASSIGN iCd-forma-pagto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = cLista.

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE leaveObject C-Win 
PROCEDURE leaveObject :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER cObject AS CHARACTER  NO-UNDO.

IF cObject = "des-cli" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} des-cli NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN iCd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.
IF cObject = "desc-tab" THEN DO:
    FIND FIRST tabela-preco NO-LOCK
        WHERE tabela-preco.ds-tabela-preco = INPUT FRAME {&FRAME-NAME} desc-tab NO-ERROR.
    IF AVAIL tabela-preco THEN DO:
        ASSIGN iCd-tabela-preco:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(tabela-preco.cd-tabela-preco).
    END.
END.
IF cObject = "desc-item" THEN DO:
    FIND FIRST item NO-LOCK
        WHERE item.ds-item = INPUT FRAME {&FRAME-NAME} desc-item NO-ERROR.
    IF AVAIL item THEN DO:
        ASSIGN iCd-item:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(item.cd-item).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pagto C-Win 
PROCEDURE pagto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN deVal-liq-venda = 0.
    FOR EACH tt-item:
        ASSIGN deVal-liq-venda = deVal-liq-venda + tt-item.val-total.
    END.

    ASSIGN deVal-tot-venda = deVal-liq-venda -
                             INPUT FRAME {&FRAME-NAME} deVal-desc-venda.

    ASSIGN deVal-forma = deVal-tot-venda
           deVal-tot-pag = 0
           deVal-rec-pag = 0.
    FOR EACH tt-forma-pagto:
        ASSIGN deVal-forma = deVal-forma - tt-forma-pagto.valor
               deVal-tot-pag = deVal-tot-pag + tt-forma-pagto.valor
               deVal-rec-pag = deVal-rec-pag + tt-forma-pagto.recebido.
    END.

    ASSIGN deVal-pag-troco = deVal-rec-pag - deVal-tot-pag.

    {&OPEN-QUERY-brItens}
    {&OPEN-QUERY-brPag}

    DISPLAY deVal-liq-venda
            deVal-tot-venda
            deVal-forma
            deVal-tot-pag
            deVal-rec-pag
            deVal-pag-troco
        WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalc C-Win 
PROCEDURE recalc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN deVal-unitario = INPUT FRAME {&FRAME-NAME} deVal-tabela -
                            INPUT FRAME {&FRAME-NAME} deVal-desconto.

    ASSIGN deVal-total = deVal-unitario *
                         INPUT FRAME {&FRAME-NAME} deQt-pedida.

    DISPLAY deVal-unitario
            deVal-total
        WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

