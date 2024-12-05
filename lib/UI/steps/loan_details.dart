import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/UI/steps/collateral.dart';

import '../../models/applicaiton_model.dart';

class LoanDetailsPage extends ConsumerWidget {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loanNotifier = ref.read(loanApplicationProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('Step 2: Loan Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: loanAmountController,
              decoration: InputDecoration(labelText: 'Loan Amount'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: loanTermController,
              decoration: InputDecoration(labelText: 'Loan Term (months)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: interestRateController,
              decoration: InputDecoration(labelText: 'Interest Rate'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
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
                  onPressed: () async {
                    ref
                        .read(loanApplicationProvider.notifier)
                        .updateLoanDetails(
                          loanAmount: double.parse(loanAmountController.text),
                          loanTerm: int.parse(loanTermController.text),
                          interestRate:
                              double.parse(interestRateController.text),
                          purpose: 'Education', // Replace with user input
                        );
                    await _loanNotifier.updateApplication();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CollateralPage()),
                    );
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
