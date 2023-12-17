import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/modules/productContent/views/detail_page_view.dart';
import 'package:xmshop/app/modules/productContent/views/first_page_view.dart';
import 'package:xmshop/app/modules/productContent/views/recommend_page_view.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/product_content_controller.dart';
import './cart_item_num_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);

 // action 1 点击筛选属性 2、点击的是加入购物车  3、表示点击的是立即购买
  void showBottomAttr(int action) {
    Get.bottomSheet(GetBuilder<ProductContentController>(
        init: controller,
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            color: Colors.white,
            width: double.infinity,
            height: ScreenAdapter.height(1200),
            child: Stack(
              children: [
                ListView(
                  children: [
                    ...controller.pcontent.value.attr!.map((v) {
                    return Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdapter.height(20),
                            left: ScreenAdapter.width(20)),
                        width: ScreenAdapter.width(1040),
                        child: Text('${v.cate}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: ScreenAdapter.height(20),
                              left: ScreenAdapter.width(20)),
                          width: ScreenAdapter.width(1040),
                          child: Wrap(
                              children: v.attrList!.map((e) {
                            return InkWell(
                              onTap: () {
                                controller.changeAttr(v.cate, e['title']);
                              },
                              child: Container(
                                margin: EdgeInsets.all(ScreenAdapter.width(20)),
                                child: Chip(
                                    padding: EdgeInsets.only(
                                        left: ScreenAdapter.height(20),
                                        right: ScreenAdapter.width(20)),
                                    backgroundColor: e['checked'] == true
                                        ? Colors.red
                                        : const Color.fromARGB(31, 223, 213, 213),
                                    label: Text(e['title'])),
                              ),
                            );
                          }).toList())),
                    ],
                    );
                    }).toList(),
                     Padding(
                      padding: EdgeInsets.only(
                        left: ScreenAdapter.width(20),
                         top: ScreenAdapter.height(20),
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('数量',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                              CartItemNumView()
                        ],
                      ),
                    )
                  ]
                ),
                Positioned(
                  right: 2,
                  top: 0,
                  child: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  )
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: action == 1 ?
                   Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenAdapter.height(120),
                          margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(255, 165, 0, 0.9)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            onPressed: () {
                              controller.addCart();
                            },
                            child: const Text('加入购物车'),
                          ),
                        )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenAdapter.height(120),
                          margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(253, 1, 0, 0.9)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            onPressed: () {
                              controller.buy();
                            },
                            child: const Text('立即购买'),
                          ),
                        ))
                    ],
                   ):Row(
                    children: [
                      Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(253, 1, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        if(action == 2){
                          controller.addCart();
                        }else{
                          controller.buy();
                        }
                      },
                      child: const Text('确定'),
                    ),
                    ))
                    ],
                  )
                )
              ],
            ),
          );
        }));
  }

  Widget _appBar(BuildContext context) {
    return Obx(
      () => AppBar(
        title: SizedBox(
          width: ScreenAdapter.width(400),
          height: ScreenAdapter.height(96),
          child: controller.showTabs.value
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.tabsList.map((v) {
                    return InkWell(
                      onTap: () {
                        controller.changeSelectTabsIndex(v['id']);
                        // 跳转到指定的容器
                        if (v['id'] == 1) {
                          Scrollable.ensureVisible(
                              controller.gk1.currentContext as BuildContext,
                              duration: const Duration(milliseconds: 100));
                        } else if (v['id'] == 2) {
                          Scrollable.ensureVisible(
                              controller.gk2.currentContext as BuildContext,
                              duration: const Duration(milliseconds:100));
                           // 修正
                          Timer.periodic(const Duration(milliseconds: 101), (timer) {
                            controller.scrollController.jumpTo(controller.scrollController.position.pixels - ScreenAdapter.height(120));
                            timer.cancel();
                          });
                        } else {
                          Scrollable.ensureVisible(
                              controller.gk3.currentContext as BuildContext,
                              duration: const Duration(milliseconds: 100));
                           // 修正
                          // Timer.periodic(const Duration(milliseconds: 101), (timer) {
                          //   controller.scrollController.jumpTo(controller.scrollController.position.pixels - ScreenAdapter.height(120));
                          //   timer.cancel();
                          // });
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${v['title']}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36))),
                          v['id'] == controller.selecttabsIndex.value
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenAdapter.height(10)),
                                  width: ScreenAdapter.width(100),
                                  height: ScreenAdapter.width(2),
                                  color: Colors.red,
                                  // child: ,
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenAdapter.height(10)),
                                  width: ScreenAdapter.width(100),
                                  height: ScreenAdapter.width(2),
                                  color: Colors.transparent,
                                  // child: ,
                                )
                        ],
                      ),
                    );
                  }).toList(),
                )
              : const Text(''),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(controller.opcity.value),
        elevation: 0,
        leading: ProductHeaderButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              size: ScreenAdapter.fontSize(54)),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          ProductHeaderButton(
            icon: Icon(Icons.file_upload_outlined,
                size: ScreenAdapter.fontSize(54)),
            onPressed: () {
              print('showMenu');
            },
          ),
          ProductHeaderButton(
            icon: Icon(Icons.more_horiz_rounded,
                size: ScreenAdapter.fontSize(54)),
            onPressed: () {
              showMenu(
                  context: context,
                  color: Colors.black87.withOpacity(0.7),
                  position: RelativeRect.fromLTRB(ScreenAdapter.height(800),
                      ScreenAdapter.height(210), ScreenAdapter.height(20), 0),
                  items: [
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.home, color: Colors.white),
                        Text("首页", style: TextStyle(color: Colors.white))
                      ],
                    )),
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.message, color: Colors.white),
                        Text("消息", style: TextStyle(color: Colors.white))
                      ],
                    )),
                    const PopupMenuItem(
                        child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.white),
                        Text("收藏", style: TextStyle(color: Colors.white))
                      ],
                    ))
                  ]);
            },
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: [
            FirstPageView(showBottomAttr),
            DetailPageView(_subHeader),
            RecommendPageView(),
          ],
        ));
  }

  Widget _subHeader() {
    return Obx(()=> Container(
        color: Colors.white,
        child: Row(
            children: controller.subTabsList.map((e) {
          return Expanded(
              child: InkWell(
            onTap: () {
              controller.changeSelectedSubTabsIndex(e['id']);
            },
            child: Container(
              height: ScreenAdapter.height(120),
              alignment: Alignment.center,
              child: Text('${e['title']}',
                  style: TextStyle(
                      color: controller.selectedSubTabsIndex.value == e['id']
                          ? Colors.red
                          : Colors.black87)),
            ),
          ));
        }).toList()),
      ),
    );
  }

  Widget _bottomNav() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: ScreenAdapter.height(160),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      width: ScreenAdapter.width(2), color: Colors.black26))),
          child: Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: ScreenAdapter.width(130),
                    height: ScreenAdapter.height(160),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_2_outlined),
                        Text("客服",
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(32)))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(130),
                    height: ScreenAdapter.height(160),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star_border_outlined),
                        Text("收藏",
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(32)))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(130),
                    height: ScreenAdapter.height(160),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        Text("购物车",
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(32)))
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 165, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        showBottomAttr(2);
                      },
                      child: const Text('加入购物车'),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(253, 1, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        showBottomAttr(3);
                      },
                      child: const Text('立即购买'),
                    ),
                  ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 扩展body区域到AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenAdapter.height(120)),
        child: _appBar(context),
      ),
      body: Stack(
        children: [
          _body(),
          _bottomNav(),
          Obx(() => controller.showSubHeaderTabs.value
              ? Positioned(
                  left: 0,
                  top: ScreenAdapter.getStatusBarHeight() +
                      ScreenAdapter.height(120),
                  right: 0,
                  child: _subHeader())
              : const Text(''))
        ],
      ),
    );
  }
}

class ProductHeaderButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  const ProductHeaderButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      child: SizedBox(
          width: ScreenAdapter.width(88),
          height: ScreenAdapter.width(88),
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(Colors.black38),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(const CircleBorder())),
              onPressed: onPressed,
              child: icon)),
    );
  }
}
