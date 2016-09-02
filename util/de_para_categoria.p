DEFINE VARIABLE iCat-de   AS INTEGER LABEL "DE       Categoria"   NO-UNDO.
DEFINE VARIABLE iSub-de   AS INTEGER LABEL "DE   Sub-Categoria"   NO-UNDO.
DEFINE VARIABLE iCat-para AS INTEGER LABEL "PARA     Categoria"   NO-UNDO.
DEFINE VARIABLE iSub-para AS INTEGER LABEL "PARA Sub-Categoria"   NO-UNDO.
DEFINE VARIABLE cProcess AS CHARACTER FORMAT "X(40)" LABEL "Processando" VIEW-AS FILL-IN SIZE 47 BY 0.79.
DEFINE NEW GLOBAL SHARED VARIABLE gcFiltro AS CHARACTER  NO-UNDO.
DEFINE VARIABLE lTransf AS LOGICAL    NO-UNDO INITIAL NO.

DEFINE BUFFER bf-categoria FOR categoria.
DEFINE BUFFER bf-sub-cat FOR sub-cat.

DEFINE FRAME a
     iCat-de AT COL 4.4 ROW 2
     categoria.ds-categoria SKIP
     iSub-de AT COL 3 ROW 3
     sub-cat.ds-sub SKIP
     iCat-para AT COL 3.3 ROW 4
     bf-categoria.ds-categoria SKIP
     iSub-para AT COL 1.8 ROW 5
     bf-sub-cat.ds-sub SKIP
     cProcess AT COL 5 ROW 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 10 ROW 4
         SIZE 64 BY 6.5
         FONT 7.


ON F5 OF iCat-de IN FRAME a
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    RUN zoom\zcategoria.w (OUTPUT rReturn).
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST categoria NO-LOCK
            WHERE ROWID(categoria) = rReturn.
        ASSIGN iCat-de:SCREEN-VALUE = STRING(categoria.cod-categoria).
        DISP categoria.ds-categoria WITH FRAME a.
    END.
END.

ON F5 OF iSub-de IN FRAME a
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    ASSIGN gcFiltro = "cod-categoria," + STRING(iCat-de).
    RUN zoom\zsub-cat.w (OUTPUT rReturn).
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST sub-cat NO-LOCK
            WHERE ROWID(sub-cat) = rReturn.
        ASSIGN iSub-de:SCREEN-VALUE = STRING(sub-cat.cd-sub).
        DISP sub-cat.ds-sub WITH FRAME a.
    END.
END.

ON F5 OF iCat-para IN FRAME a
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    RUN zoom\zcategoria.w (OUTPUT rReturn).
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST bf-categoria NO-LOCK
            WHERE ROWID(bf-categoria) = rReturn.
        ASSIGN iCat-para:SCREEN-VALUE = STRING(bf-categoria.cod-categoria).
        DISP bf-categoria.ds-categoria WITH FRAME a.
    END.
END.

ON F5 OF iSub-para IN FRAME a
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    ASSIGN gcFiltro = "cod-categoria," + STRING(iCat-para).
    RUN zoom\zsub-cat.w (OUTPUT rReturn).
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST bf-sub-cat NO-LOCK
            WHERE ROWID(bf-sub-cat) = rReturn.
        ASSIGN iSub-para:SCREEN-VALUE = STRING(bf-sub-cat.cd-sub).
        DISP bf-sub-cat.ds-sub WITH FRAME a.
    END.
END.

UPDATE iCat-de WITH FRAME a.
FIND FIRST categoria NO-LOCK
    WHERE categoria.cod-categoria = iCat-de.
DISP categoria.ds-categoria WITH FRAME a.

UPDATE iSub-de WITH FRAME a.
FIND FIRST sub-cat NO-LOCK
    WHERE sub-cat.cod-categoria = iCat-de
    AND   sub-cat.cd-sub = iSub-de.
DISP sub-cat.ds-sub WITH FRAME a.

UPDATE iCat-para WITH FRAME a.
FIND FIRST bf-categoria NO-LOCK
    WHERE bf-categoria.cod-categoria = iCat-para.
DISP bf-categoria.ds-categoria WITH FRAME a.

