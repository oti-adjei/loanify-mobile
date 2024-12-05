import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/services/loan.dart';
import '../models/loan_models.dart';
import '../models/collateral.dart';
import '../models/credit_history.dart';
import '../models/loan_decisions.dart';
import '../models/applicaiton_model.dart';

final loanServiceProvider = Provider<LoanService>((ref) {
  return LoanService('http://localhost:8000/api/v1');
  // return LoanService('https://your-api-base-url.com');
});

final loanNotifierProvider = StateNotifierProvider<LoanNotifier, bool>((ref) {
  final loanService = ref.watch(loanServiceProvider);
  return LoanNotifier(loanService);
});

class LoanNotifier extends StateNotifier<bool> {
  final LoanService loanService;

  LoanNotifier(this.loanService) : super(false);

  Future<void> createLoan(Loan loan) async {
    try {
      state = true;
      await loanService.createLoan(loan);
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<void> addCollateral(Collateral collateral) async {
    try {
      state = true;
      await loanService.addCollateral(collateral);
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<void> addCreditHistory(CreditHistory creditHistory) async {
    try {
      state = true;
      await loanService.addCreditHistory(creditHistory);
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<void> makeLoanDecision(LoanDecision decision) async {
    try {
      state = true;
      await loanService.makeLoanDecision(decision);
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  // New method to handle the entire loan application submission
  // Helper function to create a loan and associated data
  Future<void> processLoanApplication({
    required Loan loan,
    required Collateral collateral,
    required CreditHistory creditHistory,
    required LoanDecision decision,
  }) async {
    try {
      state = true; // Start loading

      // Run all operations concurrently using Future.wait
      await Future.wait([
        loanService.createLoan(loan),
        loanService.addCollateral(collateral),
        loanService.addCreditHistory(creditHistory),
        loanService.makeLoanDecision(decision),
      ]);

      // If all operations succeed, handle any post-processing
      print('All loan operations succeeded');
    } catch (e) {
      // Handle errors
      print('Error processing loan application: $e');
      rethrow;
    } finally {
      state = false; // Stop loading
    }
  }
}
