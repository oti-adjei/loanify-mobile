import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/models/applicaiton_model.dart';
import 'loan_details.dart'; // Step 2

class UserInfoPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loanNotifier = ref.read(loanApplicationProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Step 1: User Information')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(firstNameController, 'First Name'),
              _buildTextField(lastNameController, 'Last Name'),
              _buildTextField(emailController, 'Email'),
              _buildTextField(
                monthlyIncomeController,
                'Monthly Net Income',
                isNumeric: true,
              ),
              const SizedBox(height: 20),
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
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(loanApplicationProvider.notifier)
                            .updateUserInfo(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dateOfBirth:
                                  DateTime.now(), // Add date picker later
                              email: emailController.text,
                              monthlyIncome:
                                  double.parse(monthlyIncomeController.text),
                            );
                        _loanNotifier.updateApplication();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoanDetailsPage()),
                        );
                      }
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
