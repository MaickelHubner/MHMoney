def var chProgressBar       as com-handle no-undo.
DEFINE VARIABLE cProgRelat AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE glImplantar AS LOGICAL    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE gcFiltro AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hProgsMenu AS HANDLE     NO-UNDO EXTENT 200.
DEFINE NEW GLOBAL SHARED VARIABLE iProgsCont AS INTEGER    NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE cParamRelat AS CHAR NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hLastWidget AS HANDLE     NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE gcFiltroIniFim AS CHARACTER  NO-UNDO.

ASSIGN cProgRelat = ENTRY(1,ENTRY(NUM-ENTRIES(THIS-PROCEDURE:FILE-NAME,"\"),THIS-PROCEDURE:FILE-NAME,"\"),".").

{seg.i}
