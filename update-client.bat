@echo off
echo ==========================================
echo RozgarMap Quiz Portal - File Updater
echo ==========================================
echo.

REM Check if we're in the client directory
if not exist "src\main.jsx" (
    echo ERROR: Please run this from the client directory!
    echo Current: %cd%
    pause
    exit /b 1
)

echo [1/3] Backing up old files...
if not exist "backup" mkdir backup
copy src\index.css backup\
copy tailwind.config.js backup\
copy src\pages\*.jsx backup\
copy src\components\*.jsx backup\

echo [2/3] Copying new modern files...
REM These paths assume the new zip is extracted to Downloads\rozgar-quiz-portal-new
set "NEWDIR=C:\Users\maghf\Downloads\rozgar-quiz-portal-new\client"

copy "%NEWDIR%\src\index.css" src\
copy "%NEWDIR%\tailwind.config.js" .\
copy "%NEWDIR%\src\pages\HomePage.jsx" src\pages\
copy "%NEWDIR%\src\pages\QuizSetup.jsx" src\pages\
copy "%NEWDIR%\src\pages\QuizPage.jsx" src\pages\
copy "%NEWDIR%\src\pages\ResultPage.jsx" src\pages\
copy "%NEWDIR%\src\pages\AdminLogin.jsx" src\pages\
copy "%NEWDIR%\src\components\Navbar.jsx" src\components\
copy "%NEWDIR%\src\components\Footer.jsx" src\components\
copy "%NEWDIR%\src\components\Modal.jsx" src\components\
copy "%NEWDIR%\src\components\LoadingSpinner.jsx" src\components\

echo [3/3] Installing dependencies...
call npm install

echo.
echo ==========================================
echo DONE! Files updated successfully.
echo ==========================================
echo.
echo To start the app:
echo   npm run dev
echo.
pause
