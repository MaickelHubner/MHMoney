DEFINE VARIABLE cVersion AS CHARACTER  NO-UNDO.
INPUT FROM VALUE(SEARCH("version")) CONVERT TARGET "ibm850".
REPEAT:
    IMPORT UNFORMATTED cVersion.
    IF ENTRY(1,ENTRY(2,cVersion," " ),".") = "{1}" THEN
        ASSIGN CURRENT-WINDOW:TITLE = ENTRY(2,cVersion,"%") + " - " + ENTRY(3,cVersion," ") + " - " + CAPS(ENTRY(1,ENTRY(2,cVersion," " ),".")).            
END.
INPUT CLOSE.

IF gcUsuario <> "" THEN DO:
    FIND FIRST usuario-prog 
        WHERE usuario-prog.nome = gcUsuario
        AND   usuario-prog.programa = "{1}.W" NO-LOCK NO-ERROR.
    IF NOT AVAIL usuario-prog THEN DO:
        FIND FIRST usuario-prog 
            WHERE usuario-prog.nome = gcUsuario
            AND   usuario-prog.programa = "{1}.P" NO-LOCK NO-ERROR.
        IF NOT AVAIL usuario-prog THEN DO:
            FIND FIRST usuario-prog 
                WHERE usuario-prog.nome = gcUsuario
                AND   usuario-prog.programa = "{1}.I" NO-LOCK NO-ERROR.
        END.
    END.
    IF AVAIL usuario-prog THEN DO:
        HIDE C-Win.
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Erro (017)', INPUT 'Usu†rio sem permiss∆o!', INPUT 'Usu†rio n∆o tem permiss∆o para executar o programa ' + '{1}' + '. Verifique as restriá‰es do usu†rio.')"}
        RETURN NO-APPLY.
    END.
END.

ON ALT-BACKSPACE ANYWHERE 
DO:
    FIND FIRST usuario NO-LOCK
        WHERE usuario.nome = gcUsuario NO-ERROR.
    IF AVAIL usuario
        AND usuario.administrador THEN DO:
        {func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Informaá‰es (016)', INPUT 'Informaá‰es do campo:', INPUT 'Nome: ' + SELF:NAME + CHR(10) + 'Tipo: ' + SELF:DATA-TYPE + CHR(10) + 'Formato: ' + SELF:FORMAT)"}
    END.
END.
