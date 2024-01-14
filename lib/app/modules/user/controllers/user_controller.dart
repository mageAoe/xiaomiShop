import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

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

  final count = 0.obs;



  void increment() => count.value++;
}
