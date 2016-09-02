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

DEFINE BUFFER bf-mov-conta-aux FOR mov-conta.

/* Parameters Definitions ---                                           */

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        mov-conta
&GLOBAL-DEFINE Parent       conta
&GLOBAL-DEFINE ParentField  cd-conta
&GLOBAL-DEFINE KeyFields    mov-conta.cd-sequencia
&GLOBAL-DEFINE FrameFields  mov-conta.de-valor mov-conta.nr-mov ~
                            mov-conta.dt-mov mov-conta.de-valor ~
                            mov-conta.dt-compensacao mov-conta.agrupado ~
                            mov-conta.cd-favorecido mov-conta.cod-categoria ~
                            mov-conta.cd-sub mov-conta.conta-transf ~
                            mov-conta.ds-observacao mov-conta.id-tipo ~
                            mov-conta.id-situacao mov-conta.seq-transf ~
                            mov-conta.cd-agenda mov-conta.nr-pedido ~
                            fav cat subcat ds-conta-transf des-moeda
&GLOBAL-DEFINE FrameDisp    conta.ds-conta
                            

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE r-favorecido AS ROWID      NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE r-mov-bens AS ROWID      NO-UNDO.


/* Buffers */
DEFINE BUFFER bf-ped FOR pedido.
DEFINE BUFFER bf-movc FOR mov-conta.

{func\definitions.i}
{func\data.i}
{cotacao.i}
{winalert.i}
{proxpag.i}

DEFINE BUFFER bf-conta FOR conta.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS mov-conta.cd-conta mov-conta.cd-sequencia ~
mov-conta.id-tipo mov-conta.dt-mov mov-conta.dt-compensacao ~
mov-conta.id-situacao mov-conta.nr-mov mov-conta.de-valor ~
mov-conta.cd-favorecido mov-conta.cod-categoria mov-conta.cd-sub ~
mov-conta.conta-transf mov-conta.cd-agenda mov-conta.usuar-resp ~
mov-conta.nr-pedido mov-conta.ds-observacao 
&Scoped-define ENABLED-TABLES mov-conta
&Scoped-define FIRST-ENABLED-TABLE mov-conta
&Scoped-Define ENABLED-OBJECTS btTransf btReemb btBem btProj btAgrup ~
btImpto RECT-10 RECT-2 RECT-7 RECT-8 RECT-9 
&Scoped-Define DISPLAYED-FIELDS mov-conta.cd-conta conta.ds-conta ~
mov-conta.cd-sequencia mov-conta.id-tipo mov-conta.dt-mov ~
mov-conta.dt-compensacao mov-conta.id-situacao mov-conta.nr-mov ~
mov-conta.de-valor mov-conta.cd-favorecido mov-conta.cod-categoria ~
mov-conta.cd-sub mov-conta.conta-transf mov-conta.seq-transf ~
mov-conta.agrupado mov-conta.cd-agenda mov-conta.usuar-resp ~
mov-conta.nr-pedido mov-conta.ds-observacao 
&Scoped-define DISPLAYED-TABLES mov-conta conta
&Scoped-define FIRST-DISPLAYED-TABLE mov-conta
&Scoped-define SECOND-DISPLAYED-TABLE conta
&Scoped-Define DISPLAYED-OBJECTS des-moeda valor-transf moeda-transf ~
ds-conta-transf fav cat subcat 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btAgrup 
     IMAGE-UP FILE "image/im-mov.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-mov.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Agrup" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentos Agrupados".

DEFINE BUTTON btBem 
     IMAGE-UP FILE "image/im-bem.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-bem.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Bens" 
     SIZE 6.14 BY 1.79 TOOLTIP "Bem Relacionado".

DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-can.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-can.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Cancelar".

DEFINE BUTTON btImpto 
     IMAGE-UP FILE "image/im-saldo.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-saldo.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Impto" 
     SIZE 6.14 BY 1.79 TOOLTIP "Impostos Relacionados".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "btexit 2" 
     SIZE 6.14 BY 1.79 TOOLTIP "Confirmar".

DEFINE BUTTON btProj 
     IMAGE-UP FILE "image/im-plan.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-plan.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Proj" 
     SIZE 6.14 BY 1.79 TOOLTIP "Projeto Relacionado".

DEFINE BUTTON btReemb 
     IMAGE-UP FILE "image/im-copia.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-copia.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Reemb" 
     SIZE 6.14 BY 1.79 TOOLTIP "Movimentos Reembolsados".

DEFINE BUTTON btTransf  NO-FOCUS FLAT-BUTTON
     LABEL ">>" 
     SIZE 4 BY 1 TOOLTIP "Transfere o Movimento para Outra Conta".

DEFINE VARIABLE cat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE des-moeda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moeda" 
     VIEW-AS FILL-IN 
     SIZE 25 BY .79 NO-UNDO.

DEFINE VARIABLE ds-conta-transf AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 31 BY .79 NO-UNDO.

DEFINE VARIABLE fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE moeda-transf AS CHARACTER FORMAT "X(256)":U 
     LABEL "Moeda" 
     VIEW-AS FILL-IN 
     SIZE 27 BY .79 NO-UNDO.

DEFINE VARIABLE subcat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .79 NO-UNDO.

DEFINE VARIABLE valor-transf AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Valor Transf" 
     VIEW-AS FILL-IN 
     SIZE 18 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.25.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.5.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 3.5.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     mov-conta.cd-conta AT ROW 1.5 COL 16 COLON-ALIGNED
          LABEL "Conta"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     btTransf AT ROW 1.42 COL 72 WIDGET-ID 2
     conta.ds-conta AT ROW 1.5 COL 21.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 48 BY .79
     btReemb AT ROW 21.25 COL 20.43
     mov-conta.cd-sequencia AT ROW 3.25 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     btBem AT ROW 21.25 COL 2
     mov-conta.id-tipo AT ROW 4.25 COL 16 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 20
          LIST-ITEM-PAIRS "",0
          DROP-DOWN-LIST
          SIZE 25 BY 1
     mov-conta.dt-mov AT ROW 5.25 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     mov-conta.dt-compensacao AT ROW 6.25 COL 16 COLON-ALIGNED
          LABEL "Compensaá∆o"
          VIEW-AS FILL-IN 
          SIZE 10 BY .79
     btProj AT ROW 21.25 COL 8.14
     mov-conta.id-situacao AT ROW 3.25 COL 51 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 20
          LIST-ITEM-PAIRS "N∆o Compensado",1,
                     "Compensado",2,
                     "Reconciliado",3
          DROP-DOWN-LIST
          SIZE 25 BY 1
     mov-conta.nr-mov AT ROW 4.25 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY .79
     btAgrup AT ROW 21.25 COL 14.29
     des-moeda AT ROW 5.25 COL 51 COLON-ALIGNED
     mov-conta.de-valor AT ROW 6.25 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY .79
     mov-conta.cd-favorecido AT ROW 8 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     mov-conta.cod-categoria AT ROW 9 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     mov-conta.cd-sub AT ROW 10 COL 16 COLON-ALIGNED
          LABEL "Sub-Categoria"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     mov-conta.conta-transf AT ROW 11.75 COL 16 COLON-ALIGNED
          LABEL "Conta Transf"
          VIEW-AS FILL-IN 
          SIZE 5 BY .79
     mov-conta.seq-transf AT ROW 11.75 COL 62 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     valor-transf AT ROW 12.75 COL 16 COLON-ALIGNED
     moeda-transf AT ROW 12.75 COL 42 COLON-ALIGNED
     mov-conta.agrupado AT ROW 14.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     mov-conta.cd-agenda AT ROW 15.5 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     mov-conta.usuar-resp AT ROW 14.5 COL 55 COLON-ALIGNED
          LABEL "Respons†vel"
          VIEW-AS COMBO-BOX INNER-LINES 9999
          DROP-DOWN-LIST
          SIZE 14 BY 1
     mov-conta.nr-pedido AT ROW 15.5 COL 55 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 8 BY .79
     mov-conta.ds-observacao AT ROW 16.75 COL 2 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 78 BY 4.25
          FONT 13
     btCancel AT ROW 21.25 COL 74.14
     btOK AT ROW 21.25 COL 68
     ds-conta-transf AT ROW 11.75 COL 21.29 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fav AT ROW 8 COL 21.29 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     cat AT ROW 9 COL 21.29 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     subcat AT ROW 10 COL 21.29 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 22.04
         FONT 7.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     btImpto AT ROW 21.25 COL 26.72 WIDGET-ID 4
     RECT-10 AT ROW 14.25 COL 2
     RECT-2 AT ROW 1.25 COL 2
     RECT-7 AT ROW 3 COL 2
     RECT-8 AT ROW 7.75 COL 2
     RECT-9 AT ROW 11.5 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 22.04
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
         HEIGHT             = 22.04
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
/* SETTINGS FOR FILL-IN mov-conta.agrupado IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btOK IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN cat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       cat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN mov-conta.cd-conta IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN mov-conta.cd-sub IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN mov-conta.conta-transf IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN des-moeda IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN conta.ds-conta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ds-conta-transf IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       ds-conta-transf:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

ASSIGN 
       mov-conta.ds-observacao:RETURN-INSERTED IN FRAME DEFAULT-FRAME  = TRUE.

/* SETTINGS FOR FILL-IN mov-conta.dt-compensacao IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       fav:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN moeda-transf IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN mov-conta.seq-transf IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN subcat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       subcat:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR COMBO-BOX mov-conta.usuar-resp IN FRAME DEFAULT-FRAME
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN valor-transf IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Template Padr∆o de Detalhe */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.agrupado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.agrupado C-Win
ON ENTRY OF mov-conta.agrupado IN FRAME DEFAULT-FRAME /* Agrupado */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.agrupado C-Win
ON LEAVE OF mov-conta.agrupado IN FRAME DEFAULT-FRAME /* Agrupado */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.agrupado C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-conta.agrupado IN FRAME DEFAULT-FRAME /* Agrupado */
OR F5 OF {&Table}.agrupado DO:
    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo <> 0 THEN DO:
        {func\zoom.i &Tabela="mov-conta"
                     &Campo1="cd-sequencia"
                     &Tela1="mov-conta.agrupado"
                     &CampoFiltro1="id-tipo"
                     &ValorFiltro1="0"
                     &CampoFiltro2="dt-mov"
                     &ValorFiltro2="REPLACE(STRING(INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov, '99/99/9999'), '/', '')"
                     &CampoFiltro3="cd-conta"
                     &ValorFiltro3="mov-conta.cd-conta"}
    END.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btAgrup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btAgrup C-Win
