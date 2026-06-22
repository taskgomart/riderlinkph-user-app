abstract class WalletServiceInterface{
  Future<dynamic> getTransactionList({required int offset, required String transactionType, required String durationType, required String sDate, required String eDate});
  Future<dynamic> getLoyaltyPointList(int offset);
  Future<dynamic> convertPoint(String point);
  Future<dynamic> transferWalletMoney(String balance);
  Future<dynamic> getAddFundPromotionalList();
}