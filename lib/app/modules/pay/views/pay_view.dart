import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/pay_controller.dart';

class PayView extends GetView<PayController> {
  const PayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('去支付'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(30)),
        children:  [
            Obx(()=> ListView.builder(
                itemCount: controller.payList.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      ListTile(
                        onTap: (){
                          controller.changePayList(index);
                        },
                        leading: Image.network(controller.payList[index]['image']),
                        title: Text('${controller.payList[index]['title']}'),
                        trailing: controller.payList[index]['checked'] ? const Icon(Icons.check):null,
                     ),
                     const Divider(),
                    ]
                  );
                }
              ),
            ),
            SizedBox(height: ScreenAdapter.height(200)),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
              10))
              ),
            ),
            onPressed: (){
              
            }, child: const Text('支付'))
        ],
      ),
    );
  }
}
