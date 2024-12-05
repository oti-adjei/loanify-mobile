class Loan {
  // final int userId;
  final double loanAmount;
  final int loanTerm;
  final double interestRate;
  final String purpose;
  final DateTime applicationDate;
  final String status;

  Loan({
    // required this.userId,
    required this.loanAmount,
    required this.loanTerm,
    required this.interestRate,
    required this.purpose,
    required this.applicationDate,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      // 'userId': userId,
      'loanAmount': loanAmount,
      'loanTerm': loanTerm,
      'interestRate': interestRate,
      'purpose': purpose,
      'applicationDate': applicationDate.toIso8601String(),
      'status': status,
    };
  }
}
