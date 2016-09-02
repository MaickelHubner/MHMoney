        
        DEFINE INPUT  PARAMETER procname AS CHARACTER  NO-UNDO.
        DEFINE OUTPUT PARAMETER rLote AS ROWID      NO-UNDO.

        DEFINE VARIABLE cTemp AS CHARACTER  NO-UNDO.
        DEFINE VARIABLE cDados AS CHARACTER  NO-UNDO.
        DEFINE VARIABLE iLote AS INTEGER    NO-UNDO.
        DEFINE VARIABLE iMov AS INTEGER    NO-UNDO.
        DEFINE VARIABLE cOper AS CHARACTER  NO-UNDO.
        DEFINE VARIABLE iOrigem AS INTEGER    NO-UNDO.
        
        SESSION:SET-WAIT-STATE("GENERAL":U).

        INPUT FROM VALUE(procname) CONVERT TARGET "ibm850".

        REPEAT:
            IMPORT UNFORMATTED cTemp.
            ASSIGN cDados = ENTRY(2,cTemp,"]").
            IF cTemp MATCHES("*[LOTE]*") THEN DO:
                FIND FIRST lote WHERE lote.numero = INTEGER(ENTRY(1,cDados,"|"))
                            AND lote.origem = INTEGER(ENTRY(2,cDados,"|")) NO-LOCK NO-ERROR.
                IF AVAIL lote THEN DO:
                    INPUT CLOSE.
                    SESSION:SET-WAIT-STATE("":U).
                    RUN func\msg.w (INPUT 1, INPUT "Importa‡Æo de Movimentos (040)", INPUT "Lote j  importado.", INPUT "Esse lote j  foi importado anteriormnte").
                    RETURN "NOK".
                END.
                ELSE DO:
                    CREATE lote.
                    ASSIGN lote.numero = INTEGER(ENTRY(1,cDados,"|"))
                           lote.origem = INTEGER(ENTRY(2,cDados,"|"))
                           lote.destino = INTEGER(ENTRY(3,cDados,"|"))
                           lote.data = DATE(ENTRY(4,cDados,"|")).
                    ASSIGN iLote = lote.numero
                           iOrigem = lote.origem
                           rLote = ROWID(lote).
                END.
            END.
            IF cTemp MATCHES("*[MOV]*") THEN DO:
                CREATE lote-mov.
                ASSIGN lote-mov.numero = iLote
                       lote-mov.num-mov = INTEGER(ENTRY(1,cDados,"|"))
                       lote-mov.operacao = ENTRY(2,cDados,"|")
                       lote-mov.tabela = ENTRY(3,cDados,"|")
                       lote-mov.data = DATE(ENTRY(4,cDados,"|"))
                       lote-mov.hora = REPLACE(ENTRY(5,cDados,"|"),":","")
                       lote-mov.usuario = ENTRY(6,cDados,"|")
                       lote-mov.origem = iOrigem.
                ASSIGN iMov = lote-mov.num-mov
                       cOper = lote-mov.operacao.
            END.
            IF cTemp MATCHES("*[CAMPO]*") THEN DO:
                CREATE lote-mov-campo.
                ASSIGN lote-mov-campo.numero = iLote
                       lote-mov-campo.num-mov = iMov
                       lote-mov-campo.campo = ENTRY(1,cDados,"|")
                       lote-mov-campo.chave = IF ENTRY(2,cDados,"|") = "Sim" THEN YES ELSE NO
                       lote-mov-campo.antes = REPLACE(REPLACE(ENTRY(3,cDados,"|"),"&&",CHR(13)),CHR(13),CHR(10))
                       lote-mov-campo.origem = iOrigem.
                IF cOper = "UPD" THEN
                       ASSIGN lote-mov-campo.depois = REPLACE(REPLACE(ENTRY(4,cDados,"|"),"&&",CHR(13)),CHR(13),CHR(10)).
            END.

        END.

        INPUT CLOSE.

        SESSION:SET-WAIT-STATE("":U).
