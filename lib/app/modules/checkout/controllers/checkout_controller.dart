import 'dart:convert';

import 'package:get/get.dart';
import 'package:xmshop/app/services/cartServices.dart';
import 'package:xmshop/app/services/storage.dart';

import 'package:xmshop/app/models/address_model.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../services/httpsClient.dart';
import 'package:xmshop/app/models/user_model.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();
  RxList checkoutList = [].obs;
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;
  RxDouble allPrice = 0.0.obs;
  RxInt allNum = 0.obs;

  CartController cartController = Get.find<CartController>();

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
    computedAllPrice();
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

  // 计算总价
  computedAllPrice(){
    double tempAllPrice = 0.0;
    int temAllNum = 0;
    for (var i = 0; i < checkoutList.length; i++) {
     if(checkoutList[i]['checked'] == true){
        tempAllPrice += checkoutList[i]['price']*checkoutList[i]['count'];
        temAllNum+= checkoutList[i]['count'] as int;
      }
    }
    allPrice.value = tempAllPrice;
    allNum.value = temAllNum;
  }

  // 去结算
  doCheckout() async {
    if(addressList.isNotEmpty){
      List userList = await UserServices.getUserInfo();
      UserModel userInfo = UserModel.fromJson(userList[0]);
      // 表单校验
      Map tempJson = {
        'uid': userInfo.sid,
        'name': addressList[0].name,
        'phone': addressList[0].phone,
        'address': addressList[0].address,
        'all_price': allPrice.value.toStringAsFixed(1),
        'products': json.encode(checkoutList)
      };
      String sign = SignServices.getSign({
        ...tempJson,
        'salt': userInfo.salt
      });
      var res = await _httpsClient.post('api/doOrder', data: {
        ...tempJson,
        'sign': sign
      });
      if(res.data['success']){
        // 删除购物车里面的选中的商品
          await CartServices.deleteCheckOutData(checkoutList);
        // 更新购物车数据
           cartController.getCartListData();
        // 跳转支付
          Get.toNamed('/pay');
      } else{
       Get.snackbar('提示信息', res.data['message']);
      }
    }else{
      Get.snackbar('提示信息', '请选择收获地址');
    }
  }
}
