# Hear-Beat Server Installation Script
# Run via: irm https://raw.githubusercontent.com/Santaslileper/hear-beat-test/main/install.ps1 | iex

Write-Host "=================================" -ForegroundColor Cyan
Write-Host " Setting up Hear-Beat Server...  " -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
if (!(Get-Command "npm" -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js is not installed. Please install Node.js first: https://nodejs.org/" -ForegroundColor Red
    exit 1
}

$InstallDir = "$env:USERPROFILE\Desktop\hear-beat-server"
Write-Host "Creating installation directory at: $InstallDir"
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}

Set-Location $InstallDir

Write-Host "Downloading server files..."
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Santaslileper/hear-beat-test/master/server.js" -OutFile "$InstallDir\server.js"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Santaslileper/hear-beat-test/master/package.json" -OutFile "$InstallDir\package.json"

Write-Host "Installing dependencies..."
npm install --silent

Write-Host "Starting Hear-Beat Server..." -ForegroundColor Green
Write-Host "You can keep this window open to keep the server running." -ForegroundColor Yellow
Write-Host ""

# Start the server
npm start
