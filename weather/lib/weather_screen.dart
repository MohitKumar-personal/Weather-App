import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/api.dart';
import 'package:weather/weathermodel.dart';

class WeatherScreen extends StatefulWidget {
  final String cityname;

  WeatherScreen({required this.cityname}); // Constructor to initialize cityname

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  ApiResponse? response;
  bool inProgress = false;
  late var cityname; // Declare without initializing
  String message = "Search for the location to get weather data or refresh"; // Define message here

  @override
  void initState() {
    super.initState();
    cityname = widget.cityname; // Initialize here
    _getWeatherData(cityname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (inProgress)
              CircularProgressIndicator()
            else
              _getWeatherDataWidget(),
          ],
        ),
      )
    );
  }

  Widget _getWeatherDataWidget() {
    if (response==null){
      return Text(message);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.location_on, size: 50,),
              Text(
                response?.location?.name ?? "",
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  fontFamily: "flutterfonts",
                ),
              ),
              Text(
                response?.location?.country ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontFamily: "flutterfonts",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (response?.current?.tempC.toString() ?? "")+ " °c",
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: "flutterfonts",
                  ),
                ),
              ),
              Text(
                (response?.current?.condition?.text.toString() ?? ""),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: "flutterfonts",
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: 200,
              child: Image.network(
                  "https:${response?.current?.condition?.icon}"
                      .replaceAll("64x64", "128x128"),
                scale: 0.7,
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _data_Title_widget("Humidity", (response?.current?.humidity?.toString() ?? "")+"%"),
                    _data_Title_widget("Wind Speed", "${response?.current?.windKph?.toString() ?? ""}km/h"),
                  ],

                )
              ],
            ),
          )

        ],
      );
    }

  }
  Widget _data_Title_widget(String title, String data){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: "flutterfonts",
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: "flutterfonts",
            ),
          )
        ],
      ),
    );
  }
  _getWeatherData(String cityname) async {
    setState(() {
      inProgress = true;
    });
    try {
      response = await WeatherApi().getCurrentWeather(cityname);
      setState(() {
        inProgress = false; // Stop the circular progress bar when data is fetched
      });
    } catch (e) {
      setState(() {
        message = "Failed to get weather"; // Now 'message' is defined
        response = null;
      });
      // Handle the exception, e.g., show an error message
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

}
