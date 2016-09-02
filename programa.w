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

DEFINE INPUT  PARAMETER rAgend AS ROWID      NO-UNDO.

/* Local Variable Definitions ---                                       */

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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel btOK RECT-1 RECT-2 RECT-3 RECT-4 ~
RECT-5 RECT-6 l-dia l-mes dia-8 sem-8 mes-1 mes-17 dia-1 sem-1 mes-2 mes-18 ~
dia-2 sem-2 mes-3 mes-19 dia-3 sem-3 mes-4 mes-20 dia-4 sem-4 mes-5 mes-21 ~
dia-5 sem-5 mes-6 mes-22 dia-6 sem-6 mes-7 mes-23 dia-7 sem-7 mes-8 mes-24 ~
mes-9 mes-25 mes-10 mes-26 mes-11 mes-27 ano-13 ano-6 mes-12 mes-28 ano-14 ~
ano-7 mes-13 mes-29 ano-1 ano-8 mes-14 mes-30 ano-2 ano-9 mes-15 mes-31 ~
ano-3 ano-10 mes-16 mes-32 ano-4 ano-11 mes-33 ano-5 ano-12 i-dias-uteis ~
dia-n-util 
&Scoped-Define DISPLAYED-FIELDS agenda.cd-agenda 
&Scoped-define DISPLAYED-TABLES agenda
&Scoped-define FIRST-DISPLAYED-TABLE agenda
&Scoped-Define DISPLAYED-OBJECTS fav l-dia l-mes dia-8 sem-8 mes-1 mes-17 ~
dia-1 sem-1 mes-2 mes-18 dia-2 sem-2 mes-3 mes-19 dia-3 sem-3 mes-4 mes-20 ~
dia-4 sem-4 mes-5 mes-21 dia-5 sem-5 mes-6 mes-22 dia-6 sem-6 mes-7 mes-23 ~
dia-7 sem-7 mes-8 mes-24 mes-9 mes-25 mes-10 mes-26 mes-11 mes-27 ano-13 ~
ano-6 mes-12 mes-28 ano-14 num-ano ano-7 mes-13 mes-29 ano-1 ano-8 mes-14 ~
mes-30 ano-2 ano-9 mes-15 mes-31 ano-3 ano-10 mes-16 mes-32 ano-4 ano-11 ~
mes-33 num-mes ano-5 ano-12 i-dias-uteis dia-n-util 

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

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE VARIABLE fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY .79 NO-UNDO.

DEFINE VARIABLE i-dias-uteis AS INTEGER FORMAT "->>9":U INITIAL 0 
     LABEL "Adiciona Dias éteis" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE VARIABLE num-ano AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE num-mes AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY .79 NO-UNDO.

DEFINE VARIABLE dia-n-util AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Posterga", 1,
"Mant‚m", 2,
"Antecipa", 3
     SIZE 10 BY 2 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 21 BY 7.5.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 23 BY 7.5.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 47 BY 6.75.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 29 BY 14.75.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 14 BY 2.75.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE VARIABLE ano-1 AS LOGICAL INITIAL no 
     LABEL "Janeiro" 
     VIEW-AS TOGGLE-BOX
     SIZE 8 BY .83 NO-UNDO.

DEFINE VARIABLE ano-10 AS LOGICAL INITIAL no 
     LABEL "Outubro" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-11 AS LOGICAL INITIAL no 
     LABEL "Novembro" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-12 AS LOGICAL INITIAL no 
     LABEL "Dezembro" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-13 AS LOGICAL INITIAL yes 
     LABEL "Todo Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 10 BY .83 NO-UNDO.

DEFINE VARIABLE ano-14 AS LOGICAL INITIAL no 
     LABEL "A Cada" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-2 AS LOGICAL INITIAL no 
     LABEL "Fevereiro" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-3 AS LOGICAL INITIAL no 
     LABEL "Mar‡o" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-4 AS LOGICAL INITIAL no 
     LABEL "Abril" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-5 AS LOGICAL INITIAL no 
     LABEL "Maio" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-6 AS LOGICAL INITIAL no 
     LABEL "Junho" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-7 AS LOGICAL INITIAL no 
     LABEL "Julho" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-8 AS LOGICAL INITIAL no 
     LABEL "Agosto" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE ano-9 AS LOGICAL INITIAL no 
     LABEL "Setembro" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.

DEFINE VARIABLE dia-1 AS LOGICAL INITIAL no 
     LABEL "Domingo" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-2 AS LOGICAL INITIAL no 
     LABEL "Segunda-Feira" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-3 AS LOGICAL INITIAL no 
     LABEL "Ter‡a-Feira" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-4 AS LOGICAL INITIAL no 
     LABEL "Quarta-Feira" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-5 AS LOGICAL INITIAL no 
     LABEL "Quinta-Feira" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-6 AS LOGICAL INITIAL no 
     LABEL "Sexta-Feira" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-7 AS LOGICAL INITIAL no 
     LABEL "S bado" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE dia-8 AS LOGICAL INITIAL no 
     LABEL "Todo Dia" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .83 NO-UNDO.

