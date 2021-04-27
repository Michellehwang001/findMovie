class Dates {
  String maximum;
  String minimum;

  Dates({
      this.maximum, 
      this.minimum});

  Dates.fromJson(dynamic json) {
    maximum = json["maximum"];
    minimum = json["minimum"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["maximum"] = maximum;
    map["minimum"] = minimum;
    return map;
  }

}