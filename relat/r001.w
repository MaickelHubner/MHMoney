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
/* PrÇ-processadores */

&GLOBAL-DEFINE FrameFields  mes ano moeda

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
&Scoped-Define ENABLED-OBJECTS btCancel RECT-10 mes ano moeda btOK 
&Scoped-Define DISPLAYED-OBJECTS mes ano moeda 

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

DEFINE VARIABLE mes AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Màs" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Janeiro",1,
                     "Fevereiro",2,
                     "Maráo",3,
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
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE moeda AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Moeda" 
     VIEW-AS COMBO-BOX INNER-LINES 9999
     LIST-ITEM-PAIRS "Item 1",0
     DROP-DOWN-LIST
     SIZE 21.29 BY 1 NO-UNDO.

DEFINE VARIABLE ano AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btCancel AT ROW 3.25 COL 73
     mes AT ROW 2 COL 26 COLON-ALIGNED
     ano AT ROW 2 COL 42.29 COLON-ALIGNED NO-LABEL
     moeda AT ROW 3 COL 26 COLON-ALIGNED
     btOK AT ROW 1.5 COL 73
     RECT-10 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 5.25
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
         HEIGHT             = 5.25
         WIDTH              = 80
         MAX-HEIGHT         = 11.04
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 11.04
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
       ROW             = 5.5
       COLUMN          = 2
       HEIGHT          = .75
       WIDTH           = 78
       HIDDEN          = no
       SENSITIVE       = yes.
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
ON ENTRY OF ano IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ano C-Win
ON LEAVE OF ano IN FRAME DEFAULT-FRAME
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


&Scoped-define SELF-NAME mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON ENTRY OF mes IN FRAME DEFAULT-FRAME /* Màs */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL mes C-Win
ON LEAVE OF mes IN FRAME DEFAULT-FRAME /* Màs */
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
  {version.i r001}
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

