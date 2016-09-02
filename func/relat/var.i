def var v_hora             as char                no-undo.
def var v_data             as date initial today format "99/99/9999" no-undo.
DEFINE VARIABLE iTotReg AS INTEGER    NO-UNDO.
DEFINE VARIABLE cVrsTmp AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cVersion AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cLinhaProg AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iContParam AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTempParam AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cParamFields AS CHARACTER  NO-UNDO.

&IF DEFINED(NoCont) = 0 &THEN
DEFINE VARIABLE iContReg AS INTEGER    NO-UNDO.
&ENDIF

ASSIGN INPUT FRAME {&FRAME-NAME} {&FrameFields}.
