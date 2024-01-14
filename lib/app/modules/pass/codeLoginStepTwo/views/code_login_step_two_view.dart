import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/code_login_step_two_controller.dart';

import '../../../../widget/logo.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class CodeLoginStepTwoView extends GetView<CodeLoginStepTwoController> {
  const CodeLoginStepTwoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('手机验证码快速登录'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          const Logo(),
          Container(
            alignment: Alignment.center,
            child: const Text('请输入验证码'),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
            padding: EdgeInsets.all(ScreenAdapter.width(40)),
            child: PinCodeTextField(
                autoFocus: true,
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                dialogConfig: DialogConfig(
                  dialogTitle: "粘贴验证码",
                  dialogContent: "确定要粘贴验证码吗？",
                  affirmativeText: "确定",
                  negativeText: "取消"
                ),
                pinTheme: PinTheme( // 样式
                  activeColor: Colors.orange,
                  inactiveColor: Colors.red,
                  selectedFillColor: Colors.pink,
                  inactiveFillColor: Colors.transparent,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300), // 动画时间
                // backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller:controller.editingController, // 控制器
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, 
                appContext: context,
              ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){}, child: const Text('重新发送验证码')),
                TextButton(onPressed: (){}, child: const Text('获取帮助')),
              ],
            ),
          ),
          LoginButton(text: '获取验证码',onPressed: (){
           // 获取验证码

           // 隐藏键盘
         })
        ],
      ),
    );
  }
}
