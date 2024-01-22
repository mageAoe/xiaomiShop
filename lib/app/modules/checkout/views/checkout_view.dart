import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/checkout_controller.dart';

import '../../../services/httpsClient.dart';

class CheckoutView extends GetView<CheckoutController> {

  Widget checkoutItem(value){
    return Container(
      padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20), right: ScreenAdapter.height(20)),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(200),
            height: ScreenAdapter.width(200),
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Image.network('${ HttpsClient.repleaUrl(value["pic"])}', fit: BoxFit.fitHeight),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${value["title"]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenAdapter.height(10)),
                Text('${value["selectedAttr"]}'),
                SizedBox(height: ScreenAdapter.height(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('￥${value["price"]}', style: const TextStyle(color: Colors.red)),
                    Text('x${value["count"]}', style: const TextStyle(color: Colors.black87))
                  ],
                )
                
              ],
            ) 
          )
        ],
      ),
    );
  }

  Widget _body(){
    return ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        children: [
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: const ListTile(
              leading: Icon(Icons.add_location),
              title: Text('增加收获地址'),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          SizedBox( height: ScreenAdapter.height(40)),
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('张三 15866660001'),
                  SizedBox(
                    height: ScreenAdapter.height(10),
                  ),
                  const Text('东风科技水电费更好地')
                ],
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
          SizedBox( height: ScreenAdapter.height(40)),
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: Obx(()=> controller.checkoutList.isNotEmpty ? Column(
                children: 
                  controller.checkoutList.map((value) {
                    return checkoutItem(value);
                  }).toList(),
              ): const Text(''),
            ),
          ),
          SizedBox( height: ScreenAdapter.height(40)),
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: const Column(
              children: [
                ListTile(
                  title: Text('运费'),
                  trailing: Wrap(children: [Text('包邮')]),
                ),
                ListTile(
                  title: Text('优惠券'),
                  trailing: Wrap(
                    children: [
                      Text('无可用'),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                ListTile(
                  title: Text('卡券'),
                  trailing: Wrap(
                    children: [
                      Text('无可用'),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox( height: ScreenAdapter.height(40)),
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: const ListTile(
                  title: Text('发票'),
                  trailing: Wrap(
                    children: [
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
          ),
        ],
      );
  }

  Widget _bottom(){
    return Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  width: ScreenAdapter.width(1080),
                  height: ScreenAdapter.height(190),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.black26)),
                    boxShadow: [
                      BoxShadow(
                       color: Colors.red,
                       offset: Offset(1, 5)
                      ),
                      BoxShadow(
                       color: Colors.red,
                       offset: Offset(4, 10)
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                        const Text('共1件,合计: '),
                        Text('￥98.9', style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(48),
                          color: Colors.red
                        )), 
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(251, 72, 5, 1)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)))),
                          onPressed: (){
                            // 判断用户是否登录
                            Get.toNamed('/checkout');
                          }, 
                          child: const Text('结算')
                        )
                    ],
                  ),
                )
              );
  }

  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('确认订单'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _body(),
          _bottom()
        ],
      ),
    );
  }
}
