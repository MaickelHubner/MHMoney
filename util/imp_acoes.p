DEF VAR i-moeda LIKE moeda.cd-moeda.
DEFINE VARIABLE ch-excel     AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-planilha  AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-arquivo   AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE l-aux AS LOGICAL     NO-UNDO INITIAL NO.

DEFINE VARIABLE i-linha AS INTEGER     NO-UNDO INITIAL 2.

DEFINE TEMP-TABLE tt-cot LIKE cotacao
    INDEX idx-asc dt-ini.
DEFINE BUFFER bf-cot FOR tt-cot.

UPDATE i-moeda
    WITH SIDE-LABEL 1 COL.

FIND FIRST moeda NO-LOCK
    WHERE moeda.cd-moeda = i-moeda NO-ERROR.
IF NOT AVAIL moeda THEN RETURN "NOK".

DISP moeda.ds-moeda.

MESSAGE moeda.ds-moeda
    VIEW-AS ALERT-BOX INFO BUTTONS YES-NO SET l-aux.

IF NOT l-aux THEN RETURN "NOK".

CREATE "Excel.Application" ch-excel.
CASE i-moeda:
    /*WHEN 25 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\Historico_ETER3.xlsx").*/
    /*WHEN 26 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\Historico_WHRL4.xlsx").*/
    WHEN 30 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\Historico_RNGO11.xlsx").
    /*WHEN 32 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\XPDividendos.xlsx").*/
    /*WHEN 33 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\XPReferenciado.xlsx").*/
    /*WHEN 35 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\XPPlural.xlsx").*/
    /*WHEN 38 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\BB.xlsx").*/
    WHEN 39 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\Historico_ALPA4.xlsx").
    WHEN 40 THEN ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\Historico_ITUB4.xlsx").
END CASE.

ASSIGN ch-planilha = ch-arquivo:Sheets:Item(1).        

REPEAT i-linha = 2 TO 9999:

    IF ch-planilha:Cells(i-linha, 1):Value <> ? THEN DO:
        /*DISP ch-planilha:Cells(i-linha, 1):VALUE ch-planilha:Cells(i-linha, 3):Value.*/
        CREATE tt-cot.
        IF i-moeda = 38 THEN DO:
            ASSIGN tt-cot.dt-ini = DATE(INT(ENTRY(2, ch-planilha:Cells(i-linha, 1):Value, ".")), INT(ENTRY(1, ch-planilha:Cells(i-linha, 1):Value, ".")), INT(ENTRY(3, ch-planilha:Cells(i-linha, 1):Value, "."))).
        END.
        ELSE DO:
            ASSIGN tt-cot.dt-ini = ch-planilha:Cells(i-linha, 1):Value.
        END.
        IF i-moeda <> 32
        AND i-moeda <> 33
        AND i-moeda <> 35
        AND i-moeda <> 38 THEN DO:
            ASSIGN tt-cot.valor = ch-planilha:Cells(i-linha, 3):Value.
        END.
        ELSE DO:
            ASSIGN tt-cot.valor = ch-planilha:Cells(i-linha, 2):Value.
        END.
    END.
    ELSE DO:
        LEAVE.
    END.

END.

FOR EACH tt-cot
    USE-INDEX idx-asc:

    DISP tt-cot.dt-ini
         tt-cot.valor.

    FOR FIRST bf-cot USE-INDEX idx-asc
        WHERE bf-cot.dt-ini > tt-cot.dt-ini:
    END.

    FIND FIRST cotacao OF moeda EXCLUSIVE-LOCK
        WHERE cotacao.dt-ini = tt-cot.dt-ini NO-ERROR.

    IF AVAIL bf-cot THEN DO:
        DISP bf-cot.dt-ini - 1.
    END.

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

ch-Excel:QUIT.
RELEASE OBJECT ch-planilha NO-ERROR.
RELEASE OBJECT ch-arquivo NO-ERROR.
RELEASE OBJECT ch-Excel NO-ERROR.

