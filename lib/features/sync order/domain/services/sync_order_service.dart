import 'package:camera/camera.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/services/sync_order_service_interface.dart';

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

  @override
  Future<ApiResponse> placeSyncWalletOrder(String id) async{
    return await syncOrderRepositoryInterface.placeSyncWalletOrder(id);

  }

  @override
  Future<ApiResponse> placeBankTransferOrder(String id, String paymentMethod)async {

    return await syncOrderRepositoryInterface.placeBankTransferOrder(id,paymentMethod);

  }

  @override
  Future<ApiResponse> bankAndDelayedPayment(String orderID, String paymentMethod, String bank, XFile attachment, String holderName) async{
    return await syncOrderRepositoryInterface.bankAndDelayedPayment(orderID,paymentMethod,bank,attachment,holderName);

  }

}