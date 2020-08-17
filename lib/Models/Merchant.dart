class Merchant {
  final String image, name, description, contact, category, address;
  final int id;
  final double lat, long;

  Merchant({
    this.id,
    this.image,
    this.name,
    this.category,
    this.description,
    this.contact,
    this.address,
    this.lat,
    this.long,
  });
}

List<Merchant> merchants = [
  Merchant(
    id: 1,
    name: "Nude Zero Waste Store",
    contact: '012-2321232',
    address:
        'No 12, SS 22/3, Taman Megah asdjlskj asldkj aldkajs laksdjals kjdaskja',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder_shop.jpg",
    long: 101.5334716,
    lat: 2.9998159,
  ),
  Merchant(
    id: 2,
    name: "Belt Bag",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    image: "assets/images/placeholder2.jpg",
    long: 101.6114682,
    lat: 3.1136743,
  ),
  Merchant(
    id: 3,
    name: "Hang Top",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Household Products',
    description: dummyText,
    image: "assets/images/placeholder_shop.jpg",
    long: 101.6808868,
    lat: 3.0841094,
  ),
  Merchant(
    id: 4,
    name: "Old Fashion",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Trift Shops',
    description: dummyText,
    image: "assets/images/placeholder_shop.jpg",
    long: 101.6446361,
    lat: 3.2004111,
  ),
  Merchant(
    id: 5,
    name: "Office Code",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Household Products',
    description: dummyText,
    image: "assets/images/home_bg.jpg",
    long: 101.628541,
    lat: 3.2163753,
  ),
  Merchant(
    id: 6,
    name: "Office Code",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Personal Care Products',
    description: dummyText,
    image: "assets/images/placeholder.jpg",
    long: 101.6985495,
    lat: 3.1437188,
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
