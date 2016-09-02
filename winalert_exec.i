ASSIGN tt-alerta.parametros = REPLACE(tt-alerta.parametros,"TODAY",STRING(TODAY,"99/99/9999")).

ASSIGN cParamRelat = tt-alerta.parametros.
ASSIGN C-Win:TOP-ONLY = NO.
RUN VALUE(tt-alerta.programa).
APPLY "ENTRY" TO C-Win.


