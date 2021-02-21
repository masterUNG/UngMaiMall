import 'dart:convert';

class ShowProductModel {
  final String title;
  final String detail;
  final String urlimage;
  ShowProductModel({
    this.title,
    this.detail,
    this.urlimage,
  });

  ShowProductModel copyWith({
    String title,
    String detail,
    String urlimage,
  }) {
    return ShowProductModel(
      title: title ?? this.title,
      detail: detail ?? this.detail,
      urlimage: urlimage ?? this.urlimage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'detail': detail,
      'urlimage': urlimage,
    };
  }

  factory ShowProductModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ShowProductModel(
      title: map['title'],
      detail: map['detail'],
      urlimage: map['urlimage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowProductModel.fromJson(String source) => ShowProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'ShowProductModel(title: $title, detail: $detail, urlimage: $urlimage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ShowProductModel &&
      o.title == title &&
      o.detail == detail &&
      o.urlimage == urlimage;
  }

  @override
  int get hashCode => title.hashCode ^ detail.hashCode ^ urlimage.hashCode;
}
