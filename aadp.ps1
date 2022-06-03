

try {

    if (-not $global:UserCredential) {
        $global:UserCredential = Get-Credential
    }


    Connect-AzureAD -credential $global:UserCredential
    $global:tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
    $global:o365Service = $global:o365Service + 'A'

    function global:prompt {

        $prefix = "["+(Get-Date -format "MM'/'dd HH:mm:ss")+"] "
        Write-Host $prefix -f yellow -nonewline
        Write-Host $global:o365Service -f Green -NoNewline
        Write-Host $global:tenant -f red -NoNewline
        Write-Host (" PS "+ $pwd +">") -nonewline
        return " "
    
    }

}
catch {
    write-host  "Can't connect Azure AD Preview PowerShell" -f r
    $global:UserCredential = $false
    
}

