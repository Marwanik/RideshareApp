// lib/model/getBicyclesModel.dart

class GetBicycleModel {
  final int id;
  final String type;
  final int size;
  final String photoPath;
  final String note;
  final ModelPrice modelPrice;

  GetBicycleModel({
    required this.id,
    required this.type,
    required this.size,
    required this.photoPath,
    required this.note,
    required this.modelPrice,
  });

  factory GetBicycleModel.fromJson(Map<String, dynamic> json) {
    return GetBicycleModel(
      id: json['id'],
      type: json['type'],
      size: json['size'],
      photoPath: json['photoPath'],
      note: json['note'],
      modelPrice: ModelPrice.fromJson(json['model_price']),
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
      price: json['price'].toDouble(),
      model: json['model'],
    );
  }
}
