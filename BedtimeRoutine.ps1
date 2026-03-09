#Purpose
#to set the laptop to a "bedtime" configuration and launch Jellyfin
 
#variables

$BrightnessLevel = 1 #sets laptop screen brightness
$VolumeLevel = 25 #sets system volume level. 
$JellyfinFilepath = "C:\Program Files\Jellyfin\Jellyfin Media Player\JellyfinMediaPlayer.exe" #Path to JellyfinMediaPLayer.exe

#functions

function setSystemBrightness($BrightnessValue) {
    Invoke-CimMethod -InputObject (Get-CimInstance -Namespace root/wmi -ClassName WmiMonitorBrightnessMethods) -MethodName WmiSetBrightness -Arguments @{Brightness = $BrightnessLevel; Timeout = 1}
}
function checkifAudioDCModuleInstalled {
    $module = get-module -name AudioDeviceCmdlets
    if ($null -eq $module){
        return $true
    }
}
function installAudioDeviceCmdletsModule {
    Install-Module -Name AudioDeviceCmdlets
}
function importAudioDeviceCmdletsModule {
    import-module AudioDeviceCmdlets
}
function setSystemVolume($VolumeValue){
    
    Set-AudioDevice -PlaybackVolume $VolumeValue
}  
function launchJellyfin($filepath) {
    start-process -Filepath $filepath
}

#Main

setSystemBrightness($BrightnessLevel)
$audioModuleStatus = checkifAudioDCModuleInstalled
if ($true -eq $audioModuleStatus){
    installAudioDeviceCmdletsModule
}
importAudioDeviceCmdletsModule
setSystemVolume($VolumeLevel)

launchJellyfin($JellyfinFilepath)

