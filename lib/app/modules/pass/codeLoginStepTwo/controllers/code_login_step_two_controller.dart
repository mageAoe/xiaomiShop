import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/models/message.dart';
import '../../../../services/httpsClient.dart';
import 'package:xmshop/app/services/storage.dart';
import 'dart:async';
import '../../../user/controllers/user_controller.dart';

class CodeLoginStepTwoController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();
  UserController userController = Get.find<UserController>();

  String tel = Get.arguments["tel"];

 final TextEditingController editingController = TextEditingController();

 RxInt secoeds = 10.obs;

   @override
  void onInit() {
    super.onInit();
    countDown();
  }

  @override
  void onClose(){
    //更新用户状态
    userController.getUserInfo();
    super.onClose();
  }

    // 倒计时方法
  countDown(){
    Timer.periodic(const Duration(milliseconds: 1000), (timer) { 
      secoeds.value--;
      if(secoeds.value == 0){
        timer.cancel();
        update();
      }
    });
  }

  // 验证码登录
   Future<MessageModel> doLogin() async {
    var res = await _httpsClient.post("api/validateLoginCode", data: {
      "tel": tel,
      "code": editingController.text,
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


    // 重新发送验证码
  void sendCode() async{
    var res = await _httpsClient.post("api/sendCode", data: {
      "tel": tel
    });
    if(res != null){
      print(res);
      if(!res.data["success"]){
       Get.snackbar('提示信息', '发送验证码失败');
      }else{
        secoeds.value = 10;
        countDown();
        update();
      }
    }else{
      Get.snackbar('提示信息！', '网络异常');
    }
  }


}
