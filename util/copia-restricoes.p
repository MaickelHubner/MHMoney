DEFINE VARIABLE c-antigo AS CHARACTER   NO-UNDO INITIAL "Bruna".
DEFINE VARIABLE c-novo AS CHARACTER   NO-UNDO INITIAL "Carla".

DEFINE BUFFER bf-prog FOR usuario-prog.

FOR EACH usuario-prog
    WHERE usuario-prog.nome = c-antigo:

    CREATE bf-prog.
    BUFFER-COPY usuario-prog EXCEPT nome TO bf-prog.
    ASSIGN bf-prog.nome = c-novo.

    DISP bf-prog.
    PAUSE(0).

END.
