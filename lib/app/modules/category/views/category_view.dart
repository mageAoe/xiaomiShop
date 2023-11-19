import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../controllers/category_controller.dart';

import '../../../services/screenAdaoter.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            Get.toNamed('/search');
          },
          child: Container(
            width: ScreenAdapter.width(840),
            height: ScreenAdapter.height(96),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromRGBO(246, 246, 246, 1)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 4, 0),
                    child: Icon(Icons.search, color: Colors.black45)),
                Text('手机',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdapter.fontSize(40),
                        fontWeight: FontWeight.w500)),
                // const Expanded(child: Text('')), // 中间用Expanded控件
                const Spacer(),
                const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Icon(Icons.fit_screen_sharp, color: Colors.black45)),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.ac_unit))
        ],
        elevation: 0,
      ),
      body: Row(
        children: [
          SizedBox(
            width: ScreenAdapter.width(280),
            height: double.infinity,
            child: Obx(() => ListView.builder(
              itemCount: controller.leftCategoryList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  height: ScreenAdapter.height(184),
                  child: Obx(() => InkWell(
                        onTap: () {
                          controller.changeIndex(index, controller.leftCategoryList[index].sId!);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: ScreenAdapter.width(10),
                                height: ScreenAdapter.height(46),
                                color: controller.selectIndex.value == index
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                            Center(
                              child: Text("${controller.leftCategoryList[index].title}", 
                                      style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(36),
                                        fontWeight: controller.selectIndex.value == index ? FontWeight.bold: FontWeight.normal)),
                            )
                          ],
                        ),
                    )),
                );
              },
            )),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: Obx(() => GridView.builder(
                itemCount: controller.rightCategoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: ScreenAdapter.width(40),
                  // mainAxisSpacing: ScreenAdapter.width(20),
                  childAspectRatio: 240/320
                ), 
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: () {
                      Get.toNamed('/product-list', arguments: {"cid": controller.rightCategoryList[index].sId});
                    },
                    child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Image.network(HttpsClient.repleaUrl(controller.rightCategoryList[index].pic), fit: BoxFit.fitHeight),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, 0),child: Text("${controller.rightCategoryList[index].title}", style: TextStyle(fontSize: ScreenAdapter.fontSize(32))))
                    ],
                  ),
                  );
                }
              )),
            ),
          )
        ],
      ),
    );
  }
}
