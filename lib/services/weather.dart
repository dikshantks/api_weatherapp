import 'package:api_weatherapp/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const apikey = "697e117493874590d91553f536fe1490";
const openweatherURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = "$openweatherURL?q=$cityName&appid=$apikey&units=metric";

    NetworkHelper networkHelper = NetworkHelper(url);

    var citydata = await networkHelper.getdata();

    return citydata;
  }

  Future<dynamic> getLocationWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      timeLimit: Duration(seconds: 2),
    );

    NetworkHelper networkHelper = NetworkHelper(
        '$openweatherURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apikey&units=metric');

    var weatherdata = await networkHelper.getdata();

    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
