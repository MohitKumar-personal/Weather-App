import 'package:flutter/material.dart';
import 'package:buttons_flutter/buttons_flutter.dart';
import 'package:weather/weather_screen.dart';
import 'package:weather/weathermodel.dart';

import 'api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var city_name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/weather02.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              controller: city_name,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontFamily: 'flutterfonts',
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Enter Your City Name'.toUpperCase(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: Icon(Icons.location_on_sharp, color: Colors.white),
                              ),
                            ),
                          ),
                          BorderButton(
                            padding: EdgeInsets.only(top:10, left: 30, right: 30, bottom: 10),
                            borderRadius: 10,
                            borderColor: Colors.white,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:
                                    (context) => WeatherScreen(cityname: city_name.text),
                                ),
                              );
                              // var cityname = city_name.text.toString();
                              // _getWeatherData(cityname);

                            },
                            child: const Text("SEARCH",
                                style: TextStyle(
                                fontFamily: 'flutterfonts',
                                color: Colors.white,
                                ),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      )
                    ],
                  ),
            )
            )
          ],
        ),
      ),
    );
  }
}

// _getWeatherData(String cityname) async{
//   ApiResponse response = await WeatherApi().getCurrentWeather(cityname);
//   print(response.toJson());
// }