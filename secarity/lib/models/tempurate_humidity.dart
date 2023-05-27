class TempurateHumidity {
  int? temperatureValue = 0;
  int? humidityValue = 0;

  TempurateHumidity({this.temperatureValue, this.humidityValue});

  TempurateHumidity.fromJson(Map<String, dynamic> json) {
    temperatureValue = json['temperatureValue'];
    humidityValue = json['humidityValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temperatureValue'] = temperatureValue;
    data['humidityValue'] = humidityValue;
    return data;
  }
}
