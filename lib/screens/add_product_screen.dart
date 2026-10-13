import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // ১. TextEditingControllers
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  // ২. Certificate Upload State
  bool _hasUploadedCertificate = false;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Certificate / Proof Upload Handler
  void _pickCertificate() {
    setState(() {
      _hasUploadedCertificate = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quality Certificate attached successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Strict Validation & Submission Logic
  void _submitProduct() {
    final title = _titleController.text.trim();
    final priceText = _priceController.text.trim();
    final stockText = _stockController.text.trim();
    final description = _descriptionController.text.trim();

    // Check Product Title
    if (title.isEmpty) {
      _showError('Please enter a product title');
      return;
    }

    // Check Price Validation
    if (priceText.isEmpty) {
      _showError('Please enter the product price');
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null || price <= 0) {
      _showError('Please enter a valid price amount');
      return;
    }

    // Check Stock Validation
    if (stockText.isEmpty) {
      _showError('Please enter stock quantity');
      return;
    }

    final stock = int.tryParse(stockText);
    if (stock == null || stock < 1) {
      _showError('Stock quantity must be at least 1');
      return;
    }

    // Check Quality Certificate Upload (Mandatory for SafeSure)
    if (!_hasUploadedCertificate) {
      _showError('Quality Test Report / Lab Certificate is required!');
      return;
    }

    // Check Description
    if (description.isEmpty) {
      _showError('Please enter a product description');
      return;
    }

    if (description.length < 10) {
      _showError('Description must be at least 10 characters long');
      return;
    }

    // If All Validations Pass
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product submitted successfully! Quality score pending.'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
          'Add Verified Product',
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
            // Product Name
            const Text(
              'Product Title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'e.g., Wireless Mechanical Keyboard',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Price & Stock Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price (\$)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: '75.00',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.borderGrey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.borderGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Stock Quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '50',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.borderGrey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.borderGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Quality & Certificate Details Box (Clickable Upload)
            const Text(
              'Quality Assurance Proof / Certificate *Required',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickCertificate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: _hasUploadedCertificate ? Colors.green.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _hasUploadedCertificate ? Colors.green : AppColors.primaryGreen,
                    width: _hasUploadedCertificate ? 2 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _hasUploadedCertificate ? Icons.check_circle : Icons.verified_outlined,
                      size: 36,
                      color: _hasUploadedCertificate ? Colors.green : AppColors.primaryGreen,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _hasUploadedCertificate
                          ? 'Lab Certificate Attached Successfully!'
                          : 'Upload Quality Test Report / Lab Certificate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: _hasUploadedCertificate ? Colors.green.shade800 : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Required for SafeSure algorithmic verification score',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Product Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                    'Enter specifications, material quality, and warranty details...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            CustomButton(
              text: 'Submit Product for Verification',
              onPressed: _submitProduct,
            ),
          ],
        ),
      ),
    );
  }
}