import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/domain/services/store_setting_service_interface.dart';

import '../repositories/store_setting_repository_interface.dart';

class StoreSettingService implements StoreSettingServiceInterface{
  StoreSettingInterface storeSettingInterface;

  StoreSettingService({required this.storeSettingInterface});

  @override
  Future getLinkedAccount() {
    // TODO: implement getLinkedAccount
    throw UnimplementedError();
  }

  @override
  Future unlinkLinkedAccount() {
    // TODO: implement unlinkLinkedAccount
    throw UnimplementedError();
  }



}