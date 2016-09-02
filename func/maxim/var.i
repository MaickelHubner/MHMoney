DEFINE TEMP-TABLE tt-objects
    FIELD sequencia AS INT
    FIELD nome AS CHAR
    FIELD nome-frame AS CHAR
    FIELD layout-horizontal AS CHAR
    FIELD layout-vertical AS CHAR
    FIELD muda-tamanho AS LOGICAL
    FIELD muda-altura AS LOGICAL
    FIELD objeto-alinhamento AS HANDLE
    FIELD objeto-superior AS HANDLE
    FIELD width-original AS DECIMAL
    FIELD height-original AS DECIMAL
    FIELD row-original AS DECIMAL
    FIELD column-original AS DECIMAL
    FIELD visivel AS LOGICAL
    FIELD sobrepoe AS LOGICAL
    FIELD centraliza-h AS LOGICAL
    FIELD mantem-linha AS LOGICAL
    FIELD mantem-coluna AS LOGICAL
    FIELD hnd AS HANDLE
    FIELD margem-direita AS DECIMAL
    FIELD margem-inferior AS DECIMAL
    FIELD acerta-tamanho AS DECIMAL
    INDEX idx-seq sequencia
    INDEX idx-nome nome.

DEFINE BUFFER bfObjAux FOR tt-objects.

DEFINE VARIABLE iSeqObjMaxim AS INTEGER     NO-UNDO INITIAL 1.
