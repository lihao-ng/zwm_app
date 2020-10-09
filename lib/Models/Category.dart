class Category {
  final String image, title, value, icon;

  Category({
    this.image,
    this.value,
    this.icon,
    this.title,
  });
}

List<Category> categories = [
  Category(
    title: "Bulk Food",
    value: "Bulk Food",
    icon: "assets/images/categories_icons/bulk.png",
    image: "assets/images/categories/bulk.jpg",
  ),
  Category(
    title: "Bookworm's Paradise",
    value: "Bookworm's Paradise",
    icon: "assets/images/categories_icons/bulk.png",
    image: "assets/images/categories/bookstore.jpg",
  ),
  Category(
    title: "Community Compost Sites",
    value: "Community Compost Sites",
    icon: "assets/images/categories_icons/composting.png",
    image: "assets/images/categories/composting.jpg",
  ),
  Category(
    title: "Furry Friend’s Corner (Pet food and supplies)",
    value: "Furry Friend’s Corner (Pet food and supplies)",
    icon: "assets/images/categories_icons/furry.png",
    image: "assets/images/categories/furry.jpg",
  ),
  Category(
    title: "Household Cleaning Product",
    value: "Household Cleaning Product",
    icon: "assets/images/categories_icons/household.png",
    image: "assets/images/categories/household.jpg",
  ),
  Category(
    title: "Personal Care Product",
    value: "Personal Care Product",
    icon: "assets/images/categories_icons/personal_product.png",
    image: "assets/images/categories/personal_product.jpg",
  ),
  Category(
    title: "Repair Services",
    value: "Repair Services",
    icon: "assets/images/categories_icons/repair_services.png",
    image: "assets/images/categories/repair_services.jpg",
  ),
  Category(
    title: "Thrift Shop (Second-hand Shop)",
    value: "Thrift Shop (Second-hand Shop)",
    icon: "assets/images/categories_icons/thrift.png",
    image: "assets/images/categories/thrift.jpg",
  ),
  Category(
    title: "Traditional & Wet Market",
    value: "Traditional %26 Wet Market",
    icon: "assets/images/categories_icons/wet_markets.png",
    image: "assets/images/categories/wet_markets.jpg",
  ),
  Category(
    title: "Upcycling, Recycling & Waste Disposal",
    value: "Upcycling, Recycling %26 Waste Disposal",
    icon: "assets/images/categories_icons/recycling_centre.png",
    image: "assets/images/categories/recycling_centre.jpg",
  )
];
