import './storage.dart';

class UserServices{
  // 获取用户信息
  static Future<List> getUserInfo() async{
    List? userinfo = await Storage.getData('userInfo');
    if(userinfo != null){
      return userinfo;
    }else{
      return [];
    }
  }

  static Future<bool> getUserLoginState() async{
    List? userinfo = await getUserInfo();
    print(userinfo);
    if(userinfo.isNotEmpty && userinfo[0]["username"] != ""){
      return true;
    }else{
      return false;
    }
  }

  // 退出登录
  static loginOut() async{
    Storage.removeData("userInfo");
  }
}