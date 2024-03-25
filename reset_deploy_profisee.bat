@echo off
set cid_main=08AAAAAAAAAAc
set env_maindemo=https://profiseecloud.com/demo/ 
set maindemo=C:\demoreset\Presales\MainDemo
set "clu=C:\Program Files\Profisee\Master Data Maestro Utilities\"
set version=23.2.0\
set git_location=C:\demoreset\Presales
echo.
echo ------
echo.
echo Script to reset sharable pre-sales demo environments from GitHub 
echo.
echo ------
cd %git_location%
if exist %maindemo% (
	git pull
	) else (
	cd ..
	git clone https://github.com/Profisee/Presales.git
)
echo.
echo.
echo Command Line Utility location:  %clu%%version%
echo.
echo.
echo Environment to be exported: %env_maindemo%
echo.
echo.
echo Starting importing assets.
echo.
echo.
cd %clu%%version%
Profisee.MasterDataMaestro.Utilities.exe /URL:%env_maindemo% /CLIENTID:%cid_main% /IMPORT /TYPE:ALL /FILE:"%maindemo%" 
echo.
echo.
echo Import completed!
if "%errorlevel%"=="1" (
	Echo Success.
	) else (
	echo Import had errors.
	)
echo.
echo ------
echo.
echo Starting deploying data.
echo.
echo.
cd %clu%%version%
Profisee.MasterDataMaestro.Utilities.exe /URL:%env_maindemo% /CLIENTID:%cid_main% /DEPLOYDATA /FILE:"%maindemo%\AllData.archive" 
echo.
echo.
echo Deploy completed!
echo.
echo.
echo Done
cd %git_location%
