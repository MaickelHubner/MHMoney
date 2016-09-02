DEFINE VARIABLE cFiltroFields AS CHARACTER  NO-UNDO.
DEFINE VARIABLE iContFil AS INTEGER    NO-UNDO.
DEFINE VARIABLE cTempFil AS CHARACTER  NO-UNDO.

  IF glImplantar THEN
      ENABLE btImp WITH FRAME {&FRAME-NAME}.
  ELSE
      DISABLE btImp WITH FRAME {&FRAME-NAME}.

  IF NOT CAN-FIND(FIRST tt-filtro) THEN DO:

      ASSIGN cTempFil = TRIM("{&CamposFiltro}").

      REPEAT iContFil = 1 TO LENGTH(cTempFil):

          IF ASC(SUBSTRING(cTempFil,iContFil,1)) <> 32 THEN
              ASSIGN cFiltroFields = cFiltroFields + SUBSTRING(cTempFil,iContFil,1).
          ELSE
              IF ASC(SUBSTRING(cTempFil,(iContFil + 1),1)) <> 32 THEN
                  ASSIGN cFiltroFields = cFiltroFields + ",".

      END.

      REPEAT iContFil = 1 TO NUM-ENTRIES(cFiltroFields):
          CREATE tt-filtro.
          ASSIGN tt-filtro.orig = ENTRY(iContFil,cFiltroFields).
          FIND FIRST _file NO-LOCK
              WHERE _file._file-name = "{&Table}" NO-ERROR.
          IF AVAIL _file THEN DO:
              FIND FIRST _field NO-LOCK
                  WHERE _field._file-recid = RECID(_file)
                  AND   _field._field-name = ENTRY(iContFil,cFiltroFields) NO-ERROR.
              IF AVAIL _field THEN DO:
                  ASSIGN tt-filtro.campo = _field._label + " Inicial"
                         tt-filtro.tipo  = _field._data-type
                         tt-filtro.formato = _field._format.
                  CREATE tt-filtro.
                  ASSIGN tt-filtro.campo = _field._label + " Final"
                         tt-filtro.orig = ENTRY(iContFil,cFiltroFields)
                         tt-filtro.tipo  = _field._data-type
                         tt-filtro.formato = _field._format.
              END.
              ELSE
                  ASSIGN tt-filtro.campo = ENTRY(iContFil,cFiltroFields).
          END.
      END.

      FOR EACH tt-filtro:
          CASE ENTRY(NUM-ENTRIES(tt-filtro.campo," "),tt-filtro.campo," "):
              WHEN "Inicial" THEN DO:
                  CASE tt-filtro.tipo:
                      WHEN "CHARACTER" THEN ASSIGN tt-filtro.valor = STRING("",tt-filtro.formato).
                      WHEN "INTEGER"   THEN ASSIGN tt-filtro.valor = STRING(0,tt-filtro.formato).
                      WHEN "DECIMAL"   THEN ASSIGN tt-filtro.valor = STRING(0,tt-filtro.formato).
                      WHEN "DATE"      THEN ASSIGN tt-filtro.valor    = "01010001".
                      WHEN "LOGICAL"   THEN ASSIGN tt-filtro.valor = "NO".
                  END CASE.
              END.
              WHEN "Final" THEN DO:
                  CASE tt-filtro.tipo:
                      WHEN "CHARACTER" THEN ASSIGN tt-filtro.valor = FILL("Z",INT(ENTRY(1,ENTRY(2,tt-filtro.formato,"("),")"))).
                      WHEN "INTEGER"   THEN ASSIGN tt-filtro.valor = FILL("9",LENGTH(REPLACE(REPLACE(REPLACE(tt-filtro.formato,".",""),",",""),"-",""))).
                      WHEN "DECIMAL"   THEN ASSIGN tt-filtro.valor = FILL("9",LENGTH(REPLACE(REPLACE(REPLACE(tt-filtro.formato,".",""),",",""),"-",""))).
                      WHEN "DATE"      THEN ASSIGN tt-filtro.valor = "31129999".
                      WHEN "LOGICAL"   THEN ASSIGN tt-filtro.valor = "YES".
                  END CASE.
              END.
          END CASE.
      END.

      IF gcFiltro <> "" OR gcFiltroIniFim <> "" THEN DO:
          IF gcFiltro <> "" THEN DO:
              REPEAT iContFil = 1 TO (NUM-ENTRIES(gcFiltro) / 2):
                  FOR EACH tt-filtro
                      WHERE tt-filtro.orig = ENTRY(((2 * (iContFil - 1)) + 1),gcFiltro):
                      CASE tt-filtro.tipo:
                          WHEN "CHARACTER" THEN ASSIGN tt-filtro.valor = ENTRY((2 * iContFil),gcFiltro).
                          WHEN "INTEGER"   THEN ASSIGN tt-filtro.valor = STRING(INT(ENTRY((2 * iContFil),gcFiltro)),tt-filtro.formato).
                          WHEN "DECIMAL"   THEN ASSIGN tt-filtro.valor = STRING(DEC(ENTRY((2 * iContFil),gcFiltro)),tt-filtro.formato).
                          WHEN "DATE"      THEN ASSIGN tt-filtro.valor = ENTRY((2 * iContFil),gcFiltro).
                          WHEN "LOGICAL"   THEN ASSIGN tt-filtro.valor = ENTRY((2 * iContFil),gcFiltro).
                      END CASE.
                  END.
              END.
          END.
          IF gcFiltroIniFim <> "" THEN DO:
              REPEAT iContFil = 1 TO (NUM-ENTRIES(gcFiltroIniFim) / 3):
                  FOR EACH tt-filtro
                      WHERE tt-filtro.orig = ENTRY(((2 * (iContFil - 1)) + 1),gcFiltroIniFim):
                      IF ENTRY(NUM-ENTRIES(tt-filtro.campo," "),tt-filtro.campo," ") = "Inicial" THEN DO:
                          CASE tt-filtro.tipo:
                              WHEN "CHARACTER" THEN ASSIGN tt-filtro.valor = ENTRY((2 * iContFil),gcFiltroIniFim).
                              WHEN "INTEGER"   THEN ASSIGN tt-filtro.valor = STRING(INT(ENTRY((2 * iContFil),gcFiltroIniFim)),tt-filtro.formato).
                              WHEN "DECIMAL"   THEN ASSIGN tt-filtro.valor = STRING(DEC(ENTRY((2 * iContFil),gcFiltroIniFim)),tt-filtro.formato).
                              WHEN "DATE"      THEN ASSIGN tt-filtro.valor = ENTRY((2 * iContFil),gcFiltroIniFim).
                              WHEN "LOGICAL"   THEN ASSIGN tt-filtro.valor = ENTRY((2 * iContFil),gcFiltroIniFim).
                          END CASE.
                      END.
    
                      IF ENTRY(NUM-ENTRIES(tt-filtro.campo," "),tt-filtro.campo," ") = "Final" THEN DO:
                         CASE tt-filtro.tipo:
                              WHEN "CHARACTER" THEN ASSIGN tt-filtro.valor = ENTRY((3 * iContFil),gcFiltroIniFim).
                              WHEN "INTEGER"   THEN ASSIGN tt-filtro.valor = STRING(INT(ENTRY((3 * iContFil),gcFiltroIniFim)),tt-filtro.formato).
                              WHEN "DECIMAL"   THEN ASSIGN tt-filtro.valor = STRING(DEC(ENTRY((3 * iContFil),gcFiltroIniFim)),tt-filtro.formato).
                              WHEN "DATE"      THEN ASSIGN tt-filtro.valor = ENTRY((3 * iContFil),gcFiltroIniFim).
                              WHEN "LOGICAL"   THEN ASSIGN tt-filtro.valor = ENTRY((3 * iContFil),gcFiltroIniFim).
                          END CASE.
                      END.
                  END.
              END.
          END.
          RUN openQuery IN THIS-PROCEDURE.
      END.

  END.
