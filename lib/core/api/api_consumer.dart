import 'package:dio/dio.dart';

abstract class ApiConsumer {
  //This Function to call API and get Some Data based on url(End Points) and Headers needed in API to get the Specific Data.

  Future<Response> getData({required String url, Map<String, dynamic>? query});

  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
  });

  //This Function That's Used to Update Some Data based on URL(End Points) and Send what's you need to Update as Map.
  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  });

  //This Function That's Used to Update Some Data based on URL(End Points) and Send what's you need to Update as Map.
  Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
  });

  //This Function That's Used to Delete Data based on URL(End Points) and Send what's you need to Update as Map.
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  });

  void cancelRequest();
}
