FIND FIRST param-mn NO-LOCK NO-ERROR.
IF AVAIL param-mn
AND param-mn.perfil = 2 /* Empresarial */ THEN
    RUN menu-emp.w.
ELSE
    RUN menu.w.
