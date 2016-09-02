DEFINE TEMP-TABLE tt-pend
    FIELD dt-pend AS DATE
    FIELD tipo AS CHAR FORMAT "X(8)"
    FIELD ds-pend AS CHAR FORMAT "X(80)"
    FIELD cd-favorecido LIKE favorecido.cd-favorecido
    FIELD ds-observacao AS CHAR FORMAT "X(2000)"
    INDEX idx dt-pend.

