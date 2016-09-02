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

DEFINE INPUT  PARAMETER rAlerta AS ROWID      NO-UNDO.
DEFINE INPUT  PARAMETER rExc    AS ROWID      NO-UNDO.

/* Local Variable Definitions ---                                       */

{seg.i}

FIND FIRST alerta WHERE ROWID(alerta) = rAlerta NO-LOCK.

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS alerta-exc.cd-conta alerta-exc.cd-favorecido ~
alerta-exc.cod-categoria alerta-exc.cd-sub alerta-exc.outro-valor 
&Scoped-define ENABLED-TABLES alerta-exc
&Scoped-define FIRST-ENABLED-TABLE alerta-exc
&Scoped-Define ENABLED-OBJECTS btCan RECT-10 RECT-6 RECT-7 tipo btInc 
&Scoped-Define DISPLAYED-FIELDS alerta-exc.cd-conta ~
alerta-exc.cd-favorecido alerta-exc.cod-categoria alerta-exc.cd-sub ~
alerta-exc.outro-valor alerta-exc.valor-maximo alerta-exc.percentual ~
alerta-exc.valor-minimo alerta-exc.periodo alerta-exc.num-dias 
&Scoped-define DISPLAYED-TABLES alerta-exc
&Scoped-define FIRST-DISPLAYED-TABLE alerta-exc
&Scoped-Define DISPLAYED-OBJECTS tipo ds-conta ds-fav ds-cat ds-sub 

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
DEFINE BUTTON btCan 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6 BY 1.79.

DEFINE BUTTON btInc 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "OK" 
     SIZE 6 BY 1.79.

DEFINE VARIABLE tipo AS INTEGER FORMAT "9":U INITIAL 0 
     LABEL "Exceá∆o de" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Categoria\Sub-Categoria",1,
                     "Favorecido",2,
                     "Conta",3
     DROP-DOWN-LIST
     SIZE 24 BY .88 NO-UNDO.

DEFINE VARIABLE ds-cat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE ds-conta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE ds-fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE ds-sub AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 5.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 4.75.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 15 BY 2.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCan AT ROW 13.5 COL 62.14
     tipo AT ROW 1.75 COL 23 COLON-ALIGNED
     alerta-exc.cd-conta AT ROW 3.75 COL 12.72 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     ds-conta AT ROW 3.75 COL 18 COLON-ALIGNED NO-LABEL
     btInc AT ROW 13.5 COL 56
     alerta-exc.cd-favorecido AT ROW 4.75 COL 12.72 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     ds-fav AT ROW 4.75 COL 18 COLON-ALIGNED NO-LABEL
     alerta-exc.cod-categoria AT ROW 5.75 COL 12.72 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     ds-cat AT ROW 5.75 COL 18 COLON-ALIGNED NO-LABEL
     alerta-exc.cd-sub AT ROW 6.75 COL 12.72 COLON-ALIGNED
          LABEL "Sub-Categoria"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     ds-sub AT ROW 6.75 COL 18 COLON-ALIGNED NO-LABEL
     alerta-exc.outro-valor AT ROW 8.25 COL 4
          VIEW-AS TOGGLE-BOX
          SIZE 11 BY .83
     alerta-exc.valor-maximo AT ROW 9.25 COL 21 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     alerta-exc.percentual AT ROW 9.25 COL 49 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY .79
     alerta-exc.valor-minimo AT ROW 10.25 COL 21 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12.57 BY .79
     alerta-exc.periodo AT ROW 10.5 COL 53 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Mensal", 1,
"Anual", 2,
"No Per°odo", 3
          SIZE 12 BY 2
     alerta-exc.num-dias AT ROW 11.25 COL 21 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4.57 BY .79
     RECT-10 AT ROW 3.25 COL 2
     RECT-6 AT ROW 8.5 COL 2
     RECT-7 AT ROW 10.25 COL 51
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 67.43 BY 14.5
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
         TITLE              = "Exceá‰es"
         HEIGHT             = 14.5
         WIDTH              = 67.43
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
                                                                        */
/* SETTINGS FOR FILL-IN alerta-exc.cd-conta IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN alerta-exc.cd-sub IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN ds-cat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-sub IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN alerta-exc.num-dias IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN alerta-exc.percentual IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET alerta-exc.periodo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN alerta-exc.valor-maximo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN alerta-exc.valor-minimo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Exceá‰es */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Exceá‰es */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCan C-Win
ON CHOOSE OF btCan IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
  
    {func\bt_fechar.i}
    IF rExc = ? THEN
        DELETE alerta-exc.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btInc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btInc C-Win
