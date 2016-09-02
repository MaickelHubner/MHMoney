{func\set_leave.i}  
DEFINE BUFFER bfl-{&Tabela} FOR {&Tabela}.
&IF "{&Table}" = "" &THEN
    FIND FIRST bfl-{&Tabela} NO-LOCK
        WHERE bfl-{&Tabela}.{&Campo} = INPUT FRAME {&FRAME-NAME} {&CampoTela} NO-ERROR.
&ELSE
    &IF DEFINED(CampoPai) = 0 &THEN
        &IF DEFINED(CampoTela) = 0 &THEN
            FIND FIRST bfl-{&Tabela} NO-LOCK
                WHERE bfl-{&Tabela}.{&Campo} = INPUT FRAME {&FRAME-NAME} {&Table}.{&Campo} NO-ERROR.
        &ELSE
            FIND FIRST bfl-{&Tabela} NO-LOCK
                WHERE bfl-{&Tabela}.{&Campo} = INPUT FRAME {&FRAME-NAME} {&Table}.{&CampoTela} NO-ERROR.
        &ENDIF
    &ELSE
        &IF DEFINED(CampoTela) = 0 &THEN
            FIND FIRST bfl-{&Tabela} NO-LOCK
                WHERE bfl-{&Tabela}.{&CampoPai}
                AND   bfl-{&Tabela}.{&Campo} = INPUT FRAME {&FRAME-NAME} {&Table}.{&Campo} NO-ERROR.
        &ELSE
            FIND FIRST bfl-{&Tabela} NO-LOCK
                WHERE bfl-{&Tabela}.{&CampoPai}
                AND   bfl-{&Tabela}.{&Campo} = INPUT FRAME {&FRAME-NAME} {&Table}.{&CampoTela} NO-ERROR.
        &ENDIF
    &ENDIF
&ENDIF
IF NOT AVAIL bfl-{&Tabela} THEN DO:
    ASSIGN {&Tela}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    &IF DEFINED(CampoProc2) <> 0 &THEN
       ASSIGN {&Tela2}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    &ENDIF
    &IF DEFINED(CampoProc3) <> 0 &THEN
       ASSIGN {&Tela3}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    &ENDIF
    &IF DEFINED(CampoProc4) <> 0 &THEN
       ASSIGN {&Tela4}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    &ENDIF
    &IF DEFINED(CampoProc5) <> 0 &THEN
       ASSIGN {&Tela5}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
    &ENDIF
END.
ELSE DO:
    ASSIGN {&Tela} = bfl-{&Tabela}.{&CampoProc}.
    DISPLAY {&Tela} WITH FRAME {&FRAME-NAME}.
    &IF DEFINED(CampoProc2) <> 0 &THEN
        ASSIGN {&Tela2} = bfl-{&Tabela}.{&CampoProc2}.
        DISPLAY {&Tela2} WITH FRAME {&FRAME-NAME}.
    &ENDIF
    &IF DEFINED(CampoProc3) <> 0 &THEN
        ASSIGN {&Tela3} = bfl-{&Tabela}.{&CampoProc3}.
        DISPLAY {&Tela3} WITH FRAME {&FRAME-NAME}.
    &ENDIF
    &IF DEFINED(CampoProc4) <> 0 &THEN
        ASSIGN {&Tela4} = bfl-{&Tabela}.{&CampoProc4}.
        DISPLAY {&Tela4} WITH FRAME {&FRAME-NAME}.
    &ENDIF
    &IF DEFINED(CampoProc5) <> 0 &THEN
        ASSIGN {&Tela5} = bfl-{&Tabela}.{&CampoProc5}.
        DISPLAY {&Tela5} WITH FRAME {&FRAME-NAME}.
    &ENDIF
END.
