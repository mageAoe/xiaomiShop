import 'package:dio/dio.dart';


class HttpsClient {
  static String domain = 'https://xiaomi.itying.com/';


  static Dio dio = Dio();

  // 单例
  HttpsClient(){
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 5000);
  }

  Future get(String apiUrl) async {
    try {
      var res = await dio.get(apiUrl);
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }

  static repleaUrl(picUrl){
    String temUrl = domain + picUrl;
    return temUrl.replaceAll("\\", '/');
  }
}