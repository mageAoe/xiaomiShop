import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';

import '../controllers/register_step_three_controller.dart';

import '../../../../widget/logo.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';

class RegisterStepThreeView extends GetView<RegisterStepThreeController> {
  const RegisterStepThreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children:  [
          // logo
          const Logo(),
          PassTextField(
            controller: controller.passController,
            hintText: '小米账号/手机号/邮箱', 
            onChanged: (value){
            print('');
          }),
          PassTextField(
            controller: controller.confirmController,
            hintText: '请输入密码', onChanged: (value){
            print('');
          }),
          // 登录按钮
         LoginButton(text: '完成注册',onPressed: () async {
          MessageModel result = await controller.doRegister();
          if(result.success){
            // 回到根
            Get.offAllNamed("/tabs", arguments: {
              "initialPage": 4
            });
          }else{
            Get.snackbar("提示信息", result.message);
          }
          //  Get.toNamed('/code-login-step-two');
         }),
        ],
      ),
    );
  }
}
