import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import 'customer_home_screen.dart';
import 'seller_dashboard_screen.dart';
import 'admin_dashboard_screen.dart';
import 'main_navigation_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String selectedRole = 'Customer'; // Default selection

  void _navigateToDashboard() {
    Widget targetScreen;

    if (selectedRole == 'Seller') {
      targetScreen = const SellerDashboardScreen();
    } else if (selectedRole == 'Admin') {
      targetScreen = const AdminDashboardScreen();
    } else {
      // ✅ এখানে CustomerHomeScreen এর পরিবর্তে MainNavigationScreen দেওয়া হলো
      targetScreen = const MainNavigationScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Choose Your Role',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select how you want to experience SafeSure.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Role Cards
              _buildRoleCard(
                role: 'Customer',
                title: 'Customer / Buyer',
                description:
                    'Browse verified quality products with 100% dispute protection.',
                icon: Icons.shopping_bag_outlined,
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                role: 'Seller',
                title: 'Verified Seller',
                description:
                    'List products, track quality scores, and maintain trust rating.',
                icon: Icons.storefront_outlined,
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                role: 'Admin',
                title: 'System Administrator',
                description:
                    'Audit product certificates, oversee scores, and resolve disputes.',
                icon: Icons.admin_panel_settings_outlined,
              ),

              const Spacer(),

              // Dynamic Continue Button
              CustomButton(
                text: 'Continue as $selectedRole',
                onPressed: _navigateToDashboard,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required String title,
    required String description,
    required IconData icon,
  }) {
    bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.borderGrey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: isSelected
                  ? AppColors.primaryGreen
                  : Colors.grey.shade100,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: role,
              groupValue: selectedRole,
              activeColor: AppColors.primaryGreen,
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}