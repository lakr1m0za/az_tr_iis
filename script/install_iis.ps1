Install-WindowsFeature -name Web-Server -IncludeManagementTools

Stop-WebSite -Name "Default Web Site"
Stop-WebAppPool -Name "DefaultAppPool"

mkdir C:\Sites\Website1
mkdir C:\Sites\MyApp
New-Item -ItemType File -Name 'index.html' -Path 'C:\Sites\Website1'
Set-Content -Path C:\Sites\Website1\index.html -Value "$env:COMPUTERNAME"
get-acl C:\inetpub\wwwroot | Set-Acl C:\Sites\Website1
get-acl C:\inetpub\wwwroot | Set-Acl C:\Sites\MyApp

Install-Module -Name WebAdministration
Import-Module WebAdministration

New-Item -Path "IIS:\Sites" -Name "Website1" -Type Site -Bindings @{protocol="http";bindingInformation="*:80:"}
Set-ItemProperty -Path "IIS:\Sites\Website1" -name "physicalPath" -value "C:\Sites\Website1"
Set-ItemProperty -Path "IIS:\Sites\Website1" -Name "id" -Value 2

New-Item -Path "IIS:\AppPools" -Name "My Pool" -Type AppPool
Set-ItemProperty -Path "IIS:\AppPools\My Pool" -name "managedRuntimeVersion" -value "v4.0"
Set-ItemProperty -Path "IIS:\AppPools\My Pool" -name "autoStart" -value $true
Set-ItemProperty -Path "IIS:\AppPools\My Pool" -name "processModel" -value @{identitytype="ApplicationPoolIdentity"}
Set-ItemProperty -Path "IIS:\AppPools\My Pool" -name "managedPipelineMode" -value 0
New-Item -Type Application -Path "IIS:\Sites\Website1\MyApp" -physicalPath "C:\Sites\MyApp"

Set-ItemProperty -Path "IIS:\Sites\Website1" -name "applicationPool" -value "My Pool"
Set-ItemProperty -Path "IIS:\Sites\Website1\MyApp" -name "applicationPool" -value "My Pool"

Set-ItemProperty -Path "IIS:\Sites\Website1" -name "physicalPath" -value "C:\Sites\Website1\"
Set-ItemProperty -Path "IIS:\Sites\Website1\MyApp" -name "physicalPath" -value "C:\Sites\Website1\"

Start-Website -Name "Website1"
