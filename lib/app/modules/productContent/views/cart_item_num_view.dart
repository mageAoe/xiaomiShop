import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';
// import '../controllers/product_content_controller.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';

class CartItemNumView extends GetView {

  @override
  ProductContentController controller = Get.find();
  CartItemNumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(304),
      height: ScreenAdapter.height(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenAdapter.width(35)),
        border: Border.all(
          width: ScreenAdapter.width(2),
          color: Colors.black12
        )
      ),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              controller.decBuyNum();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenAdapter.width(100),
              height: ScreenAdapter.height(80),
              child: const Text('—'),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border(
                 left: BorderSide(width: ScreenAdapter.width(2),color: Colors.black12),
                 right: BorderSide(width: ScreenAdapter.width(2),color: Colors.black12)
                )
              ),
              alignment: Alignment.center,
              width: ScreenAdapter.width(100),
              height: ScreenAdapter.height(80),
              child:  Text('${controller.buyNum.value}'),
            ),
          InkWell(
            onTap: (){
              controller.incBuyNum();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenAdapter.width(100),
              height: ScreenAdapter.height(80),
              child: const Text('+'),
            ),
          ),
        ],
      ),
    );
  }
}