ON CHOOSE OF btAgrup IN FRAME DEFAULT-FRAME /* Agrup */
DO:
    DEFINE VARIABLE cActionTemp AS CHARACTER  NO-UNDO.

    RUN som.p(INPUT "music\click.wav").

    ASSIGN cActionTemp = pcActionBT.
  
    ASSIGN INPUT FRAME {&FRAME-NAME} mov-conta.nr-mov
           INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov
           INPUT FRAME {&FRAME-NAME} mov-conta.cd-favorecido.
    {func\run.i &Programa = "agrup.w (INPUT INPUT FRAME {&FRAME-NAME} mov-conta.cd-conta, INPUT mov-conta.cd-sequencia)"}
    DISPLAY mov-conta.de-valor WITH FRAME {&FRAME-NAME}.

    ASSIGN pcActionBT = cActionTemp.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btBem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btBem C-Win
ON CHOOSE OF btBem IN FRAME DEFAULT-FRAME /* Bens */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    ASSIGN r-mov-conta = ROWID(mov-conta).
    {func\run.i &Programa = "relbem.w"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* btexit 2 */
DO:
    IF pcActionBT = "ADD" THEN DO:
        FOR EACH bf-{&TABLE} EXCLUSIVE-LOCK
            WHERE bf-{&TABLE}.cd-conta = mov-conta.cd-conta
            AND   bf-{&TABLE}.agrupado = mov-conta.cd-sequencia:

            DELETE bf-{&TABLE}.

        END.
    END.
    {func\bt_cad_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btImpto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btImpto C-Win
ON CHOOSE OF btImpto IN FRAME DEFAULT-FRAME /* Impto */
DO:
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "movimpto.w (INPUT ROWID(mov-conta))"}

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


&Scoped-define SELF-NAME btProj
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btProj C-Win
ON CHOOSE OF btProj IN FRAME DEFAULT-FRAME /* Proj */
DO:
  
    RUN som.p(INPUT "music\click.wav").
    {func\run.i &Programa = "relproj.w (INPUT INPUT FRAME default-frame mov-conta.cd-conta, INPUT mov-conta.cd-sequencia)"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btReemb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btReemb C-Win
ON CHOOSE OF btReemb IN FRAME DEFAULT-FRAME /* Reemb */
DO:
    RUN som.p(INPUT "music\click.wav").
    ASSIGN INPUT FRAME {&FRAME-NAME} mov-conta.nr-mov
           INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov
           INPUT FRAME {&FRAME-NAME} mov-conta.cd-favorecido.
    {func\run.i &Programa = "movreemb.w (INPUT INPUT FRAME {&FRAME-NAME} mov-conta.cd-conta, INPUT mov-conta.cd-sequencia)"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btTransf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btTransf C-Win
ON CHOOSE OF btTransf IN FRAME DEFAULT-FRAME /* >> */
DO:
  
    {func\run.i &Programa = "mov-conta-transf.w (INPUT mov-conta.cd-conta, INPUT ROWID(mov-conta))"}
    IF RETURN-VALUE <> "NOK" THEN DO:
        FIND FIRST conta OF mov-conta NO-LOCK.
        FIND CURRENT mov-conta EXCLUSIVE-LOCK.
        RUN displayFields.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-agenda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-agenda C-Win
ON ENTRY OF mov-conta.cd-agenda IN FRAME DEFAULT-FRAME /* Agendamento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-agenda C-Win
ON LEAVE OF mov-conta.cd-agenda IN FRAME DEFAULT-FRAME /* Agendamento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-conta C-Win
ON ENTRY OF mov-conta.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-conta C-Win
ON LEAVE OF mov-conta.cd-conta IN FRAME DEFAULT-FRAME /* Conta */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-favorecido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-favorecido C-Win
ON ENTRY OF mov-conta.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-favorecido C-Win
ON LEAVE OF mov-conta.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
DO:
    {func\leave.i &Tabela="favorecido"
                  &Campo="cd-favorecido"
                  &CampoProc = "ds-favorecido"
                  &Tela="fav"}  
                  
    FIND LAST bf-mov-conta USE-INDEX data 
        WHERE bf-mov-conta.cd-conta      = mov-conta.cd-conta
        AND   bf-mov-conta.cd-favorecido = INPUT FRAME {&frame-name} mov-conta.cd-favorecido 
        AND   bf-mov-conta.id-tipo       = INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo NO-LOCK NO-ERROR.
    IF AVAIL bf-mov-conta THEN DO:
        IF INPUT FRAME {&FRAME-NAME} mov-conta.cod-categoria = 0 THEN
            ASSIGN mov-conta.cod-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bf-mov-conta.cod-categoria).
        IF INPUT FRAME {&FRAME-NAME} mov-conta.cd-sub = 0 THEN
            ASSIGN mov-conta.cd-sub:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bf-mov-conta.cd-sub).
        APPLY "LEAVE" TO mov-conta.cod-categoria IN FRAME {&FRAME-NAME}.
        APPLY "LEAVE" TO mov-conta.cd-sub IN FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-favorecido C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-conta.cd-favorecido IN FRAME DEFAULT-FRAME /* Favorecido */
OR F5 OF {&Table}.cd-favorecido DO:
    {func\zoom.i &Tabela="favorecido"
                 &Campo1="cd-favorecido"
                 &Tela1="mov-conta.cd-favorecido"
                 &Campo2="ds-favorecido"
                 &Tela2="fav"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-sequencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sequencia C-Win
ON ENTRY OF mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME /* Sequencia */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sequencia C-Win
ON LEAVE OF mov-conta.cd-sequencia IN FRAME DEFAULT-FRAME /* Sequencia */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cd-sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sub C-Win
ON ENTRY OF mov-conta.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sub C-Win
ON LEAVE OF mov-conta.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
DO:
    {func\leave.i &Tabela="sub-cat"
                  &Campo="cd-sub"
                  &CampoPai="cod-categoria = INPUT FRAME {&FRAME-NAME} mov-conta.cod-categoria"
                  &CampoProc = "ds-sub"
                  &Tela="subcat"}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cd-sub C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-conta.cd-sub IN FRAME DEFAULT-FRAME /* Sub-Categoria */
OR F5 OF {&Table}.cd-sub DO:
    {func\zoom.i &Tabela="sub-cat"
                 &Campo1="cd-sub"
                 &Tela1="mov-conta.cd-sub"
                 &Campo2="ds-sub"
                 &Tela2="subcat"
                 &CampoFiltro1="cod-categoria"
                 &ValorFiltro1="INPUT FRAME {&FRAME-NAME} mov-conta.cod-categoria"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.cod-categoria
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cod-categoria C-Win
ON ENTRY OF mov-conta.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cod-categoria C-Win
ON LEAVE OF mov-conta.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
DO:
    {func\leave.i &Tabela="categoria"
                  &Campo="cod-categoria"
                  &CampoProc = "ds-categoria"
                  &Tela="cat"}    
                  
    APPLY "LEAVE" TO mov-conta.cd-sub IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.cod-categoria C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-conta.cod-categoria IN FRAME DEFAULT-FRAME /* Categoria */
OR F5 OF {&Table}.cod-categoria DO:
    DEFINE VARIABLE iTipo AS INTEGER    NO-UNDO.
    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo <> 3
    AND INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo <> 0 THEN DO:
        IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo < 3 THEN
            ASSIGN iTipo = 1.
        ELSE
            ASSIGN iTipo = 2.
        {func\zoom.i &Tabela="categoria"
                     &Campo1="cod-categoria"
                     &Tela1="mov-conta.cod-categoria"
                     &Campo2="ds-categoria"
                     &Tela2="cat"
                     &CampoFiltro1="id-tipo"
                     &ValorFiltro1="iTipo"}
    END.
    ELSE DO:
        {func\zoom.i &Tabela="categoria"
                     &Campo1="cod-categoria"
                     &Tela1="mov-conta.cod-categoria"
                     &Campo2="ds-categoria"
                     &Tela2="cat"
                     &CampoFiltro1="id-tipo"
                     &ValorFiltro1="iTipo"
                     &DefVar=NO}
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.conta-transf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.conta-transf C-Win
ON ENTRY OF mov-conta.conta-transf IN FRAME DEFAULT-FRAME /* Conta Transf */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.conta-transf C-Win
ON LEAVE OF mov-conta.conta-transf IN FRAME DEFAULT-FRAME /* Conta Transf */
DO:
    {func\leave.i &Tabela="conta"
                  &Campo="cd-conta"
                  &CampoTela = "conta-transf"
                  &CampoProc ="ds-conta"
                  &Tela="ds-conta-transf"}
    
    IF AVAIL bfl-conta THEN DO:
        RUN leaveContaTransf IN THIS-PROCEDURE (INPUT bfl-conta.cd-moeda).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.conta-transf C-Win
ON MOUSE-SELECT-DBLCLICK OF mov-conta.conta-transf IN FRAME DEFAULT-FRAME /* Conta Transf */
OR F5 OF {&Table}.conta-transf DO:
    {func\zoom.i &Tabela="conta"
                 &Campo1="cd-conta"
                 &Tela1="mov-conta.conta-transf"
                 &Campo2="ds-conta"
                 &Tela2="ds-conta-transf"}
    IF AVAIL bfz-conta THEN DO:
        RUN leaveContaTransf IN THIS-PROCEDURE (INPUT bfz-conta.cd-moeda).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.de-valor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.de-valor C-Win
ON ENTRY OF mov-conta.de-valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.de-valor C-Win
ON LEAVE OF mov-conta.de-valor IN FRAME DEFAULT-FRAME /* Valor */
DO:
  
    {func\set_leave.i}  
    APPLY "LEAVE":U TO mov-conta.conta-transf IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des-moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des-moeda C-Win
ON ENTRY OF des-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des-moeda C-Win
ON LEAVE OF des-moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME conta.ds-conta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.ds-conta C-Win
ON ENTRY OF conta.ds-conta IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL conta.ds-conta C-Win
ON LEAVE OF conta.ds-conta IN FRAME DEFAULT-FRAME /* Descriá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.ds-observacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.ds-observacao C-Win
ON ENTRY OF mov-conta.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    IF pcActionBT <> "DETAIL" THEN DO:
        {func\set_entry.i}  
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.ds-observacao C-Win
ON LEAVE OF mov-conta.ds-observacao IN FRAME DEFAULT-FRAME /* Observaá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.dt-compensacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.dt-compensacao C-Win
ON ENTRY OF mov-conta.dt-compensacao IN FRAME DEFAULT-FRAME /* Compensaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.dt-compensacao C-Win
ON LEAVE OF mov-conta.dt-compensacao IN FRAME DEFAULT-FRAME /* Compensaá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.dt-mov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.dt-mov C-Win
ON ENTRY OF mov-conta.dt-mov IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.dt-mov C-Win
ON LEAVE OF mov-conta.dt-mov IN FRAME DEFAULT-FRAME /* Data */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.id-situacao
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.id-situacao C-Win
ON ENTRY OF mov-conta.id-situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.id-situacao C-Win
ON LEAVE OF mov-conta.id-situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.id-situacao C-Win
ON VALUE-CHANGED OF mov-conta.id-situacao IN FRAME DEFAULT-FRAME /* Situaá∆o */
DO:
    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-situacao = 1 THEN
        DISABLE mov-conta.dt-compensacao WITH FRAME {&FRAME-NAME}.
    ELSE
        IF pcActionBT <> "DETAIL" THEN
            ENABLE mov-conta.dt-compensacao WITH FRAME {&FRAME-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.id-tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.id-tipo C-Win
ON ENTRY OF mov-conta.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.id-tipo C-Win
ON LEAVE OF mov-conta.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.id-tipo C-Win
ON VALUE-CHANGED OF mov-conta.id-tipo IN FRAME DEFAULT-FRAME /* Tipo */
DO:

    DEFINE VARIABLE cNum AS CHARACTER    NO-UNDO.
  
    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 3  THEN DO:
        IF pcActionBT <> "DETAIL" THEN DO:
            ENABLE mov-conta.conta-transf
                   ds-conta-transf
                   mov-conta.de-valor WITH FRAME {&FRAME-NAME}.
        END.
        DISABLE mov-conta.cod-categoria
                cat
                mov-conta.cd-sub
                subcat
                btAgrup WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 4
            AND mov-conta.agrupado = 0 THEN DO:
            FOR EACH bf-mov-conta OF conta NO-LOCK
                WHERE bf-mov-conta.id-tipo = 4
                AND   bf-mov-conta.nr-mov <> ""
                BY bf-mov-conta.nr-mov:
            
                IF INTEGER(bf-mov-conta.nr-mov) > INTEGER(cNum) THEN
                    ASSIGN cNum = bf-mov-conta.nr-mov.

            END.
            IF cNum <> "" AND INPUT FRAME {&FRAME-NAME} mov-conta.nr-mov = "" THEN
                ASSIGN mov-conta.nr-mov:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(INTEGER(cNum) + 1).
        END.
        DISABLE mov-conta.conta-transf
                ds-conta-transf WITH FRAME {&FRAME-NAME}.
        IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 0 THEN DO:
            DISABLE mov-conta.cod-categoria
                    cat
                    mov-conta.cd-sub
                    subcat
                    mov-conta.de-valor WITH FRAME {&FRAME-NAME}.
            ENABLE btAgrup WITH FRAME {&FRAME-NAME}.
        END.
        ELSE DO:
            IF pcActionBT <> "DETAIL" THEN DO:
                ENABLE mov-conta.cod-categoria
                       cat
                       mov-conta.cd-sub
                       subcat
                       mov-conta.de-valor WITH FRAME {&FRAME-NAME}.
            END.
            DISABLE btAgrup WITH FRAME {&FRAME-NAME}.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME moeda-transf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda-transf C-Win
ON ENTRY OF moeda-transf IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda-transf C-Win
ON LEAVE OF moeda-transf IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.nr-mov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.nr-mov C-Win
ON ENTRY OF mov-conta.nr-mov IN FRAME DEFAULT-FRAME /* N£mero */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.nr-mov C-Win
ON LEAVE OF mov-conta.nr-mov IN FRAME DEFAULT-FRAME /* N£mero */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.nr-pedido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.nr-pedido C-Win
ON ENTRY OF mov-conta.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.nr-pedido C-Win
ON LEAVE OF mov-conta.nr-pedido IN FRAME DEFAULT-FRAME /* Pedido */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.seq-transf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.seq-transf C-Win
ON ENTRY OF mov-conta.seq-transf IN FRAME DEFAULT-FRAME /* Seq. Transf. */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.seq-transf C-Win
ON LEAVE OF mov-conta.seq-transf IN FRAME DEFAULT-FRAME /* Seq. Transf. */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME mov-conta.usuar-resp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.usuar-resp C-Win
ON ENTRY OF mov-conta.usuar-resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mov-conta.usuar-resp C-Win
ON LEAVE OF mov-conta.usuar-resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_leave.i}      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME valor-transf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor-transf C-Win
ON ENTRY OF valor-transf IN FRAME DEFAULT-FRAME /* Valor Transf */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL valor-transf C-Win
ON LEAVE OF valor-transf IN FRAME DEFAULT-FRAME /* Valor Transf */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = fav
                          &FOREACH = "favorecido BY favorecido.ds-favorecido"
                          &CAMPO = favorecido.ds-favorecido
                          &ObjPai = mov-conta.cd-favorecido}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = cat
                          &FOREACH = "categoria BY categoria.ds-categoria"
                          &CAMPO = categoria.ds-categoria
                          &ObjPai = mov-conta.cod-categoria}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = subcat
                          &FOREACH = "sub-cat WHERE (sub-cat.cod-categoria = INPUT FRAME {&Frame-name} mov-conta.cod-categoria) BY sub-cat.ds-sub"
                          &CAMPO = sub-cat.ds-sub
                          &ObjPai = mov-conta.cd-sub}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = ds-conta-transf
                          &FOREACH = "conta BY conta.ds-conta"
                          &CAMPO = conta.ds-conta
                          &ObjPai = mov-conta.cd-conta}
                          
