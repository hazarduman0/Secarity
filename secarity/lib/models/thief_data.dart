class ThiefData {
  int? id;
  int? temperatureValue;
  int? humidityValue;
  int? distanceValue;
  bool? motionValue;
  bool? vibrationValue;
  String? time;
  String? status;

  ThiefData(
      {this.id,
      this.temperatureValue,
      this.humidityValue,
      this.distanceValue,
      this.motionValue,
      this.vibrationValue,
      this.time,
      this.status});

  ThiefData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    temperatureValue = json['temperatureValue'];
    humidityValue = json['humidityValue'];
    distanceValue = json['distanceValue'];
    motionValue = json['motionValue'];
    vibrationValue = json['vibrationValue'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['temperatureValue'] = temperatureValue;
    data['humidityValue'] = humidityValue;
    data['distanceValue'] = distanceValue;
    data['motionValue'] = motionValue;
    data['vibrationValue'] = vibrationValue;
    data['time'] = time;
    data['status'] = status;
    return data;
  }
}
