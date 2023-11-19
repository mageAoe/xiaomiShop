

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import '../controllers/home_controller.dart';
import '../../../services/screenAdaoter.dart';
import '../../../services/fonts.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  // 顶部导航
  Widget _appBar(){
    return Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(() => AppBar( // 重新渲染需要 Obx
              leading: controller.flag.value ? const Text('') : const Icon(XiaoMiFont.xiaomiguishu,color: Colors.red),
              leadingWidth: controller.flag.value ? 20 : ScreenAdapter.width(140),
              title: InkWell(
                onTap: (){
                  Get.toNamed('/search');
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: controller.flag.value ? ScreenAdapter.width(800) : ScreenAdapter.width(620),
                  height: ScreenAdapter.height(96),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(237, 252, 243, 236)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 4, 0), child: Icon(Icons.search, color: Colors.black45)),
                      Text('手机', style: TextStyle(color: Colors.black54,fontSize: ScreenAdapter.fontSize(40),fontWeight: FontWeight.w500)),
                      const Expanded(child: Text('')), // 中间用Expanded控件
                      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child:Icon( XiaoMiFont.saoyisao, color: Colors.black45)),
                    ],
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: controller.flag.value ? Colors.white : Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.qr_code, color: controller.flag.value ? Colors.black87: Colors.white)),
                IconButton(onPressed: (){}, icon: Icon(XiaoMiFont.xiaoxi, color: controller.flag.value ? Colors.black87: Colors.white))
              ],
            ))     
          );
  }
  // 内容区域
  Widget _homePage(){
    return Positioned(
          top: -40,
          left: 0,
          right: 0,
          bottom: 0,
          child: ListView(
            controller: controller.scrollController,
            children: [
              _focus(),
              _banner(),
              _category(),
              _banner2(),
              _bestSelling(),
              bestGoods()
            ],
          )
        );
  }
  // 轮播图
  Widget _focus(){
    return SizedBox(
          width: ScreenAdapter.width(1080),
          height: ScreenAdapter.height(682),
          child: Obx(() => Swiper(
            itemBuilder: (context, index){
              return Image.network(
                HttpsClient.repleaUrl(controller.swiperList[index].pic),
                fit: BoxFit.fill,);
            },
            itemCount: controller.swiperList.length,
            pagination: const SwiperPagination(
              builder: SwiperPagination.rect
            ),
            autoplay: true,
            loop: true,
            // duration: 3000,
            // control: const SwiperControl(),
          )),
        );
  }
  // banner
  Widget _banner(){
    return SizedBox(
          width: ScreenAdapter.width(1080),
          height: ScreenAdapter.height(92),
          child: Image.asset('assets/images/xiaomiBanner.png', fit: BoxFit.cover),
        );
  }
  // banner2
  Widget _banner2(){
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), ScreenAdapter.width(20), ScreenAdapter.width(20), 0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/xiaomiBanner2.png")
            )
          ),
          height: ScreenAdapter.height(420),
      ),
    );
  }
  // 滑动分类
  Widget _category(){
    return Container(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(470),
      color: Colors.white,
      child: Obx(() => Swiper(
        itemBuilder: (context, index){
          return GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: ScreenAdapter.width(20),
              childAspectRatio: 1.2,
              mainAxisSpacing: ScreenAdapter.height(20)
            ), 
            itemBuilder: (context, i){
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.height(140),
                    height: ScreenAdapter.height(140),
                    child: Image.network(HttpsClient.repleaUrl(controller.categoryList[index*10+i].pic),fit: BoxFit.fitHeight),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(4), 0, 0),
                    child: Text("${controller.categoryList[index*10+i].title}", style: TextStyle(fontSize: ScreenAdapter.fontSize(34))),
                  ),
                ],
              );
            }
          );
        },
        itemCount: controller.categoryList.length~/10, // 取整
        pagination: SwiperPagination( // swiper 指示器
          margin: const EdgeInsets.all(0.0),
          builder: SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
            return ConstrainedBox(
              constraints: BoxConstraints.expand(height: ScreenAdapter.height(20)),
              child: Row(
                children: <Widget>[                            
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        // color: Colors.black12,
                        child: const RectSwiperPaginationBuilder(
                              size: Size(40.0, 3.0),
                              activeSize: Size(40.0, 3.0),
                              color: Colors.black12,
                              activeColor: Colors.black54,
                            )
                          .build(context, config),
                      ),
                    ),
                  )
                ],
              ),
            );
        })),
      )),
    );
  }
  // 热销臻选
  Widget _bestSelling(){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30), ScreenAdapter.width(40), ScreenAdapter.width(30), ScreenAdapter.width(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('热销臻选', style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenAdapter.fontSize(46))),
              Text('更多手机 >', style: TextStyle(fontSize: ScreenAdapter.fontSize(36),color: Colors.black54)),
              ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0, ScreenAdapter.width(20), ScreenAdapter.width(20)),
          child: Row(
            children: [
              // 左侧
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(738),
                  child: Obx(() => Swiper(
                    itemBuilder: (context, index){
                      String picUrl = "https://xiaomi.itying.com/${controller.hotList[index]['pic']}";
                      return Image.network(
                        picUrl.replaceAll('\\', '/'),
                        fit: BoxFit.fill,);
                    },
                    itemCount: controller.hotList.length,
                    pagination: const SwiperPagination(
                      builder: SwiperPagination.rect
                    ),
                    autoplay: true,
                    loop: true,
                  )),
                )
              ),
              SizedBox(width: ScreenAdapter.width(20)),
              // 右侧
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(738),
                  // color: Colors.red,
                  child: Obx(() => Column(
                    children: 
                      controller.sellingPlist.asMap().entries.map((entrie) {
                        var value = entrie.value;
                        return Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, entrie.key == 2?0: ScreenAdapter.height(20)),
                            color: const Color.fromRGBO(246,246,246,1),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: ScreenAdapter.height(20)),
                                      Text("${value.title}", style: TextStyle(fontSize: ScreenAdapter.fontSize(38),fontWeight: FontWeight.bold)),
                                      SizedBox(height: ScreenAdapter.height(10)),
                                      Text("${value.subTitle}", style: TextStyle(fontSize: ScreenAdapter.fontSize(28),fontWeight: FontWeight.bold)),
                                      SizedBox(height: ScreenAdapter.height(10)),
                                      Text("￥${value.price}元", style: TextStyle(fontSize: ScreenAdapter.fontSize(34),fontWeight: FontWeight.bold,color: Colors.black54)),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(padding: EdgeInsets.all(ScreenAdapter.height(8)),
                                    child: Image.network(HttpsClient.repleaUrl(value.pic),fit: BoxFit.cover))
                                )
                              ],
                            ),
                          )
                        );
                      }).toList(),
                  )),
                )
              ),
            ],
          ),
        )
      ],
    );
  }
  // 瀑布流商品
  Widget bestGoods(){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30), ScreenAdapter.width(40), ScreenAdapter.width(30), ScreenAdapter.width(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('省心优惠', style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenAdapter.fontSize(46))),
              Text('全部优惠 >', style: TextStyle(fontSize: ScreenAdapter.fontSize(36),color: Colors.black54)),
              ],
          ),
        ),
        Obx(() => Container(
          padding: EdgeInsets.all(ScreenAdapter.width(26)),
          color: const Color.fromRGBO(246,246,246,1),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: ScreenAdapter.width(26),
            crossAxisSpacing: ScreenAdapter.width(26),
            itemCount: controller.bestgPlist.length,
            shrinkWrap: true, // 收缩，让元素宽度自适应
            physics: const NeverScrollableScrollPhysics(), // 禁止左右滑动
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      child: Image.network(HttpsClient.repleaUrl(controller.bestgPlist[index].sPic)),
                    ),
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      width: double.infinity,
                      child: Text('${controller.bestgPlist[index].title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(42))),
                    ),
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      width: double.infinity,
                      child: Text('${controller.bestgPlist[index].subTitle}',style: TextStyle(fontSize: ScreenAdapter.fontSize(32))),
                    ),
                     Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      width: double.infinity,
                      child: Text('￥${controller.bestgPlist[index].price}', style: TextStyle(fontSize: ScreenAdapter.fontSize(32),fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ))
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        _homePage(),
        _appBar(),
        ],
      ),
    );
  }
}



