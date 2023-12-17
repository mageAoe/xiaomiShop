import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

class CartItemNumView extends GetView {
  final Map cartItme;
  const CartItemNumView(this.cartItme, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(244),
      height: ScreenAdapter.height(64),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenAdapter.width(35)),
        border: Border.all(
          width: ScreenAdapter.width(2),
          color: Colors.black12
        )
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(80),
            height: ScreenAdapter.height(64),
            child: const Text('-'),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
               left: BorderSide(width: ScreenAdapter.width(2),color: Colors.black12),
               right: BorderSide(width: ScreenAdapter.width(2),color: Colors.black12)
              )
            ),
            alignment: Alignment.center,
            width: ScreenAdapter.width(80),
            height: ScreenAdapter.height(64),
            child:  Text('${cartItme["count"]}'),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(80),
            height: ScreenAdapter.height(64),
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
