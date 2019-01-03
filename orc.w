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

/* Local Variable Definitions ---                                       */

&GLOBAL-DEFINE FrameFields orcamento.cd-orcamento orcamento.ds-orcamento ~
                           orcamento.ano

DEFINE VARIABLE cAction AS CHARACTER  NO-UNDO.

DEFINE BUFFER bforcamento FOR orcamento.

DEFINE NEW GLOBAL SHARED VARIABLE iorcamento AS INTEGER    NO-UNDO.

DEFINE TEMP-TABLE tt-mensal
    FIELD cod AS INTEGER
    FIELD descricao AS CHARACTER COLUMN-LABEL "" FORMAT "X(39)"
    FIELD vl-mes AS DECIMAL COLUMN-LABEL "Vl. Mensal"
    FIELD vl-esp AS DECIMAL COLUMN-LABEL "Vl. Anual"
    INDEX mensal IS PRIMARY cod ASCENDING.

DEFINE TEMP-TABLE tt-anual
    FIELD cod AS INTEGER
    FIELD mes AS CHARACTER COLUMN-LABEL "" FORMAT "X(20)"
    FIELD vl-rec AS DECIMAL COLUMN-LABEL "Receita"
    FIELD vl-poup AS DECIMAL COLUMN-LABEL "Poupanáa"
    FIELD vl-desp AS DECIMAL COLUMN-LABEL "Despesa"
    FIELD vl-dif AS DECIMAL COLUMN-LABEL "Sobra"
    FIELD vl-acum AS DECIMAL COLUMN-LABEL "Acumulado"
    INDEX anual IS PRIMARY cod ASCENDING.

DEFINE BUFFER bfItem FOR item-orcamento.

{seg.i}

{campos\cd-conta.i}
{campos\cd-poupanca.i}
{func\tt_info.i}

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAnual

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt-anual tt-mensal poupanca item-poupanca

/* Definitions for BROWSE brAnual                                       */
&Scoped-define FIELDS-IN-QUERY-brAnual tt-anual.mes tt-anual.vl-rec tt-anual.vl-poup tt-anual.vl-desp tt-anual.vl-dif tt-anual.vl-acum   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAnual   
&Scoped-define SELF-NAME brAnual
&Scoped-define QUERY-STRING-brAnual FOR EACH tt-anual NO-LOCK
&Scoped-define OPEN-QUERY-brAnual OPEN QUERY {&SELF-NAME} FOR EACH tt-anual NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brAnual tt-anual
&Scoped-define FIRST-TABLE-IN-QUERY-brAnual tt-anual


/* Definitions for BROWSE brMensal                                      */
&Scoped-define FIELDS-IN-QUERY-brMensal tt-mensal.descricao tt-mensal.vl-mes tt-mensal.vl-esp   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brMensal   
&Scoped-define SELF-NAME brMensal
&Scoped-define QUERY-STRING-brMensal FOR EACH tt-mensal NO-LOCK
&Scoped-define OPEN-QUERY-brMensal OPEN QUERY {&SELF-NAME} FOR EACH tt-mensal NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brMensal tt-mensal
&Scoped-define FIRST-TABLE-IN-QUERY-brMensal tt-mensal


/* Definitions for BROWSE brPoup                                        */
&Scoped-define FIELDS-IN-QUERY-brPoup fnCd-poupanca(item-poupanca.cd-poupanca) @ cCd-poupanca fnCd-conta(poupanca.cd-conta) @ cCd-conta item-poupanca.vl-deposito item-poupanca.vl-espontaneo[1] item-poupanca.vl-espontaneo[2] item-poupanca.vl-espontaneo[3] item-poupanca.vl-espontaneo[4] item-poupanca.vl-espontaneo[5] item-poupanca.vl-espontaneo[6] item-poupanca.vl-espontaneo[7] item-poupanca.vl-espontaneo[8] item-poupanca.vl-espontaneo[9] item-poupanca.vl-espontaneo[10] item-poupanca.vl-espontaneo[11] item-poupanca.vl-espontaneo[12]   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brPoup   
&Scoped-define SELF-NAME brPoup
&Scoped-define QUERY-STRING-brPoup FOR EACH poupanca WHERE NOT poupanca.simulacao NO-LOCK, ~
             EACH item-poupanca OF poupanca WHERE item-poupanca.ano = INPUT FRAME default-frame orcamento.ano NO-LOCK
&Scoped-define OPEN-QUERY-brPoup OPEN QUERY {&SELF-NAME} FOR EACH poupanca WHERE NOT poupanca.simulacao NO-LOCK, ~
             EACH item-poupanca OF poupanca WHERE item-poupanca.ano = INPUT FRAME default-frame orcamento.ano NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brPoup poupanca item-poupanca
&Scoped-define FIRST-TABLE-IN-QUERY-brPoup poupanca
&Scoped-define SECOND-TABLE-IN-QUERY-brPoup item-poupanca


