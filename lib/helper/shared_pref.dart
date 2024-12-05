import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;

  SharedPreferencesHelper._internal();

  // Setters
  Future<void> setIsApplicationInProgress(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isApplicationInProgress', value);
  }

  Future<void> setCurrentStage(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStage', value);
  }

  // Getters
  Future<bool> get isApplicationInProgress async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isApplicationInProgress') ?? false;
  }

  Future<int> get currentStage async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentStage') ?? 0;
  }

  static Future<void> setUserInfo(String firstName, String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
  }

  static Future<Map<String, String>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('firstName') ?? '';
    final lastName = prefs.getString('lastName') ?? '';
    return {'firstName': firstName, 'lastName': lastName};
  }

  static Future<void> setLoanDetails(
      double loanAmount, int loanTerm, double interestRate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('loanAmount', loanAmount);
    await prefs.setInt('loanTerm', loanTerm);
    await prefs.setDouble('interestRate', interestRate);
  }

  static Future<Map<String, dynamic>> getLoanDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final loanAmount = prefs.getDouble('loanAmount') ?? 0.0;
    final loanTerm = prefs.getInt('loanTerm') ?? 0;
    final interestRate = prefs.getDouble('interestRate') ?? 0.0;
    return {
      'loanAmount': loanAmount,
      'loanTerm': loanTerm,
      'interestRate': interestRate,
    };
  }

  static Future<void> setCollateral(
      String collateralType, double collateralValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('collateralType', collateralType);
    await prefs.setDouble('collateralValue', collateralValue);
  }

  static Future<Map<String, dynamic>> getCollateral() async {
    final prefs = await SharedPreferences.getInstance();
    final collateralType = prefs.getString('collateralType') ?? '';
    final collateralValue = prefs.getDouble('collateralValue') ?? 0.0;
    return {
      'collateralType': collateralType,
      'collateralValue': collateralValue,
    };
  }

  static Future<void> setDocuments(List<String> documents) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('documents', documents);
  }

  static Future<List<String>> getDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('documents') ?? [];
  }
}
