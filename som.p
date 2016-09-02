DEFINE INPUT  PARAMETER cSound AS CHARACTER  NO-UNDO.

&GLOB SND_ASYNC 1
&GLOB SND_NODEFAULT 2
&GLOB SND_LOOP 8
&GLOB SND_PURGE 64
&GLOB SND_APPLICATION 128
&GLOB SND_ALIAS 65536
&GLOB SND_FILENAME 131072
&GLOB SND_RESOURCE 262148
 
DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.
DEFINE VARIABLE szSound     AS MEMPTR  NO-UNDO.
DEFINE VARIABLE lFundo AS LOGICAL    NO-UNDO INITIAL YES.

PROCEDURE PlaySoundA EXTERNAL "winmm.dll" PERSISTENT :
  DEFINE INPUT PARAMETER  pszSound    AS LONG.
  DEFINE INPUT PARAMETER  hmod        AS LONG.
  DEFINE INPUT PARAMETER  fdwSound    AS LONG.
  DEFINE RETURN PARAMETER ReturnValue AS LONG.
END PROCEDURE.

IF SUBSTRING(cSound,1,1) = "#" THEN DO:
    ASSIGN cSound = REPLACE(cSound,"#","")
           lFundo = NO.
END.

IF SEARCH(cSound) = ? THEN
    ASSIGN cSound = SEARCH("music\padrao.wav").

SET-SIZE(szSound) = LENGTH(cSound, "raw":U) + 1.
PUT-STRING(szSound,1) = cSound.

IF lFundo THEN DO:
    RUN PlaySoundA (GET-POINTER-VALUE(szSound),
                    0,
                    {&SND_FILENAME} + {&SND_ASYNC} + {&SND_NODEFAULT},
                    OUTPUT ReturnValue).
END.
ELSE DO:
    RUN PlaySoundA (GET-POINTER-VALUE(szSound), 
                    0, 
                    {&SND_FILENAME},
                    OUTPUT ReturnValue). 
END.

SET-SIZE(szSound) = 0.
