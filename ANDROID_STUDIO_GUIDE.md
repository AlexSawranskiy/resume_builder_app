# Інструкція для Android Studio

## 📋 Вимоги

1. **Android Studio** (Arctic Fox або новіше)
2. **Flutter Plugin** для Android Studio
3. **Dart Plugin** для Android Studio
4. **Flutter SDK** (>= 3.0.0)
5. **Java JDK** 17 або новіший

## 🚀 Налаштування проєкту в Android Studio

### Крок 1: Відкрити проєкт

1. Відкрийте Android Studio
2. Виберіть `File > Open`
3. Перейдіть до папки `resume_builder_app`
4. Клацніть `OK`

Android Studio автоматично визначить це як Flutter проєкт.

### Крок 2: Перевірка налаштувань Flutter

1. Перейдіть до `File > Settings` (Windows/Linux) або `Android Studio > Preferences` (Mac)
2. Знайдіть `Languages & Frameworks > Flutter`
3. Переконайтеся, що вказано правильний шлях до Flutter SDK
4. Клацніть `Apply` і `OK`

### Крок 3: Отримання залежностей

У Terminal в Android Studio виконайте:

```bash
flutter pub get
```

Або натисніть `Pub get` у верхній частині файлу `pubspec.yaml`.

## 📱 Запуск додатку

### На Android емуляторі:

1. **Створення емулятора** (якщо ще не створено):
   - `Tools > Device Manager`
   - Клацніть `Create Device`
   - Виберіть пристрій (наприклад, Pixel 7)
   - Виберіть системний образ (рекомендовано API 33 або новіший)
   - Клацніть `Finish`

2. **Запуск емулятора**:
   - У панелі Device Manager натисніть кнопку Play біля емулятора
   - Або використайте dropdown у верхній панелі і виберіть емулятор

3. **Запуск додатку**:
   - Натисніть зелену кнопку Play (▶️) у верхній панелі
   - Або натисніть `Shift + F10` (Windows/Linux) або `Ctrl + R` (Mac)

### На Chrome (Web версія):

1. У dropdown пристроїв виберіть `Chrome`
2. Натисніть зелену кнопку Play (▶️)

### На фізичному Android пристрої:

1. **Увімкніть режим розробника на пристрої**:
   - Перейдіть до `Settings > About phone`
   - Натисніть на `Build number` 7 разів
   - Поверніться до `Settings > Developer options`
   - Увімкніть `USB debugging`

2. **Підключіть пристрій**:
   - Підключіть пристрій через USB
   - Дозвольте налагодження на пристрої
   - Пристрій з'явиться у dropdown Device Manager

3. **Запустіть додаток**:
   - Виберіть ваш пристрій у dropdown
   - Натисніть зелену кнопку Play (▶️)

## 🔨 Збірка релізних версій

### Через Terminal в Android Studio:

```bash
# APK (для встановлення на пристрої)
flutter build apk --release

# App Bundle (для Google Play Store)
flutter build appbundle --release

# Web версія
flutter build web --release
```

### Через меню Android Studio:

1. `Build > Flutter > Build APK`
2. `Build > Flutter > Build App Bundle`
3. `Build > Flutter > Build Web`

## 📂 Розташування збірок

- **Android APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **Android App Bundle**: `build/app/outputs/bundle/release/app-release.aab`
- **Web**: `build/web/`

## 🎯 Корисні команди Terminal

```bash
# Перевірити встановлені пристрої
flutter devices

# Очистити кеш збірки
flutter clean

# Перевірити стан Flutter
flutter doctor

# Перевірити стан Flutter детально
flutter doctor -v

# Запустити тести
flutter test

# Аналіз коду
flutter analyze

# Форматувати код
flutter format .
```

## 🐛 Усунення проблем

### Проблема: "Flutter SDK not found"

**Рішення**:
1. Завантажте Flutter SDK з https://flutter.dev/docs/get-started/install
2. Додайте Flutter до PATH
3. Вкажіть шлях в `File > Settings > Languages & Frameworks > Flutter`

### Проблема: "Unable to find bundled Java version"

**Рішення**:
1. Встановіть Java JDK 17: https://adoptium.net/
2. Встановіть змінну середовища `JAVA_HOME`
3. Перезапустіть Android Studio

### Проблема: "Android SDK not found"

**Рішення**:
1. У Android Studio: `Tools > SDK Manager`
2. Переконайтеся, що встановлено:
   - Android SDK Platform (API 33 або новіший)
   - Android SDK Build-Tools
   - Android SDK Command-line Tools
3. Клацніть `Apply`

### Проблема: Gradle sync failed

**Рішення**:
```bash
# У Terminal
flutter clean
flutter pub get
```

Потім у Android Studio: `File > Invalidate Caches / Restart`

### Проблема: Hot reload не працює

**Рішення**:
1. Зупиніть додаток
2. Виконайте `flutter clean`
3. Перезапустіть додаток

## 🎨 Debugging в Android Studio

### Встановлення breakpoints:

1. Клацніть на лівій межі редактора коду (номер рядка)
2. З'явиться червона крапка

### Запуск в режимі Debug:

1. Натисніть кнопку Debug (🐛) замість Run
2. Або натисніть `Shift + F9` (Windows/Linux) або `Ctrl + D` (Mac)

### Корисні панелі:

- **Debug Console**: Показує виведення додатку
- **Flutter Inspector**: Інспектування widget tree
- **Dart DevTools**: Профілювання та аналіз продуктивності

## 📝 Гарячі клавіші

| Дія | Windows/Linux | Mac |
|-----|---------------|-----|
| Run | Shift + F10 | Ctrl + R |
| Debug | Shift + F9 | Ctrl + D |
| Hot Reload | Ctrl + \ | Cmd + \ |
| Hot Restart | Ctrl + Shift + \ | Cmd + Shift + \ |
| Format Code | Ctrl + Alt + L | Cmd + Option + L |
| Quick Fix | Alt + Enter | Option + Enter |
| Find | Ctrl + F | Cmd + F |
| Replace | Ctrl + R | Cmd + R |

## 🔗 Корисні посилання

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter YouTube Channel](https://www.youtube.com/c/flutterdev)
- [Android Studio User Guide](https://developer.android.com/studio/intro)

## 🎓 Наступні кроки

1. Ознайомтеся з файлом `DEPLOYMENT.md` для інструкцій по розгортанню
2. Перегляньте структуру проєкту в `lib/`
3. Запустіть тести: `flutter test`
4. Експериментуйте з Hot Reload - змініть код і натисніть `Ctrl + \`

