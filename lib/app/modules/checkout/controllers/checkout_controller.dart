import 'package:get/get.dart';
import 'package:xmshop/app/services/storage.dart';

import 'package:xmshop/app/models/address_model.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../services/httpsClient.dart';
import 'package:xmshop/app/models/user_model.dart';

class CheckoutController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();
  RxList checkoutList = [].obs;
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;

  @override
  onInit(){
    super.onInit();
    getCheckoutData();
    getDefaultAddress();
  }

  // 获取
  getCheckoutData() async{
    List tempList = await Storage.getData('checkoutList');
    checkoutList.value = tempList;
    update();
  }

  getDefaultAddress() async{
    print('getDefaultAddress');
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
    var res = await _httpsClient.get('api/oneAddressList?uid=${userInfo.sid}&sign=$sign');
    if(res != null){
      var tempAddressList = AddressModel.fromJson(res.data);
      addressList.value = tempAddressList.result!;
      update();
    } 
  }
}
