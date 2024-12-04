class LoanDecision {
  final int loanId;
  final DateTime decisionDate;
  final String decisionStatus;
  final String reason;
  final int approvedBy;

  LoanDecision({
    required this.loanId,
    required this.decisionDate,
    required this.decisionStatus,
    required this.reason,
    required this.approvedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanId': loanId,
      'decisionDate': decisionDate.toIso8601String(),
      'decisionStatus': decisionStatus,
      'reason': reason,
      'approvedBy': approvedBy,
    };
  }

  factory LoanDecision.fromJson(Map<String, dynamic> json) {
    return LoanDecision(
      loanId: json['loanId'],
      decisionDate: DateTime.parse(json['decisionDate']),
      decisionStatus: json['decisionStatus'],
      reason: json['reason'],
      approvedBy: json['approvedBy'],
    );
  }
}
