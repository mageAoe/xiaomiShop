import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/models/message.dart';
import '../../../../services/httpsClient.dart';

class CodeLoginStepOneController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();

  TextEditingController editingController = TextEditingController();
  
  // 发送验证码
  Future<MessageModel> sendCode() async{
    var res = await _httpsClient.post("api/sendLoginCode", data: {
      "tel": editingController.text
    });
    if(res != null){
      print(res);
      if(res.data["success"]){
        return MessageModel(message: "发送验证码成功", success: true);
      }
      return MessageModel(message: res.data["message"], success: false);
    }else{
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
