# Deploy script for Resume Builder App (PowerShell)
# Використання: .\deploy.ps1

$ErrorActionPreference = "Stop"

Write-Host "🚀 Starting deployment process..." -ForegroundColor Cyan

# Функції для виводу
function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "❌ Error: $Message" -ForegroundColor Red
    exit 1
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Yellow
}

# Перевірка наявності Flutter
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Error-Custom "Flutter не знайдено. Будь ласка, встановіть Flutter SDK."
}

Write-Info "Flutter version:"
flutter --version

# Очищення попередніх збірок
Write-Info "Cleaning previous builds..."
flutter clean
Write-Success "Cleaned"

# Отримання залежностей
Write-Info "Getting dependencies..."
flutter pub get
Write-Success "Dependencies installed"

# Збірка веб-версії
Write-Info "Building web version..."
try {
    flutter build web --release --base-href="/resume_builder_app/"
    Write-Success "Web build completed"
} catch {
    Write-Error-Custom "Web build failed: $_"
}

# Перевірка наявності збірки
if (Test-Path "build\web\index.html") {
    Write-Success "Web build ready at: build\web\"
} else {
    Write-Error-Custom "Web build files not found"
}

# Збірка Android
Write-Info "Building Android version..."
try {
    # Збірка APK
    flutter build apk --release 2>$null
    Write-Success "Android APK build completed"
    Write-Success "APK ready at: build\app\outputs\flutter-apk\app-release.apk"
    
    # Збірка App Bundle
    flutter build appbundle --release 2>$null
    Write-Success "Android App Bundle build completed"
    Write-Success "App Bundle ready at: build\app\outputs\bundle\release\app-release.aab"
} catch {
    Write-Host "⚠ Android build skipped (requires Android SDK)" -ForegroundColor Yellow
    Write-Info "Встановіть Android SDK та Java JDK для збірки Android версії"
}

Write-Host ""
Write-Success "🎉 Deployment preparation completed!"
Write-Host ""
Write-Info "Наступні кроки:"
Write-Host "1. Перевірте веб-версію: build\web\index.html"
Write-Host "2. Закомітьте зміни: git add . ; git commit -m 'Build for deployment'"
Write-Host "3. Запуште в GitHub: git push origin main"
Write-Host "4. GitHub Actions автоматично розгорне на GitHub Pages"
Write-Host ""
Write-Info "Або розгорніть вручну:"
Write-Host "   cd build\web"
Write-Host "   # Розгорніть файли на ваш хостинг"
Write-Host ""

# Запитати чи відкрити веб-версію
$response = Read-Host "Відкрити веб-версію в браузері? (Y/N)"
if ($response -eq 'Y' -or $response -eq 'y') {
    $indexPath = Resolve-Path "build\web\index.html"
    Start-Process $indexPath
}

