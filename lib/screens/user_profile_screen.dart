import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'order_tracking_screen.dart';
import 'role_selection_screen.dart';
import 'address_screen.dart'; // নতুন অ্যাড্রেস স্ক্রিন ইম্পোর্ট
import 'notification_settings_screen.dart'; // নতুন নোটিফিকেশন স্ক্রিন ইম্পোর্ট

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading:
            false, // Bottom tab navigation-এ back icon দরকার নেই
        title: const Text(
          'My Account & Security',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderGrey),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryGreen,
                    child: Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rubya',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'rubya@safesure.com',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Profile Options List
            _buildProfileTile(
              icon: Icons.location_on_outlined,
              title: 'Delivery Addresses',
              subtitle: '123 Green Road, Dhaka',
              onTap: () {
                // AddressScreen-এ নেভিগেট করবে
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressScreen(),
                  ),
                );
              },
            ),
            _buildProfileTile(
              icon: Icons.shield_outlined,
              title: 'SafeSure Escrow Protection Status',
              subtitle: 'Active Guarantee On All Orders',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'SafeSure Escrow Balance: \$120.00 Protected',
                    ),
                  ),
                );
              },
            ),
            _buildProfileTile(
              icon: Icons.history,
              title: 'Order History & Claims',
              subtitle: 'View past orders & dispute resolution',
              onTap: () {
                // Order Tracking Screen-এ নিয়ে যাবে
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderTrackingScreen(),
                  ),
                );
              },
            ),
            _buildProfileTile(
              icon: Icons.notifications_outlined,
              title: 'Notification Settings',
              subtitle: 'Order updates and quality alerts',
              onTap: () {
                // NotificationSettingsScreen-এ নেভিগেট করবে
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationSettingsScreen(),
                  ),
                );
              },
            ),
            _buildProfileTile(
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {
                // সরাসরি Role Selection পেজে ফেরত নিয়ে যাবে
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoleSelectionScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color textColor = AppColors.primaryDark,
    Color iconColor = AppColors.primaryGreen,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
