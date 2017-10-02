DEFINE INPUT  PARAMETER rItem AS ROWID      NO-UNDO.

DEFINE VARIABLE dtAnt AS DATE       NO-UNDO INITIAL ?.
DEFINE VARIABLE deQuant AS DECIMAL    NO-UNDO.
DEFINE VARIABLE iDias AS INTEGER    NO-UNDO.

FIND FIRST item EXCLUSIVE-LOCK
    WHERE ROWID(item) = rItem.

ASSIGN item.reposicao = 0.

FOR EACH compra NO-LOCK
    WHERE CAN-FIND(FIRST item-compra OF compra
                       WHERE item-compra.cd-item = item.cd-item)
    BY compra.dt-compra:

    FIND FIRST item-compra OF compra NO-LOCK
        WHERE item-compra.cd-item = item.cd-item.

    IF dtAnt <> ? THEN DO:

        ASSIGN iDias = compra.dt-compra - dtAnt.
        IF item.reposicao <> 0 THEN
            ASSIGN item.reposicao = ((item.reposicao + (iDias / deQuant)) / 2).
        ELSE
            ASSIGN item.reposicao = iDias / deQuant.

    END.

    ASSIGN dtAnt = compra.dt-compra
           deQuant = item-compra.quantidade.

END.
