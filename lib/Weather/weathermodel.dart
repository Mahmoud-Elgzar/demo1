class ApiResponse {
  Location? location;
  Current? current;
  Forecast? forecast; // Add this for 5-day forecast

  ApiResponse({this.location, this.current, this.forecast});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current = json['current'] != null
        ? Current.fromJson(json['current'])
        : null;
    forecast = json['forecast'] != null
        ? Forecast.fromJson(json['forecast'])
        : null; // Parse forecast
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (forecast != null) {
      data['forecast'] = forecast!.toJson(); // Add forecast to the response
    }
    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  // ignore: non_constant_identifier_names
  String? tz_id;
  String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    // ignore: non_constant_identifier_names
    this.tz_id,
    this.localtime,
  });

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat']?.toDouble();
    lon = json['lon']?.toDouble();
    tz_id = json['tz_id'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['tz_id'] = tz_id;
    data['localtime'] = localtime;
    return data;
  }
}

class Current {
  double? tempC;
  double? tempF;
  Condition? condition;
  double? windKph;
  double? windMph;
  int? humidity;
  double? precipMm;
  double? precipIn;
  double? uv;

  Current({
    this.tempC,
    this.tempF,
    this.condition,
    this.windKph,
    this.windMph,
    this.humidity,
    this.precipMm,
    this.precipIn,
    this.uv,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = (json['temp_c'] != null) ? json['temp_c'].toDouble() : null;
    tempF = (json['temp_f'] != null) ? json['temp_f'].toDouble() : null;
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = (json['wind_kph'] != null) ? json['wind_kph'].toDouble() : null;
    windMph = (json['wind_mph'] != null) ? json['wind_mph'].toDouble() : null;
    humidity = json['humidity'];
    precipMm = (json['precip_mm'] != null) ? json['precip_mm'].toDouble() : null;
    precipIn = (json['precip_in'] != null) ? json['precip_in'].toDouble() : null;
    uv = (json['uv'] != null) ? json['uv'].toDouble() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['wind_mph'] = windMph;
    data['humidity'] = humidity;
    data['precip_mm'] = precipMm;
    data['precip_in'] = precipIn;
    data['uv'] = uv;
    return data;
  }
}

class Forecast {
  List<ForecastDay>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <ForecastDay>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(ForecastDay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forecastday != null) {
      data['forecastday'] = forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ForecastDay {
  String? date;
  Day? day;

  ForecastDay({this.date, this.day});

  ForecastDay.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (day != null) {
      data['day'] = day!.toJson();
    }
    return data;
  }
}

class Day {
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? maxwindKph;
  double? totalprecipMm;
  Condition? condition;

  Day({
    this.maxtempC,
    this.mintempC,
    this.avgtempC,
    this.maxwindKph,
    this.totalprecipMm,
    this.condition,
  });

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = (json['maxtemp_c'] != null) ? json['maxtemp_c'].toDouble() : null;
    mintempC = (json['mintemp_c'] != null) ? json['mintemp_c'].toDouble() : null;
    avgtempC = (json['avgtemp_c'] != null) ? json['avgtemp_c'].toDouble() : null;
    maxwindKph = (json['maxwind_kph'] != null) ? json['maxwind_kph'].toDouble() : null;
    totalprecipMm = (json['totalprecip_mm'] != null) ? json['totalprecip_mm'].toDouble() : null;
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxtemp_c'] = maxtempC;
    data['mintemp_c'] = mintempC;
    data['avgtemp_c'] = avgtempC;
    data['maxwind_kph'] = maxwindKph;
    data['totalprecip_mm'] = totalprecipMm;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}




/*class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['localtime'] = localtime;
    return data;
  }
}

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? precipMm;
  int? humidity;
  double? uv;

  Current(
      {this.tempC,
      this.isDay,
      this.condition,
      this.windKph,
      this.precipMm,
      this.humidity,
      this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp_c'] = tempC;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['precip_mm'] = precipMm;
    data['humidity'] = humidity;
    data['uv'] = uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}*/
