import 'package:wings/core/mutable/models/branch.model.dart';
import 'package:wings/core/mutable/models/price.model.dart.dart';

import '../../immutable/base/models/model.wings.dart';
import '../helpers/util.helper.dart';
import 'image.model.dart';

class ProductModel implements WingsModel {
  final dynamic id;
  final dynamic productId;
  final dynamic name;
  final dynamic sku;
  dynamic quantity;
  final dynamic unit;
  final dynamic price;
  final dynamic branchId;
  final dynamic total;
  final dynamic creditable;
  final dynamic refundable;
  final dynamic expDate;
  final dynamic min;
  final dynamic max;
  final dynamic description;
  final ImageModel qrCode;
  final List<ImageModel> images;
  final BranchModel company;
  final List<PriceModel> categoryPrices;

  ProductModel({
    this.id,
    this.productId,
    this.name,
    this.sku,
    this.quantity,
    this.price,
    this.total,
    this.unit,
    this.branchId,
    this.creditable,
    this.refundable,
    this.expDate,
    this.min,
    this.max,
    this.description,
    this.qrCode = const ImageModel(),
    this.images = const [],
    this.categoryPrices = const [],
    this.company = const BranchModel(),
  });

  String get quantityUnit => "$quantity $unit";

  ImageModel get image => images.isNotEmpty ? images.first : const ImageModel();

  void set increaseQuantity(int number) {
    quantity = quantity + number;
  }

  void set decreaseQuantity(int number) {
    if (quantity != 1) {
      quantity = quantity - number;
    }
  }

  bool get _total => total != null && total.toString().isNotEmpty;

  get totalPrice => _total ? total : quantity * price;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      quantity: json['quantity'] ?? '',
      unit: json['unit'] ?? '',
      price: json['price'] ?? '',
      total: json['total'],
      creditable: json['creditable'] ?? '',
      refundable: json['refundable'] ?? '',
      description: json['description'] ?? '',
      expDate: json['expDate'] ?? '',
      branchId: json['branchId'] ?? '',
      min: json['miniOrderQuantity'] ?? '',
      max: json['maxOrderQuantity'] ?? '',
      qrCode: ImageModel.fromJson(json['imageQrCode'] ?? {}),
      images: const ImageModel().fromJsonList(json['image'] ?? []),
      categoryPrices:
          const PriceModel().fromJsonList(json['categoryPrices'] ?? []),
      company: BranchModel.fromJson(json['company'] ?? {}),
    );
  }

  @override
  ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel.fromJson(json);
  }

  @override
  List<ProductModel> fromJsonList(List<dynamic> json) {
    List<ProductModel> list = [];

    for (var ele in json) {
      list.add(ProductModel.fromJson(ele));
    }

    return list;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'name': name,
      'sku': sku,
      'price': price,
      'quantity': quantity,
      'unit': unit,
      'total': total,
      'creditable': creditable,
      'refundable': refundable,
      'imageQrCode': qrCode.toJson(),
      'description': description,
      'expDate': expDate,
      'branchId': branchId,
      'maxOrderQuantity': max,
      'miniOrderQuantity': min,
      'image': images.toJson(),
      'categoryPrices': categoryPrices.toJson(),
      'company': company.toJson(),
    };
  }

  Map<String, dynamic> toItemJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
