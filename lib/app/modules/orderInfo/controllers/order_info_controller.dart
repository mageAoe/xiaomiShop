import 'package:get/get.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../services/httpsClient.dart';
import 'package:xmshop/app/models/user_model.dart';
import '../../../models/order_model.dart';

class OrderInfoController extends GetxController {
  final HttpsClient _httpsClient = HttpsClient();
  RxList<OrderInfoModel> orderList = <OrderInfoModel>[].obs;

  var orderId = Get.arguments['id'];

  @override
  onInit(){
    getOrderList();
    super.onInit();
  }

  getOrderList() async {
    // 获取用户信息
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'uid': userInfo.sid,
      "id":orderId
    };
    String sign = SignServices.getSign({
      ...tempJson,
      'salt': userInfo.salt
    });
    var res = await _httpsClient.get('api/orderInfo?uid=${userInfo.sid}&id=$orderId&sign=$sign');
    if(res.data != null){
      OrderModel tempList = OrderModel.fromJson(res.data);
      print(res.data);
      orderList.value = tempList.result??[];
      update();
    }
  }
}
