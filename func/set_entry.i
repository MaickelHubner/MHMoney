FIND FIRST usuario WHERE usuario.nome = gcUsuario NO-LOCK NO-ERROR.
IF AVAIL usuario THEN
    ASSIGN SELF:BGCOLOR = usuario.cor-campo
           hLastWidget = SELF:HANDLE.
ELSE
    ASSIGN SELF:BGCOLOR = 23
           hLastWidget = SELF:HANDLE.
