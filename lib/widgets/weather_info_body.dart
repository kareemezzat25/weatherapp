import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<WeatherCubit>(context);
    String weatherCondition = bloc.weatherModel?.weather?[0].main ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bloc.weatherModel?.name ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Text(
            'updated at ${bloc.formattedTime ?? 0}',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getImageWeather(weatherCondition) != weatherCondition
                  ? Image.asset(
                      getImageWeather(weatherCondition),
                    )
                  : Text(
                      weatherCondition,
                      style: const TextStyle(fontSize: 28, color: Colors.blue),
                    ),
              Text(
                "${bloc.weatherModel?.main?.temp ?? 0} ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Maxtemp: ${bloc.weatherModel?.main?.tempMax ?? 0}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Mintemp: ${bloc.weatherModel?.main?.tempMin ?? 0}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          if (weatherCondition != getImageWeather(weatherCondition)) ...[
            Text(
              bloc.weatherModel?.weather?[0].main ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ]
        ],
      ),
    );
  }

  String getImageWeather(String condition) {
    switch (condition) {
      case "Thunderstorm":
        return "assets/images/thunderstorm.png";
      case "Rain":
        return "assets/images/rainy.png";
      case "Snow":
        return "assets/images/snow.png";
      case "Clear":
        return "assets/images/clear.png";
      case "Clouds":
        return "assets/images/cloudy.png";
      default:
        return condition;
    }
  }
}
