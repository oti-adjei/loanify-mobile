import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/models/credit_history.dart';

import '../../models/applicaiton_model.dart';
import '../../models/collateral.dart';
import '../../models/loan_decisions.dart';
import '../../models/loan_models.dart';
import '../../providers/loan.dart';

class ReviewPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final application = ref.watch(loanApplicationProvider);

    void processAndSubmitLoanApplication(BuildContext context) {
      final notifier = ref.read(loanNotifierProvider);
      ;

      final loan = Loan(
        loanAmount: application.loanAmount ?? 0.0,
        loanTerm: application.loanTerm ?? 0,
        interestRate: application.interestRate ?? 0.0,
        purpose: application.purpose ?? '',
        applicationDate: application.applicationDate ?? DateTime.now(),
      );

      /*final collateral = Collateral(
        collateralType: application.collateralType ?? '',
        estimatedValue: application.collateralValue ?? 0.0,
      );

      final loanDecision = LoanDecision(
        decisionDate: DateTime.now(),
        decisionStatus: 'Pending',
        reason: '',
        approvedBy: '',
      );

      final creditHistory = CreditHistory(
        userId: application.userId,
        creditorName: application.creditorName,
        accountNumber: application.accountNumber,
        creditLimit: application.creditLimit,
        outstandingBalance: application.outstandingBalance,
        paymentHistory: application.paymentHistory,
      );

      notifier
          .processLoanApplication(
        loan: loan,
        collateral: collateral,
        creditHistory: creditHistory, // Assuming you have a credit history object
        decision: loanDecision,
      )
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loan application submitted successfully!')),
        );
        ref
                                .read(loanApplicationProvider.notifier)
                                .resetApplication();
        //remove all old routes from the navigator and go to home
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (route) => false,
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit loan application: $error')),
        );
      });*/
    }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/',
                        (route) => false,
                      );
                    },
                    child: Text('Save Application'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      processAndSubmitLoanApplication(context);
                    },
                    child: Text('Submit Application'),
                  ),
                ],
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
