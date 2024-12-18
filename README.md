# Chat App 💬

Welcome to the **Chat App** repository! This project is a real-time messaging application built using **Flutter** for cross-platform development and **Firebase** for backend services. It enables users to send and receive messages instantly, create customizable user profiles, and share media in a secure environment.

This app is designed with **MVVM (Model-View-ViewModel)** architecture, ensuring maintainable and scalable code. Whether you're looking to use this as a reference project or extend its functionality, this repository provides a solid foundation for building real-time chat applications.

---

## Features ✨

This application comes with several key features to enhance the chat experience:

* 🗨️ **Real-Time Chat**: 
   - Send and receive messages in real-time using Firebase Firestore, ensuring instant communication between users.
* 🔐 **Authentication**:
   - Secure user login and registration via Firebase Authentication, supporting both email/password and third-party authentication methods (Google, Facebook, etc.).
* 👤 **User Profiles**:
   - Users can create and customize their profiles, including uploading a profile image.
* 📸 **Media Sharing**:
   - Send and receive images and other media files within chat messages using Firebase Storage.
* 💬 **Message History**:
   - View and search the complete chat history stored in Firebase Firestore, allowing users to access past conversations.
* 🛡️ **Security**:
   - Firebase Security Rules are used to protect user data and prevent unauthorized access to the database.
* 🌙 **Dark Mode**:
   - The app supports both light and dark themes, offering users a personalized and comfortable interface.

---

## Requirements 📋

Before you get started, ensure you have the following installed and configured:

* **Flutter**: The app is built using Flutter for cross-platform development (Android, iOS).
  - You can download and install Flutter from [Flutter's official website](https://flutter.dev/docs/get-started/install).
* **Dart**: The app is developed using Dart programming language. Dart comes pre-installed with Flutter.
* **Firebase**: Firebase is used for authentication, real-time database (Firestore), and storage services.
  - To set up Firebase, create a project on [Firebase Console](https://console.firebase.google.com/).
* **Flutter version**: 3.24.3 or higher.
* **Dart version**: 3.5.3 or higher.

---

## Installation Guide 🛠️

Follow these steps to run the app locally on your machine:

1. **Clone the repository:**
   - Open a terminal and run the following command to clone the repository:
     ```bash
     git clone https://github.com/ASEGIDADANE/chat-app.git
     cd chat-app
     ```

2. **Install dependencies:**
   - Make sure you have Flutter and Dart installed. Then, fetch the necessary packages by running:
     ```bash
     flutter pub get
     ```

3. **Set up Firebase:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Add your Flutter app to the Firebase project by following the Firebase setup instructions for [Android](https://firebase.flutter.dev/docs/overview#installation) and [iOS](https://firebase.flutter.dev/docs/overview#installation).
   - Download the configuration files for Android (`google-services.json`) and iOS (`GoogleService-Info.plist`) from Firebase and add them to your project:
     - Place `google-services.json` in the `android/app` directory.
     - Place `GoogleService-Info.plist` in the `ios/Runner` directory.
   - Enable Firebase Authentication and Firestore in the Firebase Console.

4. **Run the app:**
   - Finally, to launch the app on your emulator or physical device, run:
     ```bash
     flutter run
     ```

---

## App Structure 🗂️

The app is organized following the **MVVM (Model-View-ViewModel)** design pattern to separate concerns and make the code more maintainable.

### `lib/`

* **`models/`**: Contains the data models representing users and messages.
* **`views/`**: Contains all UI components, including screens for login, chat, and user profile.
* **`viewmodels/`**: Contains the business logic and state management. This layer connects the models and views.
* **`services/`**: Contains the Firebase services for authentication, Firestore, and other utility classes like image upload handling.

---

## Firebase Setup 🔑

To set up Firebase in your Flutter project:

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Add Firebase to your Flutter app:
   - Follow the instructions for both **Android** and **iOS** provided in the Firebase setup guides.
3. Set up Firebase Authentication:
   - Enable **Email/Password Authentication** or any other sign-in providers (Google, Facebook, etc.) under the "Authentication" section in Firebase.
4. Set up Firestore:
   - Enable **Cloud Firestore** to store and sync messages in real-time.
5. Set up Firebase Storage:
   - Use Firebase Storage to store images and media shared within chats.
6. Download and configure the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files as per Firebase setup.

---

## How to Contribute 💡

We welcome contributions! If you’d like to contribute to this project, follow these steps:

1. **Fork the repository** on GitHub.
2. **Clone your fork** to your local machine:
   ```bash
   git clone https://github.com/your-username/chat-app.git
   cd chat-app
git checkout -b feature/your-feature
git commit -am 'Add new feature or fix'
git push origin feature/your-feature

