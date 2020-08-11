import 'package:flutter/material.dart';

class Coupon {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  Coupon({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
  });
}

List<Coupon> coupons = [
  Coupon(
      id: 1,
      title: "Office Code as dasd asdas asdasdsa",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/placeholder2.jpg",
      color: Color(0xFF3D82AE)),
  Coupon(
      id: 2,
      title: "Belt Bag",
      price: 234,
      size: 8,
      description: dummyText,
      image: "assets/images/placeholder2.jpg",
      color: Color(0xFFD3A984)),
  Coupon(
      id: 3,
      title: "Hang Top",
      price: 234,
      size: 10,
      description: dummyText,
      image: "assets/images/placeholder2.jpg",
      color: Color(0xFF989493)),
  Coupon(
      id: 4,
      title: "Old Fashion",
      price: 234,
      size: 11,
      description: dummyText,
      image: "assets/images/placeholder2.jpg",
      color: Color(0xFFE6B398)),
  Coupon(
      id: 5,
      title: "Office Code",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/placeholder2.jpg",
      color: Color(0xFFFB7883)),
  Coupon(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/placeholder2.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
