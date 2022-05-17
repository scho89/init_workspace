Import-Module SkypeOnlineConnector
$global:UserCredential = Get-Credential
$global:o365Service = $global:o365Service + 'L'

function global:prompt {

    $prefix = "["+(Get-Date -format "MM-dd HH:mm:ss")+"] "
    Write-Host $prefix -f yellow -nonewline
    Write-Host $global:o365Service -f Green -NoNewline
    $tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
    Write-Host $tenant -f red -NoNewline
    Write-Host (" PS "+ $pwd +">") -nonewline
    return " "

}

$sfbSession = New-CsOnlineSession -Credential $userCredential
Import-PSSession $sfbSession