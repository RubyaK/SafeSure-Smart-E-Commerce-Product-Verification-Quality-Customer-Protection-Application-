import 'package0:flutter/material.dart';
import '../constants/app_colors.dart';

class ProductComparisonScreen extends StatelessWidget {
  const ProductComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Compare Products',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Side-by-Side Quality Analysis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Compare verified scores to make a confident purchase.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Comparison Table Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderGrey),
              ),
              child: Column(
                children: [
                  // Product Headers Row
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Features',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                      _buildProductHeader('Smart Headphones', '\$120'),
                      _buildProductHeader('Gaming Headphones', '\$95'),
                    ],
                  ),
                  const Divider(height: 1),

                  // Comparison Rows
                  _buildComparisonRow(
                    'Quality Score',
                    '4.9 / 5.0',
                    '4.5 / 5.0',
                    isHighlight: true,
                  ),
                  _buildComparisonRow(
                    'Seller Trust Rating',
                    '98%',
                    '91%',
                    isHighlight: true,
                  ),
                  _buildComparisonRow(
                    'Build Material',
                    'Alloy + Leather',
                    'ABS Plastic',
                    isHighlight: false,
                  ),
                  _buildComparisonRow(
                    'Warranty',
                    '12 Months',
                    '6 Months',
                    isHighlight: false,
                  ),
                  _buildComparisonRow(
                    'Battery Life',
                    '30 Hours',
                    '20 Hours',
                    isHighlight: false,
                  ),
                  _buildComparisonRow(
                    'Return Dispute Rate',
                    '0.2%',
                    '1.5%',
                    isHighlight: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductHeader(String title, String price) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: const Border(left: BorderSide(color: AppColors.borderGrey)),
        ),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.headphones, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(
    String feature,
    String value1,
    String value2, {
    required bool isHighlight,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isHighlight
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: AppColors.borderGrey)),
                ),
                child: Text(
                  value1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isHighlight
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isHighlight
                        ? AppColors.primaryGreen
                        : AppColors.primaryDark,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: AppColors.borderGrey)),
                ),
                child: Text(
                  value2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isHighlight
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isHighlight ? Colors.blue : AppColors.primaryDark,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1),
      ],
    );
  }
}
