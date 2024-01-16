import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pass_login_controller.dart';

import '../../../../widget/logo.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';

class PassLoginView extends GetView<PassLoginController> {
  const PassLoginView({Key? key}) : super(key: key);
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
            controller: controller.telEditingController,
            hintText: '小米账号/手机号/邮箱', onChanged: (value){
            print('');
          }),
          PassTextField(
            controller: controller.passEditingController,
            hintText: '请输入密码', onChanged: (value){
            print('');
          }),
          const UserAgreement(),
          // 登录按钮
         LoginButton(text: '登录',onPressed: () async {
          if(!GetUtils.isPhoneNumber(controller.telEditingController.text) || controller.telEditingController.text.length != 11){
            Get.snackbar("提示信息", '手机信息不合法');
          }else{
            var result = await controller.doLogin();
            if(result.success){
              Get.offAllNamed("/tabs", arguments: {
               "initialPage": 4
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
                TextButton(onPressed: (){}, child: const Text('忘记密码')),
                TextButton(onPressed: (){
                  Get.toNamed('/code-login-step-one');
                }, child: const Text('验证码登录')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
