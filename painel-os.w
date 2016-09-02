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

DEFINE BUFFER bf-tarefa FOR tarefa.
DEFINE BUFFER bf-os FOR ordem-serv.

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE r-tarefa AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-ordem-serv AS ROWID      NO-UNDO.

DEFINE VARIABLE dtFim AS DATE FORMAT "99/99/9999"    NO-UNDO.


DEFINE VARIABLE deApont AS DECIMAL COLUMN-LABEL "Apont"    NO-UNDO.
DEFINE VARIABLE cOS AS CHARACTER FORMAT "X(25)" COLUMN-LABEL "Nome"  NO-UNDO.

{campos\situacao.i}

DEFINE TEMP-TABLE tt-tarefa-1 NO-UNDO LIKE tarefa
    FIELD r-rowid AS ROWID.

DEFINE TEMP-TABLE tt-prioridade 
    FIELD prioridade AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br-os

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ordem-serv favorecido tarefa usuario

/* Definitions for BROWSE br-os                                         */
&Scoped-define FIELDS-IN-QUERY-br-os ordem-serv.num-os ~
favorecido.ds-favorecido ordem-serv.ds-os fnDataFim() @ dtFim 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-os 
&Scoped-define QUERY-STRING-br-os FOR EACH ordem-serv ~
      WHERE ordem-serv.situacao < 8 /* Conclu¡da */ NO-LOCK, ~
      EACH favorecido OF ordem-serv NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-os OPEN QUERY br-os FOR EACH ordem-serv ~
      WHERE ordem-serv.situacao < 8 /* Conclu¡da */ NO-LOCK, ~
      EACH favorecido OF ordem-serv NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-os ordem-serv favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-br-os ordem-serv
&Scoped-define SECOND-TABLE-IN-QUERY-br-os favorecido


/* Definitions for BROWSE br-tar                                        */
&Scoped-define FIELDS-IN-QUERY-br-tar tarefa.data-prev-ini tarefa.ds-tarefa ~
tarefa.responsavel tarefa.qtd-horas tarefa.qtd-lib ~
fnApont(tarefa.nome, tarefa.sequencia) @ deApont tarefa.perc-con ~
fnSituacaoTarefa(tarefa.situacao) @ cSituacao tarefa.data-prev-fim 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-tar 
&Scoped-define QUERY-STRING-br-tar FOR EACH tarefa ~
      WHERE tarefa.num-os = ordem-serv.num-os NO-LOCK ~
    BY tarefa.data-prev-ini INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-tar OPEN QUERY br-tar FOR EACH tarefa ~
      WHERE tarefa.num-os = ordem-serv.num-os NO-LOCK ~
    BY tarefa.data-prev-ini INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-tar tarefa
&Scoped-define FIRST-TABLE-IN-QUERY-br-tar tarefa


/* Definitions for BROWSE br-tar-usu                                    */
&Scoped-define FIELDS-IN-QUERY-br-tar-usu tarefa.prioridade ~
tarefa.data-prev-ini favorecido.ds-favorecido tarefa.num-os ~
fnOS(tarefa.num-os) @ cOS tarefa.ds-tarefa tarefa.qtd-horas tarefa.qtd-lib ~
fnApont(tarefa.nome,tarefa.sequencia) @ deApont tarefa.perc-con ~
fnSituacaoTarefa(tarefa.situacao) @ cSituacao tarefa.data-prev-fim 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-tar-usu 
&Scoped-define QUERY-STRING-br-tar-usu FOR EACH tarefa ~
      WHERE tarefa.responsavel = usuario.nome ~
 AND tarefa.num-os <> 0 ~
 AND tarefa.situacao < 8 /* Conclu¡da */ NO-LOCK, ~
      EACH favorecido OF tarefa NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-tar-usu OPEN QUERY br-tar-usu FOR EACH tarefa ~
      WHERE tarefa.responsavel = usuario.nome ~
 AND tarefa.num-os <> 0 ~
 AND tarefa.situacao < 8 /* Conclu¡da */ NO-LOCK, ~
      EACH favorecido OF tarefa NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-tar-usu tarefa favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-br-tar-usu tarefa
