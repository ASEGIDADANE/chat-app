# Chat App Documentation

## Project Overview
This project is a Flutter-based chat application designed to demonstrate the use of Firebase for authentication and data storage. The app uses the MVVM (Model-View-ViewModel) architecture for separation of concerns and implements state management using the Provider package. This application showcases features like user registration, real-time messaging, and image upload using Firebase Storage.

---

## Architecture

### MVVM Architecture
The project follows the MVVM (Model-View-ViewModel) pattern to separate business logic and UI components.

- **Model:** Represents the data structure and business logic of the app. It interacts with Firebase to fetch or store data.
- **View:** The UI components of the app. These include pages and widgets, which are responsible for displaying data to the user.
- **ViewModel:** Acts as a bridge between the Model and View. It retrieves data from the Model and exposes it to the View, ensuring that the View only contains UI-related logic.

---

## Data Flow
1. **User Interaction:** The user interacts with the UI (View) components, such as sending messages or uploading images.
2. **Event Triggering:** UI triggers an event which is sent to the ViewModel.
3. **ViewModel Processing:** The ViewModel processes the event and interacts with the Model.
4. **Firebase Operations:** The Model handles interactions with Firebase services (e.g., Firestore for data storage, Firebase Storage for image upload).
5. **Data Update:** Once the data is fetched or updated, the Model sends the result back to the ViewModel.
6. **State Emission:** The ViewModel updates the state, which the View listens to and updates the UI accordingly.

---

## Folder Structure


- **data/models:** Contains data models, such as user profiles and messages.
- **data/repositories:** Contains repository implementations for interacting with Firebase services.
- **data/data_sources:** Contains Firebase data sources, like Firestore and Firebase Storage.
- **domain/entities:** Contains entity classes, such as user and message.
- **domain/use_cases:** Contains business logic implementations for data handling.
- **presentation/view_models:** Contains ViewModel classes that manage the state and interact with the Model.
- **presentation/pages:** Contains UI pages, such as the chat room and login pages.
- **presentation/widgets:** Contains reusable UI widgets.
- **main.dart:** Entry point of the application.

---

## Test Driven Development (TDD)
The project follows TDD principles, which ensures that functionality is developed in cycles of writing tests, implementing the feature, and refactoring code.

- **Unit Tests:** For testing individual components, such as repositories, ViewModels, and Firebase interactions.
- **Widget Tests:** For testing UI components like login screens and message displays.
- **Integration Tests:** For testing the overall application flow, including user authentication and message sending.

---

## Dependencies
- **firebase_core:** For initializing Firebase in the Flutter app.
- **firebase_auth:** For Firebase authentication, including user registration and login.
- **cloud_firestore:** For interacting with Firestore to store and retrieve chat messages.
- **firebase_storage:** For uploading user profile images and message media to Firebase Storage.
- **provider:** For state management using the Provider package.
- **flutter_test:** For writing tests.

---

## Conclusion
This documentation provides an overview of the architecture, data flow, and development practices used in this Flutter-based chat application. By following the MVVM pattern and using Firebase for backend services, the project is structured to be scalable, maintainable, and testable. The use of Test Driven Development ensures that each feature is thoroughly tested, providing a reliable chat app solution.
