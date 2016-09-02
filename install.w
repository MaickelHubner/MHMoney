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

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE etapa AS INTEGER    NO-UNDO INITIAL 0.

DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.
DEFINE NEW shared VARIABLE gcUsuario AS CHARACTER  NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCont IMAGE-1 IMAGE-7 EDITOR-1 base-dados ~
n-usuario n-senha categorias moeda-prin btSair 
&Scoped-Define DISPLAYED-OBJECTS EDITOR-1 base-dados n-usuario n-senha ~
categorias moeda-prin 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCont 
     IMAGE-UP FILE "image/im-fled.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-fled.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Continuar >>" 
     SIZE 6 BY 1.79 TOOLTIP "Continuar..."
     FONT 1.

DEFINE BUTTON btSair 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Sair" 
     SIZE 6 BY 1.79 TOOLTIP "Sair"
     FONT 1.

DEFINE VARIABLE EDITOR-1 AS CHARACTER INITIAL "Este programa ir  instalar o MH Money 2005. Selecione abaixo as op‡äes desejadas e clique em continuar..." 
     VIEW-AS EDITOR NO-BOX
     SIZE 41 BY 6.25
     FONT 1 NO-UNDO.

DEFINE VARIABLE n-senha AS CHARACTER FORMAT "X(8)":U 
     LABEL "Senha" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE VARIABLE n-usuario AS CHARACTER FORMAT "X(8)":U 
     LABEL "Usu rio" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE IMAGE IMAGE-1
     FILENAME "image/mhmoney.bmp":U
     SIZE 18 BY 1.75.

DEFINE IMAGE IMAGE-7
     FILENAME "image/inst001.jpg":U
     SIZE 35 BY 8.25.

DEFINE VARIABLE base-dados AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Criar Base de Dados Nova", 1,
"Utilizar Base Existente", 2
     SIZE 21 BY 1.75 NO-UNDO.

DEFINE VARIABLE categorias AS LOGICAL INITIAL yes 
     LABEL "Criar as principais Categorias~\Sub-Categorias" 
     VIEW-AS TOGGLE-BOX
     SIZE 34 BY .83 NO-UNDO.

DEFINE VARIABLE moeda-prin AS LOGICAL INITIAL yes 
     LABEL "Cadastrar a moeda principal" 
     VIEW-AS TOGGLE-BOX
     SIZE 34 BY .83 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCont AT ROW 10 COL 74
     EDITOR-1 AT ROW 3.5 COL 39 NO-LABEL
     base-dados AT ROW 5 COL 41 NO-LABEL WIDGET-ID 4
     n-usuario AT ROW 6 COL 52 COLON-ALIGNED
     n-senha AT ROW 7 COL 52 COLON-ALIGNED
     categorias AT ROW 7.25 COL 41
     moeda-prin AT ROW 8 COL 41
     btSair AT ROW 1.5 COL 74
     IMAGE-1 AT ROW 1.5 COL 3
     IMAGE-7 AT ROW 3.5 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 10.92
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
         TITLE              = "Instalador do MH Money 2005"
         HEIGHT             = 10.92
         WIDTH              = 80
         MAX-HEIGHT         = 29.75
         MAX-WIDTH          = 145.57
         VIRTUAL-HEIGHT     = 29.75
         VIRTUAL-WIDTH      = 145.57
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
ASSIGN 
       n-senha:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

ASSIGN 
       n-usuario:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Instalador do MH Money 2005 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Instalador do MH Money 2005 */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  QUIT.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCont
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCont C-Win
ON CHOOSE OF btCont IN FRAME DEFAULT-FRAME /* Continuar >> */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    CASE etapa:
        WHEN 0 THEN RUN etapa1.
        WHEN 1 THEN RUN etapa2.
        WHEN 2 THEN RUN etapa3.
        WHEN 3 THEN RUN etapa4.
        WHEN 4 THEN RUN etapa5.
    END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btSair
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btSair C-Win
ON CHOOSE OF btSair IN FRAME DEFAULT-FRAME /* Sair */
DO:
  
    {func\bt_fechar.i}
    QUIT.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME n-senha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL n-senha C-Win
ON LEAVE OF n-senha IN FRAME DEFAULT-FRAME /* Senha */
DO:
    {func\set_leave.i}  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME n-usuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL n-usuario C-Win
ON LEAVE OF n-usuario IN FRAME DEFAULT-FRAME /* Usu rio */
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
  DISPLAY EDITOR-1 base-dados n-usuario n-senha categorias moeda-prin 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCont IMAGE-1 IMAGE-7 EDITOR-1 base-dados n-usuario n-senha 
         categorias moeda-prin btSair 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE etapa1 C-Win 
PROCEDURE etapa1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISABLE btCont WITH FRAME {&FRAME-NAME}.

ASSIGN etapa = 1.

ASSIGN INPUT FRAME {&FRAME-NAME} base-dados categorias moeda-prin.

ASSIGN base-dados:HIDDEN = YES
       categorias:HIDDEN = YES
       moeda-prin:HIDDEN = YES.

