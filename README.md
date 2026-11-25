<div align="center">

# 🍔 Delivery App

A food delivery app built with **Flutter** and **Firebase**. Browse restaurants by category, explore their menus, add meals to your cart, and place orders, all in an Arabic-first (RTL) interface.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Bloc](https://img.shields.io/badge/State-Bloc%20%2F%20Cubit-8A2BE2?style=for-the-badge)

</div>

---

## 📸 Screenshots

<table>
  <tr>
    <td align="center"><b>Login</b></td>
    <td align="center"><b>Sign Up</b></td>
    <td align="center"><b>Home</b></td>
    <td align="center"><b>Restaurants</b></td>
  </tr>
  <tr>
    <td><img width="200" alt="Login" src="https://github.com/user-attachments/assets/958f0c78-e066-4a4d-93e4-2e15ee3fa887" /></td>
    <td><img width="200" alt="Sign Up" src="https://github.com/user-attachments/assets/253bd73b-8fff-4553-870e-4d071840e974" /></td>
    <td><img width="200" alt="Home" src="https://github.com/user-attachments/assets/3921a2a0-effc-447f-9ae4-267b8547330d" /></td>
    <td><img width="200" alt="Restaurants" src="https://github.com/user-attachments/assets/378b9c0c-b316-46fc-af5f-f56cfec449f6" /></td>
  </tr>
  <tr>
    <td align="center"><b>Menu</b></td>
    <td align="center"><b>Cart</b></td>
    <td align="center"><b>Profile</b></td>
    <td></td>
  </tr>
  <tr>
    <td><img width="200" alt="Menu" src="https://github.com/user-attachments/assets/85d2d3dd-9803-4925-b23c-80c2a0ce49f5" /></td>
    <td><img width="200" alt="Cart" src="https://github.com/user-attachments/assets/5509f642-9848-4e9b-8a88-23d79a137151" /></td>
    <td><img width="200" alt="Profile" src="https://github.com/user-attachments/assets/7a19d907-85fb-49ab-9e2d-9a64a1137361" /></td>
    <td></td>
  </tr>
</table>

---

## ✨ Features

- 🔐 **Authentication**: email & password sign-up and login, Google Sign-In, Facebook login, and password reset by email (Firebase Auth)
- 💾 **Persistent session**: an animated splash screen checks the saved login state and routes the user automatically
- 🏠 **Home**: offers carousel, food categories, and search
- 🍽️ **Restaurants**: list restaurants, filter by category, and search by name
- 📋 **Menu & item details**: browse each restaurant's menu by section and open item details
- ❤️ **Favorites**: save and remove favorite meals
- 🛒 **Cart**: real-time cart synced with Firestore (add, update quantity, remove)
- 📦 **Orders**: place orders from the cart and view order history
- 📍 **Location**: pick a delivery location on Google Maps with geolocation and reverse geocoding
- 💳 **Payment methods** screen
- 🌍 **Localization**: Arabic and English (`intl` / `flutter_intl`), Arabic by default with full RTL support
- ✨ **Polished UI**: glassmorphism bottom navigation bar, skeleton loading, and responsive sizing with `flutter_screenutil`

---

## 🏗️ Architecture

The project follows a **feature-first Clean Architecture** approach. Each feature is split into three layers:

```
feature/
 └── <feature_name>/
      ├── data/           # models + repository implementations
      ├── domain/         # abstract repositories / entities
      └── presentation/   # views, widgets, cubits & states
```

- **State management:** `flutter_bloc` (Cubit)
- **Dependency injection:** `get_it`
- **Backend:** Firebase Auth + Cloud Firestore
- **Networking:** `dio` + `retrofit` with a typed `ApiResult` (built with `freezed`) and centralized error handling
- **Routing:** named routes through a single `onGenerateRoute`

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── constant/      # colors, text styles, API constants
│   ├── di/            # get_it service locator
│   ├── erorr/         # API & Firebase Auth error mappers
│   ├── networking/    # Dio factory, Retrofit API service, ApiResult
│   ├── route/         # app routes
│   ├── service/       # Firebase Auth & Firestore services
│   ├── startup/       # splash / startup view
│   ├── storage/       # local auth data (shared_preferences)
│   └── widgets/       # shared widgets (search bar, snack bar, ...)
├── feature/
│   ├── Auth/          # login, sign up, reset password, profile
│   ├── home/          # home, offers, categories, bottom nav
│   ├── restaurant/    # restaurants list
│   ├── menu/          # restaurant menu
│   ├── details/       # item details
│   ├── favorite/      # favorites
│   ├── cart/          # cart
│   ├── order/         # orders
│   ├── location/      # map & delivery location
│   └── payment/       # payment methods
├── l10n/              # ARB translation files (ar, en)
├── generated/         # generated localization code
└── main.dart
```

---

## 🗄️ Firestore Data Model

| Collection | Description |
|---|---|
| `offers` | Promotional offers shown in the home carousel |
| `restaurant/{id}` | Restaurant info (name, image, rating, category) |
| `restaurant/{id}/menu` | Menu items of each restaurant |
| `user/{uid}` | User profile |
| `user/{uid}/cart` | Items in the user's cart |
| `user/{uid}/location/current` | The user's saved delivery location |
| `orders/{uid}/order` | The user's orders |

---

## 🧰 Tech Stack

| Category | Packages |
|---|---|
| State management | `flutter_bloc`, `bloc`, `equatable` |
| Backend | `firebase_core`, `firebase_auth`, `cloud_firestore` |
| Social login | `google_sign_in`, `flutter_facebook_auth` |
| Networking | `dio`, `retrofit`, `pretty_dio_logger` |
| Code generation | `freezed`, `json_serializable`, `build_runner` |
| Maps & location | `google_maps_flutter`, `geolocator`, `geocoding` |
| DI | `get_it` |
| Local storage | `shared_preferences` |
| UI | `flutter_screenutil`, `flutter_svg`, `carousel_slider`, `skeletonizer`, `modal_progress_hud_nsn` |
| Localization | `flutter_localizations`, `intl_utils` |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Dart `^3.9.2`)
- A Firebase project with **Authentication** (Email/Password, Google, Facebook) and **Cloud Firestore** enabled
- A **Google Maps API key** for the location screen

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/adham12121212/delivery_app.git
cd delivery_app

# 2. Install dependencies
flutter pub get

# 3. Generate code (freezed, json_serializable, retrofit)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Firebase setup

To connect the app to your own Firebase project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This regenerates `lib/firebase_options.dart`, `android/app/google-services.json`, and the iOS config.

### Google Maps setup

- **Android:** add your key to `android/app/src/main/AndroidManifest.xml`
  ```xml
  <meta-data
      android:name="com.google.android.geo.API_KEY"
      android:value="YOUR_API_KEY"/>
  ```
- **iOS:** call `GMSServices.provideAPIKey("YOUR_API_KEY")` in `ios/Runner/AppDelegate.swift`

---

## 👤 Author

**Adham Bassiouny**, Flutter Developer

- GitHub: [@adham12121212](https://github.com/adham12121212)
- LinkedIn: [Adham Bassiouny](https://www.linkedin.com/in/adham-bassiouny-95637322a)
- Portfolio: [adham12121212.github.io/portfolio](https://adham12121212.github.io/portfolio)

---

<div align="center">

⭐ If you like this project, give it a star!

</div>