{func\calendar.i mov-conta.dt-mov}
{func\calendar.i mov-conta.dt-compensacao}
{func\calc.i mov-conta.de-valor}
{func\calc.i valor-transf}


/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

ON F11 ANYWHERE 
DO:
  
    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario NO-ERROR.
    IF AVAIL usuario AND usuario.administrador THEN DO:
        ENABLE mov-conta.agrupado
               mov-conta.nr-mov
               mov-conta.cd-agenda
               mov-conta.usuar-resp
               mov-conta.cod-categoria
               mov-conta.cd-sub
               mov-conta.cd-favorecido WITH FRAME {&FRAME-NAME}.
        IF param-mn.perfil = 2 /* Empresarial */ THEN
            ENABLE mov-conta.nr-pedido WITH FRAME {&FRAME-NAME}.
    END.

END.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {version.i mov-conta_det}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE afterAssignFields C-Win 
PROCEDURE afterAssignFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE lPaga AS LOGICAL    NO-UNDO INITIAL YES.
    DEFINE VARIABLE de-aux-imp AS DECIMAL     NO-UNDO.
    DEFINE VARIABLE dtProx AS DATE    NO-UNDO.

    /* Acerta a moeda do movimento */
    IF AVAIL conta THEN DO:
        ASSIGN mov-conta.cd-moeda = conta.cd-moeda.
    END.

    DEFINE BUFFER bf-mov-conta-aux FOR mov-conta.

    ASSIGN INPUT FRAME {&FRAME-NAME} valor-transf.

    /* Sincroniza os dois movimentos se for uma transferància */
    IF mov-conta.id-tipo = 3 THEN DO:
        FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.conta-transf
            AND   bf-mov-conta.cd-sequencia = mov-conta.seq-transf NO-ERROR.
        IF NOT AVAIL bf-mov-conta THEN DO:

            FIND LAST bf-mov-conta-aux NO-LOCK
                WHERE bf-mov-conta-aux.cd-conta = mov-conta.conta-transf NO-ERROR.
            IF AVAILABLE bf-mov-conta-aux THEN
                ASSIGN mov-conta.seq-transf = bf-mov-conta-aux.cd-sequencia + 1.
            ELSE
                ASSIGN mov-conta.seq-transf = 1.

            CREATE bf-mov-conta.
            ASSIGN bf-mov-conta.cd-conta = mov-conta.conta-transf
                   bf-mov-conta.cd-sequencia = mov-conta.seq-transf
                   bf-mov-conta.id-situacao = 1.
        END.
        ASSIGN bf-mov-conta.de-valor = valor-transf.
    END.

    /* Se for n∆o compensado, deixa a data de compensaá∆o igual a ? */
    IF mov-conta.id-situacao = 1 THEN
        ASSIGN mov-conta.dt-compensacao = ?.

    /* Se for despesa altera o valor para negativo e vice-e-versa */
    IF ((mov-conta.id-tipo = 1
    OR mov-conta.id-tipo = 2)
    AND mov-conta.de-valor < 0)
    OR ((mov-conta.id-tipo = 4
    OR mov-conta.id-tipo = 5
    OR mov-conta.id-tipo = 6
    OR mov-conta.id-tipo = 7)
    AND mov-conta.de-valor > 0) THEN
        ASSIGN mov-conta.de-valor = (-1) * mov-conta.de-valor
               valor-transf = (-1) * valor-transf.

    /* Se for transferància zera os campos n∆o utilizados */
    IF mov-conta.id-tipo = 3 THEN
        ASSIGN bf-mov-conta.nr-mov         = mov-conta.nr-mov
               bf-mov-conta.de-valor       = valor-transf
               bf-mov-conta.dt-mov         = mov-conta.dt-mov
               bf-mov-conta.conta-transf   = mov-conta.cd-conta
               bf-mov-conta.seq-transf     = mov-conta.cd-sequencia
               bf-mov-conta.cd-favorecido  = mov-conta.cd-favorecido
               bf-mov-conta.id-tipo        = mov-conta.id-tipo
               bf-mov-conta.cd-agenda      = mov-conta.cd-agenda
               bf-mov-conta.cod-categoria  = 0
               bf-mov-conta.cd-sub         = 0
               mov-conta.cod-categoria     = 0
               mov-conta.cd-sub            = 0.
    ELSE
        ASSIGN mov-conta.conta-transf = 0
               mov-conta.seq-transf   = 0.

    /* Se for uma transferància acerta a moeda do outro movimento */
    IF mov-conta.id-tipo = 3 THEN DO:
        FIND FIRST bf-conta NO-LOCK
            WHERE bf-conta.cd-conta = mov-conta.conta-transf NO-ERROR.
        IF AVAIL bf-conta THEN DO:
            ASSIGN bf-mov-conta.cd-moeda = bf-conta.cd-moeda.
        END.
    END.

    /* Guarda o campo respons†vel */
    ASSIGN mov-conta.usuar-resp = (IF INPUT FRAME {&FRAME-NAME} mov-conta.usuar-resp = "Todos" THEN "" ELSE INPUT FRAME {&FRAME-NAME} mov-conta.usuar-resp).
    IF mov-conta.usuar-resp = "Todos" THEN
        ASSIGN mov-conta.usuar-resp = "".

    /* Se for um agrupamento */
    IF mov-conta.id-tipo = 0 THEN DO:
        /* Zera os campos n∆o utilizados */
        ASSIGN mov-conta.cod-categoria = 0
               mov-conta.cd-sub        = 0
               mov-conta.conta-transf  = 0
               mov-conta.seq-transf    = 0
               mov-conta.de-valor      = 0.
        /* Sincroniza os campos dos movimentos agrupados e faz o somat¢rio do valor de agrupamento */
        FOR EACH bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
            AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
            IF bf-mov-conta.id-tipo = 3 THEN DO:
                FIND FIRST bf-mov-conta-aux 
                    WHERE bf-mov-conta-aux.cd-conta     = bf-mov-conta.conta-transf
                    AND   bf-mov-conta-aux.cd-sequencia = bf-mov-conta.seq-transf
                    AND   bf-mov-conta-aux.conta-transf = bf-mov-conta.cd-conta EXCLUSIVE-LOCK NO-ERROR.
                IF AVAIL bf-mov-conta-aux THEN DO:
                    ASSIGN bf-mov-conta-aux.dt-mov = mov-conta.dt-mov.
                END.
            END.
            ASSIGN mov-conta.de-valor = mov-conta.de-valor + bf-mov-conta.de-valor
                   bf-mov-conta.id-situacao = mov-conta.id-situacao
                   bf-mov-conta.dt-mov = mov-conta.dt-mov
                   bf-mov-conta.dt-compensacao = mov-conta.dt-compensacao.
            /* Se o n£mero n∆o foi informado, mantÇm o original dos movimentos agrupados */
            IF mov-conta.nr-mov <> "" THEN
                ASSIGN bf-mov-conta.nr-mov = mov-conta.nr-mov.
            /* Se o respons†vel do movimento de agrupamento for diferente de Todos replica para
               os movimentos agrupados */
            IF mov-conta.usuar-resp <> "" THEN
                ASSIGN bf-mov-conta.usuar-resp = mov-conta.usuar-resp.
        END.
    END.

    /* Se for um movimento agrupado */
    IF mov-conta.agrupado <> 0 THEN DO:
        FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
            AND   bf-mov-conta.cd-sequencia = mov-conta.agrupado NO-ERROR.
        /* Se o respons†vel do agrupamento foi informado replica para o agrupado */
        IF bf-mov-conta.usuar-resp <> "" THEN
            IF mov-conta.usuar-resp = "" THEN
                ASSIGN mov-conta.usuar-resp = bf-mov-conta.usuar-resp.
        /* Soma o valor do agrupado ao valor do agrupamento */
        ASSIGN bf-mov-conta.de-valor = 0.
        FOR EACH bf-mov-conta-aux NO-LOCK
            WHERE bf-mov-conta-aux.cd-conta = bf-mov-conta.cd-conta
            AND   bf-mov-conta-aux.agrupado = bf-mov-conta.cd-sequencia:
            ASSIGN bf-mov-conta.de-valor = bf-mov-conta.de-valor + bf-mov-conta-aux.de-valor.
        END.
    END.

    /* Testa se tem agendamento e marca como pago */
    ASSIGN lPaga = YES.
    FIND FIRST agenda 
        WHERE agenda.cd-favorecido = mov-conta.cd-favorecido
        AND   agenda.id-tipo = mov-conta.id-tipo
        AND   agenda.cod-categoria = mov-conta.cod-categoria
        AND   agenda.cd-sub = mov-conta.cd-sub 
        AND   agenda.cd-conta = mov-conta.cd-conta
        AND   CAN-FIND(FIRST agenda-valor
                       WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                       AND   agenda-valor.valor = mov-conta.de-valor
                       AND   agenda-valor.dt-ini <= mov-conta.dt-mov
                       AND   agenda-valor.dt-end >= mov-conta.dt-mov) EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAIL agenda THEN
        IF mov-conta.id-tipo = 3 THEN
            FIND FIRST agenda 
                WHERE agenda.cd-favorecido = mov-conta.cd-favorecido
                AND   agenda.id-tipo = mov-conta.id-tipo
                AND   agenda.cod-categoria = mov-conta.cod-categoria
                AND   agenda.cd-sub = mov-conta.cd-sub 
                AND   agenda.cd-conta = mov-conta.conta-transf
                AND   CAN-FIND(FIRST agenda-valor
                               WHERE agenda-valor.cd-agenda = agenda.cd-agenda
                               AND   agenda-valor.valor = mov-conta.de-valor
                               AND   agenda-valor.dt-ini <= mov-conta.dt-mov
                               AND   agenda-valor.dt-end >= mov-conta.dt-mov) EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAIL agenda THEN
        IF mov-conta.id-tipo = 3 THEN
            FIND FIRST agenda 
                WHERE agenda.cd-favorecido = mov-conta.cd-favorecido
                AND   agenda.id-tipo = mov-conta.id-tipo
                AND   agenda.cod-categoria = mov-conta.cod-categoria
                AND   agenda.cd-sub = mov-conta.cd-sub 
                AND   agenda.cd-conta = mov-conta.conta-transf EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAIL agenda THEN
        FIND FIRST agenda 
            WHERE agenda.cd-favorecido = mov-conta.cd-favorecido
            AND   agenda.id-tipo = mov-conta.id-tipo
            AND   agenda.cod-categoria = mov-conta.cod-categoria
            AND   agenda.cd-sub = mov-conta.cd-sub 
            AND   agenda.cd-conta = mov-conta.cd-conta EXCLUSIVE-LOCK NO-ERROR.

    IF AVAIL agenda THEN DO:

        IF mov-conta.cd-agenda = 0 THEN DO:

            IF agenda.dt-ultimo-pag < mov-conta.dt-mov THEN DO:
    
                {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Altera Agendamento (004)', INPUT 'Deseja marcar agendamento como PAGO ?', INPUT 'Esse movimento corresponde a um agendamento. Se responder sim, o pr¢ximo pagamento desse agendamento ser† marcado como pago.')"}
                IF RETURN-VALUE <> "NOK" THEN DO:
                    ASSIGN agenda.vl-atual = 0.
                    ASSIGN mov-conta.cd-agenda = agenda.cd-agenda.
                    IF mov-conta.id-tipo = 3 THEN DO:
                        FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
                            WHERE bf-mov-conta.cd-conta = mov-conta.conta-transf
                            AND   bf-mov-conta.cd-sequencia = mov-conta.seq-transf NO-ERROR.
                        IF AVAIL bf-mov-conta THEN
                            ASSIGN bf-mov-conta.cd-agenda = agenda.cd-agenda.
                    END.
                END.
                ELSE DO:
                    ASSIGN lPaga = NO.
                END.
            END.

        END.

    END.

    FIND FIRST param-mn NO-LOCK NO-ERROR.
    IF param-mn.perfil = 2 /* Empresarial */ THEN DO:
        /* Verifica se o movimento Ç uma parcela de NF ou imposto retido */
        IF mov-conta.id-tipo <> 0 /* Agrupamento */ THEN DO:
            IF mov-conta.ds-observacao MATCHES("*FATURAMENTO - Controle:*") THEN DO:
                FIND FIRST parc-nota-fiscal EXCLUSIVE-LOCK
                    WHERE parc-nota-fiscal.nr-controle = mov-conta.nr-controle
                    AND   parc-nota-fiscal.sequencia = mov-conta.sequencia
                    AND   parc-nota-fiscal.situacao = 1 /* Pendente */ NO-ERROR.
                IF AVAIL parc-nota-fiscal THEN DO:
                    ASSIGN parc-nota-fiscal.situacao = 2 /* Liquidada */
                           parc-nota-fiscal.cd-conta = mov-conta.cd-conta
                           parc-nota-fiscal.cd-sequencia = mov-conta.cd-sequencia.
                END.
            END.
        END.
        ELSE DO:
            FOR EACH bf-mov-conta EXCLUSIVE-LOCK
                WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
                AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
                IF bf-mov-conta.ds-observacao MATCHES("*FATURAMENTO - Controle:*") THEN DO:
                    FIND FIRST parc-nota-fiscal EXCLUSIVE-LOCK
                        WHERE parc-nota-fiscal.nr-controle = bf-mov-conta.nr-controle
                        AND   parc-nota-fiscal.sequencia = bf-mov-conta.sequencia
                        AND   parc-nota-fiscal.situacao = 1 /* Pendente */ NO-ERROR.
                    IF AVAIL parc-nota-fiscal THEN DO:
                        ASSIGN parc-nota-fiscal.situacao = 2 /* Liquidada */
                               parc-nota-fiscal.cd-conta = bf-mov-conta.cd-conta
                               parc-nota-fiscal.cd-sequencia = bf-mov-conta.cd-sequencia.
                    END.
                END.
                IF bf-mov-conta.ds-observacao MATCHES("*PAGAMENTO DE IMPOSTO RETIDO - Controle:*") THEN DO:
                    FIND FIRST nota-fiscal-imp EXCLUSIVE-LOCK
                        WHERE nota-fiscal-imp.nr-controle = bf-mov-conta.nr-controle
                        AND   nota-fiscal-imp.cod-imposto = bf-mov-conta.cod-imposto
                        AND   nota-fiscal-imp.situacao = 2 /* Retido */ NO-ERROR.
                    IF AVAIL nota-fiscal-imp THEN DO:
                        ASSIGN nota-fiscal-imp.situacao = 3 /* Pago */
                               nota-fiscal-imp.cd-conta = bf-mov-conta.cd-conta
                               nota-fiscal-imp.cd-sequencia = bf-mov-conta.cd-sequencia.
                    END.
                END.
            END.
        END.

        /* Realiza o pagamento dos impostos */
        FIND FIRST agenda OF mov-conta NO-LOCK NO-ERROR.
        IF AVAIL agenda THEN DO:
            IF CAN-FIND(FIRST imposto OF agenda) THEN DO:
                ASSIGN de-aux-imp = mov-conta.de-valor.
                FOR EACH nota-fiscal-imp
                    WHERE nota-fiscal-imp.cd-conta = mov-conta.cd-conta
                    AND   nota-fiscal-imp.cd-sequencia = mov-conta.cd-sequencia NO-LOCK:
                    ASSIGN de-aux-imp = de-aux-imp + nota-fiscal-imp.val-imposto.
                END.
                IF de-aux-imp < 0 THEN DO:
                    blk-imp:
                    FOR EACH imposto NO-LOCK
                        WHERE imposto.cd-agenda = agenda.cd-agenda:
                        FOR EACH nota-fiscal-imp OF imposto EXCLUSIVE-LOCK
                            WHERE nota-fiscal-imp.situacao = 1 /* Pendente */
                            BY nota-fiscal-imp.nr-controle:
                            FIND FIRST nota-fiscal OF nota-fiscal-imp NO-LOCK NO-ERROR.
                            IF nota-fiscal.dt-emissao < mov-conta.dt-mov THEN DO:
                                IF (de-aux-imp + nota-fiscal-imp.val-imposto) <= 0.5 THEN
                                    ASSIGN de-aux-imp = de-aux-imp + nota-fiscal-imp.val-imposto
                                           nota-fiscal-imp.situacao = 3 /* Pago */
                                           nota-fiscal-imp.cd-conta = mov-conta.cd-conta
                                           nota-fiscal-imp.cd-sequencia = mov-conta.cd-sequencia.
                                ELSE
                                    LEAVE blk-imp.
                            END.
                        END.
                    END.
                END.
            END.
        END.

    END.

    /* Calcula pr¢ximo pagamento */
    IF lPaga THEN DO:
        IF mov-conta.cd-agenda <> 0 THEN DO:
            IF mov-conta.agrupado = 0 THEN DO:
                FIND FIRST agenda OF mov-conta NO-LOCK NO-ERROR.
                IF AVAIL agenda THEN DO:
                    IF mov-conta.dt-mov > agenda.dt-ultimo-pag THEN DO:
                        RUN calculaProximoPag(INPUT mov-conta.cd-agenda, INPUT mov-conta.dt-mov, INPUT TRUE, OUTPUT dtProx).
                    END.
                END.
            END.
        END.
        IF mov-conta.id-tipo = 0 THEN DO:
            FOR EACH bf-mov-conta NO-LOCK
                WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
                AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
                IF bf-mov-conta.cd-agenda <> 0 THEN DO:
                    FIND FIRST agenda OF bf-mov-conta NO-LOCK NO-ERROR.
                    IF AVAIL agenda THEN DO:
                        IF bf-mov-conta.dt-mov > agenda.dt-ultimo-pag THEN DO:
                            RUN calculaProximoPag(INPUT bf-mov-conta.cd-agenda, INPUT bf-mov-conta.dt-mov, INPUT TRUE, OUTPUT dtProx).
                        END.
                    END.
                END.
            END.
        END.
    END.

    /* Calcula a CPMF se existir agendamento */
    FIND FIRST agenda NO-LOCK
        WHERE agenda.cd-conta = mov-conta.cd-conta
        AND   agenda.calc-cpmf NO-ERROR.
    IF AVAIL agenda THEN DO:
        RUN calcCPMF.p (INPUT agenda.cd-agenda).
    END.
    ELSE DO:
        IF mov-conta.id-tipo = 3 THEN DO:
            FIND FIRST agenda NO-LOCK
                WHERE agenda.cd-conta = mov-conta.conta-transf
                AND   agenda.calc-cpmf NO-ERROR.
            IF AVAIL agenda THEN DO:
                RUN calcCPMF.p (INPUT agenda.cd-agenda).
            END.
        END.
    END.

    /* Verifica se o Favorecido est† totalmente preenchido */
    FIND FIRST favorecido OF mov-conta NO-LOCK NO-ERROR.
    IF favorecido.tem-endereco
    AND (favorecido.cidade = ""
    OR favorecido.estado = ""
    OR favorecido.rua = ""
    OR favorecido.telefone = ""
    OR favorecido.bairro = "") THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Atualizar Favorecido (026)', INPUT 'Deseja atualizar o favorecido ?', INPUT 'O endereáo do favorecido n∆o foi informado. Se vocà responder sim ser† aberto o cadastro para realizar a alteraá∆o.')"}
        IF RETURN-VALUE = "OK" THEN DO:
            ASSIGN r-favorecido = ROWID(favorecido).
            {func\run.i &Programa = "fav.w"}
        END.
    END.

    /* Valida se o pedido informado n∆o Ç antecipaá∆o e troca o n£mero se for */
    FIND FIRST pedido OF mov-conta NO-LOCK NO-ERROR.
    IF AVAIL pedido THEN DO:
        IF pedido.nr-pedido-ant <> 0 THEN DO:
            FIND FIRST bf-ped NO-LOCK
                WHERE bf-ped.nr-pedido = pedido.nr-pedido-ant NO-ERROR.
            IF AVAIL bf-ped THEN
                ASSIGN mov-conta.nr-pedido = bf-ped.nr-pedido.
        END.
    END.

    /* Roda o programa de alertas do usu†rio */
    {func\run.i &Programa = "winalert.w (INPUT 2, INPUT ROWID(mov-conta), INPUT YES, OUTPUT TABLE tt-alerta)"}

    /* Se for uma sub-categoria de reembolso abre o programa para atualizaá∆o */
    FIND FIRST sub-cat OF mov-conta NO-LOCK NO-ERROR.
    IF AVAIL sub-cat AND sub-cat.reembolso THEN DO:
        IF NOT CAN-FIND(FIRST reembolso
                        WHERE (reembolso.cd-conta-de       = mov-conta.cd-conta
                        AND    reembolso.cd-sequencia-de   = mov-conta.cd-sequencia)
                        OR    (reembolso.cd-conta-para     = mov-conta.cd-conta
                        AND    reembolso.cd-sequencia-para = mov-conta.cd-sequencia)) THEN DO:
            {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Controle de Reembolsos (042)', INPUT 'Deseja efetuar reembolso agora ?', INPUT 'A Sub-Categoria do movimento corresponde a um reembolso. Se esse for um reembolso de despesa ou um pagamento de emprÇstimo vocà deve responder SIM. Caso o reembolso n∆o for efetuado nesse momento ele pode ser efetuado mais tarde pela opá∆o de menu Funá‰es\Controle de Reembolsos.')"}
            IF RETURN-VALUE = "OK" THEN DO:
                {func\run.i &Programa = "reembolsa.w"}
            END.
        END.
    END.

    /* Verifica se algum movimento parecido j† foi relacionado a um bem */
    IF mov-conta.id-tipo <> 0 THEN DO:
        RUN procura_rel_bem (BUFFER mov-conta).
    END.
    ELSE DO:
        FOR EACH bf-mov-conta NO-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
            AND   bf-mov-conta.agrupado = mov-conta.cd-sequencia:
            RUN procura_rel_bem (BUFFER bf-mov-conta).
        END.
    END.


    IF pcActionBT = "ADD" THEN DO:
        RUN som.p(INPUT "music\tutun.wav").
    END.

    RETURN "OK".

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
IF AVAIL conta THEN DO:
    IF conta.id-tipo = 1 THEN DO:
        ASSIGN mov-conta.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Agrupamento,0,Cheque,4,Dep¢sito,1,Pagamento,5,Saque em Dinheiro,6,Transferància,3".
    END.
    IF conta.id-tipo = 2 THEN DO:
        ASSIGN mov-conta.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Agrupamento,0,Dep¢sito,1,Saque em Dinheiro,6,Transferància,3".
    END.
    IF conta.id-tipo = 3 THEN DO:
        IF NOT conta.dinheiro THEN
            ASSIGN mov-conta.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Agrupamento,0,Transferància,3,DÇbito,7,CrÇdito,2".
        ELSE
            ASSIGN mov-conta.id-tipo:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "Agrupamento,0,Transferància,3,Gasto,7,Recebimento,2".
    END.

    FIND FIRST moeda OF conta NO-LOCK NO-ERROR.
    IF AVAIL moeda THEN DO:
        ASSIGN des-moeda = moeda.ds-moeda.
    END.
    ELSE DO:
        ASSIGN des-moeda = "".
    END.
END.

IF AVAIL mov-conta THEN DO:
    IF pcActionBT = "ADD" THEN DO:
        CASE conta.id-tipo:
            WHEN 1 THEN DO:
                ASSIGN mov-conta.id-tipo = 5.
            END.
            WHEN 2 THEN DO:
                ASSIGN mov-conta.id-tipo = 1.
            END.
            WHEN 3 THEN DO:
                ASSIGN mov-conta.id-tipo = 7.
            END.
        END CASE.
        ASSIGN mov-conta.id-situacao = 1
               mov-conta.dt-mov = TODAY.
    END.
END.

{func\detalhe\display.i}

IF AVAIL mov-conta THEN DO:
    APPLY "VALUE-CHANGED" TO mov-conta.id-tipo IN FRAME {&FRAME-NAME}.
    APPLY "VALUE-CHANGED" TO mov-conta.id-situacao IN FRAME {&FRAME-NAME}.
    APPLY "LEAVE" TO mov-conta.cd-favorecido IN FRAME {&FRAME-NAME}.
    APPLY "LEAVE" TO mov-conta.cod-categoria IN FRAME {&FRAME-NAME}.
    APPLY "LEAVE" TO mov-conta.cd-sub IN FRAME {&FRAME-NAME}.
    APPLY "LEAVE" TO mov-conta.conta-transf IN FRAME {&FRAME-NAME}.

    DISABLE des-moeda WITH FRAME {&FRAME-NAME}.

    IF pcActionBT = "ADD" THEN DO:
        FIND FIRST usuario NO-LOCK
            WHERE usuario.nome = gcUsuario NO-ERROR.
        IF AVAIL usuario AND NOT usuario.administrador THEN
            DISABLE mov-conta.id-situacao WITH FRAME {&FRAME-NAME}.
    END.

    IF mov-conta.agrupado <> 0 THEN DO:
      DISABLE mov-conta.nr-mov
              mov-conta.dt-mov
              mov-conta.dt-compensacao
              mov-conta.id-situacao WITH FRAME {&FRAME-NAME}.
    END.
    IF mov-conta.id-tipo = 0 THEN DO:
      DISABLE mov-conta.id-tipo WITH FRAME {&FRAME-NAME}.
    END.

    IF mov-conta.usuar-resp = "" THEN
        ASSIGN mov-conta.usuar-resp:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Todos".
    ELSE
        DISP mov-conta.usuar-resp WITH FRAME {&FRAME-NAME}.

    IF pcActionBT = "DETAIL"
    OR mov-conta.agrupado <> 0 THEN
        DISABLE mov-conta.usuar-resp WITH FRAME {&FRAME-NAME}.

    IF pcActionBT = "DETAIL" THEN DO:
        ENABLE mov-conta.ds-observacao WITH FRAME {&FRAME-NAME}.
        ASSIGN mov-conta.ds-observacao:READ-ONLY IN FRAME {&FRAME-NAME} = YES.
    END.
END.

IF param-mn.perfil = 1 /* Pessoal */ THEN
    ASSIGN mov-conta.nr-pedido:HIDDEN = TRUE.

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
  DISPLAY des-moeda valor-transf moeda-transf ds-conta-transf fav cat subcat 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE conta THEN 
    DISPLAY conta.ds-conta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE mov-conta THEN 
    DISPLAY mov-conta.cd-conta mov-conta.cd-sequencia mov-conta.id-tipo 
          mov-conta.dt-mov mov-conta.dt-compensacao mov-conta.id-situacao 
          mov-conta.nr-mov mov-conta.de-valor mov-conta.cd-favorecido 
          mov-conta.cod-categoria mov-conta.cd-sub mov-conta.conta-transf 
          mov-conta.seq-transf mov-conta.agrupado mov-conta.cd-agenda 
          mov-conta.usuar-resp mov-conta.nr-pedido mov-conta.ds-observacao 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE mov-conta.cd-conta btTransf btReemb mov-conta.cd-sequencia btBem 
         mov-conta.id-tipo mov-conta.dt-mov mov-conta.dt-compensacao btProj 
         mov-conta.id-situacao mov-conta.nr-mov btAgrup mov-conta.de-valor 
         mov-conta.cd-favorecido mov-conta.cod-categoria mov-conta.cd-sub 
         mov-conta.conta-transf mov-conta.cd-agenda mov-conta.usuar-resp 
         mov-conta.nr-pedido mov-conta.ds-observacao btImpto RECT-10 RECT-2 
         RECT-7 RECT-8 RECT-9 
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

ASSIGN mov-conta.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = "Todos".

FOR EACH usuario:
    FIND FIRST favorecido OF usuario NO-LOCK NO-ERROR.
    IF AVAIL favorecido AND NOT favorecido.ativo THEN NEXT.
    ASSIGN mov-conta.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = mov-conta.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} + "," + usuario.nome.
END.

/*Caso usu†rio respons†vel pelo movimento esteja como inativo ainda assim carrega na lista para evitar erros*/
FOR FIRST bf-movc NO-LOCK
    WHERE ROWID(bf-movc) = r-mov-conta:
    IF bf-movc.usuar-resp <> "" AND LOOKUP(bf-movc.usuar-resp,STRING(mov-conta.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME})) = 0 THEN DO:
        ASSIGN mov-conta.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = mov-conta.usuar-resp:LIST-ITEMS IN FRAME {&FRAME-NAME} + "," + bf-movc.usuar-resp.
    END.
