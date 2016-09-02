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

DEFINE BUFFER bf-item FOR item.

/* Parameters Definitions ---                                           */

/* PrÇ-processadores */
&GLOBAL-DEFINE Table        item-compra
&GLOBAL-DEFINE Parent       compra
&GLOBAL-DEFINE ParentField  cd-compra
&GLOBAL-DEFINE KeyFields    item-compra.cd-item
&GLOBAL-DEFINE FrameFields  item-compra.quantidade item-compra.vl-unitario ~
                            item-compra.vl-total
&GLOBAL-DEFINE FrameDisp    compra.dt-compra

/* Local Variable Definitions ---                                       */


/* Buffers */

{func\definitions.i}

DEFINE BUFFER bf-compra FOR compra.

/*DEFINE BUFFER b-item-compra FOR item-compra.
DEFINE BUFFER b2-item-compra FOR item-compra.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS item-compra.cd-compra item-compra.cd-item ~
item-compra.quantidade item-compra.vl-unitario item-compra.vl-total 
&Scoped-define ENABLED-TABLES item-compra
&Scoped-define FIRST-ENABLED-TABLE item-compra
&Scoped-Define ENABLED-OBJECTS desc-item RECT-2 RECT-3 
&Scoped-Define DISPLAYED-FIELDS item-compra.cd-compra compra.dt-compra ~
item-compra.cd-item item-compra.quantidade item-compra.vl-unitario ~
item-compra.vl-total 
&Scoped-define DISPLAYED-TABLES item-compra compra
&Scoped-define FIRST-DISPLAYED-TABLE item-compra
&Scoped-define SECOND-DISPLAYED-TABLE compra
&Scoped-Define DISPLAYED-OBJECTS pc-valor ult-comp unid desc-fav desc-item 

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

DEFINE VARIABLE desc-fav AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .79 NO-UNDO.

DEFINE VARIABLE desc-item AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY .79 NO-UNDO.

DEFINE VARIABLE pc-valor AS DECIMAL FORMAT "->>,>>9.9999":U INITIAL 0 
     LABEL "% Aumento" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79
     FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ult-comp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Èltima Compra" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .79 NO-UNDO.

DEFINE VARIABLE unid AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .79 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78 BY 1.5.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 35 BY 5.75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     pc-valor AT ROW 8 COL 34 COLON-ALIGNED NO-TAB-STOP 
     ult-comp AT ROW 6 COL 34 COLON-ALIGNED NO-TAB-STOP 
     unid AT ROW 5 COL 45.29 COLON-ALIGNED NO-LABEL
     item-compra.cd-compra AT ROW 1.5 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .79
     btCancel AT ROW 8.5 COL 74.14
     compra.dt-compra AT ROW 1.5 COL 21.29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     desc-fav AT ROW 1.5 COL 32.57 COLON-ALIGNED NO-LABEL
     btOK AT ROW 8.5 COL 68
     item-compra.cd-item AT ROW 3.25 COL 16 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY .79
     desc-item AT ROW 3.25 COL 22.29 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     item-compra.quantidade AT ROW 5 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     item-compra.vl-unitario AT ROW 7 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .79
     item-compra.vl-total AT ROW 9 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.14 BY .79
     "%" VIEW-AS TEXT
          SIZE 3 BY .54 AT ROW 8.17 COL 48
     RECT-2 AT ROW 1.25 COL 2
     RECT-3 AT ROW 4.5 COL 21
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 9.54
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
         HEIGHT             = 9.54
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
/* SETTINGS FOR FILL-IN desc-fav IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       desc-item:READ-ONLY IN FRAME DEFAULT-FRAME        = TRUE.

/* SETTINGS FOR FILL-IN compra.dt-compra IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN pc-valor IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN ult-comp IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN unid IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
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
    RUN recalcula(3).
    {func\bt_cad_ok.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-compra.cd-item
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.cd-item C-Win
ON ENTRY OF item-compra.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.cd-item C-Win
ON LEAVE OF item-compra.cd-item IN FRAME DEFAULT-FRAME /* Item */
DO:
    ASSIGN ult-comp:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(DEC(0)).
    {func\leave.i &Tabela="item"
                  &Campo="cd-item"
                  &CampoProc="ds-item"
                  &Tela="desc-item"
                  &CampoProc2="unidade"
                  &Tela2="unid"}
    IF AVAIL bfl-item THEN DO:
        blk-ult-compra:
        FOR EACH bf-compra
            WHERE bf-compra.dt-compra < compra.dt-compra,
            FIRST bf-item-compra OF bf-compra 
                WHERE bf-item-compra.cd-item = INPUT FRAME {&FRAME-NAME} item-compra.cd-item
                BY bf-compra.dt-compra DESC:
            ASSIGN ult-comp:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bf-item-compra.vl-unitario).
            IF INPUT FRAME {&FRAME-NAME} item-compra.vl-unitario = 0 THEN DO:
                ASSIGN item-compra.vl-unitario:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bf-item-compra.vl-unitario).
                APPLY "LEAVE" TO item-compra.vl-unitario.
            END.
            LEAVE blk-ult-compra.
        END.
    END.
    ELSE DO:
        ASSIGN item-compra.vl-unitario:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(DEC(0)).
        APPLY "LEAVE" TO item-compra.vl-unitario.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.cd-item C-Win
