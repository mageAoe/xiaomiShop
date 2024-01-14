import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/httpsClient.dart';

class RegisterStepTwoController extends GetxController {
  //TODO: Implement RegisterStepTwoController
  final HttpsClient _httpsClient = HttpsClient();

  final TextEditingController editingController = TextEditingController();

  String tel = Get.arguments["tel"];

  RxInt secoeds = 10.obs;

  @override
  void onInit() {
    super.onInit();
    countDown();
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
  

  // 验证验证码
  Future<bool> validateCode() async {
    var res = await _httpsClient.post("api/validateCode", data: {
      "tel": tel,
      "code": editingController.text
    });
    if(res != null){
      if(res.data["success"]){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
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
