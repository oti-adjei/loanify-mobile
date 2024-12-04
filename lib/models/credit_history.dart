class CreditHistory {
  final int userId;
  final String creditorName;
  final String accountNumber;
  final double creditLimit;
  final double outstandingBalance;
  final String paymentHistory;

  CreditHistory({
    required this.userId,
    required this.creditorName,
    required this.accountNumber,
    required this.creditLimit,
    required this.outstandingBalance,
    required this.paymentHistory,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'creditorName': creditorName,
      'accountNumber': accountNumber,
      'creditLimit': creditLimit,
      'outstandingBalance': outstandingBalance,
      'paymentHistory': paymentHistory,
    };
  }

  factory CreditHistory.fromJson(Map<String, dynamic> json) {
    return CreditHistory(
      userId: json['userId'],
      creditorName: json['creditorName'],
      accountNumber: json['accountNumber'],
      creditLimit: json['creditLimit'],
      outstandingBalance: json['outstandingBalance'],
      paymentHistory: json['paymentHistory'],
    );
  }
}
