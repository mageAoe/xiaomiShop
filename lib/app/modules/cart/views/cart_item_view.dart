import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';
import './cart_item_num_view.dart';
import '../../../services/httpsClient.dart';
import '../controllers/cart_controller.dart';

class CartItemView extends GetView {
  
  final Map cartItme;
  @override
  CartController controller = Get.find();
  CartItemView(this.cartItme, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: ScreenAdapter.height(20),bottom: ScreenAdapter.height(20)),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenAdapter.height(20)),
            width: ScreenAdapter.width(100),
            child: Checkbox(
                  activeColor: Colors.red,
                  value: cartItme['checked'], 
                  onChanged: (value){
                    controller.checkCartItem(cartItme);
                  }
                ),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            padding: EdgeInsets.all(ScreenAdapter.height(24)),
            width: ScreenAdapter.width(260),
            child: Image.network('${HttpsClient.repleaUrl(cartItme["pic"])}',fit: BoxFit.cover),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${cartItme["title"]}', style: TextStyle(
                  fontSize: ScreenAdapter.fontSize(36),
                  fontWeight: FontWeight.bold
                )),
                SizedBox(height: ScreenAdapter.height(20)),
                Row(
                  children: [
                    Chip(label: Text('${cartItme["selectedAttr"]}'))
                  ],
                ),
                SizedBox(height: ScreenAdapter.height(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('￥${cartItme["price"]}', style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(48),
                      color: Colors.red
                    )),
                     CartItemNumView(cartItme)
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
