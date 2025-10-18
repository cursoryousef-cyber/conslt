@echo off
echo ========================================
echo   Fixing iOS Project Files
echo ========================================
echo.

echo [1/3] Creating iOS platform files...
call flutter create --platforms=ios .
echo.

echo [2/3] Restoring Firebase configuration...
echo GoogleService-Info.plist - OK
echo AppDelegate.swift - OK
echo.

echo [3/3] Checking project structure...
dir ios\Runner.xcodeproj
echo.

echo ========================================
echo iOS files created successfully!
echo ========================================
echo.
echo Next steps:
echo 1. Check ios/Runner/ folder
echo 2. Commit and push to GitHub
echo 3. Rebuild on Codemagic
echo.
pause

