import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response<dynamic>> downloadFile(
      {required String urlPath,
      required String savePath,
      void Function(int, int)? onrecive,
      CancelToken? cancelToken}) async {
    return await dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onrecive,
      cancelToken: cancelToken,
    );
  }
}
