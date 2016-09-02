xcopy C:\Maickel\MHMoney\*.xlsx E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.r E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.wrx E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.df E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.cur E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.ico E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.bmp E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.jpg E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.lst E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.txt E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.dll E:\MHMoney /E /R /Y /D
xcopy C:\Maickel\MHMoney\*.lst E:\MHMoney /E /R /Y /D
copy C:\Maickel\MHMoney\blat.exe E:\MHMoney\blat.exe
xcopy C:\Maickel\MHMoney\prog\*.* E:\MHMoney\prog /E /R /Y /D
xcopy C:\Maickel\MHMoney\manual\*.* E:\MHMoney\manual /E /R /Y /D
copy C:\Maickel\MHMoney\version E:\MHMoney\version
copy C:\Maickel\MHMoney\func\ProgressGL\*.dll E:\MHMoney\func\ProgressGL
del E:\MHMoney\image\bens\*.* /Q
copy E:\MHMoney\backup\arq.null E:\MHMoney\image\bens\arq.null
rmdir E:\MHMoney\backup /Q /S
rmdir E:\MHMoney\temp /Q /S
mkdir E:\MHMoney\backup
mkdir E:\MHMoney\temp
mkdir E:\MHMoney\music
xcopy C:\Maickel\MHMoney\music\*.* E:\MHMoney\music /E /R /Y /D
copy E:\MHMoney\image\bens\arq.null E:\MHMoney\backup\arq.null
copy E:\MHMoney\image\bens\arq.null E:\MHMoney\temp\arq.null
copy E:\MHMoney\image\bens\arq.null E:\MHMoney\lotes\arq.null
rmdir E:\MHMoney\campos /Q
rmdir E:\MHMoney\database\maickel /Q
rmdir E:\MHMoney\database\MHSoftware /Q
rmdir E:\MHMoney\database\dump /Q
del E:\MHMoney\database\lote\*.* /Q
rmdir E:\MHMoney\database\lote /Q
rmdir E:\MHMoney\func\cadastro /Q
rmdir E:\MHMoney\func\cript /S /Q
rmdir E:\MHMoney\func\detalhe /Q
rmdir E:\MHMoney\func\formation /Q
rmdir E:\MHMoney\func\graf /Q
rmdir E:\MHMoney\func\master_detail /Q
rmdir E:\MHMoney\func\pesq /Q
rmdir E:\MHMoney\func\relat /Q
rmdir E:\MHMoney\func\templates /Q
del E:\MHMoney\util\gera_chave.r /Q
del E:\MHMoney\mensagens.txt /Q