&Scoped-define SECOND-TABLE-IN-QUERY-br-tar-usu favorecido


/* Definitions for BROWSE br-usu                                        */
&Scoped-define FIELDS-IN-QUERY-br-usu usuario.nome usuario.hrs-dia 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br-usu 
&Scoped-define QUERY-STRING-br-usu FOR EACH usuario NO-LOCK, ~
      EACH favorecido OF usuario ~
      WHERE favorecido.ativo = TRUE NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br-usu OPEN QUERY br-usu FOR EACH usuario NO-LOCK, ~
      EACH favorecido OF usuario ~
      WHERE favorecido.ativo = TRUE NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br-usu usuario favorecido
&Scoped-define FIRST-TABLE-IN-QUERY-br-usu usuario
&Scoped-define SECOND-TABLE-IN-QUERY-br-usu favorecido


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br-os}~
    ~{&OPEN-QUERY-br-tar}~
    ~{&OPEN-QUERY-br-tar-usu}~
    ~{&OPEN-QUERY-br-usu}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btOrd RECT-6 br-os br-tar br-usu br-tar-usu ~
btDown btUp btExit btRecalc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnApont C-Win 
FUNCTION fnApont RETURNS DECIMAL
  ( cNome AS CHAR, iSeq AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnDataFim C-Win 
FUNCTION fnDataFim RETURNS DATE
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnOS C-Win 
FUNCTION fnOS RETURNS CHARACTER
  ( iNum AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btDown 
     IMAGE-UP FILE "image/im-down.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-down.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Menos Priorit ria".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btOrd 
     IMAGE-UP FILE "image/im-plan.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-plan.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "OS" 
     SIZE 6.14 BY 1.79 TOOLTIP "Manuten‡Æo de Ordens de Servi‡o".

DEFINE BUTTON btRecalc 
     IMAGE-UP FILE "image/im-copia.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-copia.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "recalc" 
     SIZE 6.14 BY 1.79 TOOLTIP "Recalcular Tudo".

DEFINE BUTTON btUp 
     IMAGE-UP FILE "image/im-up.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-up.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Mais Priorit ria".

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 149 BY 2.25.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br-os FOR 
      ordem-serv, 
      favorecido SCROLLING.

DEFINE QUERY br-tar FOR 
      tarefa SCROLLING.

DEFINE QUERY br-tar-usu FOR 
      tarefa, 
      favorecido SCROLLING.

DEFINE QUERY br-usu FOR 
      usuario, 
      favorecido SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br-os
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-os C-Win _STRUCTURED
  QUERY br-os NO-LOCK DISPLAY
      ordem-serv.num-os FORMAT "999999":U WIDTH 7
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 12
      ordem-serv.ds-os FORMAT "x(40)":U
      fnDataFim() @ dtFim COLUMN-LABEL "Fim Previsto" WIDTH 8.57
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 62 BY 8
         FONT 1
         TITLE "Ordens de Servi‡o Ativas".

DEFINE BROWSE br-tar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-tar C-Win _STRUCTURED
  QUERY br-tar NO-LOCK DISPLAY
      tarefa.data-prev-ini FORMAT "99/99/9999":U
      tarefa.ds-tarefa FORMAT "x(40)":U
      tarefa.responsavel FORMAT "X(8)":U
      tarefa.qtd-horas FORMAT "->>,>>9.99":U
      tarefa.qtd-lib FORMAT "->>,>>9.99":U
      fnApont(tarefa.nome, tarefa.sequencia) @ deApont
      tarefa.perc-con FORMAT "->>,>>9.99":U
      fnSituacaoTarefa(tarefa.situacao) @ cSituacao WIDTH 10
      tarefa.data-prev-fim FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 86 BY 8
         FONT 1
         TITLE "Tarefas da OS".

DEFINE BROWSE br-tar-usu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-tar-usu C-Win _STRUCTURED
  QUERY br-tar-usu NO-LOCK DISPLAY
      tarefa.prioridade FORMAT ">>>>>9":U
      tarefa.data-prev-ini FORMAT "99/99/9999":U
      favorecido.ds-favorecido COLUMN-LABEL "Cliente" FORMAT "X(40)":U
            WIDTH 12
      tarefa.num-os FORMAT "999999":U
      fnOS(tarefa.num-os) @ cOS
      tarefa.ds-tarefa FORMAT "x(40)":U
      tarefa.qtd-horas FORMAT "->>,>>9.99":U
      tarefa.qtd-lib FORMAT "->>,>>9.99":U
      fnApont(tarefa.nome,tarefa.sequencia) @ deApont
      tarefa.perc-con FORMAT "->>,>>9.99":U
      fnSituacaoTarefa(tarefa.situacao) @ cSituacao WIDTH 10
      tarefa.data-prev-fim FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 122 BY 14
         FONT 1
         TITLE "Tarefas do Funcion rio".

DEFINE BROWSE br-usu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br-usu C-Win _STRUCTURED
  QUERY br-usu NO-LOCK DISPLAY
      usuario.nome COLUMN-LABEL "Funcion rio" FORMAT "X(8)":U WIDTH 7.43
      usuario.hrs-dia FORMAT "->>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 20 BY 14
         FONT 1
         TITLE "Equipe".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btOrd AT ROW 1.5 COL 9 WIDGET-ID 84
     br-os AT ROW 3.75 COL 2 WIDGET-ID 200
     br-tar AT ROW 3.75 COL 65 WIDGET-ID 300
     br-usu AT ROW 12 COL 2 WIDGET-ID 400
     br-tar-usu AT ROW 12 COL 23 WIDGET-ID 500
     btDown AT ROW 13.75 COL 145 WIDGET-ID 10
     btUp AT ROW 12 COL 145 WIDGET-ID 8
     btExit AT ROW 1.5 COL 144 WIDGET-ID 2
     btRecalc AT ROW 1.5 COL 3 WIDGET-ID 6
     RECT-6 AT ROW 1.25 COL 2 WIDGET-ID 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 151 BY 25
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
         HEIGHT             = 25
         WIDTH              = 151
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* BROWSE-TAB br-os RECT-6 DEFAULT-FRAME */
/* BROWSE-TAB br-tar br-os DEFAULT-FRAME */
/* BROWSE-TAB br-usu br-tar DEFAULT-FRAME */
/* BROWSE-TAB br-tar-usu br-usu DEFAULT-FRAME */
ASSIGN 
       br-tar:ALLOW-COLUMN-SEARCHING IN FRAME DEFAULT-FRAME = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-os
/* Query rebuild information for BROWSE br-os
     _TblList          = "money.ordem-serv,money.favorecido OF money.ordem-serv"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "ordem-serv.situacao < 8 /* Conclu¡da */"
     _FldNameList[1]   > money.ordem-serv.num-os
"ordem-serv.num-os" ? ? "integer" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente" ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = money.ordem-serv.ds-os
     _FldNameList[4]   > "_<CALC>"
"fnDataFim() @ dtFim" "Fim Previsto" ? ? ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br-os */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-tar
/* Query rebuild information for BROWSE br-tar
     _TblList          = "money.tarefa"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "money.tarefa.data-prev-ini|yes"
     _Where[1]         = "tarefa.num-os = ordem-serv.num-os"
     _FldNameList[1]   = money.tarefa.data-prev-ini
     _FldNameList[2]   = money.tarefa.ds-tarefa
     _FldNameList[3]   = money.tarefa.responsavel
     _FldNameList[4]   = money.tarefa.qtd-horas
     _FldNameList[5]   = money.tarefa.qtd-lib
     _FldNameList[6]   > "_<CALC>"
"fnApont(tarefa.nome, tarefa.sequencia) @ deApont" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = money.tarefa.perc-con
     _FldNameList[8]   > "_<CALC>"
"fnSituacaoTarefa(tarefa.situacao) @ cSituacao" ? ? ? ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = money.tarefa.data-prev-fim
     _Query            is OPENED
*/  /* BROWSE br-tar */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-tar-usu
/* Query rebuild information for BROWSE br-tar-usu
     _TblList          = "money.tarefa,money.favorecido OF money.tarefa"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "tarefa.responsavel = usuario.nome
 AND tarefa.num-os <> 0
 AND tarefa.situacao < 8 /* Conclu¡da */"
     _FldNameList[1]   = money.tarefa.prioridade
     _FldNameList[2]   = money.tarefa.data-prev-ini
     _FldNameList[3]   > money.favorecido.ds-favorecido
"favorecido.ds-favorecido" "Cliente" ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = money.tarefa.num-os
     _FldNameList[5]   > "_<CALC>"
"fnOS(tarefa.num-os) @ cOS" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = money.tarefa.ds-tarefa
     _FldNameList[7]   = money.tarefa.qtd-horas
     _FldNameList[8]   = money.tarefa.qtd-lib
     _FldNameList[9]   > "_<CALC>"
"fnApont(tarefa.nome,tarefa.sequencia) @ deApont" ? ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   = money.tarefa.perc-con
     _FldNameList[11]   > "_<CALC>"
"fnSituacaoTarefa(tarefa.situacao) @ cSituacao" ? ? ? ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   = money.tarefa.data-prev-fim
     _Query            is OPENED
*/  /* BROWSE br-tar-usu */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br-usu
/* Query rebuild information for BROWSE br-usu
     _TblList          = "money.usuario,money.favorecido OF money.usuario"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[2]         = "favorecido.ativo = TRUE"
     _FldNameList[1]   > money.usuario.nome
"usuario.nome" "Funcion rio" ? "character" ? ? ? ? ? ? no ? no no "7.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = money.usuario.hrs-dia
     _Query            is OPENED
*/  /* BROWSE br-usu */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESIZED OF C-Win /* <insert window title> */
DO:
    DEFINE VARIABLE hLabel AS HANDLE      NO-UNDO.
    
    ASSIGN FRAME default-frame:WIDTH = C-Win:WIDTH
           FRAME default-frame:HEIGHT = C-Win:HEIGHT.
    
    DO WITH FRAME {&FRAME-NAME}:
        ASSIGN RECT-6:WIDTH = C-Win:WIDTH - 2.00
               btExit:COLUMN = C-Win:WIDTH - 7.00
               br-tar:WIDTH = C-Win:WIDTH - 65.00
               br-usu:ROW = C-Win:HEIGHT - 13.08
               br-tar-usu:ROW = C-Win:HEIGHT - 13.08
               btUp:ROW = C-Win:HEIGHT - 13.08
               btDown:ROW = C-Win:HEIGHT - 11.33
               btUp:COL = C-Win:WIDTH - 6.00
               btDown:COL = C-Win:WIDTH - 6.00
               br-tar-usu:WIDTH = C-Win:WIDTH - 29.00
               br-os:HEIGHT = C-Win:HEIGHT - 17.08
               br-tar:HEIGHT = C-Win:HEIGHT - 17.08
            .                              
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-os
&Scoped-define SELF-NAME br-os
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-os C-Win
ON VALUE-CHANGED OF br-os IN FRAME DEFAULT-FRAME /* Ordens de Servi‡o Ativas */
DO:
  
    {&OPEN-QUERY-br-tar}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-tar
&Scoped-define SELF-NAME br-tar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-tar C-Win
ON MOUSE-SELECT-DBLCLICK OF br-tar IN FRAME DEFAULT-FRAME /* Tarefas da OS */
DO:
    IF AVAIL tarefa THEN DO:              
        ASSIGN r-parent = ROWID(usuario)
               r-tarefa = ROWID(tarefa)
               pcActionBT = "UPDATE".
        {func\run.i &Programa = "tarefa_det.w"}
        IF RETURN-VALUE = "OK" THEN DO:
            {&OPEN-QUERY-br-tar}
            APPLY "VALUE-CHANGED" TO br-usu.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-tar C-Win
ON ROW-DISPLAY OF br-tar IN FRAME DEFAULT-FRAME /* Tarefas da OS */
DO:
  
    IF tarefa.data-prev-fim < TODAY THEN DO:

        ASSIGN tarefa.data-prev-ini:FGCOLOR IN BROWSE br-tar = 12
               tarefa.ds-tarefa:FGCOLOR IN BROWSE br-tar     = 12
               tarefa.responsavel:FGCOLOR IN BROWSE br-tar   = 12
               tarefa.qtd-horas:FGCOLOR IN BROWSE br-tar     = 12
               tarefa.perc-con:FGCOLOR IN BROWSE br-tar      = 12
               cSituacao:FGCOLOR IN BROWSE br-tar            = 12
               tarefa.data-prev-fim:FGCOLOR IN BROWSE br-tar = 12
               tarefa.qtd-lib:FGCOLOR IN BROWSE br-tar       = 12
               deApont:FGCOLOR IN BROWSE br-tar              = 12.

    END.

    IF tarefa.situacao = 8 /* Conclu¡da */ THEN DO:

        ASSIGN tarefa.data-prev-ini:FGCOLOR IN BROWSE br-tar = 2
               tarefa.ds-tarefa:FGCOLOR IN BROWSE br-tar     = 2
               tarefa.responsavel:FGCOLOR IN BROWSE br-tar   = 2
               tarefa.qtd-horas:FGCOLOR IN BROWSE br-tar     = 2
               tarefa.perc-con:FGCOLOR IN BROWSE br-tar      = 2
               cSituacao:FGCOLOR IN BROWSE br-tar            = 2
               tarefa.data-prev-fim:FGCOLOR IN BROWSE br-tar = 2
               tarefa.qtd-lib:FGCOLOR IN BROWSE br-tar       = 2
               deApont:FGCOLOR IN BROWSE br-tar              = 2.

    END.

    IF tarefa.situacao = 9 /* Cancelada */ THEN DO:

        ASSIGN tarefa.data-prev-ini:FGCOLOR IN BROWSE br-tar = 8
               tarefa.ds-tarefa:FGCOLOR IN BROWSE br-tar     = 8
               tarefa.responsavel:FGCOLOR IN BROWSE br-tar   = 8
               tarefa.qtd-horas:FGCOLOR IN BROWSE br-tar     = 8
               tarefa.perc-con:FGCOLOR IN BROWSE br-tar      = 8
               cSituacao:FGCOLOR IN BROWSE br-tar            = 8
               tarefa.data-prev-fim:FGCOLOR IN BROWSE br-tar = 8
               tarefa.qtd-lib:FGCOLOR IN BROWSE br-tar       = 8
               deApont:FGCOLOR IN BROWSE br-tar              = 8.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-tar C-Win
ON START-SEARCH OF br-tar IN FRAME DEFAULT-FRAME /* Tarefas da OS */
DO:
    DEF VAR cWhere AS CHAR NO-UNDO.
    DEF VAR hQuery AS HANDLE NO-UNDO.
    DEF VAR cBy    AS CHAR NO-UNDO.

    ASSIGN cWhere = "FOR ".
    ASSIGN cWhere = cWhere + "EACH money.tarefa ".
    ASSIGN cWhere = cWhere + " WHERE tarefa.num-os = " + string(ordem-serv.num-os) + " NO-LOCK ".
    ASSIGN cBy = "BY tarefa.data-prev-ini INDEXED-REPOSITION".

    /* Se a coluna clicada nÆo foi clicada anteriormente fa‡a */
    IF SELF :CURRENT-COLUMN :SORT-ASCENDING = ? THEN DO:
       SELF :CLEAR-SORT-ARROWS(). /* Limpa as setas das outras colunas */
       SELF :CURRENT-COLUMN :SORT-ASCENDING = FALSE. /* Ordena a coluna ascendentemente */
    END.
    /* SenÆo ordena a coluna ao inverso do que j  est  ordenada */
    ELSE SELF :CURRENT-COLUMN :SORT-ASCENDING = NOT SELF :CURRENT-COLUMN :SORT-ASCENDING.

    IF SELF :CURRENT-COLUMN :NAME = "deApont" THEN DO:
        RETURN NO-APPLY.
    END.
    
    /* Armazena a coluna recem selecionada */
    IF SELF :CURRENT-COLUMN :SORT-ASCENDING = FALSE OR SELF :CURRENT-COLUMN :SORT-ASCENDING = TRUE THEN DO:
        CASE SELF :CURRENT-COLUMN :NAME:
            WHEN "cSituacao" THEN DO: /*Trata as fun‡äes*/
                ASSIGN cBy = "BY tarefa.situacao".
            END.
            OTHERWISE DO: /*Campos padrÆo*/
                ASSIGN cBy = "BY " + SELF :CURRENT-COLUMN :NAME.
            END.
        END CASE.
    
        IF SELF :CURRENT-COLUMN :SORT-ASCENDING = TRUE THEN
            ASSIGN cBy = cBy + " DESCENDING.".
        ELSE
            ASSIGN cBy = cBy + ".".
    END.
    ELSE DO:
        SELF :CLEAR-SORT-ARROWS().
        RETURN.
    END.
    
    /* Executa a nova query para o Browse */
    ASSIGN hQuery = SELF :QUERY :HANDLE.
    hQuery:QUERY-PREPARE(cWhere + cBy).
    hQuery:QUERY-OPEN().
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-usu
&Scoped-define SELF-NAME br-usu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br-usu C-Win
ON VALUE-CHANGED OF br-usu IN FRAME DEFAULT-FRAME /* Equipe */
DO:
  
    {&OPEN-QUERY-br-tar-usu}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btDown
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btDown C-Win
ON CHOOSE OF btDown IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE iMaxPri      AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iCont        AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-seq        AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-prioridade AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-num-linhas-sel AS INTEGER     NO-UNDO.

    EMPTY TEMP-TABLE tt-tarefa-1.

    blk:
    DO TRANSACTION:
        ASSIGN i-num-linhas-sel = br-tar-usu:NUM-SELECTED-ROWS.
        REPEAT iCont = 1 TO br-tar-usu:NUM-SELECTED-ROWS:

            br-tar-usu:FETCH-SELECTED-ROW(iCont) IN FRAME {&FRAME-NAME}.

           IF tarefa.prioridade >= 1 THEN DO:
                CREATE tt-tarefa-1.
                BUFFER-COPY tarefa TO tt-tarefa-1.
                ASSIGN tt-tarefa-1.r-rowid = ROWID(tarefa).
            END.
        END.
        SELECT MAX(prioridade) INTO iMaxPri FROM tarefa
            WHERE tarefa.responsavel = usuario.nome    
            AND   tarefa.num-os <> 0                   
            AND   tarefa.situacao < 8 /* Conclu¡da */. 

        IF tarefa.prioridade < iMaxPri THEN DO:

            ASSIGN iCont = 0.
            FOR EACH tt-tarefa-1
                BREAK BY tt-tarefa-1.prioridade:
                ASSIGN iCont = iCont + 1.
    
                IF ((tt-tarefa-1.prioridade - i-seq) <> 1) AND icont <> 1  THEN DO:
                    UNDO blk, LEAVE blk.
                END.
    
                IF iCont = br-tar-usu:NUM-SELECTED-ROWS THEN DO:
                    FIND FIRST bf-tarefa EXCLUSIVE-LOCK
                       WHERE bf-tarefa.responsavel = tarefa.responsavel                                       
                        AND   bf-tarefa.num-os <> 0                                                         
                        AND   bf-tarefa.situacao < 8 /* Conclu¡da */                                        
                        AND   bf-tarefa.prioridade = (tt-tarefa-1.prioridade + 1) NO-ERROR.
                    IF AVAIL bf-tarefa THEN DO:
                        ASSIGN bf-tarefa.prioridade = bf-tarefa.prioridade -  br-tar-usu:NUM-SELECTED-ROWS. 

                    END.
                    ELSE DO:
                        UNDO blk, LEAVE blk.
                    END.
                END.
                                                                                                            
                FIND FIRST tarefa
                    WHERE rowid(tarefa) = tt-tarefa-1.r-rowid EXCLUSIVE-LOCK NO-ERROR.
                IF AVAIL tarefa THEN DO:
                    ASSIGN tarefa.prioridade = tarefa.prioridade + 1.
                END.

                ASSIGN i-seq = tt-tarefa-1.prioridade. 
            END.
        END.
    END.

    RUN calc_prioridade.p (INPUT tarefa.responsavel, INPUT TODAY).

    {&open-query-br-tar-usu}
        
    br-tar-usu:SELECT-ALL().
    ASSIGN iCont = 1.

    REPEAT WHILE br-tar-usu:NUM-SELECTED-ROWS > i-num-linhas-sel:
        br-tar-usu:FETCH-SELECTED-ROW(iCont) IN FRAME {&FRAME-NAME}.
        IF NOT CAN-FIND(FIRST tt-tarefa-1
                        WHERE tt-tarefa-1.r-rowid = ROWID(tarefa)) THEN DO:
            br-tar-usu:DESELECT-SELECTED-ROW(iCont).
        END.
        ELSE DO:
            ASSIGN iCont = iCont + 1.
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


&Scoped-define SELF-NAME btOrd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOrd C-Win
ON CHOOSE OF btOrd IN FRAME DEFAULT-FRAME /* OS */
DO:
 
    IF AVAIL ordem-serv THEN DO:
        ASSIGN r-ordem-serv = ROWID(ordem-serv).
    END.
    {func\run.i &Programa = "os.w"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btRecalc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btRecalc C-Win
ON CHOOSE OF btRecalc IN FRAME DEFAULT-FRAME /* recalc */
DO:

    FOR EACH usuario,
        FIRST favorecido OF usuario
            WHERE favorecido.ativo:

        RUN calc_prioridade.p (INPUT usuario.nome,
                               INPUT TODAY).

    END.

    {&OPEN-QUERY-br-os}
    APPLY "VALUE-CHANGED" TO br-os.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btUp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btUp C-Win
ON CHOOSE OF btUp IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    DEFINE VARIABLE iCont        AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-seq        AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-prioridade AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-num-linhas-sel AS INTEGER     NO-UNDO.
    
    EMPTY TEMP-TABLE tt-tarefa-1.

    blk:
    DO TRANSACTION:
        ASSIGN i-num-linhas-sel = br-tar-usu:NUM-SELECTED-ROWS.
        REPEAT iCont = 1 TO br-tar-usu:NUM-SELECTED-ROWS:
            
            br-tar-usu:FETCH-SELECTED-ROW(iCont) IN FRAME {&FRAME-NAME}.
            
            CREATE tt-tarefa-1.
            BUFFER-COPY tarefa TO tt-tarefa-1.
            ASSIGN tt-tarefa-1.r-rowid = ROWID(tarefa).
        END.  

        ASSIGN iCont = 0.
        FOR EACH tt-tarefa-1
            BREAK BY tt-tarefa-1.prioridade:

            ASSIGN iCont = iCont + 1.

            IF ((tt-tarefa-1.prioridade - i-seq) <> 1) AND icont <> 1  THEN DO:
                UNDO blk, LEAVE blk.
            END.
    
            IF iCont = 1 THEN DO:
                IF (tt-tarefa-1.prioridade - 1) <= 0 THEN DO:
                    UNDO blk, LEAVE blk.
                END.
                FIND FIRST bf-tarefa EXCLUSIVE-LOCK
                   WHERE bf-tarefa.responsavel = tarefa.responsavel
                    AND   bf-tarefa.num-os <> 0
                    AND   bf-tarefa.situacao < 8 /* Conclu¡da */
                    AND   bf-tarefa.prioridade = (tt-tarefa-1.prioridade - 1) NO-ERROR.
                IF AVAIL bf-tarefa THEN DO:
                    ASSIGN bf-tarefa.prioridade = bf-tarefa.prioridade +  br-tar-usu:NUM-SELECTED-ROWS.  
                END.
            END.
    
            FIND FIRST tarefa
                WHERE rowid(tarefa) = tt-tarefa-1.r-rowid EXCLUSIVE-LOCK NO-ERROR.
            IF AVAIL tarefa THEN DO:
                ASSIGN tarefa.prioridade = tarefa.prioridade - 1.
            END.

            ASSIGN i-seq = tt-tarefa-1.prioridade.
        END.
    END.

    RUN calc_prioridade.p (INPUT tarefa.responsavel, INPUT TODAY).

    {&open-query-br-tar-usu}
        
    br-tar-usu:SELECT-ALL().
    ASSIGN iCont = 1.

    REPEAT WHILE br-tar-usu:NUM-SELECTED-ROWS > i-num-linhas-sel:
        br-tar-usu:FETCH-SELECTED-ROW(iCont) IN FRAME {&FRAME-NAME}.
        IF NOT CAN-FIND(FIRST tt-tarefa-1
                        WHERE tt-tarefa-1.r-rowid = ROWID(tarefa)) THEN DO:
            br-tar-usu:DESELECT-SELECTED-ROW(iCont).
        END.
        ELSE DO:
            ASSIGN iCont = iCont + 1.
        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br-os
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
  {version.i painel-os}
  RUN enable_UI.
  RUN initialize.
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
  ENABLE btOrd RECT-6 br-os br-tar br-usu br-tar-usu btDown btUp btExit 
         btRecalc 
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

    APPLY "VALUE-CHANGED" TO br-usu IN FRAME {&FRAME-NAME}.

    ASSIGN C-Win:WINDOW-STATE = WINDOW-MAXIMIZED.
    APPLY "WINDOW-RESIZED" TO C-Win.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnApont C-Win 
FUNCTION fnApont RETURNS DECIMAL
  ( cNome AS CHAR, iSeq AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE de-cont AS DECIMAL     NO-UNDO.

    FOR EACH apontamento NO-LOCK
        WHERE apontamento.nome-tarefa = cNome
        AND   apontamento.seq-tarefa = iSeq:
        ASSIGN de-cont = de-cont + apontamento.qt-apont.
    END.

    RETURN de-cont.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnDataFim C-Win 
FUNCTION fnDataFim RETURNS DATE
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE dtAux AS DATE    NO-UNDO.
    
    SELECT MAX(data-prev-fim) INTO dtAux FROM tarefa 
        WHERE tarefa.num-os = ordem-serv.num-os.
    
    RETURN dtAux.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnOS C-Win 
FUNCTION fnOS RETURNS CHARACTER
  ( iNum AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST bf-os NO-LOCK
        WHERE bf-os.num-os = iNum NO-ERROR.
    IF AVAIL bf-os THEN
        RETURN bf-os.ds-os.
    ELSE
        RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

