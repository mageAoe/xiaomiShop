import 'package:get/get.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../../services/httpsClient.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/models/user_model.dart';
import '../../addressList/controllers/address_list_controller.dart';

class AddressEditController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString area = ''.obs;
  String id = Get.arguments['id'];

  AddressListController listController = Get.find<AddressListController>();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    print('onClose-------Add------');
    // 销毁时更新列表
    listController.getAddressList();
    super.onClose();
  }
  
  initData(){
    nameController.text = Get.arguments['name'];
    phoneController.text = Get.arguments['phone'];

    String address = Get.arguments['address'];
    List addressList = address.split(' ');
    area.value = "${addressList[0]} ${addressList[1]} ${addressList[2]}";

    addressList.removeRange(0, 3);
    addressController.text = addressList.join(' ');
  }

  setArea(String str){
    area.value = str;
    update();
  }

  doEditAddress() async{
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'id': id,
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
    var res = await _httpsClient.post('api/editAddress', data: data);
    if(res.data["success"]){
      Get.back();
    }else{
      Get.snackbar('提示信息', res.data['message']);
    }
  }

}
