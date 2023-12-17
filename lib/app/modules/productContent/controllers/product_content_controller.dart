import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';
import '../../../models/product_model.dart';
import '../../../services/httpsClient.dart';
import '../../../services/cartServices.dart';

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
  RxList<ProductAttrModel> attrList = <ProductAttrModel>[].obs;

  // container的位置
  double gk2Position = 0;
  double gk3Position = 0;
  // 是否显示详情tab
  RxBool showSubHeaderTabs = false.obs;
  // 保存筛选属性值
  RxString selectedAttr = ''.obs;

  // 购买的数量
  RxInt buyNum = 1.obs;

  List subTabsList = [
    {
      "id":1,
      "title":"商品介绍",
    },
    {
      "id":2,
      "title":"规格参数",
    },
  ];
  RxInt selectedSubTabsIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    getCategoryData();
  }

  // 获取元素的位置
  void getContainerPosition(double pixels){
    RenderBox box2 = gk2.currentContext!.findRenderObject() as RenderBox;
    gk2Position = box2.localToGlobal(Offset.zero).dy + pixels - (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(120)); // 获取纵轴的位置

    RenderBox box3 = gk3.currentContext!.findRenderObject() as RenderBox;
    gk3Position = box3.localToGlobal(Offset.zero).dy + pixels; // 获取纵轴的位置
  }

  /// 监听详情滑动
  scrollControllerListener(){
    scrollController.addListener(() {
      if(gk2Position ==0 && gk3Position == 0){
        // 获取第二屏跟第三屏的高度 距离顶部的高度
        getContainerPosition(scrollController.position.pixels);
      }
      // 显示隐藏tab
      if(scrollController.position.pixels >gk2Position && scrollController.position.pixels < gk3Position){
        if(showSubHeaderTabs.value == false){
          showSubHeaderTabs.value = true;
          selecttabsIndex.value = 2;
          update();
        }
      }else if(scrollController.position.pixels >0 && scrollController.position.pixels < gk2Position){
        if(showSubHeaderTabs.value == true){
          showSubHeaderTabs.value = false;
          selecttabsIndex.value = 1;
          update();
        }
      }else if(scrollController.position.pixels > gk2Position){
        if(showSubHeaderTabs.value == true){
          showSubHeaderTabs.value = false;
          selecttabsIndex.value = 3;
          update();
        }
      }

      if(scrollController.position.pixels <= 100){
        opcity.value = scrollController.position.pixels/100;
        if(opcity.value > 0.85){
          opcity.value = 1;
        }
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
        if(scrollController.position.pixels >= 200 && opcity.value < 1){
          opcity.value = 1;
        }
      }
    });
  }

  // tabs 切换
  void changeSelectTabsIndex(int index){
    selecttabsIndex.value = index;
    update();
  }

  // 改变内容区域的 tabs 切换
  void changeSelectedSubTabsIndex(index){
    selectedSubTabsIndex.value = index;
    // 跳转到指定位置
    scrollController.jumpTo(gk2Position);
    update();
  }

  // 获取详情数据
  getCategoryData() async{
    var res = await _httpsClient.get("api/pcontent?id=${Get.arguments['id']}");
    if(res!=null){
      Product temData =  Product.fromJson(res.data);
      pcontent.value = temData.result!;
      attrList.value = pcontent.value.attr!;
      initAttr(attrList); // 初始化
      setSelectedAttr(); // 获取商品属性
      update();
    }
  }

  // 重构 attr里面的数据结构
  initAttr(List<ProductAttrModel> attr){
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list!.length; j++) {
        if(j==0){
          attr[i].attrList!.add({
            "title": attr[i].list![j],
            "checked": true
          });
        }else{
           attr[i].attrList!.add({
            "title": attr[i].list![j],
            "checked": false
          });
        }
      }
    }
  }

  // 切换attr
  changeAttr(cate,title){
    for (var i = 0; i < attrList.length; i++) {
      if(attrList[i].cate == cate){
        for (var j = 0; j < attrList[i].list!.length; j++) {
          attrList[i].attrList![j]['checked'] = false;
          if(attrList[i].attrList![j]['title'] == title){
            attrList[i].attrList![j]['checked'] = true;
          }
        }
      }
    }
    update();
  }

  // 获取 attr 属性
  setSelectedAttr(){
    List tempList = [];
     for (var i = 0; i < attrList.length; i++) {
      for (var j = 0; j < attrList[i].list!.length; j++) {
          if(attrList[i].attrList![j]['checked']){
            tempList.add(attrList[i].attrList![j]['title']);
          }
        }
    }
    selectedAttr.value = tempList.join(',');
    update();
  }

  // 增加数量
  incBuyNum(){
    buyNum.value++;
    update();
  }

  // 减少数量
  decBuyNum(){
    if(buyNum.value > 1){
      buyNum.value--;
      update();
    }
  }

  void addCart(){
    setSelectedAttr();
    // print('加入购物车');
    CartServices.addCart(pcontent.value, selectedAttr.value, buyNum.value);
    Get.back();
    Get.snackbar('提示!', "加入购物车成功");
  }

  void buy(){
    setSelectedAttr();
    print('立即购买');
    Get.back();
  }
}
