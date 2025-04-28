import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (mantido igual)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage('assets/images/user_avatar.png'),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Hi, Jamilson!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('São Paulo, Brazil', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications_none),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Card de Pontuação (mantido igual)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        infoColumn(Icons.monetization_on, '5000\nPOINTS'),
                        infoColumn(Icons.cloud, 'SAVED\nCO2'),
                        infoColumn(Icons.recycling, 'RECYCLED'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Materiais (mantido igual)
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(material['image']!, fit: BoxFit.contain),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                material['name']!,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Ecopontos (área modificada)
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
                            boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                            ],
                        ),
                        child: Row(
                            children: [
                            // Padding adicionado apenas no lado esquerdo da imagem
                            Padding(
                                padding: const EdgeInsets.only(left: 12), // Ajuste este valor conforme necessário
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                    width: 105,
                                    height: 105,
                                    child: Image.asset(
                                    'assets/images/map_sample.png',
                                    fit: BoxFit.cover,
                                    ),
                                ),
                                ),
                            ),
                            const SizedBox(width: 12),
                            // Conteúdo textual
                            Expanded(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    station,
                                    style: const TextStyle(
                                        fontSize: 14, 
                                        fontWeight: FontWeight.w600,
                                    ),
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
            
            // Botão da loja fixo no canto direito (mantido igual)
            Positioned(
              bottom: 30,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                elevation: 4,
                onPressed: () {
                  // ação do botão
                },
                child: const Icon(Icons.store, size: 28),
              ),
            ),
          ],
        ),
      ),

      // Barra de navegação inferior (mantido igual)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
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

// Componente para infoCard (mantido igual)
class infoColumn extends StatelessWidget {
  final IconData icon;
  final String text;
  const infoColumn(this.icon, this.text);

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