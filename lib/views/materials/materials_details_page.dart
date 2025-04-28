import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class MaterialDetailsPage extends StatelessWidget {
  final String materialName;
  final String materialImage;

  const MaterialDetailsPage({
    Key? key,
    required this.materialName,
    required this.materialImage,
  }) : super(key: key);

  // Função para gerar dados dummy
  static List<Map<String, dynamic>> _generateDummyData(String material) {
    final now = DateTime.now();
    return List.generate(30, (index) {
      final date = now.subtract(Duration(days: 29 - index));
      return {
        'date': date,
        'quantity': (1 + index % 5).toDouble(),
        'points': (5 + index % 10) * 10,
      };
    });
  }

  double _calculateTotalRecycled(List<Map<String, dynamic>> recyclingHistory) {
    return recyclingHistory.fold(0, (sum, item) => sum + (item['quantity'] as double));
  }

  @override
  Widget build(BuildContext context) {
    final recyclingHistory = _generateDummyData(materialName);
    final totalRecycled = _calculateTotalRecycled(recyclingHistory);

    return Scaffold(
      appBar: AppBar(
        title: Text(materialName),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                kIsWeb
                    ? Image.network(
                        materialImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Icon(Icons.recycling, size: 50),
                        ),
                      )
                    : Image.asset(
                        materialImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                const SizedBox(height: 16),
                Text(
                  'Total Recycled',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '$totalRecycled kg',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(
                      'Last 7 days',
                      recyclingHistory.sublist(23).fold(0, (sum, item) => sum + (item['quantity'] as double)),
                    ),
                    _buildStatItem(
                      'Earned Points',
                      recyclingHistory.fold(0, (sum, item) => sum + (item['points'] as int)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recyclingHistory.length,
              itemBuilder: (context, index) {
                final item = recyclingHistory[index];
                final date = item['date'] as DateTime;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.recycling, color: Colors.green),
                    title: Text('${item['quantity']} kg recycled'),
                    subtitle: Text('${date.day}/${date.month}/${date.year}'),
                    trailing: Text(
                      '+${item['points']} pts',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, num value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}