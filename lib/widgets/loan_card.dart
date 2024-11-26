import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/loan/collateral.dart';
import 'package:loanify_mobile/loan/loan_details.dart';
import 'package:loanify_mobile/loan/review.dart';
import 'package:loanify_mobile/loan/user_info.dart';
import 'package:loanify_mobile/models/loan_models.dart';

class LoanCard extends ConsumerStatefulWidget {
  @override
  _LoanCardState createState() => _LoanCardState();
}

class _LoanCardState extends ConsumerState<LoanCard> {
  bool isApplicationInProgress = true;
  int currentStage = 0; // Current stage of the loan application (0 to 4).

  @override
  void initState() {
    super.initState();
    final application = ref.read(loanApplicationProvider);
    if (application.monthlyIncome == null || application.monthlyIncome == 0) {
      setState(() {
        isApplicationInProgress = false;
        currentStage = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void createApplication(BuildContext context) {
      final application = ref.read(loanApplicationProvider);
      if (application.firstName.isEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserInfoPage()));
      } else if (application.loanAmount == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoanDetailsPage()));
      } else if (application.collateralType.isEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CollateralPage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReviewPage()));
      }
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isApplicationInProgress) ...[
              // Display this content when no application is in progress
              Text('Make Your Loans',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Request your loans and get your money to balance just in seconds.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => createApplication(context),
                icon: Icon(Icons.add),
                label: Text('Create Application'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ] else ...[
              // Display progress indicator and related content when an application is in progress
              Text(
                'Loan Application In Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return Column(
                    children: [
                      // Circle indicating stage
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: index <= currentStage
                              ? Colors.blue
                              : Colors
                                  .grey.shade300, // Highlight if current stage
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              color: index <= currentStage
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Text below the circle
                      if (index == currentStage)
                        Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => continueApplication(context),
                icon: Icon(Icons.arrow_forward),
                label: Text('Continue Application'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void continueApplication(BuildContext context) {
    // Action for continuing the in-progress application
    print('Continue application tapped');
  }
}
