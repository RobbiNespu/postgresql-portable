@echo off
title PostgreSQL Portable
cls

:: set default code page
chcp 1252 > nul

set PGDATABASE=postgres
set PGPORT=5432
set PGUSER=postgres
set PGHOST=localhost
set PGHOSTADDR=127.0.0.1
set PGPASSWORD=postgres
set PGSQL=%PAL:AppDir%\PgSQL
set PGDATA=%PAL:DataDir%\data
set PGLOG=%PAL:DataDir%\log.txt
set PGLOCALEDIR=%PAL:AppDir%\PgSQL\share
set PATH=%PATH%;%PAL:AppDir%\PgSQL\bin
set PATH=%PATH%;%PAL:AppDir%\Perl\bin

echo.
echo Running on port %PGPORT%.

set PAL=%CD%
echo.
cd ..
cd data
echo Running on path %CD%.

:: initialise a new database on first use
if not exist "%PGDATA%" (
	echo.
	echo Initialising database for first use, please wait...
	"%PGSQL%\bin\initdb" -U %PGUSER% -A trust -E utf8 --locale=C >nul
)

:: startup postgres server
echo.
"%PGSQL%\bin\pg_ctl" -D "%PGDATA%" -l "%PGLOG%" -w start

