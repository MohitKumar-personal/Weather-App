import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  final String cityname;

  WeatherScreen({required this.cityname}); // Constructor to initialize cityname

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.cityname), // Direct variable usage
      ),
    );
  }
}