/* Definitions for FRAME fPage2                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage2 ~
    ~{&OPEN-QUERY-brPoup}

/* Definitions for FRAME fPage3                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage3 ~
    ~{&OPEN-QUERY-brMensal}

/* Definitions for FRAME fPage5                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage5 ~
    ~{&OPEN-QUERY-brAnual}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS orcamento.cd-orcamento orcamento.ds-orcamento ~
orcamento.ano 
&Scoped-define ENABLED-TABLES orcamento
&Scoped-define FIRST-ENABLED-TABLE orcamento
&Scoped-Define ENABLED-OBJECTS btCopy btAdd btCancel btDelete btFirst ~
btLast btNext btPrev btSave btUpdate select-frame btExit RECT-1 RECT-6 
&Scoped-Define DISPLAYED-FIELDS orcamento.cd-orcamento ~
orcamento.ds-orcamento orcamento.ano 
&Scoped-define DISPLAYED-TABLES orcamento
&Scoped-define FIRST-DISPLAYED-TABLE orcamento
&Scoped-Define DISPLAYED-OBJECTS select-frame 

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
     LABEL "Add" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir".

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancel" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btCopy 
     IMAGE-UP FILE "image/im-copia.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-copia.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Copia" 
     SIZE 6.14 BY 1.79 TOOLTIP "Copia Outro Oráamento".

DEFINE BUTTON btDelete 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Delete" 
     SIZE 6.14 BY 1.79 TOOLTIP "Excluir".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btFirst 
     IMAGE-UP FILE "image/im-fir.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fir.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "First" 
     SIZE 6.14 BY 1.79 TOOLTIP "Primeiro".

DEFINE BUTTON btLast 
     IMAGE-UP FILE "image/im-las.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-las.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Last" 
     SIZE 6.14 BY 1.79 TOOLTIP "Èltimo".

DEFINE BUTTON btNext 
     IMAGE-UP FILE "image/im-nex.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-nex.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Next" 
     SIZE 6.14 BY 1.79 TOOLTIP "Pr¢ximo".

DEFINE BUTTON btPrev 
     IMAGE-UP FILE "image/im-pre.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-pre.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Prev" 
     SIZE 6.14 BY 1.79 TOOLTIP "Anterior".

DEFINE BUTTON btSave 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Save" 
     SIZE 6.14 BY 1.79 TOOLTIP "Salvar".

DEFINE BUTTON btUpdate 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Upd" 
     SIZE 6.14 BY 1.79 TOOLTIP "Modificar".

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 115 BY 2.25.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 115 BY 1.5.

DEFINE VARIABLE select-frame AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     LIST-ITEMS "Resumo Anual","Resumo Mensal","Receitas","Poupanáa","Despesas" 
     SIZE 17 BY 3 NO-UNDO.

DEFINE BUTTON btElim 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Retirar desse oráamento".

DEFINE BUTTON btInc 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir nesse oráamento".

DEFINE VARIABLE cat AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 33 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE sub AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Sub-Categoria" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 33 BY 1
     FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 64 BY 4.75.

DEFINE BUTTON btElimp 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Excluir a contribuiá∆o extra desse oráamento".

DEFINE BUTTON btIncp 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Incluir" 
     SIZE 6.14 BY 1.79 TOOLTIP "Incluir contribuiá∆o extra nesse oráamento".

DEFINE VARIABLE contas AS INTEGER FORMAT "999":U INITIAL 0 
     LABEL "Conta" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "",0
     DROP-DOWN-LIST
     SIZE 42 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE vl-poup AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 64 BY 4.75.

DEFINE VARIABLE anual AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY .67
     FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE mensal AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY .67
     FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE res-anual AS CHARACTER FORMAT "X(256)":U INITIAL "Valor Anual" 
      VIEW-AS TEXT 
     SIZE 15 BY .67 NO-UNDO.

DEFINE VARIABLE res-mensal AS CHARACTER FORMAT "X(256)":U INITIAL "Valor Mensal" 
      VIEW-AS TEXT 
     SIZE 15 BY .67 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 17 BY 4.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAnual FOR 
      tt-anual SCROLLING.

DEFINE QUERY brMensal FOR 
      tt-mensal SCROLLING.

DEFINE QUERY brPoup FOR 
      poupanca, 
      item-poupanca SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAnual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAnual C-Win _FREEFORM
  QUERY brAnual NO-LOCK DISPLAY
      tt-anual.mes
      tt-anual.vl-rec FORMAT "->>>,>>>,>>9.99":U
      tt-anual.vl-poup FORMAT "->>>,>>>,>>9.99":U
      tt-anual.vl-desp FORMAT "->>>,>>>,>>9.99":U
      tt-anual.vl-dif FORMAT "->>>,>>>,>>9.99":U
      tt-anual.vl-acum FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 79 BY 9.25
         FONT 1.

DEFINE BROWSE brMensal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brMensal C-Win _FREEFORM
  QUERY brMensal NO-LOCK DISPLAY
      tt-mensal.descricao
      tt-mensal.vl-mes FORMAT "->>>,>>>,>>9.99":U
      tt-mensal.vl-esp FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 74 BY 16.75
         FONT 2.

DEFINE BROWSE brPoup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brPoup C-Win _FREEFORM
  QUERY brPoup NO-LOCK DISPLAY
      fnCd-poupanca(item-poupanca.cd-poupanca) @ cCd-poupanca
      fnCd-conta(poupanca.cd-conta) @ cCd-conta
      item-poupanca.vl-deposito FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[1] COLUMN-LABEL "Janeiro" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[2] COLUMN-LABEL "Fevereiro" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[3] COLUMN-LABEL "Maráo" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[4] COLUMN-LABEL "Abril" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[5] COLUMN-LABEL "Maio" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[6] COLUMN-LABEL "Junho" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[7] COLUMN-LABEL "Julho" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[8] COLUMN-LABEL "Agosto" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[9] COLUMN-LABEL "Setembro" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[10] COLUMN-LABEL "Outubro" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[11] COLUMN-LABEL "Novembro" FORMAT "->>>,>>>,>>9.99":U
      item-poupanca.vl-espontaneo[12] COLUMN-LABEL "Dezembro" FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 92 BY 8.25
         FONT 1
         TITLE "Planejamento de Poupanáas".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCopy AT ROW 1.5 COL 52
     btAdd AT ROW 1.5 COL 31
     btCancel AT ROW 23.5 COL 111.14
     btDelete AT ROW 1.5 COL 43.29
     btFirst AT ROW 1.5 COL 4
     btLast AT ROW 1.5 COL 22.43
     btNext AT ROW 1.5 COL 16.29
     btPrev AT ROW 1.5 COL 10.14
     btSave AT ROW 23.5 COL 105
     btUpdate AT ROW 1.5 COL 37.14
     select-frame AT ROW 5.5 COL 4 NO-LABEL
     orcamento.cd-orcamento AT ROW 4 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     orcamento.ds-orcamento AT ROW 4 COL 20.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 83.72 BY .79
     orcamento.ano AT ROW 4 COL 110 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btExit AT ROW 1.5 COL 111
     RECT-1 AT ROW 1.25 COL 3
     RECT-6 AT ROW 3.75 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 117.57 BY 24.46
         FONT 1.

DEFINE FRAME fPage2
     brPoup AT ROW 1 COL 3
     btElimp AT ROW 10 COL 70.14
     btIncp AT ROW 10 COL 64
     contas AT ROW 10 COL 19 COLON-ALIGNED
     vl-poup AT ROW 11 COL 19 COLON-ALIGNED
     item-orcamento.vl-mes AT ROW 11 COL 48.72 COLON-ALIGNED
          LABEL "Extra" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[1] AT ROW 13 COL 21 COLON-ALIGNED
          LABEL "Janeiro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[2] AT ROW 14 COL 21 COLON-ALIGNED
          LABEL "Fevereiro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[3] AT ROW 15 COL 21 COLON-ALIGNED
          LABEL "Maráo" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[4] AT ROW 16 COL 21 COLON-ALIGNED
          LABEL "Abril" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[5] AT ROW 13 COL 40 COLON-ALIGNED
          LABEL "Maio" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[6] AT ROW 14 COL 40 COLON-ALIGNED
          LABEL "Junho" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[7] AT ROW 15 COL 40 COLON-ALIGNED
          LABEL "Julho" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[8] AT ROW 16 COL 40 COLON-ALIGNED
          LABEL "Agosto" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[9] AT ROW 13 COL 62 COLON-ALIGNED
          LABEL "Setembro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[10] AT ROW 14 COL 62 COLON-ALIGNED
          LABEL "Outubro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[11] AT ROW 15 COL 62 COLON-ALIGNED
          LABEL "Novembro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[12] AT ROW 16 COL 62 COLON-ALIGNED
          LABEL "Dezembro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     RECT-4 AT ROW 12.5 COL 14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 23 ROW 5.5
         SIZE 95 BY 17.75
         FONT 1.

DEFINE FRAME fPage3
     brMensal AT ROW 1.25 COL 11
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 23 ROW 5.5
         SIZE 95 BY 17.75.

DEFINE FRAME fPage4
     res-mensal AT ROW 1.5 COL 1 COLON-ALIGNED NO-LABEL
     mensal AT ROW 2.5 COL 1 COLON-ALIGNED NO-LABEL
     res-anual AT ROW 3.5 COL 1 COLON-ALIGNED NO-LABEL
     anual AT ROW 4.5 COL 17 RIGHT-ALIGNED NO-LABEL
     RECT-5 AT ROW 1.13 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 8.75
         SIZE 19 BY 5.

DEFINE FRAME fPage5
     brAnual AT ROW 1.25 COL 7
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 23 ROW 5.5
         SIZE 95 BY 18.

DEFINE FRAME fPage1
     btElim AT ROW 1.5 COL 9.14
     btInc AT ROW 1.5 COL 3
     cat AT ROW 1.5 COL 58 COLON-ALIGNED
     sub AT ROW 2.5 COL 58 COLON-ALIGNED
     item-orcamento.vl-mes AT ROW 4.25 COL 79 COLON-ALIGNED FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[1] AT ROW 8 COL 21 COLON-ALIGNED
          LABEL "Janeiro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[2] AT ROW 9 COL 21 COLON-ALIGNED
          LABEL "Fevereiro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[3] AT ROW 10 COL 21 COLON-ALIGNED
          LABEL "Maráo" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[4] AT ROW 11 COL 21 COLON-ALIGNED
          LABEL "Abril" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[5] AT ROW 8 COL 41 COLON-ALIGNED
          LABEL "Maio" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[6] AT ROW 9 COL 41 COLON-ALIGNED
          LABEL "Junho" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[7] AT ROW 10 COL 41 COLON-ALIGNED
          LABEL "Julho" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[8] AT ROW 11 COL 41 COLON-ALIGNED
          LABEL "Agosto" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[9] AT ROW 8 COL 63 COLON-ALIGNED
          LABEL "Setembro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[10] AT ROW 9 COL 63 COLON-ALIGNED
          LABEL "Outubro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[11] AT ROW 10 COL 63 COLON-ALIGNED
          LABEL "Novembro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     item-orcamento.vl-espontaneo[12] AT ROW 11 COL 63 COLON-ALIGNED
          LABEL "Dezembro" FORMAT "->>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     RECT-3 AT ROW 7.5 COL 14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 23 ROW 5.5
         SIZE 95 BY 17.75
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
         TITLE              = "Planejamento de Oráamento"
         HEIGHT             = 24.46
         WIDTH              = 117.57
         MAX-HEIGHT         = 24.46
         MAX-WIDTH          = 117.57
         VIRTUAL-HEIGHT     = 24.46
         VIRTUAL-WIDTH      = 117.57
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
/* REPARENT FRAME */
ASSIGN FRAME fPage1:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPage2:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPage3:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPage4:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fPage5:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fPage1:MOVE-AFTER-TAB-ITEM (orcamento.ano:HANDLE IN FRAME DEFAULT-FRAME)
       XXTABVALXX = FRAME fPage1:MOVE-BEFORE-TAB-ITEM (FRAME fPage2:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fPage1
   Custom                                                               */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[10] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[11] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[12] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[1] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[2] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[3] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[4] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[5] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[6] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[7] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[8] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[9] IN FRAME fPage1
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-mes IN FRAME fPage1
   EXP-FORMAT                                                           */
/* SETTINGS FOR FRAME fPage2
   Custom                                                               */
/* BROWSE-TAB brPoup 1 fPage2 */
ASSIGN 
       brPoup:NUM-LOCKED-COLUMNS IN FRAME fPage2     = 1
       brPoup:COLUMN-RESIZABLE IN FRAME fPage2       = TRUE
       brPoup:COLUMN-MOVABLE IN FRAME fPage2         = TRUE.

/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[10] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[11] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[12] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[1] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[2] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[3] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[4] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[5] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[6] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[7] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[8] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-espontaneo[9] IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN item-orcamento.vl-mes IN FRAME fPage2
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FRAME fPage3
                                                                        */
/* BROWSE-TAB brMensal 1 fPage3 */
ASSIGN 
       brMensal:COLUMN-RESIZABLE IN FRAME fPage3       = TRUE
       brMensal:COLUMN-MOVABLE IN FRAME fPage3         = TRUE.

/* SETTINGS FOR FRAME fPage4
                                                                        */
/* SETTINGS FOR FILL-IN anual IN FRAME fPage4
   ALIGN-R                                                              */
/* SETTINGS FOR FRAME fPage5
                                                                        */
/* BROWSE-TAB brAnual 1 fPage5 */
ASSIGN 
       brAnual:COLUMN-RESIZABLE IN FRAME fPage5       = TRUE
       brAnual:COLUMN-MOVABLE IN FRAME fPage5         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAnual
/* Query rebuild information for BROWSE brAnual
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-anual NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Query            is OPENED
*/  /* BROWSE brAnual */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brMensal
/* Query rebuild information for BROWSE brMensal
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt-mensal NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Where[1]         = "item-orcamento.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento"
     _Query            is OPENED
*/  /* BROWSE brMensal */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brPoup
/* Query rebuild information for BROWSE brPoup
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH poupanca WHERE NOT poupanca.simulacao NO-LOCK,
      EACH item-poupanca OF poupanca WHERE item-poupanca.ano = INPUT FRAME default-frame orcamento.ano NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Where[1]         = "item-poupanca.ano = INPUT FRAME default-frame orcamento.ano
AND NOT poupanca.simulacao"
     _Query            is OPENED
*/  /* BROWSE brPoup */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Planejamento de Oráamento */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Planejamento de Oráamento */
DO:
  /* This event will close the window and terminate the procedure.  */
  IF cAction <> "" THEN
    APPLY "CHOOSE" TO btCancel IN FRAME default-frame.
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME orcamento.ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL orcamento.ano C-Win
ON ENTRY OF orcamento.ano IN FRAME DEFAULT-FRAME /* Ano */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL orcamento.ano C-Win
ON LEAVE OF orcamento.ano IN FRAME DEFAULT-FRAME /* Ano */
DO:

    {func\set_leave.i}  
    RUN recalcula.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAnual
&Scoped-define FRAME-NAME fPage5
&Scoped-define SELF-NAME brAnual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAnual C-Win
ON ROW-DISPLAY OF brAnual IN FRAME fPage5
DO:
  
    IF tt-anual.vl-dif <= 0 THEN DO:
        ASSIGN tt-anual.vl-dif:FGCOLOR IN BROWSE brAnual = 12.
    END.
    ELSE DO:
        ASSIGN tt-anual.vl-dif:FGCOLOR IN BROWSE brAnual = 9.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAnual C-Win
ON VALUE-CHANGED OF brAnual IN FRAME fPage5
DO:
  
    IF AVAIL tt-anual THEN
        brAnual:DESELECT-SELECTED-ROW(1).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brMensal
&Scoped-define FRAME-NAME fPage3
&Scoped-define SELF-NAME brMensal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brMensal C-Win
ON ROW-DISPLAY OF brMensal IN FRAME fPage3
DO:
  
    IF SUBSTRING(tt-mensal.descricao,6,1) <> "" THEN
        ASSIGN tt-mensal.vl-mes:FGCOLOR IN BROWSE brMensal = 9
               tt-mensal.vl-esp:FGCOLOR IN BROWSE brMensal = 9
               tt-mensal.descricao:FGCOLOR IN BROWSE brMensal = 9.

    IF tt-mensal.descricao = "RECEITAS"
    OR tt-mensal.descricao = "CONTRIBUIÄÂES ∑ POUPANÄA"
    OR tt-mensal.descricao = "DESPESAS" THEN
        ASSIGN tt-mensal.vl-mes:FGCOLOR IN BROWSE brMensal = 12
               tt-mensal.vl-esp:FGCOLOR IN BROWSE brMensal = 12
               tt-mensal.descricao:FGCOLOR IN BROWSE brMensal = 12.

    IF tt-mensal.descricao = "" THEN
        ASSIGN tt-mensal.vl-mes:FGCOLOR IN BROWSE brMensal = 15
               tt-mensal.vl-esp:FGCOLOR IN BROWSE brMensal = 15
               tt-mensal.descricao:FGCOLOR IN BROWSE brMensal = 15.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brMensal C-Win
ON VALUE-CHANGED OF brMensal IN FRAME fPage3
DO:

    IF AVAIL tt-mensal THEN DO:
        IF brMensal:NUM-SELECTED-ROWS > 0 THEN
            brMensal:DESELECT-SELECTED-ROW(1).  
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd C-Win
ON CHOOSE OF btAdd IN FRAME DEFAULT-FRAME /* Add */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND LAST bforcamento NO-LOCK NO-ERROR.

    CREATE orcamento.
    IF AVAIL bforcamento THEN
        ASSIGN orcamento.cd-orcamento = bforcamento.cd-orcamento + 1.
    ELSE
        ASSIGN orcamento.cd-orcamento = 1.
    RUN displayFields.
    ASSIGN cAction = "ADD".
    APPLY "CHOOSE" TO btUpdate.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF VALID-HANDLE(hLastWidget) THEN
        ASSIGN hLastWidget:BGCOLOR = ?.
    IF cAction = "ADD" THEN
        DELETE orcamento.
    DISABLE {&FrameFields} WITH FRAME default-frame.
    DISABLE btSave
            btCancel WITH FRAME default-frame.
    RUN controlButons(INPUT NO).
    ENABLE btAdd
           btUpdate
           btDelete
           btFirst
           btLast
           btPrev
           btNext WITH FRAME default-frame.
    IF cAction = "ADD" THEN DO:
        FIND FIRST orcamento NO-LOCK NO-ERROR.
    END.
    RUN displayFields.
    ASSIGN cAction = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCopy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCopy C-Win
ON CHOOSE OF btCopy IN FRAME DEFAULT-FRAME /* Copia */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FOR EACH tt-info:
        DELETE tt-info.
    END.
    CREATE tt-info.
    ASSIGN tt-info.campo = "Oráamento"
           tt-info.tabela = "orcamento"
           tt-info.campo-proc = "cd-orcamento"
           tt-info.valor = ""
           tt-info.campo-desc = "ds-orcamento".

    {func\run.i &Programa = "func\info.w (INPUT-OUTPUT TABLE tt-info)"}

    IF RETURN-VALUE = "OK" THEN DO:

        FIND FIRST tt-info
            WHERE tt-info.campo = "Oráamento".
        IF tt-info.descricao = "" THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Oráamento Inv†lido (038)', INPUT 'N∆o foi informado oráamento v†lido!', INPUT 'N∆o foi informado um oráamento v†lido no programa de Informaá‰es Adicionais para ser copiado.')"}
            RETURN.
        END.
        ELSE DO:

            {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Copia de Oráamento (039)', INPUT 'Confirma c¢pia de oráamento ?', INPUT 'Os itens do oráamento informado ser∆o copiados para o oráamento atual. Se j† existirem itens idànticos, ser∆o sobrepostos.')"}
            IF RETURN-VALUE = "OK" THEN DO:
                FOR EACH item-orcamento NO-LOCK
                    WHERE item-orcamento.cd-orcamento = INT(tt-info.valor):
                    FIND FIRST bfitem OF item-orcamento
                        WHERE bfitem.cd-orcamento = orcamento.cd-orcamento EXCLUSIVE-LOCK NO-ERROR.
                    IF AVAIL bfItem THEN DO:
                        DELETE bfItem.
                    END.
                    CREATE bfItem.
                    BUFFER-COPY item-orcamento EXCEPT cd-orcamento TO bfItem.
                    ASSIGN bfItem.cd-orcamento = orcamento.cd-orcamento.
                END.
                RUN displayFields IN THIS-PROCEDURE.
            END.
        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDelete C-Win
ON CHOOSE OF btDelete IN FRAME DEFAULT-FRAME /* Delete */
DO:
  
    DEFINE VARIABLE l-OK AS LOGICAL    NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
    IF RETURN-VALUE = "OK" THEN DO:
        FOR EACH item-orcamento OF orcamento EXCLUSIVE-LOCK:
            DELETE item-orcamento.
        END.
        FIND CURRENT orcamento EXCLUSIVE-LOCK.
        DELETE orcamento.
        FIND NEXT orcamento NO-LOCK NO-ERROR.
        IF NOT AVAIL orcamento THEN
            FIND PREV orcamento NO-LOCK NO-ERROR.
        RUN displayFields.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btElim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btElim C-Win
ON CHOOSE OF btElim IN FRAME fPage1 /* Eliminar */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND CURRENT item-orcamento EXCLUSIVE-LOCK.
    DELETE item-orcamento.
    APPLY "VALUE-CHANGED":U TO sub IN FRAME fPage1.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btElimp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btElimp C-Win
ON CHOOSE OF btElimp IN FRAME fPage2 /* Eliminar */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND CURRENT item-orcamento EXCLUSIVE-LOCK.
    DELETE item-orcamento.
    APPLY "VALUE-CHANGED":U TO contas IN FRAME fPage2.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
ON CHOOSE OF btFirst IN FRAME DEFAULT-FRAME /* First */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND FIRST orcamento NO-LOCK NO-ERROR.
    RUN displayFields.
    ENABLE btNext
           btLast WITH FRAME default-frame.
    DISABLE btPrev
            btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btInc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btInc C-Win
ON CHOOSE OF btInc IN FRAME fPage1 /* Incluir */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    CREATE item-orcamento.
    ASSIGN item-orcamento.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
           item-orcamento.cod-categoria = INPUT FRAME fPage1 cat
           item-orcamento.cd-sub = INPUT FRAME fPage1 sub.
    APPLY "VALUE-CHANGED":U TO sub IN FRAME fPage1.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btIncp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btIncp C-Win
ON CHOOSE OF btIncp IN FRAME fPage2 /* Incluir */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    CREATE item-orcamento.
    ASSIGN item-orcamento.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
           item-orcamento.cod-categoria = 997
           item-orcamento.cd-sub = INPUT FRAME fPage2 contas.
    APPLY "VALUE-CHANGED":U TO contas IN FRAME fPage2.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btLast C-Win
ON CHOOSE OF btLast IN FRAME DEFAULT-FRAME /* Last */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND LAST orcamento NO-LOCK NO-ERROR.
    RUN displayFields.
    DISABLE btNext
            btLast WITH FRAME default-frame.
    ENABLE btPrev
           btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btNext C-Win
ON CHOOSE OF btNext IN FRAME DEFAULT-FRAME /* Next */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND NEXT orcamento NO-LOCK NO-ERROR.
    IF NOT AVAIL orcamento THEN DO:
        FIND LAST orcamento NO-LOCK.
        DISABLE btNext
                btLast WITH FRAME default-frame.
    END.
    RUN displayFields.
    ENABLE btPrev
           btFirst WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPrev C-Win
ON CHOOSE OF btPrev IN FRAME DEFAULT-FRAME /* Prev */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    FIND PREV orcamento NO-LOCK NO-ERROR.
    IF NOT AVAIL orcamento THEN DO:
        FIND FIRST orcamento NO-LOCK.
        DISABLE btPrev
                btFirst WITH FRAME default-frame.
    END.
    RUN displayFields.
    ENABLE btNext
           btLast WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSave C-Win
ON CHOOSE OF btSave IN FRAME DEFAULT-FRAME /* Save */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    IF VALID-HANDLE(hLastWidget) THEN
        ASSIGN hLastWidget:BGCOLOR = ?.
    FIND CURRENT orcamento EXCLUSIVE-LOCK.
    ASSIGN INPUT FRAME default-frame {&FrameFields}.
    DISABLE {&FrameFields} WITH FRAME default-frame.
    DISABLE btSave
            btCancel WITH FRAME default-frame.
    RUN controlButons(INPUT NO).
    ENABLE btAdd
           btUpdate
           btDelete
           btFirst
           btLast
           btPrev
           btNext WITH FRAME default-frame.
    FIND FIRST orcamento WHERE cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento NO-LOCK.
    ASSIGN iorcamento = orcamento.cd-orcamento.
    RUN displayFields.
    ASSIGN cAction = "".

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUpdate C-Win
ON CHOOSE OF btUpdate IN FRAME DEFAULT-FRAME /* Upd */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    ENABLE {&FrameFields} WITH FRAME default-frame.
    ENABLE btSave
           btCancel WITH FRAME default-frame.
    DISABLE btAdd
            btUpdate
            btDelete
            btFirst
            btLast
            btPrev
            btNext WITH FRAME default-frame.
    IF cAction = "" THEN
        ASSIGN cAction = "UPDATE".
    RUN controlButons(INPUT YES).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME cat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cat C-Win
ON ENTRY OF cat IN FRAME fPage1 /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cat C-Win
ON LEAVE OF cat IN FRAME fPage1 /* Categoria */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cat C-Win
ON VALUE-CHANGED OF cat IN FRAME fPage1 /* Categoria */
DO:
    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO INITIAL "".
    DEFINE VARIABLE iPrim AS INTEGER  NO-UNDO.
  
    FOR EACH sub-cat NO-LOCK
        WHERE sub-cat.cod-categoria = INPUT FRAME fPage1 cat
        BY sub-cat.ds-sub:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + ",".
        ELSE
            ASSIGN iPrim = sub-cat.cd-sub.
        ASSIGN cLista = cLista + REPLACE(sub-cat.ds-sub,",",";") + "," + STRING(sub-cat.cd-sub,"999").
    END.
    IF cLista <> "" THEN
        ASSIGN cLista = cLista + ",".
    ELSE
        ASSIGN iPrim = 999.
    ASSIGN cLista = cLista + "GERAL,999".
    ASSIGN sub:LIST-ITEM-PAIRS = cLista.
    ASSIGN sub = iPrim.
    DISPLAY sub WITH FRAME fPage1.
    APPLY "VALUE-CHANGED":U TO sub IN FRAME fPage1.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME orcamento.cd-orcamento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL orcamento.cd-orcamento C-Win
ON ENTRY OF orcamento.cd-orcamento IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL orcamento.cd-orcamento C-Win
ON LEAVE OF orcamento.cd-orcamento IN FRAME DEFAULT-FRAME /* C¢digo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME contas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL contas C-Win
ON ENTRY OF contas IN FRAME fPage2 /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL contas C-Win
ON LEAVE OF contas IN FRAME fPage2 /* Conta */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL contas C-Win
ON VALUE-CHANGED OF contas IN FRAME fPage2 /* Conta */
DO:

    DEFINE VARIABLE deTemp AS DECIMAL    NO-UNDO.
  
    FOR EACH item-poupanca
        WHERE item-poupanca.ano = INPUT FRAME default-frame orcamento.ano NO-LOCK:

        FIND FIRST poupanca WHERE poupanca.cd-poupanca = item-poupanca.cd-poupanca NO-LOCK.
        IF poupanca.cd-conta <> INPUT FRAME fPage2 contas THEN NEXT.

        ASSIGN deTemp = deTemp + item-poupanca.vl-deposito.

    END.

    ASSIGN vl-poup = deTemp.
    DISPLAY vl-poup WITH FRAME fPage2.
    {&OPEN-QUERY-brPoup}

    FIND FIRST item-orcamento
        WHERE item-orcamento.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
        AND   item-orcamento.cod-categoria = 997
        AND   item-orcamento.cd-sub = INPUT FRAME fPage2 contas EXCLUSIVE-LOCK NO-ERROR.
    IF cAction <> "" THEN DO:
        IF NOT AVAIL item-orcamento THEN DO:
            ENABLE btIncp WITH FRAME fPage2.
            DISABLE btElimp
                    item-orcamento.vl-mes
                    item-orcamento.vl-espontaneo WITH FRAME fPage2.
        END.
        ELSE DO:
            DISABLE btIncp WITH FRAME fPage2.
            ENABLE btElimp
                   item-orcamento.vl-mes
                   item-orcamento.vl-espontaneo WITH FRAME fPage2.
        END.
    END.
    IF AVAIL item-orcamento THEN DO:
        DISPLAY item-orcamento.vl-mes
                item-orcamento.vl-espontaneo WITH FRAME fPage2.
    END.
    ELSE DO:
        ASSIGN item-orcamento.vl-mes:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[1]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[2]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[3]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[4]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[5]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[6]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[7]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[8]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[9]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[10]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[11]:SCREEN-VALUE IN FRAME fPage2 = ""
               item-orcamento.vl-espontaneo[12]:SCREEN-VALUE IN FRAME fPage2 = "".
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME orcamento.ds-orcamento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL orcamento.ds-orcamento C-Win
ON ENTRY OF orcamento.ds-orcamento IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL orcamento.ds-orcamento C-Win
ON LEAVE OF orcamento.ds-orcamento IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME select-frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL select-frame C-Win
ON VALUE-CHANGED OF select-frame IN FRAME DEFAULT-FRAME
DO:
    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO INITIAL "".
    DEFINE VARIABLE iPrim AS INTEGER  NO-UNDO.

    IF select-frame <> "" THEN
        RUN som.p(INPUT "music\click.wav").

    HIDE FRAME fpage1.
    HIDE FRAME fpage2.
    HIDE FRAME fpage3.
    HIDE FRAME fpage5.
  
    CASE select-frame:SCREEN-VALUE IN FRAME default-frame:
        WHEN "Resumo Anual" THEN DO:
            {&OPEN-QUERY-brAnual}
            APPLY "VALUE-CHANGED" TO brAnual.
            VIEW FRAME fPage5.
        END.
        WHEN "Resumo Mensal" THEN DO:
            {&OPEN-QUERY-brMensal}
            APPLY "VALUE-CHANGED" TO brMensal.
            VIEW FRAME fPage3.
        END.
        WHEN "Receitas" THEN DO:
            FOR EACH categoria NO-LOCK
                WHERE categoria.id-tipo = 1
                BY categoria.ds-categoria:
                IF cLista <> "" THEN
                    ASSIGN cLista = cLista + ",".
                ELSE
                    ASSIGN iPrim = categoria.cod-categoria.
                ASSIGN cLista = cLista + categoria.ds-categoria + "," + STRING(categoria.cod-categoria,"999").
            END.
            IF cLista <> "" THEN
                ASSIGN cLista = cLista + ",".
            ELSE
                ASSIGN iPrim = 999.
            ASSIGN cLista = cLista + "OUTROS,999".
            ASSIGN cat:LIST-ITEM-PAIRS = cLista.
            ASSIGN cat = iPrim.
            DISPLAY cat WITH FRAME fPage1.
            APPLY "VALUE-CHANGED":U TO cat IN FRAME fPage1.
            VIEW FRAME fPage1.
        END.
        WHEN "Poupanáa" THEN DO:
            FOR EACH conta NO-LOCK
                WHERE conta.id-tipo = 2
                AND   conta.id-encerrada = NO
                BY conta.ds-conta:
                IF cLista <> "" THEN
                    ASSIGN cLista = cLista + ",".
                ELSE
                    ASSIGN iPrim = conta.cd-conta.
                ASSIGN cLista = cLista + STRING(conta.cd-conta,"999") + " - " + conta.ds-conta + "," + STRING(conta.cd-conta,"999").
            END.
            IF cLista = "" THEN
                ASSIGN cLista = ",0".
            ASSIGN contas:LIST-ITEM-PAIRS = cLista.
            ASSIGN contas = iPrim.
            DISPLAY contas WITH FRAME fPage2.
            APPLY "VALUE-CHANGED":U TO contas IN FRAME fPage2.
            VIEW FRAME fPage2.
        END.
        WHEN "Despesas" THEN DO:
            FOR EACH categoria NO-LOCK
                WHERE categoria.id-tipo = 2
                BY categoria.ds-categoria:
                IF cLista <> "" THEN
                    ASSIGN cLista = cLista + ",".
                ELSE
                    ASSIGN iPrim = categoria.cod-categoria.
                ASSIGN cLista = cLista + categoria.ds-categoria + "," + STRING(categoria.cod-categoria,"999").
            END.
            IF cLista <> "" THEN
                ASSIGN cLista = cLista + ",".
            ELSE
                ASSIGN iPrim = 998.
            ASSIGN cLista = cLista + "OUTROS,998".
            ASSIGN cat:LIST-ITEM-PAIRS = cLista.
            ASSIGN cat = iPrim.
            DISPLAY cat WITH FRAME fPage1.
            APPLY "VALUE-CHANGED":U TO cat IN FRAME fPage1.
            VIEW FRAME fPage1.
        END.
    END CASE.

    ASSIGN INPUT FRAME {&FRAME-NAME} select-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub C-Win
ON ENTRY OF sub IN FRAME fPage1 /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub C-Win
ON LEAVE OF sub IN FRAME fPage1 /* Sub-Categoria */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sub C-Win
ON VALUE-CHANGED OF sub IN FRAME fPage1 /* Sub-Categoria */
DO:
  
    FIND FIRST item-orcamento
        WHERE item-orcamento.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
        AND   item-orcamento.cod-categoria = INPUT FRAME fPage1 cat
        AND   item-orcamento.cd-sub = INPUT FRAME fPage1 sub EXCLUSIVE-LOCK NO-ERROR.
    IF cAction <> "" THEN DO:
        IF NOT AVAIL item-orcamento THEN DO:
            ENABLE btInc WITH FRAME fPage1.
            DISABLE btElim
                    item-orcamento.vl-mes
                    item-orcamento.vl-espontaneo WITH FRAME fPage1.
        END.
        ELSE DO:
            DISABLE btInc WITH FRAME fPage1.
            ENABLE btElim
                   item-orcamento.vl-mes
                   item-orcamento.vl-espontaneo WITH FRAME fPage1.
        END.
    END.
    IF AVAIL item-orcamento THEN DO:
        DISPLAY item-orcamento.vl-mes
                item-orcamento.vl-espontaneo WITH FRAME fPage1.
    END.
    ELSE DO:
        ASSIGN item-orcamento.vl-mes:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[1]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[2]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[3]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[4]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[5]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[6]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[7]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[8]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[9]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[10]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[11]:SCREEN-VALUE IN FRAME fPage1 = ""
               item-orcamento.vl-espontaneo[12]:SCREEN-VALUE IN FRAME fPage1 = "".
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[10]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[10] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[10] IN FRAME fPage1 /* Outubro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[10] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[10] IN FRAME fPage1 /* Outubro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[10] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[10] IN FRAME fPage1 /* Outubro */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[10]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[10] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[10] IN FRAME fPage2 /* Outubro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[10] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[10] IN FRAME fPage2 /* Outubro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[10] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[10] IN FRAME fPage2 /* Outubro */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[11]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[11] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[11] IN FRAME fPage2 /* Novembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[11] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[11] IN FRAME fPage2 /* Novembro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[11] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[11] IN FRAME fPage2 /* Novembro */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[11]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[11] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[11] IN FRAME fPage1 /* Novembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[11] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[11] IN FRAME fPage1 /* Novembro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[11] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[11] IN FRAME fPage1 /* Novembro */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[12]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[12] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[12] IN FRAME fPage2 /* Dezembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[12] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[12] IN FRAME fPage2 /* Dezembro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[12] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[12] IN FRAME fPage2 /* Dezembro */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[12]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[12] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[12] IN FRAME fPage1 /* Dezembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[12] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[12] IN FRAME fPage1 /* Dezembro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[12] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[12] IN FRAME fPage1 /* Dezembro */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[1]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[1] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[1] IN FRAME fPage2 /* Janeiro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[1] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[1] IN FRAME fPage2 /* Janeiro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[1] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[1] IN FRAME fPage2 /* Janeiro */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[1]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[1] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[1] IN FRAME fPage1 /* Janeiro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[1] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[1] IN FRAME fPage1 /* Janeiro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[1] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[1] IN FRAME fPage1 /* Janeiro */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[2]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[2] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[2] IN FRAME fPage1 /* Fevereiro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[2] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[2] IN FRAME fPage1 /* Fevereiro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[2] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[2] IN FRAME fPage1 /* Fevereiro */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[2]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[2] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[2] IN FRAME fPage2 /* Fevereiro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[2] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[2] IN FRAME fPage2 /* Fevereiro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[2] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[2] IN FRAME fPage2 /* Fevereiro */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[3]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[3] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[3] IN FRAME fPage1 /* Maráo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[3] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[3] IN FRAME fPage1 /* Maráo */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[3] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[3] IN FRAME fPage1 /* Maráo */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[3]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[3] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[3] IN FRAME fPage2 /* Maráo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[3] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[3] IN FRAME fPage2 /* Maráo */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[3] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[3] IN FRAME fPage2 /* Maráo */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[4]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[4] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[4] IN FRAME fPage2 /* Abril */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[4] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[4] IN FRAME fPage2 /* Abril */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[4] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[4] IN FRAME fPage2 /* Abril */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[4]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[4] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[4] IN FRAME fPage1 /* Abril */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[4] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[4] IN FRAME fPage1 /* Abril */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[4] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[4] IN FRAME fPage1 /* Abril */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[5]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[5] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[5] IN FRAME fPage2 /* Maio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[5] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[5] IN FRAME fPage2 /* Maio */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[5] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[5] IN FRAME fPage2 /* Maio */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[5]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[5] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[5] IN FRAME fPage1 /* Maio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[5] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[5] IN FRAME fPage1 /* Maio */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[5] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[5] IN FRAME fPage1 /* Maio */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[6]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[6] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[6] IN FRAME fPage2 /* Junho */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[6] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[6] IN FRAME fPage2 /* Junho */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[6] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[6] IN FRAME fPage2 /* Junho */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[6]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[6] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[6] IN FRAME fPage1 /* Junho */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[6] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[6] IN FRAME fPage1 /* Junho */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[6] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[6] IN FRAME fPage1 /* Junho */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[7]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[7] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[7] IN FRAME fPage2 /* Julho */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[7] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[7] IN FRAME fPage2 /* Julho */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[7] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[7] IN FRAME fPage2 /* Julho */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[7]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[7] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[7] IN FRAME fPage1 /* Julho */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[7] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[7] IN FRAME fPage1 /* Julho */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[7] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[7] IN FRAME fPage1 /* Julho */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[8]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[8] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[8] IN FRAME fPage1 /* Agosto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[8] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[8] IN FRAME fPage1 /* Agosto */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[8] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[8] IN FRAME fPage1 /* Agosto */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[8]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[8] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[8] IN FRAME fPage2 /* Agosto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[8] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[8] IN FRAME fPage2 /* Agosto */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[8] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[8] IN FRAME fPage2 /* Agosto */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[9]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[9] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[9] IN FRAME fPage2 /* Setembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[9] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[9] IN FRAME fPage2 /* Setembro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[9] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[9] IN FRAME fPage2 /* Setembro */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-espontaneo[9]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[9] C-Win
ON ENTRY OF item-orcamento.vl-espontaneo[9] IN FRAME fPage1 /* Setembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[9] C-Win
ON LEAVE OF item-orcamento.vl-espontaneo[9] IN FRAME fPage1 /* Setembro */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-espontaneo[9] C-Win
ON VALUE-CHANGED OF item-orcamento.vl-espontaneo[9] IN FRAME fPage1 /* Setembro */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-espontaneo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME item-orcamento.vl-mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-mes C-Win
ON ENTRY OF item-orcamento.vl-mes IN FRAME fPage2 /* Extra */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-mes C-Win
ON LEAVE OF item-orcamento.vl-mes IN FRAME fPage2 /* Extra */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-mes.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-mes C-Win
ON VALUE-CHANGED OF item-orcamento.vl-mes IN FRAME fPage2 /* Extra */
DO:
  
    ASSIGN INPUT FRAME fPage2 item-orcamento.vl-mes.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME item-orcamento.vl-mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-mes C-Win
ON ENTRY OF item-orcamento.vl-mes IN FRAME fPage1 /* Valor Mensal */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-mes C-Win
ON LEAVE OF item-orcamento.vl-mes IN FRAME fPage1 /* Valor Mensal */
DO:
  
    {func\set_leave.i}  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-mes.
    RUN recalcula.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-orcamento.vl-mes C-Win
ON VALUE-CHANGED OF item-orcamento.vl-mes IN FRAME fPage1 /* Valor Mensal */
DO:
  
    ASSIGN INPUT FRAME fPage1 item-orcamento.vl-mes.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME vl-poup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-poup C-Win
ON ENTRY OF vl-poup IN FRAME fPage2 /* Valor */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vl-poup C-Win
ON LEAVE OF vl-poup IN FRAME fPage2 /* Valor */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAnual
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
    {version.i orc}
    /*RUN enable_UI.*/
    RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlButons C-Win 
PROCEDURE controlButons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER lHabilita AS LOGICAL    NO-UNDO.

IF NOT lHabilita THEN DO:
    DISABLE item-orcamento.vl-mes
            item-orcamento.vl-espontaneo
            btInc
            btElim WITH FRAME fPage1.
    DISABLE item-orcamento.vl-mes
            item-orcamento.vl-espontaneo
            btIncp
            btElimp WITH FRAME fPage2.
    ENABLE btCopy WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    IF INPUT FRAME default-frame select-frame = "Poupanáa" THEN
        APPLY "VALUE-CHANGED" TO contas IN FRAME fPage2.
    ELSE
        APPLY "VALUE-CHANGED" TO sub IN FRAME fPage1.
    DISABLE btCopy WITH FRAME {&FRAME-NAME}.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaTTAnual C-Win 
PROCEDURE criaTTAnual :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VARIABLE deAcum AS DECIMAL    NO-UNDO.

FOR EACH tt-anual:
    DELETE tt-anual.
END.

CREATE tt-anual.
ASSIGN tt-anual.cod = 1
       tt-anual.mes = "Janeiro".
CREATE tt-anual.
ASSIGN tt-anual.cod = 2
       tt-anual.mes = "Fevereiro".
CREATE tt-anual.
ASSIGN tt-anual.cod = 3
       tt-anual.mes = "Maráo".
CREATE tt-anual.
ASSIGN tt-anual.cod = 4
       tt-anual.mes = "Abril".
CREATE tt-anual.
ASSIGN tt-anual.cod = 5
       tt-anual.mes = "Maio".
CREATE tt-anual.
ASSIGN tt-anual.cod = 6
       tt-anual.mes = "Junho".
CREATE tt-anual.
ASSIGN tt-anual.cod = 7
       tt-anual.mes = "Julho".
CREATE tt-anual.
ASSIGN tt-anual.cod = 8
       tt-anual.mes = "Agosto".
CREATE tt-anual.
ASSIGN tt-anual.cod = 9
       tt-anual.mes = "Setembro".
CREATE tt-anual.
ASSIGN tt-anual.cod = 10
       tt-anual.mes = "Outubro".
CREATE tt-anual.
ASSIGN tt-anual.cod = 11
       tt-anual.mes = "Novembro".
CREATE tt-anual.
ASSIGN tt-anual.cod = 12
       tt-anual.mes = "Dezembro".

FOR EACH bfItem
    WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento NO-LOCK:

    FIND FIRST categoria WHERE categoria.cod-categoria = bfItem.cod-categoria NO-LOCK NO-ERROR.
    IF AVAIL categoria THEN DO:

        IF categoria.id-tipo = 1 THEN DO:

            FOR EACH tt-anual:
                ASSIGN tt-anual.vl-rec = tt-anual.vl-rec + bfItem.vl-mes
                       tt-anual.vl-rec = tt-anual.vl-rec + bfItem.vl-espontaneo[tt-anual.cod].
            END.

        END.
        ELSE DO:

            FOR EACH tt-anual:
                ASSIGN tt-anual.vl-desp = tt-anual.vl-desp + bfItem.vl-mes
                       tt-anual.vl-desp = tt-anual.vl-desp + bfItem.vl-espontaneo[tt-anual.cod].
            END.

        END.

    END.
    ELSE DO:
        IF bfItem.cod-categoria = 999 THEN DO:
            FOR EACH tt-anual:
                ASSIGN tt-anual.vl-rec = tt-anual.vl-rec + bfItem.vl-mes
                       tt-anual.vl-rec = tt-anual.vl-rec + bfItem.vl-espontaneo[tt-anual.cod].
            END.
        END.
        IF bfItem.cod-categoria = 998 THEN DO:
            FOR EACH tt-anual:
                ASSIGN tt-anual.vl-desp = tt-anual.vl-desp + bfItem.vl-mes
                       tt-anual.vl-desp = tt-anual.vl-desp + bfItem.vl-espontaneo[tt-anual.cod].
            END.
        END.
        IF bfItem.cod-categoria = 997 THEN DO:
            FOR EACH tt-anual:
                ASSIGN tt-anual.vl-poup = tt-anual.vl-poup + bfItem.vl-mes
                       tt-anual.vl-poup = tt-anual.vl-poup + bfItem.vl-espontaneo[tt-anual.cod].
            END.
        END.
    END.

END.
FOR EACH item-poupanca 
    WHERE item-poupanca.ano = INPUT FRAME default-frame orcamento.ano NO-LOCK:
    FIND FIRST poupanca OF item-poupanca NO-LOCK.
    IF poupanca.simulacao THEN NEXT.
    FOR EACH tt-anual:
        ASSIGN tt-anual.vl-poup = tt-anual.vl-poup + item-poupanca.vl-deposito
               tt-anual.vl-poup = tt-anual.vl-poup + item-poupanca.vl-espontaneo[tt-anual.cod].
    END.
END.

ASSIGN deAcum = 0.
FOR EACH tt-anual:
    ASSIGN tt-anual.vl-dif = tt-anual.vl-rec - tt-anual.vl-desp - tt-anual.vl-poup
           deAcum = deAcum + tt-anual.vl-dif
           tt-anual.vl-acum = deAcum.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE criaTTMensal C-Win 
PROCEDURE criaTTMensal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE deMes AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE deEsp AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iCat  AS INTEGER    NO-UNDO.
    DEFINE VARIABLE dMesc AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE dEspc AS DECIMAL    NO-UNDO.

    FOR EACH tt-mensal:
        DELETE tt-mensal.
    END.

    /* Receitas */

    ASSIGN iCont = 1.
    CREATE tt-mensal.
    ASSIGN tt-mensal.cod = iCont
           tt-mensal.descricao = "RECEITAS"
           iCont = iCont + 1
           iCat = tt-mensal.cod
           dMesc = 0
           dEspc = 0.

    FOR EACH categoria NO-LOCK
        WHERE categoria.id-tipo = 1
        BY categoria.ds-categoria:

        IF CAN-FIND(FIRST bfItem
                    WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria) THEN DO:

            CREATE tt-mensal.
            ASSIGN tt-mensal.cod = iCont
                   tt-mensal.descricao = "     " + categoria.ds-categoria
                   iCont = iCont + 1
                   deMes = 0
                   deEsp = 0
                   iTemp = tt-mensal.cod.

            FOR EACH sub-cat OF categoria NO-LOCK
                BY sub-cat.ds-sub:

                FIND FIRST bfItem
                    WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria
                    AND   bfItem.cd-sub = sub-cat.cd-sub NO-LOCK NO-ERROR.
                IF AVAIL bfItem THEN DO:

                    CREATE tt-mensal.
                    ASSIGN tt-mensal.cod = iCont
                           tt-mensal.descricao = "          " + sub-cat.ds-sub
                           tt-mensal.vl-mes = bfItem.vl-mes
                           tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                              bfItem.vl-espontaneo[2] +
                                              bfItem.vl-espontaneo[3] +
                                              bfItem.vl-espontaneo[4] +
                                              bfItem.vl-espontaneo[5] +
                                              bfItem.vl-espontaneo[6] +
                                              bfItem.vl-espontaneo[7] +
                                              bfItem.vl-espontaneo[8] +
                                              bfItem.vl-espontaneo[9] +
                                              bfItem.vl-espontaneo[10] +
                                              bfItem.vl-espontaneo[11] +
                                              bfItem.vl-espontaneo[12] +
                                              (12 * bfItem.vl-mes)
                           deMes = deMes + tt-mensal.vl-mes
                           deEsp = deEsp + tt-mensal.vl-esp
                           iCont = iCont + 1.

                END.

            END.
            FIND FIRST bfItem
                WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
                AND   bfItem.cod-categoria = categoria.cod-categoria
                AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
            IF AVAIL bfItem THEN DO:

                CREATE tt-mensal.
                ASSIGN tt-mensal.cod = iCont
                       tt-mensal.descricao = "          GERAL"
                       tt-mensal.vl-mes = bfItem.vl-mes
                       tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                          bfItem.vl-espontaneo[2] +
                                          bfItem.vl-espontaneo[3] +
                                          bfItem.vl-espontaneo[4] +
                                          bfItem.vl-espontaneo[5] +
                                          bfItem.vl-espontaneo[6] +
                                          bfItem.vl-espontaneo[7] +
                                          bfItem.vl-espontaneo[8] +
                                          bfItem.vl-espontaneo[9] +
                                          bfItem.vl-espontaneo[10] +
                                          bfItem.vl-espontaneo[11] +
                                          bfItem.vl-espontaneo[12] +
                                          (12 * bfItem.vl-mes)
                       deMes = deMes + tt-mensal.vl-mes
                       deEsp = deEsp + tt-mensal.vl-esp
                       iCont = iCont + 1.

            END.

            FIND FIRST tt-mensal WHERE tt-mensal.cod = iTemp.
            ASSIGN tt-mensal.vl-mes = deMes
                   tt-mensal.vl-esp = deEsp
                   dMesc = dMesc + deMes
                   dEspc = dEspc + deEsp.

        END.

    END.
    FIND FIRST bfItem
        WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
        AND   bfItem.cod-categoria = 999
        AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
    IF AVAIL bfItem THEN DO:

        CREATE tt-mensal.
        ASSIGN tt-mensal.cod = iCont
               tt-mensal.descricao = "     OUTROS"
               tt-mensal.vl-mes = bfItem.vl-mes
               tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                  bfItem.vl-espontaneo[2] +
                                  bfItem.vl-espontaneo[3] +
                                  bfItem.vl-espontaneo[4] +
                                  bfItem.vl-espontaneo[5] +
                                  bfItem.vl-espontaneo[6] +
                                  bfItem.vl-espontaneo[7] +
                                  bfItem.vl-espontaneo[8] +
                                  bfItem.vl-espontaneo[9] +
                                  bfItem.vl-espontaneo[10] +
                                  bfItem.vl-espontaneo[11] +
                                  bfItem.vl-espontaneo[12] +
                                  (12 * bfItem.vl-mes)
               dMesc = dMesc + tt-mensal.vl-mes
               dEspc = dEspc + tt-mensal.vl-esp
               iCont = iCont + 1.

    END.

    FIND FIRST tt-mensal WHERE tt-mensal.cod = iCat.
    ASSIGN tt-mensal.vl-mes = dMesc
           tt-mensal.vl-esp = dEspc.

    /* Poupanáa */

    CREATE tt-mensal.
    ASSIGN tt-mensal.cod = iCont
           iCont = iCont + 1.

    CREATE tt-mensal.
    ASSIGN tt-mensal.cod = iCont
           tt-mensal.descricao = "CONTRIBUIÄÂES ∑ POUPANÄA"
           iCont = iCont + 1
           iCat = tt-mensal.cod
           dMesc = 0
           dEspc = 0.
    FOR EACH item-poupanca 
        WHERE item-poupanca.ano = INPUT FRAME default-frame orcamento.ano NO-LOCK:

        FIND FIRST poupanca OF item-poupanca NO-LOCK.
        IF poupanca.simulacao THEN NEXT.

        CREATE tt-mensal.
        ASSIGN tt-mensal.cod = iCont
               tt-mensal.descricao = "     " + poupanca.ds-poupanca
               tt-mensal.vl-mes = item-poupanca.vl-deposito
               tt-mensal.vl-esp = item-poupanca.vl-espontaneo[1] +
                                  item-poupanca.vl-espontaneo[2] +
                                  item-poupanca.vl-espontaneo[3] +
                                  item-poupanca.vl-espontaneo[4] +
                                  item-poupanca.vl-espontaneo[5] +
                                  item-poupanca.vl-espontaneo[6] +
                                  item-poupanca.vl-espontaneo[7] +
                                  item-poupanca.vl-espontaneo[8] +
                                  item-poupanca.vl-espontaneo[9] +
                                  item-poupanca.vl-espontaneo[10] +
                                  item-poupanca.vl-espontaneo[11] +
                                  item-poupanca.vl-espontaneo[12] +
                                  (12 * item-poupanca.vl-deposito)
               dMesc = dMesc + tt-mensal.vl-mes
               dEspc = dEspc + tt-mensal.vl-esp
               iCont = iCont + 1.

    END.
    FOR EACH conta WHERE conta.id-tipo = 2 NO-LOCK:
        FIND FIRST bfItem
            WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
            AND   bfItem.cod-categoria = 997
            AND   bfItem.cd-sub = conta.cd-conta NO-LOCK NO-ERROR.
        IF AVAIL bfItem THEN DO:

            CREATE tt-mensal.
            ASSIGN tt-mensal.cod = iCont
                   tt-mensal.descricao = "     " + conta.ds-conta
                   tt-mensal.vl-mes = bfItem.vl-mes
                   tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                      bfItem.vl-espontaneo[2] +
                                      bfItem.vl-espontaneo[3] +
                                      bfItem.vl-espontaneo[4] +
                                      bfItem.vl-espontaneo[5] +
                                      bfItem.vl-espontaneo[6] +
                                      bfItem.vl-espontaneo[7] +
                                      bfItem.vl-espontaneo[8] +
                                      bfItem.vl-espontaneo[9] +
                                      bfItem.vl-espontaneo[10] +
                                      bfItem.vl-espontaneo[11] +
                                      bfItem.vl-espontaneo[12] +
                                      (12 * bfItem.vl-mes)
                   dMesc = dMesc + tt-mensal.vl-mes
                   dEspc = dEspc + tt-mensal.vl-esp
                   iCont = iCont + 1.

        END.
    END.
    FIND FIRST tt-mensal WHERE tt-mensal.cod = iCat.
    ASSIGN tt-mensal.vl-mes = dMesc
           tt-mensal.vl-esp = dEspc.

    /* Despesas */

    CREATE tt-mensal.
    ASSIGN tt-mensal.cod = iCont
           iCont = iCont + 1.

    CREATE tt-mensal.
    ASSIGN tt-mensal.cod = iCont
           tt-mensal.descricao = "DESPESAS"
           iCont = iCont + 1
           iCat = tt-mensal.cod
           dMesc = 0
           dEspc = 0.

    FOR EACH categoria NO-LOCK
        WHERE categoria.id-tipo = 2
        BY categoria.ds-categoria:

        IF CAN-FIND(FIRST bfItem
                    WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria) THEN DO:

            CREATE tt-mensal.
            ASSIGN tt-mensal.cod = iCont
                   tt-mensal.descricao = "     " + categoria.ds-categoria
                   iCont = iCont + 1
                   deMes = 0
                   deEsp = 0
                   iTemp = tt-mensal.cod.

            FOR EACH sub-cat OF categoria NO-LOCK
                BY sub-cat.ds-sub:

                FIND FIRST bfItem
                    WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
                    AND   bfItem.cod-categoria = categoria.cod-categoria
                    AND   bfItem.cd-sub = sub-cat.cd-sub NO-LOCK NO-ERROR.
                IF AVAIL bfItem THEN DO:

                    CREATE tt-mensal.
                    ASSIGN tt-mensal.cod = iCont
                           tt-mensal.descricao = "          " + sub-cat.ds-sub
                           tt-mensal.vl-mes = bfItem.vl-mes
                           tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                              bfItem.vl-espontaneo[2] +
                                              bfItem.vl-espontaneo[3] +
                                              bfItem.vl-espontaneo[4] +
                                              bfItem.vl-espontaneo[5] +
                                              bfItem.vl-espontaneo[6] +
                                              bfItem.vl-espontaneo[7] +
                                              bfItem.vl-espontaneo[8] +
                                              bfItem.vl-espontaneo[9] +
                                              bfItem.vl-espontaneo[10] +
                                              bfItem.vl-espontaneo[11] +
                                              bfItem.vl-espontaneo[12] +
                                              (12 * bfItem.vl-mes)
                           deMes = deMes + tt-mensal.vl-mes
                           deEsp = deEsp + tt-mensal.vl-esp
                           iCont = iCont + 1.

                END.

            END.
            FIND FIRST bfItem
                WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
                AND   bfItem.cod-categoria = categoria.cod-categoria
                AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
            IF AVAIL bfItem THEN DO:

                CREATE tt-mensal.
                ASSIGN tt-mensal.cod = iCont
                       tt-mensal.descricao = "          GERAL"
                       tt-mensal.vl-mes = bfItem.vl-mes
                       tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                          bfItem.vl-espontaneo[2] +
                                          bfItem.vl-espontaneo[3] +
                                          bfItem.vl-espontaneo[4] +
                                          bfItem.vl-espontaneo[5] +
                                          bfItem.vl-espontaneo[6] +
                                          bfItem.vl-espontaneo[7] +
                                          bfItem.vl-espontaneo[8] +
                                          bfItem.vl-espontaneo[9] +
                                          bfItem.vl-espontaneo[10] +
                                          bfItem.vl-espontaneo[11] +
                                          bfItem.vl-espontaneo[12] +
                                          (12 * bfItem.vl-mes)
                       deMes = deMes + tt-mensal.vl-mes
                       deEsp = deEsp + tt-mensal.vl-esp
                       iCont = iCont + 1.

            END.

            FIND FIRST tt-mensal WHERE tt-mensal.cod = iTemp.
            ASSIGN tt-mensal.vl-mes = deMes
                   tt-mensal.vl-esp = deEsp
                   dMesc = dMesc + deMes
                   dEspc = dEspc + deEsp.

        END.

    END.
    FIND FIRST bfItem
        WHERE bfItem.cd-orcamento = INPUT FRAME default-frame orcamento.cd-orcamento
        AND   bfItem.cod-categoria = 998
        AND   bfItem.cd-sub = 999 NO-LOCK NO-ERROR.
    IF AVAIL bfItem THEN DO:

        CREATE tt-mensal.
        ASSIGN tt-mensal.cod = iCont
               tt-mensal.descricao = "     OUTROS"
               tt-mensal.vl-mes = bfItem.vl-mes
               tt-mensal.vl-esp = bfItem.vl-espontaneo[1] +
                                  bfItem.vl-espontaneo[2] +
                                  bfItem.vl-espontaneo[3] +
                                  bfItem.vl-espontaneo[4] +
                                  bfItem.vl-espontaneo[5] +
                                  bfItem.vl-espontaneo[6] +
                                  bfItem.vl-espontaneo[7] +
                                  bfItem.vl-espontaneo[8] +
                                  bfItem.vl-espontaneo[9] +
                                  bfItem.vl-espontaneo[10] +
                                  bfItem.vl-espontaneo[11] +
                                  bfItem.vl-espontaneo[12] +
                                  (12 * bfItem.vl-mes)
               dMesc = dMesc + tt-mensal.vl-mes
               dEspc = dEspc + tt-mensal.vl-esp
               iCont = iCont + 1.

    END.

    FIND FIRST tt-mensal WHERE tt-mensal.cod = iCat.
    ASSIGN tt-mensal.vl-mes = dMesc
           tt-mensal.vl-esp = dEspc.

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

  IF AVAILABLE orcamento THEN 
    DISPLAY {&FrameFields}
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ELSE DO:
      ASSIGN orcamento.cd-orcamento:SCREEN-VALUE = ""
             orcamento.ds-orcamento:SCREEN-VALUE = "".
  END.
  DISPLAY res-mensal
          res-anual WITH FRAME fPage4.
  RUN recalcula.
  {&OPEN-QUERY-brAnual}
  APPLY "VALUE-CHANGED" TO brAnual IN FRAME fPage5.
  {&OPEN-QUERY-brMensal}
  APPLY "VALUE-CHANGED" TO brMensal IN FRAME fPage3.

      
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
  DISPLAY select-frame 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE orcamento THEN 
    DISPLAY orcamento.cd-orcamento orcamento.ds-orcamento orcamento.ano 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCopy btAdd btCancel btDelete btFirst btLast btNext btPrev btSave 
         btUpdate select-frame orcamento.cd-orcamento orcamento.ds-orcamento 
         orcamento.ano btExit RECT-1 RECT-6 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY cat sub 
      WITH FRAME fPage1 IN WINDOW C-Win.
  IF AVAILABLE item-orcamento THEN 
    DISPLAY item-orcamento.vl-mes item-orcamento.vl-espontaneo[1] 
          item-orcamento.vl-espontaneo[2] item-orcamento.vl-espontaneo[3] 
          item-orcamento.vl-espontaneo[4] item-orcamento.vl-espontaneo[5] 
          item-orcamento.vl-espontaneo[6] item-orcamento.vl-espontaneo[7] 
          item-orcamento.vl-espontaneo[8] item-orcamento.vl-espontaneo[9] 
          item-orcamento.vl-espontaneo[10] item-orcamento.vl-espontaneo[11] 
          item-orcamento.vl-espontaneo[12] 
      WITH FRAME fPage1 IN WINDOW C-Win.
  ENABLE btElim btInc cat sub item-orcamento.vl-mes 
         item-orcamento.vl-espontaneo[1] item-orcamento.vl-espontaneo[2] 
         item-orcamento.vl-espontaneo[3] item-orcamento.vl-espontaneo[4] 
         item-orcamento.vl-espontaneo[5] item-orcamento.vl-espontaneo[6] 
         item-orcamento.vl-espontaneo[7] item-orcamento.vl-espontaneo[8] 
         item-orcamento.vl-espontaneo[9] item-orcamento.vl-espontaneo[10] 
         item-orcamento.vl-espontaneo[11] item-orcamento.vl-espontaneo[12] 
         RECT-3 
      WITH FRAME fPage1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage1}
  DISPLAY contas vl-poup 
      WITH FRAME fPage2 IN WINDOW C-Win.
  IF AVAILABLE item-orcamento THEN 
    DISPLAY item-orcamento.vl-mes item-orcamento.vl-espontaneo[1] 
          item-orcamento.vl-espontaneo[2] item-orcamento.vl-espontaneo[3] 
          item-orcamento.vl-espontaneo[4] item-orcamento.vl-espontaneo[5] 
          item-orcamento.vl-espontaneo[6] item-orcamento.vl-espontaneo[7] 
          item-orcamento.vl-espontaneo[8] item-orcamento.vl-espontaneo[9] 
          item-orcamento.vl-espontaneo[10] item-orcamento.vl-espontaneo[11] 
          item-orcamento.vl-espontaneo[12] 
      WITH FRAME fPage2 IN WINDOW C-Win.
  ENABLE brPoup btElimp btIncp contas vl-poup item-orcamento.vl-mes 
         item-orcamento.vl-espontaneo[1] item-orcamento.vl-espontaneo[2] 
         item-orcamento.vl-espontaneo[3] item-orcamento.vl-espontaneo[4] 
         item-orcamento.vl-espontaneo[5] item-orcamento.vl-espontaneo[6] 
         item-orcamento.vl-espontaneo[7] item-orcamento.vl-espontaneo[8] 
         item-orcamento.vl-espontaneo[9] item-orcamento.vl-espontaneo[10] 
         item-orcamento.vl-espontaneo[11] item-orcamento.vl-espontaneo[12] 
         RECT-4 
      WITH FRAME fPage2 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage2}
  ENABLE brMensal 
      WITH FRAME fPage3 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage3}
  ENABLE brAnual 
      WITH FRAME fPage5 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage5}
  DISPLAY res-mensal mensal res-anual anual 
      WITH FRAME fPage4 IN WINDOW C-Win.
  ENABLE RECT-5 res-mensal mensal res-anual anual 
      WITH FRAME fPage4 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage4}
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

  ASSIGN select-frame:SCREEN-VALUE IN FRAME default-frame = "Resumo Anual".
  APPLY "VALUE-CHANGED":U TO select-frame IN FRAME default-frame.  

  FIND LAST orcamento WHERE orcamento.ano = YEAR(TODAY) NO-LOCK NO-ERROR.

  RUN displayFields.
  ENABLE btFirst btLast btNext btPrev btAdd btUpdate btDelete RECT-1 select-frame btExit
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.

  ENABLE cat
         sub WITH FRAME fPage1.

  ENABLE brPoup
         contas WITH FRAME fPage2.

  ENABLE brMensal WITH FRAME fPage3.
  ENABLE brAnual WITH FRAME fPage5.

  ENABLE btCopy WITH FRAME {&FRAME-NAME}.

  IF NOT AVAIL orcamento THEN
    APPLY "CHOOSE" TO btFirst.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalcula C-Win 
