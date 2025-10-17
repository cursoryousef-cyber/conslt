@echo off
echo ========================================
echo     Doctor Consultation App Setup
echo ========================================
echo.

echo [1/3] Cleaning project...
call flutter clean
echo.

echo [2/3] Getting dependencies...
call flutter pub get
echo.

echo [3/3] Checking Flutter doctor...
call flutter doctor
echo.

echo ========================================
echo Setup complete!
echo ========================================
echo.
echo Next steps:
echo 1. Enable Firebase services in Console
echo 2. Run: flutter run
echo.
pause