DEFINE VARIABLE l-dia AS LOGICAL INITIAL no 
     LABEL "Di rio" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE l-mes AS LOGICAL INITIAL yes 
     LABEL "Mensal" 
     VIEW-AS TOGGLE-BOX
     SIZE 8 BY .83 NO-UNDO.

DEFINE VARIABLE mes-1 AS LOGICAL INITIAL no 
     LABEL "1" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-10 AS LOGICAL INITIAL no 
     LABEL "10" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-11 AS LOGICAL INITIAL no 
     LABEL "11" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-12 AS LOGICAL INITIAL no 
     LABEL "12" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-13 AS LOGICAL INITIAL no 
     LABEL "13" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-14 AS LOGICAL INITIAL no 
     LABEL "14" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-15 AS LOGICAL INITIAL no 
     LABEL "15" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-16 AS LOGICAL INITIAL no 
     LABEL "16" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-17 AS LOGICAL INITIAL no 
     LABEL "17" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-18 AS LOGICAL INITIAL no 
     LABEL "18" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-19 AS LOGICAL INITIAL no 
     LABEL "19" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-2 AS LOGICAL INITIAL no 
     LABEL "2" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-20 AS LOGICAL INITIAL no 
     LABEL "20" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-21 AS LOGICAL INITIAL no 
     LABEL "21" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-22 AS LOGICAL INITIAL no 
     LABEL "22" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-23 AS LOGICAL INITIAL no 
     LABEL "23" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-24 AS LOGICAL INITIAL no 
     LABEL "24" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-25 AS LOGICAL INITIAL no 
     LABEL "25" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-26 AS LOGICAL INITIAL no 
     LABEL "26" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-27 AS LOGICAL INITIAL no 
     LABEL "27" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-28 AS LOGICAL INITIAL no 
     LABEL "28" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-29 AS LOGICAL INITIAL no 
     LABEL "29" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-3 AS LOGICAL INITIAL no 
     LABEL "3" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-30 AS LOGICAL INITIAL no 
     LABEL "30" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-31 AS LOGICAL INITIAL no 
     LABEL "31" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-32 AS LOGICAL INITIAL no 
     LABEL "éltimo" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-33 AS LOGICAL INITIAL no 
     LABEL "A Cada" 
     VIEW-AS TOGGLE-BOX
     SIZE 9 BY .83 NO-UNDO.

DEFINE VARIABLE mes-4 AS LOGICAL INITIAL no 
     LABEL "4" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-5 AS LOGICAL INITIAL no 
     LABEL "5" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-6 AS LOGICAL INITIAL no 
     LABEL "6" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-7 AS LOGICAL INITIAL no 
     LABEL "7" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-8 AS LOGICAL INITIAL no 
     LABEL "8" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE mes-9 AS LOGICAL INITIAL no 
     LABEL "9" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .83 NO-UNDO.

DEFINE VARIABLE sem-1 AS LOGICAL INITIAL no 
     LABEL "1¦ Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-2 AS LOGICAL INITIAL no 
     LABEL "2¦ Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-3 AS LOGICAL INITIAL no 
     LABEL "3¦ Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-4 AS LOGICAL INITIAL no 
     LABEL "4¦ Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-5 AS LOGICAL INITIAL no 
     LABEL "5¦ Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-6 AS LOGICAL INITIAL no 
     LABEL "6¦ Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-7 AS LOGICAL INITIAL no 
     LABEL "éltima Semana do Mˆs" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.

