import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/address_list_controller.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';

class AddressListView extends GetView<AddressListController> {
  const AddressListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收货地址'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        child: Stack(
          children: [
            Obx(() => controller.addressList.isNotEmpty
                ? ListView(
                    children: controller.addressList.map((vlaue) {
                    return vlaue.defaultAddress == 1?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.check, color: Colors.red),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${vlaue.address}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenAdapter.fontSize(46))),
                              SizedBox(height: ScreenAdapter.height(24)),
                              Text('${vlaue.name} ${vlaue.phone}'),
                            ],
                          ),
                          trailing: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        const Divider(height: 3),
                        SizedBox(height: ScreenAdapter.height(30)),
                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: (){
                            controller.changeDefaultAddress(vlaue.sId);
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${vlaue.address}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenAdapter.fontSize(46))),
                              SizedBox(height: ScreenAdapter.height(24)),
                              Text('${vlaue.name} ${vlaue.phone}'),
                            ],
                          ),
                          trailing: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        const Divider(height: 3),
                        SizedBox(height: ScreenAdapter.height(30)),
                      ],
                    );
                  }).toList())
                : const Text('')),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/address-add');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(251, 72, 5, 1),
                        borderRadius: BorderRadius.circular(20)),
                    height: ScreenAdapter.height(140),
                    alignment: Alignment.center,
                    child: const Text('新建收货地址',
                        style: TextStyle(color: Colors.white)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
