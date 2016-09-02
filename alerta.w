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

&GLOBAL-DEFINE FrameFields  alerta.ativo alerta.ponto[1] alerta.ponto[2] alerta.ponto[3]
&GLOBAL-DEFINE Frame1Fields alerta.num-dias alerta.valor-minimo ~
                            alerta.percentual alerta.periodo ~
                            alerta.valor-maximo
&GLOBAL-DEFINE Frame2Fields alerta.valor-maximo alerta.valor-minimo

DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO.

DEFINE VARIABLE cCat AS CHARACTER COLUMN-LABEL "Categoria" FORMAT "X(20)" NO-UNDO.
DEFINE VARIABLE cSub AS CHARACTER COLUMN-LABEL "Sub-Categoria" FORMAT "X(20)" NO-UNDO.
DEFINE VARIABLE cFav AS CHARACTER COLUMN-LABEL "Favorecido" FORMAT "X(20)" NO-UNDO.
DEFINE VARIABLE cConta AS CHARACTER COLUMN-LABEL "Conta" FORMAT "X(40)" NO-UNDO.
DEFINE VARIABLE cPer AS CHARACTER COLUMN-LABEL "Per°odo" FORMAT "X(8)" NO-UNDO.

{seg.i}

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brExc1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES alerta-exc

/* Definitions for BROWSE brExc1                                        */
&Scoped-define FIELDS-IN-QUERY-brExc1 ~
fnDesc("C",alerta-exc.cod-categoria,0) @ cCat ~
fnDesc("S",alerta-exc.cod-categoria,alerta-exc.cd-sub) @ cSub ~
fnDesc("F",alerta-exc.cd-favorecido,0) @ cFav alerta-exc.outro-valor ~
alerta-exc.valor-minimo alerta-exc.num-dias alerta-exc.percentual ~
fnDesc("P",alerta-exc.periodo,0) @ cPer 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brExc1 
&Scoped-define QUERY-STRING-brExc1 FOR EACH alerta-exc OF alerta NO-LOCK
&Scoped-define OPEN-QUERY-brExc1 OPEN QUERY brExc1 FOR EACH alerta-exc OF alerta NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brExc1 alerta-exc
&Scoped-define FIRST-TABLE-IN-QUERY-brExc1 alerta-exc


/* Definitions for BROWSE brExc2                                        */
&Scoped-define FIELDS-IN-QUERY-brExc2 ~
fnDesc("CT",alerta-exc.cd-conta,0) @ cConta alerta-exc.outro-valor ~
alerta-exc.valor-minimo alerta-exc.valor-maximo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brExc2 
&Scoped-define QUERY-STRING-brExc2 FOR EACH alerta-exc OF alerta NO-LOCK
&Scoped-define OPEN-QUERY-brExc2 OPEN QUERY brExc2 FOR EACH alerta-exc OF alerta NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brExc2 alerta-exc
&Scoped-define FIRST-TABLE-IN-QUERY-brExc2 alerta-exc


