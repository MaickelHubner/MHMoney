DEFINE BUFFER bf-pedido FOR pedido.

/* Ant */
FIND FIRST pedido EXCLUSIVE-LOCK
  WHERE pedido.nr-pedido = 133.

/* Pai */
FIND FIRST bf-pedido NO-LOCK
  WHERE bf-pedido.nr-pedido = 125.
    
BUFFER-COPY bf-pedido EXCEPT nr-pedido dt-pedido val-total situacao nr-controle TO pedido
ASSIGN pedido.nr-pedido-ant = bf-pedido.nr-pedido
       pedido.val-itens     = 0
       pedido.val-impostos  = 0
       pedido.val-desconto  = 0
       pedido.pc-impto      = 0.

