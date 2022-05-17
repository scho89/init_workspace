


# $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
# Import-PSSession $Session -DisableNameChecking
try {
    if (-not $global:UserCredential) {
        $global:UserCredential = Get-Credential
    }

    Connect-MicrosoftTeams -Credential $global:UserCredential
    $global:tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
    $global:o365Service = $global:o365Service + 'T'

    function global:prompt {

        $prefix = "["+(Get-Date -format "MM-dd HH:mm:ss")+"] "
        Write-Host $prefix -f yellow -nonewline
        Write-Host $global:o365Service -f Green -NoNewline
        Write-Host $global:tenant -f red -NoNewline
        Write-Host (" PS "+ $pwd +">") -nonewline
        return " "
    
    }

}
catch {
    Write-Host "Can't connect Teams." -f r
    $global:UserCredential = $false
}

