@echo off

reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v "DisableUNCCheck" /t "REG_DWORD" /d "1" /f

set copy_ofp_dir=D:\copy_ofp
echo 请问您要将刷机包复制到哪个目录？
echo 请用鼠标将目标目录拖入窗口，然后回车（若直接回车将默认设置 D:\copy_ofp 目录）:
set /p copy_ofp_dir=
set flash_bin_dir=%copy_ofp_dir%\flash_bin
echo 刷机包复制到 %flash_bin_dir%，请耐心等待：
md %flash_bin_dir%\IMAGES\download_agent
md %flash_bin_dir%\IMAGES\my_bigball
md %flash_bin_dir%\IMAGES\my_carrier
md %flash_bin_dir%\IMAGES\my_company
md %flash_bin_dir%\IMAGES\my_heytap
md %flash_bin_dir%\IMAGES\my_manifest
md %flash_bin_dir%\IMAGES\my_preload
md %flash_bin_dir%\IMAGES\my_region
md %flash_bin_dir%\IMAGES\my_stock
md %flash_bin_dir%\META\7z

setlocal enabledelayedexpansion

set /a numlines=0
for /f %%a in (all_files_checksum.txt) do set /a numlines+=1
echo 总文件数：%numlines%

set /a counter=0
for /f "tokens=2" %%i in (all_files_checksum.txt) do (
    set file=%%i
    set file=!file:/=\!
    copy !file! %flash_bin_dir%\!file! >nul
    set /a counter+=1
    echo 已复制 !counter!/%numlines% 个文件
)

copy all_files_checksum.txt %flash_bin_dir%\ >nul
copy all_files_checksum.txt.sig %flash_bin_dir%\ >nul

echo 刷机包复制到 %flash_bin_dir% 成功，请按任意键退出。
echo ######################################################################################################
echo 注意：如果出现“UNC 路径不受支持。默认值设为 Windows 目录。”的提示，且未复制任何文件，请重新运行该脚本。
pause