/* Definitions for FRAME fPage1                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage1 ~
    ~{&OPEN-QUERY-brExc1}

/* Definitions for FRAME fPage2                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fPage2 ~
    ~{&OPEN-QUERY-brExc2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS alerta.ativo alerta.ponto[1] alerta.ponto[2] ~
alerta.ponto[3] 
&Scoped-define ENABLED-TABLES alerta
&Scoped-define FIRST-ENABLED-TABLE alerta
&Scoped-Define ENABLED-OBJECTS btSave RECT-1 RECT-6 tipo btExit 
&Scoped-Define DISPLAYED-FIELDS alerta.ativo alerta.ponto[1] ~
alerta.ponto[2] alerta.ponto[3] 
&Scoped-define DISPLAYED-TABLES alerta
&Scoped-define FIRST-DISPLAYED-TABLE alerta
&Scoped-Define DISPLAYED-OBJECTS tipo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnDesc C-Win 
FUNCTION fnDesc RETURNS CHARACTER
  ( cOque AS CHARACTER, Cod1 AS INTEGER, Cod2 AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btSave 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Save" 
     SIZE 6.14 BY 1.79 TOOLTIP "Salvar".

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 43 BY 2.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 72.43 BY 2.25.

DEFINE VARIABLE tipo AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE 
     LIST-ITEMS "Agendamentos Vencidos","Agendamentos a Vencer","Saldos","Valor Planejado","Controle de Valor","Operaá‰es Especiais" 
     SIZE 27 BY 3.5 NO-UNDO.

DEFINE BUTTON btAdd1 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Adicionar" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btDel1 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btMod1 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6 BY 1.79.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 15 BY 2.58.

DEFINE BUTTON btAdd2 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Adicionar" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btDel2 
     IMAGE-UP FILE "image/im-era.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-era.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Eliminar" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btMod2 
     IMAGE-UP FILE "image/im-mod.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mod.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Modificar" 
     SIZE 6 BY 1.79.

DEFINE VARIABLE tx-help AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 37 BY 5 NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 31 BY 4.25.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 31 BY 5.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 37 BY 4.25.

DEFINE VARIABLE rel-1 AS LOGICAL INITIAL yes 
     LABEL "Patrimìnio Di†rio" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-10 AS LOGICAL INITIAL yes 
     LABEL "Previs∆o de Saldo" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-11 AS LOGICAL INITIAL yes 
     LABEL "Gr†fico Patrimìnio Anual" 
     VIEW-AS TOGGLE-BOX
     SIZE 20 BY .83 NO-UNDO.

DEFINE VARIABLE rel-12 AS LOGICAL INITIAL yes 
     LABEL "Gr†fico Custos Anuais" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-13 AS LOGICAL INITIAL yes 
     LABEL "Gr†fico Patrimìnio Total" 
     VIEW-AS TOGGLE-BOX
     SIZE 20 BY .83 NO-UNDO.

DEFINE VARIABLE rel-14 AS LOGICAL INITIAL yes 
     LABEL "Acompanhamento Poupanáa" 
     VIEW-AS TOGGLE-BOX
     SIZE 23 BY .83 NO-UNDO.

DEFINE VARIABLE rel-15 AS LOGICAL INITIAL yes 
     LABEL "Acompanhamento de Oráamento" 
     VIEW-AS TOGGLE-BOX
     SIZE 26 BY .83 NO-UNDO.

DEFINE VARIABLE rel-16 AS LOGICAL INITIAL yes 
     LABEL "Lista de Compras" 
     VIEW-AS TOGGLE-BOX
     SIZE 15 BY .83 NO-UNDO.

DEFINE VARIABLE rel-2 AS LOGICAL INITIAL yes 
     LABEL "Balanáo Mensal" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-3 AS LOGICAL INITIAL yes 
     LABEL "Fluxo de Caixa Mensal" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-4 AS LOGICAL INITIAL yes 
     LABEL "Extrato Mensal" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-5 AS LOGICAL INITIAL yes 
     LABEL "Relat¢rio Mensal" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-6 AS LOGICAL INITIAL yes 
     LABEL "Comparativo Mensal" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-7 AS LOGICAL INITIAL yes 
     LABEL "Balanáo Anual" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE rel-8 AS LOGICAL INITIAL yes 
     LABEL "Acompanhamento Balanáa Comercial" 
     VIEW-AS TOGGLE-BOX
     SIZE 29 BY .83 NO-UNDO.

DEFINE VARIABLE rel-9 AS LOGICAL INITIAL yes 
     LABEL "Relat¢rio Anual" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brExc1 FOR 
      alerta-exc SCROLLING.

DEFINE QUERY brExc2 FOR 
      alerta-exc SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brExc1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brExc1 C-Win _STRUCTURED
  QUERY brExc1 NO-LOCK DISPLAY
      fnDesc("C",alerta-exc.cod-categoria,0) @ cCat
      fnDesc("S",alerta-exc.cod-categoria,alerta-exc.cd-sub) @ cSub
      fnDesc("F",alerta-exc.cd-favorecido,0) @ cFav
      alerta-exc.outro-valor COLUMN-LABEL "Valor" FORMAT "Sim/N∆o":U
      alerta-exc.valor-minimo FORMAT "->>,>>9.99":U
      alerta-exc.num-dias FORMAT ">>9":U
      alerta-exc.percentual COLUMN-LABEL "Percentual" FORMAT "->>9.9999":U
      fnDesc("P",alerta-exc.periodo,0) @ cPer
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 70 BY 5
         FONT 1
         TITLE "Exceá‰es" FIT-LAST-COLUMN.

DEFINE BROWSE brExc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brExc2 C-Win _STRUCTURED
  QUERY brExc2 NO-LOCK DISPLAY
      fnDesc("CT",alerta-exc.cd-conta,0) @ cConta
      alerta-exc.outro-valor COLUMN-LABEL "Valor" FORMAT "Sim/N∆o":U
      alerta-exc.valor-minimo FORMAT "->>,>>9.99":U
      alerta-exc.valor-maximo FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 70 BY 5
         FONT 1
         TITLE "Exceá‰es".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btSave AT ROW 1.5 COL 3
     tipo AT ROW 3.75 COL 2 NO-LABEL
     alerta.ativo AT ROW 3.75 COL 31
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .75
     alerta.ponto[1] AT ROW 4.75 COL 45
          LABEL "Ao Iniciar"
          VIEW-AS TOGGLE-BOX
          SIZE 11.57 BY .83
     btExit AT ROW 1.5 COL 67.43
     alerta.ponto[2] AT ROW 5.5 COL 45
          LABEL "Incluir/Alterar Movimento"
          VIEW-AS TOGGLE-BOX
          SIZE 27 BY .83
     alerta.ponto[3] AT ROW 6.25 COL 45
          LABEL "Calcular Saldo"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .83
     RECT-1 AT ROW 4.5 COL 31
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 74.29 BY 16.71
         FONT 1.

DEFINE FRAME fPage2
     btAdd2 AT ROW 9 COL 2
     alerta.valor-minimo AT ROW 1.5 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     alerta.valor-maximo AT ROW 2.5 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     brExc2 AT ROW 4 COL 2
     btDel2 AT ROW 9 COL 14.29
     btMod2 AT ROW 9 COL 8.14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 7.5
         SIZE 72 BY 10
         FONT 1.

DEFINE FRAME fPage1
     btAdd1 AT ROW 9 COL 2
     alerta.valor-minimo AT ROW 1.5 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     alerta.percentual AT ROW 1.5 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.43 BY .79
     alerta.periodo AT ROW 1.5 COL 54.57 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Mensal", 1,
"Anual", 2,
"No Per°odo", 3
          SIZE 11.43 BY 2.17
     alerta.valor-maximo AT ROW 2.5 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     alerta.num-dias AT ROW 2.5 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     brExc1 AT ROW 4 COL 2
     btDel1 AT ROW 9 COL 14.29
     btMod1 AT ROW 9 COL 8.14
     RECT-5 AT ROW 1.25 COL 53
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 7.5
         SIZE 72 BY 10
         FONT 1.

DEFINE FRAME fPage3
     rel-2 AT ROW 1.5 COL 4
     rel-3 AT ROW 2.25 COL 4
     rel-4 AT ROW 3 COL 4
     rel-5 AT ROW 3.75 COL 4
     rel-6 AT ROW 4.5 COL 4
     rel-7 AT ROW 6 COL 4
     rel-8 AT ROW 6.75 COL 4
     rel-9 AT ROW 7.5 COL 4
     rel-11 AT ROW 8.25 COL 4
     rel-12 AT ROW 9 COL 4
     rel-13 AT ROW 9.75 COL 4
     rel-1 AT ROW 1.5 COL 36
     rel-10 AT ROW 2.25 COL 36
     rel-14 AT ROW 3 COL 36
     rel-15 AT ROW 3.75 COL 36
     tx-help AT ROW 5.75 COL 35 NO-LABEL
     rel-16 AT ROW 4.5 COL 36
     RECT-7 AT ROW 1.25 COL 3
     RECT-8 AT ROW 5.75 COL 3
     RECT-9 AT ROW 1.25 COL 35
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 7.5
         SIZE 72 BY 10
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
         TITLE              = "Alertas"
         HEIGHT             = 16.71
         WIDTH              = 74.29
         MAX-HEIGHT         = 19.42
         MAX-WIDTH          = 74.29
         VIRTUAL-HEIGHT     = 19.42
         VIRTUAL-WIDTH      = 74.29
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
       FRAME fPage3:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR TOGGLE-BOX alerta.ponto[1] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX alerta.ponto[2] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX alerta.ponto[3] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FRAME fPage1
                                                                        */
