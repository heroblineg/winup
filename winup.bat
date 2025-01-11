@echo off
chcp 65001
setlocal

rem Check for options
set RUN_WINGET=false
set RUN_PIP=false
set RUN_UWP=false

if "%1"=="" (
    set RUN_WINGET=true
    set RUN_PIP=true
    set RUN_UWP=true
) else (
    :parse_options
    if "%1"=="-w" (
        set RUN_WINGET=true
    ) else if "%1"=="-p" (
        set RUN_PIP=true
    ) else if "%1"=="-s" (
        set RUN_UWP=true
    )
    shift
    if not "%1"=="" goto parse_options
)

rem Execute commands based on options
if "%RUN_WINGET%"=="true" (
    echo wingetパッケージをアップデートします。
    winget upgrade --all
)

if "%RUN_PIP%"=="true" (
    echo pipパッケージをアップデートします。
    pip-review --auto
)

if "%RUN_UWP%"=="true" (
    echo MS UWPのパッケージをアップデートします。
    powershell -Command "[Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallManager,InstallService.dll,ContentType=WindowsRuntime]; (New-Object Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallManager).SearchForAllUpdatesAsync()"
)

endlocal
