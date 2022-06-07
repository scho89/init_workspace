

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

    

