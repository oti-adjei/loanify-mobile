import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/loan_models.dart';
import '../models/collateral.dart';
import '../models/credit_history.dart';
import '../models/loan_decisions.dart';

class LoanService {
  final String baseUrl;

  LoanService(this.baseUrl);

  Future<void> createLoan(Loan loan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/loans'),
      body: jsonEncode(loan.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create loan: ${response.body}');
    }
  }

  Future<void> addCollateral(Collateral collateral) async {
    final response = await http.post(
      Uri.parse('$baseUrl/collaterals'),
      body: jsonEncode(collateral.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add collateral: ${response.body}');
    }
  }

  Future<void> addCreditHistory(CreditHistory creditHistory) async {
    final response = await http.post(
      Uri.parse('$baseUrl/credit-history'),
      body: jsonEncode(creditHistory.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add credit history: ${response.body}');
    }
  }

  Future<void> makeLoanDecision(LoanDecision decision) async {
    final response = await http.post(
      Uri.parse('$baseUrl/loan-decisions'),
      body: jsonEncode(decision.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to make loan decision: ${response.body}');
    }
  }
}