DEFINE VARIABLE sem-8 AS LOGICAL INITIAL no 
     LABEL "Toda Semana" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .83 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 19.5 COL 73.14
     btOK AT ROW 19.5 COL 67
     agenda.cd-agenda AT ROW 1.5 COL 22 COLON-ALIGNED
          LABEL "Agendamento"
          VIEW-AS FILL-IN 
          SIZE 4 BY .79
     fav AT ROW 1.5 COL 26.29 COLON-ALIGNED NO-LABEL
     l-dia AT ROW 3 COL 3
     l-mes AT ROW 3 COL 52
     dia-8 AT ROW 4.25 COL 5
     sem-8 AT ROW 4.25 COL 29
     mes-1 AT ROW 4.25 COL 56
     mes-17 AT ROW 4.25 COL 68
     dia-1 AT ROW 5 COL 5
     sem-1 AT ROW 5 COL 29
     mes-2 AT ROW 5 COL 56
     mes-18 AT ROW 5 COL 68
     dia-2 AT ROW 5.75 COL 5
     sem-2 AT ROW 5.75 COL 29
     mes-3 AT ROW 5.75 COL 56
     mes-19 AT ROW 5.75 COL 68
     dia-3 AT ROW 6.5 COL 5
     sem-3 AT ROW 6.5 COL 29
     mes-4 AT ROW 6.5 COL 56
     mes-20 AT ROW 6.5 COL 68
     dia-4 AT ROW 7.25 COL 5
     sem-4 AT ROW 7.25 COL 29
     mes-5 AT ROW 7.25 COL 56
     mes-21 AT ROW 7.25 COL 68
     dia-5 AT ROW 8 COL 5
     sem-5 AT ROW 8 COL 29
     mes-6 AT ROW 8 COL 56
     mes-22 AT ROW 8 COL 68
     dia-6 AT ROW 8.75 COL 5
     sem-6 AT ROW 8.75 COL 29
     mes-7 AT ROW 8.75 COL 56
     mes-23 AT ROW 8.75 COL 68
     dia-7 AT ROW 9.5 COL 5
     sem-7 AT ROW 9.5 COL 29
     mes-8 AT ROW 9.5 COL 56
     mes-24 AT ROW 9.5 COL 68
     mes-9 AT ROW 10.25 COL 56
     mes-25 AT ROW 10.25 COL 68
     mes-10 AT ROW 11 COL 56
     mes-26 AT ROW 11 COL 68
     mes-11 AT ROW 11.75 COL 56
     mes-27 AT ROW 11.75 COL 68
     ano-13 AT ROW 12.25 COL 5
     ano-6 AT ROW 12.25 COL 29
     mes-12 AT ROW 12.5 COL 56
     mes-28 AT ROW 12.5 COL 68
     ano-14 AT ROW 13 COL 5
     num-ano AT ROW 13 COL 12 COLON-ALIGNED NO-LABEL
     ano-7 AT ROW 13 COL 29
     mes-13 AT ROW 13.25 COL 56
     mes-29 AT ROW 13.25 COL 68
     ano-1 AT ROW 13.75 COL 5
     ano-8 AT ROW 13.75 COL 29
     mes-14 AT ROW 14 COL 56
     mes-30 AT ROW 14 COL 68
     ano-2 AT ROW 14.5 COL 5
     ano-9 AT ROW 14.5 COL 29
     mes-15 AT ROW 14.75 COL 56
     mes-31 AT ROW 14.75 COL 68
     ano-3 AT ROW 15.25 COL 5
     ano-10 AT ROW 15.25 COL 29
     mes-16 AT ROW 15.5 COL 56
     mes-32 AT ROW 15.5 COL 68
     ano-4 AT ROW 16 COL 5
     ano-11 AT ROW 16 COL 29
     mes-33 AT ROW 16.5 COL 56
     num-mes AT ROW 16.5 COL 62 COLON-ALIGNED NO-LABEL
     ano-5 AT ROW 16.75 COL 5
     ano-12 AT ROW 16.75 COL 29
     i-dias-uteis AT ROW 18.5 COL 38 COLON-ALIGNED
     dia-n-util AT ROW 19 COL 4 NO-LABEL
     "Meses" VIEW-AS TEXT
          SIZE 5 BY .54 AT ROW 13.08 COL 19
     "Dias" VIEW-AS TEXT
          SIZE 5 BY .54 AT ROW 16.63 COL 69
     "Anual" VIEW-AS TEXT
          SIZE 4 BY .54 AT ROW 11 COL 4
     "Semanal" VIEW-AS TEXT
          SIZE 6 BY .54 AT ROW 3 COL 27
     "Dia NÆo étil" VIEW-AS TEXT
          SIZE 9 BY .54 AT ROW 18.25 COL 3
     RECT-1 AT ROW 3.25 COL 2
     RECT-2 AT ROW 3.25 COL 26
     RECT-3 AT ROW 11.25 COL 2
     RECT-4 AT ROW 3.25 COL 51
     RECT-5 AT ROW 18.5 COL 2
     RECT-6 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 20.46
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
         HEIGHT             = 20.46
         WIDTH              = 80
         MAX-HEIGHT         = 20.46
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 20.46
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
/* SETTINGS FOR FILL-IN agenda.cd-agenda IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN num-ano IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN num-mes IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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


&Scoped-define SELF-NAME ano-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-13 C-Win
ON VALUE-CHANGED OF ano-13 IN FRAME DEFAULT-FRAME /* Todo Mˆs */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} ano-13 THEN DO:
        DISABLE ano-1
                ano-2
                ano-3
                ano-4
                ano-5
                ano-6
                ano-7
                ano-8
                ano-9
                ano-10
                ano-11
                ano-12
                ano-14
                WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ENABLE ano-1
               ano-2
               ano-3
               ano-4
               ano-5
               ano-6
               ano-7
               ano-8
               ano-9
               ano-10
               ano-11
               ano-12
               ano-14
               WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ano-14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano-14 C-Win
