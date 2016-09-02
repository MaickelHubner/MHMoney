set DLC=c:\dlc101a
set PROMSG=c:\dlc101a\promsgs

copy C:\Maickel\MHMoney\util\progress.cfg c:\dlc101a

cd c:\Maickel\MHMOney\database\Maickel

c:\dlc101a\bin\_mprosrv.exe -db c:\Maickel\MHMOney\database\Maickel\money.db -S 65500 -L 5000 -B 2000 -n 3 -Mm 4096 
