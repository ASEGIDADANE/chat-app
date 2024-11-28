
import 'package:chat_app/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  // Getter to access the current user
  User? get user => _user;

  // AuthService constructor
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangeStreamListener);
  }

  
  Future<bool> login(String email, String password) async {
    if (!emailPattern.hasMatch(email)) {
      print('Invalid email format');
      return false;
    }

    // Validate password
    if (!passwordPattern.hasMatch(password)) {
      print(
          'Password must be at least 8 characters long, contain at least one letter and one number');
      return false;
    }
    try {
      print('Attempting login with email: $email and password: $password');
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        _user = credential.user;
        print('User logged in successfully: ${_user?.email}');
        return true;
      } else {
        print('No user returned after login attempt');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        _user = credential.user; // Store the signed-up user
        return true;
      }
      return false; // Returns false if no user is created
    } catch (e) {
      print(e); // Log error for debugging
      return false; // Return false in case of an error
    }
  }

  // Listener for auth state changes
  void authStateChangeStreamListener(User? user) {
    if (user != null) {
      _user = user;
      print('User is now: ${_user?.email}');
    } else {
      _user = null;
      print('User is logged out');
    }
  }

  // Logout method
  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      print('User has been logged out');
      return true;
    } catch (e) {
      print('Logout error: $e'); // More descriptive error message
    }
    return false;
  }
}
