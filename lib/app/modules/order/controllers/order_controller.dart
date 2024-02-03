import 'package:get/get.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';
import '../../../services/httpsClient.dart';
import 'package:xmshop/app/models/user_model.dart';
import '../../../models/order_model.dart';

class OrderController extends GetxController {

  final HttpsClient _httpsClient = HttpsClient();
  RxList<OrderInfoModel> orderList = <OrderInfoModel>[].obs;

  @override
  onInit(){
    super.onInit();
    getOrderList();
  }

  getOrderList() async {
    // 获取用户信息
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    // 表单校验
    Map tempJson = {
      'uid': userInfo.sid,
    };
    String sign = SignServices.getSign({
      ...tempJson,
      'salt': userInfo.salt
    });
    var res = await _httpsClient.get('api/orderList?uid=${userInfo.sid}&sign=$sign');
    if(res!= null){
      OrderModel tempList = OrderModel.fromJson(res.data);
      orderList.value = tempList.result!;
      update();
    }
  }
}
