import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loanify_mobile/services/loan.dart';
import '../models/loan_models.dart';
import '../models/collateral.dart';
import '../models/credit_history.dart';
import '../models/loan_decisions.dart';

final loanServiceProvider = Provider<LoanService>((ref) {
  return LoanService('https://your-api-base-url.com');
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
}
