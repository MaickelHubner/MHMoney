    DEFINE VARIABLE deCont AS DECIMAL     NO-UNDO.

FORM apontamento.data AT 5
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 320 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-pedido. 

FORM apontamento.data AT 10
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 320 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-periodo.

FORM apontamento.nome AT 5
     apontamento.data
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 320 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-pedido-g. 

FORM apontamento.nome AT 10
     apontamento.data
     apontamento.hora-ini
     apontamento.hora-fim
     apontamento.qt-apont
     apontamento.ds-apontamento FORMAT "X(80)"
    WITH WIDTH 320 STREAM-IO NO-BOX NO-LABELS DOWN FRAME f-periodo-g.

DEFINE TEMP-TABLE tt-un
    FIELD un AS CHAR
    FIELD qt AS DEC.
DEFINE TEMP-TABLE tt-ped LIKE tt-un.

    EMPTY TEMP-TABLE tt-un.

    OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "rel_per.txt") CONVERT TARGET "iso8859-1".

    PUT UNFORMATTED "============================================================================================================================================================================================================================" SKIP
                    "Per¡odo: " STRING(01/01/2012, "99/99/9999") " at‚ " STRING(12/31/2012, "99/99/9999") SKIP
                    "============================================================================================================================================================================================================================".

    FOR EACH apontamento NO-LOCK
        WHERE apontamento.data >= 01/01/2012
        AND   apontamento.data <= 12/31/2012,
        FIRST pedido OF apontamento
            WHERE pedido.cd-favorecido = 40
        BREAK BY apontamento.nr-pedido
        BY apontamento.sequencia
        BY apontamento.data:

            FIND FIRST favorecido OF pedido NO-LOCK.
            FIND FIRST pedido-item OF apontamento NO-LOCK.
            FIND FIRST item OF pedido-item NO-LOCK.


        IF FIRST-OF(apontamento.nr-pedido) THEN DO:

            /*FIND FIRST pedido OF apontamento NO-LOCK.*/
            PUT UNFORMATTED SKIP(2)
                            "    =======================================================================================================================================================================================================================" SKIP
                            "    Pedido: " pedido.nr-pedido " - " favorecido.ds-favorecido " - " STRING(pedido.dt-pedido, "99/99/9999") " - " pedido.nom-projeto SKIP
                            "    =======================================================================================================================================================================================================================".

            EMPTY TEMP-TABLE tt-ped.
        END.

        IF FIRST-OF(apontamento.sequencia) THEN DO:

            PUT UNFORMATTED SKIP(2)
                            "         -------------------------------------" SKIP
                            "         Item: " item.ds-item SKIP
                            "         -------------------------------------" SKIP(2).
            ASSIGN deCont = 0.

            DISP "Usu rio" @ apontamento.nome
                 "Data" @ apontamento.data
                 "Hr Ini" @ apontamento.hora-ini
                 "Hr Fim" @ apontamento.hora-fim
                 "Qt Apont" @ apontamento.qt-apont
                 "Descri‡Æo" @ apontamento.ds-apontamento
                WITH FRAME f-periodo-g.
            DOWN WITH FRAME f-periodo-g.
            UNDERLINE apontamento.nome
                 apontamento.data
                 apontamento.hora-ini
                 apontamento.hora-fim
                 apontamento.qt-apont
                 apontamento.ds-apontamento
                WITH FRAME f-periodo-g.
            DOWN WITH FRAME f-periodo-g.
        END.

        DISP apontamento.nome
             apontamento.data
             apontamento.hora-ini
             apontamento.hora-fim
             apontamento.qt-apont
             apontamento.ds-apontamento
            WITH FRAME f-periodo-g.
        DOWN WITH FRAME f-periodo-g.
        ASSIGN deCont = deCont + apontamento.qt-apont.

        FIND FIRST tt-un
            WHERE tt-un.un = item.un NO-ERROR.
        IF NOT AVAIL tt-un THEN DO:
            CREATE tt-un.
            ASSIGN tt-un.un = item.un.
        END.
        ASSIGN tt-un.qt = tt-un.qt + apontamento.qt-apont.

        FIND FIRST tt-ped
            WHERE tt-ped.un = item.un NO-ERROR.
        IF NOT AVAIL tt-ped THEN DO:
            CREATE tt-ped.
            ASSIGN tt-ped.un = item.un.
        END.
        ASSIGN tt-ped.qt = tt-ped.qt + apontamento.qt-apont.

        IF LAST-OF(apontamento.sequencia) THEN DO:
            PUT UNFORMATTED SKIP(2) 
                            "         -------------------------------------" SKIP
                            "         Total de " item.ds-item ": " TRIM(STRING(deCont,"->>>,>>9.99")) SKIP
                            "         -------------------------------------".
        END.

        IF LAST-OF(apontamento.nr-pedido) THEN DO:
            PUT UNFORMATTED SKIP(2)
                            "         -------------------------------------" SKIP
                            "         TOTAL DO PEDIDO: " SKIP(1).
            FOR EACH tt-ped:
                PUT UNFORMATTED "              " CAPS(tt-ped.un) ": " TRIM(STRING(tt-ped.qt,"->>>,>>9.99")) SKIP.
            END.
            PUT UNFORMATTED SKIP(1) "         -------------------------------------" SKIP.
        END.

    END.

    PUT UNFORMATTED SKIP(2)
                    "    =======================================================================================================================================================================================================================" SKIP
                    "    TOTAL APONTADO NO PERÖODO: " SKIP(1).

    FOR EACH tt-un:
        PUT UNFORMATTED "         " CAPS(tt-un.un) ": " TRIM(STRING(tt-un.qt,"->>>,>>9.99")) SKIP.
    END.

    PUT UNFORMATTED SKIP(1) "    =======================================================================================================================================================================================================================".

    OUTPUT CLOSE.
    DOS SILENT VALUE("notepad.exe " + SESSION:TEMP-DIRECTORY + "rel_per.txt").
  