ON VALUE-CHANGED OF ano-14 IN FRAME DEFAULT-FRAME /* A Cada */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} ano-14 THEN DO:
        DISABLE ano-1
                ano-2
                ano-3
                ano-4
                ano-5
                ano-6
                ano-7
                ano-8
                ano-9
                ano-10
                ano-11
                ano-12
                ano-13
                WITH FRAME {&FRAME-NAME}.
        ENABLE num-ano WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ENABLE ano-1
               ano-2
               ano-3
               ano-4
               ano-5
               ano-6
               ano-7
               ano-8
               ano-9
               ano-10
               ano-11
               ano-12
               ano-13
               WITH FRAME {&FRAME-NAME}.
        DISABLE num-ano WITH FRAME {&FRAME-NAME}.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    {func\bt_fechar.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:

    RUN som.p(INPUT "music\click.wav").

    FIND FIRST agenda NO-LOCK
        WHERE ROWID(agenda) = rAgend NO-ERROR.

    FOR EACH prog-agenda OF agenda EXCLUSIVE-LOCK:
        DELETE prog-agenda.
    END.

    /* Grava A‡Æo Dia NÆo étil */
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 0
           prog-agenda.valor = INPUT FRAME {&FRAME-NAME} dia-n-util.

    /* Grava Anual */
    IF INPUT FRAME {&FRAME-NAME} ano-13 THEN DO:
        CREATE prog-agenda.
        ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
               prog-agenda.id-tipo = 1
               prog-agenda.todos = YES.
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} ano-14 THEN DO:
            CREATE prog-agenda.
            ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
                   prog-agenda.id-tipo = 1
                   prog-agenda.num-periodo = INPUT FRAME {&FRAME-NAME} num-ano.
        END.
        ELSE DO:
            RUN gravaAno.
        END.
    END.

    /* Grava Mensal */
    IF INPUT FRAME {&FRAME-NAME} l-mes THEN DO:
        IF INPUT FRAME {&FRAME-NAME} mes-33 THEN DO:
            CREATE prog-agenda.
            ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
                   prog-agenda.id-tipo = 2
                   prog-agenda.num-periodo = INPUT FRAME {&FRAME-NAME} num-ano.
        END.
        ELSE DO:
            IF INPUT FRAME {&FRAME-NAME} mes-32 THEN DO:
                CREATE prog-agenda.
                ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
                       prog-agenda.id-tipo = 2
                       prog-agenda.ultimo = YES.
            END.
            RUN gravaMes.
        END.
    END.

    /* Grava Semanal */
    IF INPUT FRAME {&FRAME-NAME} l-dia THEN DO:
        IF INPUT FRAME {&FRAME-NAME} sem-8 THEN DO:
            CREATE prog-agenda.
            ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
                   prog-agenda.id-tipo = 3
                   prog-agenda.todos = YES.
        END.
        ELSE DO:
            IF INPUT FRAME {&FRAME-NAME} sem-7 THEN DO:
                CREATE prog-agenda.
                ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
                       prog-agenda.id-tipo = 3
                       prog-agenda.ultimo = YES.
            END.
            RUN gravaSem.
        END.
    END.

    /* Grava Diario */
    IF INPUT FRAME {&FRAME-NAME} l-dia THEN DO:
        IF INPUT FRAME {&FRAME-NAME} dia-8 THEN DO:
            CREATE prog-agenda.
            ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
                   prog-agenda.id-tipo = 4
                   prog-agenda.todos = YES.
        END.
        ELSE DO:
            RUN gravaDia.
        END.
    END.

    /* Grava Adi‡Æo de Dias éteis */
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 5
           prog-agenda.valor = INPUT FRAME {&FRAME-NAME} i-dias-uteis.


    APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dia-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dia-8 C-Win
ON VALUE-CHANGED OF dia-8 IN FRAME DEFAULT-FRAME /* Todo Dia */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} dia-8 THEN DO:
        disABLE dia-1
               dia-2
               dia-3
               dia-4
               dia-5
               dia-6
               dia-7
               sem-1
               sem-2
               sem-3
               sem-4
               sem-5
               sem-6
               sem-7
               sem-8
               WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ENABLE dia-1
               dia-2
               dia-3
               dia-4
               dia-5
               dia-6
               dia-7
               sem-1
               sem-2
               sem-3
               sem-4
               sem-5
               sem-6
               sem-7
               sem-8
               WITH FRAME {&FRAME-NAME}.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME i-dias-uteis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-dias-uteis C-Win
