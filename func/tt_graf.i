DEFINE TEMP-TABLE tt-graf
    FIELD dado AS CHARACTER
    FIELD valor AS DECIMAL EXTENT 4
    FIELD seq AS INTEGER
    INDEX tdx-cod seq.

DEFINE TEMP-TABLE tt-graf-par
    FIELD dado-label AS CHARACTER
    FIELD valor-label AS CHARACTER EXTENT 4
    FIELD titulo AS CHARACTER
    FIELD mostra-valores AS LOGICAL EXTENT 4
    FIELD tipo AS INTEGER.