/* BROWSE-TAB brExc1 num-dias fPage1 */
ASSIGN 
       brExc1:COLUMN-RESIZABLE IN FRAME fPage1       = TRUE
       brExc1:COLUMN-MOVABLE IN FRAME fPage1         = TRUE.

/* SETTINGS FOR FRAME fPage2
                                                                        */
/* BROWSE-TAB brExc2 valor-maximo fPage2 */
ASSIGN 
       brExc2:COLUMN-RESIZABLE IN FRAME fPage2       = TRUE
       brExc2:COLUMN-MOVABLE IN FRAME fPage2         = TRUE.

/* SETTINGS FOR FRAME fPage3
   Custom                                                               */
ASSIGN 
       tx-help:READ-ONLY IN FRAME fPage3        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brExc1
/* Query rebuild information for BROWSE brExc1
     _TblList          = "money.alerta-exc OF money.alerta"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > "_<CALC>"
"fnDesc(""C"",alerta-exc.cod-categoria,0) @ cCat" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > "_<CALC>"
"fnDesc(""S"",alerta-exc.cod-categoria,alerta-exc.cd-sub) @ cSub" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > "_<CALC>"
"fnDesc(""F"",alerta-exc.cd-favorecido,0) @ cFav" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > money.alerta-exc.outro-valor
"alerta-exc.outro-valor" "Valor" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   = money.alerta-exc.valor-minimo
     _FldNameList[6]   = money.alerta-exc.num-dias
     _FldNameList[7]   > money.alerta-exc.percentual
"alerta-exc.percentual" "Percentual" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > "_<CALC>"
"fnDesc(""P"",alerta-exc.periodo,0) @ cPer" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE brExc1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brExc2
/* Query rebuild information for BROWSE brExc2
     _TblList          = "money.alerta-exc OF money.alerta"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > "_<CALC>"
"fnDesc(""CT"",alerta-exc.cd-conta,0) @ cConta" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > money.alerta-exc.outro-valor
"alerta-exc.outro-valor" "Valor" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   = money.alerta-exc.valor-minimo
     _FldNameList[4]   = money.alerta-exc.valor-maximo
     _Query            is OPENED
*/  /* BROWSE brExc2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Alertas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Alertas */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta.ativo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.ativo C-Win
ON VALUE-CHANGED OF alerta.ativo IN FRAME DEFAULT-FRAME /* Ativo */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brExc1
&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME brExc1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brExc1 C-Win
ON DELETE-CHARACTER OF brExc1 IN FRAME fPage1 /* Exceá‰es */
DO:

    APPLY "CHOOSE" TO btDel1 IN FRAME fPage1.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brExc1 C-Win
