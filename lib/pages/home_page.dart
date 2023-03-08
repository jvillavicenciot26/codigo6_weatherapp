import 'dart:convert';

import 'package:codigo6_weatherapp/models/location_weather_model.dart';
import 'package:codigo6_weatherapp/services/api_service.dart';
import 'package:codigo6_weatherapp/widgets/item_forecast_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationWeatherModel? locationWeatherModel;
  LocationWeatherModel? locationWeatherModelTemp;
  final TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData("Lima   ");
    getDataLocation();
  }

  Future<void> getData(String cityName) async {
    ApiService apiService = ApiService();
    isLoading = true;
    setState(() {});
    locationWeatherModel = await apiService.getWeatherData(cityName);
    if (locationWeatherModel == null) {
      locationWeatherModel = locationWeatherModelTemp;
      isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          content: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  "Intenta con otra ciudad.",
                ),
              )
            ],
          ),
        ),
      );
    } else {
      locationWeatherModelTemp = locationWeatherModel;
      _cityController.clear();
      isLoading = false;
      setState(() {});
    }
  }

  getDataLocation() async {
    ApiService apiService = ApiService();
    isLoading = true;
    setState(() {});
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position.latitude);
    print(position.longitude);
    locationWeatherModel = await apiService.getWeatherLocation(
        position.latitude, position.longitude);
    if (locationWeatherModel != null) {
      locationWeatherModelTemp = locationWeatherModel;
      isLoading = false;
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.location_on,
            ),
            onPressed: () {
              getDataLocation();
            },
          ),
        ],
      ),
      body: !isLoading && locationWeatherModel != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
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
                            //"27",
                            locationWeatherModel!.current.tempC.toString(),
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
                            //"Trujillo, Perú",
                            "${locationWeatherModel!.location.name}, ${locationWeatherModel!.location.country}",
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
                      TextFormField(
                        controller: _cityController,
                        validator: ((String? value) {
                          if (value != null && value.isEmpty) {
                            return "El campo es obligatorio";
                          }
                          return null;
                        }),
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
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String cityName = _cityController.text;
                              getData(cityName);
                            }
                          },
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
              ),
            )
          : Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  color: Color(0xffF66C2D),
                  strokeWidth: 2.0,
                ),
              ),
            ),
    );
  }
}
