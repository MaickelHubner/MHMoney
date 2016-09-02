&IF "{1}" = "sub-cat" &THEN
    &IF "{2}" = "CRE" &THEN
        FIND FIRST categoria WHERE categoria.cod-categoria = sub-cat.cod-categoria NO-LOCK NO-ERROR.
        IF NOT AVAIL categoria THEN DO:
            DELETE sub-cat.
            RETURN "NOK":U.
        END.
    &ENDIF
&ENDIF
