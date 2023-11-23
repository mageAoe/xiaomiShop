import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

import '../../../services/screenAdaoter.dart';

import '../../../services/searchServices.dart';

class SearchView extends GetView<SearchPageController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246,246,246,1),
      appBar: AppBar(
        title: SearchHeaderWidget(),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              // 保存搜索记录
              SearchServices.setHistoryData(controller.keywords);
              // 替换路由
              Get.offAndToNamed('/product-list',arguments: {
                "keywords": controller.keywords
              });
            }, 
            child: Text('搜索',style: TextStyle(fontSize: ScreenAdapter.fontSize(36),color: Colors.black87))
          )
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.height(20)),
        children: [
          Obx(()=> controller.historyList.isNotEmpty ?  Padding(
              padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('搜索历史',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(42)
                  )),
                  // const Icon(Icons.delete_forever_rounded)
                  IconButton(onPressed: (){
                    Get.bottomSheet(
                      Container(
                        padding: EdgeInsets.all(ScreenAdapter.width(20)),
                        color: Colors.white,
                        width: ScreenAdapter.width(1080),
                        height: ScreenAdapter.height(360),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("您确定要清空历史记录吗？",style: TextStyle(fontSize: ScreenAdapter.fontSize(48)))
                              ],
                            ),
                            SizedBox(height: ScreenAdapter.height(40)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: ScreenAdapter.width(480),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(209, 212, 209, 209)),
                                      foregroundColor: MaterialStateProperty.all(Colors.white)
                                    ),
                                    onPressed: (){
                                      Get.back();
                                  }, child: const Text('取消')),
                                ),
                                SizedBox(height: ScreenAdapter.width(40)),
                                SizedBox(
                                  width: ScreenAdapter.width(480),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const  Color.fromARGB(209, 212, 209, 209)),
                                      foregroundColor: MaterialStateProperty.all(Colors.red)
                                    ),
                                    onPressed: (){
                                      controller.clearHistoryData();
                                      Get.back();
                                    }, 
                                    child: const Text('确定')),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  }, icon: const Icon(Icons.delete_forever_rounded)
                 )
                ],
              ),
            ): const Text(''),
          ),
          Obx(()=> Wrap(
              children: controller.historyList.map((value) =>  GestureDetector(
                onLongPress: () {
                  Get.defaultDialog(
                    title: "提示信息!",
                    middleText: "您确定要删除吗？",
                    confirm: ElevatedButton(
                      style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(const  Color.fromARGB(209, 212, 209, 209)),
                         foregroundColor: MaterialStateProperty.all(Colors.red)
                      ),
                      onPressed: (){
                        controller.removeHistoryData(value);
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
                child: Container(
                    padding: EdgeInsets.fromLTRB(ScreenAdapter.width(32), ScreenAdapter.width(16), ScreenAdapter.width(32), ScreenAdapter.width(16)),
                    margin: EdgeInsets.all(ScreenAdapter.height(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('$value'),
                  ),
              )
               ).toList()
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('猜你想搜',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenAdapter.fontSize(42)
                )),
                const Icon(Icons.refresh)
              ],
            ),
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(ScreenAdapter.width(32), ScreenAdapter.width(16), ScreenAdapter.width(32), ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Text('手机'),
              )
            ],
          ),

          const SizedBox(height: 20),

          // 小米热搜
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(138),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/hot_search.png')
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: GridView.builder(
                    shrinkWrap: true, // 收缩  在 ListView里面使用 GridView 会因为没有高度的问题报错
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenAdapter.width(40),
                      mainAxisSpacing: ScreenAdapter.height(20),
                      childAspectRatio: 3/1
                    ), 
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          Container(
                            width: ScreenAdapter.width(120),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Image.network('https://www.itying.com/images/shouji.png',fit: BoxFit.cover),
                          ),
                          Expanded(child: Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            alignment: Alignment.topLeft,
                            child: const Text('123'),
                          ))
                        ],
                      );
                    })
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 头部的搜索框
  Container SearchHeaderWidget() {
    return Container(
        width: ScreenAdapter.width(840),
        height: ScreenAdapter.height(96),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(246, 246, 246, 1)),
        child: TextField(
          autofocus: true,
          style: TextStyle(
            fontSize: ScreenAdapter.fontSize(36)
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none
            )
          ),
          onChanged: (value) {
            controller.keywords = value;
          },
          // 监听键盘的回车事件
          onSubmitted: (value) {
            // Get.toNamed('/product-list',arguments: {
            //     "keywords": value
            // });
            SearchServices.setHistoryData(value);
            // 替换路由
            Get.offAndToNamed('/product-list',arguments: {
                "keywords": value
            });
          },
        ),
      );
  }
}