END.

{func\detalhe\initialize.i}

{func\sugere_cod.i cd-sequencia}

DISABLE mov-conta.cd-sequencia
        mov-conta.seq-transf
        mov-conta.agrupado
        mov-conta.cd-agenda
        mov-conta.nr-pedido WITH FRAME {&FRAME-NAME}.

{func\cursor.i mov-conta.cd-favorecido}
{func\cursor.i mov-conta.cod-categoria}
{func\cursor.i mov-conta.cd-sub}
{func\cursor.i mov-conta.conta-transf}
{func\cursor.i mov-conta.agrupado}

IF CAN-FIND(FIRST reembolso
            WHERE (reembolso.cd-conta-de       = mov-conta.cd-conta
            AND    reembolso.cd-sequencia-de   = mov-conta.cd-sequencia)
            OR    (reembolso.cd-conta-para     = mov-conta.cd-conta
            AND    reembolso.cd-sequencia-para = mov-conta.cd-sequencia)) THEN DO:
    ENABLE btReemb WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    DISABLE btReemb WITH FRAME {&FRAME-NAME}.
END.

IF param-mn.perfil <> 2 THEN
    ASSIGN btImpto:HIDDEN = TRUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE leaveContaTransf C-Win 
PROCEDURE leaveContaTransf :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER iMoeda AS INTEGER    NO-UNDO.

