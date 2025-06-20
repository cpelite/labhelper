# Lab-Helper

# Prüfen ob Admin-Rechte vorhanden sind, ggf. mit Admin-Rechten neustarten.
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Script wird mit Administratorrechten neu gestartet..."
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Eigentliches Script

$setting = Read-Host "Was soll gemacht werden? Lab-DNS setzen oder normalen DNS setzen? Bitte lab oder normal eingeben"
if ($setting -eq 'lab') {
    Set-DnsClientServerAddress -InterfaceIndex 8 -ServerAddresses ("192.168.1.35")
    Write-Host("DNS auf 192.168.1.35 (LAB) gesetzt!")
    Write-Host ("Enter drücken um das Script zu beenden.")
    [System.Console]::ReadKey($true) | Out-Null
    exit
}

elseif ($setting -eq 'normal') {
    Set-DnsClientServerAddress -InterfaceIndex 8 -ResetServerAddresses
    Write-Host("Normale DNS-Settings (DHCP) wiederhergestellt.")
    Write-Host ("Enter drücken um das Script zu beenden.")
    [System.Console]::ReadKey($true) | Out-Null
    exit
}

else {
    Write-Host("Falsche Eingabe. Script wird beendet.")
    Write-Host ("Enter drücken um das Script zu beenden.")
    [System.Console]::ReadKey($true) | Out-Null
    exit
}