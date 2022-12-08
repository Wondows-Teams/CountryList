import 'package:countrylist/Pais.dart';
import 'package:countrylist/PaisDetail.dart';
import 'package:http/http.dart' as http;

class PaisHttpService{
  // Base API url
  final String _url = "https://restcountries.com/";

  Future<List<Pais>> getPaises() async {
    var uri = Uri.parse(_url + "v2/all");
    var response = await http.get(uri,
        headers: {
        });
    if(response.statusCode == 200){
      //print(response.body);
      return paisFromJson(response.body);
    }else{
      throw("");
    }
  }

}