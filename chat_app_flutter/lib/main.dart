// import 'dart:ffi';

// import 'package:chat_app/pages/login_pages.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:chat_app/utils.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await setup();
  runApp(
    DevicePreview(
      enabled: true, // Change this to false to disable in production
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyApp(),
    ),
  );
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerService();
}
Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  late NavigationService _naviagtionService;
  late AuthService _authService;
  MyApp({super.key}) {
    _naviagtionService = getIt.get<NavigationService>();
    _authService = getIt.get<AuthService>();
 
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _naviagtionService.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      // home: loginpage(),
      // Ensure this is the correct reference
      
      initialRoute: _authService.user != null?'/home':'/login',
      routes: _naviagtionService.routes,
      builder: DevicePreview.appBuilder, // Add this line
    );
  }
}
