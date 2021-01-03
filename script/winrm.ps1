$sessionOptions = New-PSSessionOption -SkipCACheck
New-PSSession -ComputerName www1, www2 -UseSSL -SessionOption $sessionOptions
Invoke-Command -ComputerName www1, www2 -FilePath install_iis.ps1
