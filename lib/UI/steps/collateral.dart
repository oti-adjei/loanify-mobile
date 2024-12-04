import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/UI/steps/document_upload.dart';

import '../../models/applicaiton_model.dart';

class CollateralPage extends ConsumerWidget {
  final TextEditingController collateralTypeController =
      TextEditingController();
  final TextEditingController collateralValueController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Step 3: Collateral Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: collateralTypeController,
              decoration: InputDecoration(labelText: 'Collateral Type'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: collateralValueController,
              decoration: InputDecoration(labelText: 'Estimated Value'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ref.read(loanApplicationProvider.notifier).updateCollateral(
                      collateralType: collateralTypeController.text,
                      collateralValue:
                          double.parse(collateralValueController.text),
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentUploadPage()),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
