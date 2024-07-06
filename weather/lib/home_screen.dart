import 'package:flutter/material.dart';
import 'package:buttons_flutter/buttons_flutter.dart';
import 'package:weather/weather_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// HomeScreen displays a weather search interface allowing users to enter a city name.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityNameController = TextEditingController();
  String _lastSearchedCity = '';

  @override
  void initState() {
    super.initState();
    _loadLastSearchedCity();
  }

  Future<void> _loadLastSearchedCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastSearchedCity = prefs.getString('lastSearchedCity') ?? '';
      _cityNameController.text = _lastSearchedCity;
    });
  }

  Future<void> _saveLastSearchedCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                _buildBackgroundImage(screenWidth, screenHeight),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(double screenWidth, double screenHeight) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/weather02.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildInputAndSearchButton(screenWidth, screenHeight),
      ),
    );
  }

  Widget _buildInputAndSearchButton(double screenWidth, double screenHeight) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCityNameTextField(screenWidth),
          _buildSearchButton(screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.1),
        ],
      ),
    );
  }

  Widget _buildCityNameTextField(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: TextField(
        controller: _cityNameController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
        decoration: InputDecoration(
          hintText: 'Enter Your City Name'.toUpperCase(),
          hintStyle: const TextStyle(color: Colors.white),
          border: _inputBorder(),
          focusedBorder: _inputBorder(color: Colors.black),
          enabledBorder: _inputBorder(),
          prefixIcon: const Icon(Icons.location_on, color: Colors.white),
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder({Color color = Colors.white}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildSearchButton(double screenWidth, double screenHeight) {
    return BorderButton(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.08),
      borderRadius: 10,
      borderColor: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
      onPressed: () => _navigateToWeatherScreen(context),
      child: Text("SEARCH", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04)),
    );
  }

  void _navigateToWeatherScreen(BuildContext context) {
    if (_cityNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name'))
      );
    } else {
      _saveLastSearchedCity(_cityNameController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherScreen(cityname: _cityNameController.text),
        ),
      );
    }
  }
}
