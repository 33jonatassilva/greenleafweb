import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb
import '../../services/user_service.dart';
import '../../models/user_model.dart';
import '../scanner/scanner_page.dart';
import '../stations/stations_page.dart';
import '../learn/learn_page.dart';
import '../profile/profile_page.dart';
import '../impact/impact_page.dart';
import '../store/store_page.dart';
import '../notifications/notifications_page.dart';
import '../materials/materials_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final UserService _userService = UserService();

  List<Widget> get _widgetOptions => <Widget>[
        HomeContent(userService: _userService),
        const StationsPage(),
        // Substitui ScannerPage por um placeholder na web
        kIsWeb
            ? const Center(child: Text("Scanner não disponível na web"))
            : const ScannerPage(),
        const LearnPage(),
        ProfilePage(userService: _userService),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Stations'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final UserService userService;
  
  const HomeContent({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    final materials = [
      {'name': 'Plastic', 'image': 'assets/images/plastic.png'},
      {'name': 'Glass', 'image': 'assets/images/glass.png'},
      {'name': 'Metal', 'image': 'assets/images/metal.png'},
      {'name': 'Paper', 'image': 'assets/images/paper.png'},
    ];

    final binStations = [
      'EcoPonto Jardim São Luís',
      'EcoPonto Santo Amaro',
      'EcoPonto Brooklin',
    ];

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header com ListenableBuilder
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(userService: userService),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: kIsWeb
                                ? NetworkImage('assets/images/user_avatar.png')
                                      as ImageProvider
                                : const AssetImage('assets/images/user_avatar.png'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ListenableBuilder(
                          listenable: userService,
                          builder: (context, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, ${userService.currentUser.name}!',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${userService.currentUser.city}, ${userService.currentUser.state}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NotificationsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Card de Impacto
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ImpactPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoColumn(Icons.monetization_on, '5000\nPOINTS'),
                        InfoColumn(Icons.cloud, 'SAVED\nCO2'),
                        InfoColumn(Icons.recycling, 'RECYCLED'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Seção de Materiais
                const Text(
                  'Materials',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: materials.length,
                    itemBuilder: (context, index) {
                      final material = materials[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialDetailsPage(
                                materialName: material['name']!,
                                materialImage: material['image']!,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: kIsWeb
                                      ? Image.network(
                                          material['image']!,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.asset(
                                          material['image']!,
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                material['name']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Seção de Ecopontos
                const Text(
                  'Nearby Bin Stations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Column(
                  children: binStations.map((station) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 105,
                                height: 105,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: kIsWeb
                                        ? NetworkImage(
                                            'assets/images/map_sample.png')
                                                as ImageProvider
                                        : const AssetImage(
                                            'assets/images/map_sample.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  station,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  )).toList(),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
          
          // Botão da Loja
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              elevation: 4,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StorePage()),
                );
              },
              child: const Icon(Icons.store, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final IconData icon;
  final String text;
  const InfoColumn(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 6),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}