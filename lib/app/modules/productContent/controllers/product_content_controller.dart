import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../services/httpsClient.dart';

class ProductContentController extends GetxController {
  //TODO: Implement ProductContentController
  ScrollController scrollController = ScrollController();
  final HttpsClient _httpsClient = HttpsClient();

  
  GlobalKey gk1 = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();

  // 导航透明度
  RxDouble opcity = 0.0.obs;
  // 是否显示tab
  RxBool showTabs = false.obs;
  List tabsList = [
    {
      "id":1,
      "title":"商品",
    },
    {
      "id":2,
      "title":"详情",
    },
    {
      "id":3,
      "title":"推荐",
    }
  ];

  RxInt selecttabsIndex = 1.obs;
  // 详情数据
  var pcontent = ProductItemModel().obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    getCategoryData();
  }


  scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels <= 100){
        opcity.value = scrollController.position.pixels/100;
        if(showTabs.value == true){
          showTabs.value = false;
          update();
        }
        update();
      }else{
        if(showTabs.value == false){
          showTabs.value = true;
          update();
        }
      }
    });
  }
  // tabs 切换
  void changeSelectTabsIndex(int index){
    selecttabsIndex.value = index;
    update();
  }

  // 获取详情数据
  getCategoryData() async{
    var res = await _httpsClient.get("api/pcontent?id=${Get.arguments['id']}");
    if(res!=null){
      Product temData =  Product.fromJson(res.data);
      pcontent.value = temData.result!;
      update();
    }
  }

}
