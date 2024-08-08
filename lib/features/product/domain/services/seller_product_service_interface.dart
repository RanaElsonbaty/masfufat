abstract class SellerProductServiceInterface{
  Future<dynamic> getSellerProductList(String sellerId, String offset, String productId, String search ,
    String orderBy ,
    String productType,
    String priceFilter , );

  Future<dynamic> getSellerWiseBestSellingProductList(String sellerId, String offset);

  Future<dynamic> getSellerWiseFeaturedProductList(String sellerId, String offset);

  Future<dynamic> getSellerWiseRecomendedProductList(String sellerId, String offset);

  Future<dynamic> getShopAgainFromRecentStoreList();
}