import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/order_model.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../controllers/order_info_controller.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';

class OrderInfoView extends GetView<OrderInfoController> {
  const OrderInfoView({Key? key}) : super(key: key);

  Widget orderItem(OrderItemModel value){
    return Container(
      padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20), right: ScreenAdapter.height(20)),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(200),
            height: ScreenAdapter.width(200),
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Image.network('${HttpsClient.repleaUrl(value.productImg)}', fit: BoxFit.fitHeight),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${value.productTitle}', style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenAdapter.height(10)),
                Text('${value.selectedAttr}'),
                SizedBox(height: ScreenAdapter.height(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('￥${value.productPrice}', style: const TextStyle(color: Colors.red)),
                    Text('x${value.productCount}', style: const TextStyle(color: Colors.black87))
                  ],
                )
                
              ],
            ) 
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text('订单详情'),
        centerTitle: true,
      ),
      body: Obx(()=> controller.orderList.isNotEmpty? ListView(
          children: [
            // 商品信息
            Container(
              padding: EdgeInsets.only(
                top: ScreenAdapter.height(20),
                bottom: ScreenAdapter.height(20)
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    title: Text('商品信息', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  // orderItem()
                  ...controller.orderList[0].orderItem!.map((e){
                    return orderItem(e);
                  }).toList()
                ],
              ),
            ),
            
            // 订单信息
            SizedBox(height: ScreenAdapter.height(30)),
            Container(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(20),
                  bottom: ScreenAdapter.height(20)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
              child:  Column(
                children: [
                   const ListTile(
                    title: Text("订单信息",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text("订单编号：${controller.orderList[0].orderId}"),
                  ),
                  ListTile(
                    title: Text("下单时间：${DateTime.fromMillisecondsSinceEpoch(controller.orderList[0].addTime!)}"),
                  ),
                  const ListTile(
                    title: Text("支付方式： 微信支付"),
                  ),
                  const ListTile(
                    title: Text("支付时间：xxxxxxxxxxx"),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenAdapter.height(40)),
            //配送信息
            Container(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(20),
                  bottom: ScreenAdapter.height(20)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
              child:  Column(
                children: [
                  const ListTile(
                    title: Text("配送信息",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const ListTile(
                    title: Text("配送方式：圆通快递"),
                  ),
                  ListTile(
                    title: Text("收货人:${controller.orderList[0].name} ${controller.orderList[0].phone}"),
                  ),
                  ListTile(
                    title: Text("收货地址: ${controller.orderList[0].address}"),
                  ),
                ],
              ),
            ),
            //支付金额
             SizedBox(height: ScreenAdapter.height(40)),
            Container(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(20),
                  bottom: ScreenAdapter.height(20)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
              child:  Column(
                children: [
                  ListTile(
                    title: const Text("商品总额"),
                    trailing: Text("¥${controller.orderList[0].allPrice}元"),
                  ),
                  const ListTile(
                    title: Text("运费"),
                    trailing: Text("¥0元"),
                  ),
                    ListTile(
                    trailing: Text("实付款 ¥${controller.orderList[0].allPrice}元"),
                  ),
                ],
              ),
            ),
          ],
        ): const Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
}
