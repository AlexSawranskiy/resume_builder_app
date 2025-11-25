# resume_builder_app_github

# Resume Builder App

Застосунок для створення резюме з інтеграцією GitHub статистики. Розроблено з використанням Flutter, MVVM архітектури та go_router.

## 📱 Платформи

- ✅ **Web** (GitHub Pages)
- ✅ **Android** (APK і App Bundle)

## 🚀 Швидкий старт

### Для Android Studio

Детальну інструкцію дивіться в [ANDROID_STUDIO_GUIDE.md](ANDROID_STUDIO_GUIDE.md)

### Через командний рядок

```bash
# Отримати залежності
flutter pub get

# Запустити на Android емуляторі
flutter run

# Запустити у Chrome (Web)
flutter run -d chrome
```

## 📦 Збірка

### Веб-версія
```bash
flutter build web --release
```

### Android
```bash
# APK для встановлення
flutter build apk --release

# App Bundle для Google Play
flutter build appbundle --release
```

### Автоматична збірка
Використайте скрипти:
- **Windows**: `.\deploy.ps1`
- **Linux/Mac**: `./deploy.sh`

## 🌐 Розгортання

Детальні інструкції по розгортанню дивіться в [DEPLOYMENT.md](DEPLOYMENT.md)

### Швидке розгортання на GitHub Pages

1. Створіть репозиторій на GitHub
2. Запуште код:
```bash
git add .
git commit -m "Initial commit"
git push origin main
```
3. Увімкніть GitHub Pages в Settings > Pages
4. Виберіть джерело: "GitHub Actions"
5. Після автоматичної збірки ваш застосунок буде доступний за адресою:
   `https://YOUR_USERNAME.github.io/resume_builder_app/`

## 🏗️ Архітектура

Проєкт використовує **MVVM** (Model-View-ViewModel) архітектуру:

```
lib/
├── models/           # Моделі даних
├── views/            # UI екрани
├── viewmodels/       # Бізнес логіка
├── services/         # Сервіси (API, storage)
├── repository/       # Репозиторії для роботи з даними
├── widgets/          # Переиспользуемі компоненти
└── routes.dart       # Навігація (go_router)
```

## 📚 Технології

- **Flutter** - UI framework
- **Provider** - State management
- **go_router** - Навігація
- **http** - HTTP запити
- **shared_preferences** - Локальне збереження

## 🧪 Тестування

```bash
# Запустити всі тести
flutter test

# Запустити конкретний тест
flutter test test/theme_service_test.dart
```

## 📖 Документація

- [DEPLOYMENT.md](DEPLOYMENT.md) - Інструкції по розгортанню
- [ANDROID_STUDIO_GUIDE.md](ANDROID_STUDIO_GUIDE.md) - Робота в Android Studio

## 🤝 Внесок

1. Fork репозиторій
2. Створіть feature branch (`git checkout -b feature/AmazingFeature`)
3. Закомітьте зміни (`git commit -m 'Add some AmazingFeature'`)
4. Запуште в branch (`git push origin feature/AmazingFeature`)
5. Відкрийте Pull Request

## 📄 Ліцензія

Цей проєкт створено в освітніх цілях.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
