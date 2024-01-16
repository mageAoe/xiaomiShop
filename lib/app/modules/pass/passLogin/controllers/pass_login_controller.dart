import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/models/message.dart';
import '../../../../services/httpsClient.dart';
import 'package:xmshop/app/services/storage.dart';

class PassLoginController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();

  TextEditingController telEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();


  Future<MessageModel> doLogin() async {
    var res = await _httpsClient.post("api/doLogin", data: {
      "username": telEditingController.text,
      "password": passEditingController.text,
    });
    if(res != null){
      if(res.data["success"]){
        // 保持用户信息
        Storage.setData("userInfo", res.data["userinfo"]);
        return MessageModel(message: "登录成功", success: true);
      }else{
        return MessageModel(message: res.data["success"], success: false);
      }
    }else{
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
