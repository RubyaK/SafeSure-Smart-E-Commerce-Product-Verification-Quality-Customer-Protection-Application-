import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Delivery Addresses',
          style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryGreen, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Home Address (Default)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                    ),
                    Icon(Icons.check_circle, color: AppColors.primaryGreen, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Rubya', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('+880 1712-345678', style: TextStyle(color: AppColors.textMuted)),
                const Text('123 Green Road, Dhanmondi, Dhaka', style: TextStyle(color: AppColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add New Address feature coming soon!')),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Add New Address', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}