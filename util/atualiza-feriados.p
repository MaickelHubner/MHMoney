DEFINE BUFFER bf-fer FOR feriado.

FOR EACH bf-fer
    WHERE YEAR(bf-fer.dt-feriado) = 2016:

    CREATE feriado.
    BUFFER-COPY bf-fer EXCEPT dt-feriado TO feriado.
    ASSIGN feriado.dt-feriado = DATE(MONTH(bf-fer.dt-feriado), DAY(bf-fer.dt-feriado), YEAR(bf-fer.dt-feriado) + 1).

    DISP feriado WITH WIDTH 200.
    UPDATE feriado.dt-feriado.

END.
