



try {
    $orgName = Read-Host "Tenant name? "
    if (-not $global:UserCredential) {
        $global:UserCredential = Get-Credential
    }
    
    
    $url = 'https://'+$orgName+'-admin.sharepoint.com'
    Connect-SPOService -Url $url -Credential $UserCredential
    $global:tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
    $global:o365Service = $global:o365Service + 'S'


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
    Write-Host "Can't connect to SharePoint Online" -f r
    $global:UserCredential = $false
}

