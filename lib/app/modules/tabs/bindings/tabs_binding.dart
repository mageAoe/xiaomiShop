import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../user/controllers/user_controller.dart';
import '../../give/controllers/give_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../category/controllers/category_controller.dart';

// 进入到 tab 页面就需要 懒加载这些个 控制器 controller

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<UserController>(
      () => UserController(),
    );

    Get.lazyPut<GiveController>(
      () => GiveController(),
    );

    // Get.lazyPut<CartController>(
    //   () => CartController(),
    // );

    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
  }
}
