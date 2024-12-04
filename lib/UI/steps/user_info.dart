import 'package:flutter/material.dart';
import 'package:loanify_mobile/UI/steps/loan_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/applicaiton_model.dart';

class UserInfoPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Step 1: User Information')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: monthlyIncomeController,
                decoration: InputDecoration(labelText: 'Monthly Net Income'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(loanApplicationProvider.notifier).updateUserInfo(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          dateOfBirth:
                              DateTime.now(), // Replace with a date picker
                          email: emailController.text,
                          monthlyIncome:
                              double.parse(monthlyIncomeController.text),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoanDetailsPage()),
                    );
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
