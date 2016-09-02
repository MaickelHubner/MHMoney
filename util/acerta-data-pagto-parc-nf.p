for each parc-nota-fiscal EXCLUSIVE-LOCK:
    if parc-nota-fiscal.dt-pagto-parc = ? then
        assign parc-nota-fiscal.dt-pagto-parc = parc-nota-fiscal.dt-parcela.
end.
