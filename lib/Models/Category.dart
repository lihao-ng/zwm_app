import 'package:flutter/material.dart';

class Category {
  final String image, title;

  Category({
    this.image,
    this.title,
  });
}

List<Category> categories = [
  Category(
    title: "Bulk Food",
    image: "assets/images/categories/bulk.jpg",
  ),
  Category(
    title: "Bookworm's Paradise",
    image: "assets/images/categories/bookstore.jpg",
  ),
  Category(
    title: "Community Compost Sites",
    image: "assets/images/categories/composting.jpg",
  ),
  Category(
    title: "Furry Friend's Corner",
    image: "assets/images/categories/furry.jpg",
  ),
  Category(
    title: "Household Cleaning Product",
    image: "assets/images/categories/household.jpg",
  ),
  Category(
    title: "Personal Care Product",
    image: "assets/images/categories/personal_product.jpg",
  ),
  Category(
    title: "Repair Services",
    image: "assets/images/categories/repair_services.jpg",
  ),
  Category(
    title: "Thrift Shop (Second-hand Shop)",
    image: "assets/images/categories/thrift.jpg",
  ),
  Category(
    title: "Traditional & Wet Market",
    image: "assets/images/categories/wet_markets.jpg",
  ),
  Category(
    title: "Upcycling, Recycling & Waste Disposal",
    image: "assets/images/categories/recycling_centre.jpg",
  )
];
