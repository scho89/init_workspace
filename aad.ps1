

    if (-not $global:UserCredential) {
        $global:UserCredential = Get-Credential
    }

    Connect-MsolService -credential $global:UserCredential
    

    if ($Error[0].CategoryInfo.Activity -eq "Connect-MsolService") {
        write-host  "Can't connect Office 365 PowerShell (MsOnline)" -f r
        $global:UserCredential = $false
        $Error.RemoveAt(0)
    }

    else {
        $global:tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
        $global:o365Service = $global:o365Service + 'O'

        function global:prompt {

            $prefix = "["+(Get-Date -format "MM'/'dd HH:mm:ss")+"] "
            Write-Host $prefix -f yellow -nonewline
            Write-Host $global:o365Service -f Green -NoNewline
            Write-Host $global:tenant -f red -NoNewline
            Write-Host (" PS "+ $pwd +">") -nonewline
            return " "
            
        }
    }

    

