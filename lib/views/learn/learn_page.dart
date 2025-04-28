import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprenda sobre Reciclagem'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Jogos Educativos
            _buildSectionTitle('Jogos Educativos'),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildGameCard(
                    context,
                    'Separe os Resíduos',
                    'Aprenda a separar corretamente os diferentes tipos de lixo',
                    Icons.gamepad,
                    Colors.green,
                  ),
                  const SizedBox(width: 13),
                  _buildGameCard(
                    context,
                    'Quiz da Reciclagem',
                    'Teste seus conhecimentos sobre sustentabilidade',
                    Icons.quiz,
                    Colors.blue,
                  ),
                  const SizedBox(width: 13),
                  _buildGameCard(
                    context,
                    'Memória Ecológica',
                    'Encontre os pares de materiais recicláveis',
                    Icons.memory,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Seção de Artigos
            _buildSectionTitle('Artigos Educativos'),
            const SizedBox(height: 16),
            _buildArticleCard(
              context,
              'Como Separar o Lixo Corretamente',
              'Guia completo para separação de resíduos em casa',
              'assets/images/recycling.png',
              'Descubra como pequenas ações em casa podem fazer uma grande diferença para o meio ambiente...',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              context,
              'Os Benefícios da Reciclagem',
              'Impacto positivo no meio ambiente e na economia',
              'assets/images/benefits.png',
              'A reciclagem reduz a extração de recursos naturais, economiza energia e gera empregos...',
            ),
            const SizedBox(height: 24),

            // Seção de Notícias
            _buildSectionTitle('Últimas Notícias'),
            const SizedBox(height: 16),
            _buildNewsCard(
              context,
              'Nova Tecnologia para Reciclagem de Plásticos',
              'Pesquisadores desenvolvem método inovador',
              'assets/images/tech.png',
              '02/05/2023',
            ),
            const SizedBox(height: 16),
            _buildNewsCard(
              context,
              'Cidade Atinge Meta de 50% de Reciclagem',
              'Resultado foi alcançado 6 meses antes do previsto',
              'assets/images/city.png',
              '15/04/2023',
            ),
            const SizedBox(height: 16),
            _buildNewsCard(
              context,
              'Escola Promove Feira de Sustentabilidade',
              'Alunos apresentam projetos criativos com materiais reciclados',
              'assets/images/school.png',
              '28/03/2023',
            ),
            const SizedBox(height: 24),

            // Seção de Vídeos
            _buildSectionTitle('Vídeos Educativos'),
            const SizedBox(height: 16),
            _buildVideoCard(
              context,
              'O Ciclo da Reciclagem',
              'Entenda todo o processo, da coleta à reutilização',
              'assets/images/video1.png',
            ),
            const SizedBox(height: 16),
            _buildVideoCard(
              context,
              'DIY: Reciclagem Criativa',
              'Ideias para reutilizar materiais em casa',
              'assets/images/video2.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, String title, String description, IconData icon, Color color) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 12),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Jogo em desenvolvimento')),
                );
              },
              child: const Text(
                'Jogar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, String title, String subtitle, String imagePath, String description) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: kIsWeb
                ? Image.network(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 50),
                    ),
                  )
                : Image.asset(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Text(description),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Conteúdo completo em desenvolvimento')),
                      );
                    },
                    child: const Text('Ler mais'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, String subtitle, String imagePath, String date) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: kIsWeb
                  ? Image.network(
                      imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, size: 30),
                      ),
                    )
                  : Image.asset(
                      imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notícia completa em desenvolvimento')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, String title, String description, String imagePath) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: kIsWeb
                ? Image.network(
                    imagePath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey[200],
                      child: const Icon(Icons.videocam_off, size: 50),
                    ),
                  )
                : Image.asset(
                    imagePath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}