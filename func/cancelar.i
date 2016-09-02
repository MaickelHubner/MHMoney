FIND FIRST bf-{&Table} WHERE ROWID(bf-{&Table}) = ROWID({&Table}) NO-LOCK.
FIND PREV bf-{&Table} NO-LOCK NO-ERROR.
IF NOT AVAIL bf-{&Table} THEN DO:
    FIND FIRST bf-{&Table} 
        WHERE ROWID(bf-{&Table}) <> ROWID({&Table}) NO-LOCK NO-ERROR.
END.
FIND CURRENT {&Table} EXCLUSIVE-LOCK.
DELETE {&Table}.
IF AVAIL bf-{&Table} THEN DO:
    FIND FIRST {&Table} WHERE ROWID({&Table}) = ROWID(bf-{&Table}) NO-LOCK NO-ERROR.
END.
