FUNCTION fnIntToB36 RETURNS CHAR (iNum AS INTEGER):

    DEFINE VARIABLE cB36 AS CHARACTER   NO-UNDO.

    DEFINE VARIABLE i-num AS INTEGER     NO-UNDO EXTENT 7.
    DEFINE VARIABLE i-aux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.

    ASSIGN i-num[1] = iNum MOD 36
           i-aux = iNum.

    REPEAT i = 2 TO 7:
        IF i-aux > 35 THEN DO:
            ASSIGN i-aux = (i-aux - i-num[i - 1]) / 36
                   i-num[i] = i-aux MOD 36.
        END.
    END.

    REPEAT i = 7 TO 1 BY -1:
        IF i-num[i] < 10 THEN
            ASSIGN cB36 = cB36 + STRING(i-num[i],"9").
        ELSE
            ASSIGN cB36 = cB36 + CHR(i-num[i] + 55).
    END.

    RETURN cB36.

END FUNCTION.

FUNCTION fnB36ToInt RETURNS INTEGER (cB36 AS CHARACTER):

    DEFINE VARIABLE iNum AS INTEGER     NO-UNDO.
    
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    DEFINE VARIABLE c-aux AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i-aux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-exp AS INTEGER     NO-UNDO.

    ASSIGN i-exp = LENGTH(cB36) - 1.

    REPEAT i = 1 TO LENGTH(cB36):

        ASSIGN c-aux = SUBSTRING(cB36, i, 1).

        IF ASC(c-aux) < 65 THEN
            ASSIGN i-aux = INT(c-aux).
        ELSE
            ASSIGN i-aux = ASC(c-aux) - 55.

        ASSIGN iNum = iNum + (i-aux * DEC(EXP(36, i-exp)))
               i-exp = i-exp - 1.

    END.

    RETURN iNum.

END FUNCTION.

