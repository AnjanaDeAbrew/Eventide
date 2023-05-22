import 'package:eventide_organizer_app/firebase_options.dart';
import 'package:eventide_organizer_app/providers/auth/login_provider.dart';
import 'package:eventide_organizer_app/providers/auth/signup_provider.dart';
import 'package:eventide_organizer_app/providers/auth/user_provider.dart';
import 'package:eventide_organizer_app/providers/home/booking_provider.dart';
import 'package:eventide_organizer_app/providers/home/chat_provider.dart';
import 'package:eventide_organizer_app/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => SignupProvider()),
      ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => BookingProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = const MaterialColor(0xffCE1F1F, <int, Color>{
      50: Color.fromARGB(255, 206, 31, 31),
      100: Color.fromARGB(255, 206, 31, 31),
      200: Color.fromARGB(255, 206, 31, 31),
      300: Color.fromARGB(255, 206, 31, 31),
      400: Color.fromARGB(255, 206, 31, 31),
      500: Color.fromARGB(255, 206, 31, 31),
      600: Color.fromARGB(255, 206, 31, 31),
      700: Color.fromARGB(255, 206, 31, 31),
      800: Color.fromARGB(255, 206, 31, 31),
      900: Color.fromARGB(255, 206, 31, 31),
    });
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      theme: ThemeData(primarySwatch: mycolor),
    );
  }
}
