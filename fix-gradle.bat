@echo off
echo ========================================
echo   Fixing Gradle Build Issues
echo ========================================
echo.

echo [1/4] Stopping Gradle daemons...
cd android
call gradlew --stop
cd ..
echo.

echo [2/4] Cleaning Gradle cache...
rmdir /s /q %USERPROFILE%\.gradle\caches 2>nul
echo Gradle cache cleared
echo.

echo [3/4] Cleaning Flutter...
call flutter clean
echo.

echo [4/4] Getting dependencies...
call flutter pub get
echo.

echo ========================================
echo Ready to build!
echo ========================================
echo.
echo Now run: flutter build apk --release
echo.
pause

