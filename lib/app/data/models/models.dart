class MessagingModel {
  MessagingModel({
    required this.title,
    required this.body,
    required this.data,
  });
  factory MessagingModel.fromJson(Map<String, dynamic> json) => MessagingModel(
        title: json["title"],
        body: json["body"],
        data: json["data"],
      );
  String title;
  String body;
  Map<String, dynamic> data;
  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "data": data,
      };
}
