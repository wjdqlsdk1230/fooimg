@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "BASE=%~dp0"
set "OUTPUT=%BASE%번호 변환 후"
set "MISSING_FILE=%OUTPUT%\누락 목록.txt"
set /a SUCCESS=0
set /a FAILED=0
set /a MISSING=0

if not exist "%OUTPUT%\" mkdir "%OUTPUT%"
if exist "%MISSING_FILE%" del /Q "%MISSING_FILE%"

echo.
echo 파일명 번호 변환을 시작합니다.
echo 원본 폴더: %BASE%
echo 출력 폴더: %OUTPUT%
echo.

call :convert "기본" "01"
call :convert "미소" "02"
call :convert "신남" "03"
call :convert "슬픔" "04"
call :convert "오열" "05"
call :convert "짜증" "06"
call :convert "분노" "07"
call :convert "질투" "08"
call :convert "의문" "09"
call :convert "사랑" "10"
call :convert "머쓱" "11"
call :convert "당황" "12"
call :convert "놀람" "13"
call :convert "공포" "14"
call :convert "경멸" "15"
call :convert "유혹" "16"
call :convert "애교" "17"
call :convert "부끄러움" "18"
call :convert "비웃음" "19"
call :convert "우쭐" "20"
call :convert "의심" "21"
call :convert "졸림" "22"
call :convert "감탄" "23"
call :convert "두려움" "24"
call :convert "머리쓰다듬받기" "25"
call :convert "손잡기" "26"
call :convert "키스" "27"
call :convert "식사" "28"
call :convert "식사먹여주기" "29"
call :convert "디저트" "30"
call :convert "샤워" "31"
call :convert "샤워끝" "32"
call :convert "프로포즈" "33"
call :convert "웨딩드레스" "34"
call :convert "임신" "35"
call :convert "출산" "36"
call :convert "모유수유" "37"
call :convert "수영복" "38"
call :convert "수영복데이트" "39"
call :convert "온천" "40"
call :convert "메이드비키니" "41"
call :convert "젖소비키니" "42"
call :convert "전투준비" "43"
call :convert "전투공격" "44"
call :convert "전투방어" "45"
call :convert "전투부상" "46"
call :convert "전투패배" "47"
call :convert "임신섹스" "48"
call :convert "임신섹스사정" "49"
call :convert "알몸서빙" "50"
call :convert "도게자" "51"
call :convert "필로우토크" "52"
call :convert "삼각목마" "53"
call :convert "페이스시팅" "54"
call :convert "목줄채우기" "55"
call :convert "목줄알몸산책" "56"
call :convert "목줄섹스약" "57"
call :convert "목줄섹스강" "58"
call :convert "목줄섹스사정" "59"
call :convert "자위약" "60"
call :convert "자위절정" "61"
call :convert "69자세" "62"
call :convert "69자세사정" "63"
call :convert "핑거링" "64"
call :convert "핑거링절정" "65"
call :convert "파이즈리" "66"
call :convert "파이즈리사정" "67"
call :convert "수유대딸약" "68"
call :convert "수유대딸강" "69"
call :convert "수유대딸사정" "70"
call :convert "림잡" "71"
call :convert "펠라약" "72"
call :convert "펠라강" "73"
call :convert "펠라사정" "74"
call :convert "펠라사정보여주기" "75"
call :convert "정상위약" "76"
call :convert "정상위강" "77"
call :convert "정상위절정" "78"
call :convert "후배위약" "79"
call :convert "후배위강" "80"
call :convert "후배위절정" "81"
call :convert "측위약" "82"
call :convert "측위강" "83"
call :convert "측위사정" "84"
call :convert "기승위약" "85"
call :convert "기승위강" "86"
call :convert "기승위절정" "87"
call :convert "아마존프레스약" "88"
call :convert "아마존프레스강" "89"
call :convert "아마존프레스사정" "90"
call :convert "풀넬슨약" "91"
call :convert "풀넬슨강" "92"
call :convert "풀넬슨사정" "93"
call :convert "교배프레스약" "94"
call :convert "교배프레스강" "95"
call :convert "교배프레스사정" "96"
call :convert "들박약" "97"
call :convert "들박강" "98"
call :convert "들박사정" "99"
call :convert "풋잡" "100"
call :convert "풋잡사정" "101"
call :convert "핸드잡" "102"
call :convert "핸드잡사정" "103"
call :convert "애널후배위약" "104"
call :convert "애널후배위강" "105"
call :convert "애널후배위사정" "106"
call :convert "펨돔풋잡약" "107"
call :convert "펨돔풋잡강" "108"
call :convert "펨돔풋잡사정" "109"

echo.
if !SUCCESS! EQU 0 if !FAILED! EQU 0 (
    echo 변환할 파일이 없습니다.
    echo 이 CMD 파일과 같은 폴더에 "기본.png", "미소.webp"처럼 이름을 붙인 이미지를 넣어주세요.
) else (
    echo 작업 완료: !SUCCESS!개 성공, !FAILED!개 실패
    echo 결과 위치: %OUTPUT%
)

echo.
if !MISSING! EQU 0 (
    echo [확인] 01부터 109까지 빠진 번호가 없습니다.
) else (
    echo [알림] 누락된 번호가 !MISSING!개 있습니다.
    echo ----------------------------------------
    type "%MISSING_FILE%"
    echo ----------------------------------------
    echo 누락 목록 저장: %MISSING_FILE%
)
echo.
pause
exit /b

:convert
set "OLD_NAME=%~1"
set "NEW_NAME=%~2"
set "FOUND=0"

for %%E in (png jpg jpeg webp bmp tif tiff gif avif jxl) do (
    if exist "%BASE%!OLD_NAME!.%%E" (
        set "FOUND=1"
        copy /Y "%BASE%!OLD_NAME!.%%E" "%OUTPUT%\!NEW_NAME!.%%E" >nul
        if errorlevel 1 (
            echo [실패] !OLD_NAME!.%%E
            set /a FAILED+=1
        ) else (
            echo [완료] !OLD_NAME!.%%E  ^-^> !NEW_NAME!.%%E
            set /a SUCCESS+=1
        )
    )
)

if !FOUND! EQU 0 (
    set /a MISSING+=1
    >>"%MISSING_FILE%" echo !NEW_NAME!=!OLD_NAME!
)
exit /b
