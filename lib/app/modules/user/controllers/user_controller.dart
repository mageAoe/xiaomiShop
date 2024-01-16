import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../models/user_model.dart';

class UserController extends GetxController {

  List userWalletWidgetList = [
    {
      "topWidget": Text('-', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
      "text": '米金'
    },
    {
      "topWidget": Text('-', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
      "text": '优惠券'
    },
    {
      "topWidget": Text('-', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
      "text": '红包'
    },
    {
      "topWidget": Text('-', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
      "text": '最高额度'
    },
    {
      "topWidget": const Icon(Icons.wallet_outlined),
      "text": '钱包'
    }
  ];

  RxBool isLogin = false.obs;
  // RxList userInfoList = [].obs;

  var userInfo = UserModel().obs;

  getUserInfo() async {
    var tempLoginState = await UserServices.getUserLoginState();
    isLogin.value = tempLoginState;
    var tempList = await UserServices.getUserInfo();
    print(tempList);
    if(tempList.isNotEmpty){
      print("===========");
      // userInfoList.value = tempList;
      userInfo.value = UserModel.fromJson(tempList[0]);
      update();
    }
  }

  loginOut() {
    UserServices.loginOut();
    isLogin.value = false;
    userInfo.value = UserModel();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }
}
