DEFINE VARIABLE ch-excel     AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-planilha  AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-arquivo   AS COM-HANDLE NO-UNDO.

DEFINE VARIABLE i-linha AS INTEGER     NO-UNDO INITIAL 2.
DEFINE VARIABLE dt-ini AS DATE LABEL "Data In¡cio" FORMAT "99/99/9999"  NO-UNDO.
DEFINE VARIABLE i-moeda AS INTEGER     NO-UNDO.

ASSIGN dt-ini = DATE(MONTH(TODAY), 1, YEAR(TODAY)).

CREATE "Excel.Application" ch-excel.
ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\TD.xlsx").
ASSIGN ch-planilha = ch-arquivo:Sheets:Item(1).        

UPDATE dt-ini
    WITH SIDE-LABEL 1 COL.

REPEAT i-linha = 3 TO 9999:

    IF ch-planilha:Cells(i-linha, 1):Value <> ? THEN DO:

        DISP ch-planilha:Cells(i-linha, 1):VALUE 
             ROUND(ch-planilha:Cells(i-linha, 4):Value, 2)
             ROUND(ch-planilha:Cells(i-linha, 6):Value, 2).

        CASE STRING(ch-planilha:Cells(i-linha, 1):VALUE):
            WHEN "Tesouro IPCA+ 2035 (NTNB Princ)" THEN ASSIGN i-moeda = 37.
            WHEN "Tesouro Prefixado 2021 (LTN)" THEN ASSIGN i-moeda = 36.
            WHEN "Tesouro Prefixado com Juros Semestrais 2021 (NTNF)" THEN ASSIGN i-moeda = 24.
            WHEN "Tesouro Prefixado com Juros Semestrais 2023 (NTNF)" THEN ASSIGN i-moeda = 29.
        END CASE.

        FIND FIRST moeda NO-LOCK
            WHERE moeda.cd-moeda = i-moeda NO-ERROR.
        IF AVAIL moeda THEN DO:
        
            DISP moeda.ds-moeda.
        
            FIND FIRST cotacao OF moeda
                WHERE cotacao.dt-ini = dt-ini NO-ERROR.
            IF AVAIL cotacao THEN DO:
        
                DISP cotacao.dt-ini
                     cotacao.valor.
                DOWN.

                ASSIGN cotacao.valor = (ROUND(ch-planilha:Cells(i-linha, 4):Value, 2) / ROUND(ch-planilha:Cells(i-linha, 6):Value, 2)).
        
                DISP cotacao.dt-ini
                     cotacao.valor.

            END.
            ELSE DO:

                FIND FIRST cotacao OF moeda
                    WHERE cotacao.dt-end = 12/31/9999 NO-ERROR.
                IF AVAIL cotacao THEN DO:

                    DISP cotacao.dt-ini
                         cotacao.valor.
                    DOWN.

                    ASSIGN cotacao.dt-end = dt-ini - 1.

                END.

                CREATE cotacao.
                ASSIGN cotacao.cd-moeda = moeda.cd-moeda
                       cotacao.dt-ini = dt-ini
                       cotacao.dt-end = 12/31/9999
                       cotacao.valor = (ROUND(ch-planilha:Cells(i-linha, 4):Value, 2) / ROUND(ch-planilha:Cells(i-linha, 6):Value, 2)).

                DISP cotacao.dt-ini
                     cotacao.valor.

            END.
        
        END.
        
    END.
    ELSE DO:
        LEAVE.
    END.

END.

ch-Excel:QUIT.
RELEASE OBJECT ch-Excel NO-ERROR.


