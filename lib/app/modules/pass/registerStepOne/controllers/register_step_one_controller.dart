import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../services/httpsClient.dart';

class RegisterStepOneController extends GetxController {
  //TODO: Implement RegisterStepOneController
  final HttpsClient _httpsClient = HttpsClient();
  TextEditingController editingController = TextEditingController();



  Future<bool> sendCode() async{
    var res = await _httpsClient.post("api/sendCode", data: {
      "tel": editingController.text
    });
    if(res != null){
      print(res);
      if(res.data["success"]){
        // 测试： 把验证码复制到剪切板上面
        // Clipboard.setData(ClipboardData(text: res.data["code"]));
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}
