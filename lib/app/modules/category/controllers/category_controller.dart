import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../models/category_model.dart';


class CategoryController extends GetxController {
  //TODO: Implement CategoryController

  RxInt selectIndex = 0.obs;
  RxList<CategoryItem> leftCategoryList = <CategoryItem>[].obs;
  RxList<CategoryItem> rightCategoryList = <CategoryItem>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLeftCategoryList();
  }

 void changeIndex(index, String pid){
    selectIndex.value = index;
    getRightCategoryList(pid);
    update();
 }

 getLeftCategoryList() async {
    var res = await Dio().get("https://xiaomi.itying.com/api/pcate");
    CategoryModel category =  CategoryModel.fromJson(res.data);
    leftCategoryList.value = category.result!;
    getRightCategoryList(leftCategoryList[0].sId!);
    print(leftCategoryList[0].sId);
    update();
 }

  getRightCategoryList(String pid) async {
    var res = await Dio().get("https://xiaomi.itying.com/api/pcate?pid=$pid");
    CategoryModel category =  CategoryModel.fromJson(res.data);
    rightCategoryList.value = category.result!;
    update();
 }
}
