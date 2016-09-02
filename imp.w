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

DEFINE NEW GLOBAL SHARED VARIABLE cDiretorio AS CHARACTER  NO-UNDO INITIAL "C:\TEMP".

DEFINE STREAM sTemp.

DEFINE NEW GLOBAL SHARED VARIABLE iConta AS INTEGER    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE iCategoria AS INTEGER    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE iSub-Cat AS INTEGER    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE iFavorecido AS INTEGER    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.

{seg.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btArq RECT-5 arquivo EDITOR-1 btImp btExit 
&Scoped-Define DISPLAYED-OBJECTS arquivo EDITOR-1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btArq 
     IMAGE-UP FILE "image/im-add.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-add.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Arq" 
     SIZE 6 BY 1.79 TOOLTIP "Procurar arquivo".

DEFINE BUTTON btExit 
     IMAGE-UP FILE "image/im-exi.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-exi.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Button 1" 
     SIZE 6.14 BY 1.79 TOOLTIP "Sair".

DEFINE BUTTON btImp 
     IMAGE-UP FILE "image/im-chck1.bmp":U
     IMAGE-INSENSITIVE FILE "image/ii-chck1.bmp":U NO-FOCUS FLAT-BUTTON
     LABEL "Imp" 
     SIZE 6 BY 1.79 TOOLTIP "Importar".

DEFINE VARIABLE EDITOR-1 AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 78 BY 12.75 NO-UNDO.

DEFINE VARIABLE arquivo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Arquivo" 
     VIEW-AS FILL-IN 
     SIZE 35 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 2.25.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btArq AT ROW 1.5 COL 47
     arquivo AT ROW 2 COL 9 COLON-ALIGNED
     EDITOR-1 AT ROW 3.75 COL 2 NO-LABEL
     btImp AT ROW 1.5 COL 53.14
     btExit AT ROW 1.5 COL 73
     RECT-5 AT ROW 1.25 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 15.75
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
         TITLE              = "Importa‡Æo de Arquivos"
         HEIGHT             = 15.75
         WIDTH              = 80
         MAX-HEIGHT         = 20.04
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 20.04
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
ASSIGN 
       EDITOR-1:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Importa‡Æo de Arquivos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Importa‡Æo de Arquivos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME arquivo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL arquivo C-Win
ON ENTRY OF arquivo IN FRAME DEFAULT-FRAME /* Arquivo */
DO:
    {func\set_entry.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL arquivo C-Win
ON LEAVE OF arquivo IN FRAME DEFAULT-FRAME /* Arquivo */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btArq
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btArq C-Win
ON CHOOSE OF btArq IN FRAME DEFAULT-FRAME /* Arq */
DO:
  DEFINE VARIABLE OKpressed AS LOGICAL    NO-UNDO.
  DEFINE VARIABLE procname  AS CHARACTER  NO-UNDO.
 
  RUN som.p(INPUT "music\click.wav").
  SYSTEM-DIALOG GET-FILE procname
        TITLE      "Arquivos para Importa‡Æo"
        FILTERS    "Arquivos QIF"   "*.qif",
                   "Todos os Arquivos"      "*.*"
        INITIAL-DIR cDiretorio
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed. 

  IF OKpressed  THEN  DO:
      ASSIGN cDiretorio = SUBSTRING(procname,1,INDEX(procname,ENTRY(NUM-ENTRIES(procname,"\"),procname,"\"))).
      ASSIGN arquivo:SCREEN-VALUE IN FRAME default-frame = procname.
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


&Scoped-define SELF-NAME btImp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btImp C-Win
ON CHOOSE OF btImp IN FRAME DEFAULT-FRAME /* Imp */
DO:

    DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE dtTemp AS DATE       NO-UNDO.
    DEFINE VARIABLE deValor AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE cConta AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE iSit AS INTEGER    NO-UNDO.
    DEFINE VARIABLE cNum AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cFav AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cCat AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cSub AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cTransf AS CHARACTER  NO-UNDO.

    DEFINE VARIABLE cAux1 AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cAux2 AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cAux3 AS CHARACTER  NO-UNDO.

    DEFINE VARIABLE deSaldot AS DECIMAL    NO-UNDO.
    DEFINE VARIABLE dtSaldot AS DATE       NO-UNDO.

    DEFINE VARIABLE iAux AS INTEGER    NO-UNDO.

    DEFINE VARIABLE hTemp AS HANDLE     NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO INITIAL 0.

    RUN som.p(INPUT "music\click.wav").
    ASSIGN editor-1:SCREEN-VALUE IN FRAME default-frame = "".

    INPUT STREAM sTemp FROM VALUE(arquivo:SCREEN-VALUE IN FRAME default-frame) CONVERT TARGET "ibm850".

    IMPORT STREAM sTemp UNFORMATTED cTemp.

    block1:
    DO TRANSACTION:
        REPEAT:
    
            IF cTemp MATCHES("*!Type:*") THEN DO:
                REPEAT WHILE NOT cTemp MATCHES("*^*"):
                    IMPORT STREAM sTemp UNFORMATTED cTemp.
                    CASE SUBSTRING(cTemp,1,1):
                        WHEN 'D' THEN DO:
                            ASSIGN cAux1 = SUBSTRING(ENTRY(1,cTemp,"/"),2,LENGTH(ENTRY(1,cTemp,"/")))
                                   cAux2 = ENTRY(1,ENTRY(2,cTemp,"/"),"'")
                                   cAux3 = ENTRY(2,ENTRY(2,cTemp,"/"),"'")
                                   dtTemp = DATE(INTEGER(cAux2),INTEGER(cAux1),INTEGER(cAux3) + 2000).
                        END.
                        WHEN 'T' THEN DO:
                            ASSIGN deValor = DECIMAL(REPLACE(REPLACE(SUBSTRING(TRIM(cTemp),2,LENGTH(TRIM(cTemp))),".",""),",",".")).
                        END.
                        WHEN 'L' THEN DO:
                            ASSIGN cConta = ENTRY(1,ENTRY(2,cTemp,"["),"]").
                            ASSIGN editor-1:SCREEN-VALUE IN FRAME default-frame = "Importando conta " + cConta + " ..." + CHR(13) + CHR(13) + "Data: " + STRING(dtTemp,"99/99/9999") + CHR(13) + "Saldo de abertura: " + STRING(deValor,"->>>,>>>,>>9.99") + CHR(13) + CHR(13).
                            RUN contas.w PERSISTENT SET hTemp.
                            RUN initialize IN hTemp.
                            RUN setarDados IN hTemp (INPUT cConta, INPUT deValor, INPUT dtTemp).
                            WAIT-FOR "CLOSE" OF hTemp.
                            IF iConta = 0 THEN DO:
                                MESSAGE "        A opera‡Æo foi cancelada!" SKIP 
                                        "Vocˆ deve criar a conta a ser importada..."
                                    VIEW-AS ALERT-BOX ERROR BUTTONS OK.
                                UNDO block1, LEAVE block1.
                            END.
                            ELSE DO:
                                FIND FIRST conta WHERE cd-conta = iConta NO-LOCK.
                                ASSIGN iAux = conta.id-tipo.
                            END.
                        END.
                    END CASE.
                END.
            END.
            FIND LAST mov-conta WHERE mov-conta.cd-conta = iConta NO-LOCK NO-ERROR.
            IF AVAIL mov-conta THEN
                ASSIGN iCont = mov-conta.cd-sequencia + 1.
            IF cTemp MATCHES("*^*") THEN DO:
                ASSIGN iSit = 1
                       dtTemp = ?
                       deValor = 0
                       cNum = ""
                       cFav = ""
                       cCat = ""
                       cSub = ""
                       cTransf = ""
                       iSub-Cat = 0
                       iCategoria = 0.
                IMPORT STREAM sTemp UNFORMATTED cTemp.
                REPEAT WHILE NOT cTemp MATCHES("*^*"):
                    CASE SUBSTRING(cTemp,1,1):
                        WHEN 'D' THEN DO:
                            ASSIGN cAux1 = SUBSTRING(ENTRY(1,cTemp,"/"),2,LENGTH(ENTRY(1,cTemp,"/")))
                                   cAux2 = ENTRY(1,ENTRY(2,cTemp,"/"),"'")
                                   cAux3 = ENTRY(2,ENTRY(2,cTemp,"/"),"'")
                                   dtTemp = DATE(INTEGER(cAux2),INTEGER(cAux1),INTEGER(cAux3) + 2000).
                        END.
                        WHEN 'T' THEN DO:
                            ASSIGN deValor = DECIMAL(REPLACE(REPLACE(SUBSTRING(TRIM(cTemp),2,LENGTH(TRIM(cTemp))),",",""),".",",")).
                        END.
                        WHEN 'C' THEN DO:
                            IF SUBSTRING(cTemp,2,1) = "*" THEN
                                ASSIGN iSit = 2.
                            IF SUBSTRING(cTemp,2,1) = "X" THEN
                                ASSIGN iSit = 3.
                        END.
                        WHEN 'N' THEN DO:
                            ASSIGN cNum = SUBSTRING(TRIM(cTemp),2,LENGTH(TRIM(cTemp))).
                        END.
                        WHEN 'P' THEN DO:
                            ASSIGN cFav = SUBSTRING(TRIM(cTemp),2,LENGTH(TRIM(cTemp))).
                        END.
                        WHEN 'L' THEN DO:
                            IF SUBSTRING(cTemp,2,1) <> "[" THEN DO:
                                ASSIGN cCat = SUBSTRING(ENTRY(1,cTemp,":"),2,LENGTH(ENTRY(1,cTemp,":")))
                                       cSub = ENTRY(2,cTemp,":").
                            END.
                            ELSE DO:
                                ASSIGN cTransf = ENTRY(1,ENTRY(2,cTemp,"["),"]").
                            END.
                        END.
                    END CASE.
                    IMPORT STREAM sTemp UNFORMATTED cTemp.               
                END.
                /* Testes e valida‡äes */
                IF cTransf = "" THEN DO:
                    FIND FIRST categoria WHERE categoria.ds-categoria = cCat NO-LOCK NO-ERROR.
                    IF NOT AVAIL categoria THEN DO:
                        RUN cat.w PERSISTENT SET hTemp.
                        RUN initialize IN hTemp.
                        RUN setarDados IN hTemp (INPUT cCat).
                        WAIT-FOR "CLOSE" OF hTemp.
                        IF iCategoria = 0 THEN DO:
                            MESSAGE "          A opera‡Æo foi cancelada!" SKIP 
                                    "Vocˆ deve criar a categoria a ser importada..."
                                VIEW-AS ALERT-BOX ERROR BUTTONS OK.
                            UNDO block1, LEAVE block1.
                        END.
                    END.
                    ELSE DO:
                        ASSIGN iCategoria = categoria.cod-categoria.
                    END.
                    FIND FIRST sub-cat WHERE sub-cat.cod-categoria = iCategoria
                                       AND   ds-sub = cSub NO-LOCK NO-ERROR.
                    IF NOT AVAIL sub-cat THEN DO:
                        RUN subcat.w PERSISTENT SET hTemp (INPUT iCategoria).
                        RUN initialize IN hTemp.
                        RUN setarDados IN hTemp (INPUT cSub).
                        WAIT-FOR "CLOSE" OF hTemp.
                        IF iSub-Cat = 0 THEN DO:
                            MESSAGE "            A opera‡Æo foi cancelada!" SKIP 
                                    "Vocˆ deve criar a sub-categoria a ser importada..."
                                VIEW-AS ALERT-BOX ERROR BUTTONS OK.
                            UNDO block1, LEAVE block1.
                        END.
                    END.
                    ELSE DO:
                        ASSIGN iSub-Cat = sub-cat.cd-sub.
                    END.
                END.
                FIND FIRST favorecido WHERE ds-favorecido = cFav NO-LOCK NO-ERROR.
                IF NOT AVAIL favorecido THEN DO:
                    RUN fav.w PERSISTENT SET hTemp.
                    RUN initialize IN hTemp.
                    RUN setarDados IN hTemp (INPUT cFav).
                    WAIT-FOR "CLOSE" OF hTemp.
                    IF iFavorecido = 0 THEN DO:
                        MESSAGE "          A opera‡Æo foi cancelada!" SKIP 
                                "Vocˆ deve criar o favorecido a ser importado..."
                            VIEW-AS ALERT-BOX ERROR BUTTONS OK.
                        UNDO block1, LEAVE block1.
                    END.
                END.
                ELSE DO:
                    ASSIGN iFavorecido = favorecido.cd-favorecido.
                END.
                /* Criando Movimento */
                CREATE mov-conta.
                ASSIGN mov-conta.cd-conta       = iConta
                       mov-conta.nr-mov         = cNum
                       mov-conta.dt-mov         = dtTemp
                       mov-conta.cd-favorecido  = iFavorecido
                       mov-conta.id-situacao    = iSit
                       mov-conta.de-valor       = deValor
                       mov-conta.dt-compensacao = IF iSit <> 1 THEN dtTemp ELSE ?
                       mov-conta.cod-categoria  = iCategoria
                       mov-conta.cd-sub         = iSub-Cat
                       mov-conta.cd-sequencia   = iCont + 1.
                CASE iAux:
                    WHEN 1 THEN DO:
                        IF deValor < 0 THEN DO:
                            IF cFav = "Dinheiro" THEN DO:
                                ASSIGN mov-conta.id-tipo = 6.
                            END.
                            ELSE DO:
                                IF cNum <> "" THEN DO:
                                    ASSIGN mov-conta.id-tipo = 4.
                                END.
                                ELSE DO:
                                    ASSIGN mov-conta.id-tipo = 5.
                                END.
                            END.
                        END.
                        ELSE DO:
                            ASSIGN mov-conta.id-tipo = 1.
                        END.
                    END.
                    WHEN 2 THEN DO:
                        IF deValor < 0 THEN DO:
                            ASSIGN mov-conta.id-tipo = 6.
                        END.
                        ELSE DO:
                            ASSIGN mov-conta.id-tipo = 1.
                        END.
                    END.
                    WHEN 3 THEN DO:
                        IF deValor < 0 THEN DO:
                            ASSIGN mov-conta.id-tipo = 7.
                        END.
                        ELSE DO:
                            ASSIGN mov-conta.id-tipo = 2.
                        END.
                    END.
                END CASE.
                IF cTransf <> "" THEN DO:
                    FIND FIRST conta WHERE ds-conta = cTransf NO-LOCK NO-ERROR.
                    IF AVAIL conta THEN DO:
                        ASSIGN mov-conta.conta-transf = conta.cd-conta
                               mov-conta.id-tipo = 3.
                    END.
                END.
                ASSIGN iCont = iCont + 1.
            END.
        END.
    END.

    FIND FIRST conta WHERE conta.cd-conta = iConta EXCLUSIVE-LOCK.
    ASSIGN deSaldot = conta.vl-saldo-ini
           dtSaldot = ?.
    FOR EACH mov-conta NO-LOCK
        WHERE mov-conta.cd-conta = iConta 
        AND   mov-conta.id-situacao = 3
        USE-INDEX data:

        ASSIGN deSaldot = deSaldot + mov-conta.de-valor
               dtSaldot = mov-conta.dt-mov.

    END.
    ASSIGN conta.vl-saldo = deSaldot
           conta.dt-saldo = dtSaldot.

    ASSIGN editor-1:SCREEN-VALUE IN FRAME default-frame = editor-1:SCREEN-VALUE IN FRAME default-frame + 
                                                          "Foram importados " + STRING(iCont) + " movimentos com sucesso!".

    INPUT STREAM sTemp CLOSE.

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
  {version.i imp}
  RUN enable_UI.
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
  DISPLAY arquivo EDITOR-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btArq RECT-5 arquivo EDITOR-1 btImp btExit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

