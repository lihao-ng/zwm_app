class Merchant {
  final String name,
      description,
      contact,
      category,
      address,
      businessHours,
      link,
      otherInformation,
      photo;
  final int id;
  final double lat, lng;

  Merchant({
    this.id,
    this.name,
    this.category,
    this.description,
    this.contact,
    this.address,
    this.lat,
    this.lng,
    this.businessHours,
    this.link,
    this.otherInformation,
    this.photo,
  });

  Merchant.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.category = data['category'],
        this.description = data['description'],
        this.contact = data['contact'],
        this.address = data['address'],
        this.lat = data['lat'],
        this.lng = data['lng'],
        this.businessHours = data['business_hours'],
        this.link = data['link'],
        this.otherInformation = data['other_information'],
        this.photo = data['photo'];
}

List<Merchant> merchants = [
  Merchant(
    id: 1,
    name: "Nude Zero Waste Store",
    contact: '012-2321232',
    address:
        'No 12, SS 22/3, Taman Megah asdjl skj asldkj aldkajs laksdjals kjdaskja',
    category: 'Bulk Store',
    description: dummyText,
    photo: "assets/images/placeholder_shop.jpg",
    lng: 101.5334716,
    lat: 2.9998159,
  ),
  Merchant(
    id: 2,
    name: "Belt Bag",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Bulk Store',
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
    lng: 101.6114682,
    lat: 3.1136743,
  ),
  Merchant(
    id: 3,
    name: "Hang Top",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Household Products',
    description: dummyText,
    photo: "assets/images/placeholder_shop.jpg",
    lng: 101.6808868,
    lat: 3.0841094,
  ),
  Merchant(
    id: 4,
    name: "Old Fashion",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Trift Shops',
    description: dummyText,
    photo: "assets/images/placeholder_shop.jpg",
    lng: 101.6446361,
    lat: 3.2004111,
  ),
  Merchant(
    id: 5,
    name: "Office Code",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Household Products',
    description: dummyText,
    photo: "assets/images/home_bg.jpg",
    lng: 101.628541,
    lat: 3.2163753,
  ),
  Merchant(
    id: 6,
    name: "Office Code",
    contact: '012-2321232',
    address: 'No 12, SS 22/3, Taman Megah',
    category: 'Personal Care Products',
    description: dummyText,
    photo: "assets/images/placeholder.jpg",
    lng: 101.6985495,
    lat: 3.1437188,
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
