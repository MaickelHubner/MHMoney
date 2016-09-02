DEFINE BUFFER bf-forma-pagto FOR forma-pagto.
DEFINE VARIABLE cCd-forma-pagto AS CHARACTER COLUMN-LABEL "Forma de Pagamento" FORMAT "X(40)" NO-UNDO.

FUNCTION fnListaCd-forma-pagto RETURNS CHARACTER:

    DEFINE VARIABLE cLista AS CHARACTER  NO-UNDO.

    FOR EACH bf-forma-pagto NO-LOCK:
        IF cLista <> "" THEN
            ASSIGN cLista = cLista + "," + bf-forma-pagto.ds-forma-pagto + "," + STRING(bf-forma-pagto.cd-forma-pagto).
        ELSE
            ASSIGN cLista = bf-forma-pagto.ds-forma-pagto + "," + STRING(bf-forma-pagto.cd-forma-pagto).
    END.
    IF cLista = "" THEN
        ASSIGN cLista = ",0".

    RETURN cLista.

END.

FUNCTION fnCd-forma-pagto RETURNS CHARACTER
    (INPUT iCod AS INTEGER):

    FIND FIRST bf-forma-pagto NO-LOCK
        WHERE bf-forma-pagto.Cd-forma-pagto = iCod NO-ERROR.
    IF AVAIL bf-forma-pagto THEN
        RETURN bf-forma-pagto.ds-forma-pagto.
    ELSE
        RETURN "".

END.

