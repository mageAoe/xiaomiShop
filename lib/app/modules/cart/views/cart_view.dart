import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';
import '../controllers/cart_controller.dart';
import './cart_item_view.dart';

class CartView extends GetView {
  @override
  CartController controller = Get.put(CartController());
  CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('购物车',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            Obx(() => controller.isEdit.value
                ? TextButton(
                    onPressed: () {
                      controller.changeIsEdit();
                    },
                    child: const Text('删除',
                        style: TextStyle(
                          color: Colors.black,
                        )))
                : TextButton(
                    onPressed: () {
                      controller.changeIsEdit();
                    },
                    child: const Text('编辑',
                        style: TextStyle(color: Colors.black))))
          ],
        ),
        body: GetBuilder<CartController>(
          initState: (state) {
            controller.getCartListData();
          },
          init: controller,
          builder: (controller) {
            return Stack(
              children: [
                controller.cartList.isNotEmpty
                    ? ListView(
                        children: controller.cartList.map((v) {
                          return CartItemView(v);
                        }).toList(),
                      )
                    : const Center(
                        child: Text('购物车空空的'),
                      ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.only(right: ScreenAdapter.width(20)),
                      width: ScreenAdapter.width(1080),
                      height: ScreenAdapter.height(190),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border:
                              Border(top: BorderSide(color: Colors.black26))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  activeColor: Colors.orange[400],
                                  value: controller.checkedAllBox.value,
                                  onChanged: (value) {
                                    controller.checkedAllFunc(value);
                                  }),
                              const Text('全选')
                            ],
                          ),
                          Obx(() => controller.isEdit.value
                              ? Row(
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        255, 165, 0, 0.9)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        onPressed: () {
                                          controller.deleteCartData();
                                        },
                                        child: const Text('删除'))
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Text('合计: '),
                                    Text('￥98.9',
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(48),
                                            color: Colors.red)),
                                    SizedBox(width: ScreenAdapter.width(20)),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        255, 165, 0, 0.9)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        onPressed: () {
                                          // 判断用户是否登录
                                          // Get.toNamed('/checkout');
                                          controller.checkout();
                                        },
                                        child: const Text('结算'))
                                  ],
                                ))
                        ],
                      ),
                    ))
              ],
            );
          },
        ));
  }
}
