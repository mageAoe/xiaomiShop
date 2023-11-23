import 'package:get/get.dart';
import 'package:xmshop/app/services/storage.dart';
import '../../../services/searchServices.dart';

class SearchPageController extends GetxController {
  //TODO: Implement SearchController

  String keywords = "";
  RxList historyList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  // 获取历史搜索
  getHistoryData()async {
    var tempList = await SearchServices.getHistoryData(keywords);
    if(tempList.isNotEmpty){
      historyList.addAll(tempList);
      update();
    }
  }

  // 清空
  clearHistoryData() async {
    await SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }

  // 删除
  removeHistoryData(keywords) async {
    var tempList = await SearchServices.getHistoryData(keywords);
    if(tempList.isNotEmpty){
      tempList.remove(keywords);
      await Storage.setData('searchList', tempList);
      historyList.remove(keywords);
      update();
    }
  }

}