UPDATE iSub-para WITH FRAME a.
FIND FIRST bf-sub-cat NO-LOCK
    WHERE bf-sub-cat.cod-categoria = iCat-para
    AND   bf-sub-cat.cd-sub = iSub-para NO-ERROR.
IF NOT AVAIL bf-sub-cat THEN DO:
    RUN func\msg.w (INPUT 2, INPUT "Execu‡Æo", INPUT "Deseja remanejar a sub-categoria ?", INPUT "Deseja alterar os movimentos da Sub-Categoria " + STRING(sub-cat.cd-sub) + " - " + sub-cat.ds-sub + " para o c¢digo " + STRING(iSub-para) + " ?").
    IF RETURN-VALUE = "OK" THEN DO:
        CREATE bf-sub-cat.
        BUFFER-COPY sub-cat EXCEPT sub-cat.cd-sub TO bf-sub-cat.
        ASSIGN bf-sub-cat.cd-sub = iSub-para
               lTransf = YES.
    END.
    ELSE DO:
        RETURN "NOK".
    END.
END.
DISP bf-sub-cat.ds-sub WITH FRAME a.

IF NOT lTransf THEN
    RUN func\msg.w (INPUT 2, INPUT "Execu‡Æo", INPUT "Confirma altera‡Æo de categoria ?", INPUT "Confirma a altera‡Æo dos movimentos de " + categoria.ds-categoria + " para " + bf-categoria.ds-categoria + " ?").

IF RETURN-VALUE = "OK" OR lTransf THEN DO:

    FIND FIRST sub-cat EXCLUSIVE-LOCK
        WHERE sub-cat.cod-categoria = iCat-de
        AND   sub-cat.cd-sub = iSub-de NO-ERROR.
    IF NOT AVAIL sub-cat THEN
        RETURN "NOK".

    FIND FIRST bf-sub-cat NO-LOCK
        WHERE bf-sub-cat.cod-categoria = iCat-para
        AND   bf-sub-cat.cd-sub = iSub-para NO-ERROR.
    IF NOT AVAIL bf-sub-cat THEN
        RETURN "NOK".

    FOR EACH mov-conta OF sub-cat EXCLUSIVE-LOCK:
        ASSIGN mov-conta.cod-categoria = bf-sub-cat.cod-categoria
               mov-conta.cd-sub = bf-sub-cat.cd-sub
               cProcess = "Conta: " + string(mov-conta.cd-conta) + " Mov: " + STRING(mov-conta.cd-sequencia).
        DISP cProcess WITH FRAME a.
    END.
    FOR EACH agenda OF sub-cat EXCLUSIVE-LOCK:
        ASSIGN agenda.cod-categoria = bf-sub-cat.cod-categoria
               agenda.cd-sub = bf-sub-cat.cd-sub
               cProcess = "Agendamento: " + STRING(agenda.cd-agenda).
        DISP cProcess WITH FRAME a.
    END.
    FOR EACH alerta-exc OF sub-cat EXCLUSIVE-LOCK:
        ASSIGN alerta-exc.cod-categoria = bf-sub-cat.cod-categoria
               alerta-exc.cd-sub = bf-sub-cat.cd-sub
               cProcess = "Exce‡äes de Alerta: " + STRING(alerta-exc.tipo).
        DISP cProcess WITH FRAME a.
    END.
    FOR EACH item-orcamento OF sub-cat EXCLUSIVE-LOCK:
        ASSIGN item-orcamento.cod-categoria = bf-sub-cat.cod-categoria
               item-orcamento.cd-sub = bf-sub-cat.cd-sub
               cProcess = "Or‡amento: " + STRING(item-orcamento.cd-orcamento).
        DISP cProcess WITH FRAME a.
    END.
    FOR EACH item OF sub-cat EXCLUSIVE-LOCK:
        ASSIGN item.cod-categoria = bf-sub-cat.cod-categoria
               item.cd-sub = bf-sub-cat.cd-sub
               cProcess = "Item: " + STRING(item.cd-item).
        DISP cProcess WITH FRAME a.
    END.

    IF lTransf THEN DO:
        DELETE sub-cat.
    END.

END.

RUN func\msg.w (INPUT 1, INPUT "Execu‡Æo OK", INPUT "Movimentos alterados com sucesso!", INPUT "").

RETURN "OK".

