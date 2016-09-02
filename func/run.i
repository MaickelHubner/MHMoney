&IF "{&Programa}" MATCHES("relat*") &THEN
ASSIGN cParamRelat = "".
&ENDIF
IF "{&Menu}" <> "YES" THEN DO:
    ASSIGN C-Win:SENSITIVE = NO.
    ASSIGN C-Win:TOP-ONLY = NO.
    RUN {&Programa}.
    ASSIGN C-Win:TOP-ONLY = YES.
    ASSIGN C-Win:SENSITIVE = YES.
    APPLY "ENTRY" TO C-Win.
END.
ELSE DO:
    ASSIGN C-Win:TOP-ONLY = NO.
    RUN {&Programa}.
    APPLY "ENTRY" TO C-Win.
END.
