import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';

String _gasLink = "https://crmmobile.bangchak.co.th/webservice/oil_price.aspx";
String _weatherLink = "https://data.tmd.go.th/api/Weather3Hours/V2/?uid=api&ukey=api12345";

Xml2Json _x2j = Xml2Json();

Future<Map<String, dynamic>> getWeatherData () async {
  try {
    Response res = await get(Uri.parse(_weatherLink)).timeout(Duration(seconds: 5));
    _x2j.parse(res.body);
    String json = _x2j.toParker();
    return jsonDecode(json);
  } on TimeoutException {
    return {"error": "Timeout"};
  } on Socket {
    return {"error": "Socket"};
  } catch (e) {
    return {"error": e};
  }
}

Future<Map<String, dynamic>> getGasData () async {
  try {
    Response res = await get(Uri.parse(_gasLink)).timeout(Duration(seconds: 5));
    _x2j.parse(res.body);
    String json = _x2j.toParker();
    return jsonDecode(json);
  } on TimeoutException {
    return {"error": "Timeout"};
  } on Socket {
    return {"error": "Timeout"};
  } catch (e) {
    return {"error": e};
  }
}