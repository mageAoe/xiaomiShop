import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/order_controller.dart';

import '../../../services/httpsClient.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text('订单'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(()=> controller.orderList.isNotEmpty? ListView(
              padding: EdgeInsets.only(top: ScreenAdapter.width(140),left: ScreenAdapter.width(20),right: ScreenAdapter.width(20),bottom: ScreenAdapter.width(20)),
              children: 
              controller.orderList.map((value){
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey[200]!
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 0,
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/order-info', arguments: {
                        'id': value.sId
                      });
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('订单编号:${value.orderId}'),
                        ),
                        Column(
                          children: 
                          value.orderItem!.map((item){
                            return ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: ScreenAdapter.width(120),
                                height: ScreenAdapter.height(120),
                                child: Image.network('${HttpsClient.repleaUrl(item.productImg)}', fit: BoxFit.cover),
                              ),
                              title:  Text('${item.productTitle}'),
                              trailing:  Text('x${item.productCount}'),
                           );
                          }).toList()
                        ),
                        ListTile(
                          leading: Wrap(
                            children: [
                              const Text('合计：'),
                              Text('￥${value.allPrice}', style: const TextStyle(color: Colors.red))
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey[200])
                            ), 
                            child: const Text('申请售后'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList()
            ):const Center(child: Text('您还没有订单')),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: Colors.grey[50],
              width: ScreenAdapter.width(10780),
              height: ScreenAdapter.height(120),
              child: const Row(
                children: [
                  Expanded(
                    child: Text('全部', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('代付款', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('待收货', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('已完成', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('已取消', textAlign: TextAlign.center),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
