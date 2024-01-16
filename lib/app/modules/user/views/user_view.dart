import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:xmshop/app/services/screenAdaoter.dart';

import '../controllers/user_controller.dart';

import '../../../services/fonts.dart';

import '../../../widget/logo.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Row(
            children: [
              const Text("会员码"),
              IconButton(onPressed: (){}, icon: const Icon(Icons.qr_code_outlined)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.settings_outlined)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.message_outlined)),
            ],
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.height(20)),
        children: [
          // 用户头像 登录注册
          Obx(()=> controller.isLogin.value? SizedBox(
              child: Row(
                children: [
                  SizedBox(width: ScreenAdapter.width(40)),
                  SizedBox(
                    height: ScreenAdapter.height(150),
                    width: ScreenAdapter.height(150),
                    child: CircleAvatar(
                      radius: ScreenAdapter.width(75),
                      backgroundImage: const AssetImage('assets/images/user.png'),
                    ),
                  ),
                  SizedBox(width: ScreenAdapter.width(40)),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${controller.userInfo.value.username}', style: TextStyle(fontSize: ScreenAdapter.fontSize(46))),
                        SizedBox(height: ScreenAdapter.height(20) ),
                        Text("普通会员", style: TextStyle(fontSize: ScreenAdapter.fontSize(36)))
                      ]
                    ),
                  SizedBox(width: ScreenAdapter.width(40)),
                  Icon(Icons.arrow_forward_ios, size: ScreenAdapter.fontSize(34),color: Colors.black54)
                ],
              ),
            ):SizedBox(
              child: Row(
                children: [
                  SizedBox(width: ScreenAdapter.width(40)),
                  SizedBox(
                    height: ScreenAdapter.height(150),
                    width: ScreenAdapter.height(150),
                    child: CircleAvatar(
                      radius: ScreenAdapter.width(75),
                      backgroundImage: const AssetImage('assets/images/user.png'),
                    ),
                  ),
                  SizedBox(width: ScreenAdapter.width(40)),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/code-login-step-one');
                    },
                    child: Text('登录/注册', style: TextStyle(fontSize: ScreenAdapter.fontSize(46)))
                  ),
                  SizedBox(width: ScreenAdapter.width(40)),
                  Icon(Icons.arrow_forward_ios, size: ScreenAdapter.fontSize(34),color: Colors.black54)
                ],
              ),
            ),
          ),
          Obx(()=>  controller.userInfo.value.gold != null ? Container(
              height: ScreenAdapter.height(160),
              margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
              child: Row(
                children: [
                  UserWalletWidget(
                      topWidget: Text('${controller.userInfo.value.gold}', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '米金',
                  ),
                  UserWalletWidget(
                      topWidget: Text('${controller.userInfo.value.coupon}', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '优惠券',
                  ),
                  UserWalletWidget(
                      topWidget: Text('${controller.userInfo.value.redPacket}', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '红包',
                  ),
                  UserWalletWidget(
                      topWidget: Text('${controller.userInfo.value.quota}', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '最高额度',
                  ),
                  const UserWalletWidget(
                      topWidget: Icon(Icons.wallet_outlined),
                      text: '钱包',
                  )
                ]
              ),
            ):Container(
              height: ScreenAdapter.height(160),
              margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
              child: Row(
                children: [
                  UserWalletWidget(
                      topWidget: Text('—', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '米金',
                  ),
                  UserWalletWidget(
                      topWidget: Text('—', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '优惠券',
                  ),
                  UserWalletWidget(
                      topWidget: Text('—', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '红包',
                  ),
                  UserWalletWidget(
                      topWidget: Text('—', style: TextStyle(fontSize: ScreenAdapter.fontSize(80), fontWeight: FontWeight.bold)),
                      text: '最高额度',
                  ),
                  const UserWalletWidget(
                      topWidget: Icon(Icons.wallet_outlined),
                      text: '钱包',
                  )
                ]
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: ScreenAdapter.height(40)),
            child: Container(
              width: ScreenAdapter.width(1008),
              height: ScreenAdapter.height(300),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/user_ad1.png")
                ),
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
              ),
            ),
          ),
          // 订单
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(40)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(20),bottom: ScreenAdapter.height(20)),
                  height: ScreenAdapter.height(100),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text('收藏'),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: ScreenAdapter.width(2),
                                color: Colors.black12
                              ),
                              right: BorderSide(
                                width: ScreenAdapter.width(2),
                                color: Colors.black12
                              )
                            )
                          ),
                          child: const Text('足迹'),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text('关注'),
                        )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ScreenAdapter.width(20), right: ScreenAdapter.width(20)),
                  child: Divider(
                    height: ScreenAdapter.height(5),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.width(40), bottom: ScreenAdapter.width(40)),
                  height: ScreenAdapter.height(240),
                  child: const Row(
                    children: [
                      UserWalletWidget(
                          topWidget: Icon(Icons.account_balance_wallet),
                          text: '代付款',
                          alignment: MainAxisAlignment.center,
                      ),
                      UserWalletWidget(
                          topWidget: Icon(Icons.car_crash_outlined),
                          text: '待收货',
                          alignment: MainAxisAlignment.center,
                      ),
                      UserWalletWidget(
                          topWidget: Icon(Icons.message_rounded),
                          text: '待评价',
                          alignment: MainAxisAlignment.center,
                      ),
                      UserWalletWidget(
                          topWidget: Icon(Icons.change_circle_outlined),
                          text: '退换/售后',
                          alignment: MainAxisAlignment.center,
                      ),
                      UserWalletWidget(
                          topWidget: Icon(Icons.library_books_rounded),
                          text: '全部订单',
                          alignment: MainAxisAlignment.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // 服务
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(40)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.all(ScreenAdapter.height(20)),
                      child: Text('服务', style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenAdapter.fontSize(44),
                        fontWeight: FontWeight.bold
                      )),
                    ),
                    const Text('更多 >', style: TextStyle(color: Colors.black12))
                  ],
                ),
                GridView.count(
                  shrinkWrap: true, // 收缩
                  physics: const NeverScrollableScrollPhysics(), // 禁止GridView滑动
                  crossAxisCount: 4,
                  childAspectRatio: 1.253,
                  children: const [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.webIcon,
                        color: Colors.blue),
                        Text('一键安装')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.tuihuanhuo,
                        color: Colors.orange),
                        Text('一键退换')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.weixiu,
                        color: Colors.purple),
                        Text('一键维修')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.schedule,
                        color: Colors.orange),
                        Text('服务进度')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.xiaoxi,
                        color: Colors.orange),
                        Text('小米之家')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.kefu,
                        color: Colors.orange),
                        Text('客服中心')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.huishou,
                        color: Colors.green),
                        Text('以旧换新')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(XiaoMiFont.banhalf32,
                        color: Colors.green),
                        Text('手机电池')
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          LoginButton(text: '退出登录',onPressed: () async {
            controller.loginOut();
         }),
        ],
      ),
    );
  }
}

// 用户的 米金  优惠券  红包 最高额度  钱包
class UserWalletWidget extends StatelessWidget {
  final Widget topWidget;
  final String text;
  final MainAxisAlignment alignment;

  const UserWalletWidget({
    super.key,
    required this.topWidget,
    required this.text,
    this.alignment = MainAxisAlignment.spaceBetween
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: alignment,
        children: [
          topWidget,
          Text(text, style: TextStyle(fontSize: ScreenAdapter.fontSize(34), color: Colors.black45))
        ],
      )
    );
  }
}
