DEFINE OUTPUT PARAMETER r-Temp AS ROWID.
FIND FIRST agenda NO-LOCK WHERE agenda.cd-agenda = integer("171") NO-ERROR.
IF AVAIL agenda THEN
    ASSIGN r-Temp = ROWID(agenda).
ELSE
    ASSIGN r-Temp = ?.
