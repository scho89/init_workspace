#remove o365 session
Disconnect-AzureAD
Disconnect-SPOService
Get-PSSession | Remove-PSSession
Disconnect-ExchangeOnline -Confirm:$false
Disconnect-MicrosoftTeams


$global:UserCredential = $false
$global:tenant = ""
$global:o365Service = ""

function global:prompt {

    $prefix = "["+(Get-Date -format "MM-dd HH:mm:ss")+"] "
    Write-Host $prefix -f yellow -nonewline
    Write-Host ("PS "+ $pwd +">") -nonewline
    return " "

}


