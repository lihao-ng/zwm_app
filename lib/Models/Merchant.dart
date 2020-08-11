class Merchant {
  final String image, name, description, contact, category, address;
  final int id;

  Merchant({
    this.id,
    this.image,
    this.name,
    this.category,
    this.description,
    this.contact,
    this.address,
  });
}

List<Merchant> merchants = [
  Merchant(
    id: 1,
    name: "Nude Zero Waste Store",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder_shop.jpg",
  ),
  Merchant(
    id: 2,
    name: "Belt Bag",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder2.jpg",
  ),
  Merchant(
    id: 3,
    name: "Hang Top",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder_shop.jpg",
  ),
  Merchant(
    id: 4,
    name: "Old Fashion",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder_shop.jpg",
  ),
  Merchant(
    id: 5,
    name: "Office Code",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/home_bg.jpg",
  ),
  Merchant(
    id: 6,
    name: "Office Code",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder.jpg",
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