IF base-dados = 1 THEN DO:
    ASSIGN editor-1:SCREEN-VALUE = "Criando a nova base de dados...".
    IF SEARCH("database\money.db") = ? THEN
        CREATE DATABASE "database\money.db".
    CONNECT "database\money.db" -1.
END.
ELSE DO:
    ASSIGN editor-1:SCREEN-VALUE = "Conectando com a base de dados existente...".
    CONNECT "database\money.db" -1.
END.

ENABLE btCont WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE etapa2 C-Win 
PROCEDURE etapa2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISABLE btCont WITH FRAME {&FRAME-NAME}.

IF base-dados = 1 THEN DO:
    ASSIGN editor-1:SCREEN-VALUE = "Nesta etapa vocˆ dever  acessar o Data Administration (abrir  automaticamente)." + CHR(13) +
                                   "No menu, selecionar Admin\Load Data and Definitions\Data Definitions (.df file)..." + CHR(13) +
                                   "Na tela Load Data Definitions clicar no botÆo OK e aguardar o t‚rmino da importa‡Æo" + CHR(13) +
                                   "Ap¢s vocˆ pode fechar o Data Administration e continuar a instala‡Æo".
END.
ELSE DO:
    ASSIGN editor-1:SCREEN-VALUE = "Nesta etapa vocˆ dever  acessar o Data Administration (abrir  automaticamente)." + CHR(13) +
                                   "No menu, selecionar Admin\Load Data and Definitions\Data Definitions (.df file)..." + CHR(13) +
                                   "Na tela Load Data Definitions digitar ~"database\delta.df~", clicar no botÆo OK e aguardar o t‚rmino da importa‡Æo" + CHR(13) +
                                   "Ap¢s vocˆ pode fechar o Data Administration e continuar a instala‡Æo".
END.

ASSIGN etapa = 2.

{func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Aviso', INPUT 'Aten‡Æo!', INPUT 'Antes de continuar leia atentamente as instru‡äes mostradas no programa de instala‡Æo.')"}

RUN _admin.p.

ENABLE btCont WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE etapa3 C-Win 
PROCEDURE etapa3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISABLE btCont WITH FRAME {&FRAME-NAME}.

ASSIGN etapa = 3.

IF categorias THEN DO:
    ASSIGN editor-1:SCREEN-VALUE = "Aguarde enquanto o programa de instala‡Æo cria as principais Categorias e Sub-Categorias..." + CHR(13).
    RUN util\cria_cat.p.
END.
IF moeda-prin THEN DO:
    ASSIGN editor-1:SCREEN-VALUE = editor-1:SCREEN-VALUE + "Aguarde enquanto o programa de instala‡Æo configura a moeda principal do sistema..." + CHR(13).
    RUN util\acerta_moeda.p.
END.
IF base-dados = 2 THEN DO:
    ASSIGN editor-1:SCREEN-VALUE = editor-1:SCREEN-VALUE + "Aguarde enquanto o programa de instala‡Æo converte os movimentos antigos..." + CHR(13).
    RUN util\conv_transf.p.
    RUN util\reconc_agrupados.p.
END.
IF base-dados = 2 THEN DO:
    ASSIGN editor-1:SCREEN-VALUE = editor-1:SCREEN-VALUE + "Aguarde enquanto o programa de instala‡Æo repassa os valores de agendamento para o novo formato..." + CHR(13).
    RUN util\cria_valores_agend.p.
END.

ENABLE btCont WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE etapa4 C-Win 
PROCEDURE etapa4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISABLE btCont WITH FRAME {&FRAME-NAME}.

ASSIGN editor-1:SCREEN-VALUE = "Informe um usu rio e senha que ser  utilizado no sistema:" + CHR(13).

ASSIGN etapa = 4
       n-usuario:HIDDEN = NO
       n-senha:HIDDEN = NO.

ENABLE btCont WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE etapa5 C-Win 
PROCEDURE etapa5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE btCont WITH FRAME {&FRAME-NAME}.

ASSIGN etapa = 5.

ASSIGN FILE-INFO:FILE-NAME = SEARCH("menu.r").

RUN util\fininst.p (INPUT INPUT FRAME {&FRAME-NAME} n-usuario,
                    INPUT INPUT FRAME {&FRAME-NAME} n-senha,
                    INPUT SUBSTRING(FILE-INFO:FULL-PATHNAME,1,(LENGTH(FILE-INFO:FULL-PATHNAME) - (LENGTH(ENTRY(NUM-ENTRIES(FILE-INFO:FULL-PATHNAME,"\"),FILE-INFO:FULL-PATHNAME,"\")) + 1)))).

{func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Aviso', INPUT 'Instala‡Æo OK!', INPUT 'O MH Money 2005 foi instalado e configurado com sucesso.')"}

APPLY "CLOSE" TO THIS-PROCEDURE.
RUN MENU.w.

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

ASSIGN n-usuario:HIDDEN IN FRAME {&FRAME-NAME} = YES
       n-senha:HIDDEN IN FRAME {&FRAME-NAME} = YES.

APPLY "VALUE-CHANGED" TO base-dados IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

