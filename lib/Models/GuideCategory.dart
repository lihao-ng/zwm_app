class GuideCategory {
  final String image, title, value;

  GuideCategory({
    this.image,
    this.value,
    this.title,
  });
}

List<GuideCategory> guideCategories = [
  GuideCategory(
    title: "Plastic",
    value: "Plastic",
    image: "assets/images/categories/bulk.jpg",
  ),
  GuideCategory(
    title: "Metal",
    value: "Metal",
    image: "assets/images/categories/bookstore.jpg",
  ),
  GuideCategory(
    title: "Glass",
    value: "Glass",
    image: "assets/images/categories/composting.jpg",
  ),
  GuideCategory(
    title: "Paper",
    value: "Paper",
    image: "assets/images/categories/household.jpg",
  ),
  GuideCategory(
    title: "Electronics",
    value: "Electronics",
    image: "assets/images/categories/furry.jpg",
  ),
  GuideCategory(
    title: "Fabric",
    value: "Fabric",
    image: "assets/images/categories/repair_services.jpg",
  ),
  GuideCategory(
    title: "Households",
    value: "Households",
    image: "assets/images/categories/repair_services.jpg",
  ),
  GuideCategory(
    title: "Hazardous",
    value: "Hazardous",
    image: "assets/images/categories/personal_product.jpg",
  ),
];
