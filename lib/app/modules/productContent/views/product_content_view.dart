import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/product_content_controller.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 扩展body区域到AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenAdapter.height(96)),
        child: Obx(()=> AppBar(
                  title: SizedBox(
                    width: ScreenAdapter.width(400),
                    height: ScreenAdapter.height(96),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("商品", style: TextStyle(fontSize: ScreenAdapter.fontSize(36))),
                              Container(
                                margin: EdgeInsets.only(top: ScreenAdapter.height(10)),
                                width: ScreenAdapter.width(100),
                                height: ScreenAdapter.width(2),
                                color: Colors.red,
                                // child: ,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("商品", style: TextStyle(fontSize: ScreenAdapter.fontSize(36))),
                              Container(
                                margin: EdgeInsets.only(top: ScreenAdapter.height(10)),
                                width: ScreenAdapter.width(100),
                                height: ScreenAdapter.width(2),
                                color: Colors.red,
                                // child: ,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("商品", style: TextStyle(fontSize: ScreenAdapter.fontSize(36))),
                              Container(
                                margin: EdgeInsets.only(top: ScreenAdapter.height(10)),
                                width: ScreenAdapter.width(100),
                                height: ScreenAdapter.width(2),
                                color: Colors.red,
                                // child: ,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white.withOpacity(controller.opcity.value),
                  elevation: 0,
                  leading: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
                      child: SizedBox(
                        width: ScreenAdapter.width(88),
                        height: ScreenAdapter.width(88),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0)
                            ),
                            // alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.black38),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              const CircleBorder()
                            )
                          ),
                          onPressed: (){},
                          child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new_outlined))),
                      ),
                    ),
                  actions: [
                    Container(
                      margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                      width: ScreenAdapter.width(88),
                      height: ScreenAdapter.width(88),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(0)
                          ),
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(Colors.black38),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            const CircleBorder()
                          )
                        ),
                        onPressed: (){},
                        child: IconButton(onPressed: (){}, icon: const Icon(Icons.file_upload_outlined))),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                      width: ScreenAdapter.width(80),
                      height: ScreenAdapter.width(80),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(0)
                          ),
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(Colors.black38),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            const CircleBorder()
                          )
                        ),
                        onPressed: (){},
                        child: IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz_rounded))),
                    ),
                  ],
                ),
        ),
      ),
      body: ListView(
        controller: controller.scrollController,
        children: [
          Container(
            width: ScreenAdapter.width(1080),
            height: ScreenAdapter.width(300),
            color: Colors.teal,
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          ),const ListTile(
            title: Text('assa'),
          ),
          const ListTile(
            title: Text('assa'),
          )
        ],
      ),
    );
  }
}
