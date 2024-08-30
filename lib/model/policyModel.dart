class PolicyModel {
  final int id;
  final String title;
  final String description;

  PolicyModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
