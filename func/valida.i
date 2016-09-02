{func\run.i &Programa = "func\msg.w (INPUT 1, INPUT 'Valida‡Æo (003)', INPUT '{&Mensagem}', INPUT '{&Ajuda}')"}
&IF DEFINED(DescFrame) <> 0 &THEN
    ASSIGN sl-frame:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "{&DescFrame}".
    APPLY "VALUE-CHANGED":U TO sl-frame IN FRAME {&FRAME-NAME}.
&ENDIF
&IF DEFINED(Campo) <> 0 &THEN
    APPLY "ENTRY":U TO {&Campo} IN FRAME {&FRAME-NAME}.
&ENDIF
RETURN "NOK":U.

