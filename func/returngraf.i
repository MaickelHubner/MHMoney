DEFINE VARIABLE hProg AS HANDLE     NO-UNDO.

RUN {1} PERSISTENT SET hProg.

RUN setPersistent IN hProg.
RUN executaRelatorio IN hProg.
RUN getTTGraf IN hProg (OUTPUT TABLE tt-graf-par, OUTPUT TABLE tt-graf).
RUN closeProg IN hProg.

IF VALID-HANDLE(hProg) THEN
    DELETE PROCEDURE hProg.
