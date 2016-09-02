DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

for each _file where _file._hidden = NO NO-LOCK:

    /* DELETE */
    output to value("database\trg\d\" + _file._dump-name + ".p").
    
    put unformatted "TRIGGER PROCEDURE FOR DELETE OF " _file._file-name "." skip(1).

    if _file._dump-name <> "mn013" and
       _file._dump-name <> "mn014" and
       _file._dump-name <> "mn015" and
       _file._dump-name <> "mn016" and
       _file._dump-name <> "mn017" and
       _file._dump-name <> "mn018" then do:
        
        put unformatted "DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO." skip
                        "DEFINE VARIABLE iNum AS INTEGER    NO-UNDO." skip(1)
                        "FIND FIRST param-mn NO-LOCK." skip
                        "IF param-mn.sincroniza THEN DO:" skip(1)
                        "    FIND LAST lote-mov WHERE lote-mov.numero = 0 NO-LOCK NO-ERROR." skip
                        "    IF AVAIL lote-mov THEN" skip
                        "        ASSIGN iNum = lote-mov.num-mov + 1." skip
                        "    ELSE" skip
                        "        ASSIGN iNum = 1." skip(1)
                        "    CREATE lote-mov." skip
                        "    ASSIGN lote-mov.usuario  = gcUsuario" skip
                        "           lote-mov.data     = TODAY" skip
                        "           lote-mov.hora     = REPLACE(STRING(TIME," '"' "HH:MM" '"' ")," '"' ":" '"' "," '""' ")" skip
                        "           lote-mov.tabela   = " '"' _file._file-name '"' skip
                        "           lote-mov.operacao = " '"' "DEL" '"' skip
                        "           lote-mov.origem   = param-mn.maquina-local" SKIP
                        "           lote-mov.num-mov  = iNum." skip(1).
    
        find first _index where recid(_index) = _file._prime-index NO-LOCK.
        if avail _index then do:
            for each _index-field where _index-field._index-recid = recid(_index) NO-LOCK:
                find first _field where recid(_field) = _index-field._field-recid NO-LOCK.
                if avail _field then do:
                    put unformatted "    CREATE lote-mov-campo." skip
                                    "    ASSIGN lote-mov-campo.num-mov = iNum" skip
                                    "           lote-mov-campo.campo   = " '"' _field._field-name '"' skip
                                    "           lote-mov-campo.chave   = yes" skip
                                    "           lote-mov-campo.origem  = param-mn.maquina-local" SKIP
                                    "           lote-mov-campo.antes   = TRIM(STRING(" _file._file-name "." _field._field-name "," '"' TRIM(_field._format) '"' "))." skip(1).
                end.
            end.
        end.

        put unformatted "END.".

    end.

    output close.

    /* CREATE OU UPDATE */
    output to value("database\trg\w\" + _file._dump-name + ".p").
    
    put unformatted "TRIGGER PROCEDURE FOR WRITE OF " _file._file-name " NEW BUFFER newTab OLD BUFFER oldTab." skip(1).

    if _file._dump-name <> "mn013" and
       _file._dump-name <> "mn014" and
       _file._dump-name <> "mn015" and
       _file._dump-name <> "mn016" and
       _file._dump-name <> "mn017" and
       _file._dump-name <> "mn018" then do:

        put unformatted "DEFINE SHARED VARIABLE gcUsuario AS CHARACTER  NO-UNDO." skip
                        "DEFINE VARIABLE cResult AS CHARACTER  NO-UNDO." skip
                        "DEFINE VARIABLE iCont AS INTEGER    NO-UNDO." skip
                        "DEFINE VARIABLE iNum AS INTEGER    NO-UNDO." skip(1)
                        "FUNCTION fnValor RETURNS CHARACTER (cTab AS CHARACTER, cCampo AS CHARACTER):" skip
                        "    DEFINE VARIABLE cValor AS CHARACTER NO-UNDO." skip
                        "    CASE cTab:" skip
                        "        WHEN " '"' "NEW" '"' " THEN DO:" skip
                        "            CASE cCampo:" skip.
        for each _field where _field._file-recid = recid(_file) NO-LOCK:
            IF _field._extent = 0 THEN DO:
                put unformatted "                WHEN " '"' _field._field-name '"' " THEN DO:" skip
                                "                    ASSIGN cValor = TRIM(STRING(newTab." _field._field-name "," '"' TRIM(_field._format) '"' "))." skip
                                "                END." skip.
            END.
            ELSE DO:
                put unformatted "                WHEN " '"' _field._field-name '"' " THEN DO:" skip.
                REPEAT iCont = 1 TO _field._extent:
                    IF iCont = 1 THEN
                        PUT UNFORMATTED "                    ASSIGN cValor = TRIM(STRING(newTab." _field._field-name "[" iCont "]" "," '"' TRIM(_field._format) '"' ")) + ~"|~" +" skip.
                    IF iCont <> _field._extent THEN
                        PUT UNFORMATTED "                                    TRIM(STRING(newTab." _field._field-name "[" iCont "]" "," '"' TRIM(_field._format) '"' ")) + ~"|~" +" skip.
                    ELSE
                        PUT UNFORMATTED "                                    TRIM(STRING(newTab." _field._field-name "[" iCont "]" "," '"' TRIM(_field._format) '"' "))." skip.
                END.
                PUT UNFORMATTED "                END." skip.
            END.
        end.
        put unformatted "            END CASE." skip
                        "        END." skip
                        "        WHEN " '"' "OLD" '"' " THEN DO:" skip
                        "            CASE cCampo:" skip.
        for each _field where _field._file-recid = recid(_file) NO-LOCK:
            IF _field._extent = 0 THEN DO:
                put unformatted "                WHEN " '"' _field._field-name '"' " THEN DO:" skip
                                "                    ASSIGN cValor = TRIM(STRING(oldTab." _field._field-name "," '"' TRIM(_field._format) '"' "))." skip
                                "                END." skip.
            END.
            ELSE DO:
                put unformatted "                WHEN " '"' _field._field-name '"' " THEN DO:" skip.
                REPEAT iCont = 1 TO _field._extent:
                    IF iCont = 1 THEN
                        PUT UNFORMATTED "                    ASSIGN cValor = TRIM(STRING(oldTab." _field._field-name "[" iCont "]" "," '"' TRIM(_field._format) '"' ")) + ~"|~" +" skip.
                    IF iCont <> _field._extent THEN
                        PUT UNFORMATTED "                                    TRIM(STRING(oldTab." _field._field-name "[" iCont "]" "," '"' TRIM(_field._format) '"' ")) + ~"|~" +" skip.
                    ELSE
                        PUT UNFORMATTED "                                    TRIM(STRING(oldTab." _field._field-name "[" iCont "]" "," '"' TRIM(_field._format) '"' "))." skip.
                END.
                PUT UNFORMATTED "                END." skip.
            END.
        end.
        put unformatted "            END CASE." skip
                        "        END." skip
                        "    END CASE." skip
                        "    RETURN cValor." skip
                        "END FUNCTION." skip(1)
                        "FIND FIRST param-mn NO-LOCK." skip
                        "IF param-mn.sincroniza THEN DO:" skip(1)
                        "    FIND LAST lote-mov WHERE lote-mov.numero = 0 NO-LOCK NO-ERROR." skip
                        "    IF AVAIL lote-mov THEN" skip
                        "        ASSIGN iNum = lote-mov.num-mov + 1." skip
                        "    ELSE" skip
                        "        ASSIGN iNum = 1." skip(1)
                        "    CREATE lote-mov." skip
                        "    ASSIGN lote-mov.usuario  = gcUsuario" skip
                        "           lote-mov.data     = TODAY" skip
                        "           lote-mov.hora     = REPLACE(STRING(TIME," '"' "HH:MM" '"' ")," '"' ":" '"' "," '""' ")" skip
                        "           lote-mov.tabela   = " '"' _file._file-name '"' skip
                        "           lote-mov.operacao = " '"' "UPD" '"' skip
                        "           lote-mov.origem   = param-mn.maquina-local" SKIP
                        "           lote-mov.num-mov  = iNum." skip(1)
                        "    BUFFER-COMPARE oldTab TO newTab SAVE RESULT IN cResult." skip(1).
    
        assign iCont = 0.
        find first _index where recid(_index) = _file._prime-index NO-LOCK.
        if avail _index then do:
            for each _index-field where _index-field._index-recid = recid(_index) NO-LOCK:
                find first _field where recid(_field) = _index-field._field-recid NO-LOCK.
                if avail _field then do:
                    if iCont = 0 then
                        put unformatted "    IF LOOKUP(" '"' _field._field-name '"' ",cResult) <> 0".
                    else
                        put unformatted skip "    OR LOOKUP(" '"' _field._field-name '"' ",cResult) <> 0".
                    assign iCont = iCont + 1.
                end.
            end.
        end.
        put unformatted " THEN DO:" skip(1)
                        "        ASSIGN lote-mov.operacao = " '"' "CRE" '"' "." skip(1).
    
        find first _index where recid(_index) = _file._prime-index NO-LOCK.
        if avail _index then do:
            for each _index-field where _index-field._index-recid = recid(_index) NO-LOCK:
                find first _field where recid(_field) = _index-field._field-recid NO-LOCK.
                if avail _field then do:
                    put unformatted "        CREATE lote-mov-campo." skip
                                    "        ASSIGN lote-mov-campo.num-mov = iNum" skip
                                    "               lote-mov-campo.campo   = " '"' _field._field-name '"' skip
                                    "               lote-mov-campo.chave   = YES" skip
                                    "               lote-mov-campo.origem  = param-mn.maquina-local" SKIP
                                    "               lote-mov-campo.antes   = TRIM(STRING(newTab." _field._field-name "," '"' TRIM(_field._format) '"' "))." skip(1).
                end.
            end.
        end.    
        put unformatted "        REPEAT iCont = 1 TO NUM-ENTRIES(cResult):" skip
                        "            FIND FIRST lote-mov-campo" skip
                        "                WHERE lote-mov-campo.num-mov = iNum" skip
                        "                AND   lote-mov-campo.campo = ENTRY(iCont,cResult) NO-LOCK NO-ERROR." skip
                        "            IF NOT AVAIL lote-mov-campo THEN DO:" skip
                        "                CREATE lote-mov-campo." skip
                        "                ASSIGN lote-mov-campo.num-mov = iNum" skip
                        "                       lote-mov-campo.campo   = ENTRY(iCont,cResult)" skip
                        "                       lote-mov-campo.origem  = param-mn.maquina-local." SKIP
                        "                ASSIGN lote-mov-campo.antes   = fnValor(" '"' "NEW" '"' ",ENTRY(iCont,cResult))." skip
                        "            END." skip
                        "        END." skip(1)
                        "    END." skip
                        "    ELSE DO:" skip(1).
    
        find first _index where recid(_index) = _file._prime-index NO-LOCK.
        if avail _index then do:
            for each _index-field where _index-field._index-recid = recid(_index) NO-LOCK:
                find first _field where recid(_field) = _index-field._field-recid NO-LOCK.
                if avail _field then do:
                    put unformatted "        CREATE lote-mov-campo." skip
                                    "        ASSIGN lote-mov-campo.num-mov = iNum" skip
                                    "               lote-mov-campo.campo   = " '"' _field._field-name '"' skip
                                    "               lote-mov-campo.chave   = YES" skip
                                    "               lote-mov-campo.origem  = param-mn.maquina-local" SKIP
                                    "               lote-mov-campo.antes   = TRIM(STRING(oldTab." _field._field-name "," '"' TRIM(_field._format) '"' "))." skip
                                    "               lote-mov-campo.depois  = TRIM(STRING(newTab." _field._field-name "," '"' TRIM(_field._format) '"' "))." skip(1).
                end.
            end.
        end.    
        put unformatted "        REPEAT iCont = 1 TO NUM-ENTRIES(cResult):" skip
                        "            CREATE lote-mov-campo." skip
                        "            ASSIGN lote-mov-campo.num-mov = iNum" skip
                        "                   lote-mov-campo.campo   = ENTRY(iCont,cResult)" skip
                        "                   lote-mov-campo.origem  = param-mn.maquina-local." SKIP
                        "            ASSIGN lote-mov-campo.antes   = fnValor(" '"' "OLD" '"' ",ENTRY(iCont,cResult))." skip
                        "                   lote-mov-campo.depois  = fnValor(" '"' "NEW" '"' ",ENTRY(iCont,cResult))." skip
                        "        END." skip(1)
                        "    END." skip(1)
                        "END.".
    
    end.

    output close.

end.