FUNCTION ConvChar
RETURNS CHARACTER
  ( cChar AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.

    IF ASC(cChar) < 32 THEN RETURN "".
    IF ASC(cChar) > 126 AND ASC(cChar) < 161 THEN RETURN "".

    IF ASC(cChar) < 127 THEN DO:
        ASSIGN cReturn = STRING((ASC(cChar) - 31),"999").
    END.
    ELSE DO:
        ASSIGN cReturn = STRING((ASC(cChar) - 60),"999").
    END.

    RETURN cReturn.

END FUNCTION.

FUNCTION DesConvChar
RETURNS CHARACTER
  ( iLetra AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.

    IF iLetra < 100 THEN DO:
        ASSIGN iLetra = iLetra + 31.
    END.
    ELSE DO:
        ASSIGN iLetra = iLetra + 60.
    END.

    ASSIGN cReturn = CHR(iLetra).

    RETURN cReturn.

END FUNCTION.

FUNCTION RegChar
RETURNS CHARACTER
  ( iAsc AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE iResto AS INTEGER    NO-UNDO.

    IF iAsc <= 0 THEN RETURN "&".

    IF iAsc > 36 THEN DO:
        ASSIGN iResto = iAsc MOD 36.
    END.
    ELSE DO:
        ASSIGN iResto = iAsc.
    END.

    ASSIGN iResto = iResto + 1.

    IF iResto < 11 THEN DO:
        ASSIGN cReturn = CHR(iResto + 47).
    END.
    ELSE DO:
        ASSIGN cReturn = CHR(iResto + 54).
    END.

    RETURN cReturn.

END FUNCTION.

FUNCTION Converte
RETURNS CHARACTER
  ( cCampo AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.

    REPEAT iCont = 1 TO LENGTH(cCampo):
        ASSIGN cReturn = cReturn + ConvChar(SUBSTRING(cCampo,iCont,1)).
    END.

    RETURN cReturn.

END FUNCTION.

FUNCTION Desconverte
RETURNS CHARACTER
  ( iEntrada AS INTEGER, cChave AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE iCont AS INTEGER    NO-UNDO.
    DEFINE VARIABLE iLetra AS INTEGER    NO-UNDO.
    DEFINE VARIABLE cPalavra AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER    NO-UNDO INITIAL 1.
    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.

    REPEAT iCont = 1 TO LENGTH(cChave) BY 3:
        ASSIGN iLetra = INT(SUBSTRING(cChave,iCont,3)).
        IF iLetra <> 300 THEN DO:
            ASSIGN cPalavra = cPalavra + DesconvChar(iLetra).
        END.
        ELSE DO:
            IF iAux = iEntrada THEN DO:
                RETURN cPalavra.
            END.
            ELSE DO:
                ASSIGN cPalavra = ""
                       iAux = iAux + 1.
            END.
        END.
    END.

    IF iAux = iEntrada THEN DO:
        RETURN cPalavra.
    END.
    ELSE DO:
        RETURN "Erro!".
    END.


END FUNCTION.

FUNCTION NumRegistroMoney
RETURNS CHARACTER
  ( iEntrada AS INTEGER, cChave AS CHARACTER, dtValidade AS DATE, cControle AS CHAR, iPerfil AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cUsuario AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cConta   AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cFav     AS CHARACTER  NO-UNDO.

    DEFINE VARIABLE cNum AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i-con AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-let AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cVal AS CHARACTER   NO-UNDO.

    ASSIGN cUsuario = Desconverte(1,cChave)
           cConta   = Desconverte(2,cChave)
           cFav     = Desconverte(3,cChave)
           cVal     = fnIntToB36(dtValidade - DATE(7,27,2009)).

    ASSIGN OVERLAY(cVal, 1, 1) = STRING(iPerfil, "9").

    ASSIGN OVERLAY(cNum, 32, 1) = cControle.
    IF ASC(cControle) < 65 THEN
        ASSIGN i-con = INT(cControle).
    ELSE
        ASSIGN i-con = ASC(cControle) - 55.

    ASSIGN iAux = 0.
    REPEAT i-let = 1 TO 31:
        ASSIGN iAux = iAux + i-con.
        REPEAT:
            IF iAux > 31 THEN
                ASSIGN iAux = iAux - 31.
            IF iAux < 32 AND SUBSTRING(cNum, iAux, 1) = "" THEN 
                LEAVE.
            ELSE
                ASSIGN iAux = iAux + 1.
        END.
        IF i-let <= 8 /* Usu rio */ THEN DO:
            ASSIGN OVERLAY(cNum, iAux, 1) = RegChar(ASC(SUBSTRING(cUsuario,i-let,1))).
        END.
        ELSE DO:
            IF i-let <= 16 /* Conta */ THEN DO:
                ASSIGN OVERLAY(cNum, iAux, 1) = RegChar(ASC(SUBSTRING(cConta,(i-let - 8),1))).
            END.
            ELSE DO:
                IF i-let <= 24 /* Favorecido */ THEN DO:
                    ASSIGN OVERLAY(cNum, iAux, 1) = RegChar(ASC(SUBSTRING(cFav,(i-let - 16),1))).
                END.
                ELSE DO: /* Validade */
                    ASSIGN OVERLAY(cNum, iAux, 1) = SUBSTRING(cVal,(i-let - 24),1).
                END.
            END.
        END.
    END.

    IF iEntrada = 0 THEN
        RETURN cNum.
    ELSE
        RETURN SUBSTRING(cNum, ((iEntrada * 4) - 3), 4).

END FUNCTION.

FUNCTION ValidaRegMoney
RETURNS CHARACTER
  ( iEntrada AS INTEGER, cValor AS CHARACTER, cRegistro AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
        1 - Usu rio
        2 - Conta
        3 - Favorecido
        4 - Data
        5 - Perfil
------------------------------------------------------------------------------*/

    DEFINE VARIABLE cReturn AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cControle AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i-con AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iAux AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i-let AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cUsuario AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cConta   AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cFav     AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE cVal AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE iData AS INTEGER     NO-UNDO.

    ASSIGN cValor = SUBSTRING(cValor, 1, 8).
    REPEAT iData = 1 TO 8:
        ASSIGN OVERLAY(cValor, iData, 1) = RegChar(ASC(SUBSTRING(cValor,iData,1))).
    END.

    ASSIGN cControle = SUBSTRING(cRegistro, 32, 1).
    IF ASC(cControle) < 65 THEN
        ASSIGN i-con = INT(cControle).
    ELSE
        ASSIGN i-con = ASC(cControle) - 55.

    ASSIGN iAux = 0.
    REPEAT i-let = 1 TO 31:
        ASSIGN iAux = iAux + i-con.
        REPEAT:
            IF iAux > 31 THEN
                ASSIGN iAux = iAux - 31.
            IF iAux < 32 AND SUBSTRING(cRegistro, iAux, 1) <> "" THEN 
                LEAVE.
            ELSE
                ASSIGN iAux = iAux + 1.
        END.
        IF i-let <= 8 /* Usu rio */ THEN DO:
            ASSIGN OVERLAY(cUsuario,i-let,1) = SUBSTRING(cRegistro, iAux, 1).
        END.
        ELSE DO:
            IF i-let <= 16 /* Conta */ THEN DO:
                ASSIGN OVERLAY(cConta,(i-let - 8),1) = SUBSTRING(cRegistro, iAux, 1).
            END.
            ELSE DO:
                IF i-let <= 24 /* Favorecido */ THEN DO:
                    ASSIGN OVERLAY(cFav,(i-let - 16),1) = SUBSTRING(cRegistro, iAux, 1).
                END.
                ELSE DO: /* Validade */
                    ASSIGN OVERLAY(cVal,(i-let - 24),1) = SUBSTRING(cRegistro, iAux, 1).
                END.
            END.
        END.
    END.

    ASSIGN cReturn = "NOK".
    CASE iEntrada:
        WHEN 1 THEN DO:
            IF cValor = cUsuario THEN
                ASSIGN cReturn = "OK".
        END.
        WHEN 2 THEN DO:
            IF cValor = cConta THEN
                ASSIGN cReturn = "OK".
        END.
        WHEN 3 THEN DO:
            IF cValor = cFav THEN
                ASSIGN cReturn = "OK".
        END.
        WHEN 4 THEN DO:
            ASSIGN cVal = SUBSTRING(cVal, 1, 7)
                   OVERLAY(cVal, 1, 1) = "0"
                   iData = fnB36ToInt(cVal)
                   cReturn = STRING(DATE(7,27,2009) + iData, "99/99/9999").
        END.
        WHEN 5 THEN DO:
            ASSIGN cVal = SUBSTRING(cVal, 1, 1).
            IF cVal = "2" THEN
                ASSIGN cReturn = "Empresarial".
            ELSE
                ASSIGN cReturn = "Pessoal".
        END.
    END CASE.

    RETURN cReturn.

END FUNCTION.

