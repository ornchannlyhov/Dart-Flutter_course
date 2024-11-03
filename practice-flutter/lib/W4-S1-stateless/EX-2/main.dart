import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: const Padding(
        padding: EdgeInsets.all(16.0), 
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              ProductCard(product: Product.DART),
              SizedBox(height: 16.0), 
              ProductCard(product: Product.FLUTTER),
              SizedBox(height: 16.0), 
              ProductCard(product: Product.FIREBASE),
            ],
          ),
        ),
      ),
    ),
  ));
}

enum Product {
  FLUTTER('Flutter', 'The best mobile widget library',
      'assets/stateless-img/flutter.png'),
  DART('Dart', 'The best object language', 'assets/stateless-img/dart.png'),
  FIREBASE('FireBase', 'The best cloud database',
      'assets/stateless-img/firebase.png');

  final String title;
  final String description;
  final String image;

  const Product(this.title, this.description, this.image);
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), 
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.image,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8.0),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
