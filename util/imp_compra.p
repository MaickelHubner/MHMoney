DEFINE VARIABLE i-fav LIKE favorecido.cd-favorecido NO-UNDO INITIAL 5.
DEFINE VARIABLE dt-compra AS DATE FORMAT "99/99/9999" LABEL "Data Compra" NO-UNDO INITIAL TODAY.

DEFINE VARIABLE ch-excel     AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-planilha  AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ch-arquivo   AS COM-HANDLE NO-UNDO.

DEFINE VARIABLE i-linha AS INTEGER     NO-UNDO INITIAL 1.
DEFINE VARIABLE c-ds AS CHARACTER   NO-UNDO.

DEFINE TEMP-TABLE tt-it LIKE item-compra
    FIELD ds-item LIKE item.ds-item.

DEFINE TEMP-TABLE tt-depara
    FIELD ds-item LIKE item.ds-item
    FIELD cd-item LIKE item.cd-item
    FIELD multiplicador AS DEC INITIAL 1.

DEFINE BUFFER bf-compra FOR compra.

INPUT FROM VALUE("C:/Maickel/MHMoney/deparaitens.d").
REPEAT:
    CREATE tt-depara.
    IMPORT tt-depara.
END.
INPUT CLOSE.

IF AVAIL tt-depara AND tt-depara.cd-item = 0 THEN
    DELETE tt-depara.

FIND FIRST favorecido NO-LOCK
    WHERE favorecido.cd-favorecido = i-fav NO-ERROR.

DISPLAY i-fav
        favorecido.ds-favorecido NO-LABEL SKIP
        dt-compra
    WITH FRAME f.

UPDATE i-fav
       dt-compra
    WITH FRAME f SIDE-LABEL.

FIND FIRST compra NO-LOCK
    WHERE compra.cd-favorecido = i-fav
    AND   compra.dt-compra = dt-compra
    AND compra.gerada = FALSE NO-ERROR.
IF NOT AVAIL compra THEN DO:
    FIND LAST bf-compra.
    CREATE compra.
    ASSIGN compra.cd-compra = bf-compra.cd-compra + 1
           compra.cd-favorecido = i-fav
           compra.dt-compra = dt-compra.
END.

CREATE "Excel.Application" ch-excel.
ASSIGN ch-arquivo = ch-excel:Workbooks:OPEN("C:\Users\Hubner\Desktop\compra.xlsx").
ASSIGN ch-planilha = ch-arquivo:Sheets:Item(1).        

REPEAT i-linha = 1 TO 9999:

    IF ch-planilha:Cells(i-linha, 1):Value <> ? THEN DO:
        /*DISP ch-planilha:Cells(i-linha, 1):VALUE 
             ch-planilha:Cells(i-linha, 3):Value
             ch-planilha:Cells(i-linha, 4):Value
             ch-planilha:Cells(i-linha, 5):Value.*/

        ASSIGN c-ds = TRIM(ch-planilha:Cells(i-linha, 1):VALUE).

        FIND FIRST tt-depara
            WHERE tt-depara.ds-item = c-ds NO-ERROR.
        IF NOT AVAIL tt-depara THEN DO:
            CREATE tt-depara.
            ASSIGN tt-depara.ds-item = c-ds.
            DISP tt-depara.ds-item FORMAT "X(50)".
            UPDATE tt-depara.cd-item
                   tt-depara.multiplicador.
        END.

        IF tt-depara.cd-item > 0 THEN DO:
            FIND FIRST item NO-LOCK
                WHERE item.cd-item = tt-depara.cd-item NO-ERROR.
            IF AVAIL item THEN DO:
                FIND FIRST tt-it
                    WHERE tt-it.cd-compra = compra.cd-compra
                    AND   tt-it.cd-item = tt-depara.cd-item NO-ERROR.
                IF NOT AVAIL tt-it THEN DO:
                    CREATE tt-it.
                    ASSIGN tt-it.cd-compra = compra.cd-compra
                           tt-it.cd-item = tt-depara.cd-item
                           tt-it.ds-item = item.ds-item
                           tt-it.vl-total = ch-planilha:Cells(i-linha, 5):VALUE
                           tt-it.quantidade = ch-planilha:Cells(i-linha, 3):VALUE * tt-depara.multiplicador.
                END.
                ELSE DO:
                    ASSIGN tt-it.vl-total = tt-it.vl-total + ch-planilha:Cells(i-linha, 5):VALUE
                           tt-it.quantidade = tt-it.quantidade + (ch-planilha:Cells(i-linha, 3):VALUE * tt-depara.multiplicador).
                END.
                ASSIGN tt-it.vl-unitario = (tt-it.vl-total / tt-it.quantidade).
            END.
        END.

    END.
    ELSE DO:
        LEAVE.
    END.

END.

OS-DELETE VALUE("C:/Maickel/MHMoney/deparaitens.d").
OUTPUT TO VALUE("C:/Maickel/MHMoney/deparaitens.d").
FOR EACH tt-depara
    WHERE tt-depara.cd-item > 0:
    EXPORT tt-depara.
END.
OUTPUT CLOSE.

IF CAN-FIND(FIRST tt-it
            WHERE tt-it.cd-item = 0) THEN DO:
    MESSAGE "Existe algum item ainda nÆo associado. NÆo foi poss¡vel gerar os itens da compra..."
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.
ELSE DO:
    FOR EACH tt-it:
        DISP tt-it.cd-item
             tt-it.ds-item FORMAT "X(28)"
             tt-it.quantidade
             tt-it.vl-unitario FORMAT ">,>>9.99"
             tt-it.vl-total FORMAT ">,>>9.99"
            WITH WIDTH 500.
        FIND FIRST item-compra OF compra EXCLUSIVE-LOCK
            WHERE item-compra.cd-item = tt-it.cd-item NO-ERROR.
        IF NOT AVAIL item-compra THEN DO:
            CREATE item-compra.
            ASSIGN item-compra.cd-compra = compra.cd-compra
                   item-compra.cd-item = tt-it.cd-item.
        END.

        ASSIGN item-compra.quantidade = tt-it.quantidade
               item-compra.vl-unitario = tt-it.vl-unitario
               item-compra.vl-total = tt-it.vl-total.

    END.
END.

ch-Excel:QUIT.
RELEASE OBJECT ch-Excel NO-ERROR.
