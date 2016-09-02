/* Atualiza Descri‡Æo do Item */
FOR EACH pedido-item:
    IF pedido-item.ds-pedido-item = "" THEN DO:
        FIND FIRST item OF pedido-item NO-LOCK NO-ERROR.
        IF AVAIL item THEN
            ASSIGN pedido-item.ds-pedido-item = item.ds-item.
    END.
END.

FOR EACH apontamento NO-LOCK:

    FIND FIRST pedido-item OF apontamento NO-LOCK NO-ERROR.
    FIND FIRST item OF pedido-item NO-LOCK NO-ERROR.
    IF item.cd-item = 14 /* Administrativo */ THEN NEXT.

    FIND FIRST pedido OF apontamento NO-ERROR.
    IF AVAIL pedido THEN DO:
        IF pedido.situacao = 9 /* Cancelado */ THEN NEXT.

        /* Calcula Data Aprova‡Æo */
        IF pedido.dt-aprovacao = ?
        OR apontamento.data < pedido.dt-aprovacao THEN
            ASSIGN pedido.dt-aprovacao = apontamento.data.

        /* Calcula Data LiberacÆo Homologa‡Æo */
        IF pedido.situacao >= 3 /* Atendido */ THEN DO:
            IF pedido.dt-lib-homolog = ?
            OR apontamento.data > pedido.dt-lib-homolog THEN
                ASSIGN pedido.dt-lib-homolog = apontamento.data
                       pedido.dt-encerramento = apontamento.data + 30.
        END.
    END.

END.
