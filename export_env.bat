@echo off
set cid_main=0AAAAAAAAAAAAc
set env_maindemo=https://profiseecloud.com/demo_environment/
set exportfolder=C:\demoreset\export
set maindemo=C:\demoreset\Presales\MainDemo
set "clu=C:\Program Files\Profisee\Master Data Maestro Utilities\"
set version=23.2.0\
echo.
echo ------
echo.
echo Script to export sharable pre-sales demo environments and push to GitHub 
echo.
echo ------
echo.
echo.
echo Command Line Utility location:  %clu%%version%
echo.
echo.
echo Environment to be exported: %env_maindemo%
echo.
echo.
echo Starting exporting assets.
echo.
echo.
cd %clu%%version%
Profisee.MasterDataMaestro.Utilities.exe /URL:%env_maindemo% /EXPORT /TYPE:ALL /FILE:"%exportfolder%" /CLIENTID:%cid_main%
echo.
echo.
echo Export completed!
echo.
echo ------
echo.
echo Starting exporting data.
echo.
echo.
cd %clu%%version%
Profisee.MasterDataMaestro.Utilities.exe /URL:%env_maindemo% /ARCHIVEDATA /STRATEGY:AllData /TYPE:ALL /FILE:"%exportfolder%" /CLIENTID:%cid_main%
echo.
echo.
echo Export completed!
echo.
echo.
echo Cloning demo environment.
echo.
echo.
cd C:\demoreset
if exist %maindemo% (
	git pull
	) else (
	git clone https://github.com/demo/Presales.git
)
echo.
echo Navigating into git folder
echo.
cd Presales
echo Git Status 
git status
echo.
echo. Git Status completed.
echo.
echo.
echo. Moving files to Git folder
echo.
cp -f ../export/* MainDemo
git add .
git commit -m "Uploading files to MainDemo"
git push
echo.
echo. Done! All the files have been pushed to Github
echo.
echo.
echo Cleaning files.
rm -rf %exportfolder%/*
echo.
echo Done