FIND FIRST moeda NO-LOCK
    WHERE moeda.cd-moeda = iMoeda NO-ERROR.
IF AVAIL moeda THEN DO:
    ASSIGN moeda-transf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = moeda.ds-moeda.
END.
ELSE DO:
    ASSIGN moeda-transf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
END.

IF iMoeda <> conta.cd-moeda THEN DO:
    IF pcActionBT <> "DETAIL" THEN
        ENABLE valor-transf WITH FRAME {&FRAME-NAME}.
END.
ELSE DO:
    DISABLE valor-transf WITH FRAME {&FRAME-NAME}.
END.

FIND FIRST bf-mov-conta NO-LOCK
    WHERE bf-mov-conta.cd-conta = INPUT FRAME {&FRAME-NAME} mov-conta.conta-transf
    AND   bf-mov-conta.cd-sequencia = INPUT FRAME {&FRAME-NAME} mov-conta.seq-transf NO-ERROR.
IF AVAIL bf-mov-conta THEN DO:
    IF iMoeda <> conta.cd-moeda THEN
        ASSIGN valor-transf = bf-mov-conta.de-valor.
    ELSE
        ASSIGN valor-transf = INPUT FRAME {&FRAME-NAME} mov-conta.de-valor * (-1).
END.
ELSE DO:
    IF iMoeda <> conta.cd-moeda THEN DO:
        ASSIGN valor-transf = fnCotacao(INPUT FRAME {&FRAME-NAME} mov-conta.de-valor,
                                        conta.cd-moeda,
                                        iMoeda,
                                        INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov) * (-1).
    END.
    ELSE DO:
        ASSIGN valor-transf = INPUT FRAME {&FRAME-NAME} mov-conta.de-valor * (-1).
    END.
