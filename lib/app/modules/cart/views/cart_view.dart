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
        title: const Text('购物车', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){}, 
            child:  Text('编辑',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenAdapter.fontSize(48),
              fontWeight: FontWeight.w600)
              )
          )
        ],
        
      ),
      body: GetBuilder<CartController>(
        initState: (state){
          controller.getCartListData();
        },
          init: controller,
          builder: (controller){
            return Stack(
            children: [
              controller.cartList.isNotEmpty? ListView(
                  children: controller.cartList.map((v){
                    return CartItemView(v);
                  }).toList(),
                ): const Center(
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
                    border: Border(top: BorderSide(color: Colors.black26))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value){
                          print(value);
                        }),
                        const Text('全选')
                      ],
                    ),
                    Row(
                      children: [
                        const Text('合计: '),
                        Text('￥98.9', style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(48),
                          color: Colors.red
                        )),
                        SizedBox(width: ScreenAdapter.width(20)),
                        ElevatedButton(
                        style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(255, 165, 0, 0.9)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)))),
                          onPressed: (){}, 
                          child: const Text('结算')
                        )
                      ],
                    )
                    ],
                  ),
                )
              )
            ],
          );
          },
        )
    );
  }
}
