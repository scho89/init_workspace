#o365.ps1
$global:orgName = Read-Host "Tenant name? "
$global:UserCredential = Get-Credential

function global:prompt {

    $prefix = "["+(Get-Date -format "MM-dd HH:mm:ss")+"]"
    Write-Host $prefix -f yellow -nonewline
    $tenant = " ("+$orgName+")"
    Write-Host $tenant -f red -NoNewline
    Write-Host (" PS "+ $pwd +">") -nonewline
    return " "
}

write-host 'Connecting MsOnline PowerShell' -ForegroundColor Green
Connect-MsolService -credential $global:UserCredential

write-host 'Connecting Azure AD PowerShell' -ForegroundColor Green
Connect-AzureAD -credential $global:UserCredential

write-host 'Connecting Exchange Online PowerShell' -ForegroundColor Green
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

write-host 'Connecting SharePoint Online PowerShell' -ForegroundColor Green
$url = 'https://'+$orgName+'-admin.sharepoint.com'
Connect-SPOService -Url $url -Credential $UserCredential

write-host 'Connecting Skype for Business Online PowerShell' -ForegroundColor Green

Import-Module SkypeOnlineConnector
$sfbSession = New-CsOnlineSession -Credential $userCredential
Import-PSSession $sfbSession

