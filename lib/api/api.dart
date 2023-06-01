import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseUrl = "http://192.168.1.7:5000";
const Map<String, dynamic> defaultHeader = {"Content-Type": "application/json"};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = defaultHeader;
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));
  }

  Dio get getRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    dynamic data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data['success'],
      data: data['data'],
      message: data['message'] ?? "",
    );
  }
}
