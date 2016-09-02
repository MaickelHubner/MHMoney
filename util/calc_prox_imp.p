DEFINE VARIABLE dtUltPagImpto AS DATE    NO-UNDO INITIAL 07/29/2016.
DEFINE VARIABLE de-total AS DECIMAL     NO-UNDO.

ASSIGN dtultPagImpto = DATE(MONTH(dtultPagImpto), 1, YEAR(dtultPagImpto)).

FOR EACH nota-fiscal-imp NO-LOCK
    WHERE nota-fiscal-imp.situacao = 1 /* Pendente */
    AND   INDEX("4,8,17,19", STRING(nota-fiscal-imp.cod-imposto)) <> 0,
    FIRST nota-fiscal OF nota-fiscal-imp
        WHERE nota-fiscal.dt-emissao >= (dtUltPagImpto - 31):

    ASSIGN de-total = de-total + nota-fiscal-imp.val-imposto.

END.

DISP de-total.
