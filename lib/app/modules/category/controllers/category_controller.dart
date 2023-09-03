import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../services/httpsClient.dart';


class CategoryController extends GetxController {
  //TODO: Implement CategoryController
  final HttpsClient _httpsClient = HttpsClient();

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
    var res = await _httpsClient.get("https://xiaomi.itying.com/api/pcate");
    if(res!=null){
      CategoryModel category =  CategoryModel.fromJson(res.data);
      leftCategoryList.value = category.result!;
      getRightCategoryList(leftCategoryList[0].sId!);
      print(leftCategoryList[0].sId);
      update();
    }
 }

  getRightCategoryList(String pid) async {
    var res = await _httpsClient.get("https://xiaomi.itying.com/api/pcate?pid=$pid");
    if(res!=null){
      CategoryModel category =  CategoryModel.fromJson(res.data);
      rightCategoryList.value = category.result!;
      update();
    }
 }
}
