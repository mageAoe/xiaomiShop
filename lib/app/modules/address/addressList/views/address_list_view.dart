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
                    children: controller.addressList.map((value) {
                    return value.defaultAddress == 1?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.check, color: Colors.red),
                          title: InkWell(
                            onTap: (){
                              controller.changeDefaultAddress(value.sId);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${value.address}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenAdapter.fontSize(46))),
                                SizedBox(height: ScreenAdapter.height(24)),
                                Text('${value.name} ${value.phone}'),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: (){
                              Get.toNamed('/address-edit', arguments: {
                                'id': value.sId,
                                'name': value.name,
                                'phone': value.phone,
                                'address': value.address
                              });
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ),
                        const Divider(height: 3),
                        SizedBox(height: ScreenAdapter.height(30)),
                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: InkWell(
                            onLongPress: (){
                              Get.defaultDialog(
                                title: "提示信息!",
                                middleText: "您确定要删除吗？",
                                confirm: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const  Color.fromARGB(209, 212, 209, 209)),
                                    foregroundColor: MaterialStateProperty.all(Colors.red)
                                  ),
                                  onPressed: (){
                                    controller.deleteAddress(value.sId);
                                    Get.back();
                                }, child: const Text('确定')
                                ),
                                cancel: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const  Color.fromARGB(209, 212, 209, 209)),
                                    foregroundColor: MaterialStateProperty.all(Colors.white)
                                  ),
                                  onPressed: (){
                                    Get.back();
                                  }, child:  const Text('取消')
                                )
                              );
                            },
                            onTap: (){
                              controller.changeDefaultAddress(value.sId);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${value.address}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenAdapter.fontSize(46))),
                                SizedBox(height: ScreenAdapter.height(24)),
                                Text('${value.name} ${value.phone}'),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: (){
                              Get.toNamed('/address-edit', arguments: {
                                'id': value.sId,
                                'name': value.name,
                                'phone': value.phone,
                                'address': value.address
                              });
                            },
                            icon: const Icon(Icons.edit),
                          )
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
