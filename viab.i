DEFINE TEMP-TABLE tt-calc-viab
    FIELD linha AS INT
    FIELD descricao AS CHAR FORMAT "X(80)"
    FIELD valor AS CHAR FORMAT "X(12)"
    INDEX idx IS PRIMARY UNIQUE linha.

