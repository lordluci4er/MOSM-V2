import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/theme/app_theme.dart';
import 'core/services/firebase_service.dart';
import 'shared/widgets/loading_widget.dart';

// Screens
import 'features/auth/presentation/screens/login_screen.dart';
import 'core/navigation/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOSM',
      debugShowCheckedModeBanner: false,

      /// 🔥 DARK THEME USE
      theme: AppTheme.darkTheme,

      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        /// 🔥 LOADING SCREEN (UPGRADED)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: LoadingWidget(
              text: "Checking authentication...",
            ),
          );
        }

        /// ✅ LOGGED IN
        if (snapshot.hasData) {
          return const MainScreen();
        }

        /// ❌ NOT LOGGED IN
        return const LoginScreen();
      },
    );
  }
}