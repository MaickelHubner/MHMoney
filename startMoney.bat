cd\
cd windows\system32\drivers\etc
copy \\logi-maikelh\MHMoney\services.usr C:\WINDOWS\system32\drivers\etc\services.usr
type services.* >> services.dat
del services
ren services.dat services
