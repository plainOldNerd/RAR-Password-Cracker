@echo off

set startTime=%time%

REM Set the file to extract and where to extract to
set file=d:\desktop\20161109.rar
set extractTo=d:\desktop\batshit\
set passwordFile=d:\desktop\batshit\password.txt

REM These two variables are constant!
set charSet=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!"#$%%'(*+,-./:;=@[\]_`{}~
set /a lastCharIndex=86

REM Start the actual algorithm
set pwd=%charSet:~0,1%
set /a length=1
REM "ph" is short for placeholder. The zero'th place is the right-most char 
REM in the pwd string. The value of ph[pwdIndex] tells us what char in the 
REM charSet string the pwdIndex'th char (from right to left) is
set /a ph[0]=0

cd c:\program files\winrar

:startLoop
echo currently testing password %pwd% > %passwordFile%
unrar e -ad -p%pwd% %file% %extractTo%
if %errorlevel% equ 0 ( goto :finishedLoop )

set /a pwdIndex=0
set continueLoop=t

:startPwdInc

if %pwdIndex% neq %length% (

  setlocal enabledelayedexpansion

  if !ph[%pwdIndex%]! equ %lastCharIndex% (
    endlocal
    goto :condition1
  ) else (
    endlocal
    goto :condition2
  )
  endlocal
) else (
    goto :condition3
)

:condition1
REM We haven't reached the left-most end of pwd but the current char is the 
REM last char in charSet
set /a ph[%pwdIndex%]=0
call :updatePwd
set /a pwdIndex+=1
goto :startPwdInc

:condition2
REM We haven't reached the left-most end of pwd and the current char is NOT 
REM the last char in charSet
set /a ph[%pwdIndex%]+=1
call :updatePwd
goto :startLoop
pause

:condition3
REM We have reached the left-most end of pwd
set pwd=%charSet:~0,1%%pwd%
set /a length+=1
if %length% equ 128 (goto :failed)
goto :startLoop

:finishedLoop

pause

echo The password is %pwd% > %passwordFile%

set endTime=%time%
set /a startVal=(1%startTime:~0,2%-100)*360000 + (1%startTime:~3,2%-100)*6000 + (1%startTime:~6,2%-100)*100 + (1%startTime:~9,2%-100)
set /a endVal=(1%endTime:~0,2%-100)*360000 + (1%endTime:~3,2%-100)*6000 + (1%endTime:~6,2%-100)*100 + (1%endTime:~9,2%-100)
set /a timeTaken=%endVal%-%startVal%
echo The time taken was %timeTaken% centiseconds, >> %passwordFile%

set /a hoursTaken=%timeTaken%/360000
set /a minutesTaken=(%timeTaken%-%hoursTaken%*360000)/6000
set /a secondsTaken=(%timeTaken%-%hoursTaken%*360000-%minutesTaken%*6000)/100
set /a millisecondsTaken=%timeTaken%-%hoursTaken%*360000-%minutesTaken%*6000-%secondsTaken%*100

echo or %hoursTaken%:%minutesTaken%:%secondsTaken%.%millisecondsTaken% >> %passwordFile%

exit /b 0

:failed
echo After such a long time, I'm sorry that the password contains a character that can't be tested! See the readme file. > %passwordFile%
exit /b 0

:updatePwd
REM This method ONLY updates one char of the pwd at a time. In the case of zzz, 
REM for example, it will need to be run 3 times!
setlocal enabledelayedexpansion

set /a a=%length%-%pwdIndex%-1
set /a b=!ph[%pwdIndex%]!
set /a c=%length%-%pwdIndex%

set newPwd=!pwd:~0,%a%!!charSet:~%b%,1!!pwd:~%c%,%pwdIndex%!
endlocal & (
  set pwd=%newPwd%
)
exit /b 0