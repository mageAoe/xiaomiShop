import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/address_add_controller.dart';

import 'package:city_pickers/city_pickers.dart';

class AddressAddView extends GetView<AddressAddController> {
  const AddressAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新建收货地址'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: ScreenAdapter.width(20)),
        children: [
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            color: Colors.white,
            child: Column(
              children: [
              Row(
                children: [
                  Text('姓名',
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(42))),
                  SizedBox(width: ScreenAdapter.width(40)),
                   Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                            hintText: '请输入姓名', 
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: ScreenAdapter.fontSize(42)
                            )
                        ),
                      ))
                ],
              ),
              const Divider(height: 5, color: Colors.black),
              Row(
                children: [
                  Text('电话',
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(42))),
                  SizedBox(width: ScreenAdapter.width(40)),
                  Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.phoneController,
                       decoration: InputDecoration(
                            hintText: '请输入详细地址', 
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: ScreenAdapter.fontSize(42)
                            )
                        ),
                      ))
                ],
              ),
            ]),
          ),
          SizedBox(height: ScreenAdapter.height(40)),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            color: Colors.white,
            child: Column(
              children: [
              SizedBox(
                height: ScreenAdapter.height(160),
                child: InkWell(
                  onTap: () async {
                    Result? result = await CityPickers.showCityPicker(
                      context: context,
                    );
                    if(result != null){
                      print(result.provinceName);
                      controller.setArea("${result.provinceName} ${result.cityName} ${result.areaName}");
                    }
                  },
                  child: Row(
                    children: [
                      Text('所在地区',
                          style: TextStyle(fontSize: ScreenAdapter.fontSize(42))),
                      SizedBox(width: ScreenAdapter.width(40)),
                      Expanded(
                          flex: 1,
                          child: Obx(()=> controller.area.value == "" ? 
                            Text('所在地区', style: TextStyle(fontSize: ScreenAdapter.fontSize(42), color: Colors.black54))
                            :
                            Text(controller.area.value, style: TextStyle(fontSize: ScreenAdapter.fontSize(42), color: Colors.black54))
                          )
                       )
                    ],
                  ),
                ),
              ),
              const Divider(height: 5),
              Row(
                children: [
                  Text('详细地址',
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(42))),
                  SizedBox(width: ScreenAdapter.width(40)),
                  Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.addressController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: '请输入详细地址', 
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: ScreenAdapter.fontSize(42)
                            )
                        ),
                      ))
                ],
              ),
            ]),
          ),
          SizedBox(height: ScreenAdapter.height(200)),
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(40)),
            child: InkWell(
              onTap: (){
                controller.doAddress();
              },
              child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(251, 72, 5, 1),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: ScreenAdapter.height(140),
                      alignment: Alignment.center,
                      child: const Text('保存', style: TextStyle(color: Colors.white)),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
