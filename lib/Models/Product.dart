class Product {
  final String name, category, description, photo;
  final int id;
  final double price;

  Product({
    this.id,
    this.name,
    this.category,
    this.description,
    this.price,
    this.photo,
  });

  Product.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.category = data['category'],
        this.description = data['description'],
        this.price = double.parse(data['price'].toString()),
        this.photo = data['photo'];
}
