import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/models/loan_models.dart';

class ReviewPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final application = ref.watch(loanApplicationProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Step 5: Review and Submit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review Your Application',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              // User Information
              _buildSection('User Information', [
                'First Name: ${application.firstName}',
                'Last Name: ${application.lastName}',
                'Date of Birth: ${application.dateOfBirth}',
                'Email: ${application.email}',
                'Monthly Income: ${application.monthlyIncome}',
              ]),
              // Loan Details
              _buildSection('Loan Details', [
                'Loan Amount: ${application.loanAmount}',
                'Loan Term: ${application.loanTerm} months',
                'Interest Rate: ${application.interestRate}',
                'Purpose: ${application.purpose}',
                'Application Date: ${application.applicationDate}',
              ]),
              // Collateral
              _buildSection('Collateral Details', [
                'Type: ${application.collateralType}',
                'Estimated Value: ${application.collateralValue}',
              ]),
              // Documents
              _buildSection('Uploaded Documents', [
                ...application.documents.map((doc) => 'Document: $doc'),
              ]),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Application Submitted'),
                      content: Text(
                          'Your loan application has been submitted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...details.map((detail) => Text(detail)),
        ],
      ),
    );
  }
}