ON MOUSE-SELECT-DBLCLICK OF brExc1 IN FRAME fPage1 /* Exceá‰es */
DO:

    APPLY "CHOOSE" TO btMod1 IN FRAME fPage1.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brExc2
&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME brExc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brExc2 C-Win
ON DELETE-CHARACTER OF brExc2 IN FRAME fPage2 /* Exceá‰es */
DO:

    APPLY "CHOOSE" TO btDel2 IN FRAME fPage2.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brExc2 C-Win
ON MOUSE-SELECT-DBLCLICK OF brExc2 IN FRAME fPage2 /* Exceá‰es */
DO:
  
    APPLY "CHOOSE" TO btMod2 IN FRAME fPage2.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btAdd1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd1 C-Win
ON CHOOSE OF btAdd1 IN FRAME fPage1 /* Adicionar */
DO:
  
    {func\run.i &Programa = "alerta-exc.w (INPUT ROWID(alerta), INPUT ?)"}
    {&OPEN-QUERY-brExc1}
    RUN controlButtons IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btAdd2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAdd2 C-Win
ON CHOOSE OF btAdd2 IN FRAME fPage2 /* Adicionar */
DO:
  
    {func\run.i &Programa = "alerta-exc.w (INPUT ROWID(alerta), INPUT ?)"}
    {&OPEN-QUERY-brExc2}
    RUN controlButtons IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btDel1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel1 C-Win
ON CHOOSE OF btDel1 IN FRAME fPage1 /* Eliminar */
DO:
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
    IF RETURN-VALUE = "OK" THEN DO:
        FIND CURRENT alerta-exc EXCLUSIVE-LOCK.
        DELETE alerta-exc.
        {&OPEN-QUERY-brExc1}
    END.
    RUN controlButtons IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btDel2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDel2 C-Win
ON CHOOSE OF btDel2 IN FRAME fPage2 /* Eliminar */
DO:
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Eliminaá∆o de Registro (002)', INPUT 'Confirma ?', INPUT 'Confirma eliminaá∆o do registro ?')"}
    IF RETURN-VALUE = "OK" THEN DO:
        FIND CURRENT alerta-exc EXCLUSIVE-LOCK.
        DELETE alerta-exc.
        {&OPEN-QUERY-brExc2}
    END.
    RUN controlButtons IN THIS-PROCEDURE.

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


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME btMod1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMod1 C-Win
ON CHOOSE OF btMod1 IN FRAME fPage1 /* Modificar */
DO:
  
    {func\run.i &Programa = "alerta-exc.w (INPUT ROWID(alerta), INPUT ROWID(alerta-exc))"}
    {&OPEN-QUERY-brExc1}
    RUN controlButtons IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME btMod2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btMod2 C-Win
ON CHOOSE OF btMod2 IN FRAME fPage2 /* Modificar */
DO:
  
    {func\run.i &Programa = "alerta-exc.w (INPUT ROWID(alerta), INPUT ROWID(alerta-exc))"}
    {&OPEN-QUERY-brExc2}
    RUN controlButtons IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME btSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSave C-Win
ON CHOOSE OF btSave IN FRAME DEFAULT-FRAME /* Save */
DO:
    RUN som.p(INPUT "music\click.wav").
    FIND CURRENT alerta EXCLUSIVE-LOCK.
    CASE iTipo:
        WHEN 1 THEN DO:
            ASSIGN INPUT FRAME fPage1 {&Frame1Fields}.
            ASSIGN INPUT FRAME default-frame {&FrameFields}.
        END.
        WHEN 2 THEN DO:
            ASSIGN INPUT FRAME fPage1 {&Frame1Fields}.
            ASSIGN INPUT FRAME default-frame {&FrameFields}.
        END.
        WHEN 3 THEN DO:
            ASSIGN INPUT FRAME fPage2 {&Frame2Fields}.
            ASSIGN INPUT FRAME default-frame {&FrameFields}.
        END.
        WHEN 4 THEN DO:
            ASSIGN INPUT FRAME fPage1 {&Frame1Fields}.
            ASSIGN INPUT FRAME default-frame {&FrameFields}.
        END.
        WHEN 5 THEN DO:
            ASSIGN INPUT FRAME default-frame {&FrameFields}.
            ASSIGN alerta.valor-minimo = INPUT FRAME fPage1 alerta.valor-minimo.
            ASSIGN alerta.valor-maximo = INPUT FRAME fPage1 alerta.valor-maximo.
        END.
        WHEN 6 THEN DO:
            ASSIGN INPUT FRAME default-frame {&FrameFields}.
        END.
    END CASE.
    ENABLE tipo WITH FRAME default-frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME alerta.num-dias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.num-dias C-Win
