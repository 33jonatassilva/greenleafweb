import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja GreenLeaf'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de pesquisa
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar produtos...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),

            // Categorias
            const Text(
              'Categorias',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(icon: Icons.spa, label: 'Beleza'),
                  SizedBox(width: 10),
                  CategoryCard(icon: Icons.cleaning_services, label: 'Limpeza'),
                  SizedBox(width: 10),
                  CategoryCard(icon: Icons.fastfood, label: 'Alimentícios'),
                  SizedBox(width: 10),
                  CategoryCard(icon: Icons.pets, label: 'Pets'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Produtos em destaque
            const Text(
              'Produtos em Destaque',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
              children: const [
                ProductCard(
                  name: 'Shampoo Natural',
                  price: 24.90,
                  category: 'Beleza',
                  image: 'assets/images/beauty1.jpg',
                ),
                ProductCard(
                  name: 'Detergente Ecológico',
                  price: 8.50,
                  category: 'Limpeza',
                  image: 'assets/images/clean1.jpg',
                ),
                ProductCard(
                  name: 'Snack para Cães',
                  price: 15.90,
                  category: 'Pets',
                  image: 'assets/images/pet1.jpg',
                ),
                ProductCard(
                  name: 'Arroz Integral Orgânico',
                  price: 12.90,
                  category: 'Alimentícios',
                  image: 'assets/images/food1.jpg',
                ),
              ],
            ),

            // Ofertas especiais
            const SizedBox(height: 20),
            const Text(
              'Ofertas Especiais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SpecialOfferCard(
                    name: 'Kit Beleza Sustentável',
                    originalPrice: 89.90,
                    discountPrice: 69.90,
                    image: 'assets/images/beauty_kit.jpg',
                  ),
                  SizedBox(width: 15),
                  SpecialOfferCard(
                    name: 'Limpeza Completa',
                    originalPrice: 45.00,
                    discountPrice: 32.90,
                    image: 'assets/images/clean_kit.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  
  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.green),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String category;
  final String image;
  
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10)),
              child: kIsWeb
                  ? Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.shopping_bag)),
                      ),
                    )
                  : Image.asset(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'R\$ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name adicionado ao carrinho')),
                      );
                    },
                    child: const Text(
                      'Comprar',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  final String name;
  final double originalPrice;
  final double discountPrice;
  final String image;
  
  const SpecialOfferCard({
    super.key,
    required this.name,
    required this.originalPrice,
    required this.discountPrice,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10)),
                child: kIsWeb
                    ? Image.network(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Center(child: Icon(Icons.local_offer)),
                        ),
                      )
                    : Image.asset(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'R\$ ${originalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'R\$ ${discountPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$name adicionado ao carrinho')),
                        );
                      },
                      child: const Text(
                        'Adicionar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}