ON ENTRY OF i-dias-uteis IN FRAME DEFAULT-FRAME /* Adiciona Dias éteis */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL i-dias-uteis C-Win
ON LEAVE OF i-dias-uteis IN FRAME DEFAULT-FRAME /* Adiciona Dias éteis */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME l-dia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL l-dia C-Win
ON VALUE-CHANGED OF l-dia IN FRAME DEFAULT-FRAME /* Di rio */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} l-dia THEN DO:
        ENABLE dia-1
               dia-2
               dia-3
               dia-4
               dia-5
               dia-6
               dia-7
               dia-8
               sem-1
               sem-2
               sem-3
               sem-4
               sem-5
               sem-6
               sem-7
               sem-8
               WITH FRAME {&FRAME-NAME}.
        ASSIGN l-mes:CHECKED IN FRAME {&FRAME-NAME} = NO.
        APPLY "VALUE-CHANGED" TO l-mes IN FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        disABLE dia-1
               dia-2
               dia-3
               dia-4
               dia-5
               dia-6
               dia-7
               dia-8
               sem-1
               sem-2
               sem-3
               sem-4
               sem-5
               sem-6
               sem-7
               sem-8
               WITH FRAME {&FRAME-NAME}.
        ASSIGN l-mes:CHECKED IN FRAME {&FRAME-NAME} = YES.
        APPLY "VALUE-CHANGED" TO l-mes IN FRAME {&FRAME-NAME}.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME l-mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL l-mes C-Win
ON VALUE-CHANGED OF l-mes IN FRAME DEFAULT-FRAME /* Mensal */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} l-mes THEN DO:
        ENABLE mes-1
               mes-2
               mes-3
               mes-4
               mes-5
               mes-6
               mes-7
               mes-8
               mes-9
               mes-10
               mes-11
               mes-12
               mes-13
               mes-14
               mes-15
               mes-16
               mes-17
               mes-18
               mes-19
               mes-20
               mes-21
               mes-22
               mes-23
               mes-24
               mes-25
               mes-26
               mes-27
               mes-28
               mes-29
               mes-30
               mes-31
               mes-32
               mes-33
               WITH FRAME {&FRAME-NAME}.
        ASSIGN l-dia:CHECKED IN FRAME {&FRAME-NAME} = NO.
        APPLY "VALUE-CHANGED" TO l-dia IN FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        disABLE mes-1
               mes-2
               mes-3
               mes-4
               mes-5
               mes-6
               mes-7
               mes-8
               mes-9
               mes-10
               mes-11
               mes-12
               mes-13
               mes-14
               mes-15
               mes-16
               mes-17
               mes-18
               mes-19
               mes-20
               mes-21
               mes-22
               mes-23
               mes-24
               mes-25
               mes-26
               mes-27
               mes-28
               mes-29
               mes-30
               mes-31
               mes-32
               mes-33
               WITH FRAME {&FRAME-NAME}.
        ASSIGN l-dia:CHECKED IN FRAME {&FRAME-NAME} = YES.
        APPLY "VALUE-CHANGED" TO l-dia IN FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes-33
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes-33 C-Win
ON VALUE-CHANGED OF mes-33 IN FRAME DEFAULT-FRAME /* A Cada */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} mes-33 THEN DO:
        disABLE mes-1
               mes-2
               mes-3
               mes-4
               mes-5
               mes-6
               mes-7
               mes-8
               mes-9
               mes-10
               mes-11
               mes-12
               mes-13
               mes-14
               mes-15
               mes-16
               mes-17
               mes-18
               mes-19
               mes-20
               mes-21
               mes-22
               mes-23
               mes-24
               mes-25
               mes-26
               mes-27
               mes-28
               mes-29
               mes-30
               mes-31
               mes-32
               WITH FRAME {&FRAME-NAME}.
        ENABLE num-mes WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ENABLE mes-1
               mes-2
               mes-3
               mes-4
               mes-5
               mes-6
               mes-7
               mes-8
               mes-9
               mes-10
               mes-11
               mes-12
               mes-13
               mes-14
               mes-15
               mes-16
               mes-17
               mes-18
               mes-19
               mes-20
               mes-21
               mes-22
               mes-23
               mes-24
               mes-25
               mes-26
               mes-27
               mes-28
               mes-29
               mes-30
               mes-31
               mes-32
               WITH FRAME {&FRAME-NAME}.
        DISABLE num-mes WITH FRAME {&FRAME-NAME}.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME num-ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL num-ano C-Win
ON ENTRY OF num-ano IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL num-ano C-Win
ON LEAVE OF num-ano IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME num-mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL num-mes C-Win
ON ENTRY OF num-mes IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL num-mes C-Win
ON LEAVE OF num-mes IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sem-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sem-8 C-Win
ON VALUE-CHANGED OF sem-8 IN FRAME DEFAULT-FRAME /* Toda Semana */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} sem-8 THEN DO:
        disABLE sem-1
               sem-2
               sem-3
               sem-4
               sem-5
               sem-6
               sem-7
               WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        ENABLE sem-1
               sem-2
               sem-3
               sem-4
               sem-5
               sem-6
               sem-7
               WITH FRAME {&FRAME-NAME}.
    END.
      
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
  {version.i programa}
  RUN initialize.
  RUN enable_UI.
  RUN afterdisplay.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterdisplay C-Win 
