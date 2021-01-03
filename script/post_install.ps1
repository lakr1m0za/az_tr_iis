mkdir c:\Admin
$rootcert = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -DnsName "IIS Root Cert CA" -KeyUsage CertSign -NotAfter (Get-Date).AddYears(10) -KeyLength 4096
Export-Certificate -cert $rootcert -FilePath C:\Admin\CABackup.cer
Import-Certificate -FilePath C:\Admin\CABackup.cer -CertStoreLocation Cert:\LocalMachine\Root
$serverCert = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName $env:COMPUTERNAME -Signer $rootcert -KeyLength 4096
Get-ChildItem WSMan:\localhost\Listener\ | Where-Object -Property Keys -eq 'Transport=HTTP' | Remove-Item -Recurse
New-Item -Path WSMan:\localhost\Listener\ -Transport HTTPS -Address * -CertificateThumbPrint $serverCert.Thumbprint -Force
