DEFINE INPUT PARAMETER cUser AS CHARACTER  NO-UNDO.
DEFINE INPUT PARAMETER cPass AS CHARACTER  NO-UNDO.
DEFINE INPUT PARAMETER cDir AS CHARACTER  NO-UNDO.

DISABLE TRIGGERS FOR LOAD OF usuario.
DISABLE TRIGGERS FOR LOAD OF param-mn.

CREATE usuario.
ASSIGN usuario.nome = cUser
       usuario.senha = cPass
       usuario.administrador = YES.

CREATE param-mn.
ASSIGN param-mn.prod-dir = cDir
       param-mn.sincroniza = NO.
