@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "BASE=%~dp0"
set "OUTPUT=%BASE%데이터 삭제 후"
set /a COUNT=0
set /a SUCCESS=0
set /a FAILED=0

where exiftool >nul 2>&1
if errorlevel 1 (
    echo.
    echo [오류] ExifTool을 찾을 수 없습니다.
    echo ExifTool을 설치한 뒤 명령 프롬프트를 새로 열거나 컴퓨터를 다시 시작해주세요.
    echo.
    pause
    exit /b 1
)

if not exist "%OUTPUT%\" mkdir "%OUTPUT%"

echo.
echo 이미지 메타데이터 제거를 시작합니다.
echo 원본 폴더: %BASE%
echo 출력 폴더: %OUTPUT%
echo.

for %%E in (png jpg jpeg webp bmp tif tiff) do (
    for %%F in ("%BASE%*.%%E") do (
        if exist "%%~fF" (
            set /a COUNT+=1
            echo [!COUNT!] %%~nxF

            copy /Y "%%~fF" "%OUTPUT%\%%~nxF" >nul
            if errorlevel 1 (
                echo     복사 실패
                set /a FAILED+=1
            ) else (
                exiftool -all= -overwrite_original_in_place "%OUTPUT%\%%~nxF" >nul 2>&1
                if errorlevel 1 (
                    echo     메타데이터 제거 실패
                    set /a FAILED+=1
                ) else (
                    echo     완료
                    set /a SUCCESS+=1
                )
            )
        )
    )
)

echo.
if !COUNT! EQU 0 (
    echo 처리할 이미지가 없습니다.
    echo 이 CMD 파일과 같은 폴더에 이미지를 넣어주세요.
) else (
    echo 작업 완료: !SUCCESS!개 성공, !FAILED!개 실패
    echo 결과 위치: %OUTPUT%
)
echo.
pause
endlocal
