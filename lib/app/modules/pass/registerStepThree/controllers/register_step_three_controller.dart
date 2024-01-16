import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/services/storage.dart';
import '../../../../services/httpsClient.dart';
import '../../../../models/message.dart';


class RegisterStepThreeController extends GetxController {
  //TODO: Implement RegisterStepThreeController

  final HttpsClient _httpsClient = HttpsClient();

  String tel = Get.arguments["tel"];
  String code = Get.arguments["code"];

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();



  // 执行注册
  Future<MessageModel> doRegister() async {
    var res = await _httpsClient.post("api/register", data: {
      "tel": tel,
      "password": passController.text,
      "code": code
    });
    if(res != null){
      if(res.data["success"]){
        // 保持用户信息
        Storage.setData("userInfo", res.data["userinfo"]);
        return MessageModel(message: "注册成功", success: true);
      }else{
        return MessageModel(message: res.data["success"], success: false);
      }
    }else{
      return MessageModel(message: "网络异常", success: false);
    }
  }


}
