&IF DEFINED(DefVar) = 0 &THEN
DEFINE VARIABLE rReturn AS ROWID      NO-UNDO.
DEFINE BUFFER bfz-{&Tabela} FOR {&Tabela}.
&ENDIF
ASSIGN glImplantar = YES.

&IF DEFINED(CampoFiltro1) <> 0 &THEN
    ASSIGN gcFiltro = "{&CampoFiltro1}," + STRING({&ValorFiltro1}).
    &IF DEFINED(CampoFiltro2) <> 0 &THEN
        ASSIGN gcFiltro = gcFiltro + ",{&CampoFiltro2}," + STRING({&ValorFiltro2}).
        &IF DEFINED(CampoFiltro3) <> 0 &THEN
            ASSIGN gcFiltro = gcFiltro + ",{&CampoFiltro3}," + STRING({&ValorFiltro3}).
        &ENDIF
    &ENDIF
&ELSE
    ASSIGN gcFiltro = "".
&ENDIF

&IF DEFINED(CampoFiltroIniFim1) <> 0 &THEN
    ASSIGN gcFiltroIniFim = "{&CampoFiltroIniFim1}," + STRING({&ValorFiltroIni1}) + "," + STRING({&ValorFiltroFim1}).
    &IF DEFINED(CampoFiltroIniFim2) <> 0 &THEN
        ASSIGN gcFiltroIniFim = gcFiltroIniFim + ",{&CampoFiltroIniFim2}," + STRING({&ValorFiltroIni2}) + "," + STRING({&ValorFiltroFim2}).
        &IF DEFINED(CampoFiltroIniFim3) <> 0 &THEN
            ASSIGN gcFiltroIniFim = gcFiltroIniFim + ",{&CampoFiltroIniFim3}," + STRING({&ValorFiltroIni3}) + "," + STRING({&ValorFiltroFim3}).
        &ENDIF
    &ENDIF
&ELSE
    ASSIGN gcFiltroIniFim = "".
&ENDIF

&IF "{&ProgramaZoom}" <> "" &THEN
    {func\run.i &Programa = "{&ProgramaZoom} (OUTPUT rReturn)"}
&ELSE
    {func\run.i &Programa = "zoom\z{&Tabela}.w (OUTPUT rReturn)"}
&ENDIF
    
IF RETURN-VALUE = "OK" THEN DO:
    FIND FIRST bfz-{&Tabela} NO-LOCK
        WHERE ROWID(bfz-{&Tabela}) = rReturn.
    ASSIGN {&Tela1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bfz-{&Tabela}.{&Campo1}).
    &IF DEFINED(Campo2) <> 0 &THEN
        ASSIGN {&Tela2}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bfz-{&Tabela}.{&Campo2}).
    &ENDIF
    &IF DEFINED(Campo3) <> 0 &THEN
        ASSIGN {&Tela3}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bfz-{&Tabela}.{&Campo3}).
    &ENDIF
    &IF DEFINED(Campo4) <> 0 &THEN
        ASSIGN {&Tela4}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bfz-{&Tabela}.{&Campo4}).
    &ENDIF
    &IF DEFINED(Campo5) <> 0 &THEN
        ASSIGN {&Tela5}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(bfz-{&Tabela}.{&Campo5}).
    &ENDIF
END.
&IF DEFINED(CampoFiltro1) <> 0 &THEN
    ASSIGN gcFiltro = "".
&ENDIF
