import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_step_one_controller.dart';

import '../../../../widget/logo.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';

class RegisterStepOneView extends GetView<RegisterStepOneController> {
  const RegisterStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('手机验证码快速登录'),
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children:  [
          // logo
          const Logo(),
          PassTextField(
            controller: controller.editingController,
            hintText: '请输入手机号码', 
            onChanged: (value){
              print('');
          }),
          // 登录按钮
         LoginButton(text: '下一步',
          onPressed: () async {
            if(GetUtils.isPhoneNumber(controller.editingController.text) && controller.editingController.text.length == 11){
             
              var flag = await controller.sendCode();
              if(flag){
                   Get.toNamed('/register-step-two', arguments: {
                    "tel": controller.editingController.text
                  });
              }else{
                Get.snackbar('提示信息！', '网络异常');
              }
            }else{
              Get.snackbar('提示信息！', '手机号格式不合法');
            }
         }),
         SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('遇到问题？你可以', style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(onPressed: (){
                  Get.toNamed('/pass-login');
                }, child: const Text('获取帮助')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
