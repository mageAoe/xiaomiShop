import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductContentController extends GetxController {
  //TODO: Implement ProductContentController
  ScrollController scrollController = ScrollController();
  
  RxDouble opcity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
  }


  scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels <= 100){
        opcity.value = scrollController.position.pixels/100;
        print(opcity.value);
        update();
      }
    });
  }

}
