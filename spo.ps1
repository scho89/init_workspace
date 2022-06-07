



try {
    $orgName = Read-Host "Tenant name? "
    if (-not $global:UserCredential) {
        $global:UserCredential = Get-Credential
    }
    
    
    $url = 'https://'+$orgName+'-admin.sharepoint.com'
    Connect-SPOService -Url $url -Credential $UserCredential
    $global:tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
    $global:o365Service = $global:o365Service + 'S'
    
    function prompt {


        if ((Get-History).count -ge 1) {
                $executionTime = ((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Totalmilliseconds
                } 
        else {
              $executionTime = 0                
             }

        $global:prefix = (Get-Date -format "MM'/'dd HH:mm:ss") + (" {0:#,0} ms " -f $executionTime)

        Write-Host $global:prefix -f yellow -nonewline

        if ($global:o365Service) {
                Write-Host $global:o365Service -f Green -NoNewline
                Write-Host $global:tenant -f red -NoNewline  
        }

        Write-Host (" "+$pwd +">") -nonewline
        return " "
    
    }
}
catch {
    Write-Host "Can't connect to SharePoint Online" -f r
    $global:UserCredential = $false
}

