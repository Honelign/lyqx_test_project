# Fake Store App

A Flutter application that interacts with the Fake Store API to display products, manage cart, and wishlist functionality.

## Features

- **Authentication**
  - Login with username and password
  - Form validation
  - Show/hide password functionality

- **Product Listing**
  - Display products with images, names, prices, and ratings
  - Lazy loading (load more products when scrolling)
  - Product details view

- **Cart Management**
  - Add products to cart
  - Remove products from cart
  - Update product quantities
  - Display cart total

- **Wishlist (Local Storage)**
  - Add products to wishlist
  - Remove products from wishlist
  - View all wishlist products
  - Store wishlist locally using shared_preferences

## Tech Stack

- **API Calls**: Dio
- **State Management**: BLoC (flutter_bloc)
- **Dependency Injection**: Injectable & Get_it
- **Local Storage**: Shared_preferences, Flutter Secure Storage
- **Navigation**: GoRouter
- **Other Libraries**:
  - cached_network_image (for image caching)
  - flutter_rating_bar (for product ratings)
  - equatable (for value equality)
  - dartz (for functional programming)
  - json_annotation & json_serializable (for JSON serialization)

## Architecture

The project follows Clean Architecture principles with the following layers:

- **Presentation Layer**: UI components, BLoCs
- **Domain Layer**: Entities, Use Cases, Repository Interfaces
- **Data Layer**: Repository Implementations, Data Sources, Models

## Project Structure

```
lib/
├── core/
│   ├── api/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── routes/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── products/
│   ├── cart/
│   └── wishlist/
└── main.dart
```

Each feature follows the same structure:

```
feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate code
4. Run the app with `flutter run`

## Login Credentials

Use the following credentials to log in:

- **Username**: johnd
- **Password**: m38rmF$

## Development Time

The estimated time to deliver this project would be approximately 16-20 hours, including:

- Project setup and architecture: 2-3 hours
- Authentication implementation: 2-3 hours
- Products listing and details: 4-5 hours
- Cart functionality: 3-4 hours
- Wishlist functionality: 3-4 hours
- Testing and bug fixing: 2-3 hours



## Screenshots

### Products Screen
![Product Screen](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.00.30.png)

### Wishlist Screen
![Wsihlist Screen](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.00.39.png)

### Cart List empty
!['Cart List](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.00.43.png)

### Cart List
![Cart List](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.00.52.png)

### Product detail
![Product detail](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.00.59.png)

### Login Screen
![Login Screen](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.02.42.png)

### Welcome Screen
![Welcome Screen](screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-05-26%20at%2002.02.57.png)
