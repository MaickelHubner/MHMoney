DEFINE VARIABLE deMaximWD AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deMaximWE AS DECIMAL     NO-UNDO.
DEFINE VARIABLE hAux AS HANDLE      NO-UNDO.
DEFINE VARIABLE hTemp AS HANDLE      NO-UNDO.
DEFINE VARIABLE deAltAux AS DECIMAL     NO-UNDO.
DEFINE VARIABLE iContOb AS INTEGER     NO-UNDO.
DEFINE VARIABLE deRowMax AS DECIMAL     NO-UNDO.
DEFINE VARIABLE deAltMax AS DECIMAL     NO-UNDO.

ASSIGN FRAME {&Frame}:SCROLLABLE = FALSE
       FRAME {&Frame}:HIDDEN = TRUE.

FOR EACH tt-objects:
    ASSIGN hAux = tt-objects.hnd.
    ASSIGN hAux:COLUMN = 2.5
           hAux:WIDTH = 1.
    ASSIGN hAux:ROW = 1.5
           hAux:HEIGHT = 6.
END.

IF  CAN-FIND(FIRST tt-objects
             WHERE tt-objects.layout-horizontal = "Esquerda"
             AND   NOT tt-objects.sobrepoe)
AND CAN-FIND(FIRST tt-objects
             WHERE tt-objects.layout-horizontal = "Direita"
             AND   NOT tt-objects.sobrepoe) THEN DO:
    ASSIGN deMaximWD = ({&Window}:WIDTH / 2) - 2.25
           deMaximWE = deMaximWD.
END.
ELSE DO:
    ASSIGN deMaximWD = {&Window}:WIDTH - 2.25
           deMaximWE = deMaximWD.
END.
ASSIGN FRAME {&Frame}:WIDTH = {&Window}:WIDTH
       FRAME {&Frame}:HEIGHT = {&Window}:HEIGHT
       deRowMax = {&Window}:HEIGHT + 0.5.

&IF DEFINED(MinWidthD) &THEN
IF deMaximWD < {&MinWidthD} THEN
    ASSIGN deMaximWE = deMaximWE - ({&MinWidthD} - deMaximWD)
           deMaximWD = {&MinWidthD}.
&ENDIF
&IF DEFINED(MinWidthE) &THEN
IF deMaximWE < {&MinWidthE} THEN
    ASSIGN deMaximWD = deMaximWD - ({&MinWidthE} - deMaximWE)
           deMaximWE = {&MinWidthE}.
&ENDIF

/* Objetos Mestres */
FOR EACH tt-objects
    WHERE NOT VALID-HANDLE(tt-objects.objeto-alinhamento):
    ASSIGN hAux = tt-objects.hnd.

    CASE tt-objects.layout-horizontal:
        WHEN "Esquerda" THEN DO:
            IF tt-objects.muda-tamanho THEN DO:
                ASSIGN hAux:WIDTH = deMaximWE.
            END.
        END.
        WHEN "Direita" THEN DO:
            IF tt-objects.muda-tamanho THEN DO:
                ASSIGN hAux:COLUMN = deMaximWE + 4
                       hAux:WIDTH = deMaximWD.
            END.
            ELSE DO:
                ASSIGN hAux:COLUMN = {&Window}:WIDTH - tt-objects.width-original.
            END.
        END.
    END CASE.

END.

/* Acerta Width */
FOR EACH tt-objects:
    ASSIGN hAux = tt-objects.hnd.
    IF NOT tt-objects.muda-tamanho THEN DO:
        ASSIGN hAux:WIDTH = tt-objects.width-original.
    END.
END.

/* Objetos Dependentes */
FOR EACH tt-objects
    WHERE VALID-HANDLE(tt-objects.objeto-alinhamento):
    ASSIGN hAux = tt-objects.hnd
           hTemp = tt-objects.objeto-alinhamento.

    CASE tt-objects.layout-horizontal:
        WHEN "Alinhado Esquerda Com" THEN DO:
            ASSIGN hAux:COLUMN = hTemp:COLUMN.
            IF tt-objects.muda-tamanho THEN DO:
                ASSIGN hAux:WIDTH = deMaximWD.
            END.
        END.
        WHEN "Alinhado Direita Com" THEN DO:
            ASSIGN hAux:COLUMN = hTemp:COLUMN + hTemp:WIDTH - hAux:WIDTH.
            IF tt-objects.muda-tamanho THEN DO:
                ASSIGN hAux:WIDTH = deMaximWD.
            END.
        END.
        WHEN "A Direita de" THEN DO:
            ASSIGN hAux:COLUMN = hTemp:COLUMN + hTemp:WIDTH + 0.1.
            IF tt-objects.muda-tamanho THEN DO:
                ASSIGN hAux:WIDTH = deMaximWD.
            END.
        END.
    END CASE.

