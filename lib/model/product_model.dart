class ProductModel {
  ProductModel({
    required this.success,
    required this.data,
    required this.msg,
  });

  final bool success;
  final Data? data;
  final String msg;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      success: json["success"] ?? false,
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      msg: json["msg"] ?? "",
    );
  }
}

class Data {
  Data({
    required this.title,
    required this.status,
    required this.products,
    required this.pagination,
    required this.categories,
  });

  final String title;
  final String status;
  final List<Product> products;
  final Pagination? pagination;
  final List<Category> categories;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json["title"] ?? "",
      status: json["status"] ?? "",
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x))),
    );
  }
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.isSelected,
  });

  final String id;
  final String title;
  final String image;
  final bool isSelected;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      image: json["image"] ?? "",
      isSelected: json["isSelected"] ?? false,
    );
  }
}

class Pagination {
  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json["currentPage"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
      totalItems: json["totalItems"] ?? 0,
      itemsPerPage: json["itemsPerPage"] ?? 0,
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.discountPrice,
    required this.title,
    required this.quantity,
    required this.maxQuantity,
    required this.image,
    required this.status,
    required this.statusText,
    required this.discounts,
    required this.type,
  });

  final String id;
  final int price;
  final int discountPrice;
  final String title;
  final int quantity;
  final int maxQuantity;
  final List<Image> image;
  final bool status;
  final String statusText;
  final List<dynamic> discounts;
  final String type;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"] ?? "",
      price: json["price"] ?? 0,
      discountPrice: json["discountPrice"] ?? 0,
      title: json["title"] ?? "",
      quantity: json["quantity"] ?? 0,
      maxQuantity: json["maxQuantity"] ?? 0,
      image: json["image"] == null
          ? []
          : List<Image>.from(json["image"]!.map((x) => Image.fromJson(x))),
      status: json["status"] ?? false,
      statusText: json["statusText"] ?? "",
      discounts: json["discounts"] == null
          ? []
          : List<dynamic>.from(json["discounts"]!.map((x) => x)),
      type: json["type"] ?? "",
    );
  }
}

class Image {
  Image({
    required this.url,
  });

  final String url;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json["url"] ?? "",
    );
  }
}
