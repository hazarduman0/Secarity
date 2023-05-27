class Distance {
  int? distanceValue;

  Distance({this.distanceValue});

  Distance.fromJson(Map<String, dynamic> json) {
    distanceValue = json['distanceValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distanceValue'] = distanceValue;
    return data;
  }
}