END.
DISPLAY valor-transf WITH FRAME {&FRAME-NAME}.

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

IF cObject = "fav" THEN DO:
    FIND FIRST favorecido NO-LOCK
        WHERE favorecido.ds-favorecido = INPUT FRAME {&FRAME-NAME} fav NO-ERROR.
    IF AVAIL favorecido THEN DO:
        ASSIGN mov-conta.cd-favorecido:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(favorecido.cd-favorecido).
    END.
END.
IF cObject = "cat" THEN DO:
    FIND FIRST categoria NO-LOCK
        WHERE categoria.ds-categoria = INPUT FRAME {&FRAME-NAME} cat NO-ERROR.
    IF AVAIL categoria THEN DO:
        ASSIGN mov-conta.cod-categoria:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(categoria.cod-categoria).
    END.
END.
IF cObject = "subcat" THEN DO:
    FIND FIRST sub-cat NO-LOCK
        WHERE sub-cat.ds-sub = INPUT FRAME {&FRAME-NAME} subcat NO-ERROR.
    IF AVAIL sub-cat THEN DO:
        ASSIGN mov-conta.cd-sub:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(sub-cat.cd-sub).
    END.
END.
IF cObject = "ds-conta-transf" THEN DO:
    FIND FIRST conta NO-LOCK
        WHERE conta.ds-conta = INPUT FRAME {&FRAME-NAME} ds-conta-transf NO-ERROR.
    IF AVAIL conta THEN DO:
        ASSIGN mov-conta.conta-transf:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(conta.cd-conta).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procura_rel_bem C-Win 
