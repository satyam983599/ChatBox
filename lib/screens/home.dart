import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/flags/image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () async {
                await authProvider.loginWithGoogle();
              },
              icon: Image.asset(
                "assets/flags/logos_google-icon.png",
                height: 24.0,
              ),
              label: const Text(
                "Sign in with Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Poppins",
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF438E96),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