ON ENTRY OF alerta.num-dias IN FRAME fPage1 /* Quantidade de Dias */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.num-dias C-Win
ON LEAVE OF alerta.num-dias IN FRAME fPage1 /* Quantidade de Dias */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.num-dias C-Win
ON VALUE-CHANGED OF alerta.num-dias IN FRAME fPage1 /* Quantidade de Dias */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta.percentual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.percentual C-Win
ON ENTRY OF alerta.percentual IN FRAME fPage1 /* Percentual */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.percentual C-Win
ON LEAVE OF alerta.percentual IN FRAME fPage1 /* Percentual */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.percentual C-Win
ON VALUE-CHANGED OF alerta.percentual IN FRAME fPage1 /* Percentual */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta.periodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.periodo C-Win
ON VALUE-CHANGED OF alerta.periodo IN FRAME fPage1 /* Per */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME alerta.ponto[1]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.ponto[1] C-Win
ON VALUE-CHANGED OF alerta.ponto[1] IN FRAME DEFAULT-FRAME /* Ao Iniciar */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta.ponto[2]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.ponto[2] C-Win
ON VALUE-CHANGED OF alerta.ponto[2] IN FRAME DEFAULT-FRAME /* Incluir/Alterar Movimento */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta.ponto[3]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.ponto[3] C-Win
ON VALUE-CHANGED OF alerta.ponto[3] IN FRAME DEFAULT-FRAME /* Calcular Saldo */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage3
&Scoped-define SELF-NAME rel-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-1 C-Win
ON ENTRY OF rel-1 IN FRAME fPage3 /* Patrimìnio Di†rio */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta o patrimìnio do dia.".
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-1 C-Win
ON VALUE-CHANGED OF rel-1 IN FRAME fPage3 /* Patrimìnio Di†rio */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 1 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 1.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-10 C-Win
ON ENTRY OF rel-10 IN FRAME fPage3 /* Previs∆o de Saldo */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta a previs∆o de saldo para os pr¢ximos 30 dias.".
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-10 C-Win
ON VALUE-CHANGED OF rel-10 IN FRAME fPage3 /* Previs∆o de Saldo */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 10 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 10.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-10.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-11 C-Win
ON ENTRY OF rel-11 IN FRAME fPage3 /* Gr†fico Patrimìnio Anual */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um gr†fico do patrimìnio ao longo do ano." + CHR(10) +
                                  "Dias 4, 16, 26 e 30".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-11 C-Win
ON VALUE-CHANGED OF rel-11 IN FRAME fPage3 /* Gr†fico Patrimìnio Anual */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 11 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 11.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-11.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-12 C-Win
ON ENTRY OF rel-12 IN FRAME fPage3 /* Gr†fico Custos Anuais */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um resumo dos custos ao longo do ano." + CHR(10) +
                                  "Dias 3, 10, 17, 24 e 30".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-12 C-Win
ON VALUE-CHANGED OF rel-12 IN FRAME fPage3 /* Gr†fico Custos Anuais */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 12 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 12.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-12.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-13 C-Win
ON ENTRY OF rel-13 IN FRAME fPage3 /* Gr†fico Patrimìnio Total */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um gr†fico da evoluá∆o patrimonial (bens e financeira) nos £ltimos 12 meses." + CHR(10) +
                                  "Dias 6, 19 e 27".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-13 C-Win
ON VALUE-CHANGED OF rel-13 IN FRAME fPage3 /* Gr†fico Patrimìnio Total */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 13 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 13.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-13.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-14 C-Win
ON ENTRY OF rel-14 IN FRAME fPage3 /* Acompanhamento Poupanáa */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta o acompanhamento da poupanáa principal." + CHR(10) +
                                  "Dias 6, 14, 21 e 28".
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-14 C-Win
ON VALUE-CHANGED OF rel-14 IN FRAME fPage3 /* Acompanhamento Poupanáa */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 14 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 14.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-14.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-15 C-Win
ON ENTRY OF rel-15 IN FRAME fPage3 /* Acompanhamento de Oráamento */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta o acompanhamento do £ltimo oráamento do ano." + CHR(10) +
                                  "Dias 1, 5, 9, 13, 17, 21, 25 e 29".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-15 C-Win
ON VALUE-CHANGED OF rel-15 IN FRAME fPage3 /* Acompanhamento de Oráamento */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 15 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 15.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-15.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-16
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-16 C-Win
ON ENTRY OF rel-16 IN FRAME fPage3 /* Lista de Compras */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta uma lista de compra dos itens que est∆o em seu per°odo de reposiá∆o.".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-16 C-Win
ON VALUE-CHANGED OF rel-16 IN FRAME fPage3 /* Lista de Compras */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 16 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 16.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-16.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-2 C-Win
ON ENTRY OF rel-2 IN FRAME fPage3 /* Balanáo Mensal */
DO:
  ASSIGN tx-help:SCREEN-VALUE = "Apresenta um resumo semanal dos gastos." + CHR(10) +
                                "Dias 1, 8, 15, 22 e 30".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-2 C-Win
ON VALUE-CHANGED OF rel-2 IN FRAME fPage3 /* Balanáo Mensal */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 2 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 2.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-2.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-3 C-Win
ON ENTRY OF rel-3 IN FRAME fPage3 /* Fluxo de Caixa Mensal */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta os movimentos de entrada e sa°da da conta principal." + CHR(10) +
                                  "Dias 5, 10, 15, 20, 25 e 30".  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-3 C-Win
