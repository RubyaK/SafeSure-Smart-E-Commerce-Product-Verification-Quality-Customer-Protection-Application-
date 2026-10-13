import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // নোটিফিকেশন টগল বাটনগুলোর স্টেট
  bool _orderUpdates = true;
  bool _escrowAlerts = true;
  bool _qualityAlerts = true;
  bool _promotionalOffers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Manage how SafeSure notifies you about orders, security, and updates.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // Settings Group Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Column(
              children: [
                _buildSwitchTile(
                  title: 'Order Updates',
                  subtitle: 'Get notified when order status changes (Shipped, Delivered)',
                  value: _orderUpdates,
                  onChanged: (val) {
                    setState(() {
                      _orderUpdates = val;
                    });
                  },
                ),
                const Divider(height: 1, color: AppColors.borderGrey),
                _buildSwitchTile(
                  title: 'SafeSure Escrow Alerts',
                  subtitle: 'Updates regarding fund protection and release',
                  value: _escrowAlerts,
                  onChanged: (val) {
                    setState(() {
                      _escrowAlerts = val;
                    });
                  },
                ),
                const Divider(height: 1, color: AppColors.borderGrey),
                _buildSwitchTile(
                  title: 'Quality & Dispute Alerts',
                  subtitle: 'Get alerts on your evidence review and complaints',
                  value: _qualityAlerts,
                  onChanged: (val) {
                    setState(() {
                      _qualityAlerts = val;
                    });
                  },
                ),
                const Divider(height: 1, color: AppColors.borderGrey),
                _buildSwitchTile(
                  title: 'Promotional Offers',
                  subtitle: 'Receive discount codes, deals, and recommendations',
                  value: _promotionalOffers,
                  onChanged: (val) {
                    setState(() {
                      _promotionalOffers = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      ),
      value: value,
      activeColor: AppColors.primaryGreen,
      onChanged: onChanged,
    );
  }
}