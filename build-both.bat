@echo off
echo ========================================
echo   Building Android APK and iOS Setup
echo ========================================
echo.

echo [Step 1/3] Fixing iOS project files...
call flutter create --platforms=ios .
echo.

echo [Step 2/3] Building Android APK...
call flutter build apk --release
echo.

echo [Step 3/3] Results...
echo.
echo ----------------------------------------
echo Android APK:
echo build\app\outputs\flutter-apk\app-release.apk
echo ----------------------------------------
echo.
echo iOS Project:
echo Ready for Codemagic build!
echo Push to GitHub and build on Codemagic.
echo.
echo ========================================
echo Build complete!
echo ========================================
pause