OCXFile = SEARCH( "r001.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "r001.wrx":U SKIP(1)
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
  DISPLAY mes ano moeda 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btCancel RECT-10 mes ano moeda btOK 
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

DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO EXTENT 5.
DEFINE VARIABLE deTotCat AS DECIMAL    NO-UNDO EXTENT 5.
DEFINE VARIABLE deTotal AS DECIMAL    NO-UNDO EXTENT 5.
DEFINE VARIABLE lCat AS LOGICAL    NO-UNDO.
DEFINE VARIABLE cAux AS CHARACTER FORMAT "X(40)" NO-UNDO.
DEFINE VARIABLE iMax AS INTEGER    NO-UNDO.
DEFINE VARIABLE deSaldo AS DECIMAL     NO-UNDO.
DEFINE VARIABLE iSemana AS INTEGER     NO-UNDO.
DEFINE VARIABLE dtAux AS DATE    NO-UNDO.
DEFINE VARIABLE dtSemana AS DATE    NO-UNDO.  
DEFINE VARIABLE deDesc AS DECIMAL     NO-UNDO.

/* Acerto de datas */

/* Output padr∆o */
select count(*) into iMax from sub-cat.
{func\relat\ini.i iMax}

/* L¢gica do relat¢rio */

PUT "  <tr>" SKIP
    "    <td width=~"800~" colSpan=~"2~"><strong><font face=~"Arial~" color=~"#319B64~"><br>" SKIP
    "    " fnMes(mes) "/" STRING(ano,"9999") "<br><br></font></strong>" SKIP
    "    </td>" SKIP
    "  </tr>".

{func\relat\capitulo.i '"Rendimentos"' 800}

ASSIGN deTotal = 0.

FOR EACH categoria NO-LOCK
    WHERE id-tipo = 1
    BY ds-categoria:

    ASSIGN lCat = NO
           deTotCat = 0.

    FOR EACH sub-cat OF categoria NO-LOCK
        BY ds-sub:

        {func\relat\control.i}
        ASSIGN deValor = 0.

        FOR EACH mov-conta 
            WHERE mov-conta.cod-categoria = categoria.cod-categoria
            AND   mov-conta.cd-sub = sub-cat.cd-sub
            AND   mov-conta.dt-mov >= DATE(mes,1,ano)
            AND   mov-conta.dt-mov <= fnUltimoDia(mes,ano):

            /*IF (DAY(mov-conta.dt-mov) MOD 7) <> 0 THEN
                ASSIGN deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")) + 1)] = 
                       deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")) + 1)] + 
                       IF mov-conta.cd-moeda = moeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
            ELSE
                ASSIGN deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")))] = 
                       deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")))] + 
                       IF mov-conta.cd-moeda = moeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).*/
            ASSIGN deValor[fnSemana(mov-conta.dt-mov)] = 
                   deValor[fnSemana(mov-conta.dt-mov)] + 
                   IF mov-conta.cd-moeda = moeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

        END.
        IF (deValor[1] + deValor[2] + deValor[3] + deValor[4] + deValor[5]) <> 0 THEN DO:

            ASSIGN deTotCat[1] = deTotCat[1] + deValor[1]
                   deTotCat[2] = deTotCat[2] + deValor[2]
                   deTotCat[3] = deTotCat[3] + deValor[3]
                   deTotCat[4] = deTotCat[4] + deValor[4]
                   deTotCat[5] = deTotCat[5] + deValor[5].

            IF NOT lCat THEN DO:
                {func\relat\titulo.i &Coluna1=categoria.ds-categoria
                                     &Tamanho1=320
                                     &Coluna2='"1¶ Sem"'
                                     &Tamanho2=96
                                     &Coluna3='"2¶ Sem"'
                                     &Tamanho3=96
                                     &Coluna4='"3¶ Sem"'
                                     &Tamanho4=96
                                     &Coluna5='"4¶ Sem"'
                                     &Tamanho5=96
                                     &Coluna6='"5¶ Sem"'
                                     &Tamanho6=96
                                     &Small=YES}
                ASSIGN lCat = YES.
            END.

            {func\relat\linha.i &Coluna1=sub-cat.ds-sub
                                &Align1="left"
                                &Coluna2=deValor[1]
                                &Align2="right"
                                &Coluna3=deValor[2]
                                &Align3="right"
                                &Coluna4=deValor[3]
                                &Align4="right"
                                &Coluna5=deValor[4]
                                &Align5="right"
                                &Coluna6=deValor[5]
                                &Align6="right"
                                &Small=YES}
        END.
    END.

    IF (deTotCat[1] + deTotCat[2] + deTotCat[3] + deTotCat[4] + deTotCat[5]) <> 0 THEN DO:
        ASSIGN deTotal[1] = deTotal[1] + deTotCat[1]
               deTotal[2] = deTotal[2] + deTotCat[2]
               deTotal[3] = deTotal[3] + deTotCat[3]
               deTotal[4] = deTotal[4] + deTotCat[4]
               deTotal[5] = deTotal[5] + deTotCat[5].
        ASSIGN cAux = "Total de " + categoria.ds-categoria.
        {func\relat\total.i &Coluna1=cAux
                            &Align1="left"
                            &Coluna2=deTotCat[1]
                            &Align2="right"
                            &Coluna3=deTotCat[2]
                            &Align3="right"
                            &Coluna4=deTotCat[3]
                            &Align4="right"
                            &Coluna5=deTotCat[4]
                            &Align5="right"
                            &Coluna6=deTotCat[5]
                            &Align6="right"
                            &Small=YES}
    END.

END.

IF (deTotal[1] + deTotal[2] + deTotal[3] + deTotal[4] + deTotal[5]) <> 0 THEN DO:
    {func\relat\total.i &Coluna1='"Total de Rendimentos"'
                        &Align1="left"
                        &Coluna2=deTotal[1]
                        &Align2="right"
                        &Coluna3=deTotal[2]
                        &Align3="right"
                        &Coluna4=deTotal[3]
                        &Align4="right"
                        &Coluna5=deTotal[4]
                        &Align5="right"
                        &Coluna6=deTotal[5]
                        &Align6="right"
                        &Cor='"black"'
                        &Small=YES}
END.

{func\relat\end-capitulo.i}

IF CAN-FIND(FIRST conta
            WHERE conta.cd-moeda <> 0) THEN DO:

    {func\relat\capitulo.i '"Investimentos"' 800}

    ASSIGN deTotal = 0
           lCat = NO
           deTotCat = 0.

    FOR EACH conta NO-LOCK
        WHERE conta.cd-moeda <> 0
        BY conta.ds-conta:

        ASSIGN deSaldo = conta.vl-saldo-ini
               iSemana = 1
               dtSemana = DATE(mes,1,ano) - 1.
        FOR EACH mov-conta OF conta NO-LOCK
            WHERE mov-conta.dt-mov <= dtSemana
            AND   mov-conta.id-tipo <> 0:
            ASSIGN deSaldo = deSaldo + mov-conta.de-valor.
        END.

        ASSIGN deValor = 0.

        REPEAT dtAux = DATE(mes,1,ano) TO (fnUltimoDia(mes,ano) + 1):
            IF iSemana = fnSemana(dtAux) THEN 
                NEXT.
            ELSE DO:
                ASSIGN deValor[iSemana] = (-1) * fnCotacao(deSaldo,conta.cd-moeda,moeda,dtSemana)
                       deDesc = 0.
                FOR EACH mov-conta OF conta NO-LOCK
                    WHERE mov-conta.dt-mov > dtSemana
                    AND   mov-conta.dt-mov < dtAux
                    AND   mov-conta.id-tipo <> 0:
                    ASSIGN deSaldo = deSaldo + mov-conta.de-valor
                           deDesc = deDesc + fnCotacao(mov-conta.de-valor,conta.cd-moeda,moeda,mov-conta.dt-mov).
                END.
                ASSIGN dtSemana = dtAux - 1
                       deValor[iSemana] = deValor[iSemana] + fnCotacao(deSaldo,conta.cd-moeda,moeda,dtSemana) - deDesc
                       iSemana = iSemana + 1.
            END.
        END.

        IF (deValor[1] + deValor[2] + deValor[3] + deValor[4] + deValor[5]) <> 0 THEN DO:

            ASSIGN deTotCat[1] = deTotCat[1] + deValor[1]
                   deTotCat[2] = deTotCat[2] + deValor[2]
                   deTotCat[3] = deTotCat[3] + deValor[3]
                   deTotCat[4] = deTotCat[4] + deValor[4]
                   deTotCat[5] = deTotCat[5] + deValor[5].

            IF NOT lCat THEN DO:
                {func\relat\titulo.i &Coluna1='"Contas"'
                                     &Tamanho1=320
                                     &Coluna2='"1¶ Sem"'
                                     &Tamanho2=96
                                     &Coluna3='"2¶ Sem"'
                                     &Tamanho3=96
                                     &Coluna4='"3¶ Sem"'
                                     &Tamanho4=96
                                     &Coluna5='"4¶ Sem"'
                                     &Tamanho5=96
                                     &Coluna6='"5¶ Sem"'
                                     &Tamanho6=96
                                     &Small=YES}
                ASSIGN lCat = YES.
            END.

            {func\relat\linha.i &Coluna1=conta.ds-conta
                                &Align1="left"
                                &Coluna2=deValor[1]
                                &Align2="right"
                                &Coluna3=deValor[2]
                                &Align3="right"
                                &Coluna4=deValor[3]
                                &Align4="right"
                                &Coluna5=deValor[4]
                                &Align5="right"
                                &Coluna6=deValor[5]
                                &Align6="right"
                                &Small=YES}
        END.

    END.

    IF (deTotCat[1] + deTotCat[2] + deTotCat[3] + deTotCat[4] + deTotCat[5]) <> 0 THEN DO:
        ASSIGN deTotal[1] = deTotal[1] + deTotCat[1]
               deTotal[2] = deTotal[2] + deTotCat[2]
               deTotal[3] = deTotal[3] + deTotCat[3]
               deTotal[4] = deTotal[4] + deTotCat[4]
               deTotal[5] = deTotal[5] + deTotCat[5].
        {func\relat\total.i &Coluna1='"Total das Contas"'
                            &Align1="left"
                            &Coluna2=deTotCat[1]
                            &Align2="right"
                            &Coluna3=deTotCat[2]
                            &Align3="right"
                            &Coluna4=deTotCat[3]
                            &Align4="right"
                            &Coluna5=deTotCat[4]
                            &Align5="right"
                            &Coluna6=deTotCat[5]
                            &Align6="right"
                            &Small=YES}
    END.

    IF (deTotal[1] + deTotal[2] + deTotal[3] + deTotal[4] + deTotal[5]) <> 0 THEN DO:
        {func\relat\total.i &Coluna1='"Total de Investimentos"'
                            &Align1="left"
                            &Coluna2=deTotal[1]
                            &Align2="right"
                            &Coluna3=deTotal[2]
                            &Align3="right"
                            &Coluna4=deTotal[3]
                            &Align4="right"
                            &Coluna5=deTotal[4]
                            &Align5="right"
                            &Coluna6=deTotal[5]
                            &Align6="right"
                            &Cor='"black"'
                            &Small=YES}
    END.

    {func\relat\end-capitulo.i}

END.

{func\relat\capitulo.i '"Despesas"' 800}

ASSIGN deTotal = 0.

FOR EACH categoria NO-LOCK
    WHERE categoria.id-tipo = 2
    BY ds-categoria:

    ASSIGN lCat = NO
           deTotCat = 0.

    FOR EACH sub-cat OF categoria NO-LOCK
        BY ds-sub:

        {func\relat\control.i}
        ASSIGN deValor = 0.

        FOR EACH mov-conta 
            WHERE mov-conta.cod-categoria = categoria.cod-categoria
            AND   mov-conta.cd-sub = sub-cat.cd-sub
            AND   mov-conta.dt-mov >= DATE(mes,1,ano)
            AND   mov-conta.dt-mov <= fnUltimoDia(mes,ano):

            /*IF (DAY(mov-conta.dt-mov) MOD 7) <> 0 THEN
                ASSIGN deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")) + 1)] = 
                       deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")) + 1)] + 
                       IF mov-conta.cd-moeda = moeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).
            ELSE
                ASSIGN deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")))] = 
                       deValor[(INT(ENTRY(1,STRING(DAY(mov-conta.dt-mov) / 7),",")))] + 
                       IF mov-conta.cd-moeda = moeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).*/
            ASSIGN deValor[fnSemana(mov-conta.dt-mov)] = 
                   deValor[fnSemana(mov-conta.dt-mov)] + 
                   IF mov-conta.cd-moeda = moeda THEN mov-conta.de-valor ELSE fnCotacao(mov-conta.de-valor,mov-conta.cd-moeda,moeda,mov-conta.dt-mov).

        END.
        IF (deValor[1] + deValor[2] + deValor[3] + deValor[4] + deValor[5]) <> 0 THEN DO:

            ASSIGN deTotCat[1] = deTotCat[1] + deValor[1]
                   deTotCat[2] = deTotCat[2] + deValor[2]
                   deTotCat[3] = deTotCat[3] + deValor[3]
                   deTotCat[4] = deTotCat[4] + deValor[4]
                   deTotCat[5] = deTotCat[5] + deValor[5].

            IF NOT lCat THEN DO:
                {func\relat\titulo.i &Coluna1=categoria.ds-categoria
                                     &Tamanho1=320
                                     &Coluna2='"1¶ Sem"'
                                     &Tamanho2=96
                                     &Coluna3='"2¶ Sem"'
                                     &Tamanho3=96
                                     &Coluna4='"3¶ Sem"'
                                     &Tamanho4=96
                                     &Coluna5='"4¶ Sem"'
                                     &Tamanho5=96
                                     &Coluna6='"5¶ Sem"'
                                     &Tamanho6=96
                                     &Small=YES}
                ASSIGN lCat = YES.
            END.

            {func\relat\linha.i &Coluna1=sub-cat.ds-sub
                                &Align1="left"
                                &Coluna2=deValor[1]
                                &Align2="right"
                                &Coluna3=deValor[2]
                                &Align3="right"
                                &Coluna4=deValor[3]
                                &Align4="right"
                                &Coluna5=deValor[4]
                                &Align5="right"
                                &Coluna6=deValor[5]
                                &Align6="right"
                                &Small=YES}
        END.
    END.

    IF (deTotCat[1] + deTotCat[2] + deTotCat[3] + deTotCat[4] + deTotCat[5]) <> 0 THEN DO:
        ASSIGN deTotal[1] = deTotal[1] + deTotCat[1]
               deTotal[2] = deTotal[2] + deTotCat[2]
               deTotal[3] = deTotal[3] + deTotCat[3]
               deTotal[4] = deTotal[4] + deTotCat[4]
               deTotal[5] = deTotal[5] + deTotCat[5].
        ASSIGN cAux = "Total de " + categoria.ds-categoria.
        {func\relat\total.i &Coluna1=cAux
                            &Align1="left"
                            &Coluna2=deTotCat[1]
                            &Align2="right"
                            &Coluna3=deTotCat[2]
                            &Align3="right"
                            &Coluna4=deTotCat[3]
                            &Align4="right"
                            &Coluna5=deTotCat[4]
                            &Align5="right"
                            &Coluna6=deTotCat[5]
                            &Align6="right"
                            &Small=YES}
    END.

END.

IF (deTotal[1] + deTotal[2] + deTotal[3] + deTotal[4] + deTotal[5]) <> 0 THEN DO:
    {func\relat\total.i &Coluna1='"Total de Despesas"'
                        &Align1="left"
                        &Coluna2=deTotal[1]
                        &Align2="right"
                        &Coluna3=deTotal[2]
                        &Align3="right"
                        &Coluna4=deTotal[3]
                        &Align4="right"
                        &Coluna5=deTotal[4]
                        &Align5="right"
                        &Coluna6=deTotal[5]
                        &Align6="right"
                        &Cor='"black"'
                        &Small=YES}
END.

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

ASSIGN mes = MONTH(TODAY)
       ano = YEAR(TODAY).

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

