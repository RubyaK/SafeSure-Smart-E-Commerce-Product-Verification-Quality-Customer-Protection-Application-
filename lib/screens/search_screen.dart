import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'product_details_screen.dart'; // ProductDetailsScreen ইম্পোর্ট করা হলো

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // প্রোডাক্টের বিশদ বিবরণসহ লিস্ট (আইডি, নাম, দাম, ইমেজ)
  final List<Map<String, dynamic>> allProducts = [
    {
      'id': 'p1',
      'title': 'Smart Noise-Canceling Headphones',
      'price': 120.0,
      'imageUrl':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    },
    {
      'id': 'p2',
      'title': 'Wireless Gaming Mouse',
      'price': 45.0,
      'imageUrl':
          'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500',
    },
    {
      'id': 'p3',
      'title': 'Smart Fitness Watch',
      'price': 75.50,
      'imageUrl':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
    },
    {
      'id': 'p4',
      'title': 'Casual Denim Jacket',
      'price': 65.0,
      'imageUrl':
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  void _filterSearch(String query) {
    setState(() {
      filteredProducts = allProducts
          .where(
            (item) => item['title'].toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _filterSearch,
          // কিবোর্ডের এন্টার প্রেস করার জন্য এই দুটি লাইন যোগ করা হয়েছে
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (filteredProducts.isNotEmpty) {
              final product = filteredProducts.first;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    productId: product['id'],
                    productTitle: product['title'],
                    productPrice: product['price'],
                    imageUrl: product['imageUrl'],
                  ),
                ),
              );
            }
          },
          decoration: const InputDecoration(
            hintText: 'Search verified products...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: filteredProducts.isEmpty
          ? const Center(
              child: Text(
                'No products found!',
                style: TextStyle(color: AppColors.textMuted, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderGrey),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        product['imageUrl'],
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image,
                              size: 45,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                    title: Text(
                      product['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    subtitle: Text(
                      '\$${product['price']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // সার্চ রেজাল্ট থেকে প্রোডাক্টে ক্লিক করলে ডিটেইলস পেজে নিয়ে যাবে
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            productId: product['id'],
                            productTitle: product['title'],
                            productPrice: product['price'],
                            imageUrl: product['imageUrl'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