ON CHOOSE OF btInc IN FRAME DEFAULT-FRAME /* OK */
DO:

    DEFINE VARIABLE lErro AS LOGICAL    NO-UNDO INITIAL NO.
  
    RUN som.p(INPUT "music\click.wav").

    IF INPUT FRAME default-frame tipo = 3 
        AND alerta.tipo <> 3
        AND alerta.tipo <> 5 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Validaá∆o (035)', INPUT 'Exceá∆o de conta n∆o permitida!', INPUT 'N∆o Ç permitida uma exceá∆o de conta para esse tipo de alerta.')"}
        ASSIGN lErro = YES.
    END.

    IF INPUT FRAME default-frame tipo <> 3 AND alerta.tipo = 3 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Validaá∆o (035)', INPUT 'Exceá∆o n∆o permitida!', INPUT 'N∆o Ç permitida esta exceá∆o para alerta de saldo.')"}
        ASSIGN lErro = YES.
    END.

    IF INPUT FRAME default-frame tipo = 2 
        AND alerta.tipo > 3
        AND alerta.tipo <> 5 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Validaá∆o (035)', INPUT 'Exceá∆o de favorecido n∆o permitida!', INPUT 'N∆o Ç permitida uma exceá∆o de favorecido para um alerta de valores.')"}
        ASSIGN lErro = YES.
    END.

    IF INPUT FRAME default-frame alerta-exc.cd-sub <> 0 AND
       INPUT FRAME default-frame alerta-exc.cod-categoria = 0 THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Validaá∆o (035)', INPUT 'Categoria inv†lida!', INPUT 'N∆o foi informada uma categoria v†lida para a exceá∆o.')"}
        ASSIGN lErro = YES.
    END.

    IF NOT lErro THEN DO:
    
        FIND CURRENT alerta-exc EXCLUSIVE-LOCK.
        ASSIGN alerta-exc.usuario = alerta.usuario
               alerta-exc.tipo = alerta.tipo.
        ASSIGN INPUT FRAME default-frame alerta-exc.cd-conta
                                alerta-exc.cd-favorecido
                                alerta-exc.cod-categoria
                                alerta-exc.cd-sub
                                alerta-exc.valor-maximo
                                alerta-exc.valor-minimo
                                alerta-exc.num-dias
                                alerta-exc.percentual
                                alerta-exc.periodo
                                alerta-exc.outro-valor.
        APPLY "CLOSE" TO THIS-PROCEDURE.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-conta C-Win
ON ENTRY OF alerta-exc.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-conta C-Win
ON LEAVE OF alerta-exc.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:

    {func\set_leave.i}  
    ASSIGN ds-conta:SCREEN-VALUE IN FRAME default-frame = fnDesc("CT",INPUT FRAME default-frame alerta-exc.cd-conta,0).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-conta C-Win
ON MOUSE-SELECT-DBLCLICK OF alerta-exc.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
OR F5 OF alerta-exc.cd-conta DO:
  
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.

    RUN zoom/zconta.w(OUTPUT iTemp).
    IF iTemp <> 0 THEN DO:
        ASSIGN alerta-exc.cd-conta:SCREEN-VALUE IN FRAME default-frame = STRING(iTemp)
               ds-conta:SCREEN-VALUE IN FRAME default-frame = fnDesc("CT",INPUT FRAME default-frame alerta-exc.cd-conta,0).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-favorecido C-Win
ON ENTRY OF alerta-exc.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-favorecido C-Win
ON LEAVE OF alerta-exc.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:

    {func\set_leave.i}  
    ASSIGN ds-fav:SCREEN-VALUE IN FRAME default-frame = fnDesc("F",INPUT FRAME default-frame alerta-exc.cd-favorecido,0).
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF alerta-exc.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
OR F5 OF alerta-exc.cd-favorecido DO:
  
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.

    RUN zoom/zfav.w(OUTPUT iTemp).
    IF iTemp <> 0 THEN DO:
        ASSIGN alerta-exc.cd-favorecido:SCREEN-VALUE IN FRAME default-frame = STRING(iTemp)
               ds-fav:SCREEN-VALUE IN FRAME default-frame = fnDesc("F",INPUT FRAME default-frame alerta-exc.cd-favorecido,0).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-sub C-Win