PROCEDURE procura_rel_bem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE PARAMETER BUFFER pbf-mov FOR mov-conta.

    DEFINE BUFFER bf-mov-conta-bem FOR mov-conta.
    DEFINE BUFFER bf-mov-bens FOR mov-bens.

    DEFINE VARIABLE cTipo AS CHARACTER   NO-UNDO.

    IF NOT CAN-FIND(FIRST mov-bens OF pbf-mov) THEN DO:

        IF pbf-mov.usuar-resp <> "" THEN DO:
            FOR LAST bf-mov-conta-bem NO-LOCK
                WHERE bf-mov-conta-bem.cd-conta = pbf-mov.cd-conta
                AND   bf-mov-conta-bem.dt-mov < pbf-mov.dt-mov
                AND   bf-mov-conta-bem.cd-favorecido = pbf-mov.cd-favorecido
                AND   bf-mov-conta-bem.cod-categoria = pbf-mov.cod-categoria
                AND   bf-mov-conta-bem.cd-sub = pbf-mov.cd-sub
                AND   bf-mov-conta-bem.id-tipo = pbf-mov.id-tipo
                AND   bf-mov-conta-bem.usuar-resp = pbf-mov.usuar-resp,
                FIRST mov-bens OF bf-mov-conta-bem NO-LOCK
                BY bf-mov-conta-bem.dt-mov:
            END.
        END.

        IF NOT AVAIL mov-bens THEN DO:
            FOR LAST bf-mov-conta-bem NO-LOCK
                WHERE bf-mov-conta-bem.cd-conta = pbf-mov.cd-conta
                AND   bf-mov-conta-bem.dt-mov < pbf-mov.dt-mov
                AND   bf-mov-conta-bem.cd-favorecido = pbf-mov.cd-favorecido
                AND   bf-mov-conta-bem.cod-categoria = pbf-mov.cod-categoria
                AND   bf-mov-conta-bem.cd-sub = pbf-mov.cd-sub
                AND   bf-mov-conta-bem.id-tipo = pbf-mov.id-tipo,
                FIRST mov-bens OF bf-mov-conta-bem NO-LOCK
                BY bf-mov-conta-bem.dt-mov:
            END.
        END.

        IF AVAIL mov-bens THEN DO:

            CASE mov-bens.id-tipo:
                WHEN 1 THEN ASSIGN cTipo = "Aquisiá∆o".
                WHEN 2 THEN ASSIGN cTipo = "Valor Agregado".
                WHEN 3 THEN ASSIGN cTipo = "Manutená∆o".
                WHEN 4 THEN ASSIGN cTipo = "Despesa".
                WHEN 5 THEN ASSIGN cTipo = "Consumo".
                WHEN 6 THEN ASSIGN cTipo = "Venda".
            END CASE.

            FIND FIRST bens OF mov-bens NO-LOCK NO-ERROR.

            {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Relacionar com Bem (047)', INPUT 'Deseja relacionar o movimento com o Bem ?', INPUT 'Existe um movimento anterior idàntico relacionado a ' + cTipo + ' do bem ' + bens.ds-bens + '. Deseja associar automaticamente esse movimento ao bem ?')"}
            IF RETURN-VALUE = "OK" THEN DO:
                CREATE bf-mov-bens.
                BUFFER-COPY pbf-mov TO bf-mov-bens.
                BUFFER-COPY bens TO bf-mov-bens.
                ASSIGN bf-mov-bens.id-tipo = mov-bens.id-tipo.
                IF mov-bens.id-tipo = 5 THEN DO:
                    ASSIGN r-parent = ROWID(pbf-mov)
                           r-mov-bens = ROWID(bf-mov-bens)
                           pcActionBT = "UPDATE".
                    {func\run.i &Programa = "mov-bens_det.w"}
                END.
            END.

        END.

    END.

    RETURN "OK".

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
DEFINE BUFFER bf-conta FOR conta.
DEFINE VARIABLE deSaldo AS DECIMAL    NO-UNDO.

IF pcActionBT = "ADD" THEN DO:
    /* Validar Chave Duplicada */
    FIND FIRST bf-mov-conta NO-LOCK
        WHERE bf-mov-conta.cd-conta      = INPUT FRAME {&FRAME-NAME} mov-conta.cd-conta
        AND   bf-mov-conta.cd-sequencia  = INPUT FRAME {&FRAME-NAME} mov-conta.cd-sequencia
        AND   ROWID(bf-mov-conta) <> ROWID(mov-conta) NO-ERROR.
    IF AVAIL bf-mov-conta THEN DO:
        {func\valida.i &Mensagem  = "Registro j† casdastrado!"
                       &Ajuda     = "Esse registro j† foi cadastrado anteriormente."}
    END.
END.

IF pcActionBT = "ADD"
OR pcActionBT = "UPDATE" THEN DO:

    /* Valida Chaves Extrangeiras */
    IF NOT CAN-FIND(FIRST favorecido
                WHERE favorecido.cd-favorecido = INPUT FRAME {&FRAME-NAME} mov-conta.cd-favorecido) THEN DO:
        {func\valida.i &Mensagem  = "Favorecido n∆o encontrado!"
                       &Ajuda     = "N∆o foi encontrado o Favorecido informado."
                       &Campo     = mov-conta.cd-favorecido}
    END.

    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo <> 3
    AND INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo <> 0 THEN DO:

        FIND FIRST categoria NO-LOCK
            WHERE categoria.cod-categoria = INPUT FRAME {&FRAME-NAME} mov-conta.cod-categoria NO-ERROR.
        IF NOT AVAIL categoria THEN DO:
            {func\valida.i &Mensagem  = "Categoria n∆o encontrada!"
                           &Ajuda     = "N∆o foi encontrada a categoria informada."
                           &Campo     = mov-conta.cod-categoria}
        END.

        FIND FIRST sub-cat NO-LOCK
            WHERE  sub-cat.cd-sub        = INPUT FRAME {&FRAME-NAME} mov-conta.cd-sub
            AND    sub-cat.cod-categoria = INPUT FRAME {&FRAME-NAME} mov-conta.cod-categoria NO-ERROR.

        IF NOT AVAILABLE sub-cat THEN DO:
            {func\valida.i &Mensagem  = "Sub-Categoria n∆o encontrada!"
                           &Ajuda     = "N∆o foi encontrada a sub-categoria informada."
                           &Campo     = mov-conta.cd-sub}
        END.
        ELSE DO:
            IF sub-cat.obriga-num AND INPUT FRAME {&FRAME-NAME} mov-conta.nr-mov = "" THEN DO:
                {func\valida.i &Mensagem  = "N£mero do movimento obrigat¢rio!"
                               &Ajuda     = "Vocà deve informar o n£mero do movimento para esta categoria/sub-categoria."
                               &Campo     = mov-conta.nr-mov}
            END.
        END.
    END.
    ELSE DO:
        IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 0 THEN DO:
            blk-agrup:
            FOR EACH bf-movc NO-LOCK
                WHERE bf-movc.cd-conta = mov-conta.cd-conta
                AND   bf-movc.agrupado = mov-conta.cd-sequencia:
                IF bf-movc.id-tipo <> 3
                AND bf-movc.id-tipo <> 0 THEN DO:
                    FIND FIRST sub-cat NO-LOCK
                        WHERE  sub-cat.cd-sub        = bf-movc.cd-sub
                        AND    sub-cat.cod-categoria = bf-movc.cod-categoria NO-ERROR.
                    IF AVAIL sub-cat THEN DO:
                        IF sub-cat.obriga-num AND INPUT FRAME {&FRAME-NAME} mov-conta.nr-mov = "" THEN DO:
                            {func\valida.i &Mensagem  = "N£mero do movimento obrigat¢rio!"
                                           &Ajuda     = "Vocà deve informar o n£mero do movimento para esta categoria/sub-categoria."
                                           &Campo     = mov-conta.nr-mov}
                            LEAVE blk-agrup.
                        END.
                    END.
                END.
            END.
        END.
    END.

    CASE INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo:
        WHEN 4 OR 
        WHEN 5 OR
        WHEN 6 OR
        WHEN 7 THEN DO:
            IF categoria.id-tipo = 1 THEN DO:
                {func\valida.i &Mensagem  = "Categoria inv†lida!"
                               &Ajuda     = "Foi informada uma categoria de receita para um tipo de movimento de despesa."
                               &Campo     = mov-conta.cod-categoria}
            END.
        END.
        WHEN 1 OR 
        WHEN 2 THEN DO:
            IF categoria.id-tipo = 2 THEN DO:
                {func\valida.i &Mensagem  = "Categoria inv†lida!"
                               &Ajuda     = "Foi informada uma categoria de despesa para um tipo de movimento de receita."
                               &Campo     = mov-conta.cod-categoria}
            END.
        END.
    END CASE.

    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-situacao <> 1 
    AND INPUT FRAME {&FRAME-NAME} mov-conta.dt-compensacao = ? THEN DO:
        {func\valida.i &Mensagem  = "Data n∆o informada!"
                       &Ajuda     = "N∆o foi informada a data de compensaá∆o do movimento."
                       &Campo     = mov-conta.dt-compensacao}
    END.

    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 3 THEN DO:
        FIND FIRST bf-conta NO-LOCK
            WHERE bf-conta.cd-conta = INPUT FRAME {&FRAME-NAME} mov-conta.conta-transf NO-ERROR.
        IF NOT AVAIL bf-conta THEN DO:
            {func\valida.i &Mensagem  = "Conta inv†lida!"
                           &Ajuda     = "A conta de transferància informada n∆o existe."
                           &Campo     = mov-conta.conta-transf}
        END.
        FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.conta-transf
            AND   bf-mov-conta.cd-sequencia = mov-conta.seq-transf NO-ERROR.
        IF AVAIL bf-mov-conta THEN DO:
            IF bf-mov-conta.id-situacao <> 1 THEN DO:
                IF INPUT FRAME {&FRAME-NAME} mov-conta.de-valor <> mov-conta.de-valor
                OR INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov <> mov-conta.dt-mov THEN DO:
                    {func\valida.i &Mensagem  = "Alteraá∆o n∆o permitida!"
                                   &Ajuda     = "A transferància j† foi compensada na outra conta, e por esse motivo n∆o pode ter seus valores e datas alterados."}
                END.
            END.
        END.
    END.

    /* N∆o permite alterar valores e datas de movimentos reconciliados */
    IF INPUT FRAME {&FRAME-NAME} mov-conta.id-situacao = 3
    AND mov-conta.id-situacao = 3 THEN DO:

        IF INPUT FRAME {&FRAME-NAME} mov-conta.de-valor <> mov-conta.de-valor
        OR INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov <> mov-conta.dt-mov
        OR INPUT FRAME {&FRAME-NAME} mov-conta.dt-compensacao <> mov-conta.dt-compensacao THEN DO:
            {func\valida.i &Mensagem  = "Alteraá∆o n∆o permitida!"
                           &Ajuda     = "N∆o Ç permitido alterar valores e datas de movimentos reconciliados."}
        END.

    END.

    /* Valida Valor do Limite da conta */
    IF /*INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov <= TODAY + 7 AND*/ 
        INPUT FRAME {&FRAME-NAME} mov-conta.id-situacao = 1 THEN DO:
        IF INPUT FRAME {&FRAME-NAME} mov-conta.agrupado = 0 THEN DO:
            ASSIGN deSaldo = conta.vl-saldo.
            FOR EACH bf-mov-conta OF conta NO-LOCK
                WHERE bf-mov-conta.id-situacao <> 3
                AND   bf-mov-conta.agrupado = 0
                AND   bf-mov-conta.dt-mov <= INPUT FRAME {&FRAME-NAME} mov-conta.dt-mov
                AND   ROWID(bf-mov-conta) <> ROWID(mov-conta):
                ASSIGN deSaldo = deSaldo + bf-mov-conta.de-valor.
            END.
            IF ((INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 4
            OR INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 5
            OR INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 6
            OR INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo = 7)
            AND INPUT FRAME {&FRAME-NAME} mov-conta.de-valor > 0) THEN
                ASSIGN deSaldo = deSaldo - INPUT FRAME {&FRAME-NAME} mov-conta.de-valor.
            ELSE
                ASSIGN deSaldo = deSaldo + INPUT FRAME {&FRAME-NAME} mov-conta.de-valor.
            IF deSaldo < (conta.vl-limite * (-1)) AND deSaldo < 0 THEN DO:
                {func\run.i &Programa = "func\msg.w (INPUT 2, INPUT 'Validaá∆o (003)', INPUT 'Movimentaá∆o n∆o permitida!', INPUT 'O valor do movimento estourar† o limite da conta. Deseja prosseguir mesmo assim ?')"}
                IF RETURN-VALUE = "NOK" THEN DO:
                    APPLY "ENTRY":U TO mov-conta.de-valor IN FRAME {&FRAME-NAME}.
                    RETURN "NOK":U.
                END.
            END.
        END.
    END.

END.

/* Se mudou de uma transferància para um movimento normal, elimina o outro movimento de transferància */
IF mov-conta.id-tipo = 3 
AND INPUT FRAME {&FRAME-NAME} mov-conta.id-tipo <> 3 THEN DO:
    FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
        WHERE bf-mov-conta.cd-conta = mov-conta.conta-transf
        AND   bf-mov-conta.cd-sequencia = mov-conta.seq-transf NO-ERROR.
    IF AVAIL bf-mov-conta THEN DO:
        DELETE bf-mov-conta.
    END.
END.

/* Se mudou de agrupamento ou foi agrupado */
IF mov-conta.agrupado <> INPUT FRAME {&FRAME-NAME} mov-conta.agrupado THEN DO:

    /* Recalcula o valor do agrupamento anterior */
    IF mov-conta.agrupado <> 0 THEN DO:
        FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = mov-conta.cd-conta
            AND   bf-mov-conta.cd-sequencia = mov-conta.agrupado NO-ERROR.
        ASSIGN bf-mov-conta.de-valor = 0.
        FOR EACH bf-mov-conta-aux NO-LOCK
            WHERE bf-mov-conta-aux.cd-conta = bf-mov-conta.cd-conta
            AND   bf-mov-conta-aux.agrupado = bf-mov-conta.cd-sequencia
            AND   ROWID(bf-mov-conta-aux) <> ROWID(mov-conta):
            ASSIGN bf-mov-conta.de-valor = bf-mov-conta.de-valor + bf-mov-conta-aux.de-valor.
        END.
    END.
    /* Verifica se o novo agrupamento informado existe */
    IF INPUT FRAME {&FRAME-NAME} mov-conta.agrupado <> 0 THEN DO:
        FIND FIRST bf-mov-conta EXCLUSIVE-LOCK
            WHERE bf-mov-conta.cd-conta = INPUT FRAME {&FRAME-NAME} mov-conta.cd-conta
            AND   bf-mov-conta.cd-sequencia = INPUT FRAME {&FRAME-NAME} mov-conta.agrupado
            AND   bf-mov-conta.id-tipo = 0 NO-ERROR.
        IF NOT AVAIL bf-mov-conta THEN DO:
            {func\valida.i &Mensagem  = "Agrupamento inexistente!"
                           &Ajuda     = "N∆o existe o agrupamento informado."
                           &Campo     = mov-conta.agrupado}
        END.
    END.
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

