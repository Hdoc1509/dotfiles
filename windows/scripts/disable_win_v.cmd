REM Logic taken from: https://superuser.com/questions/1439819/disabling-winv-on-windows#comment2638243_1440344
REM Registry steps from: https://www.askvg.com/tip-how-to-disable-cloud-based-clipboard-winv-history-in-windows-10/
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\System /v AllowClipboardHistory /t REG_DWORD /d 0
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\System /v AllowCrossDeviceClipboard /t REG_DWORD /d 0