ON VALUE-CHANGED OF rel-3 IN FRAME fPage3 /* Fluxo de Caixa Mensal */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 3 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 3.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-3.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-4 C-Win
ON ENTRY OF rel-4 IN FRAME fPage3 /* Extrato Mensal */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Extrato banc†rio da conta principal." + CHR(10) +
                                  "Dias 1 e 16".  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-4 C-Win
ON VALUE-CHANGED OF rel-4 IN FRAME fPage3 /* Extrato Mensal */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 4 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 4.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-4.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-5 C-Win
ON ENTRY OF rel-5 IN FRAME fPage3 /* Relat¢rio Mensal */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um resumo do màs anterior." + CHR(10) +
                                  "Dias 1 a 5".    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-5 C-Win
ON VALUE-CHANGED OF rel-5 IN FRAME fPage3 /* Relat¢rio Mensal */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 5 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 5.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-5.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-6 C-Win
ON ENTRY OF rel-6 IN FRAME fPage3 /* Comparativo Mensal */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um comparativo do màs atual com o anterior e o mesmo màs no ano anterior." + CHR(10) +
                                  "Dias 1 e 18".  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-6 C-Win
ON VALUE-CHANGED OF rel-6 IN FRAME fPage3 /* Comparativo Mensal */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 6 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 6.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-6.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-7 C-Win
ON ENTRY OF rel-7 IN FRAME fPage3 /* Balanáo Anual */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um resumo mensal dos gastos." + CHR(10) +
                                  "Dia 6 e 28".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-7 C-Win
ON VALUE-CHANGED OF rel-7 IN FRAME fPage3 /* Balanáo Anual */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 7 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 7.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-7.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-8 C-Win
ON ENTRY OF rel-8 IN FRAME fPage3 /* Acompanhamento Balanáa Comercial */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um acompanhamento da relaá∆o gastos X recebimento mensal, trimestral, semestral e anual." + CHR(10) +
                                  "Dia 2 e 17".  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-8 C-Win
ON VALUE-CHANGED OF rel-8 IN FRAME fPage3 /* Acompanhamento Balanáa Comercial */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 8 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 8.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-8.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rel-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-9 C-Win
ON ENTRY OF rel-9 IN FRAME fPage3 /* Relat¢rio Anual */
DO:
    ASSIGN tx-help:SCREEN-VALUE = "Apresenta um resumo do ano corrente." + CHR(10) +
                                  "Dia 3 e 17".
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rel-9 C-Win
ON VALUE-CHANGED OF rel-9 IN FRAME fPage3 /* Relat¢rio Anual */
DO:
    FIND FIRST alerta-exc EXCLUSIVE-LOCK
        WHERE alerta-exc.tipo = 6
        AND   alerta-exc.usuario = gcUsuario
        AND   alerta-exc.cd-favorecido = 9 NO-ERROR.
    IF NOT AVAIL alerta-exc THEN DO:
        CREATE alerta-exc.
        ASSIGN alerta-exc.tipo = 6
               alerta-exc.usuario = gcUsuario
               alerta-exc.cd-favorecido = 9.               
    END.

    ASSIGN alerta-exc.outro-valor = INPUT FRAME fPage3 rel-9.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo C-Win
