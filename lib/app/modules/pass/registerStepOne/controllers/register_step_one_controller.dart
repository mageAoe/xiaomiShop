import 'package:flutter/material.dart';
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
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}
