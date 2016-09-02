RUN som.p(INPUT "music\click.wav").
IF pcActionBT = "ADD" THEN DO:
        DELETE {&Table}.
END.
ASSIGN pcActionBT = "".
APPLY "CLOSE" TO THIS-PROCEDURE.
RETURN "NOK".

