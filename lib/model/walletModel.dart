class WalletModel {
  final int id;
  final double balance;
  final String bankAccount;

  WalletModel({
    required this.id,
    required this.balance,
    required this.bankAccount,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      balance: json['balance'].toDouble(),
      bankAccount: json['bankAccount'],
    );
  }
}
