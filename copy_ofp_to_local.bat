@echo off

reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v "DisableUNCCheck" /t "REG_DWORD" /d "1" /f

set copy_ofp_dir=D:\copy_ofp
echo ������Ҫ��ˢ�������Ƶ��ĸ�Ŀ¼��
echo ������꽫Ŀ��Ŀ¼���봰�ڣ�Ȼ��س�����ֱ�ӻس���Ĭ������ D:\copy_ofp Ŀ¼��:
set /p copy_ofp_dir=
set flash_bin_dir=%copy_ofp_dir%\flash_bin
echo ˢ�������Ƶ� %flash_bin_dir%�������ĵȴ���
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
echo ���ļ�����%numlines%

set /a counter=0
for /f "tokens=2" %%i in (all_files_checksum.txt) do (
    set file=%%i
    set file=!file:/=\!
    copy !file! %flash_bin_dir%\!file! >nul
    set /a counter+=1
    echo �Ѹ��� !counter!/%numlines% ���ļ�
)

copy all_files_checksum.txt %flash_bin_dir%\ >nul
copy all_files_checksum.txt.sig %flash_bin_dir%\ >nul

echo ˢ�������Ƶ� %flash_bin_dir% �ɹ����밴������˳���
echo ######################################################################################################
echo ע�⣺������֡�UNC ·������֧�֡�Ĭ��ֵ��Ϊ Windows Ŀ¼��������ʾ����δ�����κ��ļ������������иýű���
pause