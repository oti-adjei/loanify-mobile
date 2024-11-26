import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model for the Loan Application
class LoanApplication {
  String firstName = '';
  String lastName = '';
  DateTime? dateOfBirth;
  String email = '';
  double? monthlyIncome;
  double? loanAmount;
  int? loanTerm; // In months
  double? interestRate;
  String purpose = '';
  DateTime? applicationDate;
  String collateralType = '';
  double? collateralValue;
  List<String> documents = []; // Paths to uploaded files

  bool get isComplete => firstName.isNotEmpty && loanAmount != null;
}

// StateNotifier to manage the loan application state
class LoanApplicationNotifier extends StateNotifier<LoanApplication> {
  LoanApplicationNotifier() : super(LoanApplication());

  void updateUserInfo({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    required double monthlyIncome,
  }) {
    state = LoanApplication()
      ..firstName = firstName
      ..lastName = lastName
      ..dateOfBirth = dateOfBirth
      ..email = email
      ..monthlyIncome = monthlyIncome;
  }

  void updateLoanDetails({
    required double loanAmount,
    required int loanTerm,
    required double interestRate,
    required String purpose,
  }) {
    state = LoanApplication()
      ..loanAmount = loanAmount
      ..loanTerm = loanTerm
      ..interestRate = interestRate
      ..purpose = purpose
      ..applicationDate = DateTime.now();
  }

  void updateCollateral({
    required String collateralType,
    required double collateralValue,
  }) {
    state = LoanApplication()
      ..collateralType = collateralType
      ..collateralValue = collateralValue;
  }

  void addDocument(String documentPath) {
    state.documents.add(documentPath);
    state = LoanApplication()..documents = state.documents;
  }
}

// Define the Riverpod provider
final loanApplicationProvider =
    StateNotifierProvider<LoanApplicationNotifier, LoanApplication>(
  (ref) => LoanApplicationNotifier(),
);
