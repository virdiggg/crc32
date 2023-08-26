@echo off

if not "%~1"=="" set input-title=""
if not "%~1"=="" set input-path=%~dp1
if not "%~1"=="" set input-path-for-txt="%~dp1"
if not "%~1"=="" set input-file=%~nx1
if not "%~1"=="" set input-file-for-txt="%~nx1"

set name=""
set ext=".mkv"
for /R %input-path% %%f in (*.mkv) do (
  set name=%%~nf
)

echo file name w/o ext:%name%

REM buat file input.txt baru
type nul > input.txt

REM if not "%~1"=="" echo %input-title% /d %input-path-for-txt% %input-file-for-txt% full-path:"%full-path%">input.txt

REM simpan full path file-nya ke variabel full-path
set "full-path=%input-path%%input-file%"

REM simpan full path file crc32-nya ke variabel crc32
REM file crc32.exe harus ada di dalam folder yang sama dengan file yang mau dicek
set "crc32=%input-path%crc32.exe"

REM simpan hasil cek crc32 di file input.txt
%crc32% "%full-path%">input.txt

REM ambil nilainya dari file input.txt
set /p rawCRC=<input.txt

REM echo %rawCRC%

REM nilainya = 0xECACAA70 (390,833,665)
REM ambil kata dari karakter kedua sampe belakang sebanyak 8 karakter
set "rawCRC=%rawCRC:~2,8%"

echo CRC32:%rawCRC%

REM rename file lama
start mv "%full-path%" "%name%[%rawCRC%]%ext%"

REM delete file input.txt
del input.txt

set input-title=""
set input-path=""
set input-path-for-txt=""
set input-file=""
set input-file-for-txt=""
set full-path=""
set name=""
set ext=""
set crc32=""
set rawCRC=""

@pause