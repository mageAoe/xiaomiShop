import 'package:get/get.dart';

class PayController extends GetxController {
  
 RxInt payType = 0.obs;

 RxList payList = [
  {
    'id': 1,
    'title': '支付宝支付',
    'checked': true,
    'image': 'https://www.itying.com/themes/itying/images/alipay.png'
  },
  {
    'id': 2,
    'title': '微信支付',
    'checked': false,
    'image': 'https://www.itying.com/themes/itying/images/weixinpay.png'
  }
 ].obs;

 changePayList(index){
  List<Map<String, Object>> tempList = [];
  for (var i = 0; i < payList.length; i++) {
    payList[i]['checked'] = false;
    tempList.add(payList[i]);
  }
  tempList[index]['checked'] = true;
  payType.value = index;
  payList.value = tempList;
  update();
 }
}
