import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/screens/details.dart';
import 'package:group_chat/screens/home.dart';
import 'package:group_chat/utils.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/chat_page.dart';
import 'screens/login_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCro5KSax45Wj5SCNHPa2gFkD-PckR9I8g",
        authDomain: "chatbox-b05ba.firebaseapp.com",
        projectId: "chatbox-b05ba",
        storageBucket: "chatbox-b05ba.appspot.com",
        messagingSenderId: "1004775718427",
        appId: "1:1004775718427:web:177375e437749e597302be",
      ));

  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatBox',
        theme: ThemeData(
          textTheme: TextStyles.cherrySwashTextTheme,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthChecker(),
          "/details":(context)=>Details(),
          '/login': (context) => LoginScreen(),
          '/chat': (context) => ChatPage(),

        },

      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {

          return authProvider.isFirstTimeLogin ? ChatPage(): Details();
        } else {

          return const Home();
        }
      },
    );
  }
}