ON ENTRY OF alerta-exc.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-sub C-Win
ON LEAVE OF alerta-exc.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:

    {func\set_leave.i}  
    ASSIGN ds-sub:SCREEN-VALUE IN FRAME default-frame = fnDesc("S",INPUT FRAME default-frame alerta-exc.cod-categoria,INPUT FRAME default-frame alerta-exc.cd-sub).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cd-sub C-Win
ON MOUSE-SELECT-DBLCLICK OF alerta-exc.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
OR F5 OF alerta-exc.cd-sub DO:
  
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.

    RUN zoom/zsubcat.w(INPUT INPUT FRAME default-frame alerta-exc.cod-categoria, OUTPUT iTemp).
    IF iTemp <> 0 THEN DO:
        ASSIGN alerta-exc.cd-sub:SCREEN-VALUE IN FRAME default-frame = STRING(iTemp)
               ds-sub:SCREEN-VALUE IN FRAME default-frame = fnDesc("S",INPUT FRAME default-frame alerta-exc.cod-categoria,INPUT FRAME default-frame alerta-exc.cd-sub).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cod-categoria C-Win
ON ENTRY OF alerta-exc.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cod-categoria C-Win
ON LEAVE OF alerta-exc.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:

    {func\set_leave.i}  
    ASSIGN ds-cat:SCREEN-VALUE IN FRAME default-frame = fnDesc("C",INPUT FRAME default-frame alerta-exc.cod-categoria,0).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.cod-categoria C-Win
ON MOUSE-SELECT-DBLCLICK OF alerta-exc.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
OR F5 OF alerta-exc.cod-categoria DO:
  
    DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.

    RUN zoom/zcat.w(INPUT 0, OUTPUT iTemp).
    IF iTemp <> 0 THEN DO:
        ASSIGN alerta-exc.cod-categoria:SCREEN-VALUE IN FRAME default-frame = STRING(iTemp)
               ds-cat:SCREEN-VALUE IN FRAME default-frame = fnDesc("C",INPUT FRAME default-frame alerta-exc.cod-categoria,0).
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ds-conta
&Scoped-define SELF-NAME alerta-exc.num-dias
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.num-dias C-Win
ON ENTRY OF alerta-exc.num-dias IN FRAME DEFAULT-FRAME /* Quantidade de Dias */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.num-dias C-Win
ON LEAVE OF alerta-exc.num-dias IN FRAME DEFAULT-FRAME /* Quantidade de Dias */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.outro-valor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.outro-valor C-Win
ON VALUE-CHANGED OF alerta-exc.outro-valor IN FRAME DEFAULT-FRAME /* Outro Valor */
DO:
  
    IF INPUT FRAME default-frame alerta-exc.outro-valor THEN DO:
        CASE alerta.tipo:
            WHEN 1 THEN DO:
                ENABLE alerta-exc.valor-minimo WITH FRAME default-frame.
            END.
            WHEN 2 THEN DO:
                ENABLE alerta-exc.valor-minimo
                       alerta-exc.num-dias WITH FRAME default-frame.
            END.
            WHEN 3 THEN DO:
                ENABLE alerta-exc.valor-maximo
                       alerta-exc.valor-minimo WITH FRAME default-frame.
            END.
            WHEN 4 THEN DO:
                ENABLE alerta-exc.percentual
                       alerta-exc.periodo WITH FRAME default-frame.
            END.
            WHEN 5 THEN DO:
                ENABLE alerta-exc.valor-maximo
                       alerta-exc.valor-minimo WITH FRAME default-frame.
            END.
            WHEN 6 THEN DO:
            END.
        END CASE.
    END.
    ELSE DO:
        DISABLE alerta-exc.valor-maximo
                alerta-exc.valor-minimo
                alerta-exc.num-dias
                alerta-exc.percentual
                alerta-exc.periodo WITH FRAME default-frame.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.percentual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.percentual C-Win
ON ENTRY OF alerta-exc.percentual IN FRAME DEFAULT-FRAME /* Percentual */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.percentual C-Win
ON LEAVE OF alerta-exc.percentual IN FRAME DEFAULT-FRAME /* Percentual */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo C-Win
ON ENTRY OF tipo IN FRAME DEFAULT-FRAME /* Exceá∆o de */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo C-Win
ON LEAVE OF tipo IN FRAME DEFAULT-FRAME /* Exceá∆o de */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tipo C-Win
ON VALUE-CHANGED OF tipo IN FRAME DEFAULT-FRAME /* Exceá∆o de */
DO:
    CASE INPUT FRAME default-frame tipo:
        WHEN 1 THEN DO:
            DISABLE alerta-exc.cd-conta
                    alerta-exc.cd-favorecido WITH FRAME default-frame.
            ENABLE alerta-exc.cod-categoria
                   alerta-exc.cd-sub WITH FRAME default-frame.
        END.
        WHEN 2 THEN DO:
            ENABLE alerta-exc.cd-favorecido WITH FRAME default-frame.
            DISABLE alerta-exc.cd-conta
                    alerta-exc.cod-categoria
                    alerta-exc.cd-sub WITH FRAME default-frame.
        END.
        WHEN 3 THEN DO:
            ENABLE alerta-exc.cd-conta WITH FRAME default-frame.
            DISABLE alerta-exc.cod-categoria
                    alerta-exc.cd-sub
                    alerta-exc.cd-favorecido WITH FRAME default-frame.
        END.
    END CASE.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.valor-maximo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.valor-maximo C-Win
ON ENTRY OF alerta-exc.valor-maximo IN FRAME DEFAULT-FRAME /* Valor M†ximo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.valor-maximo C-Win
ON LEAVE OF alerta-exc.valor-maximo IN FRAME DEFAULT-FRAME /* Valor M†ximo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME alerta-exc.valor-minimo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.valor-minimo C-Win
ON ENTRY OF alerta-exc.valor-minimo IN FRAME DEFAULT-FRAME /* Valor M°nimo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL alerta-exc.valor-minimo C-Win
ON LEAVE OF alerta-exc.valor-minimo IN FRAME DEFAULT-FRAME /* Valor M°nimo */
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
  {version.i alerta-exc}
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
  DISPLAY tipo ds-conta ds-fav ds-cat ds-sub 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE alerta-exc THEN 
    DISPLAY alerta-exc.cd-conta alerta-exc.cd-favorecido alerta-exc.cod-categoria 
          alerta-exc.cd-sub alerta-exc.outro-valor alerta-exc.valor-maximo 
          alerta-exc.percentual alerta-exc.valor-minimo alerta-exc.periodo 
          alerta-exc.num-dias 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCan RECT-10 RECT-6 RECT-7 tipo alerta-exc.cd-conta btInc 
         alerta-exc.cd-favorecido alerta-exc.cod-categoria alerta-exc.cd-sub 
         alerta-exc.outro-valor 
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

DEFINE VARIABLE iTemp AS INTEGER    NO-UNDO.

{func\cursor.i alerta-exc.cd-conta "IN FRAME {&FRAME-NAME}"}
{func\cursor.i alerta-exc.cd-fav "IN FRAME {&FRAME-NAME}"}
{func\cursor.i alerta-exc.cod-categoria "IN FRAME {&FRAME-NAME}"}
{func\cursor.i alerta-exc.cd-sub "IN FRAME {&FRAME-NAME}"}

IF rExc <> ? THEN DO:

    FIND FIRST alerta-exc WHERE ROWID(alerta-exc) = rExc NO-LOCK.

    ASSIGN iTemp = 1.
    IF alerta-exc.cd-favorecido <> 0 THEN
        ASSIGN iTemp = 2.
    IF alerta-exc.cd-conta <> 0 THEN
        ASSIGN iTemp = 3.

    ASSIGN tipo = iTemp.

END.
ELSE DO:
    CREATE alerta-exc.
    ASSIGN tipo = 1.
END.
  
DISPLAY alerta-exc.cd-conta
        alerta-exc.cd-favorecido
        alerta-exc.cod-categoria
        alerta-exc.cd-sub
        alerta-exc.valor-maximo
        alerta-exc.valor-minimo
        alerta-exc.num-dias
        alerta-exc.percentual
        alerta-exc.periodo
        alerta-exc.outro-valor
        tipo
    WITH FRAME default-frame.

APPLY "VALUE-CHANGED" TO tipo IN FRAME default-frame.
APPLY "LEAVE" TO alerta-exc.cd-conta IN FRAME default-frame.
APPLY "LEAVE" TO alerta-exc.cd-favorecido IN FRAME default-frame.
APPLY "LEAVE" TO alerta-exc.cod-categoria IN FRAME default-frame.
APPLY "LEAVE" TO alerta-exc.cd-sub IN FRAME default-frame.
APPLY "VALUE-CHANGED" TO alerta-exc.outro-valor IN FRAME default-frame.

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

