DEFINE OUTPUT PARAMETER r-Temp AS ROWID.
FIND FIRST conta NO-LOCK WHERE conta.cd-conta = integer("8") NO-ERROR.
IF AVAIL conta THEN
    ASSIGN r-Temp = ROWID(conta).
ELSE
    ASSIGN r-Temp = ?.
