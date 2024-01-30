import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../../services/httpsClient.dart';
import '../../addressList/controllers/address_list_controller.dart';

class AddressAddController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString area = ''.obs;

  AddressListController listController = Get.find<AddressListController>();


  setArea(String str){
    area.value = str;
    update();
  }

  @override
  void onClose() {
    print('onClose-------Add------');
    // 销毁时更新列表
    listController.getAddressList();
    super.onClose();
  }

  doAddress() async{
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'uid': userInfo.sid,
      'name': nameController.text,
      'phone': phoneController.text.toString(),
      'address': '${area.value} ${addressController.text}',
    };
    String sign = SignServices.getSign({
      ...tempJson,
      'salt': userInfo.salt
    });
    var data = {
      ...tempJson,
      'sign': sign
    };
    var res = await _httpsClient.post('api/addAddress', data: data);
    if(res.data["success"]){
      Get.back();
    }else{
      Get.snackbar('提示信息', res.data['message']);
    }
  }

}
