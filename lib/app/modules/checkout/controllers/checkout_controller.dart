import 'package:get/get.dart';
import 'package:xmshop/app/services/storage.dart';

class CheckoutController extends GetxController {
  RxList checkoutList = [].obs;

  @override
  onInit(){
    getCheckoutData();
    super.onInit();
  }

  // 获取
  getCheckoutData() async{
    List tempList = await Storage.getData('checkoutList');
    checkoutList.value = tempList;
    update();
  }

}
