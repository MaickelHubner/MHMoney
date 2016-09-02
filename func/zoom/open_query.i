    DEFINE VARIABLE hColumn AS HANDLE     NO-UNDO.
    DEFINE VARIABLE qh   AS WIDGET-HANDLE.
    DEFINE VARIABLE cQuery AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE lPrim AS LOGICAL    NO-UNDO INITIAL YES.

    ASSIGN hColumn = BROWSE brZoom:CURRENT-COLUMN
           qh = BROWSE brZoom:QUERY
           cQuery = "for each {&TABLE} NO-LOCK".

    FOR EACH tt-filtro
        BY tt-filtro.orig:

        IF lPrim THEN DO:
            ASSIGN cQuery = cQuery + " WHERE {&Table}."
                   lPrim = NO.
        END.
        ELSE DO:
            ASSIGN cQuery = cQuery + " AND {&Table}.".
        END.

        ASSIGN cQuery = cQuery + tt-filtro.orig.

        IF ENTRY(NUM-ENTRIES(tt-filtro.campo," "),tt-filtro.campo," ") <> "Final" THEN
            ASSIGN cQuery = cQuery + " >= ".
        ELSE
            ASSIGN cQuery = cQuery + " <= ".

        CASE tt-filtro.tipo:
            WHEN "CHARACTER" THEN DO:
                ASSIGN cQuery = cQuery + "~"" + tt-filtro.valor + "~"".
            END.
            WHEN "LOGICAL" THEN DO:
                ASSIGN cQuery = cQuery + (IF tt-filtro.valor = "Sim" THEN "YES" ELSE "NO").
            END.
            OTHERWISE DO:
                ASSIGN cQuery = cQuery + tt-filtro.tipo + "(~"" + tt-filtro.valor + "~")".
            END.
        END CASE.

    END.

    IF VALID-HANDLE(hColumn) THEN DO:
        IF hColumn:TABLE <> ? THEN DO:
            ASSIGN cQuery = cQuery + " BY {&TABLE}." + hColumn:NAME + ".".
        END.
        ELSE DO:
            ASSIGN cQuery = cQuery + " BY {&TABLE}." + SUBSTRING(hColumn:NAME,2,(LENGTH(hColumn:NAME) - 1)) + ".".
        END.
    END.

    qh:QUERY-PREPARE(cQuery).
    qh:QUERY-OPEN.

