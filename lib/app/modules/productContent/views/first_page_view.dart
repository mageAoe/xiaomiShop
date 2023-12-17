import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';
import '../../../services/httpsClient.dart';

class FirstPageView extends GetView {
  @override
  ProductContentController controller = Get.find();
  final Function showBottomAttr;

  @override
  FirstPageView(this.showBottomAttr, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.pcontent.value.sId != null
          ? Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              key: controller.gk1,
              width: ScreenAdapter.width(1080),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                        HttpsClient.repleaUrl(controller.pcontent.value.pic),
                        fit: BoxFit.cover),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text(
                      '${controller.pcontent.value.title}',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: ScreenAdapter.fontSize(46)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text(
                      '${controller.pcontent.value.subTitle}',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: ScreenAdapter.fontSize(34)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Text("价格：",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("￥${controller.pcontent.value.price}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: ScreenAdapter.fontSize(86))),
                        ]),
                        Row(children: [
                          const Text("原价：",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("￥${controller.pcontent.value.oldPrice}",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: ScreenAdapter.fontSize(46),
                                  decoration: TextDecoration.lineThrough)),
                        ])
                      ],
                    ),
                  ),
                  // 筛选
                  Container(
                    height: ScreenAdapter.height(120),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: InkWell(
                      // GestureDetector  InkWell
                      onTap: () {
                        showBottomAttr(1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Row(
                              children: [
                                const Text('已选',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenAdapter.width(20)),
                                  child: Text(controller.selectedAttr.value),
                                )
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black38,
                              size: ScreenAdapter.fontSize(46))
                        ],
                      ),
                    ),
                  ),
                  // 门店
                  Container(
                    height: ScreenAdapter.height(120),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: InkWell(
                      onTap: () {
                        Get.bottomSheet(Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(32)),
                          color: Colors.white,
                          width: double.infinity,
                          height: ScreenAdapter.height(1080),
                          child: ListView(
                            children: const [Text("小米门店")],
                          ),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text('门店',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenAdapter.width(20)),
                                child: const Text('小米之家旺达专卖店'),
                              )
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black38,
                              size: ScreenAdapter.fontSize(46))
                        ],
                      ),
                    ),
                  ),
                  // 服务
                  Container(
                    height: ScreenAdapter.height(120),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: InkWell(
                      onTap: () {
                        Get.bottomSheet(Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(32)),
                          color: Colors.white,
                          width: double.infinity,
                          height: ScreenAdapter.height(1080),
                          child: ListView(
                            children: const [Text("小米服务说明")],
                          ),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text('服务',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Image.asset('assets/images/service.png')
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black38,
                              size: ScreenAdapter.fontSize(46))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : SizedBox(
              height: ScreenAdapter.height(2400),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
