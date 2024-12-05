import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/applicaiton_model.dart';

class LoanCard extends ConsumerStatefulWidget {
  const LoanCard({super.key});

  @override
  _LoanCardState createState() => _LoanCardState();
}

class _LoanCardState extends ConsumerState<LoanCard> {
  @override
  Widget build(BuildContext context) {
    final loanState = ref.watch(loanApplicationProvider);
    final loanNotifier = ref.read(loanApplicationProvider.notifier);

    print(loanState.isApplicationInProgress);
    print("Applocation initialized");
    print(loanState.currentStage);

    if (loanState.isApplicationInProgress) {
      print('Application in progress');
      print('Current stage: ${loanState.currentStage}');
    }

    //push to right page based on loanNotifier

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!loanState.isApplicationInProgress) ...[
              Text('Make Your Loans',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Request your loans and get your money to balance just in seconds.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  await loanNotifier.startApplication();
                  if (mounted) {
                    loanNotifier.navigateToNextStep(context);
                  }
                },
                child: Text('Start Application'),
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
                          color: index <= loanState.currentStage
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
                              color: index <= loanState.currentStage
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Text below the circle
                      if (index == loanState.currentStage)
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (mounted) {
                        loanNotifier.navigateToNextStep(context);
                      }
                    },
                    child: Text('Continue App.'),
                  ),
                  ElevatedButton(
                    onPressed: () async =>
                        await loanNotifier.resetApplication(),
                    child: Text('Reset App.'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
