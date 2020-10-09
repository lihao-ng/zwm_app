class GuideCategory {
  final String image, title, value, icon;

  GuideCategory({
    this.image,
    this.value,
    this.icon,
    this.title,
  });
}

List<GuideCategory> guideCategories = [
  GuideCategory(
    title: "Plastic",
    value: "Plastic",
    icon: "assets/images/guide_categories_icons/plastic.png",
    image: "assets/images/guide_categories/plastic.jpg",
  ),
  GuideCategory(
    title: "Metal",
    value: "Metal",
    icon: "assets/images/guide_categories_icons/metal.png",
    image: "assets/images/guide_categories/metal.jpg",
  ),
  GuideCategory(
    title: "Glass",
    value: "Glass",
    icon: "assets/images/guide_categories_icons/glass.png",
    image: "assets/images/guide_categories/glass.jpg",
  ),
  GuideCategory(
    title: "Paper",
    value: "Paper",
    icon: "assets/images/guide_categories_icons/paper.png",
    image: "assets/images/guide_categories/paper.jpg",
  ),
  GuideCategory(
    title: "Electronics",
    value: "Electronics",
    icon: "assets/images/guide_categories_icons/electronics.png",
    image: "assets/images/guide_categories/electronics.jpg",
  ),
  GuideCategory(
    title: "Fabric",
    value: "Fabric",
    icon: "assets/images/guide_categories_icons/fabric.png",
    image: "assets/images/guide_categories/fabric.jpg",
  ),
  GuideCategory(
    title: "Households",
    value: "Households",
    icon: "assets/images/guide_categories_icons/households.png",
    image: "assets/images/guide_categories/households.jpg",
  ),
  GuideCategory(
    title: "Hazardous",
    value: "Hazardous",
    icon: "assets/images/guide_categories_icons/hazardous.png",
    image: "assets/images/guide_categories/hazardous.jpg",
  ),
];
