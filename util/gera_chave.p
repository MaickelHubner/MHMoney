DEFINE VARIABLE cChave AS CHARACTER  NO-UNDO INITIAL "".
DEFINE VARIABLE cNFinal AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cCFinal AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cFFinal AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
DEFINE VARIABLE iAsc AS INTEGER    NO-UNDO.
DEFINE VARIABLE cReg1 AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cReg2 AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cReg3 AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cReg4 AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cReg5 AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cReg6 AS CHARACTER  NO-UNDO.

REPEAT iCont = 1 TO LENGTH(ENTRY(1,cChave,"-")):

    ASSIGN iAsc = ASC(SUBSTRING(ENTRY(1,cChave,"-"),iCont,1)).
    ASSIGN iAsc = iAsc + 20.
    IF iAsc >= 256 THEN
        ASSIGN iAsc = iAsc - 256.

    ASSIGN cNFinal = cNFinal + CHR(iAsc).

END.
REPEAT iCont = 1 TO LENGTH(ENTRY(2,cChave,"-")):

    ASSIGN iAsc = ASC(SUBSTRING(ENTRY(2,cChave,"-"),iCont,1)).
    ASSIGN iAsc = iAsc + 20.
    IF iAsc >= 256 THEN
        ASSIGN iAsc = iAsc - 256.

    ASSIGN cCFinal = cCFinal + CHR(iAsc).

END.
REPEAT iCont = 1 TO LENGTH(ENTRY(3,cChave,"-")):

    ASSIGN iAsc = ASC(SUBSTRING(ENTRY(3,cChave,"-"),iCont,1)).
    ASSIGN iAsc = iAsc + 20.
    IF iAsc >= 256 THEN
        ASSIGN iAsc = iAsc - 256.

    ASSIGN cFFinal = cFFinal + CHR(iAsc).

END.
ASSIGN cNFinal = CAPS(REPLACE(cNFinal,"œ","-"))
       cCFinal = CAPS(REPLACE(cCFinal,"œ","-"))
       cFFinal = CAPS(REPLACE(cFFinal,"œ","-")).

MESSAGE cNFinal SKIP cCFinal SKIP cFFinal
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

REPEAT iCont = 1 TO 8:

    ASSIGN iAsc = ASC(SUBSTRING(cNFinal,iCont,1)).
    ASSIGN iAsc = iAsc - 10.
    IF iAsc < 65 THEN
        ASSIGN iAsc = iAsc - 7.
    IF iAsc < 48 THEN
        ASSIGN iAsc = iAsc + 43.
    IF iAsc = 25 THEN
        ASSIGN iAsc = ASC("?").

    IF iCont MOD 2 = 1 THEN
        ASSIGN cReg1 = cReg1 + CHR(iAsc).
    ELSE
        ASSIGN cReg2 = cReg2 + CHR(iAsc).

END.
REPEAT iCont = 1 TO 8:

    ASSIGN iAsc = ASC(SUBSTRING(cCFinal,iCont,1)).
    ASSIGN iAsc = iAsc - 10.
    IF iAsc < 65 THEN
        ASSIGN iAsc = iAsc - 7.
    IF iAsc < 48 THEN
        ASSIGN iAsc = iAsc + 43.
    IF iAsc = 25 THEN
        ASSIGN iAsc = ASC("?").
    IF iAsc = 58 THEN
        ASSIGN iAsc = ASC("@").

    IF iCont MOD 2 = 1 THEN
        ASSIGN cReg3 = cReg3 + CHR(iAsc).
    ELSE
        ASSIGN cReg4 = cReg4 + CHR(iAsc).

END.
REPEAT iCont = 1 TO 8:

    ASSIGN iAsc = ASC(SUBSTRING(cFFinal,iCont,1)).
    ASSIGN iAsc = iAsc - 10.
    IF iAsc < 65 THEN
        ASSIGN iAsc = iAsc - 7.
    IF iAsc < 48 THEN
        ASSIGN iAsc = iAsc + 43.
    IF iAsc = 25 THEN
        ASSIGN iAsc = ASC("?").
    IF iAsc = 58 THEN
        ASSIGN iAsc = ASC("@").

    IF iCont MOD 2 = 1 THEN
        ASSIGN cReg5 = cReg5 + CHR(iAsc).
    ELSE
        ASSIGN cReg6 = cReg6 + CHR(iAsc).

END.

MESSAGE cReg1 SKIP cReg2 SKIP cReg3 SKIP cReg4 SKIP cReg5 SKIP cReg6
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

