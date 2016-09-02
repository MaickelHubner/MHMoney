&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
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
DEFINE OUTPUT PARAMETER pdtReturn AS DATE       NO-UNDO.

/* Local Variable Definitions ---                                       */

{seg.i}

{func\data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bt-ant mes ano bt-dia-11 bt-dia-12 bt-dia-13 ~
bt-dia-14 bt-dia-15 bt-dia-16 bt-dia-17 bt-prox bt-dia-21 bt-dia-61 ~
bt-dia-62 bt-dia-63 bt-dia-41 bt-dia-64 bt-dia-65 bt-dia-51 bt-dia-66 ~
bt-dia-52 bt-dia-42 bt-dia-67 bt-dia-31 bt-dia-43 bt-dia-53 bt-dia-32 ~
bt-dia-54 bt-dia-44 bt-dia-55 bt-dia-45 bt-dia-56 bt-dia-46 bt-dia-33 ~
bt-dia-47 bt-dia-22 bt-dia-57 bt-dia-34 bt-dia-23 bt-dia-35 bt-dia-24 ~
bt-dia-36 bt-dia-25 bt-dia-37 bt-dia-26 bt-dia-27 FILL-IN-2 FILL-IN-3 ~
FILL-IN-4 FILL-IN-5 FILL-IN-6 FILL-IN-7 FILL-IN-8 
&Scoped-Define DISPLAYED-OBJECTS mes ano FILL-IN-2 FILL-IN-3 FILL-IN-4 ~
FILL-IN-5 FILL-IN-6 FILL-IN-7 FILL-IN-8 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt-ant  NO-FOCUS FLAT-BUTTON
     LABEL "<<" 
     SIZE 5 BY .88 TOOLTIP "Mˆs Anterior".

DEFINE BUTTON bt-dia-11  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-12  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-13  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-14  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-15  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-16  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-17  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-21  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-22  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-23  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-24  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-25  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-26  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-27  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-31  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-32  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-33  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-34  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-35  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-36  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-37  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-41  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-42  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-43  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-44  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-45  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-46  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-47  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-51  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-52  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-53  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-54  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-55  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-56  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-57  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-61  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-62  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-63  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-64  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-65  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-66  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-dia-67  NO-FOCUS FLAT-BUTTON
     LABEL "0" 
     SIZE 4 BY .88.

DEFINE BUTTON bt-prox  NO-FOCUS FLAT-BUTTON
     LABEL ">>" 
     SIZE 5 BY .88 TOOLTIP "Pr¢ximo Mˆs".

DEFINE VARIABLE mes AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 5
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
     SIZE 13 BY 1 NO-UNDO.

DEFINE VARIABLE ano AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE VARIABLE FILL-IN-2 AS CHARACTER FORMAT "X(256)":U INITIAL " Dom" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE FILL-IN-3 AS CHARACTER FORMAT "X(256)":U INITIAL " Seg" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE FILL-IN-4 AS CHARACTER FORMAT "X(256)":U INITIAL " Ter" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE FILL-IN-5 AS CHARACTER FORMAT "X(256)":U INITIAL " Qua" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE FILL-IN-6 AS CHARACTER FORMAT "X(256)":U INITIAL " Qui" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE FILL-IN-7 AS CHARACTER FORMAT "X(256)":U INITIAL " Sex" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE FILL-IN-8 AS CHARACTER FORMAT "X(256)":U INITIAL " Sab" 
      VIEW-AS TEXT 
     SIZE 4 BY .67
     BGCOLOR 22 FGCOLOR 15  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     bt-ant AT ROW 1 COL 1
     mes AT ROW 1 COL 4 COLON-ALIGNED NO-LABEL
     ano AT ROW 1 COL 16.86 COLON-ALIGNED NO-LABEL
     bt-dia-11 AT ROW 2.75 COL 1
     bt-dia-12 AT ROW 2.75 COL 5
     bt-dia-13 AT ROW 2.75 COL 9
     bt-dia-14 AT ROW 2.75 COL 13
     bt-dia-15 AT ROW 2.75 COL 17
     bt-dia-16 AT ROW 2.75 COL 21
     bt-dia-17 AT ROW 2.75 COL 25
     bt-prox AT ROW 1 COL 24
     bt-dia-21 AT ROW 3.63 COL 1
     bt-dia-61 AT ROW 7.25 COL 1
     bt-dia-62 AT ROW 7.25 COL 5
     bt-dia-63 AT ROW 7.25 COL 9
     bt-dia-41 AT ROW 5.42 COL 1
     bt-dia-64 AT ROW 7.25 COL 13
     bt-dia-65 AT ROW 7.25 COL 17
     bt-dia-51 AT ROW 6.33 COL 1
     bt-dia-66 AT ROW 7.25 COL 21
     bt-dia-52 AT ROW 6.33 COL 5
     bt-dia-42 AT ROW 5.42 COL 5
     bt-dia-67 AT ROW 7.25 COL 25
     bt-dia-31 AT ROW 4.5 COL 1
     bt-dia-43 AT ROW 5.42 COL 9
     bt-dia-53 AT ROW 6.33 COL 9
     bt-dia-32 AT ROW 4.5 COL 5
     bt-dia-54 AT ROW 6.33 COL 13
     bt-dia-44 AT ROW 5.42 COL 13
     bt-dia-55 AT ROW 6.33 COL 17
     bt-dia-45 AT ROW 5.42 COL 17
     bt-dia-56 AT ROW 6.33 COL 21
     bt-dia-46 AT ROW 5.42 COL 21
     bt-dia-33 AT ROW 4.5 COL 9
     bt-dia-47 AT ROW 5.42 COL 25
     bt-dia-22 AT ROW 3.63 COL 5
     bt-dia-57 AT ROW 6.33 COL 25
     bt-dia-34 AT ROW 4.5 COL 13
     bt-dia-23 AT ROW 3.63 COL 9
     bt-dia-35 AT ROW 4.5 COL 17
     bt-dia-24 AT ROW 3.63 COL 13
     bt-dia-36 AT ROW 4.5 COL 21
     bt-dia-25 AT ROW 3.63 COL 17
     bt-dia-37 AT ROW 4.5 COL 25
     bt-dia-26 AT ROW 3.63 COL 21
     bt-dia-27 AT ROW 3.63 COL 25
     FILL-IN-2 AT ROW 2 COL 1 NO-LABEL
     FILL-IN-3 AT ROW 2 COL 5 NO-LABEL
     FILL-IN-4 AT ROW 2 COL 9 NO-LABEL
     FILL-IN-5 AT ROW 2 COL 13 NO-LABEL
     FILL-IN-6 AT ROW 2 COL 17 NO-LABEL
     FILL-IN-7 AT ROW 2 COL 21 NO-LABEL
     FILL-IN-8 AT ROW 2 COL 25 NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 28 BY 7.13
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
         TITLE              = "Calend rio"
         HEIGHT             = 7.13
         WIDTH              = 28
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
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
                                                                        */
/* SETTINGS FOR FILL-IN FILL-IN-2 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN FILL-IN-3 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN FILL-IN-4 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN FILL-IN-5 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN FILL-IN-6 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN FILL-IN-7 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN FILL-IN-8 IN FRAME DEFAULT-FRAME
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Calend rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Calend rio */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN "NOK".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON VALUE-CHANGED OF ano IN FRAME DEFAULT-FRAME
DO:
  
    RUN displayMes IN THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON VALUE-CHANGED OF mes IN FRAME DEFAULT-FRAME
DO:
  
    RUN displayMes IN THIS-PROCEDURE.

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

ON 'CHOOSE':U ANYWHERE
DO:
    RUN som.p(INPUT "music\click.wav").
    ASSIGN INPUT FRAME {&FRAME-NAME} mes ano.
    CASE SELF:LABEL IN FRAME {&FRAME-NAME}:
        WHEN "<<" THEN DO:
            IF mes <> 1 THEN DO:
                ASSIGN mes = mes - 1.
            END.
            ELSE DO:
                ASSIGN mes = 12
                       ano = ano - 1.
            END.
            RUN displayFields IN THIS-PROCEDURE.
        END.
        WHEN ">>" THEN DO:
            IF mes <> 12 THEN DO:
                ASSIGN mes = mes + 1.
            END.
            ELSE DO:
                ASSIGN mes = 1
                       ano = ano + 1.
            END.
            RUN displayFields IN THIS-PROCEDURE.
        END.
        OTHERWISE DO:
            ASSIGN pdtReturn = DATE(mes,INT(SELF:LABEL IN FRAME {&FRAME-NAME}),ano).
            APPLY "CLOSE" TO THIS-PROCEDURE.
            RETURN "OK".
        END.
    END CASE.
END.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i calendar}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE controlaBotoes C-Win 
PROCEDURE controlaBotoes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

        IF bt-dia-11:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-11:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-11 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-12:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-12:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-12 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-13 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-13 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-14:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-14:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-14 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-15:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-15:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-15 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-16:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-16:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-16 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-51:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-51:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-51 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-52:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-52:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-52 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-53:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-53:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-53 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-54:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-54:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-54 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-55:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-55:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-55 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-56:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-56:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-56 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-57:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-57:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-57 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-61:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-61:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-61 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-62:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-62:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-62 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-63:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-63:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-63 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-64:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-64:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-64 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-65:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-65:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-65 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-66:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-66:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-66 WITH FRAME {&FRAME-NAME}.
        END.
        IF bt-dia-67:LABEL IN FRAME {&FRAME-NAME} = "0" THEN DO:
            ASSIGN bt-dia-67:LABEL IN FRAME {&FRAME-NAME} = "".
            DISABLE bt-dia-67 WITH FRAME {&FRAME-NAME}.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayFields C-Win 
