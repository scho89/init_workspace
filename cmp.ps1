try {
    if (-not $global:UserCredential) {
        $global:UserCredential = Get-Credential
    }

    Connect-IPPSSession -Credential $global:UserCredential
    $global:tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
    $global:o365Service = $global:o365Service + 'C'
    
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
    Write-Host "Can't connect Compliance shell." -f r
    $global:UserCredential = $false
}





# function global:prompt {

#     $global:prefix = "["+(Get-Date -format "MM-dd HH:mm:ss")+"]"
#     Write-Host $global:prefix -f yellow -nonewline
#     $tenant = " ("+($UserCredential.UserName -split '@')[1]+")"
#     Write-Host $tenant -f red -NoNewline
#     Write-Host (" PS "+ $pwd +">") -nonewline
#     return " "

# }

# $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/  -Credential $UserCredential -Authentication Basic -AllowRedirection
# Import-PSSession $Session -DisableNameChecking