PROCEDURE afterdisplay :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    APPLY "VALUE-CHANGED" TO ano-13 IN FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO l-mes IN FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO l-dia IN FRAME {&FRAME-NAME}.

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
  DISPLAY fav l-dia l-mes dia-8 sem-8 mes-1 mes-17 dia-1 sem-1 mes-2 mes-18 
          dia-2 sem-2 mes-3 mes-19 dia-3 sem-3 mes-4 mes-20 dia-4 sem-4 mes-5 
          mes-21 dia-5 sem-5 mes-6 mes-22 dia-6 sem-6 mes-7 mes-23 dia-7 sem-7 
          mes-8 mes-24 mes-9 mes-25 mes-10 mes-26 mes-11 mes-27 ano-13 ano-6 
          mes-12 mes-28 ano-14 num-ano ano-7 mes-13 mes-29 ano-1 ano-8 mes-14 
          mes-30 ano-2 ano-9 mes-15 mes-31 ano-3 ano-10 mes-16 mes-32 ano-4 
          ano-11 mes-33 num-mes ano-5 ano-12 i-dias-uteis dia-n-util 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE agenda THEN 
    DISPLAY agenda.cd-agenda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel btOK RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 l-dia l-mes 
         dia-8 sem-8 mes-1 mes-17 dia-1 sem-1 mes-2 mes-18 dia-2 sem-2 mes-3 
         mes-19 dia-3 sem-3 mes-4 mes-20 dia-4 sem-4 mes-5 mes-21 dia-5 sem-5 
         mes-6 mes-22 dia-6 sem-6 mes-7 mes-23 dia-7 sem-7 mes-8 mes-24 mes-9 
         mes-25 mes-10 mes-26 mes-11 mes-27 ano-13 ano-6 mes-12 mes-28 ano-14 
         ano-7 mes-13 mes-29 ano-1 ano-8 mes-14 mes-30 ano-2 ano-9 mes-15 
         mes-31 ano-3 ano-10 mes-16 mes-32 ano-4 ano-11 mes-33 ano-5 ano-12 
         i-dias-uteis dia-n-util 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE gravaAno C-Win 
PROCEDURE gravaAno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INPUT FRAME {&FRAME-NAME} ano-1 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 1.
END.
IF INPUT FRAME {&FRAME-NAME} ano-2 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 2.
END.
IF INPUT FRAME {&FRAME-NAME} ano-3 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 3.
END.
IF INPUT FRAME {&FRAME-NAME} ano-4 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 4.
END.
IF INPUT FRAME {&FRAME-NAME} ano-5 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 5.
END.
IF INPUT FRAME {&FRAME-NAME} ano-6 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 6.
END.
IF INPUT FRAME {&FRAME-NAME} ano-7 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 7.
END.
IF INPUT FRAME {&FRAME-NAME} ano-8 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 8.
END.
IF INPUT FRAME {&FRAME-NAME} ano-9 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 9.
END.
IF INPUT FRAME {&FRAME-NAME} ano-10 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 10.
END.
IF INPUT FRAME {&FRAME-NAME} ano-11 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 11.
END.
IF INPUT FRAME {&FRAME-NAME} ano-12 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 1
           prog-agenda.valor = 12.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE gravaDia C-Win 
PROCEDURE gravaDia :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INPUT FRAME {&FRAME-NAME} dia-1 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 1.
END.
IF INPUT FRAME {&FRAME-NAME} dia-2 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 2.
END.
IF INPUT FRAME {&FRAME-NAME} dia-3 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 3.
END.
IF INPUT FRAME {&FRAME-NAME} dia-4 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 4.
END.
IF INPUT FRAME {&FRAME-NAME} dia-5 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 5.
END.
IF INPUT FRAME {&FRAME-NAME} dia-6 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 6.
END.
IF INPUT FRAME {&FRAME-NAME} dia-7 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 4
           prog-agenda.valor = 7.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE gravaMes C-Win 
