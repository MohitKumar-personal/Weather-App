import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Colors.blueAccent)),
        title: const TextField(
          decoration: InputDecoration.collapsed(
            hintText: 'Search for a city',
          ),
          autofocus: true,
        ),
      ),
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}