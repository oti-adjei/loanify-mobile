import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/UI/steps/review.dart';

import '../../models/applicaiton_model.dart';

class DocumentUploadPage extends ConsumerStatefulWidget {
  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends ConsumerState<DocumentUploadPage> {
  List<String> uploadedDocuments = [];

  void uploadDocument() async {
    final filePath = 'path/to/document_${uploadedDocuments.length + 1}.pdf';
    setState(() {
      uploadedDocuments.add(filePath);
    });

    ref.read(loanApplicationProvider.notifier).addDocument(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Step 4: Upload Documents')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Uploaded Documents',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: uploadedDocuments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Document ${index + 1}'),
                    subtitle: Text(uploadedDocuments[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: uploadDocument,
              child: Text('Upload Document'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage()),
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
