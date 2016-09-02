DEFINE BUFFER bf-fer FOR feriado.

FOR EACH bf-fer
    WHERE YEAR(bf-fer.dt-feriado) = 2014:

    CREATE feriado.
    BUFFER-COPY bf-fer EXCEPT dt-feriado TO feriado.
    ASSIGN feriado.dt-feriado = bf-fer.dt-feriado + 365.

    DISP feriado WITH WIDTH 200.
    UPDATE feriado.dt-feriado.

END.
