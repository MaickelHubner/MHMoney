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

DEFINE TEMP-TABLE tt-fav
    FIELD fav LIKE favorecido.ds-favorecido
    FIELD cgc LIKE favorecido.cgc
    FIELD valor AS DECIMAL COLUMN-LABEL "Valor Total".

DEFINE TEMP-TABLE tt-det
    FIELD fav LIKE favorecido.ds-favorecido
    FIELD cat AS INTEGER
    FIELD sub AS INTEGER
    FIELD descricao AS CHARACTER COLUMN-LABEL "Categoria/Sub-Categoria" FORMAT "X(256)"
    FIELD valor AS DECIMAL COLUMN-LABEL "Valor".

/* Parameters Definitions ---                                           */
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  ano moeda resp inc-todos dep

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\relat\definitions.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btCancel RECT-10 ano resp inc-todos dep ~
moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS ano resp inc-todos dep moeda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btCancel 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Cancelar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btOK 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Executar" 
     SIZE 6.14 BY 1.79 TOOLTIP "Executar".

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 21 BY 1 NO-UNDO.

DEFINE VARIABLE resp AS CHARACTER FORMAT "X(8)":U INITIAL "Todos" 
     LABEL "Respons†vel" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEMS "Todos" 
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE ano AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Ano" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79 NO-UNDO.

DEFINE VARIABLE dep AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Dependentes" 
     VIEW-AS FILL-IN 
     SIZE 8.86 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 6.25.

