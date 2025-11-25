#!/bin/bash

# Deploy script for Resume Builder App
# Використання: ./deploy.sh

set -e

echo "🚀 Starting deployment process..."

# Кольори для виводу
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функція для виводу помилок
error() {
    echo -e "${RED}❌ Error: $1${NC}"
    exit 1
}

# Функція для виводу успіху
success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Функція для виводу інформації
info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Перевірка наявності Flutter
if ! command -v flutter &> /dev/null; then
    error "Flutter не знайдено. Будь ласка, встановіть Flutter SDK."
fi

info "Flutter version:"
flutter --version

# Очищення попередніх збірок
info "Cleaning previous builds..."
flutter clean
success "Cleaned"

# Отримання залежностей
info "Getting dependencies..."
flutter pub get
success "Dependencies installed"

# Збірка веб-версії
info "Building web version..."
if flutter build web --release --base-href="/resume_builder_app/"; then
    success "Web build completed"
else
    error "Web build failed"
fi

# Модифікація index.html якщо потрібно
if [ -f "build/web/index.html" ]; then
    success "Web build ready at: build/web/"
else
    error "Web build files not found"
fi

# Збірка Android
info "Building Android version..."
if flutter build apk --release 2>/dev/null; then
    success "Android APK build completed"
    success "APK ready at: build/app/outputs/flutter-apk/app-release.apk"
    
    # Також збудувати App Bundle
    if flutter build appbundle --release 2>/dev/null; then
        success "Android App Bundle build completed"
        success "App Bundle ready at: build/app/outputs/bundle/release/app-release.aab"
    fi
else
    echo -e "${YELLOW}⚠ Android build skipped (requires Android SDK)${NC}"
fi

echo ""
success "🎉 Deployment preparation completed!"
echo ""
info "Наступні кроки:"
echo "1. Перевірте веб-версію: build/web/index.html"
echo "2. Закомітьте зміни: git add . && git commit -m 'Build for deployment'"
echo "3. Запуште в GitHub: git push origin main"
echo "4. GitHub Actions автоматично розгорне на GitHub Pages"
echo ""
info "Або розгорніть вручну:"
echo "   cd build/web"
echo "   # Розгорніть файли на ваш хостинг"
echo ""

