import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/views/cart_view.dart';
import '../../category/views/category_view.dart';
import '../../give/views/give_view.dart';
import '../../user/views/user_view.dart';
import '../../home/views/home_view.dart';


class TabsController extends GetxController {
  //TODO: Implement TabsController
  RxInt currentIndex = 3.obs;

  final PageController pageController = PageController(initialPage: 3);

  List<Widget> pages = [
    const HomeView(),
    const CategoryView(),
    const UserView(),
    const CartView(),
    const GiveView(),
  ];

  // @override
  // void onInit() {
  //   super.onInit();
  // }

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