DEFINE VARIABLE inc-todos AS LOGICAL INITIAL no 
     LABEL "Inclui Todos" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.57 BY .83 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 5.5 COL 73
     ano AT ROW 2 COL 26 COLON-ALIGNED
     resp AT ROW 3 COL 26 COLON-ALIGNED
     inc-todos AT ROW 4 COL 28
     dep AT ROW 5 COL 26 COLON-ALIGNED
     moeda AT ROW 6 COL 26 COLON-ALIGNED
     btOK AT ROW 3.75 COL 73
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 7.5
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
         TITLE              = "Relat¢rio"
         HEIGHT             = 7.5
         WIDTH              = 80
         MAX-HEIGHT         = 8.71
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 8.71
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 7.75
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {0713E8D2-850A-101B-AFC0-4210102A8DA7} type: ProgressBar */
      CtrlFrame:MOVE-AFTER(moeda:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Relat¢rio */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Relat¢rio */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON ENTRY OF ano IN FRAME DEFAULT-FRAME /* Ano */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON LEAVE OF ano IN FRAME DEFAULT-FRAME /* Ano */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btCancel C-Win
ON CHOOSE OF btCancel IN FRAME DEFAULT-FRAME /* Cancelar */
DO:
    {func\relat\bt_cancel.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btOK C-Win
ON CHOOSE OF btOK IN FRAME DEFAULT-FRAME /* Executar */
DO:
    {func\relat\bt_executar.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME dep
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dep C-Win
ON ENTRY OF dep IN FRAME DEFAULT-FRAME /* Dependentes */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL dep C-Win
ON LEAVE OF dep IN FRAME DEFAULT-FRAME /* Dependentes */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME moeda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON ENTRY OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL moeda C-Win
ON LEAVE OF moeda IN FRAME DEFAULT-FRAME /* Moeda */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME resp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL resp C-Win
ON ENTRY OF resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL resp C-Win
ON LEAVE OF resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL resp C-Win
ON VALUE-CHANGED OF resp IN FRAME DEFAULT-FRAME /* Respons†vel */
DO:
  
    IF INPUT FRAME {&FRAME-NAME} resp <> "Todos" THEN DO:
        ENABLE inc-todos WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        DISABLE inc-todos WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

{func\relat\main_block.i}

{campos\cd-moeda.i}                

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
  {version.i r037}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load C-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "r037.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "r037.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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

{func\relat\display.i}

APPLY "VALUE-CHANGED" TO resp IN FRAME {&FRAME-NAME}.

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
  RUN control_load.
  DISPLAY ano resp inc-todos dep moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel RECT-10 ano resp inc-todos dep moeda btOK 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE executaRelatorio C-Win 
PROCEDURE executaRelatorio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* Definiá∆o das vari†veis */
{func\relat\var.i}

FOR EACH tt-fav:
    DELETE tt-fav.
END.
FOR EACH tt-det:
    DELETE tt-det.
END.

DEFINE VARIABLE cTemp AS CHARACTER FORMAT "X(256)" NO-UNDO.
DEFINE VARIABLE iMax AS INTEGER    NO-UNDO.
DEFINE VARIABLE deRend AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deDed AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deEduc AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deImp AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deBase AS DECIMAL    NO-UNDO.
DEFINE VARIABLE deRest AS DECIMAL    NO-UNDO.

/* Acerto de datas */

/* Output padr∆o */
select count(*) into iMax from mov-conta
    WHERE YEAR(mov-conta.dt-mov) = ano
    AND mov-conta.id-tipo <> 3
    AND mov-conta.id-tipo <> 0
    AND (IF resp = "Todos" THEN TRUE ELSE 
        (IF mov-conta.usuar-resp = resp THEN TRUE ELSE
        (IF mov-conta.usuar-resp = "" AND inc-todos THEN TRUE ELSE FALSE))).
{func\relat\ini.i iMax}

/* L¢gica do relat¢rio */

FIND FIRST tabela-ir NO-LOCK
    WHERE tabela-ir.dt-ini <= DATE(1,1,ano)
    AND   tabela-ir.dt-end >= DATE(12,31,ano) NO-ERROR.

ASSIGN cTemp = "Ano: " + STRING(ano,"9999") + "<br>" +
               "Respons†vel: " + resp.
{func\relat\capitulo.i cTemp 600}
{func\relat\end-capitulo.i}
{func\relat\capitulo.i '"Receitas por Favorecido"' 600}

FOR EACH mov-conta NO-LOCK
    WHERE YEAR(mov-conta.dt-mov) = ano
    AND mov-conta.de-valor > 0
    AND mov-conta.id-tipo <> 3
    AND mov-conta.id-tipo <> 0
    AND (IF resp = "Todos" THEN TRUE ELSE 
        (IF mov-conta.usuar-resp = resp THEN TRUE ELSE
        (IF mov-conta.usuar-resp = "" AND inc-todos THEN TRUE ELSE FALSE)))
    BREAK BY mov-conta.cd-favorecido:

    {func\relat\control.i}

    FIND FIRST sub-cat OF mov-conta NO-LOCK.
    FIND FIRST favorecido OF mov-conta NO-LOCK.

    IF sub-cat.l-ir THEN DO:
        FIND FIRST tt-det
            WHERE tt-det.fav = favorecido.ds-favorecido
            AND   tt-det.cat = mov-conta.cod-categoria
            AND   tt-det.sub = mov-conta.cd-sub NO-LOCK NO-ERROR.
        IF NOT AVAIL tt-det THEN DO:

            FIND FIRST categoria OF mov-conta NO-LOCK.

            CREATE tt-det.
            ASSIGN tt-det.fav = favorecido.ds-favorecido
                   tt-det.cat = mov-conta.cod-categoria
                   tt-det.sub = mov-conta.cd-sub
                   tt-det.descricao = TRIM(categoria.ds-categoria) + "/" + TRIM(sub-cat.ds-sub).
        END.

        ASSIGN tt-det.valor = tt-det.valor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
    END.

    IF LAST-OF(mov-conta.cd-favorecido) THEN DO:

        IF CAN-FIND(FIRST tt-det WHERE tt-det.fav = favorecido.ds-favorecido) THEN DO:

            CREATE tt-fav.
            ASSIGN tt-fav.fav = favorecido.ds-favorecido
                   tt-fav.cgc = favorecido.cgc.

            FOR EACH tt-det
                WHERE tt-det.fav = tt-fav.fav:

                ASSIGN tt-fav.valor = tt-fav.valor + tt-det.valor.

            END.

        END.

    END.

END.

ASSIGN deRend = 0.
FOR EACH tt-fav
    BY tt-fav.valor DESCENDING:

    ASSIGN cTemp = tt-fav.fav.
    IF tt-fav.cgc <> "" THEN
        ASSIGN cTemp = cTemp + " - " + tt-fav.cgc.
    {func\relat\titulo.i &Coluna1=cTemp
                         &Tamanho1=450
                         &Coluna2='"Valor"'
                         &Tamanho2=150}
                         
    FOR EACH tt-det
        WHERE tt-det.fav = tt-fav.fav
        BY tt-det.valor DESCENDING:

        {func\relat\linha.i &Coluna1=tt-det.descricao
                            &Align1="left"
                            &Coluna2=tt-det.valor
                            &Align2="right"}
                            
        ASSIGN deRend = deRend + tt-det.valor.

    END.

    {func\relat\total.i &Coluna1='"Total"'
                        &Align1="left"
                        &Coluna2=tt-fav.valor
                        &Align2="right"}

END.

{func\relat\end-capitulo.i}
FOR EACH tt-fav:
    DELETE tt-fav.
END.
FOR EACH tt-det:
    DELETE tt-det.
END.
{func\relat\capitulo.i '"Despesas por Favorecido"' 600}

FOR EACH mov-conta NO-LOCK
    WHERE YEAR(mov-conta.dt-mov) = ano
    AND mov-conta.de-valor < 0
    AND mov-conta.id-tipo <> 3
    AND mov-conta.id-tipo <> 0
    AND (IF resp = "Todos" THEN TRUE ELSE 
        (IF mov-conta.usuar-resp = resp THEN TRUE ELSE
        (IF mov-conta.usuar-resp = "" AND inc-todos THEN TRUE ELSE FALSE)))
    BREAK BY mov-conta.cd-favorecido:

    {func\relat\control.i}

    FIND FIRST sub-cat OF mov-conta NO-LOCK.
    FIND FIRST favorecido OF mov-conta NO-LOCK.

    IF sub-cat.l-ir THEN DO:
        FIND FIRST tt-det
            WHERE tt-det.fav = favorecido.ds-favorecido
            AND   tt-det.cat = mov-conta.cod-categoria
            AND   tt-det.sub = mov-conta.cd-sub NO-LOCK NO-ERROR.
        IF NOT AVAIL tt-det THEN DO:

            FIND FIRST categoria OF mov-conta NO-LOCK.

            CREATE tt-det.
            ASSIGN tt-det.fav = favorecido.ds-favorecido
                   tt-det.cat = mov-conta.cod-categoria
                   tt-det.sub = mov-conta.cd-sub
                   tt-det.descricao = TRIM(categoria.ds-categoria) + "/" + TRIM(sub-cat.ds-sub).
        END.

        ASSIGN tt-det.valor = tt-det.valor + fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
    END.

    IF LAST-OF(mov-conta.cd-favorecido) THEN DO:

        IF CAN-FIND(FIRST tt-det WHERE tt-det.fav = favorecido.ds-favorecido) THEN DO:

            CREATE tt-fav.
            ASSIGN tt-fav.fav = favorecido.ds-favorecido
                   tt-fav.cgc = favorecido.cgc.

            FOR EACH tt-det
                WHERE tt-det.fav = tt-fav.fav:

                ASSIGN tt-fav.valor = tt-fav.valor + tt-det.valor.

            END.

        END.

    END.

END.

ASSIGN deDed = 0
       deEduc = 0
       deImp = 0.
FOR EACH tt-fav
    BY tt-fav.valor DESCENDING:

    ASSIGN cTemp = tt-fav.fav.
    IF tt-fav.cgc <> "" THEN
        ASSIGN cTemp = cTemp + " - " + tt-fav.cgc.
    {func\relat\titulo.i &Coluna1=cTemp
                         &Tamanho1=450
                         &Coluna2='"Valor"'
                         &Tamanho2=150}
                         
    FOR EACH tt-det
        WHERE tt-det.fav = tt-fav.fav
        BY tt-det.valor DESCENDING:

        FIND FIRST sub-cat NO-LOCK
            WHERE sub-cat.cod-categoria = tt-det.cat
            AND   sub-cat.cd-sub = tt-det.sub.
        CASE sub-cat.tp-ir:
            WHEN 0 THEN ASSIGN deDed = deDed + tt-det.valor.
            WHEN 1 THEN ASSIGN deEduc = deEduc + tt-det.valor.
            WHEN 2 THEN ASSIGN deImp = deImp + tt-det.valor.
        END CASE.

        {func\relat\linha.i &Coluna1=tt-det.descricao
                            &Align1="left"
                            &Coluna2=tt-det.valor
                            &Align2="right"}

    END.

    {func\relat\total.i &Coluna1='"Total"'
                        &Align1="left"
                        &Coluna2=tt-fav.valor
                        &Align2="right"}

END.

{func\relat\end-capitulo.i}
{func\relat\capitulo.i '"C†lculo"' 400}
{func\relat\titulo.i &Coluna1='"Declaraá∆o Completa"'
                     &Tamanho1=250
                     &Coluna2='"Valor"'
                     &Tamanho2=150}
{func\relat\linha.i &Coluna1='"Total de Rendimentos"'
                    &Align1="left"
                    &Coluna2=deRend
                    &Align2="right"}
ASSIGN deBase = deRend.                    
IF dep <> 0 THEN DO:
    {func\relat\linha.i &Coluna1='"Deduá∆o com Dependentes"'
                        &Align1="left"
                        &Coluna2="(dep * tabela-ir.val-dependente * (-1))"
                        &Align2="right"}
    ASSIGN deBase = deBase - (dep * tabela-ir.val-dependente).
END.
IF deEduc <> 0 THEN DO:
    IF (-1) * deEduc > tabela-ir.max-educacao THEN
        ASSIGN deEduc = tabela-ir.max-educacao * (-1).
    {func\relat\linha.i &Coluna1='"Deduá∆o com Educaá∆o"'
                        &Align1="left"
                        &Coluna2=deEduc
                        &Align2="right"}
    ASSIGN deBase = deBase + deEduc.
END.
IF deDed <> 0 THEN DO:
    {func\relat\linha.i &Coluna1='"Outras Deduá‰es"'
                        &Align1="left"
                        &Coluna2=deDed
                        &Align2="right"}
    ASSIGN deBase = deBase + deDed.
END.
{func\relat\linha.i &Coluna1='"Base de C†lculo"'
                    &Align1="left"
                    &Coluna2=deBase
                    &Align2="right"}
FIND FIRST tabela-ir-faixa OF tabela-ir NO-LOCK
    WHERE tabela-ir-faixa.val-ini <= (deBase / 12)
    AND   tabela-ir-faixa.val-end >= (deBase / 12).
{func\relat\linha.i &Coluna1='"% de IR"'
                    &Align1="left"
                    &Coluna2=tabela-ir-faixa.pc-ir
                    &Align2="right"}
{func\relat\linha.i &Coluna1='"Imposto Devido"'
                    &Align1="left"
                    &Coluna2="((deBase * (tabela-ir-faixa.pc-ir / 100)) - (tabela-ir-faixa.val-abate * 12))"
                    &Align2="right"}
ASSIGN deImp = deImp * (-1).                    
{func\relat\linha.i &Coluna1='"Imposto Pago"'
                    &Align1="left"
                    &Coluna2=deImp
                    &Align2="right"}
ASSIGN deRest = (-1) * (((-1) * deImp) + ((deBase * (tabela-ir-faixa.pc-ir / 100)) - (tabela-ir-faixa.val-abate * 12))).
IF deRest > deImp THEN DO:
    ASSIGN deRest = deImp.
END.
{func\relat\linha.i &Coluna1='"Valor a Restituir"'
                    &Align1="left"
                    &Coluna2=deRest
                    &Align2="right"}

{func\relat\total.i &Coluna1=''
                    &Align1="left"}

{func\relat\titulo.i &Coluna1='"Declaraá∆o Simplificada"'
                     &Tamanho1=250
                     &Coluna2='"Valor"'
                     &Tamanho2=150}
{func\relat\linha.i &Coluna1='"Total de Rendimentos"'
                    &Align1="left"
                    &Coluna2=deRend
                    &Align2="right"}
ASSIGN deBase = deRend
       deDed = deRend * 0.2.
IF deDed <> 0 THEN DO:
    IF deDed > tabela-ir.max-simp THEN
        ASSIGN deDed = tabela-ir.max-simp.
    {func\relat\linha.i &Coluna1='"Deduá∆o"'
                        &Align1="left"
                        &Coluna2="(deDed * (-1))"
                        &Align2="right"}
    ASSIGN deBase = deBase - deDed.
END.
{func\relat\linha.i &Coluna1='"Base de C†lculo"'
                    &Align1="left"
                    &Coluna2=deBase
                    &Align2="right"}
FIND FIRST tabela-ir-faixa OF tabela-ir NO-LOCK
    WHERE tabela-ir-faixa.val-ini <= (deBase / 12)
    AND   tabela-ir-faixa.val-end >= (deBase / 12).
{func\relat\linha.i &Coluna1='"% de IR"'
                    &Align1="left"
                    &Coluna2=tabela-ir-faixa.pc-ir
                    &Align2="right"}
{func\relat\linha.i &Coluna1='"Imposto Devido"'
                    &Align1="left"
                    &Coluna2="((deBase * (tabela-ir-faixa.pc-ir / 100)) - (tabela-ir-faixa.val-abate * 12))"
                    &Align2="right"}
{func\relat\linha.i &Coluna1='"Imposto Pago"'
                    &Align1="left"
                    &Coluna2=deImp
                    &Align2="right"}
ASSIGN deRest = (-1) * (((-1) * deImp) + ((deBase * (tabela-ir-faixa.pc-ir / 100)) - (tabela-ir-faixa.val-abate * 12))).
IF deRest > deImp THEN DO:
    ASSIGN deRest = deImp.
END.
{func\relat\linha.i &Coluna1='"Valor a Restituir"'
                    &Align1="left"
                    &Coluna2=deRest
                    &Align2="right"}
                    
{func\relat\end-capitulo.i}

{func\relat\end.i}

RETURN "OK":U.

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

{func/cb-lista.i cd-moeda moeda}
ASSIGN resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = "Todos".
FOR EACH usuario:
    ASSIGN resp:LIST-ITEMS IN FRAME {&FRAME-NAME} = resp:LIST-ITEMS IN FRAME {&FRAME-NAME} + "," + usuario.nome.
END.

ASSIGN ano = YEAR(TODAY).

{func\relat\initialize.i}

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

    RETURN "OK".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

