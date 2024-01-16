import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/views/cart_view.dart';
import '../../category/views/category_view.dart';
import '../../give/views/give_view.dart';
import '../../user/views/user_view.dart';
import '../../home/views/home_view.dart';


class TabsController extends GetxController {
  //TODO: Implement TabsController
  RxInt currentIndex = 0.obs;

  final PageController pageController = Get.arguments != null? PageController(initialPage: Get.arguments["initialPage"]) : PageController(initialPage: 0);

  List<Widget> pages = [
    const HomeView(),
    const CategoryView(),
    const GiveView(),
    CartView(),
    const UserView(),
  ];

  @override
  void onInit() {
    if( Get.arguments != null){
      currentIndex.value = Get.arguments["initialPage"];
      update();
    }
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  setCurrentIndex(int index){
    currentIndex.value = index;
    update();
  }

}
