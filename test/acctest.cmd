@setlocal
@REM echo off
@REM execute all test cases of the accessibility test suite

@REM USER VARIABLES
@REM ##############
@REM set executable to be used
@set TIDY=..\build\cmake\Release\tidy5.exe
@REM set INPUT folder
@set TIDYINPUT=accessTest
@REM set OUTPUT folder
@set TIDYOUT=tmp
@REM set input test list file
@set TIDYIN=accesscases.txt
@set TIDYLOG=tempacc.txt
@REM ##############

@if NOT EXIST %TIDY% goto ERR1
@if NOT EXIST %TIDYINPUT%\cfg_default.txt goto ERR2
@if NOT EXIST %TIDYIN% goto ERR3
@REM Make sure output directory exists, or WARN of creation ...
@if EXIST %TIDYOUT%\nul goto RUNTEST
@echo	NOTE: Folder %TIDYOUT% does not exist. It will be created ...
@echo	Ctrl+C to abort ... any other keyin to continue ...
@pause
@md %TIDYOUT%
:RUNTEST
@echo Running ACCESS TEST suite
@echo Executable = %TIDY%
@echo Input Folder = %TIDYINPUT%
@echo Output Folder = %TIDYOUT%

@echo Running ACCESS TEST suite > %TIDYLOG%
@echo Executable = %TIDY% >> %TIDYLOG%
@echo Input Folder = %TIDYINPUT% >> %TIDYLOG%
@echo Output Folder = %TIDYOUT% >> %TIDYLOG%
@set FAILEDACC=
@for /F "skip=1 tokens=1,2*" %%i in (%TIDYIN%) do @(call onetesta.cmd %%i %%j %%k)
@if "%FAILEDACC%." == "." goto SUCCESS
@echo FAILED [%FAILEDACC%] ...
@goto END

:SUCCESS
@echo	Appears ALL tests ran fine ...
@goto END


:ERR1
@echo	ERROR: Unable to locate executable - [%TIDY%] - check name and location ...
@goto END

:ERR2
@echo	ERROR: Unable to locate input folder - [%TIDYINPUT%]! - check name and location ...
@echo	Specifically can not locate the file - [%TIDYINPUT%\cfg_default.txt] ...
@goto END

:ERR3
@echo	ERROR: Can not locate file - [%TIDYIN%] - check name and location ...
@goto END

:END
