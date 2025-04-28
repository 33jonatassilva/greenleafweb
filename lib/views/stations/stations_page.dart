import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class StationsPage extends StatefulWidget {
  const StationsPage({super.key});

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedState = 'Todos';
  final List<String> _states = [
    'Todos',
    'SP',
    'RJ',
    'MG',
    'RS',
    'PR',
    'SC',
    'BA',
    'PE',
    'CE',
    'DF'
  ];

  final List<Ecopoint> _ecopoints = [
    Ecopoint(
      name: 'Ecoponto Vila Mariana',
      address: 'R. Domingos Fernandes, 100 - Vila Mariana',
      city: 'São Paulo',
      state: 'SP',
      description: 'Aceita plástico, metal, vidro e papel. Aberto de seg a sab das 8h às 18h.',
      imagePath: 'assets/images/map_sample.png',
    ),
    // ... (mantenha todos os outros ecopoints da lista original)
  ];

  List<Ecopoint> get _filteredEcopoints {
    if (_selectedState == 'Todos' && _searchController.text.isEmpty) {
      return _ecopoints;
    }

    return _ecopoints.where((ecopoint) {
      final matchesState = _selectedState == 'Todos' || ecopoint.state == _selectedState;
      final matchesSearch = _searchController.text.isEmpty ||
          ecopoint.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          ecopoint.city.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesState && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecopontos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra de pesquisa e filtro
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar ecopontos...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  items: _states.map((state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedState = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Filtrar por estado',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          // Lista de ecopontos
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEcopoints.length,
              itemBuilder: (context, index) {
                final ecopoint = _filteredEcopoints[index];
                return _buildEcopointCard(context, ecopoint);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEcopointCard(BuildContext context, Ecopoint ecopoint) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do mapa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: kIsWeb
                  ? Image.network(
                      ecopoint.imagePath,
                      width: 130,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 130,
                        height: 220,
                        color: Colors.grey[200],
                        child: const Icon(Icons.map, size: 40),
                      ),
                    )
                  : Image.asset(
                      ecopoint.imagePath,
                      width: 130,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          // Informações do ecoponto
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ecopoint.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${ecopoint.city} - ${ecopoint.state}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ecopoint.address,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ecopoint.description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showMapDialog(context, ecopoint);
                        },
                        child: const Text('Ver no mapa'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMapDialog(BuildContext context, Ecopoint ecopoint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ecopoint.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              kIsWeb
                  ? Image.network(
                      ecopoint.imagePath,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.map, size: 50)),
                      ),
                    )
                  : Image.asset(
                      ecopoint.imagePath,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 16),
              Text(
                '${ecopoint.address}\n${ecopoint.city} - ${ecopoint.state}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // Ação para abrir no mapa externo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Abrindo no Google Maps...'),
                    duration: Duration(seconds: 1),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Abrir no mapa'),
            ),
          ],
        );
      },
    );
  }
}

class Ecopoint {
  final String name;
  final String address;
  final String city;
  final String state;
  final String description;
  final String imagePath;

  Ecopoint({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.description,
    required this.imagePath,
  });
}