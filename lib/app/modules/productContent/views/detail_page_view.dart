import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';


class DetailPageView extends GetView {

  @override
  ProductContentController controller = Get.find();
  DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
              key: controller.gk2,
              width: ScreenAdapter.width(1080),
              height: ScreenAdapter.height(1600),
              color: Colors.pink,
          );
  }
}
