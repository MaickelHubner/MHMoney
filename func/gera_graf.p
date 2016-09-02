DEFINE INPUT  PARAMETER cProg AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER cArq AS CHARACTER  NO-UNDO.
DEFINE INPUT  PARAMETER iX AS INTEGER    NO-UNDO.
DEFINE INPUT  PARAMETER iY AS INTEGER    NO-UNDO.

OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "err-money.txt").

{func\tt_graf.i}

{func\returngraf.i VALUE(cProg)}

RUN grafview.w PERSISTENT SET hProg (INPUT TABLE tt-graf-par, INPUT TABLE tt-graf).

RUN setPersistent IN hProg.
RUN geraGraf IN hProg (INPUT ("temp\" + cArq), INPUT iX, INPUT iY).
RUN closeProg IN hProg.

IF VALID-HANDLE(hProg) THEN
    DELETE PROCEDURE hProg.

OUTPUT CLOSE.
