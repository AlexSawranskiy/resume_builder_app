# Розгортання Resume Builder App

## 📱 Підтримувані платформи
- **Web** (GitHub Pages)
- **Android** (APK і App Bundle)

## 🌐 Веб-версія (GitHub Pages)

### Автоматичне розгортання
Проєкт налаштовано для автоматичного розгортання на GitHub Pages через GitHub Actions.

#### Кроки для налаштування:

1. **Створіть репозиторій на GitHub** (якщо ще не створено):
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/resume_builder_app.git
   git push -u origin main
   ```

2. **Увімкніть GitHub Pages**:
   - Перейдіть до Settings > Pages у вашому репозиторії
   - В розділі "Source" виберіть "GitHub Actions"

3. **Запустіть workflow**:
   - Після push в `main` branch, автоматично запуститься workflow
   - Або запустіть вручну: Actions > Deploy to GitHub Pages > Run workflow

4. **Відкрийте ваш застосунок**:
   - Після успішного розгортання ваш застосунок буде доступний за адресою:
   - `https://YOUR_USERNAME.github.io/resume_builder_app/`

### Ручне розгортання

Якщо ви хочете розгорнути вручну:

```bash
# 1. Збудувати веб-версію
flutter build web --release --base-href="/resume_builder_app/"

# 2. Створити гілку gh-pages
git checkout --orphan gh-pages
git reset --hard

# 3. Скопіювати файли з build/web
cp -r build/web/* .

# 4. Додати файл .nojekyll (важливо!)
touch .nojekyll

# 5. Закомітити та запушити
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages --force

# 6. Повернутись до main
git checkout main
```

## 📱 Android версія

### Вимоги для збірки Android:
- Flutter SDK (>= 3.0.0)
- Android SDK
- Java JDK 17 або новіший

### Збірка локально:

```bash
# Створити платформу Android
flutter create . --platforms=android

# Отримати залежності
flutter pub get

# Збудувати APK (для встановлення на пристрій)
flutter build apk --release

# Збудувати App Bundle (для Google Play Store)
flutter build appbundle --release
```

Результати:
- **APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **App Bundle**: `build/app/outputs/bundle/release/app-release.aab`

### Автоматична збірка Android

GitHub Actions автоматично збудує Android версію при push в `main`.
Завантажити артефакти можна з:
- Actions > Build Android Release > останній запуск > Artifacts
  - `android-apk` - APK файл
  - `android-aab` - App Bundle для Google Play

## 🚀 Скрипти для швидкого розгортання

### Windows (PowerShell):
```powershell
.\deploy.ps1
```

### Linux/Mac (Bash):
```bash
./deploy.sh
```

## 📝 Важливі нотатки

### Для Web:
- Переконайтеся, що `--base-href` відповідає назві вашого репозиторію
- Якщо репозиторій називається інакше, змініть це в:
  - `.github/workflows/deploy.yml`
  - Команді ручної збірки

### Для Android:
- Для локальної збірки потрібен Android SDK
- GitHub Actions збудує без локальних залежностей
- Розмір APK: ~15-20 MB
- Розмір App Bundle: ~40 MB (Google Play оптимізує до ~10-15 MB)

## 🔧 Налаштування після розгортання

### Якщо репозиторій на вашому домені:
Змініть `--base-href` на "/" в `.github/workflows/deploy.yml`:
```yaml
run: flutter build web --release --base-href="/"
```

### Якщо використовуєте кастомний домен:
1. Додайте файл `CNAME` в `web/` директорію з вашим доменом
2. В Settings > Pages додайте кастомний домен

## 📱 Запуск локально

### Web:
```bash
flutter run -d chrome
```

### Android:
```bash
# На емуляторі
flutter run -d emulator

# На підключеному пристрої
flutter run -d <device-id>

# Перелік доступних пристроїв
flutter devices
```

## 🐛 Усунення проблем

### Web не завантажується на GitHub Pages:
- Перевірте, чи правильно встановлено `base-href`
- Переконайтеся, що GitHub Pages увімкнено в Settings
- Перевірте логи в Actions

### Android не збирається локально:
- Запустіть `flutter doctor` для перевірки інсталяції Android SDK
- Переконайтеся, що Android SDK і Java JDK встановлено правильно
- Переконайтеся, що змінні середовища ANDROID_HOME і JAVA_HOME налаштовано
- Спробуйте `flutter clean` та повторіть збірку

## 📚 Додаткові ресурси

- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [Flutter Android Deployment](https://docs.flutter.dev/deployment/android)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)