PROCEDURE gravaMes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INPUT FRAME {&FRAME-NAME} mes-1 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 1.
END.
IF INPUT FRAME {&FRAME-NAME} mes-2 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 2.
END.
IF INPUT FRAME {&FRAME-NAME} mes-3 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 3.
END.
IF INPUT FRAME {&FRAME-NAME} mes-4 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 4.
END.
IF INPUT FRAME {&FRAME-NAME} mes-5 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 5.
END.
IF INPUT FRAME {&FRAME-NAME} mes-6 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 6.
END.
IF INPUT FRAME {&FRAME-NAME} mes-7 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 7.
END.
IF INPUT FRAME {&FRAME-NAME} mes-8 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 8.
END.
IF INPUT FRAME {&FRAME-NAME} mes-9 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 9.
END.
IF INPUT FRAME {&FRAME-NAME} mes-10 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 10.
END.
IF INPUT FRAME {&FRAME-NAME} mes-11 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 11.
END.
IF INPUT FRAME {&FRAME-NAME} mes-12 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 12.
END.
IF INPUT FRAME {&FRAME-NAME} mes-13 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 13.
END.
IF INPUT FRAME {&FRAME-NAME} mes-14 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 14.
END.
IF INPUT FRAME {&FRAME-NAME} mes-15 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 15.
END.
IF INPUT FRAME {&FRAME-NAME} mes-16 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 16.
END.
IF INPUT FRAME {&FRAME-NAME} mes-17 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 17.
END.
IF INPUT FRAME {&FRAME-NAME} mes-18 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 18.
END.
IF INPUT FRAME {&FRAME-NAME} mes-19 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 19.
END.
IF INPUT FRAME {&FRAME-NAME} mes-20 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 20.
END.
IF INPUT FRAME {&FRAME-NAME} mes-21 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 21.
END.
IF INPUT FRAME {&FRAME-NAME} mes-22 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 22.
END.
IF INPUT FRAME {&FRAME-NAME} mes-23 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 23.
END.
IF INPUT FRAME {&FRAME-NAME} mes-24 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 24.
END.
IF INPUT FRAME {&FRAME-NAME} mes-25 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 25.
END.
IF INPUT FRAME {&FRAME-NAME} mes-26 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 26.
END.
IF INPUT FRAME {&FRAME-NAME} mes-27 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 27.
END.
IF INPUT FRAME {&FRAME-NAME} mes-28 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 28.
END.
IF INPUT FRAME {&FRAME-NAME} mes-29 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 29.
END.
IF INPUT FRAME {&FRAME-NAME} mes-30 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 30.
END.
IF INPUT FRAME {&FRAME-NAME} mes-31 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 2
           prog-agenda.valor = 31.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE gravaSem C-Win 
PROCEDURE gravaSem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INPUT FRAME {&FRAME-NAME} sem-1 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 3
           prog-agenda.valor = 1.
END.
IF INPUT FRAME {&FRAME-NAME} sem-2 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 3
           prog-agenda.valor = 2.
END.
IF INPUT FRAME {&FRAME-NAME} sem-3 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 3
           prog-agenda.valor = 3.
END.
IF INPUT FRAME {&FRAME-NAME} sem-4 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 3
           prog-agenda.valor = 4.
END.
IF INPUT FRAME {&FRAME-NAME} sem-5 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 3
           prog-agenda.valor = 5.