ON MOUSE-SELECT-DBLCLICK OF item-compra.cd-item IN FRAME DEFAULT-FRAME /* Item */
OR F5 OF {&Table}.cd-item DO:
    {func\zoom.i &Tabela="item"
                 &Campo1="cd-item"
                 &Tela1="item-compra.cd-item"
                 &Campo2="ds-item"
                 &Tela2="desc-item"
                 &Campo3="unidade"
                 &Tela3="unid"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME pc-valor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pc-valor C-Win
ON ENTRY OF pc-valor IN FRAME DEFAULT-FRAME /* % Aumento */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL pc-valor C-Win
ON LEAVE OF pc-valor IN FRAME DEFAULT-FRAME /* % Aumento */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-compra.quantidade
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.quantidade C-Win
ON ENTRY OF item-compra.quantidade IN FRAME DEFAULT-FRAME /* Quantidade */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.quantidade C-Win
ON LEAVE OF item-compra.quantidade IN FRAME DEFAULT-FRAME /* Quantidade */
DO:

    {func\set_leave.i}  
    FIND FIRST bf-item NO-LOCK
        WHERE bf-item.cd-item = INPUT FRAME {&FRAME-NAME} item-compra.cd-item.
    IF AVAIL bf-item THEN DO:
        IF NOT bf-item.permite-dec THEN DO:
            ASSIGN item-compra.quantidade:SCREEN-VALUE IN FRAME {&FRAME-NAME} =
                   STRING(INT(ENTRY(1,item-compra.quantidade:SCREEN-VALUE IN FRAME {&FRAME-NAME}))).
        END.
    END.
    RUN recalcula(1).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ult-comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ult-comp C-Win
ON ENTRY OF ult-comp IN FRAME DEFAULT-FRAME /* Èltima Compra */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ult-comp C-Win
ON LEAVE OF ult-comp IN FRAME DEFAULT-FRAME /* Èltima Compra */
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME unid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL unid C-Win
ON ENTRY OF unid IN FRAME DEFAULT-FRAME
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL unid C-Win
ON LEAVE OF unid IN FRAME DEFAULT-FRAME
DO:
    {func\set_leave.i}    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-compra.vl-total
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.vl-total C-Win
ON ENTRY OF item-compra.vl-total IN FRAME DEFAULT-FRAME /* Total */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.vl-total C-Win
ON LEAVE OF item-compra.vl-total IN FRAME DEFAULT-FRAME /* Total */
DO:
  
    {func\set_leave.i}  
    RUN recalcula(3).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME item-compra.vl-unitario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.vl-unitario C-Win
ON ENTRY OF item-compra.vl-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
    {func\set_entry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL item-compra.vl-unitario C-Win
ON LEAVE OF item-compra.vl-unitario IN FRAME DEFAULT-FRAME /* Valor Unit†rio */
DO:
  
    {func\set_leave.i}  
    RUN recalcula(2).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
{func\pesq\lista_popup.i &FRAME = {&FRAME-NAME}}
{func\pesq\lista_objeto.i &FRAME = {&FRAME-NAME}
                          &OBJETO = desc-item
                          &FOREACH = "item BY item.ds-item"
                          &CAMPO = item.ds-item
                          &ObjPai = item-compra.cd-item}
                          
{func\calc.i item-compra.quantidade}
{func\calc.i item-compra.vl-unitario}
{func\calc.i item-compra.vl-total}


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
  {version.i item-compra_det}
  RUN enable_UI.
  RUN initialize.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcPerc C-Win 
PROCEDURE calcPerc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF INPUT FRAME {&FRAME-NAME} ult-comp <> 0 THEN
    ASSIGN pc-valor = (((INPUT FRAME {&FRAME-NAME} item-compra.vl-unitario / INPUT FRAME {&FRAME-NAME} ult-comp) - 1) * 100).
ELSE 
    ASSIGN pc-valor = 0.
DISP pc-valor WITH FRAME {&FRAME-NAME}.

IF pc-valor <= 0 THEN DO:
    ASSIGN pc-valor:BGCOLOR IN FRAME {&FRAME-NAME} = 2.
END.
ELSE DO:
    ASSIGN pc-valor:BGCOLOR IN FRAME {&FRAME-NAME} = 12.
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

FIND FIRST favorecido OF compra NO-LOCK NO-ERROR.
ASSIGN desc-fav = favorecido.ds-favorecido.

{func\detalhe\display.i}

DISPLAY desc-fav WITH FRAME {&FRAME-NAME}.

APPLY "LEAVE" TO item-compra.cd-item.

RUN calcPerc.

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
  DISPLAY pc-valor ult-comp unid desc-fav desc-item 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE compra THEN 
    DISPLAY compra.dt-compra 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE item-compra THEN 
    DISPLAY item-compra.cd-compra item-compra.cd-item item-compra.quantidade 
          item-compra.vl-unitario item-compra.vl-total 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE item-compra.cd-compra item-compra.cd-item desc-item 
         item-compra.quantidade item-compra.vl-unitario item-compra.vl-total 
         RECT-2 RECT-3 
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

{func\cursor.i item-compra.cd-item}

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

IF cObject = "desc-item" THEN DO:
    FIND FIRST item NO-LOCK
        WHERE item.ds-item = INPUT FRAME {&FRAME-NAME} desc-item NO-ERROR.
    IF AVAIL item THEN DO:
        ASSIGN item-compra.cd-item:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(item.cd-item).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalcula C-Win 
PROCEDURE recalcula :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER iQual AS INTEGER    NO-UNDO.

CASE iQual:

    WHEN 1 THEN DO:
        ASSIGN item-compra.vl-total:SCREEN-VALUE IN FRAME {&FRAME-NAME} = 
            STRING(DEC(item-compra.quantidade:SCREEN-VALUE IN FRAME {&FRAME-NAME}) *
            DEC(item-compra.vl-unitario:SCREEN-VALUE IN FRAME {&FRAME-NAME})).
    END.
    WHEN 2 THEN DO:
        ASSIGN item-compra.vl-total:SCREEN-VALUE IN FRAME {&FRAME-NAME} = 
            STRING(DEC(item-compra.quantidade:SCREEN-VALUE IN FRAME {&FRAME-NAME}) *
            DEC(item-compra.vl-unitario:SCREEN-VALUE IN FRAME {&FRAME-NAME})).
    END.
    WHEN 3 THEN DO:
        IF DEC(item-compra.quantidade:SCREEN-VALUE IN FRAME {&FRAME-NAME}) <> 0 THEN DO:
            ASSIGN item-compra.vl-unitario:SCREEN-VALUE IN FRAME {&FRAME-NAME} = 
                STRING(DEC(item-compra.vl-total:SCREEN-VALUE IN FRAME {&FRAME-NAME}) /
                DEC(item-compra.quantidade:SCREEN-VALUE IN FRAME {&FRAME-NAME})).
        END.
        ELSE DO:
            ASSIGN item-compra.vl-unitario:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(DEC(0)).
        END.
    END.

END CASE.

RUN calcPerc.

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
    IF CAN-FIND(FIRST bf-item-compra
                WHERE bf-item-compra.cd-compra = INPUT FRAME {&FRAME-NAME} item-compra.cd-compra
                AND   bf-item-compra.cd-item   = INPUT FRAME {&FRAME-NAME} item-compra.cd-item
                AND   ROWID(bf-item-compra) <> ROWID(item-compra)) THEN DO:
        FIND FIRST bf-item-compra WHERE ROWID(bf-item-compra) = ROWID(item-compra) NO-LOCK NO-ERROR.
        FIND FIRST item-compra EXCLUSIVE-LOCK
            WHERE item-compra.cd-compra = INPUT FRAME {&FRAME-NAME} item-compra.cd-compra
            AND   item-compra.cd-item   = INPUT FRAME {&FRAME-NAME} item-compra.cd-item
            AND   ROWID(item-compra) <> ROWID(bf-item-compra) NO-ERROR.
        IF AVAIL item-compra THEN DO:
            ASSIGN item-compra.quantidade = item-compra.quantidade + INPUT FRAME {&FRAME-NAME} item-compra.quantidade
                   item-compra.vl-total = item-compra.vl-total + (INPUT FRAME {&FRAME-NAME} item-compra.quantidade * INPUT FRAME {&FRAME-NAME} item-compra.vl-unitario)
                   item-compra.vl-unitario = (item-compra.vl-total / item-compra.quantidade).
            DELETE bf-item-compra.
            DISPLAY item-compra.quantidade
                    item-compra.vl-total
                    item-compra.vl-unitario
                    WITH FRAME {&FRAME-NAME}.
            RETURN "OK".
        END.
    END.
END.

IF NOT CAN-FIND(FIRST item 
                WHERE item.cd-item = INPUT FRAME {&FRAME-NAME} item-compra.cd-item) THEN DO:
    {func\valida.i &Mensagem  = "Item inv†lido!"
                   &Ajuda     = "Vocà deve informar um item v†lido."
                   &Campo     = item-compra.cd-item}
END.

IF INPUT FRAME {&FRAME-NAME} item-compra.quantidade = 0 THEN DO:
    {func\valida.i &Mensagem  = "Quantidade n∆o informada!"
                   &Ajuda     = "Vocà deve informar uma quantidade diferente de zero."
                   &Campo     = item-compra.quantidade}
END.

IF INPUT FRAME {&FRAME-NAME} item-compra.vl-unitario = 0 THEN DO:
    {func\valida.i &Mensagem  = "Valor unit†rio n∆o informado!"
                   &Ajuda     = "Vocà deve informar um valor unit†rio diferente de zero."
                   &Campo     = item-compra.vl-unitario}
END.

RETURN "OK":U.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

