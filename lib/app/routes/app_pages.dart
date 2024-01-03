import 'package:get/get.dart';

import '../modules/productContent/bindings/product_content_binding.dart';
import '../modules/productContent/views/product_content_view.dart';
import '../modules/productList/bindings/product_list_binding.dart';
import '../modules/productList/views/product_list_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

import '../modules/cart/views/cart_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABS;

  static final routes = [
    GetPage(
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => const ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      // 配置单独的动画效果
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_CONTENT,
      page: () => const ProductContentView(),
      binding: ProductContentBinding(),
    ),
    GetPage(
      name: _Paths.Cart,
      page: () => CartView(),
      // 自动注入的控制器取消，会导致底部导航栏无法显示
    ),
  ];
}
