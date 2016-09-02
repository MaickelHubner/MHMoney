FIND FIRST tt-objects WHERE tt-objects.nome = "{&Objeto}" NO-LOCK NO-ERROR.
IF NOT AVAIL tt-objects THEN DO:

    CREATE tt-objects.
    ASSIGN tt-objects.sequencia = iSeqObjMaxim
           tt-objects.nome = "{&Objeto}"
           tt-objects.layout-horizontal = "{&LayoutH}"
           tt-objects.layout-vertical = "{&LayoutV}"
           tt-objects.nome-frame = "{&Frame}"
           tt-objects.muda-tamanho = (IF "{&MudaTamanho}" <> "NÆo" THEN YES ELSE NO)
           tt-objects.muda-altura = (IF "{&MudaAltura}" <> "NÆo" THEN YES ELSE NO)
           tt-objects.visivel = (IF "{&Visivel}" <> "NÆo" THEN YES ELSE NO)
           tt-objects.sobrepoe = (IF "{&Sobrepoe}" <> "Sim" THEN NO ELSE YES)
           tt-objects.mantem-linha = (IF "{&MantemLinha}" <> "Sim" THEN NO ELSE YES)
           tt-objects.mantem-coluna = (IF "{&MantemColuna}" <> "Sim" THEN NO ELSE YES)
           tt-objects.centraliza-h = (IF "{&CentralizaH}" <> "Sim" THEN NO ELSE YES)
           iSeqObjMaxim = iSeqObjMaxim + 1.

    &IF "{&MargemDireita}" <> "" &THEN
    ASSIGN tt-objects.margem-direita = {&MargemDireita}.
    &ENDIF
    &IF "{&MargemInferior}" <> "" &THEN
    ASSIGN tt-objects.margem-inferior = {&MargemInferior}.
    &ENDIF
    &IF "{&AcertaTamanho}" <> "" &THEN
    ASSIGN tt-objects.acerta-tamanho = {&AcertaTamanho}.
    &ENDIF
           
    &IF "{&Frame}" <> "" &THEN
        ASSIGN tt-objects.hnd = {&Objeto}:HANDLE IN FRAME {&Frame}.
        &IF "{&ObjAlin}" <> "" &THEN
        ASSIGN tt-objects.objeto-alinhamento = {&ObjAlin}:HANDLE IN FRAME {&Frame}.
        &ENDIF
        &IF "{&ObjSup}" <> "" &THEN
        &IF "{&FrameSup}" = "" &THEN
        ASSIGN tt-objects.objeto-superior = {&ObjSup}:HANDLE IN FRAME {&Frame}.
        &ELSE
        ASSIGN tt-objects.objeto-superior = {&ObjSup}:HANDLE.
        &ENDIF
        &ENDIF
    &ELSE
        ASSIGN tt-objects.hnd = {&Objeto}:HANDLE.
        &IF "{&ObjAlin}" <> "" &THEN
        ASSIGN tt-objects.objeto-alinhamento = {&ObjAlin}:HANDLE.
        &ENDIF
        &IF "{&ObjSup}" <> "" &THEN
        &IF "{&FrameSup}" = "" &THEN
        ASSIGN tt-objects.objeto-superior = {&ObjSup}:HANDLE.
        &ELSE
        ASSIGN tt-objects.objeto-superior = {&ObjSup}:HANDLE IN FRAME {&FrameSup}.
        &ENDIF
        &ENDIF
    &ENDIF

    ASSIGN tt-objects.width-original = tt-objects.hnd:WIDTH
           tt-objects.row-original = tt-objects.hnd:ROW
           tt-objects.column-original = tt-objects.hnd:COLUMN
           tt-objects.height-original = tt-objects.hnd:HEIGHT.

END.
