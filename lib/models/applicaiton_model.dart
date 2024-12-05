import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/helper/shared_pref.dart';
import 'package:loanify_mobile/UI/steps/collateral.dart';
import 'package:loanify_mobile/UI/steps/loan_details.dart';
import 'package:loanify_mobile/UI/steps/review.dart';
import 'package:loanify_mobile/UI/steps/user_info.dart';
import 'package:loanify_mobile/models/loan_models.dart';

import 'collateral.dart';
import 'credit_history.dart';
import 'loan_decisions.dart';

class LoanApplicationState {
  final bool isApplicationInProgress;
  final int currentStage;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String email;
  final double monthlyIncome;
  final double loanAmount;
  final int loanTerm;
  final double interestRate;
  final String purpose;
  final DateTime applicationDate;
  final String collateralType;
  final double collateralValue;
  final List<String> documents;

  LoanApplicationState({
    required this.isApplicationInProgress,
    required this.currentStage,
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth,
    this.email = '',
    this.monthlyIncome = 0.0,
    this.loanAmount = 0.0,
    this.loanTerm = 0,
    this.interestRate = 0.0,
    this.purpose = '',
    DateTime? applicationDate,
    this.collateralType = '',
    this.collateralValue = 0.0,
    this.documents = const [],
  }) : applicationDate = applicationDate ?? DateTime.now();

  LoanApplicationState copyWith({
    bool? isApplicationInProgress,
    int? currentStage,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? email,
    double? monthlyIncome,
    double? loanAmount,
    int? loanTerm,
    double? interestRate,
    String? purpose,
    DateTime? applicationDate,
    String? collateralType,
    double? collateralValue,
    List<String>? documents,
  }) {
    return LoanApplicationState(
      isApplicationInProgress:
          isApplicationInProgress ?? this.isApplicationInProgress,
      currentStage: currentStage ?? this.currentStage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      loanAmount: loanAmount ?? this.loanAmount,
      loanTerm: loanTerm ?? this.loanTerm,
      interestRate: interestRate ?? this.interestRate,
      purpose: purpose ?? this.purpose,
      applicationDate: applicationDate ?? this.applicationDate,
      collateralType: collateralType ?? this.collateralType,
      collateralValue: collateralValue ?? this.collateralValue,
      documents: documents ?? this.documents,
    );
  }
}

class LoanApplicationNotifier extends StateNotifier<LoanApplicationState> {
  LoanApplicationNotifier()
      : super(LoanApplicationState(
            isApplicationInProgress: false, currentStage: 0));

  // Initialize the state based on shared preferences
  Future<void> initialize() async {
    final isInProgress =
        await SharedPreferencesHelper().isApplicationInProgress;
    final stage = await SharedPreferencesHelper().currentStage;

    state = LoanApplicationState(
      isApplicationInProgress: isInProgress,
      currentStage: stage,
    );
  }

  // Start the loan application process
  Future<void> startApplication() async {
    final updatedState = state.copyWith(
      isApplicationInProgress: true,
      currentStage: 0, // Assuming stage 1 is for user information
    );
    state = updatedState;

    await SharedPreferencesHelper().setIsApplicationInProgress(true);
    await SharedPreferencesHelper().setCurrentStage(0);
  }

  // Update the loan application
  Future<void> updateApplication() async {
    final updatedState = state.copyWith(
      isApplicationInProgress: true,
      currentStage: state.currentStage + 1,
    );
    state = updatedState;

    await SharedPreferencesHelper().setIsApplicationInProgress(true);
    await SharedPreferencesHelper().setCurrentStage(state.currentStage);
  }

  // Reset the loan application
  Future<void> resetApplication() async {
    final updatedState = state.copyWith(
      isApplicationInProgress: false,
      currentStage: 0, // Reset to the start
    );
    state = updatedState;

    await SharedPreferencesHelper().setIsApplicationInProgress(false);
    await SharedPreferencesHelper().setCurrentStage(0);
  }

  // Update user information and persist it
  Future<void> updateUserInfo({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    required double monthlyIncome,
  }) async {
    final updatedState = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      email: email,
      monthlyIncome: monthlyIncome,
    );

    state = updatedState;
    await _saveToPreferences(updatedState);
  }

  // Update loan details and persist it
  Future<void> updateLoanDetails({
    required double loanAmount,
    required int loanTerm,
    required double interestRate,
    required String purpose,
  }) async {
    final updatedState = state.copyWith(
      loanAmount: loanAmount,
      loanTerm: loanTerm,
      interestRate: interestRate,
      purpose: purpose,
      applicationDate: DateTime.now(),
    );

    state = updatedState;
    await _saveToPreferences(updatedState);
  }

  // Update collateral information and persist it
  Future<void> updateCollateral({
    required String collateralType,
    required double collateralValue,
  }) async {
    final updatedState = state.copyWith(
      collateralType: collateralType,
      collateralValue: collateralValue,
    );

    state = updatedState;
    await _saveToPreferences(updatedState);
  }

  // Add a document to the loan application and persist it
  Future<void> addDocument(String documentPath) async {
    final updatedDocuments = List<String>.from(state.documents)
      ..add(documentPath);
    final updatedState = state.copyWith(documents: updatedDocuments);

    state = updatedState;
    await _saveToPreferences(updatedState);
  }

  // Private method to save state to shared preferences
  Future<void> _saveToPreferences(LoanApplicationState updatedState) async {
    await SharedPreferencesHelper.setUserInfo(
        updatedState.firstName, updatedState.lastName);
    await SharedPreferencesHelper.setLoanDetails(updatedState.loanAmount,
        updatedState.loanTerm, updatedState.interestRate);
    await SharedPreferencesHelper.setCollateral(
        updatedState.collateralType, updatedState.collateralValue);
    await SharedPreferencesHelper.setDocuments(updatedState.documents);
  }

  // Handle navigation based on the current stage
  Future<void> navigateToNextStep(BuildContext context) async {
    switch (state.currentStage) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => UserInfoPage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoanDetailsPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => CollateralPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ReviewPage()));
        break;
      default:
        // Optionally handle unknown stages or completed loan application
        break;
    }
  }
}

final loanApplicationProvider =
    StateNotifierProvider<LoanApplicationNotifier, LoanApplicationState>(
        (ref) => LoanApplicationNotifier());

// final loanApplicationStateProvider = StateProvider<LoanApplication>((ref) {
//   return LoanApplication(
//     loan: Loan(),  // Initialize with default values
//     collateral: Collateral(),
//     creditHistory: CreditHistory(),
//     loanDecision: LoanDecision(),
//   );
// });

class LoanApplication {
  final Loan loan;
  final Collateral collateral;
  final CreditHistory creditHistory;
  final LoanDecision loanDecision;

  LoanApplication({
    required this.loan,
    required this.collateral,
    required this.creditHistory,
    required this.loanDecision,
  });
}
