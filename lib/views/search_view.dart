import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/apis/api_manager.dart';
import 'package:weather_app/models/weather_model.dart';

class SearchView extends StatelessWidget {
  static const String routeName = "search";
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Search City",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onSubmitted: (value) async {
                try {
                  List<Location> locations = await locationFromAddress(value);
                  if (locations.isNotEmpty) {
                    String latitude = locations[0].latitude.toString();
                    String longitude = locations[0].longitude.toString();
                    log(latitude);
                    log(longitude);
                    WeatherModel weatherModel = await ApiManager(Dio())
                        .getWeatherData(longitude, latitude);
                    log(weatherModel.weather?[0].main ?? "");
                  }
                } catch (e) {
                  log('Error occurred: $e');
                }
                log(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
                suffixIcon: const Icon(Icons.search),
                hintText: "Enter city name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
