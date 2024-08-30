import 'package:rideshare/model/walletModel.dart';
import 'package:rideshare/service/walletService.dart';

class WalletRepository {
  final WalletService walletService;

  WalletRepository(this.walletService);

  Future<WalletModel> fetchWallet(String token) async {
    return await walletService.getWallet(token);
  }
}