ON VALUE-CHANGED OF tipo IN FRAME DEFAULT-FRAME
DO:

    IF tipo <> "" THEN
        RUN som.p(INPUT "music\click.wav").

    HIDE FRAME fPage1.
    HIDE FRAME fPage2.
    HIDE FRAME fPage3.

    CASE INPUT FRAME default-frame tipo:
        WHEN "Agendamentos Vencidos" THEN DO:
            VIEW FRAME fPage1.
            ASSIGN iTipo = 1.
        END.
        WHEN "Agendamentos a Vencer" THEN DO:
            VIEW FRAME fPage1.
            ASSIGN iTipo = 2.
        END.
        WHEN "Saldos" THEN DO:
            VIEW FRAME fPage2.
            ASSIGN iTipo = 3.
        END.
        WHEN "Valor Planejado" THEN DO:
            VIEW FRAME fPage1.
            ASSIGN iTipo = 4.
        END.
        WHEN "Controle de Valor" THEN DO:
            VIEW FRAME fPage1.
            ASSIGN iTipo = 5.
        END.
        WHEN "Operaá‰es Especiais" THEN DO:
            VIEW FRAME fPage3.
            ASSIGN iTipo = 6.
        END.
    END CASE.

    FIND FIRST alerta 
        WHERE alerta.usuario = gcUsuario
        AND   alerta.tipo = iTipo EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAIL alerta THEN DO:
        CREATE alerta.
        ASSIGN alerta.usuario = gcUsuario
               alerta.tipo = iTipo.
    END.

    DISPLAY {&FrameFields} WITH FRAME default-frame.
    DISPLAY {&Frame1Fields} WITH FRAME fPage1.
    DISPLAY {&Frame2Fields} WITH FRAME fPage2.

    {&OPEN-QUERY-brExc1}
    {&OPEN-QUERY-brExc2}

    CASE iTipo:
        WHEN 1 THEN DO:
            ASSIGN alerta.num-dias:HIDDEN IN FRAME fPage1 = YES
                   alerta.percentual:HIDDEN IN FRAME fPage1 = YES
                   alerta.periodo:HIDDEN IN FRAME fPage1 = YES
                   alerta.valor-maximo:HIDDEN IN FRAME fPage1 = YES
                   rect-5:HIDDEN IN FRAME fPage1 = YES.
        END.
        WHEN 2 THEN DO:
            ASSIGN alerta.percentual:HIDDEN IN FRAME fPage1 = YES
                   alerta.periodo:HIDDEN IN FRAME fPage1 = YES
                   alerta.valor-maximo:HIDDEN IN FRAME fPage1 = YES
                   rect-5:HIDDEN IN FRAME fPage1 = YES.
        END.
        WHEN 4 THEN DO:
            ASSIGN alerta.num-dias:HIDDEN IN FRAME fPage1 = YES
                   alerta.valor-minimo:HIDDEN IN FRAME fPage1 = YES
                   alerta.valor-maximo:HIDDEN IN FRAME fPage1 = YES
                   rect-5:HIDDEN IN FRAME fPage1 = NO.
        END.
        WHEN 5 THEN DO:
            ASSIGN alerta.num-dias:HIDDEN IN FRAME fPage1 = YES
                   alerta.periodo:HIDDEN IN FRAME fPage1 = YES
                   alerta.percentual:HIDDEN IN FRAME fPage1 = YES
                   rect-5:HIDDEN IN FRAME fPage1 = YES.
        END.
    END CASE.

    RUN controlButtons IN THIS-PROCEDURE.

    ASSIGN INPUT FRAME {&FRAME-NAME} tipo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME alerta.valor-maximo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-maximo C-Win
ON ENTRY OF alerta.valor-maximo IN FRAME fPage2 /* Valor M†ximo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-maximo C-Win
ON LEAVE OF alerta.valor-maximo IN FRAME fPage2 /* Valor M†ximo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-maximo C-Win
ON VALUE-CHANGED OF alerta.valor-maximo IN FRAME fPage2 /* Valor M†ximo */
DO:

    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME alerta.valor-maximo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-maximo C-Win
ON ENTRY OF alerta.valor-maximo IN FRAME fPage1 /* Valor M†ximo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-maximo C-Win
ON LEAVE OF alerta.valor-maximo IN FRAME fPage1 /* Valor M†ximo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-maximo C-Win
ON VALUE-CHANGED OF alerta.valor-maximo IN FRAME fPage1 /* Valor M†ximo */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage2
&Scoped-define SELF-NAME alerta.valor-minimo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-minimo C-Win
ON ENTRY OF alerta.valor-minimo IN FRAME fPage2 /* Valor M°nimo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-minimo C-Win
ON LEAVE OF alerta.valor-minimo IN FRAME fPage2 /* Valor M°nimo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-minimo C-Win
ON VALUE-CHANGED OF alerta.valor-minimo IN FRAME fPage2 /* Valor M°nimo */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fPage1
&Scoped-define SELF-NAME alerta.valor-minimo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-minimo C-Win
ON ENTRY OF alerta.valor-minimo IN FRAME fPage1 /* Valor M°nimo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-minimo C-Win
ON LEAVE OF alerta.valor-minimo IN FRAME fPage1 /* Valor M°nimo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta.valor-minimo C-Win
ON VALUE-CHANGED OF alerta.valor-minimo IN FRAME fPage1 /* Valor M°nimo */
DO:
  
    DISABLE tipo WITH FRAME default-frame.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brExc1
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
  {version.i alerta}
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
DEFINE VARIABLE hTemp-results AS HANDLE     NO-UNDO.
DEFINE VARIABLE l-habilita AS LOGICAL    NO-UNDO.

IF iTipo = 3 THEN DO:
    ASSIGN hTemp-results = brExc2:QUERY IN FRAME fPage2.
    IF hTemp-results:NUM-RESULTS > 0 THEN DO:
        ENABLE btMod2
               btDel2 WITH FRAME fPage2.
    END.
    ELSE DO:
        DISABLE btMod2
                btDel2 WITH FRAME fPage2.
    END.
END.
ELSE DO:
    IF iTipo <> 6 THEN DO:
        ASSIGN hTemp-results = brExc1:QUERY IN FRAME fPage1.
        IF hTemp-results:NUM-RESULTS > 0 THEN DO:
            ENABLE btMod1
                   btDel1 WITH FRAME fPage1.
        END.
        ELSE DO:
            DISABLE btMod1
                    btDel1 WITH FRAME fPage1.
        END.
    END.
