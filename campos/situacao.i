DEFINE VARIABLE cSituacao AS CHARACTER COLUMN-LABEL "Situa‡Æo" FORMAT "X(12)" NO-UNDO.

FUNCTION fnSituacao RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Pendente".
        WHEN 2 THEN RETURN "Iniciado".
        WHEN 3 THEN RETURN "Atendido".
        WHEN 4 THEN RETURN "Faturado".
        WHEN 5 THEN RETURN "Em Homologa‡Æo".
        WHEN 6 THEN RETURN "Em Garantia".
        WHEN 9 THEN RETURN "Cancelado".
        OTHERWISE RETURN "".
    END CASE.

END.

FUNCTION fnSituacaoParc RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Pendente".
        WHEN 2 THEN RETURN "Liquidada".
        OTHERWISE RETURN "".
    END CASE.

END.

FUNCTION fnSituacaoImp RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Pendente".
        WHEN 2 THEN RETURN "Retido".
        WHEN 3 THEN RETURN "Pago".
        OTHERWISE RETURN "".
    END CASE.

END.

FUNCTION fnSituacaoTarefa RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Pendente".
        WHEN 2 THEN RETURN "Em Andamento".
        WHEN 8 THEN RETURN "Concluida".
        WHEN 9 THEN RETURN "Cancelada".
        OTHERWISE RETURN "".
    END CASE.

END.

FUNCTION fnSituacaoOS RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Criada".
        WHEN 2 THEN RETURN "Atribu¡da".
        WHEN 3 THEN RETURN "Iniciada".
        WHEN 8 THEN RETURN "Concluida".
        WHEN 9 THEN RETURN "Cancelada".
        OTHERWISE RETURN "".
    END CASE.

END.

FUNCTION fnSituacaoVisita RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Planejada".
        WHEN 2 THEN RETURN "Confirmada".
        WHEN 8 THEN RETURN "Realizada".
        WHEN 9 THEN RETURN "Cancelada".
        OTHERWISE RETURN "".
    END CASE.

END.

FUNCTION fnSituacaoCompromisso RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    CASE iCod:
        WHEN 1 THEN RETURN "Planejado".
        WHEN 2 THEN RETURN "Confirmado".
        WHEN 8 THEN RETURN "Realizado".
        WHEN 9 THEN RETURN "Cancelado".
        OTHERWISE RETURN "".
    END CASE.

END.



