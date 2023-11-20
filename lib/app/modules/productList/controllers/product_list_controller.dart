import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/plist_model.dart';

import '../../../services/httpsClient.dart';

class ProductListController extends GetxController {
  //TODO: Implement ProductListController
  GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  final HttpsClient _httpsClient = HttpsClient();
  RxList<PlistItemModel> plist = <PlistItemModel>[].obs;

  int page = 1;
  int limit = 8;
  bool flag = true;
  RxBool hasData = true.obs;
  String sort = "";

  String? keywords = Get.arguments['keywords'];
  String? cid = Get.arguments['cid'];
  String apiUrl = "";



  // 二级导航数据
  List subHeaderList = [
    {"id": 1,"title":"综合","fieds": "all","sort": -1},
    {"id": 2,"title":"销量","fieds": "salecount","sort": -1},
    {"id": 3,"title":"价格","fieds": "price","sort": -1},
    {"id": 4,"title":"筛选",},
  ];
  // 二级导航
  RxInt selectHeaderId = 1.obs;
  // 箭头
  RxInt subHeaderSort = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPlistData();
    initScrollController();
  }

  // 二级导航
  void subHeaderChange(id){
    if(id == 4){
      // 弹出
      selectHeaderId.value = id;
      scaffoldGlobalKey.currentState!.openEndDrawer();
    }else{
      selectHeaderId.value = id;
      // 改变排序
      sort = "${subHeaderList[id-1]['fieds']}_${subHeaderList[id-1]['sort']}"; 
      // 切换排序
      subHeaderList[id-1]['sort'] = subHeaderList[id-1]['sort'] * -1;

      subHeaderSort.value = subHeaderList[id-1]['sort'];

      // 重置page
      page = 1;
      plist.value = [];
      hasData.value = true;
      // 滚动条回到顶部
      scrollController.jumpTo(0);
      // 重新请求接口
      getPlistData();
    }
  }

  // 监听滚动条事件
  void initScrollController(){
    scrollController.addListener(() {
      // _scrollController.position.pixels // 滚动条下拉的高度
      // _scrollController.position.maxScrollExtent // 页面的高度
      if(scrollController.position.pixels > (scrollController.position.maxScrollExtent - 20)){
        getPlistData();
      }
    });
  }


  void getPlistData() async{
    if(flag && hasData.value){
      flag = false;
      
      if(cid!=null){
        apiUrl = "api/plist?cid=$cid&page=$page&pageSize=$limit&sort=$sort";
      }else{
         apiUrl = "api/plist?search=$keywords&page=$page&pageSize=$limit&sort=$sort";
      }

      var res = await _httpsClient.get(apiUrl);
      if(res!=null){
        PlistModel category =  PlistModel.fromJson(res.data);
        // 拼接数据
        // plist.value = category.result!;
        plist.addAll(category.result!);
        page++;
        update();
        flag = true;
        if(category.result!.length < limit){
          hasData.value = false;
        }
      } 
    }
  }
}