END.

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
  DISPLAY tipo 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE alerta THEN 
    DISPLAY alerta.ativo alerta.ponto[1] alerta.ponto[2] alerta.ponto[3] 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btSave RECT-1 RECT-6 tipo alerta.ativo alerta.ponto[1] btExit 
         alerta.ponto[2] alerta.ponto[3] 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  IF AVAILABLE alerta THEN 
    DISPLAY alerta.valor-minimo alerta.percentual alerta.periodo 
          alerta.valor-maximo alerta.num-dias 
      WITH FRAME fPage1 IN WINDOW C-Win.
  ENABLE btAdd1 RECT-5 alerta.valor-minimo alerta.percentual alerta.periodo 
         alerta.valor-maximo alerta.num-dias brExc1 btDel1 btMod1 
      WITH FRAME fPage1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage1}
  IF AVAILABLE alerta THEN 
    DISPLAY alerta.valor-minimo alerta.valor-maximo 
      WITH FRAME fPage2 IN WINDOW C-Win.
  ENABLE btAdd2 alerta.valor-minimo alerta.valor-maximo brExc2 btDel2 btMod2 
      WITH FRAME fPage2 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage2}
  DISPLAY rel-2 rel-3 rel-4 rel-5 rel-6 rel-7 rel-8 rel-9 rel-11 rel-12 rel-13 
          rel-1 rel-10 rel-14 rel-15 tx-help rel-16 
      WITH FRAME fPage3 IN WINDOW C-Win.
  ENABLE rel-2 rel-3 rel-4 rel-5 rel-6 rel-7 rel-8 rel-9 rel-11 rel-12 rel-13 
         rel-1 rel-10 rel-14 rel-15 tx-help rel-16 RECT-7 RECT-8 RECT-9 
      WITH FRAME fPage3 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fPage3}
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

ASSIGN tipo:SCREEN-VALUE IN FRAME default-frame = "Agendamentos Vencidos".
APPLY "VALUE-CHANGED" TO tipo IN FRAME default-frame.

ASSIGN rel-1 = NO
       rel-2 = NO
       rel-3 = NO
       rel-4 = NO
       rel-5 = NO
       rel-6 = NO
       rel-7 = NO
       rel-8 = NO
       rel-9 = NO
       rel-10 = NO
       rel-11 = NO
       rel-12 = NO
       rel-13 = NO
       rel-14 = NO
       rel-15 = NO.

FOR EACH alerta-exc NO-LOCK
    WHERE alerta-exc.tipo = 6
    AND   alerta-exc.usuario = gcUsuario
    AND   alerta-exc.outro-valor:

    CASE alerta-exc.cd-favorecido:
        WHEN 1 THEN ASSIGN rel-1 = YES.
        WHEN 2 THEN ASSIGN rel-2 = YES.
        WHEN 3 THEN ASSIGN rel-3 = YES.
        WHEN 4 THEN ASSIGN rel-4 = YES.
        WHEN 5 THEN ASSIGN rel-5 = YES.
        WHEN 6 THEN ASSIGN rel-6 = YES.
        WHEN 7 THEN ASSIGN rel-7 = YES.
        WHEN 8 THEN ASSIGN rel-8 = YES.
        WHEN 9 THEN ASSIGN rel-9 = YES.
        WHEN 10 THEN ASSIGN rel-10 = YES.
        WHEN 11 THEN ASSIGN rel-11 = YES.
        WHEN 12 THEN ASSIGN rel-12 = YES.
        WHEN 13 THEN ASSIGN rel-13 = YES.
        WHEN 14 THEN ASSIGN rel-14 = YES.
        WHEN 15 THEN ASSIGN rel-15 = YES.
    END CASE.

END.

DISPLAY rel-1
        rel-2
        rel-3
        rel-4
        rel-5
        rel-6
        rel-7
        rel-8
        rel-9
        rel-10
        rel-11
        rel-12
        rel-13
        rel-14
        rel-15 WITH FRAME fPage3.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnDesc C-Win 
FUNCTION fnDesc RETURNS CHARACTER
  ( cOque AS CHARACTER, Cod1 AS INTEGER, Cod2 AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.

    CASE cOque:
        WHEN "C" THEN DO:
            FIND FIRST categoria WHERE categoria.cod-categoria = Cod1 NO-LOCK NO-ERROR.
            IF AVAIL categoria THEN
                ASSIGN cReturn = categoria.ds-categoria.
        END.
        WHEN "F" THEN DO:
            FIND FIRST favorecido WHERE favorecido.cd-favorecido = Cod1 NO-LOCK NO-ERROR.
            IF AVAIL favorecido THEN
                ASSIGN cReturn = favorecido.ds-favorecido.
        END.
        WHEN "S" THEN DO:
            FIND FIRST sub-cat WHERE sub-cat.cod-categoria = Cod1 
                AND sub-cat.cd-sub = Cod2 NO-LOCK NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN cReturn = sub-cat.ds-sub.
        END.
        WHEN "CT" THEN DO:
            FIND FIRST conta WHERE conta.cd-conta = Cod1 NO-LOCK NO-ERROR.
            IF AVAIL conta THEN
                ASSIGN cReturn = conta.ds-conta.
        END.
        WHEN "P" THEN DO:
            IF Cod1 = 1 THEN
                ASSIGN cReturn = "Mensal".
            ELSE
                ASSIGN cReturn = "Anual".
        END.
    END CASE.

  RETURN cReturn.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

