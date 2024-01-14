import 'package:flutter/material.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(ScreenAdapter.width(80)),
            child: SizedBox(
              width: ScreenAdapter.width(180),
              height: ScreenAdapter.width(180),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.cover)
            ),
        );
  }
}

// 手机输入框
class PassTextField extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const PassTextField({
    super.key,
    this.isPassword = false,
    required this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.number,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.center,
            height: ScreenAdapter.height(180),
            margin: EdgeInsets.only(top: ScreenAdapter.height(100)),
            padding: EdgeInsets.only(left: ScreenAdapter.width(40)),
            decoration: BoxDecoration(
              color:  Colors.black12,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              controller: controller,
              autofocus: true,
              obscureText: isPassword,
              style: TextStyle(
                fontSize: ScreenAdapter.fontSize(48)
              ),
              keyboardType: keyboardType, // 表示默认弹出数字键盘
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Colors.black38,
                ),
                border: InputBorder.none // 去掉下划线
              ),
              onChanged: onChanged,
            ),
          );
  }
}

// 登录协议
class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Radio(value: true, groupValue: 1, onChanged: (Object){}),
                // Checkbox(value: true, onChanged: (v){}, activeColor: Colors.red),
                const Text('已阅读并同意', style: TextStyle(color: Colors.black26)),
                const Text('《商城用户协议》', style: TextStyle(color: Colors.red)),
                const Text('《删除隐私协议》', style: TextStyle(color: Colors.red)),
              ],
            ),
          );
  }
}

// 登录按钮
class LoginButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const LoginButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
            height: ScreenAdapter.height(140),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(70))
                ))
              ),
              child: Text(text, style: TextStyle(fontSize: ScreenAdapter.fontSize(46)))),
          );
  }
}