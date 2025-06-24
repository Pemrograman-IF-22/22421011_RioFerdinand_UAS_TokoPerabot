import 'package:flutter/material.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/views/screens/home_screen.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/views/screens/login_screen.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/views/screens/profile_screen.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/core/network/dio_client.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/controllers/auth_controller.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/views/screens/add_product_screen.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/views/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

Future<String> _getInitialRoute() async {
  final authController = AuthController();
  final token = await authController.getToken();
  debugPrint('Current token: $token');
  final isLoggedIn = token != null && token.isNotEmpty;
  return isLoggedIn ? '/home' : '/login';
}


  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner : false,
          navigatorKey: navigatorKey,
          title: 'Toko Perabot',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          initialRoute: snapshot.data,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/add-product': (context) => const AddProductScreen(),
            '/register': (context) => const RegisterScreen(),

          },
        );
      },
    );
  }
}