END.
IF INPUT FRAME {&FRAME-NAME} sem-6 THEN DO:
    CREATE prog-agenda.
    ASSIGN prog-agenda.cd-agenda = agenda.cd-agenda
           prog-agenda.id-tipo = 3
           prog-agenda.valor = 6.
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

    FIND FIRST agenda NO-LOCK
        WHERE ROWID(agenda) = rAgend NO-ERROR.
    IF NOT AVAIL agenda THEN RETURN.

    FIND FIRST favorecido OF agenda NO-LOCK.
    ASSIGN fav = favorecido.ds-favorecido.

    IF CAN-FIND(FIRST prog-agenda OF agenda) THEN DO:
        ASSIGN ano-13 = NO
               l-mes = NO.
    END.

    /* Procura A‡Æo Dia NÆo étil */
    FIND FIRST prog-agenda OF agenda NO-LOCK
        WHERE prog-agenda.id-tipo = 0 NO-ERROR.
    IF AVAIL prog-agenda THEN
        ASSIGN dia-n-util = prog-agenda.valor.

    /* Procura Anual */
    FOR EACH prog-agenda OF agenda NO-LOCK
        WHERE prog-agenda.id-tipo = 1:

        IF prog-agenda.todos THEN DO:
            ASSIGN ano-13 = YES.
            LEAVE.
        END.
        IF prog-agenda.num-periodos <> 0 THEN DO:
            ASSIGN ano-14 = YES
                   num-ano = prog-agenda.num-periodos.
            LEAVE.
        END.

        CASE prog-agenda.valor:
            WHEN 1 THEN ASSIGN ano-1 = YES.
            WHEN 2 THEN ASSIGN ano-2 = YES.
            WHEN 3 THEN ASSIGN ano-3 = YES.
            WHEN 4 THEN ASSIGN ano-4 = YES.
            WHEN 5 THEN ASSIGN ano-5 = YES.
            WHEN 6 THEN ASSIGN ano-6 = YES.
            WHEN 7 THEN ASSIGN ano-7 = YES.
            WHEN 8 THEN ASSIGN ano-8 = YES.
            WHEN 9 THEN ASSIGN ano-9 = YES.
            WHEN 10 THEN ASSIGN ano-10 = YES.
            WHEN 11 THEN ASSIGN ano-11 = YES.
            WHEN 12 THEN ASSIGN ano-12 = YES.
        END CASE.

    END.

    /* Procura Mensal */

    IF CAN-FIND(FIRST prog-agenda OF agenda NO-LOCK
                WHERE prog-agenda.id-tipo = 2) THEN DO:
        ASSIGN l-mes = YES.
    END.
    ELSE DO:
        ASSIGN l-mes = NO.
    END.

    FOR EACH prog-agenda OF agenda NO-LOCK
        WHERE prog-agenda.id-tipo = 2:

        IF prog-agenda.num-periodos <> 0 THEN DO:
            ASSIGN mes-33 = YES
                   num-mes = prog-agenda.num-periodos.
            LEAVE.
        END.
        IF prog-agenda.ultimo THEN DO:
            ASSIGN mes-32 = YES.
            NEXT.
        END.

        CASE prog-agenda.valor:
            WHEN 1 THEN ASSIGN mes-1 = YES.
            WHEN 2 THEN ASSIGN mes-2 = YES.
            WHEN 3 THEN ASSIGN mes-3 = YES.
            WHEN 4 THEN ASSIGN mes-4 = YES.
            WHEN 5 THEN ASSIGN mes-5 = YES.
            WHEN 6 THEN ASSIGN mes-6 = YES.
            WHEN 7 THEN ASSIGN mes-7 = YES.
            WHEN 8 THEN ASSIGN mes-8 = YES.
            WHEN 9 THEN ASSIGN mes-9 = YES.
            WHEN 10 THEN ASSIGN mes-10 = YES.
            WHEN 11 THEN ASSIGN mes-11 = YES.
            WHEN 12 THEN ASSIGN mes-12 = YES.
            WHEN 13 THEN ASSIGN mes-13 = YES.
            WHEN 14 THEN ASSIGN mes-14 = YES.
            WHEN 15 THEN ASSIGN mes-15 = YES.
            WHEN 16 THEN ASSIGN mes-16 = YES.
            WHEN 17 THEN ASSIGN mes-17 = YES.
            WHEN 18 THEN ASSIGN mes-18 = YES.
            WHEN 19 THEN ASSIGN mes-19 = YES.
            WHEN 20 THEN ASSIGN mes-20 = YES.
            WHEN 21 THEN ASSIGN mes-21 = YES.
            WHEN 22 THEN ASSIGN mes-22 = YES.
            WHEN 23 THEN ASSIGN mes-23 = YES.
            WHEN 24 THEN ASSIGN mes-24 = YES.
            WHEN 25 THEN ASSIGN mes-25 = YES.
            WHEN 26 THEN ASSIGN mes-26 = YES.
            WHEN 27 THEN ASSIGN mes-27 = YES.
            WHEN 28 THEN ASSIGN mes-28 = YES.
            WHEN 29 THEN ASSIGN mes-29 = YES.
            WHEN 30 THEN ASSIGN mes-30 = YES.
            WHEN 31 THEN ASSIGN mes-31 = YES.
        END CASE.

    END.

    /* Procura Semanal */

    FOR EACH prog-agenda OF agenda NO-LOCK
        WHERE prog-agenda.id-tipo = 3:

        IF prog-agenda.todos THEN DO:
            ASSIGN sem-8 = YES.
            LEAVE.
        END.
        IF prog-agenda.ultimo THEN DO:
            ASSIGN sem-7 = YES.
            NEXT.
        END.

        CASE prog-agenda.valor:
            WHEN 1 THEN ASSIGN sem-1 = YES.
            WHEN 2 THEN ASSIGN sem-2 = YES.
            WHEN 3 THEN ASSIGN sem-3 = YES.
            WHEN 4 THEN ASSIGN sem-4 = YES.
            WHEN 5 THEN ASSIGN sem-5 = YES.
            WHEN 6 THEN ASSIGN sem-6 = YES.
        END CASE.

    END.

    /* Procura Di rio */
    IF CAN-FIND(FIRST prog-agenda OF agenda NO-LOCK
                WHERE prog-agenda.id-tipo = 4) THEN DO:
        ASSIGN l-dia = YES.
    END.
    ELSE DO:
        ASSIGN l-dia = NO.
    END.

    FOR EACH prog-agenda OF agenda NO-LOCK
        WHERE prog-agenda.id-tipo = 4:

        IF prog-agenda.todos THEN DO:
            ASSIGN dia-8 = YES.
            LEAVE.
        END.

        CASE prog-agenda.valor:
            WHEN 1 THEN ASSIGN dia-1 = YES.
            WHEN 2 THEN ASSIGN dia-2 = YES.
            WHEN 3 THEN ASSIGN dia-3 = YES.
            WHEN 4 THEN ASSIGN dia-4 = YES.
            WHEN 5 THEN ASSIGN dia-5 = YES.
            WHEN 6 THEN ASSIGN dia-6 = YES.
            WHEN 7 THEN ASSIGN dia-7 = YES.
        END CASE.

    END.

    /* Procura Adi‡Æo de Dias éteis */
    FIND FIRST prog-agenda OF agenda NO-LOCK
        WHERE prog-agenda.id-tipo = 5 NO-ERROR.
    IF AVAIL prog-agenda THEN
        ASSIGN i-dias-uteis = prog-agenda.valor.
    ELSE
        ASSIGN i-dias-uteis = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