END.

/* Acerta Height */
FOR EACH tt-objects:
    ASSIGN hAux = tt-objects.hnd.
    IF NOT tt-objects.muda-altura THEN DO:
        ASSIGN hAux:HEIGHT = tt-objects.height-original.
    END.
END.

/* Muda Altura */
ASSIGN deAltAux = deRowMax
       iContOb = 0.
FOR EACH tt-objects
    WHERE tt-objects.layout-horizontal = "Esquerda"
    AND   tt-objects.visivel:

    IF NOT tt-objects.muda-altura THEN DO:
        ASSIGN hAux = tt-objects.hnd.
        ASSIGN deAltAux = deAltAux - hAux:HEIGHT - 0.5.
    END.
    ELSE DO:
        ASSIGN iContOb = iContOb + 1
               deAltAux = deAltAux - 1.
    END.

END.
FOR EACH tt-objects
    WHERE tt-objects.muda-altura
    AND   tt-objects.layout-horizontal = "Esquerda":

    ASSIGN hAux = tt-objects.hnd.

    /*ASSIGN hAux:HEIGHT = ((deAltAux - (iContOb * 1.5)) / iContOb).*/
    ASSIGN hAux:HEIGHT = (deAltAux / iContOb).

END.

/* Muda Altura */
ASSIGN deAltAux = deRowMax + 0.5
       iContOb = 0.
FOR EACH tt-objects
    WHERE tt-objects.layout-horizontal = "Direita"
    AND   tt-objects.visivel:

    IF NOT tt-objects.muda-altura THEN DO:
        ASSIGN hAux = tt-objects.hnd.
        ASSIGN deAltAux = deAltAux - hAux:HEIGHT - 0.5.
    END.
    ELSE DO:
        ASSIGN iContOb = iContOb + 1
               deAltAux = deAltAux - 1.
    END.

END.
FOR EACH tt-objects
    WHERE tt-objects.muda-altura
    AND   tt-objects.layout-horizontal = "Direita":

    ASSIGN hAux = tt-objects.hnd.

    /*ASSIGN hAux:HEIGHT = ((deAltAux - (iContOb * 1.5)) / iContOb).*/
    ASSIGN hAux:HEIGHT = (deAltAux / iContOb).

END.

/* Muda Posicionamento Vertical */
FOR EACH tt-objects:
    ASSIGN hAux = tt-objects.hnd.

    CASE tt-objects.layout-vertical:
        WHEN "Baixo" THEN DO:
            ASSIGN hAux:ROW = deRowMax - hAux:HEIGHT.
        END.
        WHEN "Topo" THEN DO:
            ASSIGN hAux:ROW = 1.5.
        END.
    END CASE.

END.

/* Objetos Dependentes */
FOR EACH tt-objects USE-INDEX idx-seq
    WHERE VALID-HANDLE(tt-objects.objeto-superior):
    ASSIGN hAux = tt-objects.hnd
           hTemp = tt-objects.objeto-superior.

    CASE tt-objects.layout-vertical:
        WHEN "Abaixo de" THEN DO:
            ASSIGN hAux:ROW = hTemp:ROW + hTemp:HEIGHT + 0.5.
        END.
    END CASE.

END.

FOR EACH tt-objects:

    ASSIGN hAux = tt-objects.hnd.

    IF tt-objects.mantem-linha THEN
        ASSIGN hAux:ROW = tt-objects.row-original.

    IF tt-objects.mantem-coluna THEN
        ASSIGN hAux:COLUMN = tt-objects.column-original.

    IF tt-objects.margem-direita <> 0 THEN
        ASSIGN hAux:COLUMN = hAux:COLUMN - tt-objects.margem-direita.

    IF tt-objects.margem-inferior <> 0 THEN
        ASSIGN hAux:ROW = hAux:ROW - tt-objects.margem-inferior.

    IF tt-objects.acerta-tamanho <> 0 THEN
        ASSIGN hAux:HEIGHT = hAux:HEIGHT + tt-objects.acerta-tamanho.

END.

ASSIGN FRAME {&Frame}:HIDDEN = FALSE.
