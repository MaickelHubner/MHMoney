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
&GLOBAL-DEFINE Table        item-poupanca
&GLOBAL-DEFINE Parent       poupanca
&GLOBAL-DEFINE ParentField  cd-poupanca
&GLOBAL-DEFINE KeyFields    item-poupanca.ano
&GLOBAL-DEFINE FrameFields  item-poupanca.pc-juros item-poupanca.vl-deposito ~
                            item-poupanca.vl-espontaneo[1] item-poupanca.vl-espontaneo[2] ~
                            item-poupanca.vl-espontaneo[3] item-poupanca.vl-espontaneo[4] ~
                            item-poupanca.vl-espontaneo[5] item-poupanca.vl-espontaneo[6] ~
                            item-poupanca.vl-espontaneo[7] item-poupanca.vl-espontaneo[8] ~
                            item-poupanca.vl-espontaneo[9] item-poupanca.vl-espontaneo[10] ~
                            item-poupanca.vl-espontaneo[11] item-poupanca.vl-espontaneo[12]
&GLOBAL-DEFINE FrameDisp    poupanca.ds-poupanca

/* Local Variable Definitions ---                                       */


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
&Scoped-Define ENABLED-FIELDS item-poupanca.cd-poupanca item-poupanca.ano ~
item-poupanca.vl-deposito item-poupanca.pc-juros ~
item-poupanca.vl-espontaneo[1] item-poupanca.vl-espontaneo[2] ~
item-poupanca.vl-espontaneo[3] item-poupanca.vl-espontaneo[4] ~
item-poupanca.vl-espontaneo[5] item-poupanca.vl-espontaneo[6] ~
item-poupanca.vl-espontaneo[7] item-poupanca.vl-espontaneo[8] ~
item-poupanca.vl-espontaneo[9] item-poupanca.vl-espontaneo[10] ~
item-poupanca.vl-espontaneo[11] item-poupanca.vl-espontaneo[12] 
&Scoped-define ENABLED-TABLES item-poupanca
&Scoped-define FIRST-ENABLED-TABLE item-poupanca
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-4 
&Scoped-Define DISPLAYED-FIELDS item-poupanca.cd-poupanca ~
poupanca.ds-poupanca item-poupanca.ano item-poupanca.vl-deposito ~
item-poupanca.pc-juros item-poupanca.vl-espontaneo[1] ~
item-poupanca.vl-espontaneo[2] item-poupanca.vl-espontaneo[3] ~
item-poupanca.vl-espontaneo[4] item-poupanca.vl-espontaneo[5] ~
item-poupanca.vl-espontaneo[6] item-poupanca.vl-espontaneo[7] ~
item-poupanca.vl-espontaneo[8] item-poupanca.vl-espontaneo[9] ~
item-poupanca.vl-espontaneo[10] item-poupanca.vl-espontaneo[11] ~
item-poupanca.vl-espontaneo[12] 
&Scoped-define DISPLAYED-TABLES item-poupanca poupanca
&Scoped-define FIRST-DISPLAYED-TABLE item-poupanca
&Scoped-define SECOND-DISPLAYED-TABLE poupanca


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

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 52 BY 8.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 15.75 COL 74.14
     item-poupanca.cd-poupanca AT ROW 1.5 COL 16 COLON-ALIGNED
          LABEL "Poupanáa"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     poupanca.ds-poupanca AT ROW 1.5 COL 21.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     btOK AT ROW 15.75 COL 68
     item-poupanca.ano AT ROW 3.25 COL 37 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     item-poupanca.vl-deposito AT ROW 4.25 COL 37 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY .79
     item-poupanca.pc-juros AT ROW 5.25 COL 37 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9 BY .79
     item-poupanca.vl-espontaneo[1] AT ROW 7.75 COL 26 COLON-ALIGNED
          LABEL "Janeiro"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[2] AT ROW 9 COL 26 COLON-ALIGNED
          LABEL "Fevereiro"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[3] AT ROW 10.25 COL 26 COLON-ALIGNED
          LABEL "Maráo"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[4] AT ROW 11.5 COL 26 COLON-ALIGNED
          LABEL "Abril"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[5] AT ROW 12.75 COL 26 COLON-ALIGNED
          LABEL "Maio"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[6] AT ROW 14 COL 26 COLON-ALIGNED
          LABEL "Junho"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[7] AT ROW 7.75 COL 51 COLON-ALIGNED
          LABEL "Julho"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[8] AT ROW 9 COL 51 COLON-ALIGNED
          LABEL "Agosto"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[9] AT ROW 10.25 COL 51 COLON-ALIGNED
          LABEL "Setembro"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[10] AT ROW 11.5 COL 51 COLON-ALIGNED
          LABEL "Outubro"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[11] AT ROW 12.75 COL 51 COLON-ALIGNED
          LABEL "Novembro"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     item-poupanca.vl-espontaneo[12] AT ROW 14 COL 51 COLON-ALIGNED
          LABEL "Dezembro"
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     "EspontÉneo" VIEW-AS TEXT
          SIZE 9 BY .67 AT ROW 6.5 COL 18
     RECT-2 AT ROW 1.25 COL 2
     RECT-4 AT ROW 6.75 COL 16
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16.79
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
         TITLE              = "Template Padr∆o de Detalhe"
         HEIGHT             = 16.79
         WIDTH              = 80
         MAX-HEIGHT         = 30.04
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 30.04
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
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.cd-poupanca IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN poupanca.ds-poupanca IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[10] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[11] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[12] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[1] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[2] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[3] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[4] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[5] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[6] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[7] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[8] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN item-poupanca.vl-espontaneo[9] IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Template Padr∆o de Detalhe */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Detalhe */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.ano C-Win
ON ENTRY OF item-poupanca.ano IN FRAME DEFAULT-FRAME /* Ano */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.ano C-Win
ON LEAVE OF item-poupanca.ano IN FRAME DEFAULT-FRAME /* Ano */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cad_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    {func\bt_cad_ok.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.pc-juros
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.pc-juros C-Win
ON ENTRY OF item-poupanca.pc-juros IN FRAME DEFAULT-FRAME /* Juros Mensal */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.pc-juros C-Win
ON LEAVE OF item-poupanca.pc-juros IN FRAME DEFAULT-FRAME /* Juros Mensal */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-deposito C-Win
ON ENTRY OF item-poupanca.vl-deposito IN FRAME DEFAULT-FRAME /* Valor Mensal */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-deposito C-Win
ON LEAVE OF item-poupanca.vl-deposito IN FRAME DEFAULT-FRAME /* Valor Mensal */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[10]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[10] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[10] IN FRAME DEFAULT-FRAME /* Outubro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[10] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[10] IN FRAME DEFAULT-FRAME /* Outubro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[11]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[11] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[11] IN FRAME DEFAULT-FRAME /* Novembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[11] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[11] IN FRAME DEFAULT-FRAME /* Novembro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[12]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[12] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[12] IN FRAME DEFAULT-FRAME /* Dezembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[12] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[12] IN FRAME DEFAULT-FRAME /* Dezembro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[1]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[1] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[1] IN FRAME DEFAULT-FRAME /* Janeiro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[1] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[1] IN FRAME DEFAULT-FRAME /* Janeiro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[2]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[2] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[2] IN FRAME DEFAULT-FRAME /* Fevereiro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[2] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[2] IN FRAME DEFAULT-FRAME /* Fevereiro */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[3]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[3] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[3] IN FRAME DEFAULT-FRAME /* Maráo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[3] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[3] IN FRAME DEFAULT-FRAME /* Maráo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[4]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[4] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[4] IN FRAME DEFAULT-FRAME /* Abril */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[4] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[4] IN FRAME DEFAULT-FRAME /* Abril */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[5]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[5] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[5] IN FRAME DEFAULT-FRAME /* Maio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[5] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[5] IN FRAME DEFAULT-FRAME /* Maio */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[6]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[6] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[6] IN FRAME DEFAULT-FRAME /* Junho */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[6] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[6] IN FRAME DEFAULT-FRAME /* Junho */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[7]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[7] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[7] IN FRAME DEFAULT-FRAME /* Julho */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[7] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[7] IN FRAME DEFAULT-FRAME /* Julho */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[8]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[8] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[8] IN FRAME DEFAULT-FRAME /* Agosto */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[8] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[8] IN FRAME DEFAULT-FRAME /* Agosto */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-poupanca.vl-espontaneo[9]
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[9] C-Win
ON ENTRY OF item-poupanca.vl-espontaneo[9] IN FRAME DEFAULT-FRAME /* Setembro */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-poupanca.vl-espontaneo[9] C-Win
ON LEAVE OF item-poupanca.vl-espontaneo[9] IN FRAME DEFAULT-FRAME /* Setembro */
DO:
    {func\set_leave.i}    
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
  {version.i item-poupanca_det}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

{func\detalhe\display.i}

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
  IF AVAILABLE item-poupanca THEN 
    DISPLAY item-poupanca.cd-poupanca item-poupanca.ano item-poupanca.vl-deposito 
          item-poupanca.pc-juros item-poupanca.vl-espontaneo[1] 
          item-poupanca.vl-espontaneo[2] item-poupanca.vl-espontaneo[3] 
          item-poupanca.vl-espontaneo[4] item-poupanca.vl-espontaneo[5] 
          item-poupanca.vl-espontaneo[6] item-poupanca.vl-espontaneo[7] 
          item-poupanca.vl-espontaneo[8] item-poupanca.vl-espontaneo[9] 
          item-poupanca.vl-espontaneo[10] item-poupanca.vl-espontaneo[11] 
          item-poupanca.vl-espontaneo[12] 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE poupanca THEN 
    DISPLAY poupanca.ds-poupanca 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE item-poupanca.cd-poupanca item-poupanca.ano item-poupanca.vl-deposito 
         item-poupanca.pc-juros item-poupanca.vl-espontaneo[1] 
         item-poupanca.vl-espontaneo[2] item-poupanca.vl-espontaneo[3] 
         item-poupanca.vl-espontaneo[4] item-poupanca.vl-espontaneo[5] 
         item-poupanca.vl-espontaneo[6] item-poupanca.vl-espontaneo[7] 
         item-poupanca.vl-espontaneo[8] item-poupanca.vl-espontaneo[9] 
         item-poupanca.vl-espontaneo[10] item-poupanca.vl-espontaneo[11] 
         item-poupanca.vl-espontaneo[12] RECT-2 RECT-4 
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

{func\detalhe\initialize.i}

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

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-item-poupanca NO-LOCK
        WHERE bf-item-poupanca.cd-poupanca        = INPUT FRAME {&FRAME-NAME} item-poupanca.cd-poupanca
        AND   bf-item-poupanca.ano  = INPUT FRAME {&FRAME-NAME} item-poupanca.ano
        AND   ROWID(bf-item-poupanca) <> ROWID(item-poupanca) NO-ERROR.
    IF AVAIL bf-item-poupanca THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

