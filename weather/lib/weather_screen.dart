import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/api.dart';
import 'package:weather/weathermodel.dart';

/// WeatherScreen displays weather information for a specified city.
class WeatherScreen extends StatefulWidget {
  final String cityname;

  const WeatherScreen({required this.cityname, super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ApiResponse? response;
  bool inProgress = false;
  String message = "Search for the location to get weather data or refresh";

  @override
  void initState() {
    super.initState();
    _getWeatherData(widget.cityname);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fabSize = screenWidth * 0.15;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (inProgress)
                const CircularProgressIndicator()
              else
                _getWeatherDataWidget(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _getWeatherData(widget.cityname),
          child: Icon(Icons.refresh, size: fabSize * 0.4),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fabSize / 2)
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _getWeatherDataWidget() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return response == null
        ? Text(message, style: TextStyle(fontSize: screenWidth * 0.05))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _locationRow(screenWidth),
              const SizedBox(height: 60),
              _weatherIcon(screenHeight),
              const SizedBox(height: 30),
              _temperatureRow(screenWidth),
              const SizedBox(height: 30),
              _weatherDetailsCard(screenWidth)
            ],
          );
  }

  Row _locationRow(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(Icons.location_on, size: screenWidth * 0.1),
        Text(
          response?.location?.name ?? "",
          style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.w300),
        ),
        Text(
          response?.location?.country ?? "",
          style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Row _temperatureRow(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Text(
            "${response?.current?.tempC ?? ""} °C",
            style: TextStyle(fontSize: screenWidth * 0.12, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          response?.current?.condition?.text ?? "",
          style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Center _weatherIcon(double screenHeight) {
    return Center(
      child: SizedBox(
        height: screenHeight * 0.25,
        child: Image.network(
          "https:${response?.current?.condition?.icon}".replaceAll("64x64", "128x128"),
          scale: 0.7,
        ),
      ),
    );
  }

  Card _weatherDetailsCard(double screenWidth) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _dataTitleWidget("Humidity", "${response?.current?.humidity ?? ""}%", screenWidth),
          _dataTitleWidget("Wind Speed", "${response?.current?.windKph ?? ""} km/h", screenWidth),
        ],
      ),
    );
  }

  Widget _dataTitleWidget(String title, String data, double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          Text(data, style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black87, fontWeight: FontWeight.w600)),
          Text(title, style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black87, fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  _getWeatherData(String cityname) async {
    setState(() => inProgress = true);
    try {
      response = await WeatherApi().getCurrentWeather(cityname);
    } catch (e) {
      setState(() {
        message = "Failed to get weather";
        response = null;
      });
    } finally {
      setState(() => inProgress = false);
    }
  }
}
