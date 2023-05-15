class CategoryModel {
  String sId;
  String name;

  CategoryModel({required this.sId, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(sId: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
