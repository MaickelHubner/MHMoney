&IF "{2}" = "" &THEN
ASSIGN {&Table}.{1}:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = fnLista{1}().
&ELSE
ASSIGN {2}:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = fnLista{1}().
&ENDIF
