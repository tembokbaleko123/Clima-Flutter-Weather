import 'package:http/http.dart'
    as http; //as http akan mengubah semua method didalamnya dan harus dipanggil dengan http seperti pemanggilan properties dalam class
import 'dart:convert'; //untuk mengubah data json ke dart

class NetworkHelper {
  NetworkHelper({required this.url});
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    //tambahkan angka ato huruf didalam string maka akan terjadi kesalahan dalam mengambil data (karena tidak sesuai) maka itu kode error 404

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedDataJson = jsonDecode(data);
      return decodedDataJson;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
