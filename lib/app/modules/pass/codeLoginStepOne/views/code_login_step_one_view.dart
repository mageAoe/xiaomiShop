import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/code_login_step_one_controller.dart';

import '../../../../widget/logo.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){

          }, child: const Text('帮助'))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children:  [
          // logo
          const Logo(),
          PassTextField(
            controller: controller.editingController,
            hintText: '请输入手机号码', onChanged: (value){
            print('');
          }),
          const UserAgreement(),
          // 登录按钮
         LoginButton(text: '获取验证码',onPressed: () async {
            if(!GetUtils.isPhoneNumber(controller.editingController.text) || controller.editingController.text.length != 11){
              Get.snackbar("提示信息", '手机信息不合法');
            }else{
              MessageModel result = await controller.sendCode();
              if(result.success){
                // 替换路由
                Get.offAndToNamed('/code-login-step-two', arguments: {
                  "tel": controller.editingController.text
                });
              }else{
                Get.snackbar("提示信息", result.message);
              }
            }
         }),
         SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Get.toNamed('/register-step-one');
                  // 替换路由
                  // Get.offAndToNamed('/register-step-one');
                }, child: const Text('新用户注册')),
                TextButton(onPressed: (){
                  // Get.toNamed('/pass-login');
                  Get.offAndToNamed('/pass-login');
                }, child: const Text('账号密码登录')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
