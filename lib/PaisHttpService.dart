import 'package:countrylist/Pais.dart';
import 'package:countrylist/PaisDetail.dart';
import 'package:http/http.dart' as http;

class PaisHttpService{
  // Base API url
  final String _url = "https://wft-geo-db.p.rapidapi.com/";
  // Base headers for Response url
  final String _headerKey = "0607498fa5msheda8777115e95b2p14f71cjsnca7630e70bd8";
  final String _headerHost = "wft-geo-db.p.rapidapi.com";

  Future<List<Pais>> getPaises(int n) async {
    var uri = Uri.parse(_url + "v1/geo/countries?offset=" + (n * 5).toString());
    var response = await http.get(uri,
        headers: {
          "X-RapidAPI-Key": _headerKey,
          "X-RapidAPI-Host" : _headerHost
        });

    if(response.statusCode == 200){
      //print(response.body);
      return paisFromJson(response.body);
    }else{
      throw("");
    }
  }

  Future<PaisDetail> getPaisDetail(String codePais) async {
    var uri = Uri.parse(_url + "v1/geo/countries/" + codePais);
    var response = await http.get(uri,
        headers: {
          "X-RapidAPI-Key": _headerKey,
          "X-RapidAPI-Host" : _headerHost
        });

    if(response.statusCode == 200){
      //print(response.body);
      return paisDetailFromJson(response.body);
    }else{
      throw(response.statusCode);
    }
  }


}