RUN som.p(INPUT "music\click.wav").
FIND CURRENT {&TableSelect} EXCLUSIVE-LOCK.
DELETE {&TableSelect}.
RUN afterChange IN THIS-PROCEDURE NO-ERROR.
{&OPEN-QUERY-br-select}
{&OPEN-QUERY-br-disp}
RUN controlButtons IN THIS-PROCEDURE.

