class BicycleModel {
  final int id;
  final ModelPrice modelPrice;
  final int size;
  final String photoPath;
  final String type;
  final String note;
  final List<dynamic> maintenance;

  BicycleModel({
    required this.id,
    required this.modelPrice,
    required this.size,
    required this.photoPath,
    required this.type,
    required this.note,
    required this.maintenance,
  });

  factory BicycleModel.fromJson(Map<String, dynamic> json) {
    return BicycleModel(
      id: json['id'],
      modelPrice: ModelPrice.fromJson(json['model_price']),
      size: json['size'],
      photoPath: json['photoPath'],
      type: json['type'],
      note: json['note'],
      maintenance: json['maintenance'],
    );
  }
}

class ModelPrice {
  final int id;
  final double price;
  final String model;

  ModelPrice({
    required this.id,
    required this.price,
    required this.model,
  });

  factory ModelPrice.fromJson(Map<String, dynamic> json) {
    return ModelPrice(
      id: json['id'],
      price: (json['price'] as num).toDouble(),
      model: json['model'],
    );
  }
}
