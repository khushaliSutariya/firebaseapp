class MapModel {
  String? image;
  String? text;
  String? json;

  MapModel({this.image, this.text, this.json,});

  MapModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    text = json['text'];
    json = json['json'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['text'] = text;
    data['json'] = json;
    return data;
  }
}