import 'package:clima_2/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_2/utilities/constants.dart';
import 'package:clima_2/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    this.locationWeather,
    super.key,
  });

  final Map? locationWeather; //ingat json format itu mirip dengan map pada dart

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

String? pesanCuaca;
String? iconCuaca;
int? temp;
int? condition;
String? cityName;
WeatherModel cuaca = WeatherModel();

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.locationWeather); //untuk mengakses isi dari locationWeather (isi dari api)
    updateUI(widget
        .locationWeather); //bisa juga dengan LocationScreen().locationWeather unutk akses isi api (secara auto isinya null)
    print(condition);
  }

  void updateUI(dynamic weatherData) {
    //untuk melihat type data yang digunakan oleh json format, lihat outputnya di chrome dengan cara paste api

    //Tambahkan setstate untuk mengupdate tanpa perlu restart apk
    setState(() {
      if (weatherData == null) {
        temp = 0;
        pesanCuaca = 'ERROR';
        iconCuaca = 'Unable to Get Because Location is Disable';
        cityName = '';
        return;
      }

      //Untuk mengambil data dari api secara spesifik
      double temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];

      iconCuaca = cuaca.getWeatherIcon(condition!);
      pesanCuaca = cuaca.getMessage(temp!);
    });
    // double temperature = weatherData['main']['temp'];
    // temp = temperature.toInt();
    // condition = weatherData['weather'][0]['id'];
    // cityName = weatherData['name'];
    // WeatherModel cuaca = WeatherModel();
    // iconCuaca = cuaca.getWeatherIcon(condition!);
    // pesanCuaca = cuaca.getMessage(temp!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await cuaca
                          .getLocationWeather(); //await digunakan untuk tunggu sampai data dari getlocationweather selesai diproses. kalau tanpa await maka akan null
                      updateUI(weatherData); //update UI
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData = await cuaca.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                      ;
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      // cuaca.getWeatherIcon(condition!).toString(),
                      iconCuaca.toString(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  // cuaca.getMessage(temp!),
                  '$pesanCuaca in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
