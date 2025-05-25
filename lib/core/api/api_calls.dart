import 'package:dio/dio.dart';
import 'package:todo_dart/constansts/api_constants.dart';
import 'package:todo_dart/core/api/dio_exception.dart';

class ApiCalls {
  // This class contains all the API calls for the app
  //*get method
  getData({required String endpoint})async{
    // This method is used to get data from the API
    // Use the http package to make a GET request to the API
    // Use the json package to parse the response
    // Return the parsed data
    try{
    final Dio dio =Dio(
      BaseOptions(
        baseUrl:ApiConstants.apiBaseUrl,
      ),
    );
    final response = await dio.get(endpoint);
    return response.data;
  }on DioException catch(e){
    throw CustomDioException.fromDioError(e);
    }
}
sendData({required String endpoint, required Map<String, dynamic> data})async{
  // This method is used to send data to the API
  // Use the http package to make a POST request to the API
  // Use the json package to parse the response
  // Return the parsed data
  try{
    final Dio dio =Dio(
      BaseOptions(
        baseUrl:ApiConstants.apiBaseUrl,
      ),
    );
    final response = await dio.post(endpoint, data: data);
    return response.data;
  }on DioException catch(e){
    throw CustomDioException.fromDioError(e);
  }
}

  deleteData({required String endpoint}) async{
    // This method is used to delete data from the API
    // Use the json package to parse the response
    // Return the parsed data
    try{
      final Dio dio =Dio(
        BaseOptions(
          baseUrl:ApiConstants.apiBaseUrl,
        ),
      );
      final response = await dio.delete(endpoint);
      return response.data;
    }on DioException catch(e){
      throw CustomDioException.fromDioError(e);
    }
  }
}