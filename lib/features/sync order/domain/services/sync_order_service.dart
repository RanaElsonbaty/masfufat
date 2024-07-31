import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/repositories/support_ticket_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/services/support_ticket_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/services/sync_order_service_interface.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/sync_order_repository_interface.dart';

class SyncOrderService implements SyncOrderServiceInterface{
  SyncOrderRepositoryInterface syncOrderRepositoryInterface;

  SyncOrderService({required this.syncOrderRepositoryInterface});
  @override
  Future<ApiResponse> getOrderList(String type ,String page) async{
    return await syncOrderRepositoryInterface.getOrderList(type,page);
  }  @override
  Future<ApiResponse> getOrderDeteilsList(String id) async{
    return await syncOrderRepositoryInterface.getOrderDeteilsList(id);
  }

}