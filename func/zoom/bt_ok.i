RUN som.p(INPUT "music\click.wav").  
ASSIGN pReturn = ROWID({&Table}).
APPLY "CLOSE":U TO THIS-PROCEDURE.
RETURN "OK".

