class QuestionModel {
  String? sId;
  String uid;
  String cid;
  String question;
  String description;
  String cname;
  List<String> image;
  int likes;
  List<String> userLikes;
  String createdAt;

  QuestionModel({
    this.sId,
    required this.uid,
    required this.cid,
    required this.question,
    required this.description,
    required this.cname,
    required this.image,
    required this.likes,
    required this.userLikes,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      sId: json['_id'],
      uid: json['uid'],
      cid: json['cid'],
      question: json['question'],
      description: json['description'],
      cname: json['cname'],
      image: json['image'].cast<String>(),
      likes: json['likes'],
      userLikes: json['userLikes'].cast<String>(),
      createdAt: json['createdAt'], 
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['uid'] = uid;
    data['cid'] = cid;
    data['question'] = question;
    data['description'] = description;
    data['image'] = image;
    data['likes'] = likes;
    data['userLikes'] = userLikes;
    data['createdAt'] = createdAt;
    return data;
  }
}
