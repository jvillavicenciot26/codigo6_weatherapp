import 'dart:convert';

import 'package:codigo6_weatherapp/models/location_weather_model.dart';
import 'package:codigo6_weatherapp/services/api_service.dart';
import 'package:codigo6_weatherapp/widgets/item_forecast_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationWeatherModel? locationWeatherModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    ApiService apiService = ApiService();
    locationWeatherModel = await apiService.getWeatherData();
    if (locationWeatherModel != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff282B30),
      appBar: AppBar(
        title: const Text("WeatherApp"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              "https://cdn4.iconfinder.com/data/icons/weather-129/64/weather-2-512.png",
              color: Colors.white,
              height: 74.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "27",
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  " °C",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Trujillo, Perú",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              cursorColor: Color(0xffF66C2D),
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                hintText: "Ingresa una ciudad ...",
                hintStyle: TextStyle(
                  color: Colors.white38,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Buscar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF66C2D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                  ItemForeCastWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
