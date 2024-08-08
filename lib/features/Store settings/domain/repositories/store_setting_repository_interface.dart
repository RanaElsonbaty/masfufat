import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';


abstract class StoreSettingInterface implements RepositoryInterface{
  Future<dynamic> getLinkedAccount() ;
  Future<dynamic> unlinkLinkedAccount();
}