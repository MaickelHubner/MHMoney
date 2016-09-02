define buffer bf-ped for pedido.

for each mov-conta EXCLUSIVE-LOCK
    where mov-conta.nr-pedido <> 0:

    find first pedido of mov-conta NO-LOCK.
    
    if pedido.nr-pedido-ant <> 0 then do:
        find first bf-ped where bf-ped.nr-pedido = pedido.nr-pedido-ant NO-LOCK no-error.
        if avail bf-ped then
            assign mov-conta.nr-pedido = bf-ped.nr-pedido.
        
        disp mov-conta except ds-obs.
    
    end.
    
end.
