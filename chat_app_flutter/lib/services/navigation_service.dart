import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:RegisterPage ';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // Define routes in a map
  final Map<String, Widget Function(BuildContext)> _routes = {
    '/login': (context) =>
        const loginpage(), // Ensure your page names are capitalized
    '/home': (context) => const HomePage(),
    '/register': (context) => const RegisterPage(),
  };

  // Get the navigator key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Get the routes
  Map<String, Widget Function(BuildContext)> get routes => _routes;

  // Navigate to a named route
  void pushNamed(String routeName) {
    if (_routes.containsKey(routeName)) {
      _navigatorKey.currentState?.pushNamed(routeName);
    } else {
      print('Route $routeName not found!'); // Error handling for missing routes
    }
  }

  // Replace the current route with a new one
  void pushReplacementNamed(String routeName) {
    if (_routes.containsKey(routeName)) {
      _navigatorKey.currentState?.pushReplacementNamed(routeName);
    } else {
      print('Route $routeName not found!'); // Error handling for missing routes
    }
  }

  void push(MaterialPageRoute route) {
    _navigatorKey.currentState?.push(route);
  }

  // Go back to the previous route
  void goBack() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    } else {
      print('No routes to go back to!'); // Error handling for no routes to pop
    }
  }
}
