import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/Models/Product.dart';

class Good {
  final List<String> categories;
  final List<List<Offer>> offers;
  final List<List<Product>> products;

  Good({
    this.categories,
    this.offers,
    this.products,
  });

  factory Good.fromJson(Map<String, dynamic> data) {
    List<String> categories = List<String>.from(data['categories']);
    List<List<Offer>> offers = List<List<Offer>>.from(data["offers"]
        .map((x) => List<Offer>.from(x.map((x) => Offer.fromJson(x)))));
    List<List<Product>> products = List<List<Product>>.from(data["products"]
        .map((x) => List<Product>.from(x.map((x) => Product.fromJson(x)))));

    return new Good(
      categories: categories,
      offers: offers,
      products: products,
    );
  }
}
