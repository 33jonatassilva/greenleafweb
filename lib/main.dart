import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Adicionado para kIsWeb
import 'views/login/login_page.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


void main() {
  runApp(const GreenLeafApp());
}

class GreenLeafApp extends StatelessWidget {
  const GreenLeafApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenLeaf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity, // Melhora adaptação
      ),
      home: const LoginPage(),
      //home_page: const HomePage(),
      //impact_page: const ImpactPage(),
      //learn_page: const LearnPage(),
      //materials_details_page: const MaterialDetailsPage(),
      //notifications_page: const NotificationsPage();
      //profile_page: const ProfilePage(),
      //stations_page: const StationsPage(),
      //store_page: const StorePage();

      builder: (context, child) {
        // Adaptações específicas para web
        if (kIsWeb) {
          return Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600), // Limita largura
                child: child,
              ),
            ),
          );
        }
        return child!;
      },
    );
  }
}