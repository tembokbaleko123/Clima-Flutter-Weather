import 'package:geolocator/geolocator.dart';

class Location {
  double? lattitude;
  double? longtitude;

  //untuk men get lokasi user dan perizinan gps dinyalakan pada perangkat
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.deniedForever) {
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else if (permission == LocationPermission.always) {
        print('Location permissions are always granted.');
      }
      // Future<Position>
      Position
          position = //Akan memiliki nilai (value) setelah kode dibawah atau disamping selesai eksekusi
          await Geolocator.getCurrentPosition(
              //dengan menambahkan await artinya tunggu sampai kode selesai dieksekusi baru masukkan hasil value (nilai) ke variabel tersebut
              desiredAccuracy: LocationAccuracy.low);
      // print(position);

      lattitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
