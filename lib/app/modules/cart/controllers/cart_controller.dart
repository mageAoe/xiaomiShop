import 'package:get/get.dart';
import '../../../services/cartServices.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  RxList cartList = [].obs;
  RxBool checkedAllBox = false.obs;

  void getCartListData() async{
    var tempList = await CartServices.getCartList();
    cartList.value = tempList;
    checkedAllBox.value = isCheckedAll();
    update();
  }

  // 增加数量
  void incCartNum(cartItme){
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["_id"] == cartItme["_id"] && cartItme["selectedAttr"] == cartItme["selectedAttr"]){
        cartList[i]["count"]++;
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCheckedCartData(tempList);
    update();
  }

  // 减少数量
  void decCartNum(cartItme){
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["_id"] == cartItme["_id"] && cartItme["selectedAttr"] == cartItme["selectedAttr"]){
        if(cartList[i]["count"] > 1){
          cartList[i]["count"]--;
        }else{
          // 如何小于 1 那么应该将当前商品删除掉
        }
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCheckedCartData(tempList);
    update();
  }

  // 选中商品
  void checkCartItem(cartItme){
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["_id"] == cartItme["_id"] && cartItme["selectedAttr"] == cartItme["selectedAttr"]){
        cartList[i]['checked'] = !cartList[i]['checked'];
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    checkedAllBox.value = isCheckedAll();
    CartServices.setCheckedCartData(tempList);
    update();
  }

  // 全选 反选
  void checkedAllFunc(value){
    checkedAllBox.value = value;
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
       cartList[i]['checked'] = value;
       tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCheckedCartData(tempList);
    update();
  }

  // 判断是否全选
  bool isCheckedAll(){
    if(cartList.isNotEmpty){
      for (var i = 0; i < cartList.length; i++) {
        if(cartList[i]['checked'] == false){
          return false;
        }
      }
      return true;
    }
    return false;
  }
  
}
