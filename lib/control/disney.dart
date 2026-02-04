class Disney {
  String? city;
  List? neighborhoods;
  String? id;
  String? name;
  int? lat;
  int? lng;
  List? stores;
  String? storeId;
  String? name1;
  int? lat1;
  int? lng1;
  List? products;
  String? productId;
  String? name2;
  String? category;
  int? price;
  int? quantity;
  String? imageUrl;

  Disney({
    this.city,
    this.neighborhoods,
    this.id,
    this.name,
    this.lat,
    this.lng,
    this.stores,
    this.storeId,
    this.name1,
    this.lat1,
    this.lng1,
    this.products,
    this.productId,
    this.name2,
    this.category,
    this.price,
    this.quantity,
    this.imageUrl,
  });

  factory Disney.fromJson(Map<String, dynamic> json) {
    final neighborhoods = json!["neighborhoods"];

    final store = neighborhoods!["stores"] ;
    final product = store!["products"];

    return Disney(
      city: json["city"] ?? "",
      neighborhoods: json["neighborhoods"] ?? [],
      id: neighborhoods?["id"] ?? "",
      name: neighborhoods?["name"] ?? "",
      lat: neighborhoods?["lat"] ?? 0,
      lng: neighborhoods?["lng"] ?? 0,
      stores: neighborhoods?["stores"] ?? [],
      storeId: store?["store_id"] ?? "",
      name1: store?["name"] ?? "",
      lat1: store?["lat"] ?? 0,
      lng1: store?["lng"] ?? 0,
      products: store?["products"] ?? [],
      productId: product?["product_id"] ?? "",
      name2: product?["name"] ?? "",
      category: product?["category"] ?? "",
      price: product?["price"] ?? 0,
      quantity: product?["quantity"] ?? 0,
      imageUrl: product?["image_url"] ?? "",
    );
  }
}
