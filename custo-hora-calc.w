&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

DEF TEMP-TABLE tt-custo   LIKE custo.

DEF BUFFER bf-usuario FOR usuario.

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF NEW GLOBAL SHARED VAR gNomeUsuario LIKE usuario.nome.
DEF NEW GLOBAL SHARED VAR gPeriodo     LIKE custo.periodo.

DEF VAR c-periodo    AS CHAR FORMAT "x(06)".
DEF VAR dt-val       AS DATE.
DEF VAR dt-ap        AS DATE.

{func\data.i}
{func\definitions.i}
{winalert.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel RECT-17 c-nome c-periodo-tela ~
btPagar 
&Scoped-Define DISPLAYED-OBJECTS c-nome c-ds-favorecido c-periodo-tela 

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

DEFINE BUTTON btPagar 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "&Pagar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Gerar Movimento".

DEFINE VARIABLE c-ds-favorecido AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY .88 NO-UNDO.

DEFINE VARIABLE c-nome AS CHARACTER FORMAT "X(256)":U 
     LABEL "Usu†rio" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .88 NO-UNDO.

DEFINE VARIABLE c-periodo-tela AS CHARACTER FORMAT "X(6)":U 
     LABEL "Periodo" 
     VIEW-AS FILL-IN 
     SIZE 10 BY .88 NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 63.57 BY 2.92.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 4.25 COL 58 WIDGET-ID 32
     c-nome AT ROW 1.46 COL 6.43 COLON-ALIGNED WIDGET-ID 10
     c-ds-favorecido AT ROW 1.46 COL 16.43 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     c-periodo-tela AT ROW 2.5 COL 6.43 COLON-ALIGNED WIDGET-ID 24
     btPagar AT ROW 4.25 COL 52 WIDGET-ID 20
     RECT-17 AT ROW 1.08 COL 1.43 WIDGET-ID 40
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 64.43 BY 6.54
         FONT 4 WIDGET-ID 100.


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
         TITLE              = "Calcular Custo"
         HEIGHT             = 5.29
         WIDTH              = 64.29
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
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
/* SETTINGS FOR FILL-IN c-ds-favorecido IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Calcular Custo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Calcular Custo */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    APPLY 'close' TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btPagar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btPagar C-Win
ON CHOOSE OF btPagar IN FRAME DEFAULT-FRAME /* Pagar */
DO:

    /** valida usuario informado **/
    IF INPUT FRAME {&FRAME-NAME} c-nome <> "" THEN DO:
        FIND FIRST usuario NO-LOCK
             WHERE usuario.nome = INPUT FRAME {&FRAME-NAME} c-nome NO-ERROR.       
        IF NOT AVAIL usuario THEN DO:
            {func\valida.i &Mensagem  = "Usu†rio inv†lido!"
                           &Ajuda     = "Vocà deve informar um usu†rio cadastrado."
                           &Campo     = c-nome} 
        END.
    END.
    
    /** inicio do procedimento de calculo de custo **/     
    {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Calcular ? (012)', INPUT 'Deseja calcular o custo?', INPUT 'Os custos ser∆o recalculados para o periodo e\ou usu†rio informado na tela. Tem certeza que deseja executar o c†lculo?')"}        
    IF RETURN-VALUE = "OK" THEN DO:
    
        SESSION:SET-WAIT-STATE("image\calc.cur").
        
        EMPTY TEMP-TABLE tt-custo.
        FOR EACH usuario NO-LOCK
            WHERE (IF INPUT FRAME {&FRAME-NAME} c-nome <> "" THEN usuario.nome = INPUT FRAME {&FRAME-NAME} c-nome ELSE TRUE):
            RUN calculaCusto (INPUT usuario.nome, INPUT INPUT FRAME {&FRAME-NAME} c-periodo-tela).
        END.
        
        IF CAN-FIND(FIRST tt-custo) THEN DO:
            FOR EACH custo EXCLUSIVE-LOCK
                WHERE (IF INPUT FRAME {&FRAME-NAME} c-nome <> "" THEN custo.nome = INPUT FRAME {&FRAME-NAME} c-nome ELSE TRUE)
                AND   custo.periodo = INPUT FRAME {&FRAME-NAME} c-periodo-tela:
                DELETE custo.
            END.
            FOR EACH tt-custo
                WHERE tt-custo.valor > 0:
                CREATE custo.
                BUFFER-COPY tt-custo TO custo.
                IF custo.qt-horas <> 0 THEN
                    ASSIGN custo.val-custo = custo.valor / custo.qt-horas.
                ELSE
                    ASSIGN custo.val-custo = custo.valor / 170.
                
            END.
        END.
        
        SESSION:SET-WAIT-STATE("").

        ASSIGN gNomeUsuario = INPUT FRAME {&FRAME-NAME} c-nome
               gPeriodo = INPUT FRAME {&FRAME-NAME} c-periodo-tela.

    END.

    APPLY "close" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c-nome
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON ENTRY OF c-nome IN FRAME DEFAULT-FRAME /* Usu†rio */
DO:
  {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON LEAVE OF c-nome IN FRAME DEFAULT-FRAME /* Usu†rio */
DO:
    IF INPUT FRAME {&FRAME-NAME} c-nome = "" THEN
        ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Todos".
    ELSE DO:
        FIND FIRST usuario NO-LOCK
             WHERE usuario.nome = INPUT FRAME {&FRAME-NAME} c-nome NO-ERROR.
        IF AVAIL usuario THEN DO:
            FIND FIRST favorecido NO-LOCK
                 WHERE favorecido.cd-favorecido = usuario.cd-favorecido NO-ERROR.
            IF AVAIL favorecido THEN
                ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = favorecido.ds-favorecido.                            
            ELSE
                ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".                
        END. 
        ELSE
            ASSIGN c-ds-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".           
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-nome C-Win
ON MOUSE-SELECT-DBLCLICK OF c-nome IN FRAME DEFAULT-FRAME /* Usu†rio */
OR F5 OF c-nome DO:
    {func\zoom.i &Tabela="usuario"
                 &Campo1="nome"
                 &Tela1="c-nome"}
                 
    APPLY "leave" TO c-nome IN FRAME {&FRAME-NAME}.            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c-periodo-tela
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-periodo-tela C-Win
ON ENTRY OF c-periodo-tela IN FRAME DEFAULT-FRAME /* Periodo */
DO:
    {func\set_entry.i}  
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
    {version.i custo-hora-calc}
    RUN enable_UI.
    RUN initialize.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
      WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculaCusto C-Win 
PROCEDURE calculaCusto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER c-usuario LIKE usuario.nome.
DEFINE INPUT PARAMETER c-periodo LIKE custo.periodo.

def var dt-val as date.
def var dt-ap as date.

assign dt-val = (fnUltimoDia(INT(SUBSTRING(c-periodo,5,2)),INT(SUBSTRING(c-periodo,1,4))) + 1)
       dt-ap = date(INT(SUBSTRING(c-periodo,5,2)), 1, INT(SUBSTRING(c-periodo,1,4))).
       
FIND FIRST usuario NO-LOCK
     WHERE usuario.nome = c-usuario NO-ERROR.

FOR EACH mov-conta NO-LOCK
   WHERE (IF mov-conta.dt-compensacao <> ? THEN
            (mov-conta.dt-compensacao >= dt-val AND 
             mov-conta.dt-compensacao <= fnUltimoDia(MONTH(dt-val), YEAR(dt-val))) ELSE
            (mov-conta.dt-mov >= dt-val AND 
             mov-conta.dt-mov <= fnUltimoDia(MONTH(dt-val), YEAR(dt-val))))
     AND mov-conta.id-tipo      <> 0
     AND mov-conta.id-tipo      <> 3
    AND (mov-conta.cod-categoria = 4
      OR mov-conta.cod-categoria = 12
      OR (mov-conta.cod-categoria = 13 AND mov-conta.cd-sub = 1)
      OR (mov-conta.cod-categoria = 7 AND mov-conta.cd-sub = 1))
    AND mov-conta.cd-favorecido = usuario.cd-favorecido BREAK BY mov-conta.dt-mov:

    FIND FIRST tt-custo EXCLUSIVE-LOCK
         WHERE tt-custo.nome    = usuario.nome
           AND tt-custo.periodo = c-periodo NO-ERROR.
    IF NOT AVAIL tt-custo THEN DO:
        CREATE tt-custo.
        ASSIGN tt-custo.nome        = usuario.nome
               tt-custo.periodo     = c-periodo.
    END.
    ASSIGN tt-custo.valor = tt-custo.valor + (mov-conta.de-valor * -1).
   
END.

/** horas **/
FOR EACH apontamento NO-LOCK
   WHERE apontamento.nome = usuario.nome
   AND   apontamento.data >= dt-ap
   AND   apontamento.data <= fnUltimoDia(MONTH(dt-ap), YEAR(dt-ap)),
    FIRST pedido-item OF apontamento,
    FIRST ITEM OF pedido-item BREAK BY apontamento.data:

    IF NOT (ITEM.unidade MATCHES ("*hr*")) THEN NEXT.
    
    FIND FIRST tt-custo 
         WHERE tt-custo.nome    = usuario.nome
           AND tt-custo.periodo = c-periodo NO-ERROR.
    IF NOT AVAIL tt-custo THEN DO:
        CREATE tt-custo.
        ASSIGN tt-custo.nome        = usuario.nome
               tt-custo.periodo     = c-periodo.
    END.
    ASSIGN tt-custo.qt-horas = tt-custo.qt-horas + apontamento.qt-apontada.

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
  DISPLAY c-nome c-ds-favorecido c-periodo-tela 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel RECT-17 c-nome c-periodo-tela btPagar 
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

    ASSIGN c-periodo-tela:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(YEAR(TODAY - 30),"9999") + STRING(MONTH(TODAY - 30),"99").

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

