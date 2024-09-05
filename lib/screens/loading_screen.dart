import 'package:clima_2/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_2/services/weather.dart';

// const String apiKey = '033e7dbd9f472a2aa9e88c94546ae724';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

void getLocationData(BuildContext context) async {
  WeatherModel weatherModel = WeatherModel();
  Map weatherData = await weatherModel.getLocationWeather();

  if (context.mounted) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      },
    ));
  }
  // print(response);  //output instance of Response cara mengatasinya adalah dengan memanggil body (properties) contoh: response.statuscode
}

// //method untuk men get data dari api
// void getData() async {

// }

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object initstate'); //untuk menginisialisasi
    getLocationData(context);
  }

  @override
  Widget build(BuildContext context) {
    print('object build');
    String myMargin = '15';
    double? myMarginAsADouble;

    try {
      myMarginAsADouble = double.parse(myMargin);
    } catch (e) {
      print(e);
      // myMarginAsADouble = 30;
    }
    return Scaffold(
      // body: Container(
      //   color: Colors.red,
      //   margin: EdgeInsets.all(myMarginAsADouble ?? 30),
      // ),
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
