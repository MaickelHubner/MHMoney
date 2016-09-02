FOR EACH tarefa
    WHERE tarefa.resp = "Maickel"
    AND   tarefa.dt-alert = 01/08/2014:

    FIND FIRST favorecido OF tarefa.
    DISP favorecido.ds-fav.
    DISP tarefa EXCEPT ds-observacao.

    UPDATE tarefa.dt-alert.

END.
