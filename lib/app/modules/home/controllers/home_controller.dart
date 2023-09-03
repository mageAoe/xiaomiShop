
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/focus_model.dart';
import '../../../models/category_model.dart';
import '../../../models/plist_model.dart';
import '../../../services/httpsClient.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final HttpsClient _httpsClient = HttpsClient();

  // 浮动导航
  RxBool flag = false.obs;

  ScrollController scrollController = ScrollController();

  RxList<ResultItme> swiperList = <ResultItme>[].obs;
  RxList<CategoryItem> categoryList = <CategoryItem>[].obs;
  RxList hotList = [].obs;
  RxList<PlistItemModel> sellingPlist = <PlistItemModel>[].obs;

  RxList<PlistItemModel> bestgPlist = <PlistItemModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    // 请求接口
    getFocusList();

    getCategoryData();

    getHotData();
    // 获取热销臻选 商品数据
    getSellingPlistData();
    // 获取热门商品数据
    getBestPlistData();
  }

  scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels > 10 && scrollController.position.pixels < 30){
        if(flag.value == false){
          flag.value = true;
          update();
        }
      }
      if(scrollController.position.pixels < 10){
        if(flag.value == true){
          flag.value = false;
          update();
        }
      }
    });
  }

  // 获取轮播图数据
  getFocusList() async{
    var res = await _httpsClient.get("api/focus");
    if(res != null){
      FocusModels focus =  FocusModels.fromJson(res.data);
      swiperList.value = focus.result!;
      update();
    }
  }

  // 获取分类数据
  getCategoryData() async{
    var res = await _httpsClient.get("api/bestCate");
    if(res!=null){
      CategoryModel category =  CategoryModel.fromJson(res.data);
      categoryList.value = category.result!;
      update();
    }
  }

  // 获取热销臻选数据
  getHotData() async{
    var res = await _httpsClient.get("api/focus?position=2");
    if(res!=null){
        hotList.value = res.data['result'];
        update();
    }
  }

  // 获取热销臻选 商品数据
  getSellingPlistData() async{
    var res = await _httpsClient.get("api/plist?is_hot=1");
    if(res!=null){
      PlistModel selling =  PlistModel.fromJson(res.data);
      sellingPlist.value = selling.result!;
      update();
    }
  }

  // 获取热门商品数据
  getBestPlistData() async{
    var res = await _httpsClient.get("api/plist?is_best=1");
    if(res!=null){
      PlistModel best =  PlistModel.fromJson(res.data);
      bestgPlist.value = best.result!;
      update();
    }
  }

}
