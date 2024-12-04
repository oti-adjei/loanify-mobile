class Collateral {
  final int loanId;
  final String collateralType;
  final double estimatedValue;

  Collateral({
    required this.loanId,
    required this.collateralType,
    required this.estimatedValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanId': loanId,
      'collateralType': collateralType,
      'estimatedValue': estimatedValue,
    };
  }

  factory Collateral.fromJson(Map<String, dynamic> json) {
    return Collateral(
      loanId: json['loanId'],
      collateralType: json['collateralType'],
      estimatedValue: json['estimatedValue'],
    );
  }
}