PROCEDURE displayFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DISPLAY mes
            ano WITH FRAME {&FRAME-NAME}.


    RUN displayMes IN THIS-PROCEDURE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE displayMes C-Win 
PROCEDURE displayMes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iColuna AS INTEGER    NO-UNDO INITIAL 1.
    
    RUN zeraBotoes IN THIS-PROCEDURE.

    REPEAT iCont = 1 TO DAY(fnUltimoDia(INPUT FRAME {&FRAME-NAME} mes,
                                          INPUT FRAME {&FRAME-NAME} ano)):

        CASE WEEKDAY(DATE(INPUT FRAME {&FRAME-NAME} mes,iCont,INPUT FRAME {&FRAME-NAME} ano)):
            WHEN 1 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-11:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-21:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-31:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-41:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-51:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-61:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
            WHEN 2 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-12:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-22:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-32:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-42:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-52:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-62:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
            WHEN 3 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-23:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-33:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-43:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-53:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-63:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
            WHEN 4 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-14:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-24:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-34:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-44:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-54:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-64:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
            WHEN 5 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-15:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-25:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-35:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-45:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-55:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-65:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
            WHEN 6 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-16:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-26:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-36:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-46:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-56:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-66:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
            WHEN 7 THEN DO:
                CASE iColuna:
                    WHEN 1 THEN DO:
                        ASSIGN bt-dia-17:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 2 THEN DO:
                        ASSIGN bt-dia-27:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 3 THEN DO:
                        ASSIGN bt-dia-37:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 4 THEN DO:
                        ASSIGN bt-dia-47:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 5 THEN DO:
                        ASSIGN bt-dia-57:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                    WHEN 6 THEN DO:
                        ASSIGN bt-dia-67:LABEL IN FRAME {&FRAME-NAME} = STRING(iCont).
                    END.
                END CASE.
            END.
        END CASE.

        IF WEEKDAY(DATE(INPUT FRAME {&FRAME-NAME} mes,iCont,INPUT FRAME {&FRAME-NAME} ano)) = 7 THEN DO:
            ASSIGN iColuna = iColuna + 1.
        END.

    END.

    RUN controlaBotoes IN THIS-PROCEDURE.

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
  DISPLAY mes ano FILL-IN-2 FILL-IN-3 FILL-IN-4 FILL-IN-5 FILL-IN-6 FILL-IN-7 
          FILL-IN-8 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE bt-ant mes ano bt-dia-11 bt-dia-12 bt-dia-13 bt-dia-14 bt-dia-15 
         bt-dia-16 bt-dia-17 bt-prox bt-dia-21 bt-dia-61 bt-dia-62 bt-dia-63 
         bt-dia-41 bt-dia-64 bt-dia-65 bt-dia-51 bt-dia-66 bt-dia-52 bt-dia-42 
         bt-dia-67 bt-dia-31 bt-dia-43 bt-dia-53 bt-dia-32 bt-dia-54 bt-dia-44 
         bt-dia-55 bt-dia-45 bt-dia-56 bt-dia-46 bt-dia-33 bt-dia-47 bt-dia-22 
         bt-dia-57 bt-dia-34 bt-dia-23 bt-dia-35 bt-dia-24 bt-dia-36 bt-dia-25 
         bt-dia-37 bt-dia-26 bt-dia-27 FILL-IN-2 FILL-IN-3 FILL-IN-4 FILL-IN-5 
         FILL-IN-6 FILL-IN-7 FILL-IN-8 
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

    ASSIGN mes = MONTH(TODAY)
           ano = YEAR(TODAY).

    RUN displayFields.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE zeraBotoes C-Win 
PROCEDURE zeraBotoes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN bt-dia-11:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-12:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-13:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-14:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-15:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-16:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-51:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-52:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-53:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-54:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-55:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-56:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-57:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-61:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-62:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-63:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-64:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-65:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-66:LABEL IN FRAME {&FRAME-NAME} = "0"
        bt-dia-67:LABEL IN FRAME {&FRAME-NAME} = "0".

ENABLE  bt-dia-11 
        bt-dia-12 
        bt-dia-13 
        bt-dia-13 
        bt-dia-14 
        bt-dia-15 
        bt-dia-16 
        bt-dia-51 
        bt-dia-52 
        bt-dia-53 
        bt-dia-54 
        bt-dia-55 
        bt-dia-56 
        bt-dia-57 
        bt-dia-61 
        bt-dia-62 
        bt-dia-63 
        bt-dia-64 
        bt-dia-65 
        bt-dia-66 
        bt-dia-67 WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

