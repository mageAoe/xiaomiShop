import 'package:get/get.dart';
import '../../../services/cartServices.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  RxList cartList = [].obs;

  @override
  void onInit() {
    super.onInit();
   getCartListData();
  }


  void getCartListData() async{
    var tempList = await CartServices.getCartList();
    cartList.value = tempList;
    update();
  }
  
}
