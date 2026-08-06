# Fine Route - Project Knowledge

This document serves as a comprehensive guide to understanding the architecture, tech stack, and code structure of the **Fine Route** Flutter project. It is intended to help developers (and AI assistants) quickly onboard and navigate the codebase.

## 1. Tech Stack & Dependencies
- **Framework**: Flutter (SDK ^3.12.2)
- **State Management**: `flutter_bloc`
- **Dependency Injection**: `get_it`
- **Routing**: `go_router`
- **Networking**: `dio`
- **Local Storage**: `flutter_secure_storage` & `shared_preferences`
- **Environment Config**: `flutter_dotenv`
- **Utilities**: `dartz` (Either error handling), `equatable` (value equality)
- **Integrations Setup**: Razorpay (keys found in `.env`)

## 2. Architectural Pattern (Clean Architecture + Feature-First)
The project follows **Clean Architecture** separated by features.
- `lib/core/`: Common utilities, constants, network layer, error handling, shared widgets.
- `lib/config/`: App-wide configuration (routing, theming).
- `lib/di/`: Dependency Injection setup (`injection_container.dart`).
- `lib/features/`: Contains feature modules. Each feature is divided into:
  - `presentation/`: UI, Widgets, and BLoCs.
  - `domain/`: Entities, Use Cases, Repository Interfaces.
  - `data/`: Repository Implementations, Models (DTOs), Data Sources.

## 3. Currently Implemented Features & Functions

### Core & Configuration (Implemented)
- **Dependency Injection (`getIt`)**: Initialized in `setupDI()`. Currently registers `SharedPreferences`, `FlutterSecureStorage`, `NetworkInfo`, and a configured `ApiClient`.
- **Networking (`ApiClient`)**: Configured with `dio` for API calls to `https://mayurahospitals.com/api` (as seen in `.env`).
- **Routing (`go_router`)**: A basic router is initialized in `app_router.dart` with an initial route `/` pointing to the Home Page.
- **Theming**: A robust Material 3 Light Theme is set up with custom colors, typography (`Quicksand`, `DMSans`), and component themes (buttons, cards, inputs) in `app_theme.dart`.
- **Environment Variables**: Integrated `flutter_dotenv` mapping to `.env` variables like `API_BASE_URL` and `RAZORPAY` keys.

### Features
- **Home Feature (`lib/features/home/`)**: Currently contains a basic presentation layer with a placeholder `HomePage` screen ("Welcome to Fine Route! Clean Architecture Boilerplate.").
- **Auth Feature (`lib/features/auth/`)**: Folder structure scaffolded (`data`, `domain`, `presentation`) but no logic or screens implemented yet.

## 4. Key Workflows
- **State**: BLoCs should be placed in `presentation/bloc` inside their respective features.
- **Dependencies**: Always register new services, repositories, and use cases in `lib/di/injection_container.dart`.
- **Navigation**: Add new screens as `GoRoute` entries in `lib/config/routes/app_router.dart`.
