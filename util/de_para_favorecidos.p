DEFINE VARIABLE iFav-de   AS INTEGER LABEL "DE   Favorecido"   NO-UNDO.
DEFINE VARIABLE iFav-para AS INTEGER LABEL "PARA Favorecido"   NO-UNDO.
DEFINE VARIABLE cProcess AS CHARACTER FORMAT "X(40)" LABEL "Processando" VIEW-AS FILL-IN SIZE 47 BY 0.79.

DEFINE BUFFER bf-favorecido FOR favorecido.

DEFINE FRAME a
     iFav-de AT COL 3 ROW 2
     favorecido.ds-favorecido SKIP
     iFav-para AT COL 1.75 ROW 3
     bf-favorecido.ds-favorecido SKIP
     cProcess AT COL 5 ROW 5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 10 ROW 4
         SIZE 62 BY 6
         FONT 7.


ON F5 OF iFav-de IN FRAME a
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    RUN zoom\zfavorecido.w (OUTPUT rReturn).
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST favorecido NO-LOCK
            WHERE ROWID(favorecido) = rReturn.
        ASSIGN iFav-de:SCREEN-VALUE = STRING(favorecido.cd-favorecido).
        DISP favorecido.ds-favorecido WITH FRAME a.
    END.
END.

ON F5 OF iFav-para IN FRAME a
DO:
    DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
    RUN zoom\zfavorecido.w (OUTPUT rReturn).
    IF RETURN-VALUE = "OK" THEN DO:
        FIND FIRST bf-favorecido NO-LOCK
            WHERE ROWID(bf-favorecido) = rReturn.
        ASSIGN iFav-para:SCREEN-VALUE = STRING(bf-favorecido.cd-favorecido).
        DISP bf-favorecido.ds-favorecido WITH FRAME a.
    END.
END.

UPDATE iFav-de WITH FRAME a.
FIND FIRST favorecido NO-LOCK
    WHERE favorecido.cd-favorecido = iFav-de.
DISP favorecido.ds-favorecido WITH FRAME a.

UPDATE iFav-para WITH FRAME a.
FIND FIRST bf-favorecido NO-LOCK
    WHERE bf-favorecido.cd-favorecido = iFav-para.
DISP bf-favorecido.ds-favorecido WITH FRAME a.

RUN func\msg.w (INPUT 2, INPUT "Execu‡Æo", INPUT "Confirma altera‡Æo de favorecido ?", INPUT "Confirma a altera‡Æo dos movimentos de " + favorecido.ds-favorecido + " para " + bf-favorecido.ds-favorecido + " ?").

IF RETURN-VALUE = "OK" THEN DO:

    FOR EACH mov-conta OF favorecido EXCLUSIVE-LOCK:
        ASSIGN mov-conta.cd-favorecido = bf-favorecido.cd-favorecido
               cProcess = "Movimento: " + STRING(mov-conta.cd-sequencia).
        DISP cProcess WITH FRAME a.
    END.
    FOR EACH agenda OF favorecido EXCLUSIVE-LOCK:
        ASSIGN agenda.cd-favorecido = bf-favorecido.cd-favorecido
               cProcess = "Agendamento: " + STRING(agenda.cd-agenda).
        DISP cProcess WITH FRAME a.
    END.
    FOR EACH alerta-exc OF favorecido EXCLUSIVE-LOCK:
        ASSIGN alerta-exc.cd-favorecido = bf-favorecido.cd-favorecido
               cProcess = "Exce‡äes de Alerta: " + STRING(alerta-exc.tipo).
        DISP cProcess WITH FRAME a.
    END.

END.

RUN func\msg.w (INPUT 1, INPUT "Execu‡Æo OK", INPUT "Movimentos alterados com sucesso!", INPUT "").

RETURN "OK".

/*money.mov-conta.cd-favorecido
money.favorecido.cd-favorecido
money.agenda.cd-favorecido
money.alerta-exc.cd-favorecido*/
