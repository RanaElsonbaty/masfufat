
abstract class CategoryServiceInterface {

  Future<dynamic> getSellerWiseCategoryList(int sellerId);
  Future<dynamic> getList();
  Future<dynamic> get(int id);

}