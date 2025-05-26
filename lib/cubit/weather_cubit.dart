import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/apis/api_manager.dart';
import 'package:weather_app/cubit/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  WeatherModel? weatherModel;
  String? formattedTime;

  getWeather(String city) async {
    try {
      emit(WeatherLoadingState());
      weatherModel = await ApiManager(Dio()).getWeatherData(city);
      setTime();
      emit(WeatherSuccessState());
    } catch (e) {
      emit(WeatherFailureState());
    }
  }

  setTime() {
    formattedTime = DateFormat('h:mm a').format(DateTime.now());
  }
}
