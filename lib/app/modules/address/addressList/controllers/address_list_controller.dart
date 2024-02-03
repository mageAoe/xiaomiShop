import 'package:get/get.dart';
import 'package:xmshop/app/models/address_model.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../../services/httpsClient.dart';
import 'package:xmshop/app/models/user_model.dart';
import '../../../checkout/controllers/checkout_controller.dart';

class AddressListController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;

  CheckoutController checkoutController = Get.find<CheckoutController>();

  
  @override
  void onInit() {
    // print('onInit-----------');
    getAddressList();
    super.onInit();
  }

  @override
  void onClose() {
    // print('onClose-----------');
    checkoutController.getDefaultAddress();
    super.onClose();
  }

  getAddressList() async{
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'uid': userInfo.sid,
    };
    String sign = SignServices.getSign({
      ...tempJson,
      'salt': userInfo.salt
    });
    var res = await _httpsClient.get('api/addressList?uid=${userInfo.sid}&sign=$sign');
    if(res != null){
      var tempAddressList = AddressModel.fromJson(res.data);
      addressList.value = tempAddressList.result!;
      update();
    }
  }

  changeDefaultAddress(id) async{
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'uid': userInfo.sid,
      'id': id
    };
    String sign = SignServices.getSign({
      ...tempJson,
      'salt': userInfo.salt
    });
    var res = await _httpsClient.post('api/changeDefaultAddress', data: {
      ...tempJson,
      'sign': sign
    });
    if(res != null){
      Get.back();
    }
  }

   deleteAddress(id) async{
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'uid': userInfo.sid,
      'id': id
    };
    String sign = SignServices.getSign({
      ...tempJson,
      'salt': userInfo.salt
    });
    var res = await _httpsClient.post('api/deleteAddress', data: {
      ...tempJson,
      'sign': sign
    });
    if(res != null){
      getAddressList();
    }
  }

}
