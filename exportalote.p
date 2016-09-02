    DEFINE VARIABLE cArq AS CHARACTER  NO-UNDO.
    
    SESSION:SET-WAIT-STATE("GENERAL":U).

    FIND FIRST param-mn NO-LOCK.

    CREATE lote.
    ASSIGN lote.numero = param-mn.lote-exp + 1
           lote.origem = param-mn.maquina-local
           lote.destino = param-mn.maquina-destino
           lote.data = TODAY.
    FIND CURRENT param-mn EXCLUSIVE-LOCK.
    ASSIGN param-mn.lote-exp = lote.numero.

    FOR EACH lote-mov WHERE lote-mov.numero = 0 EXCLUSIVE-LOCK:
        FOR EACH lote-mov-campo OF lote-mov EXCLUSIVE-LOCK:
            ASSIGN lote-mov-campo.numero = lote.numero
                   lote-mov-campo.origem = lote.origem.
        END.
        ASSIGN lote-mov.numero = lote.numero
               lote-mov.origem = lote.origem.
    END.

    ASSIGN cArq = "lotes\" + TRIM(STRING(lote.origem)) + "-" + TRIM(STRING(lote.destino)) + "-" + TRIM(STRING(lote.numero)) + ".lot".

    OUTPUT TO VALUE(cArq) CONVERT TARGET "iso8859-1".

    PUT UNFORMATTED "[LOTE]" + TRIM(STRING(lote.numero)) + "|" +
                    TRIM(STRING(lote.origem)) + "|" +
                    TRIM(STRING(lote.destino)) + "|" +
                    TRIM(STRING(lote.data,"99/99/9999")) SKIP.

    FOR EACH lote-mov WHERE lote-mov.numero = lote.numero NO-LOCK:
        PUT UNFORMATTED "[MOV]" + TRIM(STRING(lote-mov.num-mov)) + "|" +
                        TRIM(STRING(lote-mov.operacao)) + "|" +
                        TRIM(STRING(lote-mov.tabela)) + "|" +
                        TRIM(STRING(lote-mov.data,"99/99/9999")) + "|" +
                        TRIM(STRING(lote-mov.hora,"99:99")) + "|" +
                        TRIM(STRING(lote-mov.usuario)) SKIP.
        FOR EACH lote-mov-campo OF lote-mov NO-LOCK:
            PUT UNFORMATTED "[CAMPO]" + TRIM(STRING(lote-mov-campo.campo)) + "|" +
                            TRIM(STRING(lote-mov-campo.chave,"Sim/NÆo")) + "|".
            IF lote-mov-campo.antes <> ? THEN 
                PUT UNFORMATTED REPLACE(REPLACE(TRIM(STRING(lote-mov-campo.antes)),CHR(10),CHR(13)),CHR(13),"&&").
            ELSE 
                PUT UNFORMATTED "?".
            IF lote-mov-campo.depois <> ? THEN 
                PUT UNFORMATTED "|" + REPLACE(REPLACE(TRIM(STRING(lote-mov-campo.depois)),CHR(10),CHR(13)),CHR(13),"&&") SKIP.
            ELSE 
                PUT UNFORMATTED "?" SKIP.
            
        END.
    END.

    OUTPUT CLOSE.

    IF param-mn.email-para <> "" THEN DO:
        RUN pi-blat IN THIS-PROCEDURE (INPUT cArq).
    END.

    SESSION:SET-WAIT-STATE("":U).


    PROCEDURE pi-blat :
    /*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/

        DEFINE INPUT  PARAMETER cArquivo AS CHARACTER  NO-UNDO.

        DEFINE VARIABLE v-cod-lin-comando AS CHARACTER  NO-UNDO.
        DEFINE VARIABLE destinatario AS CHARACTER  NO-UNDO.
        DEFINE VARIABLE texto AS CHARACTER  NO-UNDO.
        DEFINE VARIABLE remetente AS CHARACTER  NO-UNDO.

        FIND FIRST param-mn NO-LOCK NO-ERROR.
        ASSIGN destinatario = param-mn.email-de
               remetente = param-mn.email-para
               texto = "Foi gerado um novo lote (em anexo) para ser importado no MHMoney 2005.".

         assign destinatario = replace(destinatario,chr(10),",")       
                destinatario = replace(destinatario,";",",")
                remetente = replace(remetente,chr(10),",")       
                remetente = replace(remetente,";",",").

        output to value(session:temp-directory + "dtsemail.txt") convert target "iso8859-1".
        put unformatted texto.
        output close.
        file-info:file-name = search("blat.exe").
        assign v-cod-lin-comando = "@" + "~"" + FILE-INFO:FULL-PATHNAME + "~""
                                   + " "
                                   + "~"" + session:temp-directory + "dtsemail.txt" + "~""
                                   + " -s" 
                                   + ' "' 
                                   + "MH Money 2005 - Novo lote para importa‡Æo" 
                                   + '"' 
                                   + " -f "
                                   + remetente
                                   + " -t " 
                                   + destinatario 
                                   + " -server " 
                                   + "~"" + param-mn.serv-email + "~""
                                   + " -port " 
                                   + param-mn.porta-email
                                   + " -mime"
                                   + " -q"
                                   + " -noh"
                                   + " -noh2".

        assign v-cod-lin-comando = v-cod-lin-comando + " -html ".           
        file-info:file-name = SEARCH(cArquivo).
        assign v-cod-lin-comando = v-cod-lin-comando + " -attach ~"" + FILE-INFO:FULL-PATHNAME + "~"".

        output to value(session:temp-directory + "dtsemail.bat") convert target "IBM850".
        put unformatted v-cod-lin-comando.
        OUTPUT CLOSE.
        dos silent value("~"" + session:temp-directory + "dtsemail.bat" + "~"").

        os-delete value(session:temp-directory + "dtsemail.txt").
        os-delete value(session:temp-directory + "dtsemail.bat").

        return "OK".

    END PROCEDURE.
