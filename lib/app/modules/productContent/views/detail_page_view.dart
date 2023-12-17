import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailPageView extends GetView {
  @override
  ProductContentController controller = Get.find();
  final Function subHeader;
  DetailPageView(this.subHeader, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.gk2,
      alignment: Alignment.center,
      width: ScreenAdapter.width(1080),
      child: Obx(() => controller.pcontent.value.content != null ? Column(
          children: [
            subHeader(),
             controller.selectedSubTabsIndex.value == 1
                ? SizedBox(
                    width: double.infinity,
                    child: Html(
                      data: controller.pcontent.value.content!,
                      style: {
                        "body":Style(
                          backgroundColor: Colors.white
                        ),
                        "p":Style(
                          fontSize: FontSize.large
                        )
                      },
                    ),
                    // child: Text("123"),
                  )
                :  SizedBox(
                    width: double.infinity,
                    child: Html(
                      data: controller.pcontent.value.specs,
                      style: {
                        "body":Style(
                          backgroundColor: Colors.white
                        ),
                        "p":Style(
                          fontSize: FontSize.large
                        )
                      },
                    ),
                    // child: Text("123"),
                  )
          ],
        ): const Text(''),
      ),
    );
  }
}
