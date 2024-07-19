import 'package:events_app/providers/favorites_provider.dart';
import 'package:events_app/providers/theme_provider.dart';
import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/views/authentication/login_screen.dart';
import 'package:events_app/views/authentication/register_screen.dart';
import 'package:events_app/views/main.pages/home_page.dart';
import 'package:events_app/views/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Firebase Auth',
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: const SplashScreen(),
          routes: {
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/home': (context) => const HomePage(),
          },
        );
      },
    );
  }
}
