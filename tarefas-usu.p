DEFINE VARIABLE cResp AS CHARACTER   NO-UNDO INITIAL "Richard".
DEFINE VARIABLE cFav AS CHARACTER COLUMN-LABEL "Cliente"  NO-UNDO.
    
FORM tarefa.dt-real-fim
     cFav
     tarefa.ds-tarefa
    WITH STREAM-IO WIDTH 80 NO-BOX DOWN FRAME f.

FORM tarefa.dt-alert-tarefa
     cFav
     tarefa.ds-tarefa
    WITH STREAM-IO WIDTH 80 NO-BOX DOWN FRAME f2.

OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "tar-resp.txt") CONVERT TARGET "iso8859-1".

PUT UNFORMATTED "CONCLUÖDAS éLTIMOS 7 DIAS" SKIP(2).

FOR EACH tarefa
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-real-fim >= (TODAY - 7)
    AND   tarefa.situacao = 8 /* Conclu¡da */
    BY tarefa.dt-real-fim:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.

    DISP tarefa.dt-real-fim
         favorecido.ds-fav @ cFav
         tarefa.ds-tarefa
        WITH FRAME f.
    DOWN WITH FRAME f.

END.

PUT UNFORMATTED SKIP(2) "CANCELADAS NOS éLTIMOS 7 DIAS" SKIP(2).

FOR EACH tarefa
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-alert-tarefa >= (TODAY - 7)
    AND   tarefa.situacao = 9
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.

    DISP tarefa.dt-alert-tarefa
         favorecido.ds-fav @ cFav
         tarefa.ds-tarefa
        WITH FRAME f2.
    DOWN WITH FRAME f2.

END.

PUT UNFORMATTED SKIP(2) "ATRASADAS" SKIP(2).

FOR EACH tarefa
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-alert-tarefa < TODAY
    AND   tarefa.situacao < 8
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.

    DISP tarefa.dt-alert-tarefa
         favorecido.ds-fav @ cFav
         tarefa.ds-tarefa
        WITH FRAME f2.
    DOWN WITH FRAME f2.

END.

PUT UNFORMATTED SKIP(2) "PENDENTES" SKIP(2).

FOR EACH tarefa
    WHERE tarefa.responsavel = cResp
    AND   tarefa.dt-alert-tarefa >= TODAY
    AND   tarefa.situacao < 8
    BY tarefa.dt-alert-tarefa:

    FIND FIRST favorecido OF tarefa NO-LOCK NO-ERROR.

    DISP tarefa.dt-alert-tarefa
         favorecido.ds-fav @ cFav
         tarefa.ds-tarefa
        WITH FRAME f2.
    DOWN WITH FRAME f2.

END.

OUTPUT CLOSE.
