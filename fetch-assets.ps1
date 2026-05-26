# Fetch AI-generated assets for The Sharpfellas Barber Studio from Canva CDN
# Run this on Windows before Stage 2 git-commits the build folder.
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $false

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$heroUrl = @"
https://export-download.canva.com/yPF9Q/DAHKjpyPF9Q/-1/0/0001-673792331171841402.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQYCGKMUH5AO7UJ26%2F20260523%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260523T091938Z&X-Amz-Expires=83345&X-Amz-Signature=9df9c539521b06b200cf13132b30e080fdb60112ae8390badbe142dc874f1f0d&X-Amz-SignedHeaders=host%3Bx-amz-expected-bucket-owner&response-expires=Sun%2C%2024%20May%202026%2008%3A28%3A43%20GMT
"@
Write-Host "Downloading hero.jpg..."
try {
    Invoke-WebRequest -Uri $heroUrl -OutFile "$here\hero.jpg" -UseBasicParsing
    if (Test-Path "$here\hero.jpg") {
        $sz = (Get-Item "$here\hero.jpg").Length
        Write-Host "OK - hero.jpg downloaded ($sz bytes)"
    } else {
        Write-Host "WARN - hero.jpg missing after download"
    }
} catch {
    Write-Host "ERROR - hero fetch failed: $_"
    Write-Host "NOTE - the Canva presigned URL may have expired (~24h lifetime). Site will fall back to gradient background until logo swap at \$250 close."
}
