import 'package:http/http.dart';
import 'dart:convert';


class WeatherSevices {
  Future <void> getWeatherData() async{
    Response response = await get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=delhi&appid=5d70bc60229315ee65eff569b57f6d8b"));
    var data = jsonDecode(response.body.toString());
    print(data);

}

  
}
