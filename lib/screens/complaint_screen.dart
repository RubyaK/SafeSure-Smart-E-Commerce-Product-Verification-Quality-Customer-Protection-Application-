import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  String selectedReason = 'Damaged Product';
  final _descriptionController = TextEditingController();
  
  // Track if evidence is uploaded
  bool _hasUploadedEvidence = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  // Mock function to pick/upload evidence
  void _pickEvidence() {
    setState(() {
      _hasUploadedEvidence = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Evidence file attached successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Validation and Submit Logic
  void _submitDispute() {
    final description = _descriptionController.text.trim();

    if (description.isEmpty) {
      _showError('Please describe the issue before submitting');
      return;
    }

    if (description.length < 10) {
      _showError('Please provide a more detailed description (at least 10 characters)');
      return;
    }

    // Check if evidence is provided
    if (!_hasUploadedEvidence) {
      _showError('Evidence (photo or unboxing video) is required for SafeSure claims!');
      return;
    }

    // Success response
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dispute submitted successfully! Case #DSP-104'),
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
          'File Dispute Claim',
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
            // Banner Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Evidence submitted will be analyzed by SafeSure automated dispute system and admin team.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Select Reason Dropdown
            const Text(
              'Select Issue Reason',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedReason,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
              ),
              items: [
                'Damaged Product',
                'Counterfeit / Fake Item',
                'Missing Components',
                'Wrong Item Delivered',
              ]
                  .map(
                    (reason) => DropdownMenuItem(
                      value: reason,
                      child: Text(reason),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => selectedReason = val!),
            ),
            const SizedBox(height: 20),

            // Complaint Description
            const Text(
              'Description of Issue',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                    'Describe the problem clearly (e.g., box was unsealed, sound non-functional)...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Media Evidence Upload Box (Required)
            const Text(
              'Upload Evidence (Photos / Video) *Required',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickEvidence,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: _hasUploadedEvidence ? Colors.green.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _hasUploadedEvidence ? Colors.green : AppColors.primaryGreen,
                    width: _hasUploadedEvidence ? 2 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _hasUploadedEvidence ? Icons.check_circle : Icons.cloud_upload_outlined,
                      size: 40,
                      color: _hasUploadedEvidence ? Colors.green : AppColors.primaryGreen,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _hasUploadedEvidence ? 'Evidence Attached Successfully!' : 'Tap to upload unboxing video or photos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _hasUploadedEvidence ? Colors.green.shade700 : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Supports JPG, PNG, MP4 (Max 50MB)',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Submit Button
            CustomButton(
              text: 'Submit Dispute Evidence',
              onPressed: _submitDispute,
            ),
          ],
        ),
      ),
    );
  }
}