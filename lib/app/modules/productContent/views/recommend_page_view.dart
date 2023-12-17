import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';


class RecommendPageView extends GetView {
  @override
  ProductContentController controller = Get.find();
  RecommendPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
              key: controller.gk3,
              width: ScreenAdapter.width(1080),
              height: ScreenAdapter.height(2800),
              color: Colors.yellow,
              child: const Text('推荐商品'),
          );
  }
}
