import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

import '../../../services/fonts.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: controller.pages,
        onPageChanged: (index){
          controller.setCurrentIndex(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        iconSize: 35,
        currentIndex: controller.currentIndex.value, // 选中的菜单
        type: BottomNavigationBarType.fixed, // 底部 4个或者4个以上的时候使用
        onTap: (index){
          controller.setCurrentIndex(index);
          controller.pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            label: '首页',
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: '分类',
            icon: Icon(XiaoMiFont.fenlei)
          ),
          BottomNavigationBarItem(
            label: '服务',
            icon: Icon(XiaoMiFont.fuwu)
          ),
          BottomNavigationBarItem(
            label: '购物车',
            icon: Icon(XiaoMiFont.gouwuche)
          ),
          BottomNavigationBarItem(
            label: '我的',
            icon: Icon(XiaoMiFont.wode)
          )
        ]
      ),
    ));
  }
}
