DEFINE VARIABLE cDir        AS CHARACTER NO-UNDO INITIAL "C:\Users\Hubner\Desktop".
DEFINE VARIABLE cFile AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLinha AS CHARACTER   NO-UNDO FORMAT "X(200)".
DEFINE VARIABLE cAcao AS CHARACTER   NO-UNDO.
DEFINE VARIABLE dtCot AS DATE    NO-UNDO.
DEFINE VARIABLE deVal AS DECIMAL     NO-UNDO.

DEFINE TEMP-TABLE tt-file
    FIELD arquivo AS CHAR FORMAT "X(70)"
    FIELD cd-moeda AS INT
    FIELD uol AS LOG.

DEFINE TEMP-TABLE tt-cot LIKE cotacao
    INDEX idx-asc cd-moeda dt-ini.
DEFINE BUFFER bf-cot FOR tt-cot.

DEFINE BUFFER first-cot FOR cotacao.

INPUT FROM OS-DIR(cDir) CONVERT TARGET "ibm850".
REPEAT:
    IMPORT cFile.
    IF cFile MATCHES "*.csv" THEN DO:
        CREATE tt-file.
        ASSIGN tt-file.arquivo = cDir + "\" + cFile
               tt-file.uol = cFile MATCHES "uol*".
        IF tt-file.uol THEN DO:
            ASSIGN cAcao = ENTRY(1, REPLACE(cFile, "uol-economia-fii-", ""), "-").
        END.
        ELSE DO:
            ASSIGN cAcao = TRIM(ENTRY(1, cFile, "-")).
        END.
        IF cAcao MATCHES "* *" THEN
            ASSIGN cAcao = ENTRY(1, cAcao, " ").
        FIND FIRST conta
            WHERE conta.ds-conta MATCHES "*" + cAcao + "*" NO-ERROR.
        IF AVAIL conta THEN DO:
            ASSIGN tt-file.cd-moeda = conta.cd-moeda.
        END.
    END.
END.

FOR EACH tt-file:
    INPUT FROM VALUE(tt-file.arquivo).
    REPEAT:
        IMPORT UNFORMATTED cLinha.
        IF cLinha MATCHES "*Data*" THEN NEXT.
        IF tt-file.uol THEN DO:
            ASSIGN deVal = DEC(REPLACE(ENTRY(6, cLinha, ";"), ".", ","))
                   dtCot = DATE(ENTRY(11, cLinha, ";")).
        END.
        ELSE DO:
            ASSIGN cLinha = REPLACE(REPLACE(cLinha, '","', ";"), '"', "").
            ASSIGN deVal = DEC(ENTRY(2, cLinha, ";"))
                   dtCot = DATE(REPLACE(ENTRY(1, cLinha, ";"), ".", "/")).
        END.
        FIND FIRST tt-cot
            WHERE tt-cot.cd-moeda = tt-file.cd-moeda
            AND   tt-cot.dt-ini = dtCot NO-ERROR.
        IF NOT AVAIL tt-cot THEN DO:
            CREATE tt-cot.
            ASSIGN tt-cot.cd-moeda = tt-file.cd-moeda
                   tt-cot.dt-ini = dtCot
                   tt-cot.valor = deVal.
        END.
    END.
END.

FOR EACH tt-cot
    USE-INDEX idx-asc:

    FIND FIRST moeda OF tt-cot NO-LOCK NO-ERROR.
    IF NOT AVAIL moeda THEN NEXT.

    FIND FIRST mov-conta OF moeda NO-ERROR.
    IF AVAIL mov-conta AND tt-cot.dt-ini < mov-conta.dt-mov THEN NEXT.

    DISP moeda.ds-moeda FORMAT "X(35)"
         tt-cot.dt-ini
         tt-cot.valor.

    FOR FIRST bf-cot USE-INDEX idx-asc
        WHERE bf-cot.dt-ini > tt-cot.dt-ini:
    END.
    IF AVAIL bf-cot THEN DO:
        DISP bf-cot.dt-ini - 1.
    END.

    FIND FIRST first-cot OF moeda EXCLUSIVE-LOCK
        WHERE first-cot.dt-ini = DATE(1, 1, 1) NO-ERROR.
    IF AVAIL first-cot THEN DO:
        IF AVAIL bf-cot AND first-cot.dt-end = DATE(12, 31, 9999) THEN DO:
            ASSIGN first-cot.dt-end = bf-cot.dt-ini - 1.
        END.
        IF tt-cot.dt-ini <= first-cot.dt-end THEN DO:
            DISP first-cot.valor @ tt-cot.valor.
            NEXT.
        END.
    END.

    FIND FIRST cotacao OF moeda EXCLUSIVE-LOCK
        WHERE cotacao.dt-ini = tt-cot.dt-ini NO-ERROR.

    IF AVAIL cotacao THEN DO:
        IF cotacao.dt-end = DATE(12,31,9999) THEN DO:
            IF AVAIL bf-cot THEN DO:
                ASSIGN cotacao.dt-end = bf-cot.dt-ini - 1.
            END.
        END.
    END.
    ELSE DO:
        IF AVAIL bf-cot THEN DO:
            CREATE cotacao.
            ASSIGN cotacao.cd-moeda = moeda.cd-moeda
                   cotacao.dt-ini = tt-cot.dt-ini
                   cotacao.dt-end = bf-cot.dt-ini - 1
                   cotacao.valor = tt-cot.valor.
        END.
        ELSE DO:
            CREATE cotacao.
            ASSIGN cotacao.cd-moeda = moeda.cd-moeda
                   cotacao.dt-ini = tt-cot.dt-ini
                   cotacao.dt-end = DATE(12,31,9999)
                   cotacao.valor = tt-cot.valor.
        END.
    END.

END.

