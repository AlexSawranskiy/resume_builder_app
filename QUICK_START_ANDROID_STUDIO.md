# Швидкий старт для Android Studio

## 🎯 Основні команди

Відкрийте **Terminal** в Android Studio (внизу екрану) і виконайте:

### 1. Збірка веб-версії
```bash
flutter build web --release
```
📁 Результат: `build/web/`

### 2. Збірка Android APK
```bash
flutter build apk --release
```
📁 Результат: `build/app/outputs/flutter-apk/app-release.apk`

### 3. Збірка Android App Bundle (для Google Play)
```bash
flutter build appbundle --release
```
📁 Результат: `build/app/outputs/bundle/release/app-release.aab`

### 4. Запуск на пристрої/емуляторі
```bash
flutter run
```

### 5. Очистити кеш (якщо щось не працює)
```bash
flutter clean
flutter pub get
```

## 🌐 Розгортання на GitHub Pages

### Варіант 1: Автоматично (рекомендовано)

1. Створіть репозиторій на GitHub
2. У Terminal виконайте:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/resume_builder_app.git
git push -u origin main
```
3. В GitHub: `Settings > Pages > Source > GitHub Actions`
4. Готово! Ваш сайт буде на `https://YOUR_USERNAME.github.io/resume_builder_app/`

### Варіант 2: Використати скрипт

**Windows (PowerShell Terminal)**:
```powershell
.\deploy.ps1
```

**Git Bash Terminal**:
```bash
./deploy.sh
```

## 🔍 Перевірка перед розгортанням

```bash
# Перевірити що все працює
flutter doctor

# Запустити тести
flutter test

# Перевірити код
flutter analyze
```

## 📱 Запуск додатку

### Через UI Android Studio:

1. **Виберіть пристрій** у dropdown вгорі (емулятор або Chrome для веб)
2. **Натисніть зелену кнопку ▶️ (Run)**

### Через Terminal:

```bash
# Веб в Chrome
flutter run -d chrome

# Android емулятор
flutter run -d emulator

# Показати всі пристрої
flutter devices
```

## 📦 Готові збірки

Після виконання команд збірки, файли будуть тут:

| Платформа | Шлях | Розмір |
|-----------|------|--------|
| Web | `build/web/` | ~2 MB |
| Android APK | `build/app/outputs/flutter-apk/app-release.apk` | ~15-20 MB |
| Android AAB | `build/app/outputs/bundle/release/app-release.aab` | ~40 MB |

## ⚡ Корисні поради

1. **Hot Reload** - після зміни коду натисніть `Ctrl + \` (або `Cmd + \` на Mac)
2. **Format Code** - `Ctrl + Alt + L` (або `Cmd + Option + L` на Mac)
3. **Terminal в Android Studio** - `Alt + F12` або знизу клацнути "Terminal"

## 🐛 Якщо щось не працює

```bash
# 1. Очистити все
flutter clean

# 2. Отримати залежності
flutter pub get

# 3. Перевірити проблеми
flutter doctor -v
```

Потім у Android Studio: `File > Invalidate Caches / Restart`

---

💡 **Повна документація**: [ANDROID_STUDIO_GUIDE.md](ANDROID_STUDIO_GUIDE.md)

