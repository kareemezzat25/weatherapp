import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class ApiManager {
  final Dio dio;
  ApiManager(this.dio);

  String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  String apiKey = "8e1e354a4e19256775782be521bbe091";

  Future<WeatherModel> getWeatherData(String cityName) async {
    try {
      var response = await dio.get("$baseUrl?q=$cityName&appid=$apiKey");
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      String message =
          e.response?.data["error"]["message"] ?? "SomeThing Went Wrong";
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString);
    }
  }
}
