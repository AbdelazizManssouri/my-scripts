@echo off
rem Formatage de la date (AAAAMMJJ_HHMMSS)
set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~3,2%

rem Chemin vers le fichier de controle et le dossier source
set "CTL_PATH=C:\Users\Administrateur\Desktop\dpec_temp.ctl"
set "LOG_DIR=C:\Users\Administrateur\Desktop\dpec_temp\"
set "SRC_DIR=T:\"
set "HIST_DIR=C:\Users\Administrateur\Desktop\dpec_archiv\"

rem Execution : Boucle sur tous les fichiers CSV dans T:\
for %%f in ("%SRC_DIR%*.csv") do (
    echo [INFO] Traitement du fichier : %%f
    sqlldr dm/Dm$2025$2805$@prod control="%CTL_PATH%" data="%%f" log="%LOG_DIR%%%~nf_%TIMESTAMP%.log" bad="%LOG_DIR%%%~nf_%TIMESTAMP%.bad"
    
    rem Deplacer le fichier vers l'historique avec un nouveau nom horodate
    echo [INFO] Archivage de %%~nxf ...
    move /y "%%f" "%HIST_DIR%%%~nf_%TIMESTAMP%.csv"
)

echo [FIN] Importation et Archivage termines.
exit