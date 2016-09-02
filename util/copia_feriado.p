DEFINE BUFFER bf-fer FOR feriado.
DEFINE VARIABLE c-desc AS CHARACTER FORMAT "X(60)"  NO-UNDO.

FOR EACH feriado NO-LOCK
    WHERE YEAR(feriado.dt-feriado) = 2014:

    CREATE bf-fer.
    BUFFER-COPY feriado EXCEPT dt-feriado TO bf-fer.
    ASSIGN bf-fer.dt-feriado = DATE(MONTH(feriado.dt-feriado), DAY(feriado.dt-feriado), YEAR(feriado.dt-feriado) + 1).
    DISP bf-fer.ds-feriado @ c-desc.
    UPDATE bf-fer.dt-feriado.

END.
