import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

import '../../../services/screenAdaoter.dart';

import '../../../services/httpsClient.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  Widget _producteListWidget() {
    // print(controller.plist.isNotEmpty);
    return ListView.builder(
            controller: controller.scrollController,
            // padding: EdgeInsets.fromLTRB(
            //     ScreenAdapter.height(26),
            //     ScreenAdapter.height(120),
            //     ScreenAdapter.height(26),
            //     ScreenAdapter.height(26)),
            padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(120), 0, 0),
            itemCount: controller.plist.length,
            itemBuilder: (content, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    // margin: EdgeInsets.only(bottom: ScreenAdapter.height(26)),
                    child: Row(
                      children: [
                        // 左侧
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(60)),
                          width: ScreenAdapter.width(400),
                          height: ScreenAdapter.height(460),
                          child: Image.network(
                              "${HttpsClient.repleaUrl(controller.plist[index].pic)}",
                              fit: BoxFit.fitHeight),
                        ),
                        // 右侧
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.height(20)),
                              child: Text("${controller.plist[index].title}",
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(42),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.height(20)),
                              child: Text("${controller.plist[index].subTitle}",
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(34),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.height(20)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text("超大屏",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                      Text("6.1寸",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text("超大屏",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                      Text("6.1寸",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text("超大屏",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                      Text("6.1寸",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            Text("￥${controller.plist[index].price}元",
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(38),
                                    fontWeight: FontWeight.bold))
                          ],
                        ))
                      ],
                    ),
                  ),
                  (index == controller.plist.length - 1)
                      ? _progressIndicator()
                      : const Text('')
                ],
              );
            }) ;
  }

  Widget _subHeaderWidget() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Obx(() => Container(
              height: ScreenAdapter.height(120),
              width: ScreenAdapter.width(1080),
              decoration: BoxDecoration(
                  color: Colors
                      .white, // 有color 跟 BoxDecoration，color必须要放到 decoration里面
                  border: Border(
                      bottom: BorderSide(
                          width: ScreenAdapter.height(2),
                          color: const Color.fromRGBO(233, 233, 233, 0.9)))),
              child: Row(
                children: controller.subHeaderList.map((value) {
                  return Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.subHeaderChange(value['id']);
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  ScreenAdapter.height(16),
                                  0,
                                  ScreenAdapter.height(16)),
                              child: Text("${value['title']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(32),
                                      color: controller.selectHeaderId ==
                                              value["id"]
                                          ? Colors.red
                                          : Colors.black54)),
                            ),
                          ),
                          _showIcon(value['id'])
                        ],
                      ));
                }).toList(),
              ),
            )));
  }

  // 自定义箭头组件
  Widget _showIcon(id){
    if(id == 2 || id == 3 || controller.subHeaderSort.value == 1 || controller.subHeaderSort.value == -1){
      if(controller.subHeaderList[id-1]["sort"] == 1){
        return Icon(Icons.arrow_drop_down, color: controller.selectHeaderId == id ?Colors.red: Colors.black54);
      }else{
         return Icon(Icons.arrow_drop_up, color: controller.selectHeaderId == id ?Colors.red: Colors.black54);
      }
    }else{
       return const Text("");
    }
  }

  Widget _progressIndicator() {
    if (controller.hasData.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text('暂无数据'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      key: controller.scaffoldGlobalKey,
      endDrawer: const Drawer(
        child: DrawerHeader(
          child: Text("data"),
        ),
      ),
      appBar: AppBar(
        title: Container(
          width: ScreenAdapter.width(900),
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(246, 246, 246, 1)),
          child: InkWell(
            onTap: () {
              Get.offAndToNamed('/search');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 4, 0),
                    child: Icon(Icons.search, color: Colors.black45)),
                Text(controller.keywords != null ? "${controller.keywords}":"",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdapter.fontSize(40),
                        fontWeight: FontWeight.w500)),
                const Expanded(child: Text('')), // 中间用Expanded控件
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: const [Text('')],
      ),
      body: Obx(() => controller.plist.isNotEmpty
        ? Stack(
        children: [_producteListWidget(), _subHeaderWidget()],
      ): _progressIndicator()),
    );
  }
}