PROCEDURE recalcula :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

RUN criaTTMensal.
RUN criaTTAnual.
FIND FIRST tt-mensal WHERE tt-mensal.descricao = "RECEITAS".
ASSIGN mensal = tt-mensal.vl-mes
       anual = tt-mensal.vl-esp.
FIND FIRST tt-mensal WHERE tt-mensal.descricao = "CONTRIBUIÄÂES ∑ POUPANÄA".
ASSIGN mensal = mensal - tt-mensal.vl-mes
       anual = anual - tt-mensal.vl-esp.
FIND FIRST tt-mensal WHERE tt-mensal.descricao = "DESPESAS".
ASSIGN mensal = mensal - tt-mensal.vl-mes
       anual = anual - tt-mensal.vl-esp.
DISPLAY mensal
        anual WITH FRAME fPage4.
IF mensal < 0 THEN
    ASSIGN mensal:FGCOLOR IN FRAME fPage4 = 4
           mensal:TOOLTIP = "CUIDADO! Vocà est† gastando mais do que recebendo!".
ELSE                                         
    ASSIGN mensal:FGCOLOR IN FRAME fPage4 = 1
           mensal:TOOLTIP = "Oráamento est†vel. Verifique o valor anual!".

FIND FIRST tt-mensal WHERE tt-mensal.descricao = "CONTRIBUIÄÂES ∑ POUPANÄA".
IF anual < 0 THEN
    IF (tt-mensal.vl-esp - anual) < 0 THEN
        ASSIGN anual:FGCOLOR IN FRAME fPage4 = 4
               anual:TOOLTIP = "Vocà est† gastando mais do que recebendo!".
    ELSE
        ASSIGN anual:FGCOLOR IN FRAME fPage4 = 3
               anual:TOOLTIP = "A sua poupanáa est† cobrindo os seus gastos!".
ELSE                                         
    ASSIGN anual:FGCOLOR IN FRAME fPage4 = 1
           anual:TOOLTIP = "‡TIMO! Vocà est† gastando menos do que recebendo!".

{&OPEN-QUERY-brAnual}
{&OPEN-QUERY-brMensal}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setarDados C-Win 
PROCEDURE setarDados :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER cFav AS CHARACTER  NO-UNDO.

ASSIGN iorcamento = 0.

APPLY "CHOOSE" TO btAdd IN FRAME default-frame.
DISABLE btCancel WITH FRAME default-frame.

ASSIGN orcamento.ds-orcamento = cFav.
DISPLAY orcamento.ds-orcamento WITH FRAME default-frame